return {
	Play423051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423051001
		arg_1_1.duration_ = 5.3

		local var_1_0 = {
			zh = 5.3,
			ja = 5
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
				arg_1_0:Play423051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I26f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I26f")
				var_4_0.name = "I26f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I26f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I26f

				arg_1_1.bgs_.I26f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I26f" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 == nil then
				arg_1_1.var_.actorSpriteComps1083 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1083 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 2) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1083 = nil
			end

			local var_4_15 = arg_1_1.actors_["1083"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1083 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1083", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_7" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_19 = arg_1_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_19 then
					arg_1_1.var_.alphaOldValue1083 = var_4_19.alpha
					arg_1_1.var_.characterEffect1083 = var_4_19
				end

				arg_1_1.var_.alphaOldValue1083 = 0
			end

			local var_4_20 = 0.5

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_20 then
				if arg_1_1.var_.characterEffect1083 then
					arg_1_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1083, 1, (arg_1_1.time_ - 2) / var_4_20)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_20 and arg_1_1.time_ < 2 + var_4_20 + arg_4_0 and arg_1_1.var_.characterEffect1083 then
				arg_1_1.var_.characterEffect1083.alpha = 1
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
			local var_4_28 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(423051001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 16 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 16)

				if (16 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 16)) > 0 and var_4_28 < var_4_33 then
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

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051001", "story_v_out_423051.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_423051", "423051001", "story_v_out_423051.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_423051", "423051001", "story_v_out_423051.awb")

						arg_1_1:RecordAudio("423051001", var_4_35)
						arg_1_1:RecordAudio("423051001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423051", "423051001", "story_v_out_423051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423051", "423051001", "story_v_out_423051.awb")
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423051003(arg_9_1)
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

			local var_12_2 = arg_9_1.actors_["1083"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1083 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1083", 7)

				for iter_12_4 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_4)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_5 = 0
			local var_12_6 = 1.775

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423051002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 71 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 71)

				if (71 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 71)) > 0 and var_12_6 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_10 and arg_9_1.time_ < var_12_5 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play423051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423051003
		arg_13_1.duration_ = 7.6

		local var_13_0 = {
			zh = 4.666,
			ja = 7.6
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
				arg_13_0:Play423051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(423051003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)

				if (21 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 21)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051003", "story_v_out_423051.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051003", "story_v_out_423051.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_423051", "423051003", "story_v_out_423051.awb")

						arg_13_1:RecordAudio("423051003", var_16_6)
						arg_13_1:RecordAudio("423051003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423051", "423051003", "story_v_out_423051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423051", "423051003", "story_v_out_423051.awb")
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
	Play423051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423051004
		arg_17_1.duration_ = 5.53

		local var_17_0 = {
			zh = 5.5,
			ja = 5.533
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
				arg_17_0:Play423051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1083"]) and arg_17_1.var_.actorSpriteComps1083 == nil then
				arg_17_1.var_.actorSpriteComps1083 = arg_17_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1083"]) then
				if arg_17_1.var_.actorSpriteComps1083 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1083"]) and arg_17_1.var_.actorSpriteComps1083 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1083 = nil
			end

			local var_20_2 = arg_17_1.actors_["1083"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1083 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1083", 3)

				for iter_20_4 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_4)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_20_5 = 0
			local var_20_6 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(423051004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 28 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 28)

				if (28 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 28)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051004", "story_v_out_423051.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051004", "story_v_out_423051.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_423051", "423051004", "story_v_out_423051.awb")

						arg_17_1:RecordAudio("423051004", var_20_12)
						arg_17_1:RecordAudio("423051004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423051", "423051004", "story_v_out_423051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423051", "423051004", "story_v_out_423051.awb")
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
				actorName = "1083",
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
	Play423051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423051005
		arg_21_1.duration_ = 3.37

		local var_21_0 = {
			zh = 3.166,
			ja = 3.366
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
				arg_21_0:Play423051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1083 = arg_21_1.actors_["1083"].transform.localPosition
				arg_21_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1083", 3)

				for iter_24_0 = 0, arg_21_1.actors_["1083"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1083"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_24_2 = 0
			local var_24_3 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(423051005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 13 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 13)

				if (13 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 13)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051005", "story_v_out_423051.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051005", "story_v_out_423051.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_423051", "423051005", "story_v_out_423051.awb")

						arg_21_1:RecordAudio("423051005", var_24_9)
						arg_21_1:RecordAudio("423051005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423051", "423051005", "story_v_out_423051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423051", "423051005", "story_v_out_423051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play423051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1083"]) and arg_25_1.var_.actorSpriteComps1083 == nil then
				arg_25_1.var_.actorSpriteComps1083 = arg_25_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1083"]) then
				if arg_25_1.var_.actorSpriteComps1083 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1083"]) and arg_25_1.var_.actorSpriteComps1083 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1083 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
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

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(423051006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 19 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 19)

				if (19 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 19)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play423051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.625

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(423051007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 25 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 25)

				if (25 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 25)) > 0 and var_32_0 < var_32_3 then
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
	Play423051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423051008
		arg_33_1.duration_ = 6.27

		local var_33_0 = {
			zh = 4.933,
			ja = 6.266
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
				arg_33_0:Play423051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1083"]) and arg_33_1.var_.actorSpriteComps1083 == nil then
				arg_33_1.var_.actorSpriteComps1083 = arg_33_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1083"]) then
				if arg_33_1.var_.actorSpriteComps1083 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1083"]) and arg_33_1.var_.actorSpriteComps1083 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1083 = nil
			end

			local var_36_2 = arg_33_1.actors_["1083"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1083 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1083", 3)

				for iter_36_4 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_4)

					if var_36_3.name == "split_2" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_36_5 = 0
			local var_36_6 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(423051008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)

				if (21 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 21)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051008", "story_v_out_423051.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051008", "story_v_out_423051.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_423051", "423051008", "story_v_out_423051.awb")

						arg_33_1:RecordAudio("423051008", var_36_12)
						arg_33_1:RecordAudio("423051008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423051", "423051008", "story_v_out_423051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423051", "423051008", "story_v_out_423051.awb")
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
				actorName = "1083",
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
	Play423051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423051009
		arg_37_1.duration_ = 4.3

		local var_37_0 = {
			zh = 3.333,
			ja = 4.3
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
				arg_37_0:Play423051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(423051009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 14)

				if (14 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 14)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051009", "story_v_out_423051.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051009", "story_v_out_423051.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_423051", "423051009", "story_v_out_423051.awb")

						arg_37_1:RecordAudio("423051009", var_40_6)
						arg_37_1:RecordAudio("423051009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423051", "423051009", "story_v_out_423051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423051", "423051009", "story_v_out_423051.awb")
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
	Play423051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423051010
		arg_41_1.duration_ = 7.9

		local var_41_0 = {
			zh = 6.133,
			ja = 7.9
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
				arg_41_0:Play423051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = arg_41_1.actors_["1083"].transform.localPosition
				arg_41_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 3)

				for iter_44_0 = 0, arg_41_1.actors_["1083"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1083"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_44_2 = 0
			local var_44_3 = 0.7

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
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

				local var_44_4 = arg_41_1:GetWordFromCfg(423051010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)

				if (28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051010", "story_v_out_423051.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051010", "story_v_out_423051.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_423051", "423051010", "story_v_out_423051.awb")

						arg_41_1:RecordAudio("423051010", var_44_9)
						arg_41_1:RecordAudio("423051010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423051", "423051010", "story_v_out_423051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423051", "423051010", "story_v_out_423051.awb")
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
	Play423051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423051011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play423051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1083"]) and arg_45_1.var_.actorSpriteComps1083 == nil then
				arg_45_1.var_.actorSpriteComps1083 = arg_45_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1083"]) then
				if arg_45_1.var_.actorSpriteComps1083 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1083"]) and arg_45_1.var_.actorSpriteComps1083 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1083 = nil
			end

			local var_48_2 = arg_45_1.actors_["1083"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 7)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_5 = 0
			local var_48_6 = 1.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(423051011).content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 55 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 55)

				if (55 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 55)) > 0 and var_48_6 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_10 and arg_45_1.time_ < var_48_5 + var_48_10 + arg_48_0 then
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
	Play423051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423051012
		arg_49_1.duration_ = 8.6

		local var_49_0 = {
			zh = 5.766,
			ja = 8.6
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
				arg_49_0:Play423051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.65

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(423051012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 26 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 26)

				if (26 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 26)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051012", "story_v_out_423051.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051012", "story_v_out_423051.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_423051", "423051012", "story_v_out_423051.awb")

						arg_49_1:RecordAudio("423051012", var_52_6)
						arg_49_1:RecordAudio("423051012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423051", "423051012", "story_v_out_423051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423051", "423051012", "story_v_out_423051.awb")
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
	Play423051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423051013
		arg_53_1.duration_ = 7.9

		local var_53_0 = {
			zh = 7.9,
			ja = 7.266
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
				arg_53_0:Play423051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1083"]) and arg_53_1.var_.actorSpriteComps1083 == nil then
				arg_53_1.var_.actorSpriteComps1083 = arg_53_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1083"]) then
				if arg_53_1.var_.actorSpriteComps1083 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1083"]) and arg_53_1.var_.actorSpriteComps1083 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1083 = nil
			end

			local var_56_2 = arg_53_1.actors_["1083"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 3)

				for iter_56_4 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_4)

					if var_56_3.name == "split_2" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_56_5 = 0
			local var_56_6 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(423051013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 30 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 30)

				if (30 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 30)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051013", "story_v_out_423051.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051013", "story_v_out_423051.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_423051", "423051013", "story_v_out_423051.awb")

						arg_53_1:RecordAudio("423051013", var_56_12)
						arg_53_1:RecordAudio("423051013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423051", "423051013", "story_v_out_423051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423051", "423051013", "story_v_out_423051.awb")
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
	Play423051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play423051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1083"]) and arg_57_1.var_.actorSpriteComps1083 == nil then
				arg_57_1.var_.actorSpriteComps1083 = arg_57_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1083"]) then
				if arg_57_1.var_.actorSpriteComps1083 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1083"]) and arg_57_1.var_.actorSpriteComps1083 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1083 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_4 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(423051014).content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 32 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 32)

				if (32 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 32)) > 0 and var_60_3 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_7 and arg_57_1.time_ < var_60_2 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423051015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play423051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1083 = arg_61_1.actors_["1083"].transform.localPosition
				arg_61_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1083", 7)

				for iter_64_0 = 0, arg_61_1.actors_["1083"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1083"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_2 = 0
			local var_64_3 = 1.375

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(423051015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 55 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 55)

				if (55 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 55)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play423051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0.166666666666667 < arg_65_1.time_ and arg_65_1.time_ <= 0.166666666666667 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_68_1 = 0
			local var_68_2 = 1.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(423051016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 52 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 52)

				if (52 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 52)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423051017
		arg_69_1.duration_ = 8.17

		local var_69_0 = {
			zh = 5,
			ja = 8.166
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
				arg_69_0:Play423051018(arg_69_1)
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

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
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
			local var_72_6 = 0.575

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

				local var_72_7 = arg_69_1:GetWordFromCfg(423051017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 23 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 23)

				if (23 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 23)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051017", "story_v_out_423051.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051017", "story_v_out_423051.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_423051", "423051017", "story_v_out_423051.awb")

						arg_69_1:RecordAudio("423051017", var_72_12)
						arg_69_1:RecordAudio("423051017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423051", "423051017", "story_v_out_423051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423051", "423051017", "story_v_out_423051.awb")
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
	Play423051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423051018
		arg_73_1.duration_ = 4.8

		local var_73_0 = {
			zh = 2.733,
			ja = 4.8
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
				arg_73_0:Play423051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1083 = arg_73_1.actors_["1083"].transform.localPosition
				arg_73_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1083", 3)

				for iter_76_0 = 0, arg_73_1.actors_["1083"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1083"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_76_2 = 0
			local var_76_3 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(423051018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)

				if (12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051018", "story_v_out_423051.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051018", "story_v_out_423051.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_423051", "423051018", "story_v_out_423051.awb")

						arg_73_1:RecordAudio("423051018", var_76_9)
						arg_73_1:RecordAudio("423051018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_423051", "423051018", "story_v_out_423051.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_423051", "423051018", "story_v_out_423051.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play423051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423051019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play423051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1083"]) and arg_77_1.var_.actorSpriteComps1083 == nil then
				arg_77_1.var_.actorSpriteComps1083 = arg_77_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1083"]) then
				if arg_77_1.var_.actorSpriteComps1083 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1083"]) and arg_77_1.var_.actorSpriteComps1083 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1083 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 0.475

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(423051019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 19 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 19)

				if (19 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 19)) > 0 and var_80_3 < var_80_6 then
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
	Play423051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423051020
		arg_81_1.duration_ = 5.4

		local var_81_0 = {
			zh = 5.1,
			ja = 5.4
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
				arg_81_0:Play423051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1083"]) and arg_81_1.var_.actorSpriteComps1083 == nil then
				arg_81_1.var_.actorSpriteComps1083 = arg_81_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1083"]) then
				if arg_81_1.var_.actorSpriteComps1083 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1083"]) and arg_81_1.var_.actorSpriteComps1083 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1083 = nil
			end

			local var_84_2 = arg_81_1.actors_["1083"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1083 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1083", 3)

				for iter_84_4 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_4)

					if var_84_3.name == "split_2" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_84_5 = 0
			local var_84_6 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(423051020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 18 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 18)

				if (18 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 18)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051020", "story_v_out_423051.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051020", "story_v_out_423051.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_423051", "423051020", "story_v_out_423051.awb")

						arg_81_1:RecordAudio("423051020", var_84_12)
						arg_81_1:RecordAudio("423051020", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_423051", "423051020", "story_v_out_423051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_423051", "423051020", "story_v_out_423051.awb")
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

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play423051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423051021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1083"]) and arg_85_1.var_.actorSpriteComps1083 == nil then
				arg_85_1.var_.actorSpriteComps1083 = arg_85_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1083"]) then
				if arg_85_1.var_.actorSpriteComps1083 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1083"]) and arg_85_1.var_.actorSpriteComps1083 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1083 = nil
			end

			local var_88_2 = 0
			local var_88_3 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_4 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(423051021).content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 22 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_4) / 22)

				if (22 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_4) / 22)) > 0 and var_88_3 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_7 and arg_85_1.time_ < var_88_2 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423051022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1083 = arg_89_1.actors_["1083"].transform.localPosition
				arg_89_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1083", 7)

				for iter_92_0 = 0, arg_89_1.actors_["1083"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["1083"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_2 = 0
			local var_92_3 = 1.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(423051022).content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 59 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 59)

				if (59 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 59)) > 0 and var_92_3 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_7 and arg_89_1.time_ < var_92_2 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play423051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423051023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play423051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_143", "se_story_143_walk04", "")
			end

			local var_96_1 = 0
			local var_96_2 = 1.375

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(423051023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 55 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 55)

				if (55 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 55)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423051024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play423051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.425

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(423051024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 17 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 17)

				if (17 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 17)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play423051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423051025
		arg_101_1.duration_ = 5.87

		local var_101_0 = {
			zh = 4.433,
			ja = 5.866
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
				arg_101_0:Play423051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["10146"] == nil then
				local var_104_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_104_0) then
					local var_104_1 = Object.Instantiate(var_104_0, arg_101_1.canvasGo_.transform)

					var_104_1.transform:SetSiblingIndex(1)

					var_104_1.name = "10146"
					var_104_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_["10146"] = var_104_1

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs((var_104_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_2 = arg_101_1.actors_["10146"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10146 == nil then
				arg_101_1.var_.actorSpriteComps10146 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10146 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_3.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_3.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10146 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10146 = nil
			end

			local var_104_5 = arg_101_1.actors_["10146"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10146 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10146", 3)

				for iter_104_6 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_6)

					if var_104_6.name == "split_6" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(0, -350, -320)
			end

			local var_104_8 = 0
			local var_104_9 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(423051025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)

				if (19 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 19)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051025", "story_v_out_423051.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051025", "story_v_out_423051.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_423051", "423051025", "story_v_out_423051.awb")

						arg_101_1:RecordAudio("423051025", var_104_15)
						arg_101_1:RecordAudio("423051025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423051", "423051025", "story_v_out_423051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423051", "423051025", "story_v_out_423051.awb")
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
				actorName = "10146",
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
	Play423051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423051026
		arg_105_1.duration_ = 5.2

		local var_105_0 = {
			zh = 5.2,
			ja = 5.066
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
				arg_105_0:Play423051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(423051026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 27 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 27)

				if (27 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 27)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051026", "story_v_out_423051.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051026", "story_v_out_423051.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_423051", "423051026", "story_v_out_423051.awb")

						arg_105_1:RecordAudio("423051026", var_108_6)
						arg_105_1:RecordAudio("423051026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423051", "423051026", "story_v_out_423051.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423051", "423051026", "story_v_out_423051.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play423051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423051027
		arg_109_1.duration_ = 6.8

		local var_109_0 = {
			zh = 6.8,
			ja = 6.666
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
				arg_109_0:Play423051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10146 = arg_109_1.actors_["10146"].transform.localPosition
				arg_109_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10146", 3)

				for iter_112_0 = 0, arg_109_1.actors_["10146"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10146"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_6" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_112_2 = 0
			local var_112_3 = 0.775

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(423051027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 31 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 31)

				if (31 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 31)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051027", "story_v_out_423051.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051027", "story_v_out_423051.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_423051", "423051027", "story_v_out_423051.awb")

						arg_109_1:RecordAudio("423051027", var_112_9)
						arg_109_1:RecordAudio("423051027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_423051", "423051027", "story_v_out_423051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_423051", "423051027", "story_v_out_423051.awb")
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

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play423051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423051028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play423051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10146"]) and arg_113_1.var_.actorSpriteComps10146 == nil then
				arg_113_1.var_.actorSpriteComps10146 = arg_113_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10146"]) then
				if arg_113_1.var_.actorSpriteComps10146 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10146"]) and arg_113_1.var_.actorSpriteComps10146 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10146 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 0.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(423051028).content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 20 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 20)

				if (20 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 20)) > 0 and var_116_3 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_7 and arg_113_1.time_ < var_116_2 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play423051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423051029
		arg_117_1.duration_ = 5.23

		local var_117_0 = {
			zh = 4.8,
			ja = 5.233
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
				arg_117_0:Play423051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10146"]) and arg_117_1.var_.actorSpriteComps10146 == nil then
				arg_117_1.var_.actorSpriteComps10146 = arg_117_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10146"]) then
				if arg_117_1.var_.actorSpriteComps10146 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10146"]) and arg_117_1.var_.actorSpriteComps10146 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10146 = nil
			end

			local var_120_2 = arg_117_1.actors_["10146"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10146 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10146", 3)

				for iter_120_4 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_4)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_120_5 = 0
			local var_120_6 = 0.525

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(423051029)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 21 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 21)

				if (21 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 21)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051029", "story_v_out_423051.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051029", "story_v_out_423051.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_423051", "423051029", "story_v_out_423051.awb")

						arg_117_1:RecordAudio("423051029", var_120_12)
						arg_117_1:RecordAudio("423051029", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_423051", "423051029", "story_v_out_423051.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_423051", "423051029", "story_v_out_423051.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play423051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423051030
		arg_121_1.duration_ = 6.5

		local var_121_0 = {
			zh = 4.333,
			ja = 6.5
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
				arg_121_0:Play423051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(423051030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 24 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 24)

				if (24 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 24)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051030", "story_v_out_423051.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051030", "story_v_out_423051.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_423051", "423051030", "story_v_out_423051.awb")

						arg_121_1:RecordAudio("423051030", var_124_6)
						arg_121_1:RecordAudio("423051030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_423051", "423051030", "story_v_out_423051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_423051", "423051030", "story_v_out_423051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play423051031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423051031
		arg_125_1.duration_ = 4.73

		local var_125_0 = {
			zh = 3.9,
			ja = 4.733
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
				arg_125_0:Play423051032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10146 = arg_125_1.actors_["10146"].transform.localPosition
				arg_125_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10146", 3)

				for iter_128_0 = 0, arg_125_1.actors_["10146"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["10146"].transform:GetChild(iter_128_0)

					if var_128_0.name == "" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_128_2 = 0
			local var_128_3 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(423051031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 18 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 18)

				if (18 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 18)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051031", "story_v_out_423051.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051031", "story_v_out_423051.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_423051", "423051031", "story_v_out_423051.awb")

						arg_125_1:RecordAudio("423051031", var_128_9)
						arg_125_1:RecordAudio("423051031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423051", "423051031", "story_v_out_423051.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423051", "423051031", "story_v_out_423051.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play423051032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423051032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play423051033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10146"]) and arg_129_1.var_.actorSpriteComps10146 == nil then
				arg_129_1.var_.actorSpriteComps10146 = arg_129_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10146"]) then
				if arg_129_1.var_.actorSpriteComps10146 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10146"]) and arg_129_1.var_.actorSpriteComps10146 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps10146 = nil
			end

			local var_132_2 = arg_129_1.actors_["10146"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10146 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10146", 7)

				for iter_132_4 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_4)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.749853302258998 < arg_129_1.time_ and arg_129_1.time_ <= 0.749853302258998 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_144", "se_story_144_clap05", "")
			end

			local var_132_6 = 0
			local var_132_7 = 1.975

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(423051032).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 79 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 79)

				if (79 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 79)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play423051033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423051033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play423051034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.3

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(423051033).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 27 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 27)

				if (27 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 27)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423051034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423051034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play423051035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(423051034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 52 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 52)

				if (52 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 52)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play423051035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423051035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play423051036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(423051035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 14)

				if (14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 14)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play423051036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423051036
		arg_145_1.duration_ = 5.5

		local var_145_0 = {
			zh = 5.466,
			ja = 5.5
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
				arg_145_0:Play423051037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.actors_["10148"] == nil then
				local var_148_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_148_0) then
					local var_148_1 = Object.Instantiate(var_148_0, arg_145_1.canvasGo_.transform)

					var_148_1.transform:SetSiblingIndex(1)

					var_148_1.name = "10148"
					var_148_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_145_1.actors_["10148"] = var_148_1

					if arg_145_1.isInRecall_ then
						for iter_148_0, iter_148_1 in ipairs((var_148_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_148_1.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_148_2 = arg_145_1.actors_["10148"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10148 == nil then
				arg_145_1.var_.actorSpriteComps10148 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps10148 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								iter_148_3.color = Color.New(Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_3.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_3.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10148 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_148_5 then
						iter_148_5.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10148 = nil
			end

			local var_148_5 = arg_145_1.actors_["10148"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10148 = var_148_5.localPosition
				var_148_5.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10148", 3)

				for iter_148_6 = 0, var_148_5.childCount - 1 do
					local var_148_6 = var_148_5:GetChild(iter_148_6)

					if var_148_6.name == "split_4" or not string.find(var_148_6.name, "split") then
						var_148_6.gameObject:SetActive(true)
					else
						var_148_6.gameObject:SetActive(false)
					end
				end
			end

			local var_148_7 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				var_148_5.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_145_1.time_ - 0) / var_148_7)
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				var_148_5.localPosition = Vector3.New(0, -350, -270)
			end

			local var_148_8 = 0
			local var_148_9 = 0.575

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(423051036)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 23 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 23)

				if (23 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 23)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051036", "story_v_out_423051.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051036", "story_v_out_423051.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_423051", "423051036", "story_v_out_423051.awb")

						arg_145_1:RecordAudio("423051036", var_148_15)
						arg_145_1:RecordAudio("423051036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423051", "423051036", "story_v_out_423051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423051", "423051036", "story_v_out_423051.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play423051037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423051037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423051038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10148"]) and arg_149_1.var_.actorSpriteComps10148 == nil then
				arg_149_1.var_.actorSpriteComps10148 = arg_149_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10148"]) then
				if arg_149_1.var_.actorSpriteComps10148 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10148"]) and arg_149_1.var_.actorSpriteComps10148 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps10148 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.1

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(423051037).content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 4 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 4)

				if (4 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 4)) > 0 and var_152_3 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_7 and arg_149_1.time_ < var_152_2 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play423051038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423051038
		arg_153_1.duration_ = 6.73

		local var_153_0 = {
			zh = 6.733,
			ja = 5.7
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play423051039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10148"]) and arg_153_1.var_.actorSpriteComps10148 == nil then
				arg_153_1.var_.actorSpriteComps10148 = arg_153_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10148"]) then
				if arg_153_1.var_.actorSpriteComps10148 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10148"]) and arg_153_1.var_.actorSpriteComps10148 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10148 = nil
			end

			local var_156_2 = arg_153_1.actors_["10148"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10148 = var_156_2.localPosition
				var_156_2.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10148", 3)

				for iter_156_4 = 0, var_156_2.childCount - 1 do
					local var_156_3 = var_156_2:GetChild(iter_156_4)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_153_1.time_ - 0) / var_156_4)
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_156_5 = 0
			local var_156_6 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(423051038)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 26 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 26)

				if (26 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 26)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051038", "story_v_out_423051.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051038", "story_v_out_423051.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_423051", "423051038", "story_v_out_423051.awb")

						arg_153_1:RecordAudio("423051038", var_156_12)
						arg_153_1:RecordAudio("423051038", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423051", "423051038", "story_v_out_423051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423051", "423051038", "story_v_out_423051.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play423051039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423051039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play423051040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10148"]) and arg_157_1.var_.actorSpriteComps10148 == nil then
				arg_157_1.var_.actorSpriteComps10148 = arg_157_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10148"]) then
				if arg_157_1.var_.actorSpriteComps10148 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10148"]) and arg_157_1.var_.actorSpriteComps10148 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10148 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.525

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(423051039).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 21 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 21)

				if (21 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 21)) > 0 and var_160_3 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_7 and arg_157_1.time_ < var_160_2 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423051040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 423051040
		arg_161_1.duration_ = 8.6

		local var_161_0 = {
			zh = 7.666,
			ja = 8.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play423051041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10148"]) and arg_161_1.var_.actorSpriteComps10148 == nil then
				arg_161_1.var_.actorSpriteComps10148 = arg_161_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10148"]) then
				if arg_161_1.var_.actorSpriteComps10148 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 1, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10148"]) and arg_161_1.var_.actorSpriteComps10148 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps10148 = nil
			end

			local var_164_2 = arg_161_1.actors_["10148"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10148 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10148", 3)

				for iter_164_4 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_4)

					if var_164_3.name == "split_2" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_161_1.time_ - 0) / var_164_4)
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_164_5 = 0
			local var_164_6 = 0.85

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(423051040)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 34 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 34)

				if (34 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 34)) > 0 and var_164_6 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051040", "story_v_out_423051.awb") ~= 0 then
					local var_164_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051040", "story_v_out_423051.awb") / 1000

					if var_164_11 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_5
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_423051", "423051040", "story_v_out_423051.awb")

						arg_161_1:RecordAudio("423051040", var_164_12)
						arg_161_1:RecordAudio("423051040", var_164_12)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_423051", "423051040", "story_v_out_423051.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_423051", "423051040", "story_v_out_423051.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_13 and arg_161_1.time_ < var_164_5 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play423051041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 423051041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play423051042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10148"]) and arg_165_1.var_.actorSpriteComps10148 == nil then
				arg_165_1.var_.actorSpriteComps10148 = arg_165_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10148"]) then
				if arg_165_1.var_.actorSpriteComps10148 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10148"]) and arg_165_1.var_.actorSpriteComps10148 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10148 = nil
			end

			local var_168_2 = arg_165_1.actors_["10148"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10148 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10148", 7)

				for iter_168_4 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_4)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.166666666666667 + arg_168_0 then
				arg_165_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep01", "")
			end

			local var_168_6 = 0
			local var_168_7 = 1.675

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(423051041).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 67 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 67)

				if (67 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 67)) > 0 and var_168_7 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_11 and arg_165_1.time_ < var_168_6 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play423051042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 423051042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play423051043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.3

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(423051042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 52 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 52)

				if (52 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 52)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play423051043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 423051043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play423051044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.4

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(423051043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 56 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 56)

				if (56 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 56)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play423051044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 423051044
		arg_177_1.duration_ = 4.77

		local var_177_0 = {
			zh = 4.766,
			ja = 3.966
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
				arg_177_0:Play423051045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:GetWordFromCfg(423051044)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 19 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 19)

				if (19 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 19)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051044", "story_v_out_423051.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051044", "story_v_out_423051.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_423051", "423051044", "story_v_out_423051.awb")

						arg_177_1:RecordAudio("423051044", var_180_6)
						arg_177_1:RecordAudio("423051044", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_423051", "423051044", "story_v_out_423051.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_423051", "423051044", "story_v_out_423051.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play423051045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 423051045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play423051046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.3

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(423051045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 12 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 12)

				if (12 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 12)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play423051046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 423051046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play423051047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.15

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(423051046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 46 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 46)

				if (46 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 46)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play423051047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 423051047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play423051048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.325

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(423051047).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 53 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 53)

				if (53 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 53)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play423051048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 423051048
		arg_193_1.duration_ = 5.9

		local var_193_0 = {
			zh = 5.9,
			ja = 5.366
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
				arg_193_0:Play423051049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.actors_["3054"] == nil then
				local var_196_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

				if not isNil(var_196_0) then
					local var_196_1 = Object.Instantiate(var_196_0, arg_193_1.canvasGo_.transform)

					var_196_1.transform:SetSiblingIndex(1)

					var_196_1.name = "3054"
					var_196_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_193_1.actors_["3054"] = var_196_1

					if arg_193_1.isInRecall_ then
						for iter_196_0, iter_196_1 in ipairs((var_196_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_196_1.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_196_2 = arg_193_1.actors_["3054"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps3054 == nil then
				arg_193_1.var_.actorSpriteComps3054 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps3054 then
					for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_196_3 then
							if arg_193_1.isInRecall_ then
								iter_196_3.color = Color.New(Mathf.Lerp(iter_196_3.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_3.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_3.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_3.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_3.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps3054 then
				for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_196_5 then
						iter_196_5.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps3054 = nil
			end

			local var_196_5 = arg_193_1.actors_["3054"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos3054 = var_196_5.localPosition
				var_196_5.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("3054", 3)

				for iter_196_6 = 0, var_196_5.childCount - 1 do
					local var_196_6 = var_196_5:GetChild(iter_196_6)

					if var_196_6.name == "" or not string.find(var_196_6.name, "split") then
						var_196_6.gameObject:SetActive(true)
					else
						var_196_6.gameObject:SetActive(false)
					end
				end
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_193_1.time_ - 0) / var_196_7)
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(0, -275, -280)
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_8 = arg_193_1.actors_["3054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_8 then
					arg_193_1.var_.alphaOldValue3054 = var_196_8.alpha
					arg_193_1.var_.characterEffect3054 = var_196_8
				end

				arg_193_1.var_.alphaOldValue3054 = 0
			end

			local var_196_9 = 0.5

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 then
				if arg_193_1.var_.characterEffect3054 then
					arg_193_1.var_.characterEffect3054.alpha = Mathf.Lerp(arg_193_1.var_.alphaOldValue3054, 1, (arg_193_1.time_ - 0) / var_196_9)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and arg_193_1.var_.characterEffect3054 then
				arg_193_1.var_.characterEffect3054.alpha = 1
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_196_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_12 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_12

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_12
						arg_193_1.bgmTxt2_.text = var_196_12
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_13 = 0
			local var_196_14 = 0.675

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(423051048)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_18 = 27 <= 0 and var_196_14 or var_196_14 * (utf8.len(var_196_16) / 27)

				if (27 <= 0 and var_196_14 or var_196_14 * (utf8.len(var_196_16) / 27)) > 0 and var_196_14 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18

					if var_196_18 + var_196_13 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_13
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051048", "story_v_out_423051.awb") ~= 0 then
					local var_196_19 = manager.audio:GetVoiceLength("story_v_out_423051", "423051048", "story_v_out_423051.awb") / 1000

					if var_196_19 + var_196_13 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_13
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_423051", "423051048", "story_v_out_423051.awb")

						arg_193_1:RecordAudio("423051048", var_196_20)
						arg_193_1:RecordAudio("423051048", var_196_20)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_423051", "423051048", "story_v_out_423051.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_423051", "423051048", "story_v_out_423051.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_21 = math.max(var_196_14, arg_193_1.talkMaxDuration)

			if var_196_13 <= arg_193_1.time_ and arg_193_1.time_ < var_196_13 + var_196_21 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_13) / var_196_21

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_13 + var_196_21 and arg_193_1.time_ < var_196_13 + var_196_21 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423051049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 423051049
		arg_198_1.duration_ = 6.4

		local var_198_0 = {
			zh = 5.1,
			ja = 6.4
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play423051050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(423051049)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 23 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 23)

				if (23 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 23)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051049", "story_v_out_423051.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051049", "story_v_out_423051.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_423051", "423051049", "story_v_out_423051.awb")

						arg_198_1:RecordAudio("423051049", var_201_6)
						arg_198_1:RecordAudio("423051049", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_423051", "423051049", "story_v_out_423051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_423051", "423051049", "story_v_out_423051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play423051050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 423051050
		arg_202_1.duration_ = 6.33

		local var_202_0 = {
			zh = 6.333,
			ja = 5.7
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play423051051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos3054 = arg_202_1.actors_["3054"].transform.localPosition
				arg_202_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("3054", 3)

				for iter_205_0 = 0, arg_202_1.actors_["3054"].transform.childCount - 1 do
					local var_205_0 = arg_202_1.actors_["3054"].transform:GetChild(iter_205_0)

					if var_205_0.name == "" or not string.find(var_205_0.name, "split") then
						var_205_0.gameObject:SetActive(true)
					else
						var_205_0.gameObject:SetActive(false)
					end
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_202_1.time_ - 0) / var_205_1)
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_205_2 = 0
			local var_205_3 = 0.675

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:GetWordFromCfg(423051050)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 27 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 27)

				if (27 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 27)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051050", "story_v_out_423051.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051050", "story_v_out_423051.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_out_423051", "423051050", "story_v_out_423051.awb")

						arg_202_1:RecordAudio("423051050", var_205_9)
						arg_202_1:RecordAudio("423051050", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_423051", "423051050", "story_v_out_423051.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_423051", "423051050", "story_v_out_423051.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play423051051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 423051051
		arg_206_1.duration_ = 10.47

		local var_206_0 = {
			zh = 8.266,
			ja = 10.466
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play423051052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if arg_206_1.bgs_.ST0112 == nil then
				local var_209_0 = Object.Instantiate(arg_206_1.paintGo_)

				var_209_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0112")
				var_209_0.name = "ST0112"
				var_209_0.transform.parent = arg_206_1.stage_.transform
				var_209_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.bgs_.ST0112 = var_209_0
			end

			if 2 < arg_206_1.time_ and arg_206_1.time_ <= 2 + arg_209_0 then
				local var_209_1 = arg_206_1.bgs_.ST0112

				arg_206_1.bgs_.ST0112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_209_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_2 = var_209_1:GetComponent("SpriteRenderer")

				if var_209_2 and var_209_2.sprite then
					local var_209_3 = 2 * (var_209_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_209_1.transform.localScale = Vector3.New(var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST0112" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_4 = 4

			if 4 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			if arg_206_1.time_ >= var_209_4 + 0.3 and arg_206_1.time_ < var_209_4 + 0.3 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_5 = 0

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_6 = 2

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_6 then
				local var_209_7 = Color.New(0, 0, 0)

				var_209_7.a = Mathf.Lerp(0, 1, (arg_206_1.time_ - var_209_5) / var_209_6)
				arg_206_1.mask_.color = var_209_7
			end

			if arg_206_1.time_ >= var_209_5 + var_209_6 and arg_206_1.time_ < var_209_5 + var_209_6 + arg_209_0 then
				local var_209_8 = Color.New(0, 0, 0)

				var_209_8.a = 1
				arg_206_1.mask_.color = var_209_8
			end

			local var_209_9 = 2

			if 2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_10 = 2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 then
				local var_209_11 = Color.New(0, 0, 0)

				var_209_11.a = Mathf.Lerp(1, 0, (arg_206_1.time_ - var_209_9) / var_209_10)
				arg_206_1.mask_.color = var_209_11
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 then
				local var_209_12 = Color.New(0, 0, 0)

				arg_206_1.mask_.enabled = false
				var_209_12.a = 0
				arg_206_1.mask_.color = var_209_12
			end

			local var_209_13 = arg_206_1.actors_["10148"]

			if 3.8 < arg_206_1.time_ and arg_206_1.time_ <= 3.8 + arg_209_0 and not isNil(var_209_13) and arg_206_1.var_.actorSpriteComps10148 == nil then
				arg_206_1.var_.actorSpriteComps10148 = var_209_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_14 = 0.2

			if 3.8 <= arg_206_1.time_ and arg_206_1.time_ < 3.8 + var_209_14 and not isNil(var_209_13) then
				if arg_206_1.var_.actorSpriteComps10148 then
					for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_209_3 then
							if arg_206_1.isInRecall_ then
								iter_209_3.color = Color.New(Mathf.Lerp(iter_209_3.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 3.8) / var_209_14), Mathf.Lerp(iter_209_3.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 3.8) / var_209_14), (Mathf.Lerp(iter_209_3.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 3.8) / var_209_14)))
							else
								local var_209_15 = Mathf.Lerp(iter_209_3.color.r, 1, (arg_206_1.time_ - 3.8) / var_209_14)

								iter_209_3.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 3.8 + var_209_14 and arg_206_1.time_ < 3.8 + var_209_14 + arg_209_0 and not isNil(var_209_13) and arg_206_1.var_.actorSpriteComps10148 then
				for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_209_5 then
						iter_209_5.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps10148 = nil
			end

			local var_209_16 = arg_206_1.actors_["3054"]

			if 1.8 < arg_206_1.time_ and arg_206_1.time_ <= 1.8 + arg_209_0 and not isNil(var_209_16) and arg_206_1.var_.actorSpriteComps3054 == nil then
				arg_206_1.var_.actorSpriteComps3054 = var_209_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_17 = 0.2

			if 1.8 <= arg_206_1.time_ and arg_206_1.time_ < 1.8 + var_209_17 and not isNil(var_209_16) then
				if arg_206_1.var_.actorSpriteComps3054 then
					for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_209_7 then
							if arg_206_1.isInRecall_ then
								iter_209_7.color = Color.New(Mathf.Lerp(iter_209_7.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 1.8) / var_209_17), Mathf.Lerp(iter_209_7.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 1.8) / var_209_17), (Mathf.Lerp(iter_209_7.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 1.8) / var_209_17)))
							else
								local var_209_18 = Mathf.Lerp(iter_209_7.color.r, 0.5, (arg_206_1.time_ - 1.8) / var_209_17)

								iter_209_7.color = Color.New(var_209_18, var_209_18, var_209_18)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 1.8 + var_209_17 and arg_206_1.time_ < 1.8 + var_209_17 + arg_209_0 and not isNil(var_209_16) and arg_206_1.var_.actorSpriteComps3054 then
				for iter_209_8, iter_209_9 in pairs(arg_206_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_209_9 then
						iter_209_9.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps3054 = nil
			end

			local var_209_19 = arg_206_1.actors_["3054"].transform

			if 1.966 < arg_206_1.time_ and arg_206_1.time_ <= 1.966 + arg_209_0 then
				arg_206_1.var_.moveOldPos3054 = var_209_19.localPosition
				var_209_19.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("3054", 7)

				for iter_209_10 = 0, var_209_19.childCount - 1 do
					local var_209_20 = var_209_19:GetChild(iter_209_10)

					if var_209_20.name == "" or not string.find(var_209_20.name, "split") then
						var_209_20.gameObject:SetActive(true)
					else
						var_209_20.gameObject:SetActive(false)
					end
				end
			end

			local var_209_21 = 0.001

			if 1.966 <= arg_206_1.time_ and arg_206_1.time_ < 1.966 + var_209_21 then
				var_209_19.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_206_1.time_ - 1.966) / var_209_21)
			end

			if arg_206_1.time_ >= 1.966 + var_209_21 and arg_206_1.time_ < 1.966 + var_209_21 + arg_209_0 then
				var_209_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_22 = arg_206_1.actors_["10148"].transform

			if 3.8 < arg_206_1.time_ and arg_206_1.time_ <= 3.8 + arg_209_0 then
				arg_206_1.var_.moveOldPos10148 = var_209_22.localPosition
				var_209_22.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10148", 3)

				for iter_209_11 = 0, var_209_22.childCount - 1 do
					local var_209_23 = var_209_22:GetChild(iter_209_11)

					if var_209_23.name == "split_4" or not string.find(var_209_23.name, "split") then
						var_209_23.gameObject:SetActive(true)
					else
						var_209_23.gameObject:SetActive(false)
					end
				end
			end

			local var_209_24 = 0.001

			if 3.8 <= arg_206_1.time_ and arg_206_1.time_ < 3.8 + var_209_24 then
				var_209_22.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_206_1.time_ - 3.8) / var_209_24)
			end

			if arg_206_1.time_ >= 3.8 + var_209_24 and arg_206_1.time_ < 3.8 + var_209_24 + arg_209_0 then
				var_209_22.localPosition = Vector3.New(0, -350, -270)
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 1.8 < arg_206_1.time_ and arg_206_1.time_ <= 1.8 + arg_209_0 then
				arg_206_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_209_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_206_1.bgmTxt_.text ~= var_209_29 and arg_206_1.bgmTxt_.text ~= "" then
						if arg_206_1.bgmTxt2_.text ~= "" then
							arg_206_1.bgmTxt_.text = arg_206_1.bgmTxt2_.text
						end

						arg_206_1.bgmTxt2_.text = var_209_29

						arg_206_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_206_1.bgmTxt_.text = var_209_29
						arg_206_1.bgmTxt2_.text = var_209_29
					end

					if arg_206_1.bgmTimer then
						arg_206_1.bgmTimer:Stop()

						arg_206_1.bgmTimer = nil
					end

					if arg_206_1.settingData.show_music_name == 1 then
						arg_206_1.musicController:SetSelectedState("show")
						arg_206_1.musicAnimator_:Play("open", 0, 0)

						if arg_206_1.settingData.music_time ~= 0 then
							arg_206_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_206_1.settingData.music_time), function()
								if arg_206_1 == nil or isNil(arg_206_1.bgmTxt_) then
									return
								end

								arg_206_1.musicController:SetSelectedState("hide")
								arg_206_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_206_1.time_ and arg_206_1.time_ <= 1.5 + arg_209_0 then
				arg_206_1:AudioAction("play", "music", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")

				local var_209_32 = manager.audio:GetAudioName("bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel")

				if "" ~= "" then
					if arg_206_1.bgmTxt_.text ~= var_209_32 and arg_206_1.bgmTxt_.text ~= "" then
						if arg_206_1.bgmTxt2_.text ~= "" then
							arg_206_1.bgmTxt_.text = arg_206_1.bgmTxt2_.text
						end

						arg_206_1.bgmTxt2_.text = var_209_32

						arg_206_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_206_1.bgmTxt_.text = var_209_32
						arg_206_1.bgmTxt2_.text = var_209_32
					end

					if arg_206_1.bgmTimer then
						arg_206_1.bgmTimer:Stop()

						arg_206_1.bgmTimer = nil
					end

					if arg_206_1.settingData.show_music_name == 1 then
						arg_206_1.musicController:SetSelectedState("show")
						arg_206_1.musicAnimator_:Play("open", 0, 0)

						if arg_206_1.settingData.music_time ~= 0 then
							arg_206_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_206_1.settingData.music_time), function()
								if arg_206_1 == nil or isNil(arg_206_1.bgmTxt_) then
									return
								end

								arg_206_1.musicController:SetSelectedState("hide")
								arg_206_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_206_1.frameCnt_ <= 1 then
				arg_206_1.dialog_:SetActive(false)
			end

			local var_209_33 = 4
			local var_209_34 = 0.6

			if 4 < arg_206_1.time_ and arg_206_1.time_ <= var_209_33 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_35 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_35:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_206_1.dialogCg_.alpha = arg_212_0
				end))
				var_209_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_36 = arg_206_1:GetWordFromCfg(423051051)
				local var_209_37 = arg_206_1:FormatText(var_209_36.content)

				arg_206_1.text_.text = var_209_37

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_39 = 24 <= 0 and var_209_34 or var_209_34 * (utf8.len(var_209_37) / 24)

				if (24 <= 0 and var_209_34 or var_209_34 * (utf8.len(var_209_37) / 24)) > 0 and var_209_34 < var_209_39 then
					arg_206_1.talkMaxDuration = var_209_39
					var_209_33 = var_209_33 + 0.3

					if var_209_39 + var_209_33 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_39 + var_209_33
					end
				end

				arg_206_1.text_.text = var_209_37
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051051", "story_v_out_423051.awb") ~= 0 then
					local var_209_40 = manager.audio:GetVoiceLength("story_v_out_423051", "423051051", "story_v_out_423051.awb") / 1000

					if var_209_40 + var_209_33 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_40 + var_209_33
					end

					if var_209_36.prefab_name ~= "" and arg_206_1.actors_[var_209_36.prefab_name] ~= nil then
						local var_209_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_36.prefab_name].transform, "story_v_out_423051", "423051051", "story_v_out_423051.awb")

						arg_206_1:RecordAudio("423051051", var_209_41)
						arg_206_1:RecordAudio("423051051", var_209_41)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_423051", "423051051", "story_v_out_423051.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_423051", "423051051", "story_v_out_423051.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_42 = var_209_33 + 0.3
			local var_209_43 = math.max(var_209_34, arg_206_1.talkMaxDuration)

			if var_209_33 + 0.3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_42 + var_209_43 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_42) / var_209_43

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_42 + var_209_43 and arg_206_1.time_ < var_209_42 + var_209_43 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play423051052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 423051052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play423051053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10148"]) and arg_214_1.var_.actorSpriteComps10148 == nil then
				arg_214_1.var_.actorSpriteComps10148 = arg_214_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10148"]) then
				if arg_214_1.var_.actorSpriteComps10148 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10148"]) and arg_214_1.var_.actorSpriteComps10148 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10148 = nil
			end

			local var_217_2 = 0
			local var_217_3 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_4 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(423051052).content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 9 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_4) / 9)

				if (9 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_4) / 9)) > 0 and var_217_3 < var_217_6 then
					arg_214_1.talkMaxDuration = var_217_6

					if var_217_6 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_6 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_7 and arg_214_1.time_ < var_217_2 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play423051053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 423051053
		arg_218_1.duration_ = 6.8

		local var_218_0 = {
			zh = 6.8,
			ja = 4.933
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play423051054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10148"]) and arg_218_1.var_.actorSpriteComps10148 == nil then
				arg_218_1.var_.actorSpriteComps10148 = arg_218_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10148"]) then
				if arg_218_1.var_.actorSpriteComps10148 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10148"]) and arg_218_1.var_.actorSpriteComps10148 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps10148 = nil
			end

			local var_221_2 = arg_218_1.actors_["10148"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10148 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10148", 3)

				for iter_221_4 = 0, var_221_2.childCount - 1 do
					local var_221_3 = var_221_2:GetChild(iter_221_4)

					if var_221_3.name == "" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_221_5 = 0
			local var_221_6 = 0.75

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:GetWordFromCfg(423051053)
				local var_221_8 = arg_218_1:FormatText(var_221_7.content)

				arg_218_1.text_.text = var_221_8

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 30 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 30)

				if (30 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 30)) > 0 and var_221_6 < var_221_10 then
					arg_218_1.talkMaxDuration = var_221_10

					if var_221_10 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_8
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051053", "story_v_out_423051.awb") ~= 0 then
					local var_221_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051053", "story_v_out_423051.awb") / 1000

					if var_221_11 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_5
					end

					if var_221_7.prefab_name ~= "" and arg_218_1.actors_[var_221_7.prefab_name] ~= nil then
						local var_221_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_7.prefab_name].transform, "story_v_out_423051", "423051053", "story_v_out_423051.awb")

						arg_218_1:RecordAudio("423051053", var_221_12)
						arg_218_1:RecordAudio("423051053", var_221_12)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_423051", "423051053", "story_v_out_423051.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_423051", "423051053", "story_v_out_423051.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_13 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_13 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_13

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_13 and arg_218_1.time_ < var_221_5 + var_221_13 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play423051054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 423051054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play423051055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10148"]) and arg_222_1.var_.actorSpriteComps10148 == nil then
				arg_222_1.var_.actorSpriteComps10148 = arg_222_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10148"]) then
				if arg_222_1.var_.actorSpriteComps10148 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10148"]) and arg_222_1.var_.actorSpriteComps10148 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10148 = nil
			end

			local var_225_2 = 0
			local var_225_3 = 0.575

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_4 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(423051054).content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_6 = 23 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_4) / 23)

				if (23 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_4) / 23)) > 0 and var_225_3 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_7 and arg_222_1.time_ < var_225_2 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play423051055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 423051055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play423051056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10148 = arg_226_1.actors_["10148"].transform.localPosition
				arg_226_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10148", 7)

				for iter_229_0 = 0, arg_226_1.actors_["10148"].transform.childCount - 1 do
					local var_229_0 = arg_226_1.actors_["10148"].transform:GetChild(iter_229_0)

					if var_229_0.name == "" or not string.find(var_229_0.name, "split") then
						var_229_0.gameObject:SetActive(true)
					else
						var_229_0.gameObject:SetActive(false)
					end
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_226_1.time_ - 0) / var_229_1)
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_2 = 0
			local var_229_3 = 1.025

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(423051055).content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_6 = 41 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_4) / 41)

				if (41 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_4) / 41)) > 0 and var_229_3 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_7 and arg_226_1.time_ < var_229_2 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play423051056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 423051056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play423051057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 1.325

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(423051056).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 53 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 53)

				if (53 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 53)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play423051057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 423051057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play423051058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.175

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(423051057).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 7 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 7)

				if (7 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 7)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play423051058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 423051058
		arg_238_1.duration_ = 7.2

		local var_238_0 = {
			zh = 6.3,
			ja = 7.2
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play423051059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1083"]) and arg_238_1.var_.actorSpriteComps1083 == nil then
				arg_238_1.var_.actorSpriteComps1083 = arg_238_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1083"]) then
				if arg_238_1.var_.actorSpriteComps1083 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 1, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1083"]) and arg_238_1.var_.actorSpriteComps1083 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps1083 = nil
			end

			local var_241_2 = arg_238_1.actors_["1083"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1083 = var_241_2.localPosition
				var_241_2.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1083", 3)

				for iter_241_4 = 0, var_241_2.childCount - 1 do
					local var_241_3 = var_241_2:GetChild(iter_241_4)

					if var_241_3.name == "split_1" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				var_241_2.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_238_1.time_ - 0) / var_241_4)
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				var_241_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_241_5 = 0
			local var_241_6 = 0.725

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_7 = arg_238_1:GetWordFromCfg(423051058)
				local var_241_8 = arg_238_1:FormatText(var_241_7.content)

				arg_238_1.text_.text = var_241_8

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_10 = 29 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 29)

				if (29 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 29)) > 0 and var_241_6 < var_241_10 then
					arg_238_1.talkMaxDuration = var_241_10

					if var_241_10 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_8
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051058", "story_v_out_423051.awb") ~= 0 then
					local var_241_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051058", "story_v_out_423051.awb") / 1000

					if var_241_11 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_5
					end

					if var_241_7.prefab_name ~= "" and arg_238_1.actors_[var_241_7.prefab_name] ~= nil then
						local var_241_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_7.prefab_name].transform, "story_v_out_423051", "423051058", "story_v_out_423051.awb")

						arg_238_1:RecordAudio("423051058", var_241_12)
						arg_238_1:RecordAudio("423051058", var_241_12)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_423051", "423051058", "story_v_out_423051.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_423051", "423051058", "story_v_out_423051.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_13 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_13 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_13

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_13 and arg_238_1.time_ < var_241_5 + var_241_13 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play423051059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 423051059
		arg_242_1.duration_ = 5.87

		local var_242_0 = {
			zh = 3.4,
			ja = 5.866
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play423051060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1083 = arg_242_1.actors_["1083"].transform.localPosition
				arg_242_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1083", 3)

				for iter_245_0 = 0, arg_242_1.actors_["1083"].transform.childCount - 1 do
					local var_245_0 = arg_242_1.actors_["1083"].transform:GetChild(iter_245_0)

					if var_245_0.name == "" or not string.find(var_245_0.name, "split") then
						var_245_0.gameObject:SetActive(true)
					else
						var_245_0.gameObject:SetActive(false)
					end
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_242_1.time_ - 0) / var_245_1)
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_245_2 = 0
			local var_245_3 = 0.35

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:GetWordFromCfg(423051059)
				local var_245_5 = arg_242_1:FormatText(var_245_4.content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 14 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 14)

				if (14 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 14)) > 0 and var_245_3 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051059", "story_v_out_423051.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051059", "story_v_out_423051.awb") / 1000

					if var_245_8 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_2
					end

					if var_245_4.prefab_name ~= "" and arg_242_1.actors_[var_245_4.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_4.prefab_name].transform, "story_v_out_423051", "423051059", "story_v_out_423051.awb")

						arg_242_1:RecordAudio("423051059", var_245_9)
						arg_242_1:RecordAudio("423051059", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_423051", "423051059", "story_v_out_423051.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_423051", "423051059", "story_v_out_423051.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_10 and arg_242_1.time_ < var_245_2 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play423051060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 423051060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play423051061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1083"]) and arg_246_1.var_.actorSpriteComps1083 == nil then
				arg_246_1.var_.actorSpriteComps1083 = arg_246_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1083"]) then
				if arg_246_1.var_.actorSpriteComps1083 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1083"]) and arg_246_1.var_.actorSpriteComps1083 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps1083 = nil
			end

			local var_249_2 = 0
			local var_249_3 = 0.7

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(423051060).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 28 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 28)

				if (28 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 28)) > 0 and var_249_3 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_7 and arg_246_1.time_ < var_249_2 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play423051061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 423051061
		arg_250_1.duration_ = 7.23

		local var_250_0 = {
			zh = 5.033,
			ja = 7.233
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play423051062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1083"]) and arg_250_1.var_.actorSpriteComps1083 == nil then
				arg_250_1.var_.actorSpriteComps1083 = arg_250_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1083"]) then
				if arg_250_1.var_.actorSpriteComps1083 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 1, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1083"]) and arg_250_1.var_.actorSpriteComps1083 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps1083 = nil
			end

			local var_253_2 = arg_250_1.actors_["1083"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1083 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1083", 3)

				for iter_253_4 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_4)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_250_1.time_ - 0) / var_253_4)
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_253_5 = 0
			local var_253_6 = 0.55

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:GetWordFromCfg(423051061)
				local var_253_8 = arg_250_1:FormatText(var_253_7.content)

				arg_250_1.text_.text = var_253_8

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 22 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 22)

				if (22 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 22)) > 0 and var_253_6 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_8
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051061", "story_v_out_423051.awb") ~= 0 then
					local var_253_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051061", "story_v_out_423051.awb") / 1000

					if var_253_11 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_5
					end

					if var_253_7.prefab_name ~= "" and arg_250_1.actors_[var_253_7.prefab_name] ~= nil then
						local var_253_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_7.prefab_name].transform, "story_v_out_423051", "423051061", "story_v_out_423051.awb")

						arg_250_1:RecordAudio("423051061", var_253_12)
						arg_250_1:RecordAudio("423051061", var_253_12)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_423051", "423051061", "story_v_out_423051.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_423051", "423051061", "story_v_out_423051.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_13 and arg_250_1.time_ < var_253_5 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play423051062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 423051062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play423051063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1083"]) and arg_254_1.var_.actorSpriteComps1083 == nil then
				arg_254_1.var_.actorSpriteComps1083 = arg_254_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1083"]) then
				if arg_254_1.var_.actorSpriteComps1083 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1083"]) and arg_254_1.var_.actorSpriteComps1083 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps1083 = nil
			end

			local var_257_2 = 0
			local var_257_3 = 0.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_4 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(423051062).content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_6 = 16 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 16)

				if (16 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 16)) > 0 and var_257_3 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_7 and arg_254_1.time_ < var_257_2 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play423051063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 423051063
		arg_258_1.duration_ = 5.77

		local var_258_0 = {
			zh = 5.766,
			ja = 4.2
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play423051064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1083"]) and arg_258_1.var_.actorSpriteComps1083 == nil then
				arg_258_1.var_.actorSpriteComps1083 = arg_258_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1083"]) then
				if arg_258_1.var_.actorSpriteComps1083 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 1, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1083"]) and arg_258_1.var_.actorSpriteComps1083 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps1083 = nil
			end

			local var_261_2 = arg_258_1.actors_["1083"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1083 = var_261_2.localPosition
				var_261_2.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1083", 3)

				for iter_261_4 = 0, var_261_2.childCount - 1 do
					local var_261_3 = var_261_2:GetChild(iter_261_4)

					if var_261_3.name == "split_8" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_2.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_258_1.time_ - 0) / var_261_4)
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_261_5 = 0
			local var_261_6 = 0.65

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_7 = arg_258_1:GetWordFromCfg(423051063)
				local var_261_8 = arg_258_1:FormatText(var_261_7.content)

				arg_258_1.text_.text = var_261_8

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 26 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_8) / 26)

				if (26 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_8) / 26)) > 0 and var_261_6 < var_261_10 then
					arg_258_1.talkMaxDuration = var_261_10

					if var_261_10 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_8
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051063", "story_v_out_423051.awb") ~= 0 then
					local var_261_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051063", "story_v_out_423051.awb") / 1000

					if var_261_11 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_11 + var_261_5
					end

					if var_261_7.prefab_name ~= "" and arg_258_1.actors_[var_261_7.prefab_name] ~= nil then
						local var_261_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_7.prefab_name].transform, "story_v_out_423051", "423051063", "story_v_out_423051.awb")

						arg_258_1:RecordAudio("423051063", var_261_12)
						arg_258_1:RecordAudio("423051063", var_261_12)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_423051", "423051063", "story_v_out_423051.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_423051", "423051063", "story_v_out_423051.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_13 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_13 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_13

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_13 and arg_258_1.time_ < var_261_5 + var_261_13 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play423051064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 423051064
		arg_262_1.duration_ = 6.6

		local var_262_0 = {
			zh = 6.6,
			ja = 5.5
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play423051065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1083 = arg_262_1.actors_["1083"].transform.localPosition
				arg_262_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1083", 3)

				for iter_265_0 = 0, arg_262_1.actors_["1083"].transform.childCount - 1 do
					local var_265_0 = arg_262_1.actors_["1083"].transform:GetChild(iter_265_0)

					if var_265_0.name == "" or not string.find(var_265_0.name, "split") then
						var_265_0.gameObject:SetActive(true)
					else
						var_265_0.gameObject:SetActive(false)
					end
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_262_1.time_ - 0) / var_265_1)
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_265_2 = 0
			local var_265_3 = 0.625

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(423051064)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 25 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 25)

				if (25 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 25)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051064", "story_v_out_423051.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051064", "story_v_out_423051.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_out_423051", "423051064", "story_v_out_423051.awb")

						arg_262_1:RecordAudio("423051064", var_265_9)
						arg_262_1:RecordAudio("423051064", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_423051", "423051064", "story_v_out_423051.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_423051", "423051064", "story_v_out_423051.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_10 and arg_262_1.time_ < var_265_2 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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

		arg_262_1:InitPlayNodeList()
	end,
	Play423051065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 423051065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play423051066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1083"]) and arg_266_1.var_.actorSpriteComps1083 == nil then
				arg_266_1.var_.actorSpriteComps1083 = arg_266_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1083"]) then
				if arg_266_1.var_.actorSpriteComps1083 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1083"]) and arg_266_1.var_.actorSpriteComps1083 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps1083 = nil
			end

			local var_269_2 = 0
			local var_269_3 = 0.7

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(423051065).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 28 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 28)

				if (28 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 28)) > 0 and var_269_3 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_7 and arg_266_1.time_ < var_269_2 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play423051066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 423051066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play423051067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_9000

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1083"]) and arg_270_1.var_.actorSpriteComps1083 == nil then
				arg_270_1.var_.actorSpriteComps1083 = arg_270_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1083"]) then
				if arg_270_1.var_.actorSpriteComps1083 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 1, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1083"]) and arg_270_1.var_.actorSpriteComps1083 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps1083 = nil
			end

			local var_273_2 = arg_270_1.actors_["1083"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1083 = var_273_2.localPosition
				var_273_2.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1083", 3)

				for iter_273_4 = 0, var_273_2.childCount - 1 do
					local var_273_3 = var_273_2:GetChild(iter_273_4)

					if var_273_3.name == "split_7" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_270_1.time_ - 0) / var_273_4)
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_5 = arg_270_1.var_.effectsikao

				if not arg_270_1.var_.effectsikao then
					var_273_5 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_loading2_keep"), arg_270_1.story_ui_effectTrs_.transform)
					var_273_5.name = "sikao"
					arg_270_1.var_.effectsikao = var_273_5
				else
					var_273_5.transform:SetParent(var_273_9000)
				end

				var_273_5.transform.localPosition = Vector3.New(-20, 0, 0)
				var_273_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_273_7 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_7 + 5 and arg_270_1.time_ < var_273_7 + 5 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_8 = 0
			local var_273_9 = 0.05

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_10 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_10:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_11 = arg_270_1:GetWordFromCfg(423051066)
				local var_273_12 = arg_270_1:FormatText(var_273_11.content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_14 = 2 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_12) / 2)

				if (2 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_12) / 2)) > 0 and var_273_9 < var_273_14 then
					arg_270_1.talkMaxDuration = var_273_14
					var_273_8 = var_273_8 + 0.3

					if var_273_14 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051066", "story_v_out_423051.awb") ~= 0 then
					local var_273_15 = manager.audio:GetVoiceLength("story_v_out_423051", "423051066", "story_v_out_423051.awb") / 1000

					if var_273_15 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_8
					end

					if var_273_11.prefab_name ~= "" and arg_270_1.actors_[var_273_11.prefab_name] ~= nil then
						local var_273_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_11.prefab_name].transform, "story_v_out_423051", "423051066", "story_v_out_423051.awb")

						arg_270_1:RecordAudio("423051066", var_273_16)
						arg_270_1:RecordAudio("423051066", var_273_16)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_423051", "423051066", "story_v_out_423051.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_423051", "423051066", "story_v_out_423051.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_17 = var_273_8 + 0.3
			local var_273_18 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_18 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_17) / var_273_18

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_17 + var_273_18 and arg_270_1.time_ < var_273_17 + var_273_18 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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

		arg_270_1:InitPlayNodeList()
	end,
	Play423051067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 423051067
		arg_276_1.duration_ = 9.13

		local var_276_0 = {
			zh = 9.066,
			ja = 9.133
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play423051068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_9000

			if 0.5 < arg_276_1.time_ and arg_276_1.time_ <= 0.5 + arg_279_0 then
				arg_276_1.var_.moveOldPos1083 = arg_276_1.actors_["1083"].transform.localPosition
				arg_276_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("1083", 3)

				for iter_279_0 = 0, arg_276_1.actors_["1083"].transform.childCount - 1 do
					local var_279_0 = arg_276_1.actors_["1083"].transform:GetChild(iter_279_0)

					if var_279_0.name == "split_8" or not string.find(var_279_0.name, "split") then
						var_279_0.gameObject:SetActive(true)
					else
						var_279_0.gameObject:SetActive(false)
					end
				end
			end

			local var_279_1 = 0.001

			if 0.5 <= arg_276_1.time_ and arg_276_1.time_ < 0.5 + var_279_1 then
				arg_276_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_276_1.time_ - 0.5) / var_279_1)
			end

			if arg_276_1.time_ >= 0.5 + var_279_1 and arg_276_1.time_ < 0.5 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				if arg_276_1.var_.effectsikao then
					Object.Destroy(arg_276_1.var_.effectsikao)

					arg_276_1.var_.effectsikao = nil
				end
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				local var_279_3 = arg_276_1.var_.effectsikao2

				if not arg_276_1.var_.effectsikao2 then
					var_279_3 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_loading2_out"), arg_276_1.story_ui_effectTrs_.transform)
					var_279_3.name = "sikao2"
					arg_276_1.var_.effectsikao2 = var_279_3
				else
					var_279_3.transform:SetParent(var_279_9000)
				end

				var_279_3.transform.localPosition = Vector3.New(-20, 0, 0)
				var_279_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_279_5 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			if arg_276_1.time_ >= var_279_5 + 1 and arg_276_1.time_ < var_279_5 + 1 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_6 = 0.5
			local var_279_7 = 0.825

			if 0.5 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_8 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_8:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_9 = arg_276_1:GetWordFromCfg(423051067)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_12 = 33 <= 0 and var_279_7 or var_279_7 * (utf8.len(var_279_10) / 33)

				if (33 <= 0 and var_279_7 or var_279_7 * (utf8.len(var_279_10) / 33)) > 0 and var_279_7 < var_279_12 then
					arg_276_1.talkMaxDuration = var_279_12
					var_279_6 = var_279_6 + 0.3

					if var_279_12 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051067", "story_v_out_423051.awb") ~= 0 then
					local var_279_13 = manager.audio:GetVoiceLength("story_v_out_423051", "423051067", "story_v_out_423051.awb") / 1000

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end

					if var_279_9.prefab_name ~= "" and arg_276_1.actors_[var_279_9.prefab_name] ~= nil then
						local var_279_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_9.prefab_name].transform, "story_v_out_423051", "423051067", "story_v_out_423051.awb")

						arg_276_1:RecordAudio("423051067", var_279_14)
						arg_276_1:RecordAudio("423051067", var_279_14)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_423051", "423051067", "story_v_out_423051.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_423051", "423051067", "story_v_out_423051.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_15 = var_279_6 + 0.3
			local var_279_16 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_16 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_16

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_16 and arg_276_1.time_ < var_279_15 + var_279_16 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play423051068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 423051068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play423051069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1083"]) and arg_282_1.var_.actorSpriteComps1083 == nil then
				arg_282_1.var_.actorSpriteComps1083 = arg_282_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1083"]) then
				if arg_282_1.var_.actorSpriteComps1083 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1083"]) and arg_282_1.var_.actorSpriteComps1083 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps1083 = nil
			end

			local var_285_2 = 0
			local var_285_3 = 0.5

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_4 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(423051068).content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_6 = 20 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 20)

				if (20 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 20)) > 0 and var_285_3 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_2
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_3, arg_282_1.talkMaxDuration)

			if var_285_2 <= arg_282_1.time_ and arg_282_1.time_ < var_285_2 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_2) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_2 + var_285_7 and arg_282_1.time_ < var_285_2 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play423051069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 423051069
		arg_286_1.duration_ = 7.1

		local var_286_0 = {
			zh = 6.666,
			ja = 7.1
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play423051070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1083"]) and arg_286_1.var_.actorSpriteComps1083 == nil then
				arg_286_1.var_.actorSpriteComps1083 = arg_286_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1083"]) then
				if arg_286_1.var_.actorSpriteComps1083 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								iter_289_1.color = Color.New(Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_0), Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_0), (Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_0)))
							else
								local var_289_1 = Mathf.Lerp(iter_289_1.color.r, 1, (arg_286_1.time_ - 0) / var_289_0)

								iter_289_1.color = Color.New(var_289_1, var_289_1, var_289_1)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1083"]) and arg_286_1.var_.actorSpriteComps1083 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps1083 = nil
			end

			local var_289_2 = arg_286_1.actors_["1083"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1083 = var_289_2.localPosition
				var_289_2.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("1083", 3)

				for iter_289_4 = 0, var_289_2.childCount - 1 do
					local var_289_3 = var_289_2:GetChild(iter_289_4)

					if var_289_3.name == "" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				var_289_2.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_286_1.time_ - 0) / var_289_4)
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				var_289_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_289_5 = 0
			local var_289_6 = 0.675

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_7 = arg_286_1:GetWordFromCfg(423051069)
				local var_289_8 = arg_286_1:FormatText(var_289_7.content)

				arg_286_1.text_.text = var_289_8

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_10 = 27 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 27)

				if (27 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 27)) > 0 and var_289_6 < var_289_10 then
					arg_286_1.talkMaxDuration = var_289_10

					if var_289_10 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_5
					end
				end

				arg_286_1.text_.text = var_289_8
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051069", "story_v_out_423051.awb") ~= 0 then
					local var_289_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051069", "story_v_out_423051.awb") / 1000

					if var_289_11 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_11 + var_289_5
					end

					if var_289_7.prefab_name ~= "" and arg_286_1.actors_[var_289_7.prefab_name] ~= nil then
						local var_289_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_7.prefab_name].transform, "story_v_out_423051", "423051069", "story_v_out_423051.awb")

						arg_286_1:RecordAudio("423051069", var_289_12)
						arg_286_1:RecordAudio("423051069", var_289_12)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_423051", "423051069", "story_v_out_423051.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_423051", "423051069", "story_v_out_423051.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_6, arg_286_1.talkMaxDuration)

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_5) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_5 + var_289_13 and arg_286_1.time_ < var_289_5 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play423051070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 423051070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play423051071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1083"]) and arg_290_1.var_.actorSpriteComps1083 == nil then
				arg_290_1.var_.actorSpriteComps1083 = arg_290_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1083"]) then
				if arg_290_1.var_.actorSpriteComps1083 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1083"]) and arg_290_1.var_.actorSpriteComps1083 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps1083 = nil
			end

			local var_293_2 = 0
			local var_293_3 = 0.8

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_4 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(423051070).content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_6 = 32 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 32)

				if (32 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 32)) > 0 and var_293_3 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_7 and arg_290_1.time_ < var_293_2 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play423051071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 423051071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play423051072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1083"]) and arg_294_1.var_.actorSpriteComps1083 == nil then
				arg_294_1.var_.actorSpriteComps1083 = arg_294_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1083"]) then
				if arg_294_1.var_.actorSpriteComps1083 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor2.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor2.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor2.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 0.5, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1083"]) and arg_294_1.var_.actorSpriteComps1083 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_294_1.var_.actorSpriteComps1083 = nil
			end

			local var_297_2 = 0
			local var_297_3 = 0.75

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_4 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(423051071).content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_6 = 30 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_4) / 30)

				if (30 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_4) / 30)) > 0 and var_297_3 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_7 and arg_294_1.time_ < var_297_2 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play423051072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 423051072
		arg_298_1.duration_ = 2.6

		local var_298_0 = {
			zh = 1.666,
			ja = 2.6
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play423051073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1083"]) and arg_298_1.var_.actorSpriteComps1083 == nil then
				arg_298_1.var_.actorSpriteComps1083 = arg_298_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1083"]) then
				if arg_298_1.var_.actorSpriteComps1083 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 1, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1083"]) and arg_298_1.var_.actorSpriteComps1083 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps1083 = nil
			end

			local var_301_2 = arg_298_1.actors_["1083"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1083 = var_301_2.localPosition
				var_301_2.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1083", 3)

				for iter_301_4 = 0, var_301_2.childCount - 1 do
					local var_301_3 = var_301_2:GetChild(iter_301_4)

					if var_301_3.name == "" or not string.find(var_301_3.name, "split") then
						var_301_3.gameObject:SetActive(true)
					else
						var_301_3.gameObject:SetActive(false)
					end
				end
			end

			local var_301_4 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				var_301_2.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_298_1.time_ - 0) / var_301_4)
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				var_301_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_301_5 = 0
			local var_301_6 = 0.2

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:GetWordFromCfg(423051072)
				local var_301_8 = arg_298_1:FormatText(var_301_7.content)

				arg_298_1.text_.text = var_301_8

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 8 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_8) / 8)

				if (8 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_8) / 8)) > 0 and var_301_6 < var_301_10 then
					arg_298_1.talkMaxDuration = var_301_10

					if var_301_10 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_8
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051072", "story_v_out_423051.awb") ~= 0 then
					local var_301_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051072", "story_v_out_423051.awb") / 1000

					if var_301_11 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_11 + var_301_5
					end

					if var_301_7.prefab_name ~= "" and arg_298_1.actors_[var_301_7.prefab_name] ~= nil then
						local var_301_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_7.prefab_name].transform, "story_v_out_423051", "423051072", "story_v_out_423051.awb")

						arg_298_1:RecordAudio("423051072", var_301_12)
						arg_298_1:RecordAudio("423051072", var_301_12)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_423051", "423051072", "story_v_out_423051.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_423051", "423051072", "story_v_out_423051.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_13 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_13 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_13

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_13 and arg_298_1.time_ < var_301_5 + var_301_13 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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

		arg_298_1:InitPlayNodeList()
	end,
	Play423051073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 423051073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play423051074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1083"]) and arg_302_1.var_.actorSpriteComps1083 == nil then
				arg_302_1.var_.actorSpriteComps1083 = arg_302_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1083"]) then
				if arg_302_1.var_.actorSpriteComps1083 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1083"]) and arg_302_1.var_.actorSpriteComps1083 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps1083 = nil
			end

			local var_305_2 = 0
			local var_305_3 = 0.175

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_4 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(423051073).content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_6 = 7 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 7)

				if (7 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 7)) > 0 and var_305_3 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_7 and arg_302_1.time_ < var_305_2 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play423051074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 423051074
		arg_306_1.duration_ = 5.1

		local var_306_0 = {
			zh = 5.1,
			ja = 3.966
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play423051075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1083"]) and arg_306_1.var_.actorSpriteComps1083 == nil then
				arg_306_1.var_.actorSpriteComps1083 = arg_306_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1083"]) then
				if arg_306_1.var_.actorSpriteComps1083 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1083"]) and arg_306_1.var_.actorSpriteComps1083 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps1083 = nil
			end

			local var_309_2 = arg_306_1.actors_["1083"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1083 = var_309_2.localPosition
				var_309_2.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1083", 3)

				for iter_309_4 = 0, var_309_2.childCount - 1 do
					local var_309_3 = var_309_2:GetChild(iter_309_4)

					if var_309_3.name == "" or not string.find(var_309_3.name, "split") then
						var_309_3.gameObject:SetActive(true)
					else
						var_309_3.gameObject:SetActive(false)
					end
				end
			end

			local var_309_4 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				var_309_2.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_306_1.time_ - 0) / var_309_4)
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				var_309_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_309_5 = 0
			local var_309_6 = 0.65

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(423051074)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 26 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 26)

				if (26 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 26)) > 0 and var_309_6 < var_309_10 then
					arg_306_1.talkMaxDuration = var_309_10

					if var_309_10 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_5
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051074", "story_v_out_423051.awb") ~= 0 then
					local var_309_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051074", "story_v_out_423051.awb") / 1000

					if var_309_11 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_5
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_423051", "423051074", "story_v_out_423051.awb")

						arg_306_1:RecordAudio("423051074", var_309_12)
						arg_306_1:RecordAudio("423051074", var_309_12)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_423051", "423051074", "story_v_out_423051.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_423051", "423051074", "story_v_out_423051.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_6, arg_306_1.talkMaxDuration)

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_5) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_5 + var_309_13 and arg_306_1.time_ < var_309_5 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play423051075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 423051075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play423051076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1083"]) and arg_310_1.var_.actorSpriteComps1083 == nil then
				arg_310_1.var_.actorSpriteComps1083 = arg_310_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1083"]) then
				if arg_310_1.var_.actorSpriteComps1083 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1083"]) and arg_310_1.var_.actorSpriteComps1083 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps1083 = nil
			end

			local var_313_2 = 0
			local var_313_3 = 1.25

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_4 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(423051075).content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 50 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 50)

				if (50 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 50)) > 0 and var_313_3 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_7 and arg_310_1.time_ < var_313_2 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play423051076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 423051076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play423051077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.825

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(423051076).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 33 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 33)

				if (33 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 33)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play423051077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 423051077
		arg_318_1.duration_ = 7.1

		local var_318_0 = {
			zh = 5.9,
			ja = 7.1
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play423051078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1083"]) and arg_318_1.var_.actorSpriteComps1083 == nil then
				arg_318_1.var_.actorSpriteComps1083 = arg_318_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1083"]) then
				if arg_318_1.var_.actorSpriteComps1083 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 1, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1083"]) and arg_318_1.var_.actorSpriteComps1083 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_318_1.var_.actorSpriteComps1083 = nil
			end

			local var_321_2 = arg_318_1.actors_["1083"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1083 = var_321_2.localPosition
				var_321_2.localScale = Vector3.New(1, 1, 1)

				arg_318_1:CheckSpriteTmpPos("1083", 3)

				for iter_321_4 = 0, var_321_2.childCount - 1 do
					local var_321_3 = var_321_2:GetChild(iter_321_4)

					if var_321_3.name == "split_7" or not string.find(var_321_3.name, "split") then
						var_321_3.gameObject:SetActive(true)
					else
						var_321_3.gameObject:SetActive(false)
					end
				end
			end

			local var_321_4 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				var_321_2.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_318_1.time_ - 0) / var_321_4)
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				var_321_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_321_5 = 0
			local var_321_6 = 0.7

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_7 = arg_318_1:GetWordFromCfg(423051077)
				local var_321_8 = arg_318_1:FormatText(var_321_7.content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 28 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 28)

				if (28 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 28)) > 0 and var_321_6 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_5
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051077", "story_v_out_423051.awb") ~= 0 then
					local var_321_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051077", "story_v_out_423051.awb") / 1000

					if var_321_11 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_5
					end

					if var_321_7.prefab_name ~= "" and arg_318_1.actors_[var_321_7.prefab_name] ~= nil then
						local var_321_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_7.prefab_name].transform, "story_v_out_423051", "423051077", "story_v_out_423051.awb")

						arg_318_1:RecordAudio("423051077", var_321_12)
						arg_318_1:RecordAudio("423051077", var_321_12)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_423051", "423051077", "story_v_out_423051.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_423051", "423051077", "story_v_out_423051.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_13 = math.max(var_321_6, arg_318_1.talkMaxDuration)

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_13 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_5) / var_321_13

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_5 + var_321_13 and arg_318_1.time_ < var_321_5 + var_321_13 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
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

		arg_318_1:InitPlayNodeList()
	end,
	Play423051078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 423051078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play423051079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1083"]) and arg_322_1.var_.actorSpriteComps1083 == nil then
				arg_322_1.var_.actorSpriteComps1083 = arg_322_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1083"]) then
				if arg_322_1.var_.actorSpriteComps1083 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1083"]) and arg_322_1.var_.actorSpriteComps1083 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps1083 = nil
			end

			local var_325_2 = 0
			local var_325_3 = 1.25

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(423051078).content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 50 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 50)

				if (50 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 50)) > 0 and var_325_3 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_7 and arg_322_1.time_ < var_325_2 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play423051079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 423051079
		arg_326_1.duration_ = 8.7

		local var_326_0 = {
			zh = 7.866,
			ja = 8.7
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play423051080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1083"]) and arg_326_1.var_.actorSpriteComps1083 == nil then
				arg_326_1.var_.actorSpriteComps1083 = arg_326_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1083"]) then
				if arg_326_1.var_.actorSpriteComps1083 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 1, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1083"]) and arg_326_1.var_.actorSpriteComps1083 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_326_1.var_.actorSpriteComps1083 = nil
			end

			local var_329_2 = arg_326_1.actors_["1083"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1083 = var_329_2.localPosition
				var_329_2.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("1083", 3)

				for iter_329_4 = 0, var_329_2.childCount - 1 do
					local var_329_3 = var_329_2:GetChild(iter_329_4)

					if var_329_3.name == "" or not string.find(var_329_3.name, "split") then
						var_329_3.gameObject:SetActive(true)
					else
						var_329_3.gameObject:SetActive(false)
					end
				end
			end

			local var_329_4 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				var_329_2.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_326_1.time_ - 0) / var_329_4)
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				var_329_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_329_5 = 0
			local var_329_6 = 0.95

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_7 = arg_326_1:GetWordFromCfg(423051079)
				local var_329_8 = arg_326_1:FormatText(var_329_7.content)

				arg_326_1.text_.text = var_329_8

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_10 = 38 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 38)

				if (38 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 38)) > 0 and var_329_6 < var_329_10 then
					arg_326_1.talkMaxDuration = var_329_10

					if var_329_10 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_5
					end
				end

				arg_326_1.text_.text = var_329_8
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051079", "story_v_out_423051.awb") ~= 0 then
					local var_329_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051079", "story_v_out_423051.awb") / 1000

					if var_329_11 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_5
					end

					if var_329_7.prefab_name ~= "" and arg_326_1.actors_[var_329_7.prefab_name] ~= nil then
						local var_329_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_7.prefab_name].transform, "story_v_out_423051", "423051079", "story_v_out_423051.awb")

						arg_326_1:RecordAudio("423051079", var_329_12)
						arg_326_1:RecordAudio("423051079", var_329_12)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_423051", "423051079", "story_v_out_423051.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_423051", "423051079", "story_v_out_423051.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_6, arg_326_1.talkMaxDuration)

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_5) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_5 + var_329_13 and arg_326_1.time_ < var_329_5 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play423051080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 423051080
		arg_330_1.duration_ = 13

		local var_330_0 = {
			zh = 10.266,
			ja = 13
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play423051081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 1.3

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:GetWordFromCfg(423051080)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 52 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 52)

				if (52 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 52)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051080", "story_v_out_423051.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051080", "story_v_out_423051.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_423051", "423051080", "story_v_out_423051.awb")

						arg_330_1:RecordAudio("423051080", var_333_6)
						arg_330_1:RecordAudio("423051080", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_423051", "423051080", "story_v_out_423051.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_423051", "423051080", "story_v_out_423051.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play423051081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 423051081
		arg_334_1.duration_ = 6.17

		local var_334_0 = {
			zh = 6.166,
			ja = 6.133
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play423051082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1083 = arg_334_1.actors_["1083"].transform.localPosition
				arg_334_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("1083", 3)

				for iter_337_0 = 0, arg_334_1.actors_["1083"].transform.childCount - 1 do
					local var_337_0 = arg_334_1.actors_["1083"].transform:GetChild(iter_337_0)

					if var_337_0.name == "" or not string.find(var_337_0.name, "split") then
						var_337_0.gameObject:SetActive(true)
					else
						var_337_0.gameObject:SetActive(false)
					end
				end
			end

			local var_337_1 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_334_1.time_ - 0) / var_337_1)
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_337_2 = 0
			local var_337_3 = 0.775

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:GetWordFromCfg(423051081)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_7 = 31 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 31)

				if (31 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 31)) > 0 and var_337_3 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051081", "story_v_out_423051.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051081", "story_v_out_423051.awb") / 1000

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end

					if var_337_4.prefab_name ~= "" and arg_334_1.actors_[var_337_4.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_4.prefab_name].transform, "story_v_out_423051", "423051081", "story_v_out_423051.awb")

						arg_334_1:RecordAudio("423051081", var_337_9)
						arg_334_1:RecordAudio("423051081", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_423051", "423051081", "story_v_out_423051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_423051", "423051081", "story_v_out_423051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_10 and arg_334_1.time_ < var_337_2 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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

		arg_334_1:InitPlayNodeList()
	end,
	Play423051082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 423051082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play423051083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1083"]) and arg_338_1.var_.actorSpriteComps1083 == nil then
				arg_338_1.var_.actorSpriteComps1083 = arg_338_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1083"]) then
				if arg_338_1.var_.actorSpriteComps1083 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor2.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor2.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor2.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 0.5, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1083"]) and arg_338_1.var_.actorSpriteComps1083 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_338_1.var_.actorSpriteComps1083 = nil
			end

			local var_341_2 = 0
			local var_341_3 = 1.2

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_4 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(423051082).content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_6 = 48 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 48)

				if (48 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_4) / 48)) > 0 and var_341_3 < var_341_6 then
					arg_338_1.talkMaxDuration = var_341_6

					if var_341_6 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_7 and arg_338_1.time_ < var_341_2 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play423051083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 423051083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play423051084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 1.55

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(423051083).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 62 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 62)

				if (62 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 62)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play423051084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 423051084
		arg_346_1.duration_ = 7.47

		local var_346_0 = {
			zh = 7.466,
			ja = 7.366
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play423051085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1083"]) and arg_346_1.var_.actorSpriteComps1083 == nil then
				arg_346_1.var_.actorSpriteComps1083 = arg_346_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1083"]) then
				if arg_346_1.var_.actorSpriteComps1083 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1083"]) and arg_346_1.var_.actorSpriteComps1083 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1083 = nil
			end

			local var_349_2 = arg_346_1.actors_["1083"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1083 = var_349_2.localPosition
				var_349_2.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1083", 3)

				for iter_349_4 = 0, var_349_2.childCount - 1 do
					local var_349_3 = var_349_2:GetChild(iter_349_4)

					if var_349_3.name == "split_2" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_346_1.time_ - 0) / var_349_4)
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_349_5 = 0
			local var_349_6 = 0.875

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(423051084)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 35 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 35)

				if (35 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 35)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051084", "story_v_out_423051.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051084", "story_v_out_423051.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_423051", "423051084", "story_v_out_423051.awb")

						arg_346_1:RecordAudio("423051084", var_349_12)
						arg_346_1:RecordAudio("423051084", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_423051", "423051084", "story_v_out_423051.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_423051", "423051084", "story_v_out_423051.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
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

		arg_346_1:InitPlayNodeList()
	end,
	Play423051085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 423051085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play423051086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1083"]) and arg_350_1.var_.actorSpriteComps1083 == nil then
				arg_350_1.var_.actorSpriteComps1083 = arg_350_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1083"]) then
				if arg_350_1.var_.actorSpriteComps1083 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1083"]) and arg_350_1.var_.actorSpriteComps1083 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps1083 = nil
			end

			local var_353_2 = arg_350_1.actors_["1083"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1083 = var_353_2.localPosition
				var_353_2.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("1083", 7)

				for iter_353_4 = 0, var_353_2.childCount - 1 do
					local var_353_3 = var_353_2:GetChild(iter_353_4)

					if var_353_3.name == "" or not string.find(var_353_3.name, "split") then
						var_353_3.gameObject:SetActive(true)
					else
						var_353_3.gameObject:SetActive(false)
					end
				end
			end

			local var_353_4 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_2.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_350_1.time_ - 0) / var_353_4)
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_353_5 = 0
			local var_353_6 = 1.825

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(423051085).content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 73 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_7) / 73)

				if (73 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_7) / 73)) > 0 and var_353_6 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_10 and arg_350_1.time_ < var_353_5 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
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

		arg_350_1:InitPlayNodeList()
	end,
	Play423051086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 423051086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play423051087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 1.625

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(423051086).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 65 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 65)

				if (65 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 65)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play423051087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 423051087
		arg_358_1.duration_ = 4.03

		local var_358_0 = {
			zh = 4.033,
			ja = 3.766
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play423051088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["10148"]) and arg_358_1.var_.actorSpriteComps10148 == nil then
				arg_358_1.var_.actorSpriteComps10148 = arg_358_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["10148"]) then
				if arg_358_1.var_.actorSpriteComps10148 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 1, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["10148"]) and arg_358_1.var_.actorSpriteComps10148 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps10148 = nil
			end

			local var_361_2 = arg_358_1.actors_["10148"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10148 = var_361_2.localPosition
				var_361_2.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10148", 2)

				for iter_361_4 = 0, var_361_2.childCount - 1 do
					local var_361_3 = var_361_2:GetChild(iter_361_4)

					if var_361_3.name == "split_4" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_2.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_358_1.time_ - 0) / var_361_4)
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_2.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_361_5 = 0
			local var_361_6 = 0.525

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:GetWordFromCfg(423051087)
				local var_361_8 = arg_358_1:FormatText(var_361_7.content)

				arg_358_1.text_.text = var_361_8

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_10 = 21 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_8) / 21)

				if (21 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_8) / 21)) > 0 and var_361_6 < var_361_10 then
					arg_358_1.talkMaxDuration = var_361_10

					if var_361_10 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_10 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_8
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051087", "story_v_out_423051.awb") ~= 0 then
					local var_361_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051087", "story_v_out_423051.awb") / 1000

					if var_361_11 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_11 + var_361_5
					end

					if var_361_7.prefab_name ~= "" and arg_358_1.actors_[var_361_7.prefab_name] ~= nil then
						local var_361_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_7.prefab_name].transform, "story_v_out_423051", "423051087", "story_v_out_423051.awb")

						arg_358_1:RecordAudio("423051087", var_361_12)
						arg_358_1:RecordAudio("423051087", var_361_12)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_423051", "423051087", "story_v_out_423051.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_423051", "423051087", "story_v_out_423051.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_13 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_13 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_13

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_13 and arg_358_1.time_ < var_361_5 + var_361_13 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play423051088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 423051088
		arg_362_1.duration_ = 8.03

		local var_362_0 = {
			zh = 7,
			ja = 8.033
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play423051089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1083"]) and arg_362_1.var_.actorSpriteComps1083 == nil then
				arg_362_1.var_.actorSpriteComps1083 = arg_362_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1083"]) then
				if arg_362_1.var_.actorSpriteComps1083 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1083"]) and arg_362_1.var_.actorSpriteComps1083 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps1083 = nil
			end

			local var_365_2 = arg_362_1.actors_["10148"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps10148 == nil then
				arg_362_1.var_.actorSpriteComps10148 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps10148 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								iter_365_5.color = Color.New(Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, (arg_362_1.time_ - 0) / var_365_3), Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, (arg_362_1.time_ - 0) / var_365_3), (Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, (arg_362_1.time_ - 0) / var_365_3)))
							else
								local var_365_4 = Mathf.Lerp(iter_365_5.color.r, 0.5, (arg_362_1.time_ - 0) / var_365_3)

								iter_365_5.color = Color.New(var_365_4, var_365_4, var_365_4)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps10148 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps10148 = nil
			end

			local var_365_5 = arg_362_1.actors_["1083"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1083 = var_365_5.localPosition
				var_365_5.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1083", 4)

				for iter_365_8 = 0, var_365_5.childCount - 1 do
					local var_365_6 = var_365_5:GetChild(iter_365_8)

					if var_365_6.name == "" or not string.find(var_365_6.name, "split") then
						var_365_6.gameObject:SetActive(true)
					else
						var_365_6.gameObject:SetActive(false)
					end
				end
			end

			local var_365_7 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				var_365_5.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_362_1.time_ - 0) / var_365_7)
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				var_365_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_365_8 = 0
			local var_365_9 = 0.75

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:GetWordFromCfg(423051088)
				local var_365_11 = arg_362_1:FormatText(var_365_10.content)

				arg_362_1.text_.text = var_365_11

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_13 = 30 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 30)

				if (30 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 30)) > 0 and var_365_9 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_8
					end
				end

				arg_362_1.text_.text = var_365_11
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051088", "story_v_out_423051.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051088", "story_v_out_423051.awb") / 1000

					if var_365_14 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_8
					end

					if var_365_10.prefab_name ~= "" and arg_362_1.actors_[var_365_10.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_10.prefab_name].transform, "story_v_out_423051", "423051088", "story_v_out_423051.awb")

						arg_362_1:RecordAudio("423051088", var_365_15)
						arg_362_1:RecordAudio("423051088", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_423051", "423051088", "story_v_out_423051.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_423051", "423051088", "story_v_out_423051.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_9, arg_362_1.talkMaxDuration)

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_8) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_8 + var_365_16 and arg_362_1.time_ < var_365_8 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play423051089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 423051089
		arg_366_1.duration_ = 8.83

		local var_366_0 = {
			zh = 8.833,
			ja = 8.166
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play423051090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10148"]) and arg_366_1.var_.actorSpriteComps10148 == nil then
				arg_366_1.var_.actorSpriteComps10148 = arg_366_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10148"]) then
				if arg_366_1.var_.actorSpriteComps10148 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor1.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor1.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor1.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 1, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10148"]) and arg_366_1.var_.actorSpriteComps10148 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps10148 = nil
			end

			local var_369_2 = arg_366_1.actors_["1083"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1083 == nil then
				arg_366_1.var_.actorSpriteComps1083 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps1083 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								iter_369_5.color = Color.New(Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_5.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_5.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps1083 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_369_7 then
						iter_369_7.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps1083 = nil
			end

			local var_369_5 = arg_366_1.actors_["10148"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10148 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10148", 2)

				for iter_369_8 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_8)

					if var_369_6.name == "" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_369_8 = 0
			local var_369_9 = 1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(423051089)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 40 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 40)

				if (40 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 40)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051089", "story_v_out_423051.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051089", "story_v_out_423051.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_423051", "423051089", "story_v_out_423051.awb")

						arg_366_1:RecordAudio("423051089", var_369_15)
						arg_366_1:RecordAudio("423051089", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_423051", "423051089", "story_v_out_423051.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_423051", "423051089", "story_v_out_423051.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
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

		arg_366_1:InitPlayNodeList()
	end,
	Play423051090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 423051090
		arg_370_1.duration_ = 12.8

		local var_370_0 = {
			zh = 7.3,
			ja = 12.8
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play423051091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1083"]) and arg_370_1.var_.actorSpriteComps1083 == nil then
				arg_370_1.var_.actorSpriteComps1083 = arg_370_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1083"]) then
				if arg_370_1.var_.actorSpriteComps1083 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1083"]) and arg_370_1.var_.actorSpriteComps1083 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps1083 = nil
			end

			local var_373_2 = arg_370_1.actors_["10148"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10148 == nil then
				arg_370_1.var_.actorSpriteComps10148 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps10148 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								iter_373_5.color = Color.New(Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, (arg_370_1.time_ - 0) / var_373_3), Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, (arg_370_1.time_ - 0) / var_373_3), (Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, (arg_370_1.time_ - 0) / var_373_3)))
							else
								local var_373_4 = Mathf.Lerp(iter_373_5.color.r, 0.5, (arg_370_1.time_ - 0) / var_373_3)

								iter_373_5.color = Color.New(var_373_4, var_373_4, var_373_4)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10148 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps10148 = nil
			end

			local var_373_5 = arg_370_1.actors_["1083"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1083 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1083", 4)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "" or not string.find(var_373_6.name, "split") then
						var_373_6.gameObject:SetActive(true)
					else
						var_373_6.gameObject:SetActive(false)
					end
				end
			end

			local var_373_7 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_370_1.time_ - 0) / var_373_7)
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_373_8 = 0
			local var_373_9 = 0.875

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_8 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_10 = arg_370_1:GetWordFromCfg(423051090)
				local var_373_11 = arg_370_1:FormatText(var_373_10.content)

				arg_370_1.text_.text = var_373_11

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_13 = 35 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_11) / 35)

				if (35 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_11) / 35)) > 0 and var_373_9 < var_373_13 then
					arg_370_1.talkMaxDuration = var_373_13

					if var_373_13 + var_373_8 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_13 + var_373_8
					end
				end

				arg_370_1.text_.text = var_373_11
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051090", "story_v_out_423051.awb") ~= 0 then
					local var_373_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051090", "story_v_out_423051.awb") / 1000

					if var_373_14 + var_373_8 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_14 + var_373_8
					end

					if var_373_10.prefab_name ~= "" and arg_370_1.actors_[var_373_10.prefab_name] ~= nil then
						local var_373_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_10.prefab_name].transform, "story_v_out_423051", "423051090", "story_v_out_423051.awb")

						arg_370_1:RecordAudio("423051090", var_373_15)
						arg_370_1:RecordAudio("423051090", var_373_15)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_423051", "423051090", "story_v_out_423051.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_423051", "423051090", "story_v_out_423051.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_16 = math.max(var_373_9, arg_370_1.talkMaxDuration)

			if var_373_8 <= arg_370_1.time_ and arg_370_1.time_ < var_373_8 + var_373_16 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_8) / var_373_16

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_8 + var_373_16 and arg_370_1.time_ < var_373_8 + var_373_16 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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

		arg_370_1:InitPlayNodeList()
	end,
	Play423051091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 423051091
		arg_374_1.duration_ = 8.9

		local var_374_0 = {
			zh = 8.9,
			ja = 8.566
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play423051092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10148"]) and arg_374_1.var_.actorSpriteComps10148 == nil then
				arg_374_1.var_.actorSpriteComps10148 = arg_374_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10148"]) then
				if arg_374_1.var_.actorSpriteComps10148 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor1.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor1.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor1.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 1, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10148"]) and arg_374_1.var_.actorSpriteComps10148 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps10148 = nil
			end

			local var_377_2 = arg_374_1.actors_["1083"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1083 == nil then
				arg_374_1.var_.actorSpriteComps1083 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps1083 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								iter_377_5.color = Color.New(Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_3), Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_3), (Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_3)))
							else
								local var_377_4 = Mathf.Lerp(iter_377_5.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_3)

								iter_377_5.color = Color.New(var_377_4, var_377_4, var_377_4)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1083 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps1083 = nil
			end

			local var_377_5 = arg_374_1.actors_["10148"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos10148 = var_377_5.localPosition
				var_377_5.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10148", 2)

				for iter_377_8 = 0, var_377_5.childCount - 1 do
					local var_377_6 = var_377_5:GetChild(iter_377_8)

					if var_377_6.name == "split_4" or not string.find(var_377_6.name, "split") then
						var_377_6.gameObject:SetActive(true)
					else
						var_377_6.gameObject:SetActive(false)
					end
				end
			end

			local var_377_7 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				var_377_5.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_374_1.time_ - 0) / var_377_7)
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				var_377_5.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_377_8 = 0
			local var_377_9 = 1.1

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_8 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_10 = arg_374_1:GetWordFromCfg(423051091)
				local var_377_11 = arg_374_1:FormatText(var_377_10.content)

				arg_374_1.text_.text = var_377_11

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_13 = 44 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 44)

				if (44 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 44)) > 0 and var_377_9 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_8
					end
				end

				arg_374_1.text_.text = var_377_11
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051091", "story_v_out_423051.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051091", "story_v_out_423051.awb") / 1000

					if var_377_14 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_8
					end

					if var_377_10.prefab_name ~= "" and arg_374_1.actors_[var_377_10.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_10.prefab_name].transform, "story_v_out_423051", "423051091", "story_v_out_423051.awb")

						arg_374_1:RecordAudio("423051091", var_377_15)
						arg_374_1:RecordAudio("423051091", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_423051", "423051091", "story_v_out_423051.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_423051", "423051091", "story_v_out_423051.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_9, arg_374_1.talkMaxDuration)

			if var_377_8 <= arg_374_1.time_ and arg_374_1.time_ < var_377_8 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_8) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_8 + var_377_16 and arg_374_1.time_ < var_377_8 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play423051092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 423051092
		arg_378_1.duration_ = 9.4

		local var_378_0 = {
			zh = 7.266,
			ja = 9.4
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play423051093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.975

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(423051092)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 39 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 39)

				if (39 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 39)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051092", "story_v_out_423051.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_423051", "423051092", "story_v_out_423051.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_423051", "423051092", "story_v_out_423051.awb")

						arg_378_1:RecordAudio("423051092", var_381_6)
						arg_378_1:RecordAudio("423051092", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_423051", "423051092", "story_v_out_423051.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_423051", "423051092", "story_v_out_423051.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play423051093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 423051093
		arg_382_1.duration_ = 12

		local var_382_0 = {
			zh = 7.5,
			ja = 12
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play423051094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1083"]) and arg_382_1.var_.actorSpriteComps1083 == nil then
				arg_382_1.var_.actorSpriteComps1083 = arg_382_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1083"]) then
				if arg_382_1.var_.actorSpriteComps1083 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								iter_385_1.color = Color.New(Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, (arg_382_1.time_ - 0) / var_385_0), Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, (arg_382_1.time_ - 0) / var_385_0), (Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, (arg_382_1.time_ - 0) / var_385_0)))
							else
								local var_385_1 = Mathf.Lerp(iter_385_1.color.r, 1, (arg_382_1.time_ - 0) / var_385_0)

								iter_385_1.color = Color.New(var_385_1, var_385_1, var_385_1)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1083"]) and arg_382_1.var_.actorSpriteComps1083 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps1083 = nil
			end

			local var_385_2 = arg_382_1.actors_["10148"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps10148 == nil then
				arg_382_1.var_.actorSpriteComps10148 = var_385_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_3 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.actorSpriteComps10148 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								iter_385_5.color = Color.New(Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, (arg_382_1.time_ - 0) / var_385_3), Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, (arg_382_1.time_ - 0) / var_385_3), (Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, (arg_382_1.time_ - 0) / var_385_3)))
							else
								local var_385_4 = Mathf.Lerp(iter_385_5.color.r, 0.5, (arg_382_1.time_ - 0) / var_385_3)

								iter_385_5.color = Color.New(var_385_4, var_385_4, var_385_4)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.actorSpriteComps10148 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_385_7 then
						iter_385_7.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_382_1.var_.actorSpriteComps10148 = nil
			end

			local var_385_5 = arg_382_1.actors_["1083"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1083 = var_385_5.localPosition
				var_385_5.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1083", 4)

				for iter_385_8 = 0, var_385_5.childCount - 1 do
					local var_385_6 = var_385_5:GetChild(iter_385_8)

					if var_385_6.name == "" or not string.find(var_385_6.name, "split") then
						var_385_6.gameObject:SetActive(true)
					else
						var_385_6.gameObject:SetActive(false)
					end
				end
			end

			local var_385_7 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				var_385_5.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_382_1.time_ - 0) / var_385_7)
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				var_385_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_385_8 = 0
			local var_385_9 = 0.825

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_8 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_10 = arg_382_1:GetWordFromCfg(423051093)
				local var_385_11 = arg_382_1:FormatText(var_385_10.content)

				arg_382_1.text_.text = var_385_11

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_13 = 33 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_11) / 33)

				if (33 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_11) / 33)) > 0 and var_385_9 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_8
					end
				end

				arg_382_1.text_.text = var_385_11
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051093", "story_v_out_423051.awb") ~= 0 then
					local var_385_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051093", "story_v_out_423051.awb") / 1000

					if var_385_14 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_14 + var_385_8
					end

					if var_385_10.prefab_name ~= "" and arg_382_1.actors_[var_385_10.prefab_name] ~= nil then
						local var_385_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_10.prefab_name].transform, "story_v_out_423051", "423051093", "story_v_out_423051.awb")

						arg_382_1:RecordAudio("423051093", var_385_15)
						arg_382_1:RecordAudio("423051093", var_385_15)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_423051", "423051093", "story_v_out_423051.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_423051", "423051093", "story_v_out_423051.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_9, arg_382_1.talkMaxDuration)

			if var_385_8 <= arg_382_1.time_ and arg_382_1.time_ < var_385_8 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_8) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_8 + var_385_16 and arg_382_1.time_ < var_385_8 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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

		arg_382_1:InitPlayNodeList()
	end,
	Play423051094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 423051094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play423051095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1083"]) and arg_386_1.var_.actorSpriteComps1083 == nil then
				arg_386_1.var_.actorSpriteComps1083 = arg_386_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_0 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1083"]) then
				if arg_386_1.var_.actorSpriteComps1083 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								iter_389_1.color = Color.New(Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, (arg_386_1.time_ - 0) / var_389_0), Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, (arg_386_1.time_ - 0) / var_389_0), (Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, (arg_386_1.time_ - 0) / var_389_0)))
							else
								local var_389_1 = Mathf.Lerp(iter_389_1.color.r, 0.5, (arg_386_1.time_ - 0) / var_389_0)

								iter_389_1.color = Color.New(var_389_1, var_389_1, var_389_1)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1083"]) and arg_386_1.var_.actorSpriteComps1083 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_389_3 then
						iter_389_3.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_386_1.var_.actorSpriteComps1083 = nil
			end

			local var_389_2 = 0
			local var_389_3 = 0.125

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_4 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(423051094).content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_6 = 5 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_4) / 5)

				if (5 <= 0 and var_389_3 or var_389_3 * (utf8.len(var_389_4) / 5)) > 0 and var_389_3 < var_389_6 then
					arg_386_1.talkMaxDuration = var_389_6

					if var_389_6 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_7 and arg_386_1.time_ < var_389_2 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play423051095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 423051095
		arg_390_1.duration_ = 5.9

		local var_390_0 = {
			zh = 4.666,
			ja = 5.9
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play423051096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["10148"]) and arg_390_1.var_.actorSpriteComps10148 == nil then
				arg_390_1.var_.actorSpriteComps10148 = arg_390_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["10148"]) then
				if arg_390_1.var_.actorSpriteComps10148 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								iter_393_1.color = Color.New(Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, (arg_390_1.time_ - 0) / var_393_0), Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, (arg_390_1.time_ - 0) / var_393_0), (Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, (arg_390_1.time_ - 0) / var_393_0)))
							else
								local var_393_1 = Mathf.Lerp(iter_393_1.color.r, 1, (arg_390_1.time_ - 0) / var_393_0)

								iter_393_1.color = Color.New(var_393_1, var_393_1, var_393_1)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["10148"]) and arg_390_1.var_.actorSpriteComps10148 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps10148 = nil
			end

			local var_393_2 = arg_390_1.actors_["10148"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos10148 = var_393_2.localPosition
				var_393_2.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10148", 2)

				for iter_393_4 = 0, var_393_2.childCount - 1 do
					local var_393_3 = var_393_2:GetChild(iter_393_4)

					if var_393_3.name == "split_6" or not string.find(var_393_3.name, "split") then
						var_393_3.gameObject:SetActive(true)
					else
						var_393_3.gameObject:SetActive(false)
					end
				end
			end

			local var_393_4 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				var_393_2.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_390_1.time_ - 0) / var_393_4)
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				var_393_2.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_393_5 = 0
			local var_393_6 = 0.55

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_7 = arg_390_1:GetWordFromCfg(423051095)
				local var_393_8 = arg_390_1:FormatText(var_393_7.content)

				arg_390_1.text_.text = var_393_8

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_10 = 22 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 22)

				if (22 <= 0 and var_393_6 or var_393_6 * (utf8.len(var_393_8) / 22)) > 0 and var_393_6 < var_393_10 then
					arg_390_1.talkMaxDuration = var_393_10

					if var_393_10 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_5
					end
				end

				arg_390_1.text_.text = var_393_8
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051095", "story_v_out_423051.awb") ~= 0 then
					local var_393_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051095", "story_v_out_423051.awb") / 1000

					if var_393_11 + var_393_5 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_11 + var_393_5
					end

					if var_393_7.prefab_name ~= "" and arg_390_1.actors_[var_393_7.prefab_name] ~= nil then
						local var_393_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_7.prefab_name].transform, "story_v_out_423051", "423051095", "story_v_out_423051.awb")

						arg_390_1:RecordAudio("423051095", var_393_12)
						arg_390_1:RecordAudio("423051095", var_393_12)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_423051", "423051095", "story_v_out_423051.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_423051", "423051095", "story_v_out_423051.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_13 = math.max(var_393_6, arg_390_1.talkMaxDuration)

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_13 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_5) / var_393_13

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_5 + var_393_13 and arg_390_1.time_ < var_393_5 + var_393_13 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
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

		arg_390_1:InitPlayNodeList()
	end,
	Play423051096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 423051096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play423051097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["10148"]) and arg_394_1.var_.actorSpriteComps10148 == nil then
				arg_394_1.var_.actorSpriteComps10148 = arg_394_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["10148"]) then
				if arg_394_1.var_.actorSpriteComps10148 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["10148"]) and arg_394_1.var_.actorSpriteComps10148 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps10148 = nil
			end

			local var_397_2 = 0
			local var_397_3 = 0.375

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_2 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_4 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(423051096).content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_6 = 15 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_4) / 15)

				if (15 <= 0 and var_397_3 or var_397_3 * (utf8.len(var_397_4) / 15)) > 0 and var_397_3 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_2 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_2
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_3, arg_394_1.talkMaxDuration)

			if var_397_2 <= arg_394_1.time_ and arg_394_1.time_ < var_397_2 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_2) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_2 + var_397_7 and arg_394_1.time_ < var_397_2 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play423051097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 423051097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play423051098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.15

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(423051097).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 46 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 46)

				if (46 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 46)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play423051098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 423051098
		arg_402_1.duration_ = 10.1

		local var_402_0 = {
			zh = 8.966,
			ja = 10.1
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play423051099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10148"]) and arg_402_1.var_.actorSpriteComps10148 == nil then
				arg_402_1.var_.actorSpriteComps10148 = arg_402_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10148"]) then
				if arg_402_1.var_.actorSpriteComps10148 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor1.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor1.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor1.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 1, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10148"]) and arg_402_1.var_.actorSpriteComps10148 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_402_1.var_.actorSpriteComps10148 = nil
			end

			local var_405_2 = arg_402_1.actors_["10148"].transform

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos10148 = var_405_2.localPosition
				var_405_2.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10148", 2)

				for iter_405_4 = 0, var_405_2.childCount - 1 do
					local var_405_3 = var_405_2:GetChild(iter_405_4)

					if var_405_3.name == "split_4" or not string.find(var_405_3.name, "split") then
						var_405_3.gameObject:SetActive(true)
					else
						var_405_3.gameObject:SetActive(false)
					end
				end
			end

			local var_405_4 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				var_405_2.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10148, Vector3.New(-390, -350, -270), (arg_402_1.time_ - 0) / var_405_4)
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				var_405_2.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_405_5 = 0
			local var_405_6 = 0.95

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_5 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_7 = arg_402_1:GetWordFromCfg(423051098)
				local var_405_8 = arg_402_1:FormatText(var_405_7.content)

				arg_402_1.text_.text = var_405_8

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_10 = 38 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 38)

				if (38 <= 0 and var_405_6 or var_405_6 * (utf8.len(var_405_8) / 38)) > 0 and var_405_6 < var_405_10 then
					arg_402_1.talkMaxDuration = var_405_10

					if var_405_10 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_5
					end
				end

				arg_402_1.text_.text = var_405_8
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051098", "story_v_out_423051.awb") ~= 0 then
					local var_405_11 = manager.audio:GetVoiceLength("story_v_out_423051", "423051098", "story_v_out_423051.awb") / 1000

					if var_405_11 + var_405_5 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_11 + var_405_5
					end

					if var_405_7.prefab_name ~= "" and arg_402_1.actors_[var_405_7.prefab_name] ~= nil then
						local var_405_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_7.prefab_name].transform, "story_v_out_423051", "423051098", "story_v_out_423051.awb")

						arg_402_1:RecordAudio("423051098", var_405_12)
						arg_402_1:RecordAudio("423051098", var_405_12)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_423051", "423051098", "story_v_out_423051.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_423051", "423051098", "story_v_out_423051.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_13 = math.max(var_405_6, arg_402_1.talkMaxDuration)

			if var_405_5 <= arg_402_1.time_ and arg_402_1.time_ < var_405_5 + var_405_13 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_5) / var_405_13

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_5 + var_405_13 and arg_402_1.time_ < var_405_5 + var_405_13 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
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

		arg_402_1:InitPlayNodeList()
	end,
	Play423051099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 423051099
		arg_406_1.duration_ = 6.67

		local var_406_0 = {
			zh = 4.666,
			ja = 6.666
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play423051100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1083"]) and arg_406_1.var_.actorSpriteComps1083 == nil then
				arg_406_1.var_.actorSpriteComps1083 = arg_406_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_0 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1083"]) then
				if arg_406_1.var_.actorSpriteComps1083 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								iter_409_1.color = Color.New(Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor1.r, (arg_406_1.time_ - 0) / var_409_0), Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor1.g, (arg_406_1.time_ - 0) / var_409_0), (Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor1.b, (arg_406_1.time_ - 0) / var_409_0)))
							else
								local var_409_1 = Mathf.Lerp(iter_409_1.color.r, 1, (arg_406_1.time_ - 0) / var_409_0)

								iter_409_1.color = Color.New(var_409_1, var_409_1, var_409_1)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1083"]) and arg_406_1.var_.actorSpriteComps1083 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_409_3 then
						iter_409_3.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_406_1.var_.actorSpriteComps1083 = nil
			end

			local var_409_2 = arg_406_1.actors_["10148"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps10148 == nil then
				arg_406_1.var_.actorSpriteComps10148 = var_409_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_3 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.actorSpriteComps10148 then
					for iter_409_4, iter_409_5 in pairs(arg_406_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_409_5 then
							if arg_406_1.isInRecall_ then
								iter_409_5.color = Color.New(Mathf.Lerp(iter_409_5.color.r, arg_406_1.hightColor2.r, (arg_406_1.time_ - 0) / var_409_3), Mathf.Lerp(iter_409_5.color.g, arg_406_1.hightColor2.g, (arg_406_1.time_ - 0) / var_409_3), (Mathf.Lerp(iter_409_5.color.b, arg_406_1.hightColor2.b, (arg_406_1.time_ - 0) / var_409_3)))
							else
								local var_409_4 = Mathf.Lerp(iter_409_5.color.r, 0.5, (arg_406_1.time_ - 0) / var_409_3)

								iter_409_5.color = Color.New(var_409_4, var_409_4, var_409_4)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.actorSpriteComps10148 then
				for iter_409_6, iter_409_7 in pairs(arg_406_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_409_7 then
						iter_409_7.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_406_1.var_.actorSpriteComps10148 = nil
			end

			local var_409_5 = arg_406_1.actors_["1083"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1083 = var_409_5.localPosition
				var_409_5.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("1083", 4)

				for iter_409_8 = 0, var_409_5.childCount - 1 do
					local var_409_6 = var_409_5:GetChild(iter_409_8)

					if var_409_6.name == "" or not string.find(var_409_6.name, "split") then
						var_409_6.gameObject:SetActive(true)
					else
						var_409_6.gameObject:SetActive(false)
					end
				end
			end

			local var_409_7 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				var_409_5.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_406_1.time_ - 0) / var_409_7)
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				var_409_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_409_8 = 0
			local var_409_9 = 0.6

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_10 = arg_406_1:GetWordFromCfg(423051099)
				local var_409_11 = arg_406_1:FormatText(var_409_10.content)

				arg_406_1.text_.text = var_409_11

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_13 = 24 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_11) / 24)

				if (24 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_11) / 24)) > 0 and var_409_9 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_8
					end
				end

				arg_406_1.text_.text = var_409_11
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051099", "story_v_out_423051.awb") ~= 0 then
					local var_409_14 = manager.audio:GetVoiceLength("story_v_out_423051", "423051099", "story_v_out_423051.awb") / 1000

					if var_409_14 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_8
					end

					if var_409_10.prefab_name ~= "" and arg_406_1.actors_[var_409_10.prefab_name] ~= nil then
						local var_409_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_10.prefab_name].transform, "story_v_out_423051", "423051099", "story_v_out_423051.awb")

						arg_406_1:RecordAudio("423051099", var_409_15)
						arg_406_1:RecordAudio("423051099", var_409_15)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_423051", "423051099", "story_v_out_423051.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_423051", "423051099", "story_v_out_423051.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_16 = math.max(var_409_9, arg_406_1.talkMaxDuration)

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_16 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_8) / var_409_16

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_8 + var_409_16 and arg_406_1.time_ < var_409_8 + var_409_16 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
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

		arg_406_1:InitPlayNodeList()
	end,
	Play423051100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 423051100
		arg_410_1.duration_ = 6.53

		local var_410_0 = {
			zh = 3.966,
			ja = 6.533
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play423051101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos1083 = arg_410_1.actors_["1083"].transform.localPosition
				arg_410_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("1083", 4)

				for iter_413_0 = 0, arg_410_1.actors_["1083"].transform.childCount - 1 do
					local var_413_0 = arg_410_1.actors_["1083"].transform:GetChild(iter_413_0)

					if var_413_0.name == "" or not string.find(var_413_0.name, "split") then
						var_413_0.gameObject:SetActive(true)
					else
						var_413_0.gameObject:SetActive(false)
					end
				end
			end

			local var_413_1 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_1 then
				arg_410_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_410_1.time_ - 0) / var_413_1)
			end

			if arg_410_1.time_ >= 0 + var_413_1 and arg_410_1.time_ < 0 + var_413_1 + arg_413_0 then
				arg_410_1.actors_["1083"].transform.localPosition = Vector3.New(390, -345, -345)
			end

			local var_413_2 = 0
			local var_413_3 = 0.5

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(423051100)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_7 = 20 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 20)

				if (20 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 20)) > 0 and var_413_3 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_2
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423051", "423051100", "story_v_out_423051.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_423051", "423051100", "story_v_out_423051.awb") / 1000

					if var_413_8 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_2
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_out_423051", "423051100", "story_v_out_423051.awb")

						arg_410_1:RecordAudio("423051100", var_413_9)
						arg_410_1:RecordAudio("423051100", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_423051", "423051100", "story_v_out_423051.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_423051", "423051100", "story_v_out_423051.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_3, arg_410_1.talkMaxDuration)

			if var_413_2 <= arg_410_1.time_ and arg_410_1.time_ < var_413_2 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_2) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_2 + var_413_10 and arg_410_1.time_ < var_413_2 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
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

		arg_410_1:InitPlayNodeList()
	end,
	Play423051101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 423051101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play423051102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1083"]) and arg_414_1.var_.actorSpriteComps1083 == nil then
				arg_414_1.var_.actorSpriteComps1083 = arg_414_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1083"]) then
				if arg_414_1.var_.actorSpriteComps1083 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								iter_417_1.color = Color.New(Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor2.r, (arg_414_1.time_ - 0) / var_417_0), Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor2.g, (arg_414_1.time_ - 0) / var_417_0), (Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor2.b, (arg_414_1.time_ - 0) / var_417_0)))
							else
								local var_417_1 = Mathf.Lerp(iter_417_1.color.r, 0.5, (arg_414_1.time_ - 0) / var_417_0)

								iter_417_1.color = Color.New(var_417_1, var_417_1, var_417_1)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1083"]) and arg_414_1.var_.actorSpriteComps1083 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_417_3 then
						iter_417_3.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_414_1.var_.actorSpriteComps1083 = nil
			end

			local var_417_2 = arg_414_1.actors_["1083"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1083 = var_417_2.localPosition
				var_417_2.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("1083", 7)

				for iter_417_4 = 0, var_417_2.childCount - 1 do
					local var_417_3 = var_417_2:GetChild(iter_417_4)

					if var_417_3.name == "" or not string.find(var_417_3.name, "split") then
						var_417_3.gameObject:SetActive(true)
					else
						var_417_3.gameObject:SetActive(false)
					end
				end
			end

			local var_417_4 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				var_417_2.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_414_1.time_ - 0) / var_417_4)
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				var_417_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_417_5 = arg_414_1.actors_["10148"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos10148 = var_417_5.localPosition
				var_417_5.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("10148", 7)

				for iter_417_5 = 0, var_417_5.childCount - 1 do
					local var_417_6 = var_417_5:GetChild(iter_417_5)

					if var_417_6.name == "" or not string.find(var_417_6.name, "split") then
						var_417_6.gameObject:SetActive(true)
					else
						var_417_6.gameObject:SetActive(false)
					end
				end
			end

			local var_417_7 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				var_417_5.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_414_1.time_ - 0) / var_417_7)
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				var_417_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_chair", "")
			end

			local var_417_9 = 0
			local var_417_10 = 1.05

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_9 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_11 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(423051101).content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 42 <= 0 and var_417_10 or var_417_10 * (utf8.len(var_417_11) / 42)

				if (42 <= 0 and var_417_10 or var_417_10 * (utf8.len(var_417_11) / 42)) > 0 and var_417_10 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_9 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_9
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_10, arg_414_1.talkMaxDuration)

			if var_417_9 <= arg_414_1.time_ and arg_414_1.time_ < var_417_9 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_9) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_9 + var_417_14 and arg_414_1.time_ < var_417_9 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
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

		arg_414_1:InitPlayNodeList()
	end,
	Play423051102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 423051102
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
			arg_418_1.auto_ = false
		end

		function arg_418_1.playNext_(arg_420_0)
			arg_418_1.onStoryFinished_()
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.3

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(423051102).content)

				arg_418_1.text_.text = var_421_1

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_3 = 12 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 12)

				if (12 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_1) / 12)) > 0 and var_421_0 < var_421_3 then
					arg_418_1.talkMaxDuration = var_421_3

					if var_421_3 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_3 + 0
					end
				end

				arg_418_1.text_.text = var_421_1
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_4 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_4 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_4

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_4 and arg_418_1.time_ < 0 + var_421_4 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I26f",
		"TextureConfig/Background/ST0112"
	},
	voices = {
		"story_v_out_423051.awb"
	}
}
