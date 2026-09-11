return {
	Play425131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425131001
		arg_1_1.duration_ = 4

		local var_1_0 = {
			zh = 3.899999999999,
			ja = 4
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
				arg_1_0:Play425131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.D02a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_4_0.name = "D02a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D02a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D02a

				arg_1_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D02a" then
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

			local var_4_9 = "1036"

			if arg_1_1.actors_["1036"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1036")

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

			local var_4_12 = arg_1_1.actors_["1036"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1036 == nil then
				arg_1_1.var_.actorSpriteComps1036 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1036 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1036 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1036 = nil
			end

			local var_4_15 = arg_1_1.actors_["1036"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1036 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1036", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -388, -250)
			end

			if 1.00066666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.00066666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect1001

				if not arg_1_1.var_.effect1001 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_4_18.name = "1001"
					arg_1_1.var_.effect1001 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9000)
				end

				var_4_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 2.86666666666667 + arg_4_0 then
				if arg_1_1.var_.effect1001 then
					Object.Destroy(arg_1_1.var_.effect1001)

					arg_1_1.var_.effect1001 = nil
				end
			end

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_4_27 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			if 1.00066666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.00066666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_147", "se_story_147_screen_tearing_glitch", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_29 = 2
			local var_4_30 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_31 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_31:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_32 = arg_1_1:GetWordFromCfg(425131001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 4 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 4)

				if (4 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 4)) > 0 and var_4_30 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_29 = var_4_29 + 0.3

					if var_4_35 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_29
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131001", "story_v_out_425131.awb") ~= 0 then
					local var_4_36 = manager.audio:GetVoiceLength("story_v_out_425131", "425131001", "story_v_out_425131.awb") / 1000

					if var_4_36 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_29
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_425131", "425131001", "story_v_out_425131.awb")

						arg_1_1:RecordAudio("425131001", var_4_37)
						arg_1_1:RecordAudio("425131001", var_4_37)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425131", "425131001", "story_v_out_425131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425131", "425131001", "story_v_out_425131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_29 + 0.3
			local var_4_39 = math.max(var_4_30, arg_1_1.talkMaxDuration)

			if var_4_29 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425131002
		arg_9_1.duration_ = 1.9

		local var_9_0 = {
			zh = 1.666,
			ja = 1.9
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
				arg_9_0:Play425131003(arg_9_1)
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

			local var_12_5 = arg_9_1.actors_["1036"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1036 == nil then
				arg_9_1.var_.actorSpriteComps1036 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps1036 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								iter_12_7.color = Color.New(Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_7.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_7.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1036 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_12_9 then
						iter_12_9.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1036 = nil
			end

			local var_12_8 = arg_9_1.actors_["1037"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1037 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1037", 4)

				for iter_12_10 = 0, var_12_8.childCount - 1 do
					local var_12_9 = var_12_8:GetChild(iter_12_10)

					if var_12_9.name == "split_6" or not string.find(var_12_9.name, "split") then
						var_12_9.gameObject:SetActive(true)
					else
						var_12_9.gameObject:SetActive(false)
					end
				end
			end

			local var_12_10 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_9_1.time_ - 0) / var_12_10)
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_12_11 = arg_9_1.actors_["1036"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1036 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1036", 2)

				for iter_12_11 = 0, var_12_11.childCount - 1 do
					local var_12_12 = var_12_11:GetChild(iter_12_11)

					if var_12_12.name == "" or not string.find(var_12_12.name, "split") then
						var_12_12.gameObject:SetActive(true)
					else
						var_12_12.gameObject:SetActive(false)
					end
				end
			end

			local var_12_13 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_9_1.time_ - 0) / var_12_13)
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_12_14 = 0
			local var_12_15 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_16 = arg_9_1:GetWordFromCfg(425131002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 8 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 8)

				if (8 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 8)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131002", "story_v_out_425131.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_425131", "425131002", "story_v_out_425131.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_425131", "425131002", "story_v_out_425131.awb")

						arg_9_1:RecordAudio("425131002", var_12_21)
						arg_9_1:RecordAudio("425131002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425131", "425131002", "story_v_out_425131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425131", "425131002", "story_v_out_425131.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_15, arg_9_1.talkMaxDuration)

			if var_12_14 <= arg_9_1.time_ and arg_9_1.time_ < var_12_14 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_14) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_14 + var_12_22 and arg_9_1.time_ < var_12_14 + var_12_22 + arg_12_0 then
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
			},
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425131003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play425131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1037 = arg_13_1.actors_["1037"].transform.localPosition
				arg_13_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1037", 7)

				for iter_16_0 = 0, arg_13_1.actors_["1037"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1037"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_16_2 = arg_13_1.actors_["1036"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1036 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1036", 7)

				for iter_16_1 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_1)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_13_1.time_ and arg_13_1.time_ <= 0.034 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_16_6 = 0
			local var_16_7 = 0.625

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(425131003).content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 25 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_8) / 25)

				if (25 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_8) / 25)) > 0 and var_16_7 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_11 and arg_13_1.time_ < var_16_6 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425131004
		arg_17_1.duration_ = 3.3

		local var_17_0 = {
			zh = 3.3,
			ja = 2.833
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
				arg_17_0:Play425131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1036"]) and arg_17_1.var_.actorSpriteComps1036 == nil then
				arg_17_1.var_.actorSpriteComps1036 = arg_17_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1036"]) then
				if arg_17_1.var_.actorSpriteComps1036 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1036"]) and arg_17_1.var_.actorSpriteComps1036 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1036 = nil
			end

			local var_20_2 = arg_17_1.actors_["1036"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1036 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1036", 2)

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
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_20_5 = 0
			local var_20_6 = 0.4

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(425131004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 16 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 16)

				if (16 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 16)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131004", "story_v_out_425131.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131004", "story_v_out_425131.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_425131", "425131004", "story_v_out_425131.awb")

						arg_17_1:RecordAudio("425131004", var_20_12)
						arg_17_1:RecordAudio("425131004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425131", "425131004", "story_v_out_425131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425131", "425131004", "story_v_out_425131.awb")
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
				actorName = "1036",
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
	Play425131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425131005
		arg_21_1.duration_ = 3.77

		local var_21_0 = {
			zh = 1.6,
			ja = 3.766
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
				arg_21_0:Play425131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1037"]) and arg_21_1.var_.actorSpriteComps1037 == nil then
				arg_21_1.var_.actorSpriteComps1037 = arg_21_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1037"]) then
				if arg_21_1.var_.actorSpriteComps1037 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1037"]) and arg_21_1.var_.actorSpriteComps1037 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1037 = nil
			end

			local var_24_2 = arg_21_1.actors_["1036"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1036 == nil then
				arg_21_1.var_.actorSpriteComps1036 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1036 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1036 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1036 = nil
			end

			local var_24_5 = arg_21_1.actors_["1037"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1037 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1037", 4)

				for iter_24_8 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_8)

					if var_24_6.name == "split_4" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_24_8 = 0
			local var_24_9 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(425131005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 7 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 7)

				if (7 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 7)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131005", "story_v_out_425131.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131005", "story_v_out_425131.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_425131", "425131005", "story_v_out_425131.awb")

						arg_21_1:RecordAudio("425131005", var_24_15)
						arg_21_1:RecordAudio("425131005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425131", "425131005", "story_v_out_425131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425131", "425131005", "story_v_out_425131.awb")
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
				actorName = "1037",
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
	Play425131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425131006
		arg_25_1.duration_ = 6.83

		local var_25_0 = {
			zh = 5.833,
			ja = 6.833
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
				arg_25_0:Play425131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1036"]) and arg_25_1.var_.actorSpriteComps1036 == nil then
				arg_25_1.var_.actorSpriteComps1036 = arg_25_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1036"]) then
				if arg_25_1.var_.actorSpriteComps1036 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 1, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1036"]) and arg_25_1.var_.actorSpriteComps1036 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1036 = nil
			end

			local var_28_2 = arg_25_1.actors_["1037"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1037 == nil then
				arg_25_1.var_.actorSpriteComps1037 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1037 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1037 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1037 = nil
			end

			local var_28_5 = arg_25_1.actors_["1036"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1036 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1036", 2)

				for iter_28_8 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_8)

					if var_28_6.name == "" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_28_8 = 0
			local var_28_9 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(425131006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 28 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 28)

				if (28 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 28)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131006", "story_v_out_425131.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131006", "story_v_out_425131.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_425131", "425131006", "story_v_out_425131.awb")

						arg_25_1:RecordAudio("425131006", var_28_15)
						arg_25_1:RecordAudio("425131006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425131", "425131006", "story_v_out_425131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425131", "425131006", "story_v_out_425131.awb")
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
				actorName = "1036",
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
	Play425131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425131007
		arg_29_1.duration_ = 8

		local var_29_0 = {
			zh = 4.233,
			ja = 8
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
				arg_29_0:Play425131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1037"]) and arg_29_1.var_.actorSpriteComps1037 == nil then
				arg_29_1.var_.actorSpriteComps1037 = arg_29_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1037"]) then
				if arg_29_1.var_.actorSpriteComps1037 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1037"]) and arg_29_1.var_.actorSpriteComps1037 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1037 = nil
			end

			local var_32_2 = arg_29_1.actors_["1036"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1036 == nil then
				arg_29_1.var_.actorSpriteComps1036 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1036 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1036 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1036 = nil
			end

			local var_32_5 = arg_29_1.actors_["1037"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1037 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1037", 4)

				for iter_32_8 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_8)

					if var_32_6.name == "split_4" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_32_8 = 0
			local var_32_9 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(425131007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 20 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 20)

				if (20 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 20)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131007", "story_v_out_425131.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131007", "story_v_out_425131.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_425131", "425131007", "story_v_out_425131.awb")

						arg_29_1:RecordAudio("425131007", var_32_15)
						arg_29_1:RecordAudio("425131007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425131", "425131007", "story_v_out_425131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425131", "425131007", "story_v_out_425131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play425131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425131008
		arg_33_1.duration_ = 7.17

		local var_33_0 = {
			zh = 4.266,
			ja = 7.166
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
				arg_33_0:Play425131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1036"]) and arg_33_1.var_.actorSpriteComps1036 == nil then
				arg_33_1.var_.actorSpriteComps1036 = arg_33_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1036"]) then
				if arg_33_1.var_.actorSpriteComps1036 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1036"]) and arg_33_1.var_.actorSpriteComps1036 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1036 = nil
			end

			local var_36_2 = arg_33_1.actors_["1037"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1037 == nil then
				arg_33_1.var_.actorSpriteComps1037 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1037 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1037 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps1037 = nil
			end

			local var_36_5 = arg_33_1.actors_["1036"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1036 = var_36_5.localPosition
				var_36_5.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1036", 2)

				for iter_36_8 = 0, var_36_5.childCount - 1 do
					local var_36_6 = var_36_5:GetChild(iter_36_8)

					if var_36_6.name == "" or not string.find(var_36_6.name, "split") then
						var_36_6.gameObject:SetActive(true)
					else
						var_36_6.gameObject:SetActive(false)
					end
				end
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_33_1.time_ - 0) / var_36_7)
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_36_8 = 0
			local var_36_9 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(425131008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 21 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 21)

				if (21 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 21)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131008", "story_v_out_425131.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131008", "story_v_out_425131.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_425131", "425131008", "story_v_out_425131.awb")

						arg_33_1:RecordAudio("425131008", var_36_15)
						arg_33_1:RecordAudio("425131008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425131", "425131008", "story_v_out_425131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425131", "425131008", "story_v_out_425131.awb")
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
				actorName = "1036",
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
	Play425131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425131009
		arg_37_1.duration_ = 14.13

		local var_37_0 = {
			zh = 9.2,
			ja = 14.133
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
				arg_37_0:Play425131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1037"]) and arg_37_1.var_.actorSpriteComps1037 == nil then
				arg_37_1.var_.actorSpriteComps1037 = arg_37_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1037"]) then
				if arg_37_1.var_.actorSpriteComps1037 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1037"]) and arg_37_1.var_.actorSpriteComps1037 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1037 = nil
			end

			local var_40_2 = arg_37_1.actors_["1036"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1036 == nil then
				arg_37_1.var_.actorSpriteComps1036 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1036 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1036 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1036 = nil
			end

			local var_40_5 = arg_37_1.actors_["1037"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1037 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1037", 4)

				for iter_40_8 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_8)

					if var_40_6.name == "split_5" then
						var_40_6:SetAsLastSibling()
						var_40_6.gameObject:SetActive(true)

						arg_37_1.var_.actorSpriteSplit1037 = var_40_6.gameObject:GetComponent(typeof(Image))

						arg_37_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_40_7 = 0.666666666666667

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_37_1.time_ - 0) / var_40_7)

				if arg_37_1.var_.actorSpriteSplit1037 ~= nil then
					arg_37_1.var_.actorSpriteSplit1037:SetAlpha((arg_37_1.time_ - 0) / var_40_7)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(390, -430, -55)

				if arg_37_1.var_.actorSpriteSplit1037 ~= nil then
					arg_37_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_40_8 = 0
			local var_40_9 = 0.8

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(425131009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 32 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 32)

				if (32 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 32)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131009", "story_v_out_425131.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131009", "story_v_out_425131.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_425131", "425131009", "story_v_out_425131.awb")

						arg_37_1:RecordAudio("425131009", var_40_15)
						arg_37_1:RecordAudio("425131009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425131", "425131009", "story_v_out_425131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425131", "425131009", "story_v_out_425131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play425131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425131010
		arg_41_1.duration_ = 5.5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play425131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1037"]) and arg_41_1.var_.actorSpriteComps1037 == nil then
				arg_41_1.var_.actorSpriteComps1037 = arg_41_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1037"]) then
				if arg_41_1.var_.actorSpriteComps1037 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1037"]) and arg_41_1.var_.actorSpriteComps1037 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1037 = nil
			end

			local var_44_2 = arg_41_1.actors_["1037"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1037 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1037", 7)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_44_5 = arg_41_1.actors_["1036"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1036 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1036", 7)

				for iter_44_5 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_5)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_8 = manager.ui.mainCamera.transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = var_44_8.localPosition
			end

			local var_44_9 = 0.5

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 then
				local var_44_10, var_44_11 = math.modf((arg_41_1.time_ - 0) / 0.099)

				var_44_8.localPosition = Vector3.New(var_44_11 * 0.12, var_44_11 * 0, var_44_11 * 0) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 then
				var_44_8.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_12 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_12 + 1.1 and arg_41_1.time_ < var_44_12 + 1.1 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_13 = 0.5
			local var_44_14 = 0.75

			if 0.5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_15 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_15:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(425131010).content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_18 = 31 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 31)

				if (31 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 31)) > 0 and var_44_14 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18
					var_44_13 = var_44_13 + 0.3

					if var_44_18 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = var_44_13 + 0.3
			local var_44_20 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_19) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 425131011
		arg_47_1.duration_ = 5.93

		local var_47_0 = {
			zh = 4.9,
			ja = 5.933
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play425131012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1036"]) and arg_47_1.var_.actorSpriteComps1036 == nil then
				arg_47_1.var_.actorSpriteComps1036 = arg_47_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1036"]) then
				if arg_47_1.var_.actorSpriteComps1036 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								iter_50_1.color = Color.New(Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_0), Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_0), (Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_0)))
							else
								local var_50_1 = Mathf.Lerp(iter_50_1.color.r, 1, (arg_47_1.time_ - 0) / var_50_0)

								iter_50_1.color = Color.New(var_50_1, var_50_1, var_50_1)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1036"]) and arg_47_1.var_.actorSpriteComps1036 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_50_3 then
						iter_50_3.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1036 = nil
			end

			local var_50_2 = arg_47_1.actors_["1036"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1036 = var_50_2.localPosition
				var_50_2.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1036", 2)

				for iter_50_4 = 0, var_50_2.childCount - 1 do
					local var_50_3 = var_50_2:GetChild(iter_50_4)

					if var_50_3.name == "" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_2.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_47_1.time_ - 0) / var_50_4)
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_2.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_50_5 = 0
			local var_50_6 = 0.6

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:GetWordFromCfg(425131011)
				local var_50_8 = arg_47_1:FormatText(var_50_7.content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 24 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 24)

				if (24 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 24)) > 0 and var_50_6 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131011", "story_v_out_425131.awb") ~= 0 then
					local var_50_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131011", "story_v_out_425131.awb") / 1000

					if var_50_11 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_5
					end

					if var_50_7.prefab_name ~= "" and arg_47_1.actors_[var_50_7.prefab_name] ~= nil then
						local var_50_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_7.prefab_name].transform, "story_v_out_425131", "425131011", "story_v_out_425131.awb")

						arg_47_1:RecordAudio("425131011", var_50_12)
						arg_47_1:RecordAudio("425131011", var_50_12)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_425131", "425131011", "story_v_out_425131.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_425131", "425131011", "story_v_out_425131.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_13 and arg_47_1.time_ < var_50_5 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play425131012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 425131012
		arg_51_1.duration_ = 2.77

		local var_51_0 = {
			zh = 1.566,
			ja = 2.766
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
				arg_51_0:Play425131013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1037"]) and arg_51_1.var_.actorSpriteComps1037 == nil then
				arg_51_1.var_.actorSpriteComps1037 = arg_51_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1037"]) then
				if arg_51_1.var_.actorSpriteComps1037 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 1, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1037"]) and arg_51_1.var_.actorSpriteComps1037 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps1037 = nil
			end

			local var_54_2 = arg_51_1.actors_["1036"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1036 == nil then
				arg_51_1.var_.actorSpriteComps1036 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps1036 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								iter_54_5.color = Color.New(Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_5.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_5.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1036 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_54_7 then
						iter_54_7.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps1036 = nil
			end

			local var_54_5 = arg_51_1.actors_["1037"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1037 = var_54_5.localPosition
				var_54_5.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1037", 4)

				for iter_54_8 = 0, var_54_5.childCount - 1 do
					local var_54_6 = var_54_5:GetChild(iter_54_8)

					if var_54_6.name == "split_4" or not string.find(var_54_6.name, "split") then
						var_54_6.gameObject:SetActive(true)
					else
						var_54_6.gameObject:SetActive(false)
					end
				end
			end

			local var_54_7 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_51_1.time_ - 0) / var_54_7)
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_54_8 = 0
			local var_54_9 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(425131012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 6 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 6)

				if (6 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 6)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131012", "story_v_out_425131.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131012", "story_v_out_425131.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_425131", "425131012", "story_v_out_425131.awb")

						arg_51_1:RecordAudio("425131012", var_54_15)
						arg_51_1:RecordAudio("425131012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_425131", "425131012", "story_v_out_425131.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_425131", "425131012", "story_v_out_425131.awb")
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
				actorName = "1037",
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
	Play425131013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 425131013
		arg_55_1.duration_ = 12.87

		local var_55_0 = {
			zh = 8.733,
			ja = 12.866
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play425131014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1036"]) and arg_55_1.var_.actorSpriteComps1036 == nil then
				arg_55_1.var_.actorSpriteComps1036 = arg_55_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1036"]) then
				if arg_55_1.var_.actorSpriteComps1036 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 1, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1036"]) and arg_55_1.var_.actorSpriteComps1036 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps1036 = nil
			end

			local var_58_2 = arg_55_1.actors_["1037"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1037 == nil then
				arg_55_1.var_.actorSpriteComps1037 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps1037 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								iter_58_5.color = Color.New(Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_5.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_5.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1037 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_58_7 then
						iter_58_7.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1037 = nil
			end

			local var_58_5 = arg_55_1.actors_["1036"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1036 = var_58_5.localPosition
				var_58_5.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1036", 2)

				for iter_58_8 = 0, var_58_5.childCount - 1 do
					local var_58_6 = var_58_5:GetChild(iter_58_8)

					if var_58_6.name == "" or not string.find(var_58_6.name, "split") then
						var_58_6.gameObject:SetActive(true)
					else
						var_58_6.gameObject:SetActive(false)
					end
				end
			end

			local var_58_7 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_55_1.time_ - 0) / var_58_7)
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_58_8 = 0
			local var_58_9 = 1.15

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(425131013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 46 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 46)

				if (46 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 46)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131013", "story_v_out_425131.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131013", "story_v_out_425131.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_425131", "425131013", "story_v_out_425131.awb")

						arg_55_1:RecordAudio("425131013", var_58_15)
						arg_55_1:RecordAudio("425131013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_425131", "425131013", "story_v_out_425131.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_425131", "425131013", "story_v_out_425131.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 425131014
		arg_59_1.duration_ = 3.9

		local var_59_0 = {
			zh = 2.8,
			ja = 3.9
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
				arg_59_0:Play425131015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1036 = arg_59_1.actors_["1036"].transform.localPosition
				arg_59_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1036", 2)

				for iter_62_0 = 0, arg_59_1.actors_["1036"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["1036"].transform:GetChild(iter_62_0)

					if var_62_0.name == "" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["1036"].transform.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_62_2 = 0
			local var_62_3 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(425131014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 13 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 13)

				if (13 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 13)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131014", "story_v_out_425131.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_425131", "425131014", "story_v_out_425131.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_425131", "425131014", "story_v_out_425131.awb")

						arg_59_1:RecordAudio("425131014", var_62_9)
						arg_59_1:RecordAudio("425131014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_425131", "425131014", "story_v_out_425131.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_425131", "425131014", "story_v_out_425131.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play425131015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 425131015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play425131016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1037 = arg_63_1.actors_["1037"].transform.localPosition
				arg_63_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1037", 7)

				for iter_66_0 = 0, arg_63_1.actors_["1037"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["1037"].transform:GetChild(iter_66_0)

					if var_66_0.name == "" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_66_2 = arg_63_1.actors_["1036"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1036 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1036", 7)

				for iter_66_1 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_1)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_5 = 0
			local var_66_6 = 0.6

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(425131015).content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 24 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_7) / 24)

				if (24 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_7) / 24)) > 0 and var_66_6 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_10 and arg_63_1.time_ < var_66_5 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 425131016
		arg_67_1.duration_ = 7

		local var_67_0 = {
			zh = 6.233,
			ja = 7
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
				arg_67_0:Play425131017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1036"]) and arg_67_1.var_.actorSpriteComps1036 == nil then
				arg_67_1.var_.actorSpriteComps1036 = arg_67_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1036"]) then
				if arg_67_1.var_.actorSpriteComps1036 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1036"]) and arg_67_1.var_.actorSpriteComps1036 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1036 = nil
			end

			local var_70_2 = arg_67_1.actors_["1036"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1036 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1036", 2)

				for iter_70_4 = 0, var_70_2.childCount - 1 do
					local var_70_3 = var_70_2:GetChild(iter_70_4)

					if var_70_3.name == "" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_67_1.time_ - 0) / var_70_4)
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_70_5 = 0
			local var_70_6 = 0.75

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(425131016)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 30 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 30)

				if (30 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 30)) > 0 and var_70_6 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131016", "story_v_out_425131.awb") ~= 0 then
					local var_70_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131016", "story_v_out_425131.awb") / 1000

					if var_70_11 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_5
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_425131", "425131016", "story_v_out_425131.awb")

						arg_67_1:RecordAudio("425131016", var_70_12)
						arg_67_1:RecordAudio("425131016", var_70_12)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_425131", "425131016", "story_v_out_425131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_425131", "425131016", "story_v_out_425131.awb")
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
				actorName = "1036",
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
	Play425131017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 425131017
		arg_71_1.duration_ = 1.23

		local var_71_0 = {
			zh = 1.066,
			ja = 1.233
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
				arg_71_0:Play425131018(arg_71_1)
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
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 1, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1037"]) and arg_71_1.var_.actorSpriteComps1037 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps1037 = nil
			end

			local var_74_2 = arg_71_1.actors_["1036"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1036 == nil then
				arg_71_1.var_.actorSpriteComps1036 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps1036 then
					for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_74_5 then
							if arg_71_1.isInRecall_ then
								iter_74_5.color = Color.New(Mathf.Lerp(iter_74_5.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_5.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_5.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_5.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_5.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps1036 then
				for iter_74_6, iter_74_7 in pairs(arg_71_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_74_7 then
						iter_74_7.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps1036 = nil
			end

			local var_74_5 = arg_71_1.actors_["1037"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1037 = var_74_5.localPosition
				var_74_5.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1037", 4)

				for iter_74_8 = 0, var_74_5.childCount - 1 do
					local var_74_6 = var_74_5:GetChild(iter_74_8)

					if var_74_6.name == "split_5" or not string.find(var_74_6.name, "split") then
						var_74_6.gameObject:SetActive(true)
					else
						var_74_6.gameObject:SetActive(false)
					end
				end
			end

			local var_74_7 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_71_1.time_ - 0) / var_74_7)
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_74_8 = 0
			local var_74_9 = 0.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(425131017)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 2 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 2)

				if (2 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 2)) > 0 and var_74_9 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131017", "story_v_out_425131.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131017", "story_v_out_425131.awb") / 1000

					if var_74_14 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_8
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_425131", "425131017", "story_v_out_425131.awb")

						arg_71_1:RecordAudio("425131017", var_74_15)
						arg_71_1:RecordAudio("425131017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_425131", "425131017", "story_v_out_425131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_425131", "425131017", "story_v_out_425131.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play425131018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 425131018
		arg_75_1.duration_ = 10.5

		local var_75_0 = {
			zh = 7,
			ja = 10.5
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
				arg_75_0:Play425131019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1036"]) and arg_75_1.var_.actorSpriteComps1036 == nil then
				arg_75_1.var_.actorSpriteComps1036 = arg_75_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1036"]) then
				if arg_75_1.var_.actorSpriteComps1036 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1036"]) and arg_75_1.var_.actorSpriteComps1036 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps1036 = nil
			end

			local var_78_2 = arg_75_1.actors_["1037"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1037 == nil then
				arg_75_1.var_.actorSpriteComps1037 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps1037 then
					for iter_78_4, iter_78_5 in pairs(arg_75_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_78_5 then
							if arg_75_1.isInRecall_ then
								iter_78_5.color = Color.New(Mathf.Lerp(iter_78_5.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_5.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_5.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_5.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_5.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps1037 then
				for iter_78_6, iter_78_7 in pairs(arg_75_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_78_7 then
						iter_78_7.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps1037 = nil
			end

			local var_78_5 = arg_75_1.actors_["1036"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1036 = var_78_5.localPosition
				var_78_5.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1036", 2)

				for iter_78_8 = 0, var_78_5.childCount - 1 do
					local var_78_6 = var_78_5:GetChild(iter_78_8)

					if var_78_6.name == "" or not string.find(var_78_6.name, "split") then
						var_78_6.gameObject:SetActive(true)
					else
						var_78_6.gameObject:SetActive(false)
					end
				end
			end

			local var_78_7 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_75_1.time_ - 0) / var_78_7)
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_78_8 = 0
			local var_78_9 = 0.725

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(425131018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 29 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 29)

				if (29 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 29)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131018", "story_v_out_425131.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131018", "story_v_out_425131.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_425131", "425131018", "story_v_out_425131.awb")

						arg_75_1:RecordAudio("425131018", var_78_15)
						arg_75_1:RecordAudio("425131018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_425131", "425131018", "story_v_out_425131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_425131", "425131018", "story_v_out_425131.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 425131019
		arg_79_1.duration_ = 9.33

		local var_79_0 = {
			zh = 8,
			ja = 9.333
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
				arg_79_0:Play425131020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.bgs_.I16f == nil then
				local var_82_0 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16f")
				var_82_0.name = "I16f"
				var_82_0.transform.parent = arg_79_1.stage_.transform
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_.I16f = var_82_0
			end

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= 2 + arg_82_0 then
				local var_82_1 = arg_79_1.bgs_.I16f

				arg_79_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_82_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_2 = var_82_1:GetComponent("SpriteRenderer")

				if var_82_2 and var_82_2.sprite then
					local var_82_3 = 2 * (var_82_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_82_1.transform.localScale = Vector3.New(var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, var_82_3 / var_82_2.sprite.bounds.size.y < var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x and var_82_3 * manager.ui.mainCameraCom_.aspect / var_82_2.sprite.bounds.size.x or var_82_3 / var_82_2.sprite.bounds.size.y, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "I16f" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_4 = 4

			if 4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_4 + 0.3 and arg_79_1.time_ < var_82_4 + 0.3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_5 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_6 = 2

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 then
				local var_82_7 = Color.New(0, 0, 0)

				var_82_7.a = Mathf.Lerp(0, 1, (arg_79_1.time_ - var_82_5) / var_82_6)
				arg_79_1.mask_.color = var_82_7
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 then
				local var_82_8 = Color.New(0, 0, 0)

				var_82_8.a = 1
				arg_79_1.mask_.color = var_82_8
			end

			local var_82_9 = 2

			if 2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_10 = 2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = Color.New(0, 0, 0)

				var_82_11.a = Mathf.Lerp(1, 0, (arg_79_1.time_ - var_82_9) / var_82_10)
				arg_79_1.mask_.color = var_82_11
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 then
				local var_82_12 = Color.New(0, 0, 0)

				arg_79_1.mask_.enabled = false
				var_82_12.a = 0
				arg_79_1.mask_.color = var_82_12
			end

			local var_82_13 = arg_79_1.actors_["1037"]

			if 3.8 < arg_79_1.time_ and arg_79_1.time_ <= 3.8 + arg_82_0 and not isNil(var_82_13) and arg_79_1.var_.actorSpriteComps1037 == nil then
				arg_79_1.var_.actorSpriteComps1037 = var_82_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_14 = 0.2

			if 3.8 <= arg_79_1.time_ and arg_79_1.time_ < 3.8 + var_82_14 and not isNil(var_82_13) then
				if arg_79_1.var_.actorSpriteComps1037 then
					for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_82_3 then
							if arg_79_1.isInRecall_ then
								iter_82_3.color = Color.New(Mathf.Lerp(iter_82_3.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 3.8) / var_82_14), Mathf.Lerp(iter_82_3.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 3.8) / var_82_14), (Mathf.Lerp(iter_82_3.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 3.8) / var_82_14)))
							else
								local var_82_15 = Mathf.Lerp(iter_82_3.color.r, 1, (arg_79_1.time_ - 3.8) / var_82_14)

								iter_82_3.color = Color.New(var_82_15, var_82_15, var_82_15)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 3.8 + var_82_14 and arg_79_1.time_ < 3.8 + var_82_14 + arg_82_0 and not isNil(var_82_13) and arg_79_1.var_.actorSpriteComps1037 then
				for iter_82_4, iter_82_5 in pairs(arg_79_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_82_5 then
						iter_82_5.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1037 = nil
			end

			local var_82_16 = arg_79_1.actors_["1037"].transform

			if 1.966 < arg_79_1.time_ and arg_79_1.time_ <= 1.966 + arg_82_0 then
				arg_79_1.var_.moveOldPos1037 = var_82_16.localPosition
				var_82_16.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1037", 7)

				for iter_82_6 = 0, var_82_16.childCount - 1 do
					local var_82_17 = var_82_16:GetChild(iter_82_6)

					if var_82_17.name == "" or not string.find(var_82_17.name, "split") then
						var_82_17.gameObject:SetActive(true)
					else
						var_82_17.gameObject:SetActive(false)
					end
				end
			end

			local var_82_18 = 0.001

			if 1.966 <= arg_79_1.time_ and arg_79_1.time_ < 1.966 + var_82_18 then
				var_82_16.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_79_1.time_ - 1.966) / var_82_18)
			end

			if arg_79_1.time_ >= 1.966 + var_82_18 and arg_79_1.time_ < 1.966 + var_82_18 + arg_82_0 then
				var_82_16.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_82_19 = arg_79_1.actors_["1037"].transform

			if 3.8 < arg_79_1.time_ and arg_79_1.time_ <= 3.8 + arg_82_0 then
				arg_79_1.var_.moveOldPos1037 = var_82_19.localPosition
				var_82_19.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1037", 3)

				for iter_82_7 = 0, var_82_19.childCount - 1 do
					local var_82_20 = var_82_19:GetChild(iter_82_7)

					if var_82_20.name == "split_3" or not string.find(var_82_20.name, "split") then
						var_82_20.gameObject:SetActive(true)
					else
						var_82_20.gameObject:SetActive(false)
					end
				end
			end

			local var_82_21 = 0.001

			if 3.8 <= arg_79_1.time_ and arg_79_1.time_ < 3.8 + var_82_21 then
				var_82_19.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_79_1.time_ - 3.8) / var_82_21)
			end

			if arg_79_1.time_ >= 3.8 + var_82_21 and arg_79_1.time_ < 3.8 + var_82_21 + arg_82_0 then
				var_82_19.localPosition = Vector3.New(0, -430, -55)
			end

			local var_82_22 = arg_79_1.actors_["1036"].transform

			if 1.966 < arg_79_1.time_ and arg_79_1.time_ <= 1.966 + arg_82_0 then
				arg_79_1.var_.moveOldPos1036 = var_82_22.localPosition
				var_82_22.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1036", 7)

				for iter_82_8 = 0, var_82_22.childCount - 1 do
					local var_82_23 = var_82_22:GetChild(iter_82_8)

					if var_82_23.name == "" or not string.find(var_82_23.name, "split") then
						var_82_23.gameObject:SetActive(true)
					else
						var_82_23.gameObject:SetActive(false)
					end
				end
			end

			local var_82_24 = 0.001

			if 1.966 <= arg_79_1.time_ and arg_79_1.time_ < 1.966 + var_82_24 then
				var_82_22.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 1.966) / var_82_24)
			end

			if arg_79_1.time_ >= 1.966 + var_82_24 and arg_79_1.time_ < 1.966 + var_82_24 + arg_82_0 then
				var_82_22.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 0.133333333333333 + arg_82_0 then
				arg_79_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.63333333333333 < arg_79_1.time_ and arg_79_1.time_ <= 1.63333333333333 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_27 = 4
			local var_82_28 = 0.4

			if 4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_27 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_29 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_29:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_30 = arg_79_1:GetWordFromCfg(425131019)
				local var_82_31 = arg_79_1:FormatText(var_82_30.content)

				arg_79_1.text_.text = var_82_31

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_33 = 16 <= 0 and var_82_28 or var_82_28 * (utf8.len(var_82_31) / 16)

				if (16 <= 0 and var_82_28 or var_82_28 * (utf8.len(var_82_31) / 16)) > 0 and var_82_28 < var_82_33 then
					arg_79_1.talkMaxDuration = var_82_33
					var_82_27 = var_82_27 + 0.3

					if var_82_33 + var_82_27 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_33 + var_82_27
					end
				end

				arg_79_1.text_.text = var_82_31
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131019", "story_v_out_425131.awb") ~= 0 then
					local var_82_34 = manager.audio:GetVoiceLength("story_v_out_425131", "425131019", "story_v_out_425131.awb") / 1000

					if var_82_34 + var_82_27 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_34 + var_82_27
					end

					if var_82_30.prefab_name ~= "" and arg_79_1.actors_[var_82_30.prefab_name] ~= nil then
						local var_82_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_30.prefab_name].transform, "story_v_out_425131", "425131019", "story_v_out_425131.awb")

						arg_79_1:RecordAudio("425131019", var_82_35)
						arg_79_1:RecordAudio("425131019", var_82_35)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_425131", "425131019", "story_v_out_425131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_425131", "425131019", "story_v_out_425131.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_36 = var_82_27 + 0.3
			local var_82_37 = math.max(var_82_28, arg_79_1.talkMaxDuration)

			if var_82_27 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_36 + var_82_37 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_36) / var_82_37

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_36 + var_82_37 and arg_79_1.time_ < var_82_36 + var_82_37 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play425131020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425131020
		arg_85_1.duration_ = 7.63

		local var_85_0 = {
			zh = 4.866,
			ja = 7.633
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
				arg_85_0:Play425131021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1037 = arg_85_1.actors_["1037"].transform.localPosition
				arg_85_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1037", 3)

				for iter_88_0 = 0, arg_85_1.actors_["1037"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["1037"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_4" then
						var_88_0:SetAsLastSibling()
						var_88_0.gameObject:SetActive(true)

						arg_85_1.var_.actorSpriteSplit1037 = var_88_0.gameObject:GetComponent(typeof(Image))

						arg_85_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_88_1 = 0.5

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_85_1.time_ - 0) / var_88_1)

				if arg_85_1.var_.actorSpriteSplit1037 ~= nil then
					arg_85_1.var_.actorSpriteSplit1037:SetAlpha((arg_85_1.time_ - 0) / var_88_1)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)

				if arg_85_1.var_.actorSpriteSplit1037 ~= nil then
					arg_85_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_88_2 = 0
			local var_88_3 = 0.6

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(425131020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 24 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 24)

				if (24 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 24)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131020", "story_v_out_425131.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_425131", "425131020", "story_v_out_425131.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_425131", "425131020", "story_v_out_425131.awb")

						arg_85_1:RecordAudio("425131020", var_88_9)
						arg_85_1:RecordAudio("425131020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425131", "425131020", "story_v_out_425131.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425131", "425131020", "story_v_out_425131.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play425131021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425131021
		arg_89_1.duration_ = 4.1

		local var_89_0 = {
			zh = 2.733,
			ja = 4.1
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
				arg_89_0:Play425131022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1036"]) and arg_89_1.var_.actorSpriteComps1036 == nil then
				arg_89_1.var_.actorSpriteComps1036 = arg_89_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1036"]) then
				if arg_89_1.var_.actorSpriteComps1036 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1036"]) and arg_89_1.var_.actorSpriteComps1036 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1036 = nil
			end

			local var_92_2 = arg_89_1.actors_["1037"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1037 == nil then
				arg_89_1.var_.actorSpriteComps1037 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps1037 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1037 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps1037 = nil
			end

			local var_92_5 = arg_89_1.actors_["1036"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1036 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1036", 2)

				for iter_92_8 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_8)

					if var_92_6.name == "" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_92_8 = arg_89_1.actors_["1037"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1037 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1037", 4)

				for iter_92_9 = 0, var_92_8.childCount - 1 do
					local var_92_9 = var_92_8:GetChild(iter_92_9)

					if var_92_9.name == "split_4" or not string.find(var_92_9.name, "split") then
						var_92_9.gameObject:SetActive(true)
					else
						var_92_9.gameObject:SetActive(false)
					end
				end
			end

			local var_92_10 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 then
				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_89_1.time_ - 0) / var_92_10)
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_92_11 = 0
			local var_92_12 = 0.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(425131021)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 11 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 11)

				if (11 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 11)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131021", "story_v_out_425131.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131021", "story_v_out_425131.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_425131", "425131021", "story_v_out_425131.awb")

						arg_89_1:RecordAudio("425131021", var_92_18)
						arg_89_1:RecordAudio("425131021", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_425131", "425131021", "story_v_out_425131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_425131", "425131021", "story_v_out_425131.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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

		arg_89_1:InitPlayNodeList()
	end,
	Play425131022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425131022
		arg_93_1.duration_ = 7.83

		local var_93_0 = {
			zh = 5.9,
			ja = 7.833
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
				arg_93_0:Play425131023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.675

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(425131022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 27 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 27)

				if (27 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 27)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131022", "story_v_out_425131.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131022", "story_v_out_425131.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_425131", "425131022", "story_v_out_425131.awb")

						arg_93_1:RecordAudio("425131022", var_96_6)
						arg_93_1:RecordAudio("425131022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425131", "425131022", "story_v_out_425131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425131", "425131022", "story_v_out_425131.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play425131023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425131023
		arg_97_1.duration_ = 8.87

		local var_97_0 = {
			zh = 5.666,
			ja = 8.866
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
				arg_97_0:Play425131024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1037"]) and arg_97_1.var_.actorSpriteComps1037 == nil then
				arg_97_1.var_.actorSpriteComps1037 = arg_97_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1037"]) then
				if arg_97_1.var_.actorSpriteComps1037 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 1, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1037"]) and arg_97_1.var_.actorSpriteComps1037 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps1037 = nil
			end

			local var_100_2 = arg_97_1.actors_["1036"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1036 == nil then
				arg_97_1.var_.actorSpriteComps1036 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps1036 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1036 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1036 = nil
			end

			local var_100_5 = arg_97_1.actors_["1037"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1037 = var_100_5.localPosition
				var_100_5.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1037", 4)

				for iter_100_8 = 0, var_100_5.childCount - 1 do
					local var_100_6 = var_100_5:GetChild(iter_100_8)

					if var_100_6.name == "split_5" then
						var_100_6:SetAsLastSibling()
						var_100_6.gameObject:SetActive(true)

						arg_97_1.var_.actorSpriteSplit1037 = var_100_6.gameObject:GetComponent(typeof(Image))

						arg_97_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_100_7 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_97_1.time_ - 0) / var_100_7)

				if arg_97_1.var_.actorSpriteSplit1037 ~= nil then
					arg_97_1.var_.actorSpriteSplit1037:SetAlpha((arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(390, -430, -55)

				if arg_97_1.var_.actorSpriteSplit1037 ~= nil then
					arg_97_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_100_8 = 0
			local var_100_9 = 0.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(425131023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 27 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 27)

				if (27 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 27)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131023", "story_v_out_425131.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131023", "story_v_out_425131.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_425131", "425131023", "story_v_out_425131.awb")

						arg_97_1:RecordAudio("425131023", var_100_15)
						arg_97_1:RecordAudio("425131023", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425131", "425131023", "story_v_out_425131.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425131", "425131023", "story_v_out_425131.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play425131024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425131024
		arg_101_1.duration_ = 4.33

		local var_101_0 = {
			zh = 2.7,
			ja = 4.333
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
				arg_101_0:Play425131025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1036"]) and arg_101_1.var_.actorSpriteComps1036 == nil then
				arg_101_1.var_.actorSpriteComps1036 = arg_101_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1036"]) then
				if arg_101_1.var_.actorSpriteComps1036 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1036"]) and arg_101_1.var_.actorSpriteComps1036 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1036 = nil
			end

			local var_104_2 = arg_101_1.actors_["1037"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1037 == nil then
				arg_101_1.var_.actorSpriteComps1037 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1037 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1037 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_104_7 then
						iter_104_7.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1037 = nil
			end

			local var_104_5 = arg_101_1.actors_["1036"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1036 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1036", 2)

				for iter_104_8 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_8)

					if var_104_6.name == "" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_104_8 = 0
			local var_104_9 = 0.325

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(425131024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 13 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 13)

				if (13 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 13)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131024", "story_v_out_425131.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131024", "story_v_out_425131.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_425131", "425131024", "story_v_out_425131.awb")

						arg_101_1:RecordAudio("425131024", var_104_15)
						arg_101_1:RecordAudio("425131024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_425131", "425131024", "story_v_out_425131.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_425131", "425131024", "story_v_out_425131.awb")
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
				actorName = "1036",
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
	Play425131025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425131025
		arg_105_1.duration_ = 6.3

		local var_105_0 = {
			zh = 6.3,
			ja = 5.833
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
				arg_105_0:Play425131026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1036 = arg_105_1.actors_["1036"].transform.localPosition
				arg_105_1.actors_["1036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1036", 2)

				for iter_108_0 = 0, arg_105_1.actors_["1036"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["1036"].transform:GetChild(iter_108_0)

					if var_108_0.name == "" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["1036"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["1036"].transform.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_108_2 = 0
			local var_108_3 = 0.85

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(425131025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 34 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 34)

				if (34 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 34)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131025", "story_v_out_425131.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_425131", "425131025", "story_v_out_425131.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_425131", "425131025", "story_v_out_425131.awb")

						arg_105_1:RecordAudio("425131025", var_108_9)
						arg_105_1:RecordAudio("425131025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425131", "425131025", "story_v_out_425131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425131", "425131025", "story_v_out_425131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 425131026
		arg_109_1.duration_ = 2.3

		local var_109_0 = {
			zh = 2.233,
			ja = 2.3
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
				arg_109_0:Play425131027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1037"]) and arg_109_1.var_.actorSpriteComps1037 == nil then
				arg_109_1.var_.actorSpriteComps1037 = arg_109_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1037"]) then
				if arg_109_1.var_.actorSpriteComps1037 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 1, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1037"]) and arg_109_1.var_.actorSpriteComps1037 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1037 = nil
			end

			local var_112_2 = arg_109_1.actors_["1036"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1036 == nil then
				arg_109_1.var_.actorSpriteComps1036 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps1036 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								iter_112_5.color = Color.New(Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_5.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_5.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1036 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_112_7 then
						iter_112_7.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps1036 = nil
			end

			local var_112_5 = arg_109_1.actors_["1037"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1037 = var_112_5.localPosition
				var_112_5.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1037", 4)

				for iter_112_8 = 0, var_112_5.childCount - 1 do
					local var_112_6 = var_112_5:GetChild(iter_112_8)

					if var_112_6.name == "split_5" or not string.find(var_112_6.name, "split") then
						var_112_6.gameObject:SetActive(true)
					else
						var_112_6.gameObject:SetActive(false)
					end
				end
			end

			local var_112_7 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				var_112_5.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_109_1.time_ - 0) / var_112_7)
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				var_112_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_112_8 = 0
			local var_112_9 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(425131026)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 5 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 5)

				if (5 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 5)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131026", "story_v_out_425131.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131026", "story_v_out_425131.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_425131", "425131026", "story_v_out_425131.awb")

						arg_109_1:RecordAudio("425131026", var_112_15)
						arg_109_1:RecordAudio("425131026", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_425131", "425131026", "story_v_out_425131.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_425131", "425131026", "story_v_out_425131.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play425131027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 425131027
		arg_113_1.duration_ = 10.1

		local var_113_0 = {
			zh = 7.666,
			ja = 10.1
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
				arg_113_0:Play425131028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1036"]) and arg_113_1.var_.actorSpriteComps1036 == nil then
				arg_113_1.var_.actorSpriteComps1036 = arg_113_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1036"]) then
				if arg_113_1.var_.actorSpriteComps1036 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1036"]) and arg_113_1.var_.actorSpriteComps1036 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1036 = nil
			end

			local var_116_2 = arg_113_1.actors_["1037"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1037 == nil then
				arg_113_1.var_.actorSpriteComps1037 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps1037 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								iter_116_5.color = Color.New(Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_5.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_5.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1037 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_116_7 then
						iter_116_7.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1037 = nil
			end

			local var_116_5 = arg_113_1.actors_["1036"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1036 = var_116_5.localPosition
				var_116_5.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1036", 2)

				for iter_116_8 = 0, var_116_5.childCount - 1 do
					local var_116_6 = var_116_5:GetChild(iter_116_8)

					if var_116_6.name == "" or not string.find(var_116_6.name, "split") then
						var_116_6.gameObject:SetActive(true)
					else
						var_116_6.gameObject:SetActive(false)
					end
				end
			end

			local var_116_7 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_113_1.time_ - 0) / var_116_7)
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_116_8 = 0
			local var_116_9 = 1.05

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(425131027)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 42 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 42)

				if (42 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 42)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131027", "story_v_out_425131.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131027", "story_v_out_425131.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_425131", "425131027", "story_v_out_425131.awb")

						arg_113_1:RecordAudio("425131027", var_116_15)
						arg_113_1:RecordAudio("425131027", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_425131", "425131027", "story_v_out_425131.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_425131", "425131027", "story_v_out_425131.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 425131028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play425131029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1037 = arg_117_1.actors_["1037"].transform.localPosition
				arg_117_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1037", 7)

				for iter_120_0 = 0, arg_117_1.actors_["1037"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1037"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_120_2 = arg_117_1.actors_["1036"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1036 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1036", 7)

				for iter_120_1 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_1)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.133333333333333 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_147", "se_story_147_whoosh", "")
			end

			local var_120_6 = 0
			local var_120_7 = 0.55

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(425131028).content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 22 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 22)

				if (22 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 22)) > 0 and var_120_7 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_11 and arg_117_1.time_ < var_120_6 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 425131029
		arg_121_1.duration_ = 7.17

		local var_121_0 = {
			zh = 4.266,
			ja = 7.166
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
				arg_121_0:Play425131030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1036"]) and arg_121_1.var_.actorSpriteComps1036 == nil then
				arg_121_1.var_.actorSpriteComps1036 = arg_121_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1036"]) then
				if arg_121_1.var_.actorSpriteComps1036 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 1, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1036"]) and arg_121_1.var_.actorSpriteComps1036 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1036 = nil
			end

			local var_124_2 = arg_121_1.actors_["1036"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1036 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1036", 3)

				for iter_124_4 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_4)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_124_5 = 0
			local var_124_6 = 0.65

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(425131029)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 26 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 26)

				if (26 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 26)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131029", "story_v_out_425131.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131029", "story_v_out_425131.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_425131", "425131029", "story_v_out_425131.awb")

						arg_121_1:RecordAudio("425131029", var_124_12)
						arg_121_1:RecordAudio("425131029", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_425131", "425131029", "story_v_out_425131.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_425131", "425131029", "story_v_out_425131.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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
	Play425131030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 425131030
		arg_125_1.duration_ = 9.1

		local var_125_0 = {
			zh = 7.066,
			ja = 9.1
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
				arg_125_0:Play425131031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.ST20 == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST20")
				var_128_0.name = "ST20"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.ST20 = var_128_0
			end

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.ST20

				arg_125_1.bgs_.ST20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "ST20" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 4

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_4 + 0.3 and arg_125_1.time_ < var_128_4 + 0.3 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_5 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_6 = 2

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_5) / var_128_6)
				arg_125_1.mask_.color = var_128_7
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				local var_128_8 = Color.New(0, 0, 0)

				var_128_8.a = 1
				arg_125_1.mask_.color = var_128_8
			end

			local var_128_9 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_10 = 2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 then
				local var_128_11 = Color.New(0, 0, 0)

				var_128_11.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_9) / var_128_10)
				arg_125_1.mask_.color = var_128_11
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 then
				local var_128_12 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_12.a = 0
				arg_125_1.mask_.color = var_128_12
			end

			local var_128_13 = arg_125_1.actors_["1037"]

			if 3.8 < arg_125_1.time_ and arg_125_1.time_ <= 3.8 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.actorSpriteComps1037 == nil then
				arg_125_1.var_.actorSpriteComps1037 = var_128_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_14 = 0.2

			if 3.8 <= arg_125_1.time_ and arg_125_1.time_ < 3.8 + var_128_14 and not isNil(var_128_13) then
				if arg_125_1.var_.actorSpriteComps1037 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								iter_128_3.color = Color.New(Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 3.8) / var_128_14), Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 3.8) / var_128_14), (Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 3.8) / var_128_14)))
							else
								local var_128_15 = Mathf.Lerp(iter_128_3.color.r, 1, (arg_125_1.time_ - 3.8) / var_128_14)

								iter_128_3.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 3.8 + var_128_14 and arg_125_1.time_ < 3.8 + var_128_14 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.actorSpriteComps1037 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_128_5 then
						iter_128_5.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps1037 = nil
			end

			local var_128_16 = arg_125_1.actors_["1036"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos1036 = var_128_16.localPosition
				var_128_16.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1036", 7)

				for iter_128_6 = 0, var_128_16.childCount - 1 do
					local var_128_17 = var_128_16:GetChild(iter_128_6)

					if var_128_17.name == "" or not string.find(var_128_17.name, "split") then
						var_128_17.gameObject:SetActive(true)
					else
						var_128_17.gameObject:SetActive(false)
					end
				end
			end

			local var_128_18 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_18 then
				var_128_16.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_125_1.time_ - 2) / var_128_18)
			end

			if arg_125_1.time_ >= 2 + var_128_18 and arg_125_1.time_ < 2 + var_128_18 + arg_128_0 then
				var_128_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_19 = arg_125_1.actors_["1037"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos1037 = var_128_19.localPosition
				var_128_19.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1037", 7)

				for iter_128_7 = 0, var_128_19.childCount - 1 do
					local var_128_20 = var_128_19:GetChild(iter_128_7)

					if var_128_20.name == "" or not string.find(var_128_20.name, "split") then
						var_128_20.gameObject:SetActive(true)
					else
						var_128_20.gameObject:SetActive(false)
					end
				end
			end

			local var_128_21 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_21 then
				var_128_19.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_125_1.time_ - 2) / var_128_21)
			end

			if arg_125_1.time_ >= 2 + var_128_21 and arg_125_1.time_ < 2 + var_128_21 + arg_128_0 then
				var_128_19.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_128_22 = arg_125_1.actors_["1037"].transform

			if 3.8 < arg_125_1.time_ and arg_125_1.time_ <= 3.8 + arg_128_0 then
				arg_125_1.var_.moveOldPos1037 = var_128_22.localPosition
				var_128_22.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1037", 3)

				for iter_128_8 = 0, var_128_22.childCount - 1 do
					local var_128_23 = var_128_22:GetChild(iter_128_8)

					if var_128_23.name == "split_1" or not string.find(var_128_23.name, "split") then
						var_128_23.gameObject:SetActive(true)
					else
						var_128_23.gameObject:SetActive(false)
					end
				end
			end

			local var_128_24 = 0.001

			if 3.8 <= arg_125_1.time_ and arg_125_1.time_ < 3.8 + var_128_24 then
				var_128_22.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_125_1.time_ - 3.8) / var_128_24)
			end

			if arg_125_1.time_ >= 3.8 + var_128_24 and arg_125_1.time_ < 3.8 + var_128_24 + arg_128_0 then
				var_128_22.localPosition = Vector3.New(0, -430, -55)
			end

			if 0.133333333333333 < arg_125_1.time_ and arg_125_1.time_ <= 0.133333333333333 + arg_128_0 then
				arg_125_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1.66666666666667 < arg_125_1.time_ and arg_125_1.time_ <= 1.66666666666667 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_27 = 4
			local var_128_28 = 0.325

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_27 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_29 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_29:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_30 = arg_125_1:GetWordFromCfg(425131030)
				local var_128_31 = arg_125_1:FormatText(var_128_30.content)

				arg_125_1.text_.text = var_128_31

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_33 = 13 <= 0 and var_128_28 or var_128_28 * (utf8.len(var_128_31) / 13)

				if (13 <= 0 and var_128_28 or var_128_28 * (utf8.len(var_128_31) / 13)) > 0 and var_128_28 < var_128_33 then
					arg_125_1.talkMaxDuration = var_128_33
					var_128_27 = var_128_27 + 0.3

					if var_128_33 + var_128_27 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_33 + var_128_27
					end
				end

				arg_125_1.text_.text = var_128_31
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131030", "story_v_out_425131.awb") ~= 0 then
					local var_128_34 = manager.audio:GetVoiceLength("story_v_out_425131", "425131030", "story_v_out_425131.awb") / 1000

					if var_128_34 + var_128_27 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_34 + var_128_27
					end

					if var_128_30.prefab_name ~= "" and arg_125_1.actors_[var_128_30.prefab_name] ~= nil then
						local var_128_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_30.prefab_name].transform, "story_v_out_425131", "425131030", "story_v_out_425131.awb")

						arg_125_1:RecordAudio("425131030", var_128_35)
						arg_125_1:RecordAudio("425131030", var_128_35)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_425131", "425131030", "story_v_out_425131.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_425131", "425131030", "story_v_out_425131.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_36 = var_128_27 + 0.3
			local var_128_37 = math.max(var_128_28, arg_125_1.talkMaxDuration)

			if var_128_27 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_36 + var_128_37 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_36) / var_128_37

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_36 + var_128_37 and arg_125_1.time_ < var_128_36 + var_128_37 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play425131031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425131031
		arg_131_1.duration_ = 1.5

		local var_131_0 = {
			zh = 1.233,
			ja = 1.5
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
				arg_131_0:Play425131032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1036"]) and arg_131_1.var_.actorSpriteComps1036 == nil then
				arg_131_1.var_.actorSpriteComps1036 = arg_131_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1036"]) then
				if arg_131_1.var_.actorSpriteComps1036 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1036"]) and arg_131_1.var_.actorSpriteComps1036 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1036 = nil
			end

			local var_134_2 = arg_131_1.actors_["1037"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1037 == nil then
				arg_131_1.var_.actorSpriteComps1037 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps1037 then
					for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_134_5 then
							if arg_131_1.isInRecall_ then
								iter_134_5.color = Color.New(Mathf.Lerp(iter_134_5.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_5.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_5.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_5.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_5.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1037 then
				for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_134_7 then
						iter_134_7.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps1037 = nil
			end

			local var_134_5 = arg_131_1.actors_["1036"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1036 = var_134_5.localPosition
				var_134_5.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1036", 2)

				for iter_134_8 = 0, var_134_5.childCount - 1 do
					local var_134_6 = var_134_5:GetChild(iter_134_8)

					if var_134_6.name == "" or not string.find(var_134_6.name, "split") then
						var_134_6.gameObject:SetActive(true)
					else
						var_134_6.gameObject:SetActive(false)
					end
				end
			end

			local var_134_7 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_131_1.time_ - 0) / var_134_7)
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_134_8 = arg_131_1.actors_["1037"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1037 = var_134_8.localPosition
				var_134_8.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1037", 4)

				for iter_134_9 = 0, var_134_8.childCount - 1 do
					local var_134_9 = var_134_8:GetChild(iter_134_9)

					if var_134_9.name == "split_1" or not string.find(var_134_9.name, "split") then
						var_134_9.gameObject:SetActive(true)
					else
						var_134_9.gameObject:SetActive(false)
					end
				end
			end

			local var_134_10 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_10 then
				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_131_1.time_ - 0) / var_134_10)
			end

			if arg_131_1.time_ >= 0 + var_134_10 and arg_131_1.time_ < 0 + var_134_10 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_134_11 = 0
			local var_134_12 = 0.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(425131031)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 5 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 5)

				if (5 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 5)) > 0 and var_134_12 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131031", "story_v_out_425131.awb") ~= 0 then
					local var_134_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131031", "story_v_out_425131.awb") / 1000

					if var_134_17 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_11
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_425131", "425131031", "story_v_out_425131.awb")

						arg_131_1:RecordAudio("425131031", var_134_18)
						arg_131_1:RecordAudio("425131031", var_134_18)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425131", "425131031", "story_v_out_425131.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425131", "425131031", "story_v_out_425131.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_19 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_19 and arg_131_1.time_ < var_134_11 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
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

		arg_131_1:InitPlayNodeList()
	end,
	Play425131032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425131032
		arg_135_1.duration_ = 4.2

		local var_135_0 = {
			zh = 3.866,
			ja = 4.2
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
				arg_135_0:Play425131033(arg_135_1)
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

			local var_138_2 = arg_135_1.actors_["1036"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1036 == nil then
				arg_135_1.var_.actorSpriteComps1036 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1036 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1036 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1036 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
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

				local var_138_7 = arg_135_1:GetWordFromCfg(425131032)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 14 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 14)

				if (14 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 14)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131032", "story_v_out_425131.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131032", "story_v_out_425131.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_425131", "425131032", "story_v_out_425131.awb")

						arg_135_1:RecordAudio("425131032", var_138_12)
						arg_135_1:RecordAudio("425131032", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_425131", "425131032", "story_v_out_425131.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_425131", "425131032", "story_v_out_425131.awb")
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

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425131033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425131033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play425131034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1037 = arg_139_1.actors_["1037"].transform.localPosition
				arg_139_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1037", 7)

				for iter_142_0 = 0, arg_139_1.actors_["1037"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["1037"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_142_2 = arg_139_1.actors_["1036"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1036 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1036", 7)

				for iter_142_1 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_1)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_5 = 0
			local var_142_6 = 0.575

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(425131033).content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 23 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 23)

				if (23 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 23)) > 0 and var_142_6 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_10 and arg_139_1.time_ < var_142_5 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425131034
		arg_143_1.duration_ = 5

		local var_143_0 = {
			zh = 4.233,
			ja = 5
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play425131035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1036"]) and arg_143_1.var_.actorSpriteComps1036 == nil then
				arg_143_1.var_.actorSpriteComps1036 = arg_143_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1036"]) then
				if arg_143_1.var_.actorSpriteComps1036 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 1, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1036"]) and arg_143_1.var_.actorSpriteComps1036 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1036 = nil
			end

			local var_146_2 = arg_143_1.actors_["1036"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1036 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1036", 3)

				for iter_146_4 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_4)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(0, -388, -250)
			end

			local var_146_5 = 0
			local var_146_6 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(425131034)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 17 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 17)

				if (17 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 17)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131034", "story_v_out_425131.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131034", "story_v_out_425131.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_425131", "425131034", "story_v_out_425131.awb")

						arg_143_1:RecordAudio("425131034", var_146_12)
						arg_143_1:RecordAudio("425131034", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425131", "425131034", "story_v_out_425131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425131", "425131034", "story_v_out_425131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_13 and arg_143_1.time_ < var_146_5 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play425131035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425131035
		arg_147_1.duration_ = 7.8

		local var_147_0 = {
			zh = 7.4,
			ja = 7.8
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
				arg_147_0:Play425131036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1037"]) and arg_147_1.var_.actorSpriteComps1037 == nil then
				arg_147_1.var_.actorSpriteComps1037 = arg_147_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1037"]) then
				if arg_147_1.var_.actorSpriteComps1037 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1037"]) and arg_147_1.var_.actorSpriteComps1037 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1037 = nil
			end

			local var_150_2 = arg_147_1.actors_["1036"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1036 == nil then
				arg_147_1.var_.actorSpriteComps1036 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1036 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_5.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1036 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps1036 = nil
			end

			local var_150_5 = arg_147_1.actors_["1037"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1037 = var_150_5.localPosition
				var_150_5.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1037", 4)

				for iter_150_8 = 0, var_150_5.childCount - 1 do
					local var_150_6 = var_150_5:GetChild(iter_150_8)

					if var_150_6.name == "" or not string.find(var_150_6.name, "split") then
						var_150_6.gameObject:SetActive(true)
					else
						var_150_6.gameObject:SetActive(false)
					end
				end
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_147_1.time_ - 0) / var_150_7)
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_150_8 = arg_147_1.actors_["1036"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1036 = var_150_8.localPosition
				var_150_8.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1036", 2)

				for iter_150_9 = 0, var_150_8.childCount - 1 do
					local var_150_9 = var_150_8:GetChild(iter_150_9)

					if var_150_9.name == "" or not string.find(var_150_9.name, "split") then
						var_150_9.gameObject:SetActive(true)
					else
						var_150_9.gameObject:SetActive(false)
					end
				end
			end

			local var_150_10 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_10 then
				var_150_8.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_147_1.time_ - 0) / var_150_10)
			end

			if arg_147_1.time_ >= 0 + var_150_10 and arg_147_1.time_ < 0 + var_150_10 + arg_150_0 then
				var_150_8.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_150_11 = 0
			local var_150_12 = 0.85

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(425131035)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 34 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 34)

				if (34 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 34)) > 0 and var_150_12 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131035", "story_v_out_425131.awb") ~= 0 then
					local var_150_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131035", "story_v_out_425131.awb") / 1000

					if var_150_17 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_11
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_425131", "425131035", "story_v_out_425131.awb")

						arg_147_1:RecordAudio("425131035", var_150_18)
						arg_147_1:RecordAudio("425131035", var_150_18)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425131", "425131035", "story_v_out_425131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425131", "425131035", "story_v_out_425131.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_19 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_19 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_19

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_19 and arg_147_1.time_ < var_150_11 + var_150_19 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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
				actorName = "1036",
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
	Play425131036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425131036
		arg_151_1.duration_ = 7.5

		local var_151_0 = {
			zh = 6.566,
			ja = 7.5
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
				arg_151_0:Play425131037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.825

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(425131036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 33 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 33)

				if (33 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 33)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131036", "story_v_out_425131.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131036", "story_v_out_425131.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_425131", "425131036", "story_v_out_425131.awb")

						arg_151_1:RecordAudio("425131036", var_154_6)
						arg_151_1:RecordAudio("425131036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425131", "425131036", "story_v_out_425131.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425131", "425131036", "story_v_out_425131.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play425131037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425131037
		arg_155_1.duration_ = 12.07

		local var_155_0 = {
			zh = 7.8,
			ja = 12.066
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
				arg_155_0:Play425131038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.9

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
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

				local var_158_1 = arg_155_1:GetWordFromCfg(425131037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 36 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 36)

				if (36 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 36)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131037", "story_v_out_425131.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131037", "story_v_out_425131.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_425131", "425131037", "story_v_out_425131.awb")

						arg_155_1:RecordAudio("425131037", var_158_6)
						arg_155_1:RecordAudio("425131037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_425131", "425131037", "story_v_out_425131.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_425131", "425131037", "story_v_out_425131.awb")
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
	Play425131038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425131038
		arg_159_1.duration_ = 12.73

		local var_159_0 = {
			zh = 10.533,
			ja = 12.733
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
				arg_159_0:Play425131039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1037 = arg_159_1.actors_["1037"].transform.localPosition
				arg_159_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1037", 4)

				for iter_162_0 = 0, arg_159_1.actors_["1037"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["1037"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_4" then
						var_162_0:SetAsLastSibling()
						var_162_0.gameObject:SetActive(true)

						arg_159_1.var_.actorSpriteSplit1037 = var_162_0.gameObject:GetComponent(typeof(Image))

						arg_159_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_162_1 = 0.5

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_159_1.time_ - 0) / var_162_1)

				if arg_159_1.var_.actorSpriteSplit1037 ~= nil then
					arg_159_1.var_.actorSpriteSplit1037:SetAlpha((arg_159_1.time_ - 0) / var_162_1)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1037"].transform.localPosition = Vector3.New(390, -430, -55)

				if arg_159_1.var_.actorSpriteSplit1037 ~= nil then
					arg_159_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_162_2 = 0
			local var_162_3 = 1.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(425131038)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 46 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 46)

				if (46 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 46)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131038", "story_v_out_425131.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_425131", "425131038", "story_v_out_425131.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_425131", "425131038", "story_v_out_425131.awb")

						arg_159_1:RecordAudio("425131038", var_162_9)
						arg_159_1:RecordAudio("425131038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_425131", "425131038", "story_v_out_425131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_425131", "425131038", "story_v_out_425131.awb")
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

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play425131039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425131039
		arg_163_1.duration_ = 8.7

		local var_163_0 = {
			zh = 6.1,
			ja = 8.7
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
				arg_163_0:Play425131040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1036"]) and arg_163_1.var_.actorSpriteComps1036 == nil then
				arg_163_1.var_.actorSpriteComps1036 = arg_163_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1036"]) then
				if arg_163_1.var_.actorSpriteComps1036 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1036"]) and arg_163_1.var_.actorSpriteComps1036 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1036 = nil
			end

			local var_166_2 = arg_163_1.actors_["1037"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1037 == nil then
				arg_163_1.var_.actorSpriteComps1037 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps1037 then
					for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1037 then
				for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_166_7 then
						iter_166_7.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps1037 = nil
			end

			local var_166_5 = 0
			local var_166_6 = 0.85

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(425131039)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 34 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 34)

				if (34 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 34)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131039", "story_v_out_425131.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131039", "story_v_out_425131.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_425131", "425131039", "story_v_out_425131.awb")

						arg_163_1:RecordAudio("425131039", var_166_12)
						arg_163_1:RecordAudio("425131039", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_425131", "425131039", "story_v_out_425131.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_425131", "425131039", "story_v_out_425131.awb")
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

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play425131040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425131040
		arg_167_1.duration_ = 5.83

		local var_167_0 = {
			zh = 5.833,
			ja = 3.2
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
				arg_167_0:Play425131041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.725

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(425131040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 29 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 29)

				if (29 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 29)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131040", "story_v_out_425131.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131040", "story_v_out_425131.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_425131", "425131040", "story_v_out_425131.awb")

						arg_167_1:RecordAudio("425131040", var_170_6)
						arg_167_1:RecordAudio("425131040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_425131", "425131040", "story_v_out_425131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_425131", "425131040", "story_v_out_425131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play425131041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425131041
		arg_171_1.duration_ = 8.63

		local var_171_0 = {
			zh = 4.566,
			ja = 8.633
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
				arg_171_0:Play425131042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1037"]) and arg_171_1.var_.actorSpriteComps1037 == nil then
				arg_171_1.var_.actorSpriteComps1037 = arg_171_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1037"]) then
				if arg_171_1.var_.actorSpriteComps1037 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1037"]) and arg_171_1.var_.actorSpriteComps1037 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1037 = nil
			end

			local var_174_2 = arg_171_1.actors_["1036"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1036 == nil then
				arg_171_1.var_.actorSpriteComps1036 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps1036 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps1036 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps1036 = nil
			end

			local var_174_5 = arg_171_1.actors_["1037"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1037 = var_174_5.localPosition
				var_174_5.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1037", 4)

				for iter_174_8 = 0, var_174_5.childCount - 1 do
					local var_174_6 = var_174_5:GetChild(iter_174_8)

					if var_174_6.name == "" then
						var_174_6:SetAsLastSibling()
						var_174_6.gameObject:SetActive(true)

						arg_171_1.var_.actorSpriteSplit1037 = var_174_6.gameObject:GetComponent(typeof(Image))

						arg_171_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_174_7 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				var_174_5.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_171_1.time_ - 0) / var_174_7)

				if arg_171_1.var_.actorSpriteSplit1037 ~= nil then
					arg_171_1.var_.actorSpriteSplit1037:SetAlpha((arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				var_174_5.localPosition = Vector3.New(390, -430, -55)

				if arg_171_1.var_.actorSpriteSplit1037 ~= nil then
					arg_171_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_174_8 = 0
			local var_174_9 = 0.55

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(425131041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 22 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 22)

				if (22 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 22)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131041", "story_v_out_425131.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131041", "story_v_out_425131.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_425131", "425131041", "story_v_out_425131.awb")

						arg_171_1:RecordAudio("425131041", var_174_15)
						arg_171_1:RecordAudio("425131041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_425131", "425131041", "story_v_out_425131.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_425131", "425131041", "story_v_out_425131.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play425131042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425131042
		arg_175_1.duration_ = 7.03

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play425131043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1036"]) and arg_175_1.var_.actorSpriteComps1036 == nil then
				arg_175_1.var_.actorSpriteComps1036 = arg_175_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1036"]) then
				if arg_175_1.var_.actorSpriteComps1036 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1036:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1036"]) and arg_175_1.var_.actorSpriteComps1036 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1036 = nil
			end

			local var_178_2 = arg_175_1.actors_["1037"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1037 == nil then
				arg_175_1.var_.actorSpriteComps1037 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1037 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1037 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1037 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 0.85

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(425131042)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 34 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 34)

				if (34 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 34)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131042", "story_v_out_425131.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131042", "story_v_out_425131.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_425131", "425131042", "story_v_out_425131.awb")

						arg_175_1:RecordAudio("425131042", var_178_12)
						arg_175_1:RecordAudio("425131042", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425131", "425131042", "story_v_out_425131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425131", "425131042", "story_v_out_425131.awb")
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

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play425131043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 425131043
		arg_179_1.duration_ = 5.5

		local var_179_0 = {
			zh = 5.333,
			ja = 5.5
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
				arg_179_0:Play425131044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1037"]) and arg_179_1.var_.actorSpriteComps1037 == nil then
				arg_179_1.var_.actorSpriteComps1037 = arg_179_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1037"]) then
				if arg_179_1.var_.actorSpriteComps1037 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1037"]) and arg_179_1.var_.actorSpriteComps1037 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1037 = nil
			end

			local var_182_2 = arg_179_1.actors_["1036"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1036 == nil then
				arg_179_1.var_.actorSpriteComps1036 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps1036 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1036 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1036 = nil
			end

			local var_182_5 = arg_179_1.actors_["1037"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1037 = var_182_5.localPosition
				var_182_5.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1037", 4)

				for iter_182_8 = 0, var_182_5.childCount - 1 do
					local var_182_6 = var_182_5:GetChild(iter_182_8)

					if var_182_6.name == "split_5" then
						var_182_6:SetAsLastSibling()
						var_182_6.gameObject:SetActive(true)

						arg_179_1.var_.actorSpriteSplit1037 = var_182_6.gameObject:GetComponent(typeof(Image))

						arg_179_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_182_7 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_179_1.time_ - 0) / var_182_7)

				if arg_179_1.var_.actorSpriteSplit1037 ~= nil then
					arg_179_1.var_.actorSpriteSplit1037:SetAlpha((arg_179_1.time_ - 0) / var_182_7)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(390, -430, -55)

				if arg_179_1.var_.actorSpriteSplit1037 ~= nil then
					arg_179_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_182_8 = 0
			local var_182_9 = 0.55

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(425131043)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 22 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 22)

				if (22 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 22)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131043", "story_v_out_425131.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131043", "story_v_out_425131.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_425131", "425131043", "story_v_out_425131.awb")

						arg_179_1:RecordAudio("425131043", var_182_15)
						arg_179_1:RecordAudio("425131043", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_425131", "425131043", "story_v_out_425131.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_425131", "425131043", "story_v_out_425131.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play425131044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 425131044
		arg_183_1.duration_ = 10.03

		local var_183_0 = {
			zh = 9.566,
			ja = 10.033
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
				arg_183_0:Play425131045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1036"]) and arg_183_1.var_.actorSpriteComps1036 == nil then
				arg_183_1.var_.actorSpriteComps1036 = arg_183_1.actors_["1036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1036"]) then
				if arg_183_1.var_.actorSpriteComps1036 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1036"]) and arg_183_1.var_.actorSpriteComps1036 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps1036 = nil
			end

			local var_186_2 = arg_183_1.actors_["1037"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1037 == nil then
				arg_183_1.var_.actorSpriteComps1037 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps1037 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_5.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1037 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1037 = nil
			end

			local var_186_5 = arg_183_1.actors_["1036"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1036 = var_186_5.localPosition
				var_186_5.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1036", 2)

				for iter_186_8 = 0, var_186_5.childCount - 1 do
					local var_186_6 = var_186_5:GetChild(iter_186_8)

					if var_186_6.name == "" or not string.find(var_186_6.name, "split") then
						var_186_6.gameObject:SetActive(true)
					else
						var_186_6.gameObject:SetActive(false)
					end
				end
			end

			local var_186_7 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1036, Vector3.New(-390, -388, -250), (arg_183_1.time_ - 0) / var_186_7)
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(-390, -388, -250)
			end

			local var_186_8 = 0
			local var_186_9 = 1.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(425131044)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 44 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 44)

				if (44 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 44)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131044", "story_v_out_425131.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131044", "story_v_out_425131.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_425131", "425131044", "story_v_out_425131.awb")

						arg_183_1:RecordAudio("425131044", var_186_15)
						arg_183_1:RecordAudio("425131044", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_425131", "425131044", "story_v_out_425131.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_425131", "425131044", "story_v_out_425131.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play425131045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 425131045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play425131046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1037 = arg_187_1.actors_["1037"].transform.localPosition
				arg_187_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1037", 7)

				for iter_190_0 = 0, arg_187_1.actors_["1037"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1037"].transform:GetChild(iter_190_0)

					if var_190_0.name == "" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_190_2 = arg_187_1.actors_["1036"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1036 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1036", 7)

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
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_5 = 0
			local var_190_6 = 0.875

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

				local var_190_7 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(425131045).content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 35 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_7) / 35)

				if (35 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_7) / 35)) > 0 and var_190_6 < var_190_9 then
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
				actorName = "1036",
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
	Play425131046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 425131046
		arg_191_1.duration_ = 8.63

		local var_191_0 = {
			zh = 8.633,
			ja = 7.8
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
				arg_191_0:Play425131047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_9000

			if arg_191_1.bgs_.ST2403b == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2403b")
				var_194_0.name = "ST2403b"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.ST2403b = var_194_0
			end

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.ST2403b

				arg_191_1.bgs_.ST2403b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST2403b" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 4

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_4 + 0.3 and arg_191_1.time_ < var_194_4 + 0.3 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_5 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_6 = 2

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 then
				local var_194_7 = Color.New(0, 0, 0)

				var_194_7.a = Mathf.Lerp(0, 1, (arg_191_1.time_ - var_194_5) / var_194_6)
				arg_191_1.mask_.color = var_194_7
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 then
				local var_194_8 = Color.New(0, 0, 0)

				var_194_8.a = 1
				arg_191_1.mask_.color = var_194_8
			end

			local var_194_9 = 2

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_10 = 2

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 then
				local var_194_11 = Color.New(0, 0, 0)

				var_194_11.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_9) / var_194_10)
				arg_191_1.mask_.color = var_194_11
			end

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 then
				local var_194_12 = Color.New(0, 0, 0)

				arg_191_1.mask_.enabled = false
				var_194_12.a = 0
				arg_191_1.mask_.color = var_194_12
			end

			if 3.3 < arg_191_1.time_ and arg_191_1.time_ <= 3.3 + arg_194_0 then
				local var_194_13 = arg_191_1.var_.effect1002

				if not arg_191_1.var_.effect1002 then
					var_194_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_194_13.name = "1002"
					arg_191_1.var_.effect1002 = var_194_13
				else
					var_194_13.transform:SetParent(var_194_9000)
				end

				var_194_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_194_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.2 < arg_191_1.time_ and arg_191_1.time_ <= 5.2 + arg_194_0 then
				if arg_191_1.var_.effect1002 then
					Object.Destroy(arg_191_1.var_.effect1002)

					arg_191_1.var_.effect1002 = nil
				end
			end

			if 0.233333333333333 < arg_191_1.time_ and arg_191_1.time_ <= 0.233333333333333 + arg_194_0 then
				arg_191_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_194_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_191_1.bgmTxt_.text ~= var_194_18 and arg_191_1.bgmTxt_.text ~= "" then
						if arg_191_1.bgmTxt2_.text ~= "" then
							arg_191_1.bgmTxt_.text = arg_191_1.bgmTxt2_.text
						end

						arg_191_1.bgmTxt2_.text = var_194_18

						arg_191_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_191_1.bgmTxt_.text = var_194_18
						arg_191_1.bgmTxt2_.text = var_194_18
					end

					if arg_191_1.bgmTimer then
						arg_191_1.bgmTimer:Stop()

						arg_191_1.bgmTimer = nil
					end

					if arg_191_1.settingData.show_music_name == 1 then
						arg_191_1.musicController:SetSelectedState("show")
						arg_191_1.musicAnimator_:Play("open", 0, 0)

						if arg_191_1.settingData.music_time ~= 0 then
							arg_191_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_191_1.settingData.music_time), function()
								if arg_191_1 == nil or isNil(arg_191_1.bgmTxt_) then
									return
								end

								arg_191_1.musicController:SetSelectedState("hide")
								arg_191_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_191_1.time_ and arg_191_1.time_ <= 0.133333333333333 + arg_194_0 then
				arg_191_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1.7 < arg_191_1.time_ and arg_191_1.time_ <= 1.7 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 3.3 < arg_191_1.time_ and arg_191_1.time_ <= 3.3 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_147", "se_story_147_screen_tearing_glitch", "")
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_22 = 4
			local var_194_23 = 0.225

			if 4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_22 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_24 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_24:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_191_1.dialogCg_.alpha = arg_196_0
				end))
				var_194_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_25 = arg_191_1:GetWordFromCfg(425131046)
				local var_194_26 = arg_191_1:FormatText(var_194_25.content)

				arg_191_1.text_.text = var_194_26

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 9 <= 0 and var_194_23 or var_194_23 * (utf8.len(var_194_26) / 9)

				if (9 <= 0 and var_194_23 or var_194_23 * (utf8.len(var_194_26) / 9)) > 0 and var_194_23 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28
					var_194_22 = var_194_22 + 0.3

					if var_194_28 + var_194_22 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_22
					end
				end

				arg_191_1.text_.text = var_194_26
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131046", "story_v_out_425131.awb") ~= 0 then
					local var_194_29 = manager.audio:GetVoiceLength("story_v_out_425131", "425131046", "story_v_out_425131.awb") / 1000

					if var_194_29 + var_194_22 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_29 + var_194_22
					end

					if var_194_25.prefab_name ~= "" and arg_191_1.actors_[var_194_25.prefab_name] ~= nil then
						local var_194_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_25.prefab_name].transform, "story_v_out_425131", "425131046", "story_v_out_425131.awb")

						arg_191_1:RecordAudio("425131046", var_194_30)
						arg_191_1:RecordAudio("425131046", var_194_30)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_425131", "425131046", "story_v_out_425131.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_425131", "425131046", "story_v_out_425131.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = var_194_22 + 0.3
			local var_194_32 = math.max(var_194_23, arg_191_1.talkMaxDuration)

			if var_194_22 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_31 + var_194_32 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_31) / var_194_32

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_31 + var_194_32 and arg_191_1.time_ < var_194_31 + var_194_32 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play425131047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 425131047
		arg_198_1.duration_ = 6.13

		local var_198_0 = {
			zh = 6.133,
			ja = 4.366
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
				arg_198_0:Play425131048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.225

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(425131047)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 9 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 9)

				if (9 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 9)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131047", "story_v_out_425131.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131047", "story_v_out_425131.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_425131", "425131047", "story_v_out_425131.awb")

						arg_198_1:RecordAudio("425131047", var_201_6)
						arg_198_1:RecordAudio("425131047", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_425131", "425131047", "story_v_out_425131.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_425131", "425131047", "story_v_out_425131.awb")
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
	Play425131048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 425131048
		arg_202_1.duration_ = 4.97

		local var_202_0 = {
			zh = 3.666,
			ja = 4.966
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
				arg_202_0:Play425131049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.175

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:GetWordFromCfg(425131048)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 7 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 7)

				if (7 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 7)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131048", "story_v_out_425131.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131048", "story_v_out_425131.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_425131", "425131048", "story_v_out_425131.awb")

						arg_202_1:RecordAudio("425131048", var_205_6)
						arg_202_1:RecordAudio("425131048", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_425131", "425131048", "story_v_out_425131.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_425131", "425131048", "story_v_out_425131.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play425131049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 425131049
		arg_206_1.duration_ = 8

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play425131050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_9000

			if arg_206_1.bgs_.ST2402 == nil then
				local var_209_0 = Object.Instantiate(arg_206_1.paintGo_)

				var_209_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2402")
				var_209_0.name = "ST2402"
				var_209_0.transform.parent = arg_206_1.stage_.transform
				var_209_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.bgs_.ST2402 = var_209_0
			end

			if 1 < arg_206_1.time_ and arg_206_1.time_ <= 1 + arg_209_0 then
				local var_209_1 = arg_206_1.bgs_.ST2402

				arg_206_1.bgs_.ST2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_209_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_2 = var_209_1:GetComponent("SpriteRenderer")

				if var_209_2 and var_209_2.sprite then
					local var_209_3 = 2 * (var_209_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_209_1.transform.localScale = Vector3.New(var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST2402" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_4 = 3

			if 3 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
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

			local var_209_6 = 1

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

			local var_209_9 = 1

			if 1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
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

			if 1 < arg_206_1.time_ and arg_206_1.time_ <= 1 + arg_209_0 then
				local var_209_13 = arg_206_1.var_.effect10091049

				if not arg_206_1.var_.effect10091049 then
					var_209_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), manager.ui.mainCamera.transform)
					var_209_13.name = "1049"
					arg_206_1.var_.effect10091049 = var_209_13
				else
					var_209_13.transform:SetParent(var_209_9000)
				end

				var_209_13.transform.localPosition = Vector3.New(0, 0, -1.74)
				var_209_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_206_1.time_ and arg_206_1.time_ <= 0.1 + arg_209_0 then
				arg_206_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 0.7 < arg_206_1.time_ and arg_206_1.time_ <= 0.7 + arg_209_0 then
				arg_206_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_209_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_206_1.bgmTxt_.text ~= var_209_19 and arg_206_1.bgmTxt_.text ~= "" then
						if arg_206_1.bgmTxt2_.text ~= "" then
							arg_206_1.bgmTxt_.text = arg_206_1.bgmTxt2_.text
						end

						arg_206_1.bgmTxt2_.text = var_209_19

						arg_206_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_206_1.bgmTxt_.text = var_209_19
						arg_206_1.bgmTxt2_.text = var_209_19
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

			if 0.433333333333333 < arg_206_1.time_ and arg_206_1.time_ <= 0.433333333333333 + arg_209_0 then
				arg_206_1:AudioAction("play", "music", "bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden.awb")

				local var_209_22 = manager.audio:GetAudioName("bgm_activity_4_7_story_garden", "bgm_activity_4_7_story_garden")

				if "" ~= "" then
					if arg_206_1.bgmTxt_.text ~= var_209_22 and arg_206_1.bgmTxt_.text ~= "" then
						if arg_206_1.bgmTxt2_.text ~= "" then
							arg_206_1.bgmTxt_.text = arg_206_1.bgmTxt2_.text
						end

						arg_206_1.bgmTxt2_.text = var_209_22

						arg_206_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_206_1.bgmTxt_.text = var_209_22
						arg_206_1.bgmTxt2_.text = var_209_22
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

			local var_209_23 = 3
			local var_209_24 = 1.05

			if 3 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_25 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_25:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_206_1.dialogCg_.alpha = arg_212_0
				end))
				var_209_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_26 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(425131049).content)

				arg_206_1.text_.text = var_209_26

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_28 = 42 <= 0 and var_209_24 or var_209_24 * (utf8.len(var_209_26) / 42)

				if (42 <= 0 and var_209_24 or var_209_24 * (utf8.len(var_209_26) / 42)) > 0 and var_209_24 < var_209_28 then
					arg_206_1.talkMaxDuration = var_209_28
					var_209_23 = var_209_23 + 0.3

					if var_209_28 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_28 + var_209_23
					end
				end

				arg_206_1.text_.text = var_209_26
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_29 = var_209_23 + 0.3
			local var_209_30 = math.max(var_209_24, arg_206_1.talkMaxDuration)

			if var_209_23 + 0.3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_29 + var_209_30 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_29) / var_209_30

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_29 + var_209_30 and arg_206_1.time_ < var_209_29 + var_209_30 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play425131050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 425131050
		arg_214_1.duration_ = 4.8

		local var_214_0 = {
			zh = 4.8,
			ja = 4
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play425131051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1037"]) and arg_214_1.var_.actorSpriteComps1037 == nil then
				arg_214_1.var_.actorSpriteComps1037 = arg_214_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1037"]) then
				if arg_214_1.var_.actorSpriteComps1037 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1037"]) and arg_214_1.var_.actorSpriteComps1037 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1037 = nil
			end

			local var_217_2 = arg_214_1.actors_["1037"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1037 = var_217_2.localPosition
				var_217_2.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1037", 3)

				for iter_217_4 = 0, var_217_2.childCount - 1 do
					local var_217_3 = var_217_2:GetChild(iter_217_4)

					if var_217_3.name == "split_3" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_2.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_214_1.time_ - 0) / var_217_4)
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_217_5 = 0
			local var_217_6 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(425131050)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 9 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 9)

				if (9 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 9)) > 0 and var_217_6 < var_217_10 then
					arg_214_1.talkMaxDuration = var_217_10

					if var_217_10 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131050", "story_v_out_425131.awb") ~= 0 then
					local var_217_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131050", "story_v_out_425131.awb") / 1000

					if var_217_11 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_5
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_425131", "425131050", "story_v_out_425131.awb")

						arg_214_1:RecordAudio("425131050", var_217_12)
						arg_214_1:RecordAudio("425131050", var_217_12)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_425131", "425131050", "story_v_out_425131.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_425131", "425131050", "story_v_out_425131.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_13 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_13

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_13 and arg_214_1.time_ < var_217_5 + var_217_13 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play425131051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 425131051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play425131052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1037 = arg_218_1.actors_["1037"].transform.localPosition
				arg_218_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("1037", 7)

				for iter_221_0 = 0, arg_218_1.actors_["1037"].transform.childCount - 1 do
					local var_221_0 = arg_218_1.actors_["1037"].transform:GetChild(iter_221_0)

					if var_221_0.name == "" or not string.find(var_221_0.name, "split") then
						var_221_0.gameObject:SetActive(true)
					else
						var_221_0.gameObject:SetActive(false)
					end
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_218_1.time_ - 0) / var_221_1)
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_221_2 = 0
			local var_221_3 = 1.1

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(425131051).content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 44 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 44)

				if (44 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 44)) > 0 and var_221_3 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_2 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_2
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_3, arg_218_1.talkMaxDuration)

			if var_221_2 <= arg_218_1.time_ and arg_218_1.time_ < var_221_2 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_2) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_2 + var_221_7 and arg_218_1.time_ < var_221_2 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play425131052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 425131052
		arg_222_1.duration_ = 10.57

		local var_222_0 = {
			zh = 7.166,
			ja = 10.566
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play425131053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if arg_222_1.actors_["10157"] == nil then
				local var_225_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10157")

				if not isNil(var_225_0) then
					local var_225_1 = Object.Instantiate(var_225_0, arg_222_1.canvasGo_.transform)

					var_225_1.transform:SetSiblingIndex(1)

					var_225_1.name = "10157"
					var_225_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_222_1.actors_["10157"] = var_225_1

					if arg_222_1.isInRecall_ then
						for iter_225_0, iter_225_1 in ipairs((var_225_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_225_1.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_225_2 = arg_222_1.actors_["10157"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10157 == nil then
				arg_222_1.var_.actorSpriteComps10157 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps10157 then
					for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_225_3 then
							if arg_222_1.isInRecall_ then
								iter_225_3.color = Color.New(Mathf.Lerp(iter_225_3.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_3.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_3.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_3.color.r, 1, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_3.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10157 then
				for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_225_5 then
						iter_225_5.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps10157 = nil
			end

			local var_225_5 = arg_222_1.actors_["10157"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10157 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10157", 3)

				for iter_225_6 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_6)

					if var_225_6.name == "" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10157, Vector3.New(0, -408, 115), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(0, -408, 115)
			end

			local var_225_8 = 0
			local var_225_9 = 0.825

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(425131052)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 33 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 33)

				if (33 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 33)) > 0 and var_225_9 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131052", "story_v_out_425131.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131052", "story_v_out_425131.awb") / 1000

					if var_225_14 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_8
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_425131", "425131052", "story_v_out_425131.awb")

						arg_222_1:RecordAudio("425131052", var_225_15)
						arg_222_1:RecordAudio("425131052", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_425131", "425131052", "story_v_out_425131.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_425131", "425131052", "story_v_out_425131.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_16 and arg_222_1.time_ < var_225_8 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play425131053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 425131053
		arg_226_1.duration_ = 3.1

		local var_226_0 = {
			zh = 3.1,
			ja = 2.1
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play425131054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1037"]) and arg_226_1.var_.actorSpriteComps1037 == nil then
				arg_226_1.var_.actorSpriteComps1037 = arg_226_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1037"]) then
				if arg_226_1.var_.actorSpriteComps1037 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1037"]) and arg_226_1.var_.actorSpriteComps1037 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps1037 = nil
			end

			local var_229_2 = arg_226_1.actors_["10157"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10157 == nil then
				arg_226_1.var_.actorSpriteComps10157 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps10157 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								iter_229_5.color = Color.New(Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_5.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_5.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10157 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps10157 = nil
			end

			local var_229_5 = arg_226_1.actors_["1037"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1037 = var_229_5.localPosition
				var_229_5.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1037", 4)

				for iter_229_8 = 0, var_229_5.childCount - 1 do
					local var_229_6 = var_229_5:GetChild(iter_229_8)

					if var_229_6.name == "split_5" or not string.find(var_229_6.name, "split") then
						var_229_6.gameObject:SetActive(true)
					else
						var_229_6.gameObject:SetActive(false)
					end
				end
			end

			local var_229_7 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				var_229_5.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_226_1.time_ - 0) / var_229_7)
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				var_229_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_229_8 = arg_226_1.actors_["10157"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10157 = var_229_8.localPosition
				var_229_8.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10157", 2)

				for iter_229_9 = 0, var_229_8.childCount - 1 do
					local var_229_9 = var_229_8:GetChild(iter_229_9)

					if var_229_9.name == "" or not string.find(var_229_9.name, "split") then
						var_229_9.gameObject:SetActive(true)
					else
						var_229_9.gameObject:SetActive(false)
					end
				end
			end

			local var_229_10 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_10 then
				var_229_8.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_226_1.time_ - 0) / var_229_10)
			end

			if arg_226_1.time_ >= 0 + var_229_10 and arg_226_1.time_ < 0 + var_229_10 + arg_229_0 then
				var_229_8.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_229_11 = 0
			local var_229_12 = 0.075

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_11 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_13 = arg_226_1:GetWordFromCfg(425131053)
				local var_229_14 = arg_226_1:FormatText(var_229_13.content)

				arg_226_1.text_.text = var_229_14

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_16 = 3 <= 0 and var_229_12 or var_229_12 * (utf8.len(var_229_14) / 3)

				if (3 <= 0 and var_229_12 or var_229_12 * (utf8.len(var_229_14) / 3)) > 0 and var_229_12 < var_229_16 then
					arg_226_1.talkMaxDuration = var_229_16

					if var_229_16 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_16 + var_229_11
					end
				end

				arg_226_1.text_.text = var_229_14
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131053", "story_v_out_425131.awb") ~= 0 then
					local var_229_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131053", "story_v_out_425131.awb") / 1000

					if var_229_17 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_17 + var_229_11
					end

					if var_229_13.prefab_name ~= "" and arg_226_1.actors_[var_229_13.prefab_name] ~= nil then
						local var_229_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_13.prefab_name].transform, "story_v_out_425131", "425131053", "story_v_out_425131.awb")

						arg_226_1:RecordAudio("425131053", var_229_18)
						arg_226_1:RecordAudio("425131053", var_229_18)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_425131", "425131053", "story_v_out_425131.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_425131", "425131053", "story_v_out_425131.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_19 = math.max(var_229_12, arg_226_1.talkMaxDuration)

			if var_229_11 <= arg_226_1.time_ and arg_226_1.time_ < var_229_11 + var_229_19 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_11) / var_229_19

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_11 + var_229_19 and arg_226_1.time_ < var_229_11 + var_229_19 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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
				actorName = "10157",
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
	Play425131054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 425131054
		arg_230_1.duration_ = 3.53

		local var_230_0 = {
			zh = 3.133,
			ja = 3.533
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play425131055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10157"]) and arg_230_1.var_.actorSpriteComps10157 == nil then
				arg_230_1.var_.actorSpriteComps10157 = arg_230_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10157"]) then
				if arg_230_1.var_.actorSpriteComps10157 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10157"]) and arg_230_1.var_.actorSpriteComps10157 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps10157 = nil
			end

			local var_233_2 = arg_230_1.actors_["1037"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps1037 == nil then
				arg_230_1.var_.actorSpriteComps1037 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps1037 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								iter_233_5.color = Color.New(Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_3), Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_3), (Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_3)))
							else
								local var_233_4 = Mathf.Lerp(iter_233_5.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_3)

								iter_233_5.color = Color.New(var_233_4, var_233_4, var_233_4)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps1037 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps1037 = nil
			end

			local var_233_5 = arg_230_1.actors_["10157"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10157 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10157", 2)

				for iter_233_8 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_8)

					if var_233_6.name == "split_5" or not string.find(var_233_6.name, "split") then
						var_233_6.gameObject:SetActive(true)
					else
						var_233_6.gameObject:SetActive(false)
					end
				end
			end

			local var_233_7 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_230_1.time_ - 0) / var_233_7)
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_233_8 = 0
			local var_233_9 = 0.225

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:GetWordFromCfg(425131054)
				local var_233_11 = arg_230_1:FormatText(var_233_10.content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 9 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 9)

				if (9 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 9)) > 0 and var_233_9 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131054", "story_v_out_425131.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131054", "story_v_out_425131.awb") / 1000

					if var_233_14 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_8
					end

					if var_233_10.prefab_name ~= "" and arg_230_1.actors_[var_233_10.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_10.prefab_name].transform, "story_v_out_425131", "425131054", "story_v_out_425131.awb")

						arg_230_1:RecordAudio("425131054", var_233_15)
						arg_230_1:RecordAudio("425131054", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_425131", "425131054", "story_v_out_425131.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_425131", "425131054", "story_v_out_425131.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play425131055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 425131055
		arg_234_1.duration_ = 4.63

		local var_234_0 = {
			zh = 2.366,
			ja = 4.633
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play425131056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1037"]) and arg_234_1.var_.actorSpriteComps1037 == nil then
				arg_234_1.var_.actorSpriteComps1037 = arg_234_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1037"]) then
				if arg_234_1.var_.actorSpriteComps1037 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 1, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1037"]) and arg_234_1.var_.actorSpriteComps1037 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps1037 = nil
			end

			local var_237_2 = arg_234_1.actors_["10157"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10157 == nil then
				arg_234_1.var_.actorSpriteComps10157 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps10157 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								iter_237_5.color = Color.New(Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_3), Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_3), (Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_3)))
							else
								local var_237_4 = Mathf.Lerp(iter_237_5.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_3)

								iter_237_5.color = Color.New(var_237_4, var_237_4, var_237_4)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10157 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps10157 = nil
			end

			local var_237_5 = arg_234_1.actors_["1037"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1037 = var_237_5.localPosition
				var_237_5.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1037", 4)

				for iter_237_8 = 0, var_237_5.childCount - 1 do
					local var_237_6 = var_237_5:GetChild(iter_237_8)

					if var_237_6.name == "split_5" or not string.find(var_237_6.name, "split") then
						var_237_6.gameObject:SetActive(true)
					else
						var_237_6.gameObject:SetActive(false)
					end
				end
			end

			local var_237_7 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				var_237_5.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_234_1.time_ - 0) / var_237_7)
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				var_237_5.localPosition = Vector3.New(390, -430, -55)
			end

			local var_237_8 = 0
			local var_237_9 = 0.25

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_10 = arg_234_1:GetWordFromCfg(425131055)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 10 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 10)

				if (10 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 10)) > 0 and var_237_9 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131055", "story_v_out_425131.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131055", "story_v_out_425131.awb") / 1000

					if var_237_14 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_8
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_out_425131", "425131055", "story_v_out_425131.awb")

						arg_234_1:RecordAudio("425131055", var_237_15)
						arg_234_1:RecordAudio("425131055", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_425131", "425131055", "story_v_out_425131.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_425131", "425131055", "story_v_out_425131.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_16 and arg_234_1.time_ < var_237_8 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play425131056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 425131056
		arg_238_1.duration_ = 7.77

		local var_238_0 = {
			zh = 4.7,
			ja = 7.766
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
				arg_238_0:Play425131057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10157"]) and arg_238_1.var_.actorSpriteComps10157 == nil then
				arg_238_1.var_.actorSpriteComps10157 = arg_238_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10157"]) then
				if arg_238_1.var_.actorSpriteComps10157 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10157"]) and arg_238_1.var_.actorSpriteComps10157 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps10157 = nil
			end

			local var_241_2 = arg_238_1.actors_["1037"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1037 == nil then
				arg_238_1.var_.actorSpriteComps1037 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps1037 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_241_5 then
							if arg_238_1.isInRecall_ then
								iter_241_5.color = Color.New(Mathf.Lerp(iter_241_5.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_3), Mathf.Lerp(iter_241_5.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_3), (Mathf.Lerp(iter_241_5.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_3)))
							else
								local var_241_4 = Mathf.Lerp(iter_241_5.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_3)

								iter_241_5.color = Color.New(var_241_4, var_241_4, var_241_4)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1037 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_241_7 then
						iter_241_7.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps1037 = nil
			end

			local var_241_5 = arg_238_1.actors_["10157"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10157 = var_241_5.localPosition
				var_241_5.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10157", 2)

				for iter_241_8 = 0, var_241_5.childCount - 1 do
					local var_241_6 = var_241_5:GetChild(iter_241_8)

					if var_241_6.name == "" or not string.find(var_241_6.name, "split") then
						var_241_6.gameObject:SetActive(true)
					else
						var_241_6.gameObject:SetActive(false)
					end
				end
			end

			local var_241_7 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				var_241_5.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_238_1.time_ - 0) / var_241_7)
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				var_241_5.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_241_8 = 0
			local var_241_9 = 0.55

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_10 = arg_238_1:GetWordFromCfg(425131056)
				local var_241_11 = arg_238_1:FormatText(var_241_10.content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 22 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 22)

				if (22 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 22)) > 0 and var_241_9 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131056", "story_v_out_425131.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131056", "story_v_out_425131.awb") / 1000

					if var_241_14 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_8
					end

					if var_241_10.prefab_name ~= "" and arg_238_1.actors_[var_241_10.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_10.prefab_name].transform, "story_v_out_425131", "425131056", "story_v_out_425131.awb")

						arg_238_1:RecordAudio("425131056", var_241_15)
						arg_238_1:RecordAudio("425131056", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_425131", "425131056", "story_v_out_425131.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_425131", "425131056", "story_v_out_425131.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_9, arg_238_1.talkMaxDuration)

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_8) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_8 + var_241_16 and arg_238_1.time_ < var_241_8 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
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
	Play425131057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 425131057
		arg_242_1.duration_ = 4.67

		local var_242_0 = {
			zh = 3.333,
			ja = 4.666
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
				arg_242_0:Play425131058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1037"]) and arg_242_1.var_.actorSpriteComps1037 == nil then
				arg_242_1.var_.actorSpriteComps1037 = arg_242_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1037"]) then
				if arg_242_1.var_.actorSpriteComps1037 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 1, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1037"]) and arg_242_1.var_.actorSpriteComps1037 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps1037 = nil
			end

			local var_245_2 = arg_242_1.actors_["10157"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10157 == nil then
				arg_242_1.var_.actorSpriteComps10157 = var_245_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_3 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.actorSpriteComps10157 then
					for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_245_5 then
							if arg_242_1.isInRecall_ then
								iter_245_5.color = Color.New(Mathf.Lerp(iter_245_5.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_3), Mathf.Lerp(iter_245_5.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_3), (Mathf.Lerp(iter_245_5.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_3)))
							else
								local var_245_4 = Mathf.Lerp(iter_245_5.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_3)

								iter_245_5.color = Color.New(var_245_4, var_245_4, var_245_4)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10157 then
				for iter_245_6, iter_245_7 in pairs(arg_242_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_245_7 then
						iter_245_7.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps10157 = nil
			end

			local var_245_5 = arg_242_1.actors_["1037"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1037 = var_245_5.localPosition
				var_245_5.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1037", 4)

				for iter_245_8 = 0, var_245_5.childCount - 1 do
					local var_245_6 = var_245_5:GetChild(iter_245_8)

					if var_245_6.name == "split_4" then
						var_245_6:SetAsLastSibling()
						var_245_6.gameObject:SetActive(true)

						arg_242_1.var_.actorSpriteSplit1037 = var_245_6.gameObject:GetComponent(typeof(Image))

						arg_242_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_245_7 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				var_245_5.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_242_1.time_ - 0) / var_245_7)

				if arg_242_1.var_.actorSpriteSplit1037 ~= nil then
					arg_242_1.var_.actorSpriteSplit1037:SetAlpha((arg_242_1.time_ - 0) / var_245_7)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				var_245_5.localPosition = Vector3.New(390, -430, -55)

				if arg_242_1.var_.actorSpriteSplit1037 ~= nil then
					arg_242_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_245_8 = 0
			local var_245_9 = 0.375

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(425131057)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 15 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 15)

				if (15 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 15)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131057", "story_v_out_425131.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131057", "story_v_out_425131.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_out_425131", "425131057", "story_v_out_425131.awb")

						arg_242_1:RecordAudio("425131057", var_245_15)
						arg_242_1:RecordAudio("425131057", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_425131", "425131057", "story_v_out_425131.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_425131", "425131057", "story_v_out_425131.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play425131058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 425131058
		arg_246_1.duration_ = 7.97

		local var_246_0 = {
			zh = 6.466,
			ja = 7.966
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play425131059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["10157"]) and arg_246_1.var_.actorSpriteComps10157 == nil then
				arg_246_1.var_.actorSpriteComps10157 = arg_246_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["10157"]) then
				if arg_246_1.var_.actorSpriteComps10157 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor1.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor1.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor1.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 1, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["10157"]) and arg_246_1.var_.actorSpriteComps10157 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_246_1.var_.actorSpriteComps10157 = nil
			end

			local var_249_2 = arg_246_1.actors_["1037"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps1037 == nil then
				arg_246_1.var_.actorSpriteComps1037 = var_249_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_3 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.actorSpriteComps1037 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								iter_249_5.color = Color.New(Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_3), Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_3), (Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_3)))
							else
								local var_249_4 = Mathf.Lerp(iter_249_5.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_3)

								iter_249_5.color = Color.New(var_249_4, var_249_4, var_249_4)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps1037 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_249_7 then
						iter_249_7.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps1037 = nil
			end

			local var_249_5 = arg_246_1.actors_["10157"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10157 = var_249_5.localPosition
				var_249_5.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("10157", 2)

				for iter_249_8 = 0, var_249_5.childCount - 1 do
					local var_249_6 = var_249_5:GetChild(iter_249_8)

					if var_249_6.name == "" or not string.find(var_249_6.name, "split") then
						var_249_6.gameObject:SetActive(true)
					else
						var_249_6.gameObject:SetActive(false)
					end
				end
			end

			local var_249_7 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				var_249_5.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_246_1.time_ - 0) / var_249_7)
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				var_249_5.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_249_8 = 0
			local var_249_9 = 0.625

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(425131058)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 25 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 25)

				if (25 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 25)) > 0 and var_249_9 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131058", "story_v_out_425131.awb") ~= 0 then
					local var_249_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131058", "story_v_out_425131.awb") / 1000

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end

					if var_249_10.prefab_name ~= "" and arg_246_1.actors_[var_249_10.prefab_name] ~= nil then
						local var_249_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_10.prefab_name].transform, "story_v_out_425131", "425131058", "story_v_out_425131.awb")

						arg_246_1:RecordAudio("425131058", var_249_15)
						arg_246_1:RecordAudio("425131058", var_249_15)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_425131", "425131058", "story_v_out_425131.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_425131", "425131058", "story_v_out_425131.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play425131059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 425131059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play425131060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1037 = arg_250_1.actors_["1037"].transform.localPosition
				arg_250_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1037", 7)

				for iter_253_0 = 0, arg_250_1.actors_["1037"].transform.childCount - 1 do
					local var_253_0 = arg_250_1.actors_["1037"].transform:GetChild(iter_253_0)

					if var_253_0.name == "" or not string.find(var_253_0.name, "split") then
						var_253_0.gameObject:SetActive(true)
					else
						var_253_0.gameObject:SetActive(false)
					end
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_250_1.time_ - 0) / var_253_1)
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_253_2 = arg_250_1.actors_["10157"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10157 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10157", 7)

				for iter_253_1 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_1)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10157, Vector3.New(0, -2000, 0), (arg_250_1.time_ - 0) / var_253_4)
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_5 = 0
			local var_253_6 = 0.9

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(425131059).content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 36 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 36)

				if (36 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 36)) > 0 and var_253_6 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_10 and arg_250_1.time_ < var_253_5 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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
				actorName = "10157",
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
	Play425131060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 425131060
		arg_254_1.duration_ = 4.6

		local var_254_0 = {
			zh = 3.766,
			ja = 4.6
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play425131061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1037"]) and arg_254_1.var_.actorSpriteComps1037 == nil then
				arg_254_1.var_.actorSpriteComps1037 = arg_254_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1037"]) then
				if arg_254_1.var_.actorSpriteComps1037 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1037"]) and arg_254_1.var_.actorSpriteComps1037 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps1037 = nil
			end

			local var_257_2 = arg_254_1.actors_["1037"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1037 = var_257_2.localPosition
				var_257_2.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1037", 3)

				for iter_257_4 = 0, var_257_2.childCount - 1 do
					local var_257_3 = var_257_2:GetChild(iter_257_4)

					if var_257_3.name == "" or not string.find(var_257_3.name, "split") then
						var_257_3.gameObject:SetActive(true)
					else
						var_257_3.gameObject:SetActive(false)
					end
				end
			end

			local var_257_4 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_254_1.time_ - 0) / var_257_4)
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_257_5 = 0
			local var_257_6 = 0.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_7 = arg_254_1:GetWordFromCfg(425131060)
				local var_257_8 = arg_254_1:FormatText(var_257_7.content)

				arg_254_1.text_.text = var_257_8

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_10 = 16 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_8) / 16)

				if (16 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_8) / 16)) > 0 and var_257_6 < var_257_10 then
					arg_254_1.talkMaxDuration = var_257_10

					if var_257_10 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_5
					end
				end

				arg_254_1.text_.text = var_257_8
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131060", "story_v_out_425131.awb") ~= 0 then
					local var_257_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131060", "story_v_out_425131.awb") / 1000

					if var_257_11 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_5
					end

					if var_257_7.prefab_name ~= "" and arg_254_1.actors_[var_257_7.prefab_name] ~= nil then
						local var_257_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_7.prefab_name].transform, "story_v_out_425131", "425131060", "story_v_out_425131.awb")

						arg_254_1:RecordAudio("425131060", var_257_12)
						arg_254_1:RecordAudio("425131060", var_257_12)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_425131", "425131060", "story_v_out_425131.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_425131", "425131060", "story_v_out_425131.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_6, arg_254_1.talkMaxDuration)

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_5) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_5 + var_257_13 and arg_254_1.time_ < var_257_5 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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

		arg_254_1:InitPlayNodeList()
	end,
	Play425131061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 425131061
		arg_258_1.duration_ = 5.3

		local var_258_0 = {
			zh = 4.666,
			ja = 5.3
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
				arg_258_0:Play425131062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["10157"]) and arg_258_1.var_.actorSpriteComps10157 == nil then
				arg_258_1.var_.actorSpriteComps10157 = arg_258_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["10157"]) then
				if arg_258_1.var_.actorSpriteComps10157 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["10157"]) and arg_258_1.var_.actorSpriteComps10157 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps10157 = nil
			end

			local var_261_2 = arg_258_1.actors_["1037"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps1037 == nil then
				arg_258_1.var_.actorSpriteComps1037 = var_261_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_3 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 and not isNil(var_261_2) then
				if arg_258_1.var_.actorSpriteComps1037 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								iter_261_5.color = Color.New(Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_3), Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_3), (Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_3)))
							else
								local var_261_4 = Mathf.Lerp(iter_261_5.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_3)

								iter_261_5.color = Color.New(var_261_4, var_261_4, var_261_4)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps1037 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_261_7 then
						iter_261_7.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps1037 = nil
			end

			local var_261_5 = arg_258_1.actors_["10157"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos10157 = var_261_5.localPosition
				var_261_5.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("10157", 2)

				for iter_261_8 = 0, var_261_5.childCount - 1 do
					local var_261_6 = var_261_5:GetChild(iter_261_8)

					if var_261_6.name == "split_2" or not string.find(var_261_6.name, "split") then
						var_261_6.gameObject:SetActive(true)
					else
						var_261_6.gameObject:SetActive(false)
					end
				end
			end

			local var_261_7 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_258_1.time_ - 0) / var_261_7)
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_261_8 = arg_258_1.actors_["1037"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1037 = var_261_8.localPosition
				var_261_8.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1037", 4)

				for iter_261_9 = 0, var_261_8.childCount - 1 do
					local var_261_9 = var_261_8:GetChild(iter_261_9)

					if var_261_9.name == "" or not string.find(var_261_9.name, "split") then
						var_261_9.gameObject:SetActive(true)
					else
						var_261_9.gameObject:SetActive(false)
					end
				end
			end

			local var_261_10 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_10 then
				var_261_8.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_258_1.time_ - 0) / var_261_10)
			end

			if arg_258_1.time_ >= 0 + var_261_10 and arg_258_1.time_ < 0 + var_261_10 + arg_261_0 then
				var_261_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_261_11 = 0
			local var_261_12 = 0.4

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_11 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_13 = arg_258_1:GetWordFromCfg(425131061)
				local var_261_14 = arg_258_1:FormatText(var_261_13.content)

				arg_258_1.text_.text = var_261_14

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_16 = 39 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_14) / 39)

				if (39 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_14) / 39)) > 0 and var_261_12 < var_261_16 then
					arg_258_1.talkMaxDuration = var_261_16

					if var_261_16 + var_261_11 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_16 + var_261_11
					end
				end

				arg_258_1.text_.text = var_261_14
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131061", "story_v_out_425131.awb") ~= 0 then
					local var_261_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131061", "story_v_out_425131.awb") / 1000

					if var_261_17 + var_261_11 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_17 + var_261_11
					end

					if var_261_13.prefab_name ~= "" and arg_258_1.actors_[var_261_13.prefab_name] ~= nil then
						local var_261_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_13.prefab_name].transform, "story_v_out_425131", "425131061", "story_v_out_425131.awb")

						arg_258_1:RecordAudio("425131061", var_261_18)
						arg_258_1:RecordAudio("425131061", var_261_18)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_425131", "425131061", "story_v_out_425131.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_425131", "425131061", "story_v_out_425131.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_19 = math.max(var_261_12, arg_258_1.talkMaxDuration)

			if var_261_11 <= arg_258_1.time_ and arg_258_1.time_ < var_261_11 + var_261_19 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_11) / var_261_19

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_11 + var_261_19 and arg_258_1.time_ < var_261_11 + var_261_19 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
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

		arg_258_1:InitPlayNodeList()
	end,
	Play425131062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 425131062
		arg_262_1.duration_ = 10.17

		local var_262_0 = {
			zh = 7.133,
			ja = 10.166
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
				arg_262_0:Play425131063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.75

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:GetWordFromCfg(425131062)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 53 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 53)

				if (53 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 53)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131062", "story_v_out_425131.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131062", "story_v_out_425131.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_425131", "425131062", "story_v_out_425131.awb")

						arg_262_1:RecordAudio("425131062", var_265_6)
						arg_262_1:RecordAudio("425131062", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_425131", "425131062", "story_v_out_425131.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_425131", "425131062", "story_v_out_425131.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play425131063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 425131063
		arg_266_1.duration_ = 5.27

		local var_266_0 = {
			zh = 4.033,
			ja = 5.266
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play425131064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1037"]) and arg_266_1.var_.actorSpriteComps1037 == nil then
				arg_266_1.var_.actorSpriteComps1037 = arg_266_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1037"]) then
				if arg_266_1.var_.actorSpriteComps1037 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 1, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1037"]) and arg_266_1.var_.actorSpriteComps1037 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps1037 = nil
			end

			local var_269_2 = arg_266_1.actors_["10157"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps10157 == nil then
				arg_266_1.var_.actorSpriteComps10157 = var_269_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_3 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.actorSpriteComps10157 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_269_5 then
							if arg_266_1.isInRecall_ then
								iter_269_5.color = Color.New(Mathf.Lerp(iter_269_5.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_3), Mathf.Lerp(iter_269_5.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_3), (Mathf.Lerp(iter_269_5.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_3)))
							else
								local var_269_4 = Mathf.Lerp(iter_269_5.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_3)

								iter_269_5.color = Color.New(var_269_4, var_269_4, var_269_4)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps10157 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_269_7 then
						iter_269_7.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps10157 = nil
			end

			local var_269_5 = arg_266_1.actors_["1037"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1037 = var_269_5.localPosition
				var_269_5.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("1037", 4)

				for iter_269_8 = 0, var_269_5.childCount - 1 do
					local var_269_6 = var_269_5:GetChild(iter_269_8)

					if var_269_6.name == "split_4" then
						var_269_6:SetAsLastSibling()
						var_269_6.gameObject:SetActive(true)

						arg_266_1.var_.actorSpriteSplit1037 = var_269_6.gameObject:GetComponent(typeof(Image))

						arg_266_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_269_7 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				var_269_5.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_266_1.time_ - 0) / var_269_7)

				if arg_266_1.var_.actorSpriteSplit1037 ~= nil then
					arg_266_1.var_.actorSpriteSplit1037:SetAlpha((arg_266_1.time_ - 0) / var_269_7)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				var_269_5.localPosition = Vector3.New(390, -430, -55)

				if arg_266_1.var_.actorSpriteSplit1037 ~= nil then
					arg_266_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_269_8 = 0
			local var_269_9 = 0.425

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(425131063)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 17 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 17)

				if (17 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 17)) > 0 and var_269_9 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131063", "story_v_out_425131.awb") ~= 0 then
					local var_269_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131063", "story_v_out_425131.awb") / 1000

					if var_269_14 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_8
					end

					if var_269_10.prefab_name ~= "" and arg_266_1.actors_[var_269_10.prefab_name] ~= nil then
						local var_269_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_10.prefab_name].transform, "story_v_out_425131", "425131063", "story_v_out_425131.awb")

						arg_266_1:RecordAudio("425131063", var_269_15)
						arg_266_1:RecordAudio("425131063", var_269_15)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_425131", "425131063", "story_v_out_425131.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_425131", "425131063", "story_v_out_425131.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_16 and arg_266_1.time_ < var_269_8 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play425131064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 425131064
		arg_270_1.duration_ = 1.63

		local var_270_0 = {
			zh = 1.633,
			ja = 1.2
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play425131065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10157"]) and arg_270_1.var_.actorSpriteComps10157 == nil then
				arg_270_1.var_.actorSpriteComps10157 = arg_270_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10157"]) then
				if arg_270_1.var_.actorSpriteComps10157 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10157"]) and arg_270_1.var_.actorSpriteComps10157 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10157 = nil
			end

			local var_273_2 = arg_270_1.actors_["1037"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1037 == nil then
				arg_270_1.var_.actorSpriteComps1037 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps1037 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_273_5 then
							if arg_270_1.isInRecall_ then
								iter_273_5.color = Color.New(Mathf.Lerp(iter_273_5.color.r, arg_270_1.hightColor2.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_5.color.g, arg_270_1.hightColor2.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_5.color.b, arg_270_1.hightColor2.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_5.color.r, 0.5, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_5.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1037 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_273_7 then
						iter_273_7.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps1037 = nil
			end

			local var_273_5 = arg_270_1.actors_["10157"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10157 = var_273_5.localPosition
				var_273_5.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10157", 2)

				for iter_273_8 = 0, var_273_5.childCount - 1 do
					local var_273_6 = var_273_5:GetChild(iter_273_8)

					if var_273_6.name == "split_4" or not string.find(var_273_6.name, "split") then
						var_273_6.gameObject:SetActive(true)
					else
						var_273_6.gameObject:SetActive(false)
					end
				end
			end

			local var_273_7 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10157, Vector3.New(-390, -408, 115), (arg_270_1.time_ - 0) / var_273_7)
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(-390, -408, 115)
			end

			local var_273_8 = 0
			local var_273_9 = 0.125

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_10 = arg_270_1:GetWordFromCfg(425131064)
				local var_273_11 = arg_270_1:FormatText(var_273_10.content)

				arg_270_1.text_.text = var_273_11

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 5 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 5)

				if (5 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 5)) > 0 and var_273_9 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_11
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131064", "story_v_out_425131.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131064", "story_v_out_425131.awb") / 1000

					if var_273_14 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_8
					end

					if var_273_10.prefab_name ~= "" and arg_270_1.actors_[var_273_10.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_10.prefab_name].transform, "story_v_out_425131", "425131064", "story_v_out_425131.awb")

						arg_270_1:RecordAudio("425131064", var_273_15)
						arg_270_1:RecordAudio("425131064", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_425131", "425131064", "story_v_out_425131.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_425131", "425131064", "story_v_out_425131.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_8) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_16 and arg_270_1.time_ < var_273_8 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
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
	Play425131065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 425131065
		arg_274_1.duration_ = 7.97

		local var_274_0 = {
			zh = 6.866,
			ja = 7.966
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play425131066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1037"]) and arg_274_1.var_.actorSpriteComps1037 == nil then
				arg_274_1.var_.actorSpriteComps1037 = arg_274_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1037"]) then
				if arg_274_1.var_.actorSpriteComps1037 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor1.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor1.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor1.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 1, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1037"]) and arg_274_1.var_.actorSpriteComps1037 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_274_1.var_.actorSpriteComps1037 = nil
			end

			local var_277_2 = arg_274_1.actors_["10157"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps10157 == nil then
				arg_274_1.var_.actorSpriteComps10157 = var_277_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_3 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 and not isNil(var_277_2) then
				if arg_274_1.var_.actorSpriteComps10157 then
					for iter_277_4, iter_277_5 in pairs(arg_274_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_277_5 then
							if arg_274_1.isInRecall_ then
								iter_277_5.color = Color.New(Mathf.Lerp(iter_277_5.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_3), Mathf.Lerp(iter_277_5.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_3), (Mathf.Lerp(iter_277_5.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_3)))
							else
								local var_277_4 = Mathf.Lerp(iter_277_5.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_3)

								iter_277_5.color = Color.New(var_277_4, var_277_4, var_277_4)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps10157 then
				for iter_277_6, iter_277_7 in pairs(arg_274_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_277_7 then
						iter_277_7.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps10157 = nil
			end

			local var_277_5 = arg_274_1.actors_["1037"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1037 = var_277_5.localPosition
				var_277_5.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1037", 4)

				for iter_277_8 = 0, var_277_5.childCount - 1 do
					local var_277_6 = var_277_5:GetChild(iter_277_8)

					if var_277_6.name == "" then
						var_277_6:SetAsLastSibling()
						var_277_6.gameObject:SetActive(true)

						arg_274_1.var_.actorSpriteSplit1037 = var_277_6.gameObject:GetComponent(typeof(Image))

						arg_274_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_277_7 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				var_277_5.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_274_1.time_ - 0) / var_277_7)

				if arg_274_1.var_.actorSpriteSplit1037 ~= nil then
					arg_274_1.var_.actorSpriteSplit1037:SetAlpha((arg_274_1.time_ - 0) / var_277_7)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				var_277_5.localPosition = Vector3.New(390, -430, -55)

				if arg_274_1.var_.actorSpriteSplit1037 ~= nil then
					arg_274_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_277_8 = 0
			local var_277_9 = 0.55

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_10 = arg_274_1:GetWordFromCfg(425131065)
				local var_277_11 = arg_274_1:FormatText(var_277_10.content)

				arg_274_1.text_.text = var_277_11

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_13 = 22 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 22)

				if (22 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 22)) > 0 and var_277_9 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_8
					end
				end

				arg_274_1.text_.text = var_277_11
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131065", "story_v_out_425131.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_425131", "425131065", "story_v_out_425131.awb") / 1000

					if var_277_14 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_8
					end

					if var_277_10.prefab_name ~= "" and arg_274_1.actors_[var_277_10.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_10.prefab_name].transform, "story_v_out_425131", "425131065", "story_v_out_425131.awb")

						arg_274_1:RecordAudio("425131065", var_277_15)
						arg_274_1:RecordAudio("425131065", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_425131", "425131065", "story_v_out_425131.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_425131", "425131065", "story_v_out_425131.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_9, arg_274_1.talkMaxDuration)

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_8) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_8 + var_277_16 and arg_274_1.time_ < var_277_8 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play425131066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 425131066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play425131067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1037 = arg_278_1.actors_["1037"].transform.localPosition
				arg_278_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("1037", 7)

				for iter_281_0 = 0, arg_278_1.actors_["1037"].transform.childCount - 1 do
					local var_281_0 = arg_278_1.actors_["1037"].transform:GetChild(iter_281_0)

					if var_281_0.name == "" or not string.find(var_281_0.name, "split") then
						var_281_0.gameObject:SetActive(true)
					else
						var_281_0.gameObject:SetActive(false)
					end
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_278_1.time_ - 0) / var_281_1)
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_281_2 = arg_278_1.actors_["10157"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10157 = var_281_2.localPosition
				var_281_2.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10157", 7)

				for iter_281_1 = 0, var_281_2.childCount - 1 do
					local var_281_3 = var_281_2:GetChild(iter_281_1)

					if var_281_3.name == "" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10157, Vector3.New(0, -2000, 0), (arg_278_1.time_ - 0) / var_281_4)
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_5 = 0
			local var_281_6 = 0.7

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(425131066).content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 28 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 28)

				if (28 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 28)) > 0 and var_281_6 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_10 and arg_278_1.time_ < var_281_5 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play425131067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 425131067
		arg_282_1.duration_ = 3.8

		local var_282_0 = {
			zh = 2.666,
			ja = 3.8
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play425131068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1037"]) and arg_282_1.var_.actorSpriteComps1037 == nil then
				arg_282_1.var_.actorSpriteComps1037 = arg_282_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1037"]) then
				if arg_282_1.var_.actorSpriteComps1037 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 1, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1037"]) and arg_282_1.var_.actorSpriteComps1037 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps1037 = nil
			end

			local var_285_2 = arg_282_1.actors_["1037"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1037 = var_285_2.localPosition
				var_285_2.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("1037", 3)

				for iter_285_4 = 0, var_285_2.childCount - 1 do
					local var_285_3 = var_285_2:GetChild(iter_285_4)

					if var_285_3.name == "" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				var_285_2.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_282_1.time_ - 0) / var_285_4)
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				var_285_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_285_5 = 0
			local var_285_6 = 0.25

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:GetWordFromCfg(425131067)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 10 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 10)

				if (10 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 10)) > 0 and var_285_6 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131067", "story_v_out_425131.awb") ~= 0 then
					local var_285_11 = manager.audio:GetVoiceLength("story_v_out_425131", "425131067", "story_v_out_425131.awb") / 1000

					if var_285_11 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_5
					end

					if var_285_7.prefab_name ~= "" and arg_282_1.actors_[var_285_7.prefab_name] ~= nil then
						local var_285_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_7.prefab_name].transform, "story_v_out_425131", "425131067", "story_v_out_425131.awb")

						arg_282_1:RecordAudio("425131067", var_285_12)
						arg_282_1:RecordAudio("425131067", var_285_12)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_425131", "425131067", "story_v_out_425131.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_425131", "425131067", "story_v_out_425131.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_13 and arg_282_1.time_ < var_285_5 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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

		arg_282_1:InitPlayNodeList()
	end,
	Play425131068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 425131068
		arg_286_1.duration_ = 2.2

		local var_286_0 = {
			zh = 2.066,
			ja = 2.2
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
				arg_286_0:Play425131069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10157"]) and arg_286_1.var_.actorSpriteComps10157 == nil then
				arg_286_1.var_.actorSpriteComps10157 = arg_286_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10157"]) then
				if arg_286_1.var_.actorSpriteComps10157 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps10157:ToTable()) do
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

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10157"]) and arg_286_1.var_.actorSpriteComps10157 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps10157 = nil
			end

			local var_289_2 = arg_286_1.actors_["1037"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1037 == nil then
				arg_286_1.var_.actorSpriteComps1037 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps1037 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								iter_289_5.color = Color.New(Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_3), Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_3), (Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_3)))
							else
								local var_289_4 = Mathf.Lerp(iter_289_5.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_3)

								iter_289_5.color = Color.New(var_289_4, var_289_4, var_289_4)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1037 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_289_7 then
						iter_289_7.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps1037 = nil
			end

			local var_289_5 = arg_286_1.actors_["10157"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10157 = var_289_5.localPosition
				var_289_5.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10157", 3)

				for iter_289_8 = 0, var_289_5.childCount - 1 do
					local var_289_6 = var_289_5:GetChild(iter_289_8)

					if var_289_6.name == "" or not string.find(var_289_6.name, "split") then
						var_289_6.gameObject:SetActive(true)
					else
						var_289_6.gameObject:SetActive(false)
					end
				end
			end

			local var_289_7 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10157, Vector3.New(0, -408, 115), (arg_286_1.time_ - 0) / var_289_7)
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(0, -408, 115)
			end

			local var_289_8 = arg_286_1.actors_["1037"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1037 = var_289_8.localPosition
				var_289_8.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("1037", 7)

				for iter_289_9 = 0, var_289_8.childCount - 1 do
					local var_289_9 = var_289_8:GetChild(iter_289_9)

					if var_289_9.name == "split_4" or not string.find(var_289_9.name, "split") then
						var_289_9.gameObject:SetActive(true)
					else
						var_289_9.gameObject:SetActive(false)
					end
				end
			end

			local var_289_10 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_10 then
				var_289_8.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_286_1.time_ - 0) / var_289_10)
			end

			if arg_286_1.time_ >= 0 + var_289_10 and arg_286_1.time_ < 0 + var_289_10 + arg_289_0 then
				var_289_8.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_289_11 = 0
			local var_289_12 = 0.15

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_11 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_13 = arg_286_1:GetWordFromCfg(425131068)
				local var_289_14 = arg_286_1:FormatText(var_289_13.content)

				arg_286_1.text_.text = var_289_14

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_16 = 6 <= 0 and var_289_12 or var_289_12 * (utf8.len(var_289_14) / 6)

				if (6 <= 0 and var_289_12 or var_289_12 * (utf8.len(var_289_14) / 6)) > 0 and var_289_12 < var_289_16 then
					arg_286_1.talkMaxDuration = var_289_16

					if var_289_16 + var_289_11 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_16 + var_289_11
					end
				end

				arg_286_1.text_.text = var_289_14
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131068", "story_v_out_425131.awb") ~= 0 then
					local var_289_17 = manager.audio:GetVoiceLength("story_v_out_425131", "425131068", "story_v_out_425131.awb") / 1000

					if var_289_17 + var_289_11 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_17 + var_289_11
					end

					if var_289_13.prefab_name ~= "" and arg_286_1.actors_[var_289_13.prefab_name] ~= nil then
						local var_289_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_13.prefab_name].transform, "story_v_out_425131", "425131068", "story_v_out_425131.awb")

						arg_286_1:RecordAudio("425131068", var_289_18)
						arg_286_1:RecordAudio("425131068", var_289_18)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_425131", "425131068", "story_v_out_425131.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_425131", "425131068", "story_v_out_425131.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_19 = math.max(var_289_12, arg_286_1.talkMaxDuration)

			if var_289_11 <= arg_286_1.time_ and arg_286_1.time_ < var_289_11 + var_289_19 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_11) / var_289_19

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_11 + var_289_19 and arg_286_1.time_ < var_289_11 + var_289_19 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
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

		arg_286_1:InitPlayNodeList()
	end,
	Play425131069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 425131069
		arg_290_1.duration_ = 4.77

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play425131070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if arg_290_1.bgs_.STwhite == nil then
				local var_293_0 = Object.Instantiate(arg_290_1.paintGo_)

				var_293_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_293_0.name = "STwhite"
				var_293_0.transform.parent = arg_290_1.stage_.transform
				var_293_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.bgs_.STwhite = var_293_0
			end

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				local var_293_1 = arg_290_1.bgs_.STwhite

				arg_290_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_2 = var_293_1:GetComponent("SpriteRenderer")

				if var_293_2 and var_293_2.sprite then
					local var_293_3 = 2 * (var_293_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_1.transform.localScale = Vector3.New(var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "STwhite" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_4 = 2.1

			if 2.1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_4 + 2.4 and arg_290_1.time_ < var_293_4 + 2.4 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_5 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_6 = 1

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 then
				local var_293_7 = Color.New(0, 0, 0)

				var_293_7.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_5) / var_293_6)
				arg_290_1.mask_.color = var_293_7
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_8 = Color.New(0, 0, 0)

				var_293_8.a = 1
				arg_290_1.mask_.color = var_293_8
			end

			local var_293_9 = 1

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_10 = 1.1

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_10 then
				local var_293_11 = Color.New(0, 0, 0)

				var_293_11.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_9) / var_293_10)
				arg_290_1.mask_.color = var_293_11
			end

			if arg_290_1.time_ >= var_293_9 + var_293_10 and arg_290_1.time_ < var_293_9 + var_293_10 + arg_293_0 then
				local var_293_12 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_12.a = 0
				arg_290_1.mask_.color = var_293_12
			end

			local var_293_13 = arg_290_1.actors_["1037"].transform

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1037 = var_293_13.localPosition
				var_293_13.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("1037", 7)

				for iter_293_2 = 0, var_293_13.childCount - 1 do
					local var_293_14 = var_293_13:GetChild(iter_293_2)

					if var_293_14.name == "" or not string.find(var_293_14.name, "split") then
						var_293_14.gameObject:SetActive(true)
					else
						var_293_14.gameObject:SetActive(false)
					end
				end
			end

			local var_293_15 = 0.001

			if 1 <= arg_290_1.time_ and arg_290_1.time_ < 1 + var_293_15 then
				var_293_13.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_290_1.time_ - 1) / var_293_15)
			end

			if arg_290_1.time_ >= 1 + var_293_15 and arg_290_1.time_ < 1 + var_293_15 + arg_293_0 then
				var_293_13.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_293_16 = arg_290_1.actors_["10157"].transform

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				arg_290_1.var_.moveOldPos10157 = var_293_16.localPosition
				var_293_16.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10157", 7)

				for iter_293_3 = 0, var_293_16.childCount - 1 do
					local var_293_17 = var_293_16:GetChild(iter_293_3)

					if var_293_17.name == "" or not string.find(var_293_17.name, "split") then
						var_293_17.gameObject:SetActive(true)
					else
						var_293_17.gameObject:SetActive(false)
					end
				end
			end

			local var_293_18 = 0.001

			if 1 <= arg_290_1.time_ and arg_290_1.time_ < 1 + var_293_18 then
				var_293_16.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10157, Vector3.New(0, -2000, 0), (arg_290_1.time_ - 1) / var_293_18)
			end

			if arg_290_1.time_ >= 1 + var_293_18 and arg_290_1.time_ < 1 + var_293_18 + arg_293_0 then
				var_293_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				if arg_290_1.var_.effect10091049 then
					Object.Destroy(arg_290_1.var_.effect10091049)

					arg_290_1.var_.effect10091049 = nil
				end
			end

			if 0.4 < arg_290_1.time_ and arg_290_1.time_ <= 0.4 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_145", "se_story_145_magic_whoosh02", "")
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425131069,
				charCount = 55,
				enableLayoutChange = true,
				duration = 3.66666666666667,
				groupID = "1069",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(0, 0, 0, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play425131070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 425131070
		arg_294_1.duration_ = 6.37

		local var_294_0 = {
			zh = 6.366,
			ja = 6.3
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play425131071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 1 < arg_294_1.time_ and arg_294_1.time_ <= 1 + arg_297_0 then
				local var_297_0 = arg_294_1.bgs_.ST2403b

				arg_294_1.bgs_.ST2403b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_1 = var_297_0:GetComponent("SpriteRenderer")

				if var_297_1 and var_297_1.sprite then
					local var_297_2 = 2 * (var_297_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_0.transform.localScale = Vector3.New(var_297_2 / var_297_1.sprite.bounds.size.y < var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x and var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x or var_297_2 / var_297_1.sprite.bounds.size.y, var_297_2 / var_297_1.sprite.bounds.size.y < var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x and var_297_2 * manager.ui.mainCameraCom_.aspect / var_297_1.sprite.bounds.size.x or var_297_2 / var_297_1.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "ST2403b" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_3 = 2

			if 2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_3 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			if arg_294_1.time_ >= var_297_3 + 0.3 and arg_294_1.time_ < var_297_3 + 0.3 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			local var_297_4 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_5 = 1

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_5 then
				local var_297_6 = Color.New(1, 1, 1)

				var_297_6.a = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_4) / var_297_5)
				arg_294_1.mask_.color = var_297_6
			end

			if arg_294_1.time_ >= var_297_4 + var_297_5 and arg_294_1.time_ < var_297_4 + var_297_5 + arg_297_0 then
				local var_297_7 = Color.New(1, 1, 1)

				var_297_7.a = 1
				arg_294_1.mask_.color = var_297_7
			end

			local var_297_8 = 1

			if 1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_9 = 1

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_9 then
				local var_297_10 = Color.New(1, 1, 1)

				var_297_10.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_8) / var_297_9)
				arg_294_1.mask_.color = var_297_10
			end

			if arg_294_1.time_ >= var_297_8 + var_297_9 and arg_294_1.time_ < var_297_8 + var_297_9 + arg_297_0 then
				local var_297_11 = Color.New(1, 1, 1)

				arg_294_1.mask_.enabled = false
				var_297_11.a = 0
				arg_294_1.mask_.color = var_297_11
			end

			if 0.0166666666666665 < arg_294_1.time_ and arg_294_1.time_ <= 0.0166666666666665 + arg_297_0 then
				arg_294_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 0.633333333333333 < arg_294_1.time_ and arg_294_1.time_ <= 0.633333333333333 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_297_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_294_1.bgmTxt_.text ~= var_297_16 and arg_294_1.bgmTxt_.text ~= "" then
						if arg_294_1.bgmTxt2_.text ~= "" then
							arg_294_1.bgmTxt_.text = arg_294_1.bgmTxt2_.text
						end

						arg_294_1.bgmTxt2_.text = var_297_16

						arg_294_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_294_1.bgmTxt_.text = var_297_16
						arg_294_1.bgmTxt2_.text = var_297_16
					end

					if arg_294_1.bgmTimer then
						arg_294_1.bgmTimer:Stop()

						arg_294_1.bgmTimer = nil
					end

					if arg_294_1.settingData.show_music_name == 1 then
						arg_294_1.musicController:SetSelectedState("show")
						arg_294_1.musicAnimator_:Play("open", 0, 0)

						if arg_294_1.settingData.music_time ~= 0 then
							arg_294_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_294_1.settingData.music_time), function()
								if arg_294_1 == nil or isNil(arg_294_1.bgmTxt_) then
									return
								end

								arg_294_1.musicController:SetSelectedState("hide")
								arg_294_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.633333333333333 < arg_294_1.time_ and arg_294_1.time_ <= 0.633333333333333 + arg_297_0 then
				arg_294_1:AudioAction("play", "music", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3.awb")

				local var_297_19 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_3", "bgm_activity_4_7_story_interrogation_3")

				if "" ~= "" then
					if arg_294_1.bgmTxt_.text ~= var_297_19 and arg_294_1.bgmTxt_.text ~= "" then
						if arg_294_1.bgmTxt2_.text ~= "" then
							arg_294_1.bgmTxt_.text = arg_294_1.bgmTxt2_.text
						end

						arg_294_1.bgmTxt2_.text = var_297_19

						arg_294_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_294_1.bgmTxt_.text = var_297_19
						arg_294_1.bgmTxt2_.text = var_297_19
					end

					if arg_294_1.bgmTimer then
						arg_294_1.bgmTimer:Stop()

						arg_294_1.bgmTimer = nil
					end

					if arg_294_1.settingData.show_music_name == 1 then
						arg_294_1.musicController:SetSelectedState("show")
						arg_294_1.musicAnimator_:Play("open", 0, 0)

						if arg_294_1.settingData.music_time ~= 0 then
							arg_294_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_294_1.settingData.music_time), function()
								if arg_294_1 == nil or isNil(arg_294_1.bgmTxt_) then
									return
								end

								arg_294_1.musicController:SetSelectedState("hide")
								arg_294_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_20 = 2
			local var_297_21 = 0.225

			if 2 < arg_294_1.time_ and arg_294_1.time_ <= var_297_20 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_22 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_22:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_294_1.dialogCg_.alpha = arg_300_0
				end))
				var_297_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_23 = arg_294_1:GetWordFromCfg(425131070)
				local var_297_24 = arg_294_1:FormatText(var_297_23.content)

				arg_294_1.text_.text = var_297_24

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_26 = 9 <= 0 and var_297_21 or var_297_21 * (utf8.len(var_297_24) / 9)

				if (9 <= 0 and var_297_21 or var_297_21 * (utf8.len(var_297_24) / 9)) > 0 and var_297_21 < var_297_26 then
					arg_294_1.talkMaxDuration = var_297_26
					var_297_20 = var_297_20 + 0.3

					if var_297_26 + var_297_20 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_26 + var_297_20
					end
				end

				arg_294_1.text_.text = var_297_24
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131070", "story_v_out_425131.awb") ~= 0 then
					local var_297_27 = manager.audio:GetVoiceLength("story_v_out_425131", "425131070", "story_v_out_425131.awb") / 1000

					if var_297_27 + var_297_20 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_27 + var_297_20
					end

					if var_297_23.prefab_name ~= "" and arg_294_1.actors_[var_297_23.prefab_name] ~= nil then
						local var_297_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_23.prefab_name].transform, "story_v_out_425131", "425131070", "story_v_out_425131.awb")

						arg_294_1:RecordAudio("425131070", var_297_28)
						arg_294_1:RecordAudio("425131070", var_297_28)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_425131", "425131070", "story_v_out_425131.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_425131", "425131070", "story_v_out_425131.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_29 = var_297_20 + 0.3
			local var_297_30 = math.max(var_297_21, arg_294_1.talkMaxDuration)

			if var_297_20 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_29 + var_297_30 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_29) / var_297_30

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_29 + var_297_30 and arg_294_1.time_ < var_297_29 + var_297_30 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				groupID = "1069",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play425131071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 425131071
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play425131072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.85

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(425131071).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 34 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 34)

				if (34 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 34)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play425131072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 425131072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play425131073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_interrogation", "")
			end

			local var_309_2 = 0
			local var_309_3 = 1.075

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(425131072).content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_6 = 43 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 43)

				if (43 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 43)) > 0 and var_309_3 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_2
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_3, arg_306_1.talkMaxDuration)

			if var_309_2 <= arg_306_1.time_ and arg_306_1.time_ < var_309_2 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_2) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_2 + var_309_7 and arg_306_1.time_ < var_309_2 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play425131073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 425131073
		arg_310_1.duration_ = 5.3

		local var_310_0 = {
			zh = 5.3,
			ja = 4.5
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play425131074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.225

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1440].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:GetWordFromCfg(425131073)
				local var_313_2 = arg_310_1:FormatText(var_313_1.content)

				arg_310_1.text_.text = var_313_2

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 9 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 9)

				if (9 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 9)) > 0 and var_313_0 < var_313_4 then
					arg_310_1.talkMaxDuration = var_313_4

					if var_313_4 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_4 + 0
					end
				end

				arg_310_1.text_.text = var_313_2
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131073", "story_v_out_425131.awb") ~= 0 then
					local var_313_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131073", "story_v_out_425131.awb") / 1000

					if var_313_5 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + 0
					end

					if var_313_1.prefab_name ~= "" and arg_310_1.actors_[var_313_1.prefab_name] ~= nil then
						local var_313_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_1.prefab_name].transform, "story_v_out_425131", "425131073", "story_v_out_425131.awb")

						arg_310_1:RecordAudio("425131073", var_313_6)
						arg_310_1:RecordAudio("425131073", var_313_6)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_425131", "425131073", "story_v_out_425131.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_425131", "425131073", "story_v_out_425131.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play425131074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 425131074
		arg_314_1.duration_ = 7.2

		local var_314_0 = {
			zh = 4.7,
			ja = 7.2
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play425131075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.425

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_6")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:GetWordFromCfg(425131074)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 17 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 17)

				if (17 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 17)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131074", "story_v_out_425131.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131074", "story_v_out_425131.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_425131", "425131074", "story_v_out_425131.awb")

						arg_314_1:RecordAudio("425131074", var_317_6)
						arg_314_1:RecordAudio("425131074", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_425131", "425131074", "story_v_out_425131.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_425131", "425131074", "story_v_out_425131.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.266,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(4, 4, 4)
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play425131075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 425131075
		arg_318_1.duration_ = 1.97

		local var_318_0 = {
			zh = 1.4,
			ja = 1.966
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
				arg_318_0:Play425131076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.1

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_6")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:GetWordFromCfg(425131075)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 4 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 4)

				if (4 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 4)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131075", "story_v_out_425131.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131075", "story_v_out_425131.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_425131", "425131075", "story_v_out_425131.awb")

						arg_318_1:RecordAudio("425131075", var_321_6)
						arg_318_1:RecordAudio("425131075", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_425131", "425131075", "story_v_out_425131.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_425131", "425131075", "story_v_out_425131.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play425131076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 425131076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play425131077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if arg_322_1.actors_["1137"] == nil then
				local var_325_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_325_0) then
					local var_325_1 = Object.Instantiate(var_325_0, arg_322_1.canvasGo_.transform)

					var_325_1.transform:SetSiblingIndex(1)

					var_325_1.name = "1137"
					var_325_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_322_1.actors_["1137"] = var_325_1

					if arg_322_1.isInRecall_ then
						for iter_325_0, iter_325_1 in ipairs((var_325_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_325_1.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_325_2 = arg_322_1.actors_["1137"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1137 = var_325_2.localPosition
				var_325_2.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("1137", 7)

				for iter_325_2 = 0, var_325_2.childCount - 1 do
					local var_325_3 = var_325_2:GetChild(iter_325_2)

					if var_325_3.name == "" or not string.find(var_325_3.name, "split") then
						var_325_3.gameObject:SetActive(true)
					else
						var_325_3.gameObject:SetActive(false)
					end
				end
			end

			local var_325_4 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				var_325_2.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_322_1.time_ - 0) / var_325_4)
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				var_325_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_325_5 = 0
			local var_325_6 = 1.45

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(425131076).content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 58 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 58)

				if (58 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 58)) > 0 and var_325_6 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_10 and arg_322_1.time_ < var_325_5 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play425131077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 425131077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play425131078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1.425

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(425131077).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 57 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 57)

				if (57 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 57)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play425131078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 425131078
		arg_330_1.duration_ = 6.07

		local var_330_0 = {
			zh = 4.7,
			ja = 6.066
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
				arg_330_0:Play425131079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.5

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_6")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:GetWordFromCfg(425131078)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 20 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 20)

				if (20 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 20)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131078", "story_v_out_425131.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131078", "story_v_out_425131.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_425131", "425131078", "story_v_out_425131.awb")

						arg_330_1:RecordAudio("425131078", var_333_6)
						arg_330_1:RecordAudio("425131078", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_425131", "425131078", "story_v_out_425131.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_425131", "425131078", "story_v_out_425131.awb")
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
	Play425131079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 425131079
		arg_334_1.duration_ = 8.93

		local var_334_0 = {
			zh = 8.933,
			ja = 6.766
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
			arg_334_1.auto_ = false
		end

		function arg_334_1.playNext_(arg_336_0)
			arg_334_1.onStoryFinished_()
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.8

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1137_split_6")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:GetWordFromCfg(425131079)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 32 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 32)

				if (32 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 32)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425131", "425131079", "story_v_out_425131.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_425131", "425131079", "story_v_out_425131.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_425131", "425131079", "story_v_out_425131.awb")

						arg_334_1:RecordAudio("425131079", var_337_6)
						arg_334_1:RecordAudio("425131079", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_425131", "425131079", "story_v_out_425131.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_425131", "425131079", "story_v_out_425131.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/ST20",
		"TextureConfig/Background/ST2403b",
		"TextureConfig/Background/ST2402",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_425131.awb"
	}
}
