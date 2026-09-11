return {
	Play410082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410082001
		arg_1_1.duration_ = 8.8

		local var_1_0 = {
			zh = 5.5,
			ja = 8.8
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
				arg_1_0:Play410082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L01f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_4_0.name = "L01f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L01f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L01f

				arg_1_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L01f" then
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

			local var_4_8 = "1060"

			if arg_1_1.actors_["1060"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_4_11 = arg_1_1.actors_["1060"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1060 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1060", 2)

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
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_4_14 = "10062"

			if arg_1_1.actors_["10062"] == nil then
				local var_4_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_4_15) then
					local var_4_16 = Object.Instantiate(var_4_15, arg_1_1.canvasGo_.transform)

					var_4_16.transform:SetSiblingIndex(1)

					var_4_16.name = var_4_14
					var_4_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_14] = var_4_16

					if arg_1_1.isInRecall_ then
						for iter_4_5, iter_4_6 in ipairs((var_4_16:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_6.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_17 = arg_1_1.actors_["10062"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10062 = var_4_17.localPosition
				var_4_17.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10062", 4)

				for iter_4_7 = 0, var_4_17.childCount - 1 do
					local var_4_18 = var_4_17:GetChild(iter_4_7)

					if var_4_18.name == "" or not string.find(var_4_18.name, "split") then
						var_4_18.gameObject:SetActive(true)
					else
						var_4_18.gameObject:SetActive(false)
					end
				end
			end

			local var_4_19 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_19 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_1_1.time_ - 2) / var_4_19)
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(370, -390, -290)
			end

			local var_4_20 = arg_1_1.actors_["1060"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps1060 == nil then
				arg_1_1.var_.actorSpriteComps1060 = var_4_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_21 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.actorSpriteComps1060 then
					for iter_4_8, iter_4_9 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_4_9 then
							if arg_1_1.isInRecall_ then
								iter_4_9.color = Color.New(Mathf.Lerp(iter_4_9.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_21), Mathf.Lerp(iter_4_9.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_21), (Mathf.Lerp(iter_4_9.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_21)))
							else
								local var_4_22 = Mathf.Lerp(iter_4_9.color.r, 1, (arg_1_1.time_ - 2) / var_4_21)

								iter_4_9.color = Color.New(var_4_22, var_4_22, var_4_22)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_21 and arg_1_1.time_ < 2 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps1060 then
				for iter_4_10, iter_4_11 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_4_11 then
						iter_4_11.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1060 = nil
			end

			local var_4_23 = arg_1_1.actors_["10062"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.actorSpriteComps10062 == nil then
				arg_1_1.var_.actorSpriteComps10062 = var_4_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_24 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_24 and not isNil(var_4_23) then
				if arg_1_1.var_.actorSpriteComps10062 then
					for iter_4_12, iter_4_13 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_4_13 then
							if arg_1_1.isInRecall_ then
								iter_4_13.color = Color.New(Mathf.Lerp(iter_4_13.color.r, arg_1_1.hightColor2.r, (arg_1_1.time_ - 2) / var_4_24), Mathf.Lerp(iter_4_13.color.g, arg_1_1.hightColor2.g, (arg_1_1.time_ - 2) / var_4_24), (Mathf.Lerp(iter_4_13.color.b, arg_1_1.hightColor2.b, (arg_1_1.time_ - 2) / var_4_24)))
							else
								local var_4_25 = Mathf.Lerp(iter_4_13.color.r, 0.5, (arg_1_1.time_ - 2) / var_4_24)

								iter_4_13.color = Color.New(var_4_25, var_4_25, var_4_25)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_24 and arg_1_1.time_ < 2 + var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.actorSpriteComps10062 then
				for iter_4_14, iter_4_15 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_4_15 then
						iter_4_15.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_1_1.var_.actorSpriteComps10062 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_31 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 2
			local var_4_33 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(410082001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 14 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 14)

				if (14 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 14)) > 0 and var_4_33 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_32 = var_4_32 + 0.3

					if var_4_38 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082001", "story_v_out_410082.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_410082", "410082001", "story_v_out_410082.awb") / 1000

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end

					if var_4_35.prefab_name ~= "" and arg_1_1.actors_[var_4_35.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_35.prefab_name].transform, "story_v_out_410082", "410082001", "story_v_out_410082.awb")

						arg_1_1:RecordAudio("410082001", var_4_40)
						arg_1_1:RecordAudio("410082001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410082", "410082001", "story_v_out_410082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410082", "410082001", "story_v_out_410082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_32 + 0.3
			local var_4_42 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_32 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410082002
		arg_9_1.duration_ = 10.63

		local var_9_0 = {
			zh = 5.1,
			ja = 10.633
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
				arg_9_0:Play410082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10062 = arg_9_1.actors_["10062"].transform.localPosition
				arg_9_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10062", 4)

				for iter_12_0 = 0, arg_9_1.actors_["10062"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10062"].transform:GetChild(iter_12_0)

					if var_12_0.name == "" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_12_2 = arg_9_1.actors_["10062"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10062 == nil then
				arg_9_1.var_.actorSpriteComps10062 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10062 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								iter_12_2.color = Color.New(Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_2.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_2.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10062 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_12_4 then
						iter_12_4.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10062 = nil
			end

			local var_12_5 = arg_9_1.actors_["1060"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1060 == nil then
				arg_9_1.var_.actorSpriteComps1060 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps1060 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_12_6 then
							if arg_9_1.isInRecall_ then
								iter_12_6.color = Color.New(Mathf.Lerp(iter_12_6.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_6.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_6.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_6.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_6.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1060 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_12_8 then
						iter_12_8.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1060 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.5

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(410082002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 20 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 20)

				if (20 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 20)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082002", "story_v_out_410082.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082002", "story_v_out_410082.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_410082", "410082002", "story_v_out_410082.awb")

						arg_9_1:RecordAudio("410082002", var_12_15)
						arg_9_1:RecordAudio("410082002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410082", "410082002", "story_v_out_410082.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410082", "410082002", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410082003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10062"]) and arg_13_1.var_.actorSpriteComps10062 == nil then
				arg_13_1.var_.actorSpriteComps10062 = arg_13_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10062"]) then
				if arg_13_1.var_.actorSpriteComps10062 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10062"]) and arg_13_1.var_.actorSpriteComps10062 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10062 = nil
			end

			local var_16_2 = arg_13_1.actors_["1060"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1060 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1060", 7)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_16_5 = arg_13_1.actors_["10062"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10062 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10062", 7)

				for iter_16_5 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_5)

					if var_16_6.name == "" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_16_8 = 0
			local var_16_9 = 1.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(410082003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 63 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 63)

				if (63 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 63)) > 0 and var_16_9 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_13 and arg_13_1.time_ < var_16_8 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410082004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410082005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410082004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 44 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 44)

				if (44 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 44)) > 0 and var_20_0 < var_20_3 then
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
	Play410082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410082005
		arg_21_1.duration_ = 8.7

		local var_21_0 = {
			zh = 5.933,
			ja = 8.7
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
				arg_21_0:Play410082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10062 = arg_21_1.actors_["10062"].transform.localPosition
				arg_21_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10062", 4)

				for iter_24_0 = 0, arg_21_1.actors_["10062"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10062"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_24_2 = arg_21_1.actors_["10062"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10062 == nil then
				arg_21_1.var_.actorSpriteComps10062 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10062 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10062 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10062 = nil
			end

			local var_24_5 = arg_21_1.actors_["1060"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1060 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1060", 2)

				for iter_24_5 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_5)

					if var_24_6.name == "" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_24_8 = arg_21_1.actors_["1060"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								iter_24_7.color = Color.New(Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_9), Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_9), (Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_9)))
							else
								local var_24_10 = Mathf.Lerp(iter_24_7.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_9)

								iter_24_7.color = Color.New(var_24_10, var_24_10, var_24_10)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_9 then
						iter_24_9.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_11 = 0
			local var_24_12 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(410082005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 18 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 18)

				if (18 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 18)) > 0 and var_24_12 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082005", "story_v_out_410082.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082005", "story_v_out_410082.awb") / 1000

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_410082", "410082005", "story_v_out_410082.awb")

						arg_21_1:RecordAudio("410082005", var_24_18)
						arg_21_1:RecordAudio("410082005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410082", "410082005", "story_v_out_410082.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410082", "410082005", "story_v_out_410082.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_19 and arg_21_1.time_ < var_24_11 + var_24_19 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410082006
		arg_25_1.duration_ = 7.33

		local var_25_0 = {
			zh = 4.9,
			ja = 7.333
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
				arg_25_0:Play410082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = arg_25_1.actors_["1060"].transform.localPosition
				arg_25_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 2)

				for iter_28_0 = 0, arg_25_1.actors_["1060"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1060"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_28_2 = arg_25_1.actors_["1060"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_5 = arg_25_1.actors_["10062"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10062 == nil then
				arg_25_1.var_.actorSpriteComps10062 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps10062 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps10062 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_28_8 then
						iter_28_8.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10062 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(410082006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 20 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 20)

				if (20 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 20)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082006", "story_v_out_410082.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082006", "story_v_out_410082.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_410082", "410082006", "story_v_out_410082.awb")

						arg_25_1:RecordAudio("410082006", var_28_15)
						arg_25_1:RecordAudio("410082006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410082", "410082006", "story_v_out_410082.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410082", "410082006", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410082007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1060 = arg_29_1.actors_["1060"].transform.localPosition
				arg_29_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1060", 7)

				for iter_32_0 = 0, arg_29_1.actors_["1060"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1060"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_32_2 = arg_29_1.actors_["10062"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10062 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10062", 7)

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
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_32_5 = manager.ui.mainCamera.transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.shakeOldPos = var_32_5.localPosition
			end

			local var_32_6 = 0.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				local var_32_7, var_32_8 = math.modf((arg_29_1.time_ - 0) / 0.066)

				var_32_5.localPosition = Vector3.New(var_32_8 * 0.13, var_32_8 * 0.13, var_32_8 * 0.13) + arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 then
				var_32_5.localPosition = arg_29_1.var_.shakeOldPos
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_32_10 = 0
			local var_32_11 = 1.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(410082007).content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_14 = 55 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_12) / 55)

				if (55 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_12) / 55)) > 0 and var_32_11 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14

					if var_32_14 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_15 and arg_29_1.time_ < var_32_10 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410082008
		arg_33_1.duration_ = 3.83

		local var_33_0 = {
			zh = 3.833,
			ja = 3.733
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
				arg_33_0:Play410082009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = arg_33_1.actors_["1060"].transform.localPosition
				arg_33_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 3)

				for iter_36_0 = 0, arg_33_1.actors_["1060"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1060"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_3" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_36_2 = arg_33_1.actors_["1060"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1060 == nil then
				arg_33_1.var_.actorSpriteComps1060 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1060 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410082008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 13 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 13)

				if (13 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 13)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082008", "story_v_out_410082.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082008", "story_v_out_410082.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410082", "410082008", "story_v_out_410082.awb")

						arg_33_1:RecordAudio("410082008", var_36_12)
						arg_33_1:RecordAudio("410082008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410082", "410082008", "story_v_out_410082.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410082", "410082008", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410082009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1060 = arg_37_1.actors_["1060"].transform.localPosition
				arg_37_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1060", 7)

				for iter_40_0 = 0, arg_37_1.actors_["1060"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1060"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_3" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_40_2 = 0
			local var_40_3 = 0.925

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

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410082009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 37 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 37)

				if (37 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 37)) > 0 and var_40_3 < var_40_6 then
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
				actorName = "1060",
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
	Play410082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410082010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play410082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(410082010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 24 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 24)

				if (24 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 24)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play410082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410082011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 2.1,
			ja = 4.5
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
				arg_45_0:Play410082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10062 = arg_45_1.actors_["10062"].transform.localPosition
				arg_45_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10062", 3)

				for iter_48_0 = 0, arg_45_1.actors_["10062"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10062"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_48_2 = arg_45_1.actors_["10062"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10062 == nil then
				arg_45_1.var_.actorSpriteComps10062 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10062 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10062 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10062 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(410082011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 5 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 5)

				if (5 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 5)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082011", "story_v_out_410082.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082011", "story_v_out_410082.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_410082", "410082011", "story_v_out_410082.awb")

						arg_45_1:RecordAudio("410082011", var_48_12)
						arg_45_1:RecordAudio("410082011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410082", "410082011", "story_v_out_410082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410082", "410082011", "story_v_out_410082.awb")
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

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410082012
		arg_49_1.duration_ = 7.33

		local var_49_0 = {
			zh = 3.9,
			ja = 7.333
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
				arg_49_0:Play410082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = arg_49_1.actors_["1060"].transform.localPosition
				arg_49_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 2)

				for iter_52_0 = 0, arg_49_1.actors_["1060"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1060"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_52_2 = arg_49_1.actors_["1060"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1060 == nil then
				arg_49_1.var_.actorSpriteComps1060 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1060 = nil
			end

			local var_52_5 = arg_49_1.actors_["10062"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = var_52_5.localPosition
				var_52_5.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 4)

				for iter_52_5 = 0, var_52_5.childCount - 1 do
					local var_52_6 = var_52_5:GetChild(iter_52_5)

					if var_52_6.name == "" or not string.find(var_52_6.name, "split") then
						var_52_6.gameObject:SetActive(true)
					else
						var_52_6.gameObject:SetActive(false)
					end
				end
			end

			local var_52_7 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_49_1.time_ - 0) / var_52_7)
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(370, -390, -290)
			end

			local var_52_8 = arg_49_1.actors_["10062"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_9 and not isNil(var_52_8) then
				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_52_7 then
							if arg_49_1.isInRecall_ then
								iter_52_7.color = Color.New(Mathf.Lerp(iter_52_7.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_9), Mathf.Lerp(iter_52_7.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_9), (Mathf.Lerp(iter_52_7.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_9)))
							else
								local var_52_10 = Mathf.Lerp(iter_52_7.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_9)

								iter_52_7.color = Color.New(var_52_10, var_52_10, var_52_10)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_9 and arg_49_1.time_ < 0 + var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_8, iter_52_9 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_9 then
						iter_52_9.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			local var_52_11 = 0
			local var_52_12 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(410082012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 11 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 11)

				if (11 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 11)) > 0 and var_52_12 < var_52_16 then
					arg_49_1.talkMaxDuration = var_52_16

					if var_52_16 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082012", "story_v_out_410082.awb") ~= 0 then
					local var_52_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082012", "story_v_out_410082.awb") / 1000

					if var_52_17 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_11
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_410082", "410082012", "story_v_out_410082.awb")

						arg_49_1:RecordAudio("410082012", var_52_18)
						arg_49_1:RecordAudio("410082012", var_52_18)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410082", "410082012", "story_v_out_410082.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410082", "410082012", "story_v_out_410082.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_19 and arg_49_1.time_ < var_52_11 + var_52_19 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410082013
		arg_53_1.duration_ = 7.93

		local var_53_0 = {
			zh = 4.333,
			ja = 7.933
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
				arg_53_0:Play410082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10062 = arg_53_1.actors_["10062"].transform.localPosition
				arg_53_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10062", 4)

				for iter_56_0 = 0, arg_53_1.actors_["10062"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10062"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_56_2 = arg_53_1.actors_["10062"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10062 == nil then
				arg_53_1.var_.actorSpriteComps10062 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10062 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10062 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10062 = nil
			end

			local var_56_5 = arg_53_1.actors_["1060"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1060 == nil then
				arg_53_1.var_.actorSpriteComps1060 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1060 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1060 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_56_8 then
						iter_56_8.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1060 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(410082013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 15 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 15)

				if (15 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 15)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082013", "story_v_out_410082.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082013", "story_v_out_410082.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_410082", "410082013", "story_v_out_410082.awb")

						arg_53_1:RecordAudio("410082013", var_56_15)
						arg_53_1:RecordAudio("410082013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410082", "410082013", "story_v_out_410082.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410082", "410082013", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410082014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1060 = arg_57_1.actors_["1060"].transform.localPosition
				arg_57_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1060", 7)

				for iter_60_0 = 0, arg_57_1.actors_["1060"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1060"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_60_2 = arg_57_1.actors_["10062"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10062 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10062", 7)

				for iter_60_1 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_1)

					if var_60_3.name == "" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_60_5 = 0
			local var_60_6 = 1.225

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

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410082014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 49 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 49)

				if (49 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 49)) > 0 and var_60_6 < var_60_9 then
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410082015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410082016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.025

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(410082015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 41 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 41)

				if (41 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 41)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410082016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410082016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play410082017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(410082016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 55 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 55)

				if (55 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 55)) > 0 and var_68_0 < var_68_3 then
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
	Play410082017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410082017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410082018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(410082017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 52 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 52)

				if (52 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 52)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410082018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410082018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410082019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_0 = 0.5

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				local var_76_1 = Color.New(1, 1, 1)

				var_76_1.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.mask_.color = var_76_1
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				local var_76_2 = Color.New(1, 1, 1)

				arg_73_1.mask_.enabled = false
				var_76_2.a = 0
				arg_73_1.mask_.color = var_76_2
			end

			local var_76_3 = manager.ui.mainCamera.transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = var_76_3.localPosition
			end

			local var_76_4 = 1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				local var_76_5, var_76_6 = math.modf((arg_73_1.time_ - 0) / 0.066)

				var_76_3.localPosition = Vector3.New(var_76_6 * 0.13, var_76_6 * 0.13, var_76_6 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = arg_73_1.var_.shakeOldPos
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_whoosh", "")
			end

			local var_76_8 = 0
			local var_76_9 = 1.525

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_10 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_10:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_11 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(410082018).content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 61 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 61)

				if (61 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 61)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13
					var_76_8 = var_76_8 + 0.3

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = var_76_8 + 0.3
			local var_76_15 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_14) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_14 + var_76_15 and arg_73_1.time_ < var_76_14 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410082019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410082019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410082020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.85

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(410082019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 34 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 34)

				if (34 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 34)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play410082020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410082020
		arg_83_1.duration_ = 13.47

		local var_83_0 = {
			zh = 4.6,
			ja = 13.466
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
				arg_83_0:Play410082021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10062 = arg_83_1.actors_["10062"].transform.localPosition
				arg_83_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10062", 3)

				for iter_86_0 = 0, arg_83_1.actors_["10062"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10062"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_1_1" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_86_2 = arg_83_1.actors_["10062"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10062 == nil then
				arg_83_1.var_.actorSpriteComps10062 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10062 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10062 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10062 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.5

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(410082020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 20 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 20)

				if (20 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 20)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082020", "story_v_out_410082.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082020", "story_v_out_410082.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_410082", "410082020", "story_v_out_410082.awb")

						arg_83_1:RecordAudio("410082020", var_86_12)
						arg_83_1:RecordAudio("410082020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410082", "410082020", "story_v_out_410082.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410082", "410082020", "story_v_out_410082.awb")
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
				actorName = "10062",
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
	Play410082021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410082021
		arg_87_1.duration_ = 8.63

		local var_87_0 = {
			zh = 6.533,
			ja = 8.633
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
				arg_87_0:Play410082022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1060 = arg_87_1.actors_["1060"].transform.localPosition
				arg_87_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1060", 2)

				for iter_90_0 = 0, arg_87_1.actors_["1060"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["1060"].transform:GetChild(iter_90_0)

					if var_90_0.name == "" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_90_2 = arg_87_1.actors_["1060"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1060 == nil then
				arg_87_1.var_.actorSpriteComps1060 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps1060 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								iter_90_2.color = Color.New(Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_2.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_2.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1060 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_90_4 then
						iter_90_4.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1060 = nil
			end

			local var_90_5 = arg_87_1.actors_["10062"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10062 = var_90_5.localPosition
				var_90_5.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10062", 4)

				for iter_90_5 = 0, var_90_5.childCount - 1 do
					local var_90_6 = var_90_5:GetChild(iter_90_5)

					if var_90_6.name == "split_1_1" or not string.find(var_90_6.name, "split") then
						var_90_6.gameObject:SetActive(true)
					else
						var_90_6.gameObject:SetActive(false)
					end
				end
			end

			local var_90_7 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_87_1.time_ - 0) / var_90_7)
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(370, -390, -290)
			end

			local var_90_8 = arg_87_1.actors_["10062"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10062 == nil then
				arg_87_1.var_.actorSpriteComps10062 = var_90_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_9 and not isNil(var_90_8) then
				if arg_87_1.var_.actorSpriteComps10062 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								iter_90_7.color = Color.New(Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_9), Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_9), (Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_9)))
							else
								local var_90_10 = Mathf.Lerp(iter_90_7.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_9)

								iter_90_7.color = Color.New(var_90_10, var_90_10, var_90_10)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_9 and arg_87_1.time_ < 0 + var_90_9 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10062 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_90_9 then
						iter_90_9.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps10062 = nil
			end

			local var_90_11 = 0
			local var_90_12 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_13 = arg_87_1:GetWordFromCfg(410082021)
				local var_90_14 = arg_87_1:FormatText(var_90_13.content)

				arg_87_1.text_.text = var_90_14

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_16 = 21 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 21)

				if (21 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 21)) > 0 and var_90_12 < var_90_16 then
					arg_87_1.talkMaxDuration = var_90_16

					if var_90_16 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_14
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082021", "story_v_out_410082.awb") ~= 0 then
					local var_90_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082021", "story_v_out_410082.awb") / 1000

					if var_90_17 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_11
					end

					if var_90_13.prefab_name ~= "" and arg_87_1.actors_[var_90_13.prefab_name] ~= nil then
						local var_90_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_13.prefab_name].transform, "story_v_out_410082", "410082021", "story_v_out_410082.awb")

						arg_87_1:RecordAudio("410082021", var_90_18)
						arg_87_1:RecordAudio("410082021", var_90_18)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410082", "410082021", "story_v_out_410082.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410082", "410082021", "story_v_out_410082.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_19 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_19

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_19 and arg_87_1.time_ < var_90_11 + var_90_19 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410082022
		arg_91_1.duration_ = 12.83

		local var_91_0 = {
			zh = 2.666,
			ja = 12.833
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
				arg_91_0:Play410082023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10062 = arg_91_1.actors_["10062"].transform.localPosition
				arg_91_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10062", 4)

				for iter_94_0 = 0, arg_91_1.actors_["10062"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["10062"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_5" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_94_2 = arg_91_1.actors_["10062"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10062 == nil then
				arg_91_1.var_.actorSpriteComps10062 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps10062 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps10062 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10062 = nil
			end

			local var_94_5 = arg_91_1.actors_["1060"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps1060 == nil then
				arg_91_1.var_.actorSpriteComps1060 = var_94_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_6 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.actorSpriteComps1060 then
					for iter_94_5, iter_94_6 in pairs(arg_91_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_94_6 then
							if arg_91_1.isInRecall_ then
								iter_94_6.color = Color.New(Mathf.Lerp(iter_94_6.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_6), Mathf.Lerp(iter_94_6.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_6), (Mathf.Lerp(iter_94_6.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_6)))
							else
								local var_94_7 = Mathf.Lerp(iter_94_6.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_6)

								iter_94_6.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps1060 then
				for iter_94_7, iter_94_8 in pairs(arg_91_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_94_8 then
						iter_94_8.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps1060 = nil
			end

			local var_94_8 = 0
			local var_94_9 = 0.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(410082022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 8 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 8)

				if (8 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 8)) > 0 and var_94_9 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082022", "story_v_out_410082.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082022", "story_v_out_410082.awb") / 1000

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end

					if var_94_10.prefab_name ~= "" and arg_91_1.actors_[var_94_10.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_10.prefab_name].transform, "story_v_out_410082", "410082022", "story_v_out_410082.awb")

						arg_91_1:RecordAudio("410082022", var_94_15)
						arg_91_1:RecordAudio("410082022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410082", "410082022", "story_v_out_410082.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410082", "410082022", "story_v_out_410082.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_16 and arg_91_1.time_ < var_94_8 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410082023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play410082024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1060 = arg_95_1.actors_["1060"].transform.localPosition
				arg_95_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1060", 7)

				for iter_98_0 = 0, arg_95_1.actors_["1060"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1060"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_98_2 = arg_95_1.actors_["10062"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10062 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10062", 7)

				for iter_98_1 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_1)

					if var_98_3.name == "split_1_1" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_98_5 = 0
			local var_98_6 = 1.225

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

				local var_98_7 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(410082023).content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 49 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 49)

				if (49 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 49)) > 0 and var_98_6 < var_98_9 then
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410082024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play410082025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.675

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(410082024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 67 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 67)

				if (67 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 67)) > 0 and var_102_0 < var_102_3 then
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
	Play410082025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410082025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410082026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.975

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

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(410082025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 39 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 39)

				if (39 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 39)) > 0 and var_106_0 < var_106_3 then
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
	Play410082026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410082026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410082027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.45

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(410082026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 58 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 58)

				if (58 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 58)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410082027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410082027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410082028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.875

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(410082027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)

				if (35 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 35)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410082028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410082028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play410082029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_0 = 0.5

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				local var_118_1 = Color.New(1, 1, 1)

				var_118_1.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.mask_.color = var_118_1
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				local var_118_2 = Color.New(1, 1, 1)

				arg_115_1.mask_.enabled = false
				var_118_2.a = 0
				arg_115_1.mask_.color = var_118_2
			end

			local var_118_3 = manager.ui.mainCamera.transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.shakeOldPos = var_118_3.localPosition
			end

			local var_118_4 = 1

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				local var_118_5, var_118_6 = math.modf((arg_115_1.time_ - 0) / 0.066)

				var_118_3.localPosition = Vector3.New(var_118_6 * 0.13, var_118_6 * 0.13, var_118_6 * 0.13) + arg_115_1.var_.shakeOldPos
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_3.localPosition = arg_115_1.var_.shakeOldPos
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_118_8 = 0
			local var_118_9 = 0.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_10 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_10:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_11 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(410082028).content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 3 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 3)

				if (3 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 3)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13
					var_118_8 = var_118_8 + 0.3

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = var_118_8 + 0.3
			local var_118_15 = math.max(var_118_9, arg_115_1.talkMaxDuration)

			if var_118_8 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_15 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_15

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_15 and arg_115_1.time_ < var_118_14 + var_118_15 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410082029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410082029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play410082030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(410082029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 44 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 44)

				if (44 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 44)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play410082030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410082030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play410082031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(410082030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 55 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 55)

				if (55 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 55)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play410082031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410082031
		arg_129_1.duration_ = 1.73

		local var_129_0 = {
			zh = 1.466,
			ja = 1.733
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
				arg_129_0:Play410082032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10062 = arg_129_1.actors_["10062"].transform.localPosition
				arg_129_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10062", 3)

				for iter_132_0 = 0, arg_129_1.actors_["10062"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10062"].transform:GetChild(iter_132_0)

					if var_132_0.name == "" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_132_2 = arg_129_1.actors_["10062"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10062 == nil then
				arg_129_1.var_.actorSpriteComps10062 = var_132_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_3 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.actorSpriteComps10062 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								iter_132_2.color = Color.New(Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_3), Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_3), (Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_3)))
							else
								local var_132_4 = Mathf.Lerp(iter_132_2.color.r, 1, (arg_129_1.time_ - 0) / var_132_3)

								iter_132_2.color = Color.New(var_132_4, var_132_4, var_132_4)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.actorSpriteComps10062 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_132_4 then
						iter_132_4.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10062 = nil
			end

			local var_132_5 = 0
			local var_132_6 = 0.1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(410082031)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 4 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 4)

				if (4 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 4)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082031", "story_v_out_410082.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082031", "story_v_out_410082.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_410082", "410082031", "story_v_out_410082.awb")

						arg_129_1:RecordAudio("410082031", var_132_12)
						arg_129_1:RecordAudio("410082031", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410082", "410082031", "story_v_out_410082.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410082", "410082031", "story_v_out_410082.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410082032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410082032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play410082033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10062"]) and arg_133_1.var_.actorSpriteComps10062 == nil then
				arg_133_1.var_.actorSpriteComps10062 = arg_133_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10062"]) then
				if arg_133_1.var_.actorSpriteComps10062 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10062"]) and arg_133_1.var_.actorSpriteComps10062 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10062 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(410082032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 39)

				if (39 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 39)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play410082033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410082033
		arg_137_1.duration_ = 15.93

		local var_137_0 = {
			zh = 5.6,
			ja = 15.933
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
				arg_137_0:Play410082034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10062 = arg_137_1.actors_["10062"].transform.localPosition
				arg_137_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10062", 3)

				for iter_140_0 = 0, arg_137_1.actors_["10062"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10062"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_2" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_140_2 = arg_137_1.actors_["10062"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10062 == nil then
				arg_137_1.var_.actorSpriteComps10062 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10062 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 1, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10062 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10062 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(410082033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 28 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 28)

				if (28 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 28)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082033", "story_v_out_410082.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082033", "story_v_out_410082.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_410082", "410082033", "story_v_out_410082.awb")

						arg_137_1:RecordAudio("410082033", var_140_12)
						arg_137_1:RecordAudio("410082033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410082", "410082033", "story_v_out_410082.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410082", "410082033", "story_v_out_410082.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play410082034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410082034
		arg_141_1.duration_ = 4.23

		local var_141_0 = {
			zh = 1.266,
			ja = 4.233
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410082035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1060 = arg_141_1.actors_["1060"].transform.localPosition
				arg_141_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1060", 2)

				for iter_144_0 = 0, arg_141_1.actors_["1060"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["1060"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_144_2 = arg_141_1.actors_["1060"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1060 == nil then
				arg_141_1.var_.actorSpriteComps1060 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps1060 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 1, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps1060 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps1060 = nil
			end

			local var_144_5 = arg_141_1.actors_["10062"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10062 = var_144_5.localPosition
				var_144_5.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10062", 4)

				for iter_144_5 = 0, var_144_5.childCount - 1 do
					local var_144_6 = var_144_5:GetChild(iter_144_5)

					if var_144_6.name == "split_2" or not string.find(var_144_6.name, "split") then
						var_144_6.gameObject:SetActive(true)
					else
						var_144_6.gameObject:SetActive(false)
					end
				end
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_141_1.time_ - 0) / var_144_7)
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(370, -390, -290)
			end

			local var_144_8 = arg_141_1.actors_["10062"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10062 == nil then
				arg_141_1.var_.actorSpriteComps10062 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 and not isNil(var_144_8) then
				if arg_141_1.var_.actorSpriteComps10062 then
					for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_144_7 then
							if arg_141_1.isInRecall_ then
								iter_144_7.color = Color.New(Mathf.Lerp(iter_144_7.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_9), Mathf.Lerp(iter_144_7.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_9), (Mathf.Lerp(iter_144_7.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_9)))
							else
								local var_144_10 = Mathf.Lerp(iter_144_7.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_9)

								iter_144_7.color = Color.New(var_144_10, var_144_10, var_144_10)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10062 then
				for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_144_9 then
						iter_144_9.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10062 = nil
			end

			local var_144_11 = 0
			local var_144_12 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(410082034)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 5 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 5)

				if (5 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 5)) > 0 and var_144_12 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16

					if var_144_16 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082034", "story_v_out_410082.awb") ~= 0 then
					local var_144_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082034", "story_v_out_410082.awb") / 1000

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_410082", "410082034", "story_v_out_410082.awb")

						arg_141_1:RecordAudio("410082034", var_144_18)
						arg_141_1:RecordAudio("410082034", var_144_18)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410082", "410082034", "story_v_out_410082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410082", "410082034", "story_v_out_410082.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_19 and arg_141_1.time_ < var_144_11 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play410082035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410082035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410082036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10062 = arg_145_1.actors_["10062"].transform.localPosition
				arg_145_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10062", 7)

				for iter_148_0 = 0, arg_145_1.actors_["10062"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["10062"].transform:GetChild(iter_148_0)

					if var_148_0.name == "" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_148_2 = arg_145_1.actors_["1060"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1060 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1060", 7)

				for iter_148_1 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_1)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_145_1.time_ - 0) / var_148_4)
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_148_5 = 0
			local var_148_6 = 1.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(410082035).content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 46 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 46)

				if (46 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 46)) > 0 and var_148_6 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_10 and arg_145_1.time_ < var_148_5 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410082036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410082037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.975

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(410082036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 39)

				if (39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 39)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410082037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410082037
		arg_153_1.duration_ = 8.87

		local var_153_0 = {
			zh = 3.733,
			ja = 8.866
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
				arg_153_0:Play410082038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.actors_["1056"] == nil then
				local var_156_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_156_0) then
					local var_156_1 = Object.Instantiate(var_156_0, arg_153_1.canvasGo_.transform)

					var_156_1.transform:SetSiblingIndex(1)

					var_156_1.name = "1056"
					var_156_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_153_1.actors_["1056"] = var_156_1

					if arg_153_1.isInRecall_ then
						for iter_156_0, iter_156_1 in ipairs((var_156_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_156_1.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_156_2 = arg_153_1.actors_["1056"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1056 = var_156_2.localPosition
				var_156_2.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1056", 4)

				for iter_156_2 = 0, var_156_2.childCount - 1 do
					local var_156_3 = var_156_2:GetChild(iter_156_2)

					if var_156_3.name == "split_1" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_153_1.time_ - 0) / var_156_4)
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_156_5 = arg_153_1.actors_["1060"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1060 = var_156_5.localPosition
				var_156_5.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1060", 2)

				for iter_156_3 = 0, var_156_5.childCount - 1 do
					local var_156_6 = var_156_5:GetChild(iter_156_3)

					if var_156_6.name == "" or not string.find(var_156_6.name, "split") then
						var_156_6.gameObject:SetActive(true)
					else
						var_156_6.gameObject:SetActive(false)
					end
				end
			end

			local var_156_7 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				var_156_5.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_153_1.time_ - 0) / var_156_7)
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				var_156_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_156_8 = arg_153_1.actors_["1056"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1056 == nil then
				arg_153_1.var_.actorSpriteComps1056 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_9 and not isNil(var_156_8) then
				if arg_153_1.var_.actorSpriteComps1056 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								iter_156_5.color = Color.New(Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_9), Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_9), (Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_9)))
							else
								local var_156_10 = Mathf.Lerp(iter_156_5.color.r, 1, (arg_153_1.time_ - 0) / var_156_9)

								iter_156_5.color = Color.New(var_156_10, var_156_10, var_156_10)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_9 and arg_153_1.time_ < 0 + var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps1056 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_156_7 then
						iter_156_7.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1056 = nil
			end

			local var_156_11 = arg_153_1.actors_["1060"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.actorSpriteComps1060 == nil then
				arg_153_1.var_.actorSpriteComps1060 = var_156_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_12 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_12 and not isNil(var_156_11) then
				if arg_153_1.var_.actorSpriteComps1060 then
					for iter_156_8, iter_156_9 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_156_9 then
							if arg_153_1.isInRecall_ then
								iter_156_9.color = Color.New(Mathf.Lerp(iter_156_9.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_12), Mathf.Lerp(iter_156_9.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_12), (Mathf.Lerp(iter_156_9.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_12)))
							else
								local var_156_13 = Mathf.Lerp(iter_156_9.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_12)

								iter_156_9.color = Color.New(var_156_13, var_156_13, var_156_13)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_12 and arg_153_1.time_ < 0 + var_156_12 + arg_156_0 and not isNil(var_156_11) and arg_153_1.var_.actorSpriteComps1060 then
				for iter_156_10, iter_156_11 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_156_11 then
						iter_156_11.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps1060 = nil
			end

			local var_156_14 = 0
			local var_156_15 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_16 = arg_153_1:GetWordFromCfg(410082037)
				local var_156_17 = arg_153_1:FormatText(var_156_16.content)

				arg_153_1.text_.text = var_156_17

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 20 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 20)

				if (20 <= 0 and var_156_15 or var_156_15 * (utf8.len(var_156_17) / 20)) > 0 and var_156_15 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_14
					end
				end

				arg_153_1.text_.text = var_156_17
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082037", "story_v_out_410082.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_out_410082", "410082037", "story_v_out_410082.awb") / 1000

					if var_156_20 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_14
					end

					if var_156_16.prefab_name ~= "" and arg_153_1.actors_[var_156_16.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_16.prefab_name].transform, "story_v_out_410082", "410082037", "story_v_out_410082.awb")

						arg_153_1:RecordAudio("410082037", var_156_21)
						arg_153_1:RecordAudio("410082037", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410082", "410082037", "story_v_out_410082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410082", "410082037", "story_v_out_410082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_15, arg_153_1.talkMaxDuration)

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_14) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_14 + var_156_22 and arg_153_1.time_ < var_156_14 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	Play410082038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410082038
		arg_157_1.duration_ = 8.63

		local var_157_0 = {
			zh = 3.633,
			ja = 8.633
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410082039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1060 = arg_157_1.actors_["1060"].transform.localPosition
				arg_157_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1060", 2)

				for iter_160_0 = 0, arg_157_1.actors_["1060"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["1060"].transform:GetChild(iter_160_0)

					if var_160_0.name == "" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_160_2 = arg_157_1.actors_["1060"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1060 == nil then
				arg_157_1.var_.actorSpriteComps1060 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps1060 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1060 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1060 = nil
			end

			local var_160_5 = arg_157_1.actors_["1056"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps1056 == nil then
				arg_157_1.var_.actorSpriteComps1056 = var_160_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.actorSpriteComps1056 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								iter_160_6.color = Color.New(Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_6), Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_6), (Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_6)))
							else
								local var_160_7 = Mathf.Lerp(iter_160_6.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_6)

								iter_160_6.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps1056 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_160_8 then
						iter_160_8.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1056 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(410082038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 20 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 20)

				if (20 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 20)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082038", "story_v_out_410082.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082038", "story_v_out_410082.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_410082", "410082038", "story_v_out_410082.awb")

						arg_157_1:RecordAudio("410082038", var_160_15)
						arg_157_1:RecordAudio("410082038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410082", "410082038", "story_v_out_410082.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410082", "410082038", "story_v_out_410082.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410082039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410082039
		arg_161_1.duration_ = 8.73

		local var_161_0 = {
			zh = 6.2,
			ja = 8.733
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
				arg_161_0:Play410082040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.8

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(410082039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 32)

				if (32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 32)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082039", "story_v_out_410082.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082039", "story_v_out_410082.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_410082", "410082039", "story_v_out_410082.awb")

						arg_161_1:RecordAudio("410082039", var_164_6)
						arg_161_1:RecordAudio("410082039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410082", "410082039", "story_v_out_410082.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410082", "410082039", "story_v_out_410082.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play410082040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410082040
		arg_165_1.duration_ = 7.5

		local var_165_0 = {
			zh = 3.333,
			ja = 7.5
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410082041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1056 = arg_165_1.actors_["1056"].transform.localPosition
				arg_165_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1056", 4)

				for iter_168_0 = 0, arg_165_1.actors_["1056"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1056"].transform:GetChild(iter_168_0)

					if var_168_0.name == "split_2" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_168_2 = arg_165_1.actors_["1056"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1056 == nil then
				arg_165_1.var_.actorSpriteComps1056 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1056 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								iter_168_2.color = Color.New(Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_2.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_2.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1056 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1056 = nil
			end

			local var_168_5 = arg_165_1.actors_["1060"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1060 == nil then
				arg_165_1.var_.actorSpriteComps1060 = var_168_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.actorSpriteComps1060 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								iter_168_6.color = Color.New(Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_6), Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_6), (Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_6)))
							else
								local var_168_7 = Mathf.Lerp(iter_168_6.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_6)

								iter_168_6.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1060 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_168_8 then
						iter_168_8.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1060 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(410082040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 15 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 15)

				if (15 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 15)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082040", "story_v_out_410082.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082040", "story_v_out_410082.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_410082", "410082040", "story_v_out_410082.awb")

						arg_165_1:RecordAudio("410082040", var_168_15)
						arg_165_1:RecordAudio("410082040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410082", "410082040", "story_v_out_410082.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410082", "410082040", "story_v_out_410082.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play410082041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410082041
		arg_169_1.duration_ = 11.93

		local var_169_0 = {
			zh = 5,
			ja = 11.933
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410082042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1060 = arg_169_1.actors_["1060"].transform.localPosition
				arg_169_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1060", 2)

				for iter_172_0 = 0, arg_169_1.actors_["1060"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["1060"].transform:GetChild(iter_172_0)

					if var_172_0.name == "" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_172_2 = arg_169_1.actors_["1060"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1060 == nil then
				arg_169_1.var_.actorSpriteComps1060 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps1060 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 1, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1060 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps1060 = nil
			end

			local var_172_5 = arg_169_1.actors_["1056"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps1056 == nil then
				arg_169_1.var_.actorSpriteComps1056 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps1056 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								iter_172_6.color = Color.New(Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_6.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_6.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps1056 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_172_8 then
						iter_172_8.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1056 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.55

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(410082041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 22 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 22)

				if (22 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 22)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082041", "story_v_out_410082.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082041", "story_v_out_410082.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_410082", "410082041", "story_v_out_410082.awb")

						arg_169_1:RecordAudio("410082041", var_172_15)
						arg_169_1:RecordAudio("410082041", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410082", "410082041", "story_v_out_410082.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410082", "410082041", "story_v_out_410082.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play410082042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410082042
		arg_173_1.duration_ = 9.07

		local var_173_0 = {
			zh = 7.266,
			ja = 9.066
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410082043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.725

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(410082042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 29 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 29)

				if (29 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 29)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082042", "story_v_out_410082.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082042", "story_v_out_410082.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_410082", "410082042", "story_v_out_410082.awb")

						arg_173_1:RecordAudio("410082042", var_176_6)
						arg_173_1:RecordAudio("410082042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410082", "410082042", "story_v_out_410082.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410082", "410082042", "story_v_out_410082.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play410082043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410082043
		arg_177_1.duration_ = 9.8

		local var_177_0 = {
			zh = 9.2,
			ja = 9.8
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
				arg_177_0:Play410082044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1056 = arg_177_1.actors_["1056"].transform.localPosition
				arg_177_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1056", 4)

				for iter_180_0 = 0, arg_177_1.actors_["1056"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["1056"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_2" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_180_2 = arg_177_1.actors_["1056"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1056 == nil then
				arg_177_1.var_.actorSpriteComps1056 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1056 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								iter_180_2.color = Color.New(Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_2.color.r, 1, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_2.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1056 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1056 = nil
			end

			local var_180_5 = arg_177_1.actors_["1060"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps1060 == nil then
				arg_177_1.var_.actorSpriteComps1060 = var_180_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_6 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_6 and not isNil(var_180_5) then
				if arg_177_1.var_.actorSpriteComps1060 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_180_6 then
							if arg_177_1.isInRecall_ then
								iter_180_6.color = Color.New(Mathf.Lerp(iter_180_6.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_6), Mathf.Lerp(iter_180_6.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_6), (Mathf.Lerp(iter_180_6.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_6)))
							else
								local var_180_7 = Mathf.Lerp(iter_180_6.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_6)

								iter_180_6.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_6 and arg_177_1.time_ < 0 + var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps1060 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_180_8 then
						iter_180_8.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1060 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 1.025

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(410082043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 41 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 41)

				if (41 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 41)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082043", "story_v_out_410082.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082043", "story_v_out_410082.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_410082", "410082043", "story_v_out_410082.awb")

						arg_177_1:RecordAudio("410082043", var_180_15)
						arg_177_1:RecordAudio("410082043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410082", "410082043", "story_v_out_410082.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410082", "410082043", "story_v_out_410082.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play410082044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410082044
		arg_181_1.duration_ = 8.47

		local var_181_0 = {
			zh = 5.3,
			ja = 8.466
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410082045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(410082044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 30 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 30)

				if (30 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 30)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082044", "story_v_out_410082.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082044", "story_v_out_410082.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_410082", "410082044", "story_v_out_410082.awb")

						arg_181_1:RecordAudio("410082044", var_184_6)
						arg_181_1:RecordAudio("410082044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410082", "410082044", "story_v_out_410082.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410082", "410082044", "story_v_out_410082.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play410082045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410082045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410082046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1056"]) and arg_185_1.var_.actorSpriteComps1056 == nil then
				arg_185_1.var_.actorSpriteComps1056 = arg_185_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1056"]) then
				if arg_185_1.var_.actorSpriteComps1056 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1056"]) and arg_185_1.var_.actorSpriteComps1056 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1056 = nil
			end

			local var_188_2 = 0
			local var_188_3 = 1.3

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(410082045).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 52 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 52)

				if (52 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 52)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play410082046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410082046
		arg_189_1.duration_ = 4.27

		local var_189_0 = {
			zh = 4.266,
			ja = 3.1
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play410082047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1060 = arg_189_1.actors_["1060"].transform.localPosition
				arg_189_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1060", 2)

				for iter_192_0 = 0, arg_189_1.actors_["1060"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1060"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_192_2 = arg_189_1.actors_["1060"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1060 == nil then
				arg_189_1.var_.actorSpriteComps1060 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps1060 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps1060 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1060 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.55

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(410082046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 22 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 22)

				if (22 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 22)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082046", "story_v_out_410082.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082046", "story_v_out_410082.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_410082", "410082046", "story_v_out_410082.awb")

						arg_189_1:RecordAudio("410082046", var_192_12)
						arg_189_1:RecordAudio("410082046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410082", "410082046", "story_v_out_410082.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410082", "410082046", "story_v_out_410082.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410082047
		arg_193_1.duration_ = 12.77

		local var_193_0 = {
			zh = 12.733,
			ja = 12.766
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
				arg_193_0:Play410082048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1056 = arg_193_1.actors_["1056"].transform.localPosition
				arg_193_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1056", 4)

				for iter_196_0 = 0, arg_193_1.actors_["1056"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1056"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_1" or not string.find(var_196_0.name, "split") then
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

			local var_196_5 = arg_193_1.actors_["1060"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1060 == nil then
				arg_193_1.var_.actorSpriteComps1060 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps1060 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								iter_196_6.color = Color.New(Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_6.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_6.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1060 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_196_8 then
						iter_196_8.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1060 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 1.45

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
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

				local var_196_10 = arg_193_1:GetWordFromCfg(410082047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 59 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 59)

				if (59 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 59)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082047", "story_v_out_410082.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082047", "story_v_out_410082.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_410082", "410082047", "story_v_out_410082.awb")

						arg_193_1:RecordAudio("410082047", var_196_15)
						arg_193_1:RecordAudio("410082047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410082", "410082047", "story_v_out_410082.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410082", "410082047", "story_v_out_410082.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
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
	Play410082048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410082048
		arg_197_1.duration_ = 8.53

		local var_197_0 = {
			zh = 3.7,
			ja = 8.533
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
				arg_197_0:Play410082049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.45

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(410082048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 18 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 18)

				if (18 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 18)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082048", "story_v_out_410082.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082048", "story_v_out_410082.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_410082", "410082048", "story_v_out_410082.awb")

						arg_197_1:RecordAudio("410082048", var_200_6)
						arg_197_1:RecordAudio("410082048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410082", "410082048", "story_v_out_410082.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410082", "410082048", "story_v_out_410082.awb")
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
	Play410082049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410082049
		arg_201_1.duration_ = 9.4

		local var_201_0 = {
			zh = 6.2,
			ja = 9.4
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
				arg_201_0:Play410082050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1060 = arg_201_1.actors_["1060"].transform.localPosition
				arg_201_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1060", 2)

				for iter_204_0 = 0, arg_201_1.actors_["1060"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["1060"].transform:GetChild(iter_204_0)

					if var_204_0.name == "" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_204_2 = arg_201_1.actors_["1060"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1060 == nil then
				arg_201_1.var_.actorSpriteComps1060 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps1060 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1060 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1060 = nil
			end

			local var_204_5 = arg_201_1.actors_["1056"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps1056 == nil then
				arg_201_1.var_.actorSpriteComps1056 = var_204_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_6 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.actorSpriteComps1056 then
					for iter_204_5, iter_204_6 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps1056 then
				for iter_204_7, iter_204_8 in pairs(arg_201_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_204_8 then
						iter_204_8.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1056 = nil
			end

			local var_204_8 = 0
			local var_204_9 = 0.65

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(410082049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 26 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 26)

				if (26 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 26)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082049", "story_v_out_410082.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082049", "story_v_out_410082.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_410082", "410082049", "story_v_out_410082.awb")

						arg_201_1:RecordAudio("410082049", var_204_15)
						arg_201_1:RecordAudio("410082049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410082", "410082049", "story_v_out_410082.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410082", "410082049", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410082050
		arg_205_1.duration_ = 6.13

		local var_205_0 = {
			zh = 3.166,
			ja = 6.133
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
				arg_205_0:Play410082051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1060"]) and arg_205_1.var_.actorSpriteComps1060 == nil then
				arg_205_1.var_.actorSpriteComps1060 = arg_205_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1060"]) then
				if arg_205_1.var_.actorSpriteComps1060 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1060"]) and arg_205_1.var_.actorSpriteComps1060 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1060 = nil
			end

			local var_208_2 = 0
			local var_208_3 = 0.3

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(410082050)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 12 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 12)

				if (12 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 12)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082050", "story_v_out_410082.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_410082", "410082050", "story_v_out_410082.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_410082", "410082050", "story_v_out_410082.awb")

						arg_205_1:RecordAudio("410082050", var_208_9)
						arg_205_1:RecordAudio("410082050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410082", "410082050", "story_v_out_410082.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410082", "410082050", "story_v_out_410082.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play410082051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410082051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410082052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056 = arg_209_1.actors_["1056"].transform.localPosition
				arg_209_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1056", 7)

				for iter_212_0 = 0, arg_209_1.actors_["1056"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["1056"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_212_2 = arg_209_1.actors_["1060"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1060", 7)

				for iter_212_1 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_1)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_212_5 = 0
			local var_212_6 = 0.875

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(410082051).content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 35 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 35)

				if (35 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 35)) > 0 and var_212_6 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_10 and arg_209_1.time_ < var_212_5 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "1060",
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
	Play410082052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410082052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410082053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.95

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(410082052).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 38 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 38)

				if (38 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 38)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410082053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410082053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410082054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.45

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(410082053).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 58 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 58)

				if (58 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 58)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410082054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410082054
		arg_221_1.duration_ = 5.4

		local var_221_0 = {
			zh = 1.4,
			ja = 5.4
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
				arg_221_0:Play410082055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1060 = arg_221_1.actors_["1060"].transform.localPosition
				arg_221_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1060", 2)

				for iter_224_0 = 0, arg_221_1.actors_["1060"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["1060"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_224_2 = arg_221_1.actors_["1056"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056 = var_224_2.localPosition
				var_224_2.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1056", 3)

				for iter_224_1 = 0, var_224_2.childCount - 1 do
					local var_224_3 = var_224_2:GetChild(iter_224_1)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_2.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_221_1.time_ - 0) / var_224_4)
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_224_5 = "1012"

			if arg_221_1.actors_["1012"] == nil then
				local var_224_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_224_6) then
					local var_224_7 = Object.Instantiate(var_224_6, arg_221_1.canvasGo_.transform)

					var_224_7.transform:SetSiblingIndex(1)

					var_224_7.name = var_224_5
					var_224_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_221_1.actors_[var_224_5] = var_224_7

					if arg_221_1.isInRecall_ then
						for iter_224_2, iter_224_3 in ipairs((var_224_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_224_8 = arg_221_1.actors_["1012"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1012 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1012", 4)

				for iter_224_4 = 0, var_224_8.childCount - 1 do
					local var_224_9 = var_224_8:GetChild(iter_224_4)

					if var_224_9.name == "" or not string.find(var_224_9.name, "split") then
						var_224_9.gameObject:SetActive(true)
					else
						var_224_9.gameObject:SetActive(false)
					end
				end
			end

			local var_224_10 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_10 then
				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_221_1.time_ - 0) / var_224_10)
			end

			if arg_221_1.time_ >= 0 + var_224_10 and arg_221_1.time_ < 0 + var_224_10 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(390, -465, 300)
			end

			local var_224_11 = arg_221_1.actors_["1060"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.actorSpriteComps1060 == nil then
				arg_221_1.var_.actorSpriteComps1060 = var_224_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_12 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_12 and not isNil(var_224_11) then
				if arg_221_1.var_.actorSpriteComps1060 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								iter_224_6.color = Color.New(Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_12), Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_12), (Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_12)))
							else
								local var_224_13 = Mathf.Lerp(iter_224_6.color.r, 1, (arg_221_1.time_ - 0) / var_224_12)

								iter_224_6.color = Color.New(var_224_13, var_224_13, var_224_13)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_12 and arg_221_1.time_ < 0 + var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.actorSpriteComps1060 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_224_8 then
						iter_224_8.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1060 = nil
			end

			local var_224_14 = arg_221_1.actors_["1056"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps1056 == nil then
				arg_221_1.var_.actorSpriteComps1056 = var_224_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_15 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_15 and not isNil(var_224_14) then
				if arg_221_1.var_.actorSpriteComps1056 then
					for iter_224_9, iter_224_10 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_224_10 then
							if arg_221_1.isInRecall_ then
								iter_224_10.color = Color.New(Mathf.Lerp(iter_224_10.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_15), Mathf.Lerp(iter_224_10.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_15), (Mathf.Lerp(iter_224_10.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_15)))
							else
								local var_224_16 = Mathf.Lerp(iter_224_10.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_15)

								iter_224_10.color = Color.New(var_224_16, var_224_16, var_224_16)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_15 and arg_221_1.time_ < 0 + var_224_15 + arg_224_0 and not isNil(var_224_14) and arg_221_1.var_.actorSpriteComps1056 then
				for iter_224_11, iter_224_12 in pairs(arg_221_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_224_12 then
						iter_224_12.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1056 = nil
			end

			local var_224_17 = arg_221_1.actors_["1012"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.actorSpriteComps1012 == nil then
				arg_221_1.var_.actorSpriteComps1012 = var_224_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_18 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_18 and not isNil(var_224_17) then
				if arg_221_1.var_.actorSpriteComps1012 then
					for iter_224_13, iter_224_14 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_224_14 then
							if arg_221_1.isInRecall_ then
								iter_224_14.color = Color.New(Mathf.Lerp(iter_224_14.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_18), Mathf.Lerp(iter_224_14.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_18), (Mathf.Lerp(iter_224_14.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_18)))
							else
								local var_224_19 = Mathf.Lerp(iter_224_14.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_18)

								iter_224_14.color = Color.New(var_224_19, var_224_19, var_224_19)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_18 and arg_221_1.time_ < 0 + var_224_18 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.actorSpriteComps1012 then
				for iter_224_15, iter_224_16 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_224_16 then
						iter_224_16.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1012 = nil
			end

			local var_224_20 = 0
			local var_224_21 = 0.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_20 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_22 = arg_221_1:GetWordFromCfg(410082054)
				local var_224_23 = arg_221_1:FormatText(var_224_22.content)

				arg_221_1.text_.text = var_224_23

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_25 = 4 <= 0 and var_224_21 or var_224_21 * (utf8.len(var_224_23) / 4)

				if (4 <= 0 and var_224_21 or var_224_21 * (utf8.len(var_224_23) / 4)) > 0 and var_224_21 < var_224_25 then
					arg_221_1.talkMaxDuration = var_224_25

					if var_224_25 + var_224_20 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_20
					end
				end

				arg_221_1.text_.text = var_224_23
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082054", "story_v_out_410082.awb") ~= 0 then
					local var_224_26 = manager.audio:GetVoiceLength("story_v_out_410082", "410082054", "story_v_out_410082.awb") / 1000

					if var_224_26 + var_224_20 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_26 + var_224_20
					end

					if var_224_22.prefab_name ~= "" and arg_221_1.actors_[var_224_22.prefab_name] ~= nil then
						local var_224_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_22.prefab_name].transform, "story_v_out_410082", "410082054", "story_v_out_410082.awb")

						arg_221_1:RecordAudio("410082054", var_224_27)
						arg_221_1:RecordAudio("410082054", var_224_27)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410082", "410082054", "story_v_out_410082.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410082", "410082054", "story_v_out_410082.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_28 = math.max(var_224_21, arg_221_1.talkMaxDuration)

			if var_224_20 <= arg_221_1.time_ and arg_221_1.time_ < var_224_20 + var_224_28 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_20) / var_224_28

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_20 + var_224_28 and arg_221_1.time_ < var_224_20 + var_224_28 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410082055
		arg_225_1.duration_ = 2.7

		local var_225_0 = {
			zh = 2.266,
			ja = 2.7
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
				arg_225_0:Play410082056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1056 = arg_225_1.actors_["1056"].transform.localPosition
				arg_225_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1056", 3)

				for iter_228_0 = 0, arg_225_1.actors_["1056"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["1056"].transform:GetChild(iter_228_0)

					if var_228_0.name == "split_4" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
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

			local var_228_5 = arg_225_1.actors_["1060"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_6 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								iter_228_6.color = Color.New(Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_6), Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_6), (Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_6)))
							else
								local var_228_7 = Mathf.Lerp(iter_228_6.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_6)

								iter_228_6.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_8 then
						iter_228_8.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_8 = 0
			local var_228_9 = 0.225

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
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

				local var_228_10 = arg_225_1:GetWordFromCfg(410082055)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 9 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 9)

				if (9 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 9)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082055", "story_v_out_410082.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082055", "story_v_out_410082.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_out_410082", "410082055", "story_v_out_410082.awb")

						arg_225_1:RecordAudio("410082055", var_228_15)
						arg_225_1:RecordAudio("410082055", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410082", "410082055", "story_v_out_410082.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410082", "410082055", "story_v_out_410082.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
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
	Play410082056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410082056
		arg_229_1.duration_ = 6.9

		local var_229_0 = {
			zh = 3.666,
			ja = 6.9
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
				arg_229_0:Play410082057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1012 = arg_229_1.actors_["1012"].transform.localPosition
				arg_229_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1012", 4)

				for iter_232_0 = 0, arg_229_1.actors_["1012"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["1012"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_3" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_232_2 = arg_229_1.actors_["1012"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1012 == nil then
				arg_229_1.var_.actorSpriteComps1012 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps1012 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1012 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1012 = nil
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
			local var_232_9 = 0.5

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(410082056)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 20 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 20)

				if (20 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 20)) > 0 and var_232_9 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082056", "story_v_out_410082.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082056", "story_v_out_410082.awb") / 1000

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_out_410082", "410082056", "story_v_out_410082.awb")

						arg_229_1:RecordAudio("410082056", var_232_15)
						arg_229_1:RecordAudio("410082056", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410082", "410082056", "story_v_out_410082.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410082", "410082056", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410082057
		arg_233_1.duration_ = 7.37

		local var_233_0 = {
			zh = 4.333,
			ja = 7.366
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
				arg_233_0:Play410082058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1060 = arg_233_1.actors_["1060"].transform.localPosition
				arg_233_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1060", 2)

				for iter_236_0 = 0, arg_233_1.actors_["1060"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1060"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_236_2 = arg_233_1.actors_["1060"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_5 = arg_233_1.actors_["1012"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1012 == nil then
				arg_233_1.var_.actorSpriteComps1012 = var_236_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_6 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.actorSpriteComps1012 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps1012 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_236_8 then
						iter_236_8.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps1012 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.575

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(410082057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 23 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 23)

				if (23 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 23)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082057", "story_v_out_410082.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082057", "story_v_out_410082.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_410082", "410082057", "story_v_out_410082.awb")

						arg_233_1:RecordAudio("410082057", var_236_15)
						arg_233_1:RecordAudio("410082057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410082", "410082057", "story_v_out_410082.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410082", "410082057", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410082058
		arg_237_1.duration_ = 8

		local var_237_0 = {
			zh = 4.833,
			ja = 8
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
				arg_237_0:Play410082059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1012 = arg_237_1.actors_["1012"].transform.localPosition
				arg_237_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1012", 4)

				for iter_240_0 = 0, arg_237_1.actors_["1012"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["1012"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_240_2 = arg_237_1.actors_["1012"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1012 == nil then
				arg_237_1.var_.actorSpriteComps1012 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps1012 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1012 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps1012 = nil
			end

			local var_240_5 = arg_237_1.actors_["1060"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1060 == nil then
				arg_237_1.var_.actorSpriteComps1060 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps1060 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps1060 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_240_8 then
						iter_240_8.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1060 = nil
			end

			local var_240_8 = 0
			local var_240_9 = 0.7

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(410082058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 28 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 28)

				if (28 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 28)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082058", "story_v_out_410082.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082058", "story_v_out_410082.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_410082", "410082058", "story_v_out_410082.awb")

						arg_237_1:RecordAudio("410082058", var_240_15)
						arg_237_1:RecordAudio("410082058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410082", "410082058", "story_v_out_410082.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410082", "410082058", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410082059
		arg_241_1.duration_ = 9

		local var_241_0 = {
			zh = 4.6,
			ja = 9
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
				arg_241_0:Play410082060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.675

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(410082059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 27 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 27)

				if (27 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 27)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082059", "story_v_out_410082.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082059", "story_v_out_410082.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_410082", "410082059", "story_v_out_410082.awb")

						arg_241_1:RecordAudio("410082059", var_244_6)
						arg_241_1:RecordAudio("410082059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410082", "410082059", "story_v_out_410082.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410082", "410082059", "story_v_out_410082.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play410082060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410082060
		arg_245_1.duration_ = 14.87

		local var_245_0 = {
			zh = 8.6,
			ja = 14.866
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410082061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.975

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(410082060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 39 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 39)

				if (39 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 39)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082060", "story_v_out_410082.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082060", "story_v_out_410082.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_410082", "410082060", "story_v_out_410082.awb")

						arg_245_1:RecordAudio("410082060", var_248_6)
						arg_245_1:RecordAudio("410082060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410082", "410082060", "story_v_out_410082.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410082", "410082060", "story_v_out_410082.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410082061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410082061
		arg_249_1.duration_ = 5.63

		local var_249_0 = {
			zh = 5.633,
			ja = 4.666
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
				arg_249_0:Play410082062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1056 = arg_249_1.actors_["1056"].transform.localPosition
				arg_249_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1056", 3)

				for iter_252_0 = 0, arg_249_1.actors_["1056"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1056"].transform:GetChild(iter_252_0)

					if var_252_0.name == "split_2" or not string.find(var_252_0.name, "split") then
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

			local var_252_2 = arg_249_1.actors_["1056"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1056 == nil then
				arg_249_1.var_.actorSpriteComps1056 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps1056 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								iter_252_2.color = Color.New(Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_3), Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_3), (Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_3)))
							else
								local var_252_4 = Mathf.Lerp(iter_252_2.color.r, 1, (arg_249_1.time_ - 0) / var_252_3)

								iter_252_2.color = Color.New(var_252_4, var_252_4, var_252_4)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1056 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_252_4 then
						iter_252_4.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1056 = nil
			end

			local var_252_5 = arg_249_1.actors_["1012"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1012 == nil then
				arg_249_1.var_.actorSpriteComps1012 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps1012 then
					for iter_252_5, iter_252_6 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_252_6 then
							if arg_249_1.isInRecall_ then
								iter_252_6.color = Color.New(Mathf.Lerp(iter_252_6.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_6.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_6.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_6.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_6.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1012 then
				for iter_252_7, iter_252_8 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_252_8 then
						iter_252_8.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps1012 = nil
			end

			local var_252_8 = 0
			local var_252_9 = 0.7

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
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

				local var_252_10 = arg_249_1:GetWordFromCfg(410082061)
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082061", "story_v_out_410082.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082061", "story_v_out_410082.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_410082", "410082061", "story_v_out_410082.awb")

						arg_249_1:RecordAudio("410082061", var_252_15)
						arg_249_1:RecordAudio("410082061", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410082", "410082061", "story_v_out_410082.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410082", "410082061", "story_v_out_410082.awb")
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
				actorName = "1056",
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
	Play410082062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410082062
		arg_253_1.duration_ = 4.53

		local var_253_0 = {
			zh = 1.833,
			ja = 4.533
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
				arg_253_0:Play410082063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1012 = arg_253_1.actors_["1012"].transform.localPosition
				arg_253_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1012", 4)

				for iter_256_0 = 0, arg_253_1.actors_["1012"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1012"].transform:GetChild(iter_256_0)

					if var_256_0.name == "" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_256_2 = arg_253_1.actors_["1012"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1012 == nil then
				arg_253_1.var_.actorSpriteComps1012 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1012 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								iter_256_2.color = Color.New(Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_2.color.r, 1, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_2.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1012 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1012 = nil
			end

			local var_256_5 = arg_253_1.actors_["1056"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps1056 == nil then
				arg_253_1.var_.actorSpriteComps1056 = var_256_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_6 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.actorSpriteComps1056 then
					for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_256_6 then
							if arg_253_1.isInRecall_ then
								iter_256_6.color = Color.New(Mathf.Lerp(iter_256_6.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_6), Mathf.Lerp(iter_256_6.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_6), (Mathf.Lerp(iter_256_6.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_6)))
							else
								local var_256_7 = Mathf.Lerp(iter_256_6.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_6)

								iter_256_6.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.actorSpriteComps1056 then
				for iter_256_7, iter_256_8 in pairs(arg_253_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_256_8 then
						iter_256_8.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1056 = nil
			end

			local var_256_8 = 0
			local var_256_9 = 0.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(410082062)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 6 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 6)

				if (6 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 6)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082062", "story_v_out_410082.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082062", "story_v_out_410082.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_410082", "410082062", "story_v_out_410082.awb")

						arg_253_1:RecordAudio("410082062", var_256_15)
						arg_253_1:RecordAudio("410082062", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410082", "410082062", "story_v_out_410082.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410082", "410082062", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410082063
		arg_257_1.duration_ = 3.7

		local var_257_0 = {
			zh = 1.066,
			ja = 3.7
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410082064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1056 = arg_257_1.actors_["1056"].transform.localPosition
				arg_257_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1056", 3)

				for iter_260_0 = 0, arg_257_1.actors_["1056"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["1056"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_4" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_260_2 = arg_257_1.actors_["1056"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1056 == nil then
				arg_257_1.var_.actorSpriteComps1056 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1056 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								iter_260_2.color = Color.New(Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_2.color.r, 1, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_2.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1056 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1056 = nil
			end

			local var_260_5 = arg_257_1.actors_["1012"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps1012 == nil then
				arg_257_1.var_.actorSpriteComps1012 = var_260_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_6 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.actorSpriteComps1012 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_260_6 then
							if arg_257_1.isInRecall_ then
								iter_260_6.color = Color.New(Mathf.Lerp(iter_260_6.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_6), Mathf.Lerp(iter_260_6.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_6), (Mathf.Lerp(iter_260_6.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_6)))
							else
								local var_260_7 = Mathf.Lerp(iter_260_6.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_6)

								iter_260_6.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps1012 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_260_8 then
						iter_260_8.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps1012 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(410082063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 4 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 4)

				if (4 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 4)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082063", "story_v_out_410082.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082063", "story_v_out_410082.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_410082", "410082063", "story_v_out_410082.awb")

						arg_257_1:RecordAudio("410082063", var_260_15)
						arg_257_1:RecordAudio("410082063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410082", "410082063", "story_v_out_410082.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410082", "410082063", "story_v_out_410082.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play410082064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410082064
		arg_261_1.duration_ = 7.27

		local var_261_0 = {
			zh = 4.166,
			ja = 7.266
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
				arg_261_0:Play410082065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1012 = arg_261_1.actors_["1012"].transform.localPosition
				arg_261_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1012", 4)

				for iter_264_0 = 0, arg_261_1.actors_["1012"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["1012"].transform:GetChild(iter_264_0)

					if var_264_0.name == "" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_264_2 = arg_261_1.actors_["1012"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1012 == nil then
				arg_261_1.var_.actorSpriteComps1012 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps1012 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1012 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1012 = nil
			end

			local var_264_5 = arg_261_1.actors_["1056"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1056 == nil then
				arg_261_1.var_.actorSpriteComps1056 = var_264_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_6 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.actorSpriteComps1056 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								iter_264_6.color = Color.New(Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_6), Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_6), (Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_6)))
							else
								local var_264_7 = Mathf.Lerp(iter_264_6.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_6)

								iter_264_6.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps1056 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_264_8 then
						iter_264_8.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps1056 = nil
			end

			local var_264_8 = 0
			local var_264_9 = 0.525

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:GetWordFromCfg(410082064)
				local var_264_11 = arg_261_1:FormatText(var_264_10.content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 21 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 21)

				if (21 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 21)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082064", "story_v_out_410082.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082064", "story_v_out_410082.awb") / 1000

					if var_264_14 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_8
					end

					if var_264_10.prefab_name ~= "" and arg_261_1.actors_[var_264_10.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_10.prefab_name].transform, "story_v_out_410082", "410082064", "story_v_out_410082.awb")

						arg_261_1:RecordAudio("410082064", var_264_15)
						arg_261_1:RecordAudio("410082064", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410082", "410082064", "story_v_out_410082.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410082", "410082064", "story_v_out_410082.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410082065
		arg_265_1.duration_ = 7.03

		local var_265_0 = {
			zh = 2.4,
			ja = 7.033
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
				arg_265_0:Play410082066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1056 = arg_265_1.actors_["1056"].transform.localPosition
				arg_265_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1056", 3)

				for iter_268_0 = 0, arg_265_1.actors_["1056"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1056"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_2" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
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

			local var_268_5 = arg_265_1.actors_["1012"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps1012 == nil then
				arg_265_1.var_.actorSpriteComps1012 = var_268_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_6 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.actorSpriteComps1012 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.actorSpriteComps1012 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_268_8 then
						iter_268_8.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps1012 = nil
			end

			local var_268_8 = 0
			local var_268_9 = 0.325

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

				local var_268_10 = arg_265_1:GetWordFromCfg(410082065)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 13 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 13)

				if (13 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 13)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082065", "story_v_out_410082.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082065", "story_v_out_410082.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_410082", "410082065", "story_v_out_410082.awb")

						arg_265_1:RecordAudio("410082065", var_268_15)
						arg_265_1:RecordAudio("410082065", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410082", "410082065", "story_v_out_410082.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410082", "410082065", "story_v_out_410082.awb")
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
	Play410082066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410082066
		arg_269_1.duration_ = 9.5

		local var_269_0 = {
			zh = 5.933,
			ja = 9.5
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
				arg_269_0:Play410082067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1060 = arg_269_1.actors_["1060"].transform.localPosition
				arg_269_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1060", 2)

				for iter_272_0 = 0, arg_269_1.actors_["1060"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["1060"].transform:GetChild(iter_272_0)

					if var_272_0.name == "" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_272_2 = arg_269_1.actors_["1060"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1060 == nil then
				arg_269_1.var_.actorSpriteComps1060 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps1060 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1060 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1060 = nil
			end

			local var_272_5 = arg_269_1.actors_["1056"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1056 == nil then
				arg_269_1.var_.actorSpriteComps1056 = var_272_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_6 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.actorSpriteComps1056 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								iter_272_6.color = Color.New(Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_6), Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_6), (Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_6)))
							else
								local var_272_7 = Mathf.Lerp(iter_272_6.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_6)

								iter_272_6.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1056 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_272_8 then
						iter_272_8.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1056 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.675

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(410082066)
				local var_272_11 = arg_269_1:FormatText(var_272_10.content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 27 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 27)

				if (27 <= 0 and var_272_9 or var_272_9 * (utf8.len(var_272_11) / 27)) > 0 and var_272_9 < var_272_13 then
					arg_269_1.talkMaxDuration = var_272_13

					if var_272_13 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_13 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082066", "story_v_out_410082.awb") ~= 0 then
					local var_272_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082066", "story_v_out_410082.awb") / 1000

					if var_272_14 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_8
					end

					if var_272_10.prefab_name ~= "" and arg_269_1.actors_[var_272_10.prefab_name] ~= nil then
						local var_272_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_10.prefab_name].transform, "story_v_out_410082", "410082066", "story_v_out_410082.awb")

						arg_269_1:RecordAudio("410082066", var_272_15)
						arg_269_1:RecordAudio("410082066", var_272_15)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410082", "410082066", "story_v_out_410082.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410082", "410082066", "story_v_out_410082.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_16 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_16 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_16

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_16 and arg_269_1.time_ < var_272_8 + var_272_16 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410082067
		arg_273_1.duration_ = 9

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play410082068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if arg_273_1.bgs_.ST61 == nil then
				local var_276_0 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_276_0.name = "ST61"
				var_276_0.transform.parent = arg_273_1.stage_.transform
				var_276_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_.ST61 = var_276_0
			end

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				local var_276_1 = arg_273_1.bgs_.ST61

				arg_273_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_276_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_2 = var_276_1:GetComponent("SpriteRenderer")

				if var_276_2 and var_276_2.sprite then
					local var_276_3 = 2 * (var_276_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_276_1.transform.localScale = Vector3.New(var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, var_276_3 / var_276_2.sprite.bounds.size.y < var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x and var_276_3 * manager.ui.mainCameraCom_.aspect / var_276_2.sprite.bounds.size.x or var_276_3 / var_276_2.sprite.bounds.size.y, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "ST61" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_4 = 0

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_5 = 2

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_5 then
				local var_276_6 = Color.New(0, 0, 0)

				var_276_6.a = Mathf.Lerp(0, 1, (arg_273_1.time_ - var_276_4) / var_276_5)
				arg_273_1.mask_.color = var_276_6
			end

			if arg_273_1.time_ >= var_276_4 + var_276_5 and arg_273_1.time_ < var_276_4 + var_276_5 + arg_276_0 then
				local var_276_7 = Color.New(0, 0, 0)

				var_276_7.a = 1
				arg_273_1.mask_.color = var_276_7
			end

			local var_276_8 = 2

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_9 = 2

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 then
				local var_276_10 = Color.New(0, 0, 0)

				var_276_10.a = Mathf.Lerp(1, 0, (arg_273_1.time_ - var_276_8) / var_276_9)
				arg_273_1.mask_.color = var_276_10
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 then
				local var_276_11 = Color.New(0, 0, 0)

				arg_273_1.mask_.enabled = false
				var_276_11.a = 0
				arg_273_1.mask_.color = var_276_11
			end

			local var_276_12 = arg_273_1.actors_["1060"].transform

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_12.localPosition
				var_276_12.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 7)

				for iter_276_2 = 0, var_276_12.childCount - 1 do
					local var_276_13 = var_276_12:GetChild(iter_276_2)

					if var_276_13.name == "" or not string.find(var_276_13.name, "split") then
						var_276_13.gameObject:SetActive(true)
					else
						var_276_13.gameObject:SetActive(false)
					end
				end
			end

			local var_276_14 = 0.001

			if 2 <= arg_273_1.time_ and arg_273_1.time_ < 2 + var_276_14 then
				var_276_12.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_273_1.time_ - 2) / var_276_14)
			end

			if arg_273_1.time_ >= 2 + var_276_14 and arg_273_1.time_ < 2 + var_276_14 + arg_276_0 then
				var_276_12.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_276_15 = arg_273_1.actors_["1056"].transform

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056 = var_276_15.localPosition
				var_276_15.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1056", 7)

				for iter_276_3 = 0, var_276_15.childCount - 1 do
					local var_276_16 = var_276_15:GetChild(iter_276_3)

					if var_276_16.name == "" or not string.find(var_276_16.name, "split") then
						var_276_16.gameObject:SetActive(true)
					else
						var_276_16.gameObject:SetActive(false)
					end
				end
			end

			local var_276_17 = 0.001

			if 2 <= arg_273_1.time_ and arg_273_1.time_ < 2 + var_276_17 then
				var_276_15.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_273_1.time_ - 2) / var_276_17)
			end

			if arg_273_1.time_ >= 2 + var_276_17 and arg_273_1.time_ < 2 + var_276_17 + arg_276_0 then
				var_276_15.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_276_18 = arg_273_1.actors_["1012"].transform

			if 2 < arg_273_1.time_ and arg_273_1.time_ <= 2 + arg_276_0 then
				arg_273_1.var_.moveOldPos1012 = var_276_18.localPosition
				var_276_18.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1012", 7)

				for iter_276_4 = 0, var_276_18.childCount - 1 do
					local var_276_19 = var_276_18:GetChild(iter_276_4)

					if var_276_19.name == "" or not string.find(var_276_19.name, "split") then
						var_276_19.gameObject:SetActive(true)
					else
						var_276_19.gameObject:SetActive(false)
					end
				end
			end

			local var_276_20 = 0.001

			if 2 <= arg_273_1.time_ and arg_273_1.time_ < 2 + var_276_20 then
				var_276_18.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_273_1.time_ - 2) / var_276_20)
			end

			if arg_273_1.time_ >= 2 + var_276_20 and arg_273_1.time_ < 2 + var_276_20 + arg_276_0 then
				var_276_18.localPosition = Vector3.New(0, -2000, 300)
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_276_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_273_1.bgmTxt_.text ~= var_276_23 and arg_273_1.bgmTxt_.text ~= "" then
						if arg_273_1.bgmTxt2_.text ~= "" then
							arg_273_1.bgmTxt_.text = arg_273_1.bgmTxt2_.text
						end

						arg_273_1.bgmTxt2_.text = var_276_23

						arg_273_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_273_1.bgmTxt_.text = var_276_23
						arg_273_1.bgmTxt2_.text = var_276_23
					end

					if arg_273_1.bgmTimer then
						arg_273_1.bgmTimer:Stop()

						arg_273_1.bgmTimer = nil
					end

					if arg_273_1.settingData.show_music_name == 1 then
						arg_273_1.musicController:SetSelectedState("show")
						arg_273_1.musicAnimator_:Play("open", 0, 0)

						if arg_273_1.settingData.music_time ~= 0 then
							arg_273_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_273_1.settingData.music_time), function()
								if arg_273_1 == nil or isNil(arg_273_1.bgmTxt_) then
									return
								end

								arg_273_1.musicController:SetSelectedState("hide")
								arg_273_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_273_1.time_ and arg_273_1.time_ <= 0.266666666666667 + arg_276_0 then
				arg_273_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_276_26 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_273_1.bgmTxt_.text ~= var_276_26 and arg_273_1.bgmTxt_.text ~= "" then
						if arg_273_1.bgmTxt2_.text ~= "" then
							arg_273_1.bgmTxt_.text = arg_273_1.bgmTxt2_.text
						end

						arg_273_1.bgmTxt2_.text = var_276_26

						arg_273_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_273_1.bgmTxt_.text = var_276_26
						arg_273_1.bgmTxt2_.text = var_276_26
					end

					if arg_273_1.bgmTimer then
						arg_273_1.bgmTimer:Stop()

						arg_273_1.bgmTimer = nil
					end

					if arg_273_1.settingData.show_music_name == 1 then
						arg_273_1.musicController:SetSelectedState("show")
						arg_273_1.musicAnimator_:Play("open", 0, 0)

						if arg_273_1.settingData.music_time ~= 0 then
							arg_273_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_273_1.settingData.music_time), function()
								if arg_273_1 == nil or isNil(arg_273_1.bgmTxt_) then
									return
								end

								arg_273_1.musicController:SetSelectedState("hide")
								arg_273_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_27 = 4
			local var_276_28 = 1.475

			if 4 < arg_273_1.time_ and arg_273_1.time_ <= var_276_27 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_29 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_29:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_273_1.dialogCg_.alpha = arg_279_0
				end))
				var_276_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_30 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(410082067).content)

				arg_273_1.text_.text = var_276_30

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_32 = 59 <= 0 and var_276_28 or var_276_28 * (utf8.len(var_276_30) / 59)

				if (59 <= 0 and var_276_28 or var_276_28 * (utf8.len(var_276_30) / 59)) > 0 and var_276_28 < var_276_32 then
					arg_273_1.talkMaxDuration = var_276_32
					var_276_27 = var_276_27 + 0.3

					if var_276_32 + var_276_27 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_32 + var_276_27
					end
				end

				arg_273_1.text_.text = var_276_30
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_33 = var_276_27 + 0.3
			local var_276_34 = math.max(var_276_28, arg_273_1.talkMaxDuration)

			if var_276_27 + 0.3 <= arg_273_1.time_ and arg_273_1.time_ < var_276_33 + var_276_34 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_33) / var_276_34

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_33 + var_276_34 and arg_273_1.time_ < var_276_33 + var_276_34 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play410082068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410082068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play410082069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.975

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(410082068).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 39 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 39)

				if (39 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 39)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410082069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410082069
		arg_285_1.duration_ = 5.8

		local var_285_0 = {
			zh = 5.8,
			ja = 4.733
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
				arg_285_0:Play410082070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = arg_285_1.actors_["1060"].transform.localPosition
				arg_285_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 2)

				for iter_288_0 = 0, arg_285_1.actors_["1060"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["1060"].transform:GetChild(iter_288_0)

					if var_288_0.name == "" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_288_2 = arg_285_1.actors_["1012"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1012 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1012", 4)

				for iter_288_1 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_1)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(390, -465, 300)
			end

			local var_288_5 = arg_285_1.actors_["1060"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_288_3 then
							if arg_285_1.isInRecall_ then
								iter_288_3.color = Color.New(Mathf.Lerp(iter_288_3.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_6), Mathf.Lerp(iter_288_3.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_6), (Mathf.Lerp(iter_288_3.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_6)))
							else
								local var_288_7 = Mathf.Lerp(iter_288_3.color.r, 1, (arg_285_1.time_ - 0) / var_288_6)

								iter_288_3.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_5 then
						iter_288_5.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_8 = arg_285_1.actors_["1012"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps1012 == nil then
				arg_285_1.var_.actorSpriteComps1012 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_9 and not isNil(var_288_8) then
				if arg_285_1.var_.actorSpriteComps1012 then
					for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_288_7 then
							if arg_285_1.isInRecall_ then
								iter_288_7.color = Color.New(Mathf.Lerp(iter_288_7.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_9), Mathf.Lerp(iter_288_7.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_9), (Mathf.Lerp(iter_288_7.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_9)))
							else
								local var_288_10 = Mathf.Lerp(iter_288_7.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_9)

								iter_288_7.color = Color.New(var_288_10, var_288_10, var_288_10)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_9 and arg_285_1.time_ < 0 + var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps1012 then
				for iter_288_8, iter_288_9 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_288_9 then
						iter_288_9.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1012 = nil
			end

			local var_288_11 = 0
			local var_288_12 = 0.725

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(410082069)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 29 <= 0 and var_288_12 or var_288_12 * (utf8.len(var_288_14) / 29)

				if (29 <= 0 and var_288_12 or var_288_12 * (utf8.len(var_288_14) / 29)) > 0 and var_288_12 < var_288_16 then
					arg_285_1.talkMaxDuration = var_288_16

					if var_288_16 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_16 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082069", "story_v_out_410082.awb") ~= 0 then
					local var_288_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082069", "story_v_out_410082.awb") / 1000

					if var_288_17 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_11
					end

					if var_288_13.prefab_name ~= "" and arg_285_1.actors_[var_288_13.prefab_name] ~= nil then
						local var_288_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_13.prefab_name].transform, "story_v_out_410082", "410082069", "story_v_out_410082.awb")

						arg_285_1:RecordAudio("410082069", var_288_18)
						arg_285_1:RecordAudio("410082069", var_288_18)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410082", "410082069", "story_v_out_410082.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410082", "410082069", "story_v_out_410082.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_19 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_19 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_19

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_19 and arg_285_1.time_ < var_288_11 + var_288_19 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410082070
		arg_289_1.duration_ = 5.3

		local var_289_0 = {
			zh = 2.333,
			ja = 5.3
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
				arg_289_0:Play410082071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1012 = arg_289_1.actors_["1012"].transform.localPosition
				arg_289_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1012", 4)

				for iter_292_0 = 0, arg_289_1.actors_["1012"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["1012"].transform:GetChild(iter_292_0)

					if var_292_0.name == "" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_292_2 = arg_289_1.actors_["1012"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1012 == nil then
				arg_289_1.var_.actorSpriteComps1012 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1012 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1012 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1012 = nil
			end

			local var_292_5 = arg_289_1.actors_["1060"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps1060 == nil then
				arg_289_1.var_.actorSpriteComps1060 = var_292_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_6 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.actorSpriteComps1060 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps1060 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_292_8 then
						iter_292_8.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps1060 = nil
			end

			local var_292_8 = 0
			local var_292_9 = 0.325

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(410082070)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 13 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 13)

				if (13 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 13)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082070", "story_v_out_410082.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082070", "story_v_out_410082.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_410082", "410082070", "story_v_out_410082.awb")

						arg_289_1:RecordAudio("410082070", var_292_15)
						arg_289_1:RecordAudio("410082070", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410082", "410082070", "story_v_out_410082.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410082", "410082070", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410082071
		arg_293_1.duration_ = 12.37

		local var_293_0 = {
			zh = 6.9,
			ja = 12.366
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
				arg_293_0:Play410082072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.75

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(410082071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 30 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 30)

				if (30 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 30)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082071", "story_v_out_410082.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082071", "story_v_out_410082.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_410082", "410082071", "story_v_out_410082.awb")

						arg_293_1:RecordAudio("410082071", var_296_6)
						arg_293_1:RecordAudio("410082071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410082", "410082071", "story_v_out_410082.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410082", "410082071", "story_v_out_410082.awb")
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
	Play410082072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410082072
		arg_297_1.duration_ = 3.03

		local var_297_0 = {
			zh = 2.7,
			ja = 3.033
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
				arg_297_0:Play410082073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1056 = arg_297_1.actors_["1056"].transform.localPosition
				arg_297_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1056", 3)

				for iter_300_0 = 0, arg_297_1.actors_["1056"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["1056"].transform:GetChild(iter_300_0)

					if var_300_0.name == "split_3" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_300_2 = arg_297_1.actors_["1056"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1056 == nil then
				arg_297_1.var_.actorSpriteComps1056 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps1056 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								iter_300_2.color = Color.New(Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_2.color.r, 1, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_2.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1056 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_300_4 then
						iter_300_4.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps1056 = nil
			end

			local var_300_5 = arg_297_1.actors_["1060"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1060 = var_300_5.localPosition
				var_300_5.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1060", 7)

				for iter_300_5 = 0, var_300_5.childCount - 1 do
					local var_300_6 = var_300_5:GetChild(iter_300_5)

					if var_300_6.name == "" or not string.find(var_300_6.name, "split") then
						var_300_6.gameObject:SetActive(true)
					else
						var_300_6.gameObject:SetActive(false)
					end
				end
			end

			local var_300_7 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				var_300_5.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_297_1.time_ - 0) / var_300_7)
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				var_300_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_300_8 = arg_297_1.actors_["1012"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1012 = var_300_8.localPosition
				var_300_8.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1012", 7)

				for iter_300_6 = 0, var_300_8.childCount - 1 do
					local var_300_9 = var_300_8:GetChild(iter_300_6)

					if var_300_9.name == "" or not string.find(var_300_9.name, "split") then
						var_300_9.gameObject:SetActive(true)
					else
						var_300_9.gameObject:SetActive(false)
					end
				end
			end

			local var_300_10 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_10 then
				var_300_8.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_297_1.time_ - 0) / var_300_10)
			end

			if arg_297_1.time_ >= 0 + var_300_10 and arg_297_1.time_ < 0 + var_300_10 + arg_300_0 then
				var_300_8.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_300_11 = 0
			local var_300_12 = 0.15

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_13 = arg_297_1:GetWordFromCfg(410082072)
				local var_300_14 = arg_297_1:FormatText(var_300_13.content)

				arg_297_1.text_.text = var_300_14

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_16 = 6 <= 0 and var_300_12 or var_300_12 * (utf8.len(var_300_14) / 6)

				if (6 <= 0 and var_300_12 or var_300_12 * (utf8.len(var_300_14) / 6)) > 0 and var_300_12 < var_300_16 then
					arg_297_1.talkMaxDuration = var_300_16

					if var_300_16 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_16 + var_300_11
					end
				end

				arg_297_1.text_.text = var_300_14
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082072", "story_v_out_410082.awb") ~= 0 then
					local var_300_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082072", "story_v_out_410082.awb") / 1000

					if var_300_17 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_17 + var_300_11
					end

					if var_300_13.prefab_name ~= "" and arg_297_1.actors_[var_300_13.prefab_name] ~= nil then
						local var_300_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_13.prefab_name].transform, "story_v_out_410082", "410082072", "story_v_out_410082.awb")

						arg_297_1:RecordAudio("410082072", var_300_18)
						arg_297_1:RecordAudio("410082072", var_300_18)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410082", "410082072", "story_v_out_410082.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410082", "410082072", "story_v_out_410082.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_19 = math.max(var_300_12, arg_297_1.talkMaxDuration)

			if var_300_11 <= arg_297_1.time_ and arg_297_1.time_ < var_300_11 + var_300_19 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_11) / var_300_19

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_11 + var_300_19 and arg_297_1.time_ < var_300_11 + var_300_19 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410082073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410082074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1056"]) and arg_301_1.var_.actorSpriteComps1056 == nil then
				arg_301_1.var_.actorSpriteComps1056 = arg_301_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1056"]) then
				if arg_301_1.var_.actorSpriteComps1056 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1056"]) and arg_301_1.var_.actorSpriteComps1056 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1056 = nil
			end

			local var_304_2 = 0
			local var_304_3 = 0.55

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_4 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(410082073).content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_6 = 22 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 22)

				if (22 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_4) / 22)) > 0 and var_304_3 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_7 and arg_301_1.time_ < var_304_2 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play410082074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410082074
		arg_305_1.duration_ = 12.6

		local var_305_0 = {
			zh = 12.6,
			ja = 11.1
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
				arg_305_0:Play410082075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1012"]) and arg_305_1.var_.actorSpriteComps1012 == nil then
				arg_305_1.var_.actorSpriteComps1012 = arg_305_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1012"]) then
				if arg_305_1.var_.actorSpriteComps1012 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								iter_308_1.color = Color.New(Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_0), Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_0), (Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_0)))
							else
								local var_308_1 = Mathf.Lerp(iter_308_1.color.r, 1, (arg_305_1.time_ - 0) / var_308_0)

								iter_308_1.color = Color.New(var_308_1, var_308_1, var_308_1)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1012"]) and arg_305_1.var_.actorSpriteComps1012 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1012 = nil
			end

			local var_308_2 = arg_305_1.actors_["1060"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1060 = var_308_2.localPosition
				var_308_2.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1060", 2)

				for iter_308_4 = 0, var_308_2.childCount - 1 do
					local var_308_3 = var_308_2:GetChild(iter_308_4)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				var_308_2.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_305_1.time_ - 0) / var_308_4)
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				var_308_2.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_308_5 = arg_305_1.actors_["1012"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1012 = var_308_5.localPosition
				var_308_5.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1012", 4)

				for iter_308_5 = 0, var_308_5.childCount - 1 do
					local var_308_6 = var_308_5:GetChild(iter_308_5)

					if var_308_6.name == "" or not string.find(var_308_6.name, "split") then
						var_308_6.gameObject:SetActive(true)
					else
						var_308_6.gameObject:SetActive(false)
					end
				end
			end

			local var_308_7 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				var_308_5.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_305_1.time_ - 0) / var_308_7)
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				var_308_5.localPosition = Vector3.New(390, -465, 300)
			end

			local var_308_8 = arg_305_1.actors_["1056"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1056 = var_308_8.localPosition
				var_308_8.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1056", 7)

				for iter_308_6 = 0, var_308_8.childCount - 1 do
					local var_308_9 = var_308_8:GetChild(iter_308_6)

					if var_308_9.name == "" or not string.find(var_308_9.name, "split") then
						var_308_9.gameObject:SetActive(true)
					else
						var_308_9.gameObject:SetActive(false)
					end
				end
			end

			local var_308_10 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_10 then
				var_308_8.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_305_1.time_ - 0) / var_308_10)
			end

			if arg_305_1.time_ >= 0 + var_308_10 and arg_305_1.time_ < 0 + var_308_10 + arg_308_0 then
				var_308_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_308_11 = arg_305_1.actors_["1060"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_11) and arg_305_1.var_.actorSpriteComps1060 == nil then
				arg_305_1.var_.actorSpriteComps1060 = var_308_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_12 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_12 and not isNil(var_308_11) then
				if arg_305_1.var_.actorSpriteComps1060 then
					for iter_308_7, iter_308_8 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_308_8 then
							if arg_305_1.isInRecall_ then
								iter_308_8.color = Color.New(Mathf.Lerp(iter_308_8.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_12), Mathf.Lerp(iter_308_8.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_12), (Mathf.Lerp(iter_308_8.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_12)))
							else
								local var_308_13 = Mathf.Lerp(iter_308_8.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_12)

								iter_308_8.color = Color.New(var_308_13, var_308_13, var_308_13)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_12 and arg_305_1.time_ < 0 + var_308_12 + arg_308_0 and not isNil(var_308_11) and arg_305_1.var_.actorSpriteComps1060 then
				for iter_308_9, iter_308_10 in pairs(arg_305_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_308_10 then
						iter_308_10.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps1060 = nil
			end

			local var_308_14 = 0
			local var_308_15 = 1.575

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_16 = arg_305_1:GetWordFromCfg(410082074)
				local var_308_17 = arg_305_1:FormatText(var_308_16.content)

				arg_305_1.text_.text = var_308_17

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_19 = 63 <= 0 and var_308_15 or var_308_15 * (utf8.len(var_308_17) / 63)

				if (63 <= 0 and var_308_15 or var_308_15 * (utf8.len(var_308_17) / 63)) > 0 and var_308_15 < var_308_19 then
					arg_305_1.talkMaxDuration = var_308_19

					if var_308_19 + var_308_14 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_14
					end
				end

				arg_305_1.text_.text = var_308_17
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082074", "story_v_out_410082.awb") ~= 0 then
					local var_308_20 = manager.audio:GetVoiceLength("story_v_out_410082", "410082074", "story_v_out_410082.awb") / 1000

					if var_308_20 + var_308_14 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_20 + var_308_14
					end

					if var_308_16.prefab_name ~= "" and arg_305_1.actors_[var_308_16.prefab_name] ~= nil then
						local var_308_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_16.prefab_name].transform, "story_v_out_410082", "410082074", "story_v_out_410082.awb")

						arg_305_1:RecordAudio("410082074", var_308_21)
						arg_305_1:RecordAudio("410082074", var_308_21)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410082", "410082074", "story_v_out_410082.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410082", "410082074", "story_v_out_410082.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = math.max(var_308_15, arg_305_1.talkMaxDuration)

			if var_308_14 <= arg_305_1.time_ and arg_305_1.time_ < var_308_14 + var_308_22 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_14) / var_308_22

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_14 + var_308_22 and arg_305_1.time_ < var_308_14 + var_308_22 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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

		arg_305_1:InitPlayNodeList()
	end,
	Play410082075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410082075
		arg_309_1.duration_ = 6.7

		local var_309_0 = {
			zh = 6.7,
			ja = 6.533
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play410082076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.725

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(410082075)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 29 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 29)

				if (29 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 29)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082075", "story_v_out_410082.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082075", "story_v_out_410082.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_410082", "410082075", "story_v_out_410082.awb")

						arg_309_1:RecordAudio("410082075", var_312_6)
						arg_309_1:RecordAudio("410082075", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410082", "410082075", "story_v_out_410082.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410082", "410082075", "story_v_out_410082.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play410082076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410082076
		arg_313_1.duration_ = 4.13

		local var_313_0 = {
			zh = 1.866,
			ja = 4.133
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
				arg_313_0:Play410082077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1056"]) and arg_313_1.var_.actorSpriteComps1056 == nil then
				arg_313_1.var_.actorSpriteComps1056 = arg_313_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1056"]) then
				if arg_313_1.var_.actorSpriteComps1056 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1056"]) and arg_313_1.var_.actorSpriteComps1056 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps1056 = nil
			end

			local var_316_2 = arg_313_1.actors_["1012"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1012 == nil then
				arg_313_1.var_.actorSpriteComps1012 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps1012 then
					for iter_316_4, iter_316_5 in pairs(arg_313_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_316_5 then
							if arg_313_1.isInRecall_ then
								iter_316_5.color = Color.New(Mathf.Lerp(iter_316_5.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_3), Mathf.Lerp(iter_316_5.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_3), (Mathf.Lerp(iter_316_5.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_3)))
							else
								local var_316_4 = Mathf.Lerp(iter_316_5.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_3)

								iter_316_5.color = Color.New(var_316_4, var_316_4, var_316_4)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps1012 then
				for iter_316_6, iter_316_7 in pairs(arg_313_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_316_7 then
						iter_316_7.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1012 = nil
			end

			local var_316_5 = arg_313_1.actors_["1060"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1060 = var_316_5.localPosition
				var_316_5.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1060", 7)

				for iter_316_8 = 0, var_316_5.childCount - 1 do
					local var_316_6 = var_316_5:GetChild(iter_316_8)

					if var_316_6.name == "" or not string.find(var_316_6.name, "split") then
						var_316_6.gameObject:SetActive(true)
					else
						var_316_6.gameObject:SetActive(false)
					end
				end
			end

			local var_316_7 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				var_316_5.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_313_1.time_ - 0) / var_316_7)
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				var_316_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_316_8 = arg_313_1.actors_["1012"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1012 = var_316_8.localPosition
				var_316_8.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1012", 7)

				for iter_316_9 = 0, var_316_8.childCount - 1 do
					local var_316_9 = var_316_8:GetChild(iter_316_9)

					if var_316_9.name == "" or not string.find(var_316_9.name, "split") then
						var_316_9.gameObject:SetActive(true)
					else
						var_316_9.gameObject:SetActive(false)
					end
				end
			end

			local var_316_10 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_10 then
				var_316_8.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_313_1.time_ - 0) / var_316_10)
			end

			if arg_313_1.time_ >= 0 + var_316_10 and arg_313_1.time_ < 0 + var_316_10 + arg_316_0 then
				var_316_8.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_316_11 = arg_313_1.actors_["1056"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1056 = var_316_11.localPosition
				var_316_11.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1056", 3)

				for iter_316_10 = 0, var_316_11.childCount - 1 do
					local var_316_12 = var_316_11:GetChild(iter_316_10)

					if var_316_12.name == "split_3" or not string.find(var_316_12.name, "split") then
						var_316_12.gameObject:SetActive(true)
					else
						var_316_12.gameObject:SetActive(false)
					end
				end
			end

			local var_316_13 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_13 then
				var_316_11.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_313_1.time_ - 0) / var_316_13)
			end

			if arg_313_1.time_ >= 0 + var_316_13 and arg_313_1.time_ < 0 + var_316_13 + arg_316_0 then
				var_316_11.localPosition = Vector3.New(0, -350, -180)
			end

			local var_316_14 = arg_313_1.actors_["1060"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_14) and arg_313_1.var_.actorSpriteComps1060 == nil then
				arg_313_1.var_.actorSpriteComps1060 = var_316_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_15 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_15 and not isNil(var_316_14) then
				if arg_313_1.var_.actorSpriteComps1060 then
					for iter_316_11, iter_316_12 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_316_12 then
							if arg_313_1.isInRecall_ then
								iter_316_12.color = Color.New(Mathf.Lerp(iter_316_12.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_15), Mathf.Lerp(iter_316_12.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_15), (Mathf.Lerp(iter_316_12.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_15)))
							else
								local var_316_16 = Mathf.Lerp(iter_316_12.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_15)

								iter_316_12.color = Color.New(var_316_16, var_316_16, var_316_16)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_15 and arg_313_1.time_ < 0 + var_316_15 + arg_316_0 and not isNil(var_316_14) and arg_313_1.var_.actorSpriteComps1060 then
				for iter_316_13, iter_316_14 in pairs(arg_313_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_316_14 then
						iter_316_14.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1060 = nil
			end

			local var_316_17 = 0
			local var_316_18 = 0.25

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_17 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_19 = arg_313_1:GetWordFromCfg(410082076)
				local var_316_20 = arg_313_1:FormatText(var_316_19.content)

				arg_313_1.text_.text = var_316_20

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_22 = 10 <= 0 and var_316_18 or var_316_18 * (utf8.len(var_316_20) / 10)

				if (10 <= 0 and var_316_18 or var_316_18 * (utf8.len(var_316_20) / 10)) > 0 and var_316_18 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_17 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_17
					end
				end

				arg_313_1.text_.text = var_316_20
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082076", "story_v_out_410082.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082076", "story_v_out_410082.awb") / 1000

					if var_316_23 + var_316_17 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_17
					end

					if var_316_19.prefab_name ~= "" and arg_313_1.actors_[var_316_19.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_19.prefab_name].transform, "story_v_out_410082", "410082076", "story_v_out_410082.awb")

						arg_313_1:RecordAudio("410082076", var_316_24)
						arg_313_1:RecordAudio("410082076", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410082", "410082076", "story_v_out_410082.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410082", "410082076", "story_v_out_410082.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_18, arg_313_1.talkMaxDuration)

			if var_316_17 <= arg_313_1.time_ and arg_313_1.time_ < var_316_17 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_17) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_17 + var_316_25 and arg_313_1.time_ < var_316_17 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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

		arg_313_1:InitPlayNodeList()
	end,
	Play410082077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410082077
		arg_317_1.duration_ = 8.4

		local var_317_0 = {
			zh = 8.4,
			ja = 6.166
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play410082078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1012 = arg_317_1.actors_["1012"].transform.localPosition
				arg_317_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1012", 4)

				for iter_320_0 = 0, arg_317_1.actors_["1012"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["1012"].transform:GetChild(iter_320_0)

					if var_320_0.name == "split_1" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_320_2 = arg_317_1.actors_["1012"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps1012 == nil then
				arg_317_1.var_.actorSpriteComps1012 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps1012 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								iter_320_2.color = Color.New(Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_2.color.r, 1, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_2.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps1012 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_320_4 then
						iter_320_4.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1012 = nil
			end

			local var_320_5 = arg_317_1.actors_["1060"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps1060 == nil then
				arg_317_1.var_.actorSpriteComps1060 = var_320_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_6 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.actorSpriteComps1060 then
					for iter_320_5, iter_320_6 in pairs(arg_317_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_320_6 then
							if arg_317_1.isInRecall_ then
								iter_320_6.color = Color.New(Mathf.Lerp(iter_320_6.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_6), Mathf.Lerp(iter_320_6.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_6), (Mathf.Lerp(iter_320_6.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_6)))
							else
								local var_320_7 = Mathf.Lerp(iter_320_6.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_6)

								iter_320_6.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps1060 then
				for iter_320_7, iter_320_8 in pairs(arg_317_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_320_8 then
						iter_320_8.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps1060 = nil
			end

			local var_320_8 = arg_317_1.actors_["1056"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1056 = var_320_8.localPosition
				var_320_8.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1056", 7)

				for iter_320_9 = 0, var_320_8.childCount - 1 do
					local var_320_9 = var_320_8:GetChild(iter_320_9)

					if var_320_9.name == "" or not string.find(var_320_9.name, "split") then
						var_320_9.gameObject:SetActive(true)
					else
						var_320_9.gameObject:SetActive(false)
					end
				end
			end

			local var_320_10 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_10 then
				var_320_8.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_317_1.time_ - 0) / var_320_10)
			end

			if arg_317_1.time_ >= 0 + var_320_10 and arg_317_1.time_ < 0 + var_320_10 + arg_320_0 then
				var_320_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_320_11 = arg_317_1.actors_["1060"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1060 = var_320_11.localPosition
				var_320_11.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1060", 2)

				for iter_320_10 = 0, var_320_11.childCount - 1 do
					local var_320_12 = var_320_11:GetChild(iter_320_10)

					if var_320_12.name == "split_1" or not string.find(var_320_12.name, "split") then
						var_320_12.gameObject:SetActive(true)
					else
						var_320_12.gameObject:SetActive(false)
					end
				end
			end

			local var_320_13 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_13 then
				var_320_11.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_317_1.time_ - 0) / var_320_13)
			end

			if arg_317_1.time_ >= 0 + var_320_13 and arg_317_1.time_ < 0 + var_320_13 + arg_320_0 then
				var_320_11.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_320_14 = 0
			local var_320_15 = 1.05

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_16 = arg_317_1:GetWordFromCfg(410082077)
				local var_320_17 = arg_317_1:FormatText(var_320_16.content)

				arg_317_1.text_.text = var_320_17

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_19 = 42 <= 0 and var_320_15 or var_320_15 * (utf8.len(var_320_17) / 42)

				if (42 <= 0 and var_320_15 or var_320_15 * (utf8.len(var_320_17) / 42)) > 0 and var_320_15 < var_320_19 then
					arg_317_1.talkMaxDuration = var_320_19

					if var_320_19 + var_320_14 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_14
					end
				end

				arg_317_1.text_.text = var_320_17
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082077", "story_v_out_410082.awb") ~= 0 then
					local var_320_20 = manager.audio:GetVoiceLength("story_v_out_410082", "410082077", "story_v_out_410082.awb") / 1000

					if var_320_20 + var_320_14 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_20 + var_320_14
					end

					if var_320_16.prefab_name ~= "" and arg_317_1.actors_[var_320_16.prefab_name] ~= nil then
						local var_320_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_16.prefab_name].transform, "story_v_out_410082", "410082077", "story_v_out_410082.awb")

						arg_317_1:RecordAudio("410082077", var_320_21)
						arg_317_1:RecordAudio("410082077", var_320_21)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410082", "410082077", "story_v_out_410082.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410082", "410082077", "story_v_out_410082.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_22 = math.max(var_320_15, arg_317_1.talkMaxDuration)

			if var_320_14 <= arg_317_1.time_ and arg_317_1.time_ < var_320_14 + var_320_22 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_14) / var_320_22

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_14 + var_320_22 and arg_317_1.time_ < var_320_14 + var_320_22 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play410082078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410082078
		arg_321_1.duration_ = 10.9

		local var_321_0 = {
			zh = 4.233,
			ja = 10.9
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
				arg_321_0:Play410082079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.65

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(410082078)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 26 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 26)

				if (26 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 26)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082078", "story_v_out_410082.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082078", "story_v_out_410082.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_410082", "410082078", "story_v_out_410082.awb")

						arg_321_1:RecordAudio("410082078", var_324_6)
						arg_321_1:RecordAudio("410082078", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410082", "410082078", "story_v_out_410082.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410082", "410082078", "story_v_out_410082.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play410082079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410082079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410082080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1060 = arg_325_1.actors_["1060"].transform.localPosition
				arg_325_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1060", 7)

				for iter_328_0 = 0, arg_325_1.actors_["1060"].transform.childCount - 1 do
					local var_328_0 = arg_325_1.actors_["1060"].transform:GetChild(iter_328_0)

					if var_328_0.name == "" or not string.find(var_328_0.name, "split") then
						var_328_0.gameObject:SetActive(true)
					else
						var_328_0.gameObject:SetActive(false)
					end
				end
			end

			local var_328_1 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_1 then
				arg_325_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_325_1.time_ - 0) / var_328_1)
			end

			if arg_325_1.time_ >= 0 + var_328_1 and arg_325_1.time_ < 0 + var_328_1 + arg_328_0 then
				arg_325_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_328_2 = arg_325_1.actors_["1056"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1056 = var_328_2.localPosition
				var_328_2.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1056", 7)

				for iter_328_1 = 0, var_328_2.childCount - 1 do
					local var_328_3 = var_328_2:GetChild(iter_328_1)

					if var_328_3.name == "" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_2.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_325_1.time_ - 0) / var_328_4)
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_328_5 = arg_325_1.actors_["1012"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1012 = var_328_5.localPosition
				var_328_5.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1012", 7)

				for iter_328_2 = 0, var_328_5.childCount - 1 do
					local var_328_6 = var_328_5:GetChild(iter_328_2)

					if var_328_6.name == "" or not string.find(var_328_6.name, "split") then
						var_328_6.gameObject:SetActive(true)
					else
						var_328_6.gameObject:SetActive(false)
					end
				end
			end

			local var_328_7 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				var_328_5.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_325_1.time_ - 0) / var_328_7)
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				var_328_5.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_328_8 = 0
			local var_328_9 = 0.975

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_10 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(410082079).content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_12 = 39 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_10) / 39)

				if (39 <= 0 and var_328_9 or var_328_9 * (utf8.len(var_328_10) / 39)) > 0 and var_328_9 < var_328_12 then
					arg_325_1.talkMaxDuration = var_328_12

					if var_328_12 + var_328_8 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_8
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_9, arg_325_1.talkMaxDuration)

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_8) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_8 + var_328_13 and arg_325_1.time_ < var_328_8 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play410082080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410082080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play410082081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.725

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(410082080).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 69 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 69)

				if (69 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 69)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play410082081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410082081
		arg_333_1.duration_ = 9.1

		local var_333_0 = {
			zh = 4.8,
			ja = 9.1
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play410082082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1012 = arg_333_1.actors_["1012"].transform.localPosition
				arg_333_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1012", 4)

				for iter_336_0 = 0, arg_333_1.actors_["1012"].transform.childCount - 1 do
					local var_336_0 = arg_333_1.actors_["1012"].transform:GetChild(iter_336_0)

					if var_336_0.name == "split_3" or not string.find(var_336_0.name, "split") then
						var_336_0.gameObject:SetActive(true)
					else
						var_336_0.gameObject:SetActive(false)
					end
				end
			end

			local var_336_1 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 then
				arg_333_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_333_1.time_ - 0) / var_336_1)
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 then
				arg_333_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_336_2 = arg_333_1.actors_["1012"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps1012 == nil then
				arg_333_1.var_.actorSpriteComps1012 = var_336_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_3 = 0.034

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.actorSpriteComps1012 then
					for iter_336_1, iter_336_2 in pairs(arg_333_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_336_2 then
							if arg_333_1.isInRecall_ then
								iter_336_2.color = Color.New(Mathf.Lerp(iter_336_2.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_3), Mathf.Lerp(iter_336_2.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_3), (Mathf.Lerp(iter_336_2.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_3)))
							else
								local var_336_4 = Mathf.Lerp(iter_336_2.color.r, 1, (arg_333_1.time_ - 0) / var_336_3)

								iter_336_2.color = Color.New(var_336_4, var_336_4, var_336_4)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps1012 then
				for iter_336_3, iter_336_4 in pairs(arg_333_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_336_4 then
						iter_336_4.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps1012 = nil
			end

			local var_336_5 = arg_333_1.actors_["1060"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1060 = var_336_5.localPosition
				var_336_5.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1060", 2)

				for iter_336_5 = 0, var_336_5.childCount - 1 do
					local var_336_6 = var_336_5:GetChild(iter_336_5)

					if var_336_6.name == "" or not string.find(var_336_6.name, "split") then
						var_336_6.gameObject:SetActive(true)
					else
						var_336_6.gameObject:SetActive(false)
					end
				end
			end

			local var_336_7 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				var_336_5.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_333_1.time_ - 0) / var_336_7)
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				var_336_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_336_8 = arg_333_1.actors_["1060"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps1060 == nil then
				arg_333_1.var_.actorSpriteComps1060 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_9 = 0.034

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_9 and not isNil(var_336_8) then
				if arg_333_1.var_.actorSpriteComps1060 then
					for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_336_7 then
							if arg_333_1.isInRecall_ then
								iter_336_7.color = Color.New(Mathf.Lerp(iter_336_7.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_9), Mathf.Lerp(iter_336_7.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_9), (Mathf.Lerp(iter_336_7.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_9)))
							else
								local var_336_10 = Mathf.Lerp(iter_336_7.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_9)

								iter_336_7.color = Color.New(var_336_10, var_336_10, var_336_10)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_9 and arg_333_1.time_ < 0 + var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps1060 then
				for iter_336_8, iter_336_9 in pairs(arg_333_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_336_9 then
						iter_336_9.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps1060 = nil
			end

			local var_336_11 = 0
			local var_336_12 = 0.45

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_13 = arg_333_1:GetWordFromCfg(410082081)
				local var_336_14 = arg_333_1:FormatText(var_336_13.content)

				arg_333_1.text_.text = var_336_14

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_16 = 18 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_14) / 18)

				if (18 <= 0 and var_336_12 or var_336_12 * (utf8.len(var_336_14) / 18)) > 0 and var_336_12 < var_336_16 then
					arg_333_1.talkMaxDuration = var_336_16

					if var_336_16 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_11
					end
				end

				arg_333_1.text_.text = var_336_14
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082081", "story_v_out_410082.awb") ~= 0 then
					local var_336_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082081", "story_v_out_410082.awb") / 1000

					if var_336_17 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_17 + var_336_11
					end

					if var_336_13.prefab_name ~= "" and arg_333_1.actors_[var_336_13.prefab_name] ~= nil then
						local var_336_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_13.prefab_name].transform, "story_v_out_410082", "410082081", "story_v_out_410082.awb")

						arg_333_1:RecordAudio("410082081", var_336_18)
						arg_333_1:RecordAudio("410082081", var_336_18)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410082", "410082081", "story_v_out_410082.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410082", "410082081", "story_v_out_410082.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_19 = math.max(var_336_12, arg_333_1.talkMaxDuration)

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_19 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_11) / var_336_19

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_11 + var_336_19 and arg_333_1.time_ < var_336_11 + var_336_19 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play410082082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410082082
		arg_337_1.duration_ = 8.6

		local var_337_0 = {
			zh = 5.666,
			ja = 8.6
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
				arg_337_0:Play410082083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1060 = arg_337_1.actors_["1060"].transform.localPosition
				arg_337_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1060", 2)

				for iter_340_0 = 0, arg_337_1.actors_["1060"].transform.childCount - 1 do
					local var_340_0 = arg_337_1.actors_["1060"].transform:GetChild(iter_340_0)

					if var_340_0.name == "" or not string.find(var_340_0.name, "split") then
						var_340_0.gameObject:SetActive(true)
					else
						var_340_0.gameObject:SetActive(false)
					end
				end
			end

			local var_340_1 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				arg_337_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_337_1.time_ - 0) / var_340_1)
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 then
				arg_337_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_340_2 = arg_337_1.actors_["1060"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1060 == nil then
				arg_337_1.var_.actorSpriteComps1060 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 0.034

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps1060 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								iter_340_2.color = Color.New(Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_2.color.r, 1, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_2.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps1060 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_340_4 then
						iter_340_4.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps1060 = nil
			end

			local var_340_5 = arg_337_1.actors_["1012"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps1012 == nil then
				arg_337_1.var_.actorSpriteComps1012 = var_340_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_6 = 0.034

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_6 and not isNil(var_340_5) then
				if arg_337_1.var_.actorSpriteComps1012 then
					for iter_340_5, iter_340_6 in pairs(arg_337_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_340_6 then
							if arg_337_1.isInRecall_ then
								iter_340_6.color = Color.New(Mathf.Lerp(iter_340_6.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_6), Mathf.Lerp(iter_340_6.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_6), (Mathf.Lerp(iter_340_6.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_6)))
							else
								local var_340_7 = Mathf.Lerp(iter_340_6.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_6)

								iter_340_6.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_6 and arg_337_1.time_ < 0 + var_340_6 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps1012 then
				for iter_340_7, iter_340_8 in pairs(arg_337_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_340_8 then
						iter_340_8.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps1012 = nil
			end

			local var_340_8 = 0
			local var_340_9 = 0.7

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_10 = arg_337_1:GetWordFromCfg(410082082)
				local var_340_11 = arg_337_1:FormatText(var_340_10.content)

				arg_337_1.text_.text = var_340_11

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_13 = 28 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 28)

				if (28 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 28)) > 0 and var_340_9 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_8
					end
				end

				arg_337_1.text_.text = var_340_11
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082082", "story_v_out_410082.awb") ~= 0 then
					local var_340_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082082", "story_v_out_410082.awb") / 1000

					if var_340_14 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_8
					end

					if var_340_10.prefab_name ~= "" and arg_337_1.actors_[var_340_10.prefab_name] ~= nil then
						local var_340_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_10.prefab_name].transform, "story_v_out_410082", "410082082", "story_v_out_410082.awb")

						arg_337_1:RecordAudio("410082082", var_340_15)
						arg_337_1:RecordAudio("410082082", var_340_15)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_410082", "410082082", "story_v_out_410082.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_410082", "410082082", "story_v_out_410082.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_9, arg_337_1.talkMaxDuration)

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_8) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_8 + var_340_16 and arg_337_1.time_ < var_340_8 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play410082083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410082083
		arg_341_1.duration_ = 4.07

		local var_341_0 = {
			zh = 4.066,
			ja = 3.133
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play410082084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1012 = arg_341_1.actors_["1012"].transform.localPosition
				arg_341_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1012", 4)

				for iter_344_0 = 0, arg_341_1.actors_["1012"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["1012"].transform:GetChild(iter_344_0)

					if var_344_0.name == "" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_344_2 = arg_341_1.actors_["1012"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1012 == nil then
				arg_341_1.var_.actorSpriteComps1012 = var_344_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_3 = 0.034

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.actorSpriteComps1012 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								iter_344_2.color = Color.New(Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_3), Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_3), (Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_3)))
							else
								local var_344_4 = Mathf.Lerp(iter_344_2.color.r, 1, (arg_341_1.time_ - 0) / var_344_3)

								iter_344_2.color = Color.New(var_344_4, var_344_4, var_344_4)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps1012 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_344_4 then
						iter_344_4.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps1012 = nil
			end

			local var_344_5 = arg_341_1.actors_["1060"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps1060 == nil then
				arg_341_1.var_.actorSpriteComps1060 = var_344_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_6 = 0.034

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_6 and not isNil(var_344_5) then
				if arg_341_1.var_.actorSpriteComps1060 then
					for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_344_6 then
							if arg_341_1.isInRecall_ then
								iter_344_6.color = Color.New(Mathf.Lerp(iter_344_6.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_6), Mathf.Lerp(iter_344_6.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_6), (Mathf.Lerp(iter_344_6.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_6)))
							else
								local var_344_7 = Mathf.Lerp(iter_344_6.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_6)

								iter_344_6.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_6 and arg_341_1.time_ < 0 + var_344_6 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps1060 then
				for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_344_8 then
						iter_344_8.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps1060 = nil
			end

			local var_344_8 = 0
			local var_344_9 = 0.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(410082083)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 12 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 12)

				if (12 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 12)) > 0 and var_344_9 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082083", "story_v_out_410082.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082083", "story_v_out_410082.awb") / 1000

					if var_344_14 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_8
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_410082", "410082083", "story_v_out_410082.awb")

						arg_341_1:RecordAudio("410082083", var_344_15)
						arg_341_1:RecordAudio("410082083", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_410082", "410082083", "story_v_out_410082.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_410082", "410082083", "story_v_out_410082.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_8) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_8 + var_344_16 and arg_341_1.time_ < var_344_8 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play410082084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410082084
		arg_345_1.duration_ = 4.43

		local var_345_0 = {
			zh = 1.6,
			ja = 4.433
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
				arg_345_0:Play410082085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1060 = arg_345_1.actors_["1060"].transform.localPosition
				arg_345_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("1060", 2)

				for iter_348_0 = 0, arg_345_1.actors_["1060"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["1060"].transform:GetChild(iter_348_0)

					if var_348_0.name == "" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_348_2 = arg_345_1.actors_["1060"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1060 == nil then
				arg_345_1.var_.actorSpriteComps1060 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps1060 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_348_2 then
							if arg_345_1.isInRecall_ then
								iter_348_2.color = Color.New(Mathf.Lerp(iter_348_2.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_3), Mathf.Lerp(iter_348_2.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_3), (Mathf.Lerp(iter_348_2.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_3)))
							else
								local var_348_4 = Mathf.Lerp(iter_348_2.color.r, 1, (arg_345_1.time_ - 0) / var_348_3)

								iter_348_2.color = Color.New(var_348_4, var_348_4, var_348_4)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1060 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_348_4 then
						iter_348_4.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps1060 = nil
			end

			local var_348_5 = arg_345_1.actors_["1012"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps1012 == nil then
				arg_345_1.var_.actorSpriteComps1012 = var_348_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_6 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 and not isNil(var_348_5) then
				if arg_345_1.var_.actorSpriteComps1012 then
					for iter_348_5, iter_348_6 in pairs(arg_345_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_348_6 then
							if arg_345_1.isInRecall_ then
								iter_348_6.color = Color.New(Mathf.Lerp(iter_348_6.color.r, arg_345_1.hightColor2.r, (arg_345_1.time_ - 0) / var_348_6), Mathf.Lerp(iter_348_6.color.g, arg_345_1.hightColor2.g, (arg_345_1.time_ - 0) / var_348_6), (Mathf.Lerp(iter_348_6.color.b, arg_345_1.hightColor2.b, (arg_345_1.time_ - 0) / var_348_6)))
							else
								local var_348_7 = Mathf.Lerp(iter_348_6.color.r, 0.5, (arg_345_1.time_ - 0) / var_348_6)

								iter_348_6.color = Color.New(var_348_7, var_348_7, var_348_7)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps1012 then
				for iter_348_7, iter_348_8 in pairs(arg_345_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_348_8 then
						iter_348_8.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_345_1.var_.actorSpriteComps1012 = nil
			end

			local var_348_8 = 0
			local var_348_9 = 0.25

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_10 = arg_345_1:GetWordFromCfg(410082084)
				local var_348_11 = arg_345_1:FormatText(var_348_10.content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 10 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 10)

				if (10 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 10)) > 0 and var_348_9 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082084", "story_v_out_410082.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082084", "story_v_out_410082.awb") / 1000

					if var_348_14 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_8
					end

					if var_348_10.prefab_name ~= "" and arg_345_1.actors_[var_348_10.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_10.prefab_name].transform, "story_v_out_410082", "410082084", "story_v_out_410082.awb")

						arg_345_1:RecordAudio("410082084", var_348_15)
						arg_345_1:RecordAudio("410082084", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_410082", "410082084", "story_v_out_410082.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_410082", "410082084", "story_v_out_410082.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_16 and arg_345_1.time_ < var_348_8 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play410082085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410082085
		arg_349_1.duration_ = 12.37

		local var_349_0 = {
			zh = 8.1,
			ja = 12.366
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
				arg_349_0:Play410082086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1012 = arg_349_1.actors_["1012"].transform.localPosition
				arg_349_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("1012", 4)

				for iter_352_0 = 0, arg_349_1.actors_["1012"].transform.childCount - 1 do
					local var_352_0 = arg_349_1.actors_["1012"].transform:GetChild(iter_352_0)

					if var_352_0.name == "" or not string.find(var_352_0.name, "split") then
						var_352_0.gameObject:SetActive(true)
					else
						var_352_0.gameObject:SetActive(false)
					end
				end
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				arg_349_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_349_1.time_ - 0) / var_352_1)
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				arg_349_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_352_2 = arg_349_1.actors_["1012"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1012 == nil then
				arg_349_1.var_.actorSpriteComps1012 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps1012 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								iter_352_2.color = Color.New(Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor1.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor1.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor1.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_2.color.r, 1, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_2.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1012 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_352_4 then
						iter_352_4.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_349_1.var_.actorSpriteComps1012 = nil
			end

			local var_352_5 = arg_349_1.actors_["1060"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.actorSpriteComps1060 == nil then
				arg_349_1.var_.actorSpriteComps1060 = var_352_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_6 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.actorSpriteComps1060 then
					for iter_352_5, iter_352_6 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_352_6 then
							if arg_349_1.isInRecall_ then
								iter_352_6.color = Color.New(Mathf.Lerp(iter_352_6.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_6), Mathf.Lerp(iter_352_6.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_6), (Mathf.Lerp(iter_352_6.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_6)))
							else
								local var_352_7 = Mathf.Lerp(iter_352_6.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_6)

								iter_352_6.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.actorSpriteComps1060 then
				for iter_352_7, iter_352_8 in pairs(arg_349_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_352_8 then
						iter_352_8.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps1060 = nil
			end

			local var_352_8 = 0
			local var_352_9 = 0.9

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(410082085)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_13 = 36 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 36)

				if (36 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 36)) > 0 and var_352_9 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082085", "story_v_out_410082.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082085", "story_v_out_410082.awb") / 1000

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end

					if var_352_10.prefab_name ~= "" and arg_349_1.actors_[var_352_10.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_10.prefab_name].transform, "story_v_out_410082", "410082085", "story_v_out_410082.awb")

						arg_349_1:RecordAudio("410082085", var_352_15)
						arg_349_1:RecordAudio("410082085", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_410082", "410082085", "story_v_out_410082.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_410082", "410082085", "story_v_out_410082.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_16 and arg_349_1.time_ < var_352_8 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play410082086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410082086
		arg_353_1.duration_ = 7.17

		local var_353_0 = {
			zh = 2.833,
			ja = 7.166
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
				arg_353_0:Play410082087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1060 = arg_353_1.actors_["1060"].transform.localPosition
				arg_353_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1060", 2)

				for iter_356_0 = 0, arg_353_1.actors_["1060"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["1060"].transform:GetChild(iter_356_0)

					if var_356_0.name == "" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_356_2 = arg_353_1.actors_["1060"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1060 == nil then
				arg_353_1.var_.actorSpriteComps1060 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps1060 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								iter_356_2.color = Color.New(Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_2.color.r, 1, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_2.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1060 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_356_4 then
						iter_356_4.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps1060 = nil
			end

			local var_356_5 = arg_353_1.actors_["1012"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_5) and arg_353_1.var_.actorSpriteComps1012 == nil then
				arg_353_1.var_.actorSpriteComps1012 = var_356_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_6 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_6 and not isNil(var_356_5) then
				if arg_353_1.var_.actorSpriteComps1012 then
					for iter_356_5, iter_356_6 in pairs(arg_353_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_356_6 then
							if arg_353_1.isInRecall_ then
								iter_356_6.color = Color.New(Mathf.Lerp(iter_356_6.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_6), Mathf.Lerp(iter_356_6.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_6), (Mathf.Lerp(iter_356_6.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_6)))
							else
								local var_356_7 = Mathf.Lerp(iter_356_6.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_6)

								iter_356_6.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_6 and arg_353_1.time_ < 0 + var_356_6 + arg_356_0 and not isNil(var_356_5) and arg_353_1.var_.actorSpriteComps1012 then
				for iter_356_7, iter_356_8 in pairs(arg_353_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_356_8 then
						iter_356_8.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1012 = nil
			end

			local var_356_8 = 0
			local var_356_9 = 0.125

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(410082086)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 5 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 5)

				if (5 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 5)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082086", "story_v_out_410082.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082086", "story_v_out_410082.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_410082", "410082086", "story_v_out_410082.awb")

						arg_353_1:RecordAudio("410082086", var_356_15)
						arg_353_1:RecordAudio("410082086", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_410082", "410082086", "story_v_out_410082.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_410082", "410082086", "story_v_out_410082.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play410082087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 410082087
		arg_357_1.duration_ = 11.2

		local var_357_0 = {
			zh = 9.666,
			ja = 11.2
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play410082088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1012 = arg_357_1.actors_["1012"].transform.localPosition
				arg_357_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1012", 4)

				for iter_360_0 = 0, arg_357_1.actors_["1012"].transform.childCount - 1 do
					local var_360_0 = arg_357_1.actors_["1012"].transform:GetChild(iter_360_0)

					if var_360_0.name == "" or not string.find(var_360_0.name, "split") then
						var_360_0.gameObject:SetActive(true)
					else
						var_360_0.gameObject:SetActive(false)
					end
				end
			end

			local var_360_1 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_1 then
				arg_357_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_357_1.time_ - 0) / var_360_1)
			end

			if arg_357_1.time_ >= 0 + var_360_1 and arg_357_1.time_ < 0 + var_360_1 + arg_360_0 then
				arg_357_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_360_2 = arg_357_1.actors_["1012"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1012 == nil then
				arg_357_1.var_.actorSpriteComps1012 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 0.034

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps1012 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_360_2 then
							if arg_357_1.isInRecall_ then
								iter_360_2.color = Color.New(Mathf.Lerp(iter_360_2.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_2.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_2.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_2.color.r, 1, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_2.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1012 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_360_4 then
						iter_360_4.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1012 = nil
			end

			local var_360_5 = arg_357_1.actors_["1060"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_5) and arg_357_1.var_.actorSpriteComps1060 == nil then
				arg_357_1.var_.actorSpriteComps1060 = var_360_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_6 = 0.034

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_6 and not isNil(var_360_5) then
				if arg_357_1.var_.actorSpriteComps1060 then
					for iter_360_5, iter_360_6 in pairs(arg_357_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_360_6 then
							if arg_357_1.isInRecall_ then
								iter_360_6.color = Color.New(Mathf.Lerp(iter_360_6.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_6), Mathf.Lerp(iter_360_6.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_6), (Mathf.Lerp(iter_360_6.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_6)))
							else
								local var_360_7 = Mathf.Lerp(iter_360_6.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_6)

								iter_360_6.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_6 and arg_357_1.time_ < 0 + var_360_6 + arg_360_0 and not isNil(var_360_5) and arg_357_1.var_.actorSpriteComps1060 then
				for iter_360_7, iter_360_8 in pairs(arg_357_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_360_8 then
						iter_360_8.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps1060 = nil
			end

			local var_360_8 = 0
			local var_360_9 = 1.225

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(410082087)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 49 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 49)

				if (49 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 49)) > 0 and var_360_9 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082087", "story_v_out_410082.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082087", "story_v_out_410082.awb") / 1000

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end

					if var_360_10.prefab_name ~= "" and arg_357_1.actors_[var_360_10.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_10.prefab_name].transform, "story_v_out_410082", "410082087", "story_v_out_410082.awb")

						arg_357_1:RecordAudio("410082087", var_360_15)
						arg_357_1:RecordAudio("410082087", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_410082", "410082087", "story_v_out_410082.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_410082", "410082087", "story_v_out_410082.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play410082088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 410082088
		arg_361_1.duration_ = 9.53

		local var_361_0 = {
			zh = 4.666,
			ja = 9.533
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
				arg_361_0:Play410082089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.575

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(410082088)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 23 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 23)

				if (23 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 23)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082088", "story_v_out_410082.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082088", "story_v_out_410082.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_410082", "410082088", "story_v_out_410082.awb")

						arg_361_1:RecordAudio("410082088", var_364_6)
						arg_361_1:RecordAudio("410082088", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_410082", "410082088", "story_v_out_410082.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_410082", "410082088", "story_v_out_410082.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play410082089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 410082089
		arg_365_1.duration_ = 5.13

		local var_365_0 = {
			zh = 1.7,
			ja = 5.133
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
				arg_365_0:Play410082090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1060 = arg_365_1.actors_["1060"].transform.localPosition
				arg_365_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1060", 2)

				for iter_368_0 = 0, arg_365_1.actors_["1060"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["1060"].transform:GetChild(iter_368_0)

					if var_368_0.name == "" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_368_2 = arg_365_1.actors_["1060"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1060 == nil then
				arg_365_1.var_.actorSpriteComps1060 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps1060 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps1060 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_368_4 then
						iter_368_4.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps1060 = nil
			end

			local var_368_5 = arg_365_1.actors_["1012"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1012 == nil then
				arg_365_1.var_.actorSpriteComps1012 = var_368_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_6 = 0.034

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.actorSpriteComps1012 then
					for iter_368_5, iter_368_6 in pairs(arg_365_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps1012 then
				for iter_368_7, iter_368_8 in pairs(arg_365_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_368_8 then
						iter_368_8.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps1012 = nil
			end

			local var_368_8 = 0
			local var_368_9 = 0.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:GetWordFromCfg(410082089)
				local var_368_11 = arg_365_1:FormatText(var_368_10.content)

				arg_365_1.text_.text = var_368_11

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_13 = 10 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 10)

				if (10 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_11) / 10)) > 0 and var_368_9 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_11
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082089", "story_v_out_410082.awb") ~= 0 then
					local var_368_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082089", "story_v_out_410082.awb") / 1000

					if var_368_14 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_8
					end

					if var_368_10.prefab_name ~= "" and arg_365_1.actors_[var_368_10.prefab_name] ~= nil then
						local var_368_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_10.prefab_name].transform, "story_v_out_410082", "410082089", "story_v_out_410082.awb")

						arg_365_1:RecordAudio("410082089", var_368_15)
						arg_365_1:RecordAudio("410082089", var_368_15)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_410082", "410082089", "story_v_out_410082.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_410082", "410082089", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 410082090
		arg_369_1.duration_ = 6.83

		local var_369_0 = {
			zh = 2.833,
			ja = 6.833
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
				arg_369_0:Play410082091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1012 = arg_369_1.actors_["1012"].transform.localPosition
				arg_369_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1012", 4)

				for iter_372_0 = 0, arg_369_1.actors_["1012"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["1012"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_3" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_372_2 = arg_369_1.actors_["1012"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1012 == nil then
				arg_369_1.var_.actorSpriteComps1012 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.034

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps1012 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1012 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1012 = nil
			end

			local var_372_5 = arg_369_1.actors_["1060"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps1060 == nil then
				arg_369_1.var_.actorSpriteComps1060 = var_372_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.034

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.actorSpriteComps1060 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps1060 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_372_8 then
						iter_372_8.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps1060 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.4

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:GetWordFromCfg(410082090)
				local var_372_11 = arg_369_1:FormatText(var_372_10.content)

				arg_369_1.text_.text = var_372_11

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 16 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 16)

				if (16 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 16)) > 0 and var_372_9 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_11
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082090", "story_v_out_410082.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082090", "story_v_out_410082.awb") / 1000

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end

					if var_372_10.prefab_name ~= "" and arg_369_1.actors_[var_372_10.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_10.prefab_name].transform, "story_v_out_410082", "410082090", "story_v_out_410082.awb")

						arg_369_1:RecordAudio("410082090", var_372_15)
						arg_369_1:RecordAudio("410082090", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_410082", "410082090", "story_v_out_410082.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_410082", "410082090", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 410082091
		arg_373_1.duration_ = 5.93

		local var_373_0 = {
			zh = 2.733,
			ja = 5.933
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
				arg_373_0:Play410082092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1060 = arg_373_1.actors_["1060"].transform.localPosition
				arg_373_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1060", 2)

				for iter_376_0 = 0, arg_373_1.actors_["1060"].transform.childCount - 1 do
					local var_376_0 = arg_373_1.actors_["1060"].transform:GetChild(iter_376_0)

					if var_376_0.name == "split_3" or not string.find(var_376_0.name, "split") then
						var_376_0.gameObject:SetActive(true)
					else
						var_376_0.gameObject:SetActive(false)
					end
				end
			end

			local var_376_1 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				arg_373_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_373_1.time_ - 0) / var_376_1)
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 then
				arg_373_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_376_2 = arg_373_1.actors_["1060"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1060 == nil then
				arg_373_1.var_.actorSpriteComps1060 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.034

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps1060 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1060 then
				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_376_4 then
						iter_376_4.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps1060 = nil
			end

			local var_376_5 = arg_373_1.actors_["1012"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1012 == nil then
				arg_373_1.var_.actorSpriteComps1012 = var_376_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_6 = 0.034

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_6 and not isNil(var_376_5) then
				if arg_373_1.var_.actorSpriteComps1012 then
					for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_373_1.time_ >= 0 + var_376_6 and arg_373_1.time_ < 0 + var_376_6 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1012 then
				for iter_376_7, iter_376_8 in pairs(arg_373_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_376_8 then
						iter_376_8.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps1012 = nil
			end

			local var_376_8 = 0
			local var_376_9 = 0.35

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_10 = arg_373_1:GetWordFromCfg(410082091)
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

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082091", "story_v_out_410082.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082091", "story_v_out_410082.awb") / 1000

					if var_376_14 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_8
					end

					if var_376_10.prefab_name ~= "" and arg_373_1.actors_[var_376_10.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_10.prefab_name].transform, "story_v_out_410082", "410082091", "story_v_out_410082.awb")

						arg_373_1:RecordAudio("410082091", var_376_15)
						arg_373_1:RecordAudio("410082091", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_410082", "410082091", "story_v_out_410082.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_410082", "410082091", "story_v_out_410082.awb")
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
				actorName = "1060",
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
	Play410082092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 410082092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play410082093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1060 = arg_377_1.actors_["1060"].transform.localPosition
				arg_377_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1060", 7)

				for iter_380_0 = 0, arg_377_1.actors_["1060"].transform.childCount - 1 do
					local var_380_0 = arg_377_1.actors_["1060"].transform:GetChild(iter_380_0)

					if var_380_0.name == "" or not string.find(var_380_0.name, "split") then
						var_380_0.gameObject:SetActive(true)
					else
						var_380_0.gameObject:SetActive(false)
					end
				end
			end

			local var_380_1 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_1 then
				arg_377_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_377_1.time_ - 0) / var_380_1)
			end

			if arg_377_1.time_ >= 0 + var_380_1 and arg_377_1.time_ < 0 + var_380_1 + arg_380_0 then
				arg_377_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_380_2 = arg_377_1.actors_["1012"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1012 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("1012", 7)

				for iter_380_1 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_1)

					if var_380_3.name == "" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_380_5 = 0
			local var_380_6 = 1.45

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(410082092).content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 58 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_7) / 58)

				if (58 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_7) / 58)) > 0 and var_380_6 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_10 and arg_377_1.time_ < var_380_5 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 410082093
		arg_381_1.duration_ = 3.43

		local var_381_0 = {
			zh = 3.133,
			ja = 3.433
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
				arg_381_0:Play410082094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1056 = arg_381_1.actors_["1056"].transform.localPosition
				arg_381_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1056", 3)

				for iter_384_0 = 0, arg_381_1.actors_["1056"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["1056"].transform:GetChild(iter_384_0)

					if var_384_0.name == "split_1" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_384_2 = arg_381_1.actors_["1056"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1056 == nil then
				arg_381_1.var_.actorSpriteComps1056 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.034

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps1056 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_384_2 then
							if arg_381_1.isInRecall_ then
								iter_384_2.color = Color.New(Mathf.Lerp(iter_384_2.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_2.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_2.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_2.color.r, 1, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_2.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1056 then
				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_384_4 then
						iter_384_4.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps1056 = nil
			end

			local var_384_5 = arg_381_1.actors_["1060"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1060 = var_384_5.localPosition
				var_384_5.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1060", 2)

				for iter_384_5 = 0, var_384_5.childCount - 1 do
					local var_384_6 = var_384_5:GetChild(iter_384_5)

					if var_384_6.name == "split_3" or not string.find(var_384_6.name, "split") then
						var_384_6.gameObject:SetActive(true)
					else
						var_384_6.gameObject:SetActive(false)
					end
				end
			end

			local var_384_7 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				var_384_5.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_381_1.time_ - 0) / var_384_7)
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				var_384_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_384_8 = arg_381_1.actors_["1012"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1012 = var_384_8.localPosition
				var_384_8.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1012", 4)

				for iter_384_6 = 0, var_384_8.childCount - 1 do
					local var_384_9 = var_384_8:GetChild(iter_384_6)

					if var_384_9.name == "split_3" or not string.find(var_384_9.name, "split") then
						var_384_9.gameObject:SetActive(true)
					else
						var_384_9.gameObject:SetActive(false)
					end
				end
			end

			local var_384_10 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_10 then
				var_384_8.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_381_1.time_ - 0) / var_384_10)
			end

			if arg_381_1.time_ >= 0 + var_384_10 and arg_381_1.time_ < 0 + var_384_10 + arg_384_0 then
				var_384_8.localPosition = Vector3.New(390, -465, 300)
			end

			local var_384_11 = arg_381_1.actors_["1060"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_11) and arg_381_1.var_.actorSpriteComps1060 == nil then
				arg_381_1.var_.actorSpriteComps1060 = var_384_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_12 = 0.034

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_12 and not isNil(var_384_11) then
				if arg_381_1.var_.actorSpriteComps1060 then
					for iter_384_7, iter_384_8 in pairs(arg_381_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_384_8 then
							if arg_381_1.isInRecall_ then
								iter_384_8.color = Color.New(Mathf.Lerp(iter_384_8.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_12), Mathf.Lerp(iter_384_8.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_12), (Mathf.Lerp(iter_384_8.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_12)))
							else
								local var_384_13 = Mathf.Lerp(iter_384_8.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_12)

								iter_384_8.color = Color.New(var_384_13, var_384_13, var_384_13)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_12 and arg_381_1.time_ < 0 + var_384_12 + arg_384_0 and not isNil(var_384_11) and arg_381_1.var_.actorSpriteComps1060 then
				for iter_384_9, iter_384_10 in pairs(arg_381_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_384_10 then
						iter_384_10.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1060 = nil
			end

			local var_384_14 = arg_381_1.actors_["1012"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps1012 == nil then
				arg_381_1.var_.actorSpriteComps1012 = var_384_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_15 = 0.034

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_15 and not isNil(var_384_14) then
				if arg_381_1.var_.actorSpriteComps1012 then
					for iter_384_11, iter_384_12 in pairs(arg_381_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_384_12 then
							if arg_381_1.isInRecall_ then
								iter_384_12.color = Color.New(Mathf.Lerp(iter_384_12.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_15), Mathf.Lerp(iter_384_12.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_15), (Mathf.Lerp(iter_384_12.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_15)))
							else
								local var_384_16 = Mathf.Lerp(iter_384_12.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_15)

								iter_384_12.color = Color.New(var_384_16, var_384_16, var_384_16)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_15 and arg_381_1.time_ < 0 + var_384_15 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps1012 then
				for iter_384_13, iter_384_14 in pairs(arg_381_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_384_14 then
						iter_384_14.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1012 = nil
			end

			local var_384_17 = 0
			local var_384_18 = 0.125

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_17 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_19 = arg_381_1:GetWordFromCfg(410082093)
				local var_384_20 = arg_381_1:FormatText(var_384_19.content)

				arg_381_1.text_.text = var_384_20

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_22 = 5 <= 0 and var_384_18 or var_384_18 * (utf8.len(var_384_20) / 5)

				if (5 <= 0 and var_384_18 or var_384_18 * (utf8.len(var_384_20) / 5)) > 0 and var_384_18 < var_384_22 then
					arg_381_1.talkMaxDuration = var_384_22

					if var_384_22 + var_384_17 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_22 + var_384_17
					end
				end

				arg_381_1.text_.text = var_384_20
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082093", "story_v_out_410082.awb") ~= 0 then
					local var_384_23 = manager.audio:GetVoiceLength("story_v_out_410082", "410082093", "story_v_out_410082.awb") / 1000

					if var_384_23 + var_384_17 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_23 + var_384_17
					end

					if var_384_19.prefab_name ~= "" and arg_381_1.actors_[var_384_19.prefab_name] ~= nil then
						local var_384_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_19.prefab_name].transform, "story_v_out_410082", "410082093", "story_v_out_410082.awb")

						arg_381_1:RecordAudio("410082093", var_384_24)
						arg_381_1:RecordAudio("410082093", var_384_24)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_410082", "410082093", "story_v_out_410082.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_410082", "410082093", "story_v_out_410082.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_25 = math.max(var_384_18, arg_381_1.talkMaxDuration)

			if var_384_17 <= arg_381_1.time_ and arg_381_1.time_ < var_384_17 + var_384_25 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_17) / var_384_25

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_17 + var_384_25 and arg_381_1.time_ < var_384_17 + var_384_25 + arg_384_0 then
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 410082094
		arg_385_1.duration_ = 2.77

		local var_385_0 = {
			zh = 1.033,
			ja = 2.766
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
				arg_385_0:Play410082095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1060 = arg_385_1.actors_["1060"].transform.localPosition
				arg_385_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1060", 2)

				for iter_388_0 = 0, arg_385_1.actors_["1060"].transform.childCount - 1 do
					local var_388_0 = arg_385_1.actors_["1060"].transform:GetChild(iter_388_0)

					if var_388_0.name == "" or not string.find(var_388_0.name, "split") then
						var_388_0.gameObject:SetActive(true)
					else
						var_388_0.gameObject:SetActive(false)
					end
				end
			end

			local var_388_1 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_1 then
				arg_385_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_385_1.time_ - 0) / var_388_1)
			end

			if arg_385_1.time_ >= 0 + var_388_1 and arg_385_1.time_ < 0 + var_388_1 + arg_388_0 then
				arg_385_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_388_2 = arg_385_1.actors_["1012"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1012 = var_388_2.localPosition
				var_388_2.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1012", 4)

				for iter_388_1 = 0, var_388_2.childCount - 1 do
					local var_388_3 = var_388_2:GetChild(iter_388_1)

					if var_388_3.name == "" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				var_388_2.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_385_1.time_ - 0) / var_388_4)
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				var_388_2.localPosition = Vector3.New(390, -465, 300)
			end

			local var_388_5 = arg_385_1.actors_["1060"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.actorSpriteComps1060 == nil then
				arg_385_1.var_.actorSpriteComps1060 = var_388_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_6 = 0.034

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_6 and not isNil(var_388_5) then
				if arg_385_1.var_.actorSpriteComps1060 then
					for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_388_3 then
							if arg_385_1.isInRecall_ then
								iter_388_3.color = Color.New(Mathf.Lerp(iter_388_3.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_6), Mathf.Lerp(iter_388_3.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_6), (Mathf.Lerp(iter_388_3.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_6)))
							else
								local var_388_7 = Mathf.Lerp(iter_388_3.color.r, 1, (arg_385_1.time_ - 0) / var_388_6)

								iter_388_3.color = Color.New(var_388_7, var_388_7, var_388_7)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_6 and arg_385_1.time_ < 0 + var_388_6 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.actorSpriteComps1060 then
				for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_388_5 then
						iter_388_5.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1060 = nil
			end

			local var_388_8 = arg_385_1.actors_["1012"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_8) and arg_385_1.var_.actorSpriteComps1012 == nil then
				arg_385_1.var_.actorSpriteComps1012 = var_388_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_9 = 0.034

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_9 and not isNil(var_388_8) then
				if arg_385_1.var_.actorSpriteComps1012 then
					for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_388_7 then
							if arg_385_1.isInRecall_ then
								iter_388_7.color = Color.New(Mathf.Lerp(iter_388_7.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_9), Mathf.Lerp(iter_388_7.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_9), (Mathf.Lerp(iter_388_7.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_9)))
							else
								local var_388_10 = Mathf.Lerp(iter_388_7.color.r, 1, (arg_385_1.time_ - 0) / var_388_9)

								iter_388_7.color = Color.New(var_388_10, var_388_10, var_388_10)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_9 and arg_385_1.time_ < 0 + var_388_9 + arg_388_0 and not isNil(var_388_8) and arg_385_1.var_.actorSpriteComps1012 then
				for iter_388_8, iter_388_9 in pairs(arg_385_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_388_9 then
						iter_388_9.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1012 = nil
			end

			local var_388_11 = arg_385_1.actors_["1056"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_11) and arg_385_1.var_.actorSpriteComps1056 == nil then
				arg_385_1.var_.actorSpriteComps1056 = var_388_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_12 = 0.034

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_12 and not isNil(var_388_11) then
				if arg_385_1.var_.actorSpriteComps1056 then
					for iter_388_10, iter_388_11 in pairs(arg_385_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_388_11 then
							if arg_385_1.isInRecall_ then
								iter_388_11.color = Color.New(Mathf.Lerp(iter_388_11.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_12), Mathf.Lerp(iter_388_11.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_12), (Mathf.Lerp(iter_388_11.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_12)))
							else
								local var_388_13 = Mathf.Lerp(iter_388_11.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_12)

								iter_388_11.color = Color.New(var_388_13, var_388_13, var_388_13)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_12 and arg_385_1.time_ < 0 + var_388_12 + arg_388_0 and not isNil(var_388_11) and arg_385_1.var_.actorSpriteComps1056 then
				for iter_388_12, iter_388_13 in pairs(arg_385_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_388_13 then
						iter_388_13.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps1056 = nil
			end

			local var_388_14 = 0
			local var_388_15 = 0.075

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[601].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_16 = arg_385_1:GetWordFromCfg(410082094)
				local var_388_17 = arg_385_1:FormatText(var_388_16.content)

				arg_385_1.text_.text = var_388_17

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_19 = 3 <= 0 and var_388_15 or var_388_15 * (utf8.len(var_388_17) / 3)

				if (3 <= 0 and var_388_15 or var_388_15 * (utf8.len(var_388_17) / 3)) > 0 and var_388_15 < var_388_19 then
					arg_385_1.talkMaxDuration = var_388_19

					if var_388_19 + var_388_14 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_19 + var_388_14
					end
				end

				arg_385_1.text_.text = var_388_17
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082094", "story_v_out_410082.awb") ~= 0 then
					local var_388_20 = manager.audio:GetVoiceLength("story_v_out_410082", "410082094", "story_v_out_410082.awb") / 1000

					if var_388_20 + var_388_14 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_20 + var_388_14
					end

					if var_388_16.prefab_name ~= "" and arg_385_1.actors_[var_388_16.prefab_name] ~= nil then
						local var_388_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_16.prefab_name].transform, "story_v_out_410082", "410082094", "story_v_out_410082.awb")

						arg_385_1:RecordAudio("410082094", var_388_21)
						arg_385_1:RecordAudio("410082094", var_388_21)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_410082", "410082094", "story_v_out_410082.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_410082", "410082094", "story_v_out_410082.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_22 = math.max(var_388_15, arg_385_1.talkMaxDuration)

			if var_388_14 <= arg_385_1.time_ and arg_385_1.time_ < var_388_14 + var_388_22 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_14) / var_388_22

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_14 + var_388_22 and arg_385_1.time_ < var_388_14 + var_388_22 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 410082095
		arg_389_1.duration_ = 13.53

		local var_389_0 = {
			zh = 9.366,
			ja = 13.533
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
				arg_389_0:Play410082096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1056 = arg_389_1.actors_["1056"].transform.localPosition
				arg_389_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1056", 3)

				for iter_392_0 = 0, arg_389_1.actors_["1056"].transform.childCount - 1 do
					local var_392_0 = arg_389_1.actors_["1056"].transform:GetChild(iter_392_0)

					if var_392_0.name == "split_1" or not string.find(var_392_0.name, "split") then
						var_392_0.gameObject:SetActive(true)
					else
						var_392_0.gameObject:SetActive(false)
					end
				end
			end

			local var_392_1 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_1 then
				arg_389_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_389_1.time_ - 0) / var_392_1)
			end

			if arg_389_1.time_ >= 0 + var_392_1 and arg_389_1.time_ < 0 + var_392_1 + arg_392_0 then
				arg_389_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_392_2 = arg_389_1.actors_["1056"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1056 == nil then
				arg_389_1.var_.actorSpriteComps1056 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 0.034

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps1056 then
					for iter_392_1, iter_392_2 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1056 then
				for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_392_4 then
						iter_392_4.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps1056 = nil
			end

			local var_392_5 = arg_389_1.actors_["1012"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.actorSpriteComps1012 == nil then
				arg_389_1.var_.actorSpriteComps1012 = var_392_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_6 = 0.034

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_6 and not isNil(var_392_5) then
				if arg_389_1.var_.actorSpriteComps1012 then
					for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_392_6 then
							if arg_389_1.isInRecall_ then
								iter_392_6.color = Color.New(Mathf.Lerp(iter_392_6.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_6), Mathf.Lerp(iter_392_6.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_6), (Mathf.Lerp(iter_392_6.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_6)))
							else
								local var_392_7 = Mathf.Lerp(iter_392_6.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_6)

								iter_392_6.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_6 and arg_389_1.time_ < 0 + var_392_6 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.actorSpriteComps1012 then
				for iter_392_7, iter_392_8 in pairs(arg_389_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_392_8 then
						iter_392_8.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps1012 = nil
			end

			local var_392_8 = arg_389_1.actors_["1060"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps1060 == nil then
				arg_389_1.var_.actorSpriteComps1060 = var_392_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_9 = 0.034

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_9 and not isNil(var_392_8) then
				if arg_389_1.var_.actorSpriteComps1060 then
					for iter_392_9, iter_392_10 in pairs(arg_389_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_392_10 then
							if arg_389_1.isInRecall_ then
								iter_392_10.color = Color.New(Mathf.Lerp(iter_392_10.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_9), Mathf.Lerp(iter_392_10.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_9), (Mathf.Lerp(iter_392_10.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_9)))
							else
								local var_392_10 = Mathf.Lerp(iter_392_10.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_9)

								iter_392_10.color = Color.New(var_392_10, var_392_10, var_392_10)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_9 and arg_389_1.time_ < 0 + var_392_9 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps1060 then
				for iter_392_11, iter_392_12 in pairs(arg_389_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_392_12 then
						iter_392_12.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps1060 = nil
			end

			local var_392_11 = 0
			local var_392_12 = 1

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_11 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_13 = arg_389_1:GetWordFromCfg(410082095)
				local var_392_14 = arg_389_1:FormatText(var_392_13.content)

				arg_389_1.text_.text = var_392_14

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_16 = 40 <= 0 and var_392_12 or var_392_12 * (utf8.len(var_392_14) / 40)

				if (40 <= 0 and var_392_12 or var_392_12 * (utf8.len(var_392_14) / 40)) > 0 and var_392_12 < var_392_16 then
					arg_389_1.talkMaxDuration = var_392_16

					if var_392_16 + var_392_11 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_16 + var_392_11
					end
				end

				arg_389_1.text_.text = var_392_14
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082095", "story_v_out_410082.awb") ~= 0 then
					local var_392_17 = manager.audio:GetVoiceLength("story_v_out_410082", "410082095", "story_v_out_410082.awb") / 1000

					if var_392_17 + var_392_11 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_17 + var_392_11
					end

					if var_392_13.prefab_name ~= "" and arg_389_1.actors_[var_392_13.prefab_name] ~= nil then
						local var_392_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_13.prefab_name].transform, "story_v_out_410082", "410082095", "story_v_out_410082.awb")

						arg_389_1:RecordAudio("410082095", var_392_18)
						arg_389_1:RecordAudio("410082095", var_392_18)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_410082", "410082095", "story_v_out_410082.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_410082", "410082095", "story_v_out_410082.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_19 = math.max(var_392_12, arg_389_1.talkMaxDuration)

			if var_392_11 <= arg_389_1.time_ and arg_389_1.time_ < var_392_11 + var_392_19 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_11) / var_392_19

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_11 + var_392_19 and arg_389_1.time_ < var_392_11 + var_392_19 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play410082096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 410082096
		arg_393_1.duration_ = 8.43

		local var_393_0 = {
			zh = 7.566,
			ja = 8.433
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
				arg_393_0:Play410082097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1012 = arg_393_1.actors_["1012"].transform.localPosition
				arg_393_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1012", 4)

				for iter_396_0 = 0, arg_393_1.actors_["1012"].transform.childCount - 1 do
					local var_396_0 = arg_393_1.actors_["1012"].transform:GetChild(iter_396_0)

					if var_396_0.name == "" or not string.find(var_396_0.name, "split") then
						var_396_0.gameObject:SetActive(true)
					else
						var_396_0.gameObject:SetActive(false)
					end
				end
			end

			local var_396_1 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_1 then
				arg_393_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_393_1.time_ - 0) / var_396_1)
			end

			if arg_393_1.time_ >= 0 + var_396_1 and arg_393_1.time_ < 0 + var_396_1 + arg_396_0 then
				arg_393_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_396_2 = arg_393_1.actors_["1012"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1012 == nil then
				arg_393_1.var_.actorSpriteComps1012 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 0.034

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps1012 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1012 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_396_4 then
						iter_396_4.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1012 = nil
			end

			local var_396_5 = arg_393_1.actors_["1056"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_5) and arg_393_1.var_.actorSpriteComps1056 == nil then
				arg_393_1.var_.actorSpriteComps1056 = var_396_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_6 = 0.034

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_6 and not isNil(var_396_5) then
				if arg_393_1.var_.actorSpriteComps1056 then
					for iter_396_5, iter_396_6 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_396_6 then
							if arg_393_1.isInRecall_ then
								iter_396_6.color = Color.New(Mathf.Lerp(iter_396_6.color.r, arg_393_1.hightColor2.r, (arg_393_1.time_ - 0) / var_396_6), Mathf.Lerp(iter_396_6.color.g, arg_393_1.hightColor2.g, (arg_393_1.time_ - 0) / var_396_6), (Mathf.Lerp(iter_396_6.color.b, arg_393_1.hightColor2.b, (arg_393_1.time_ - 0) / var_396_6)))
							else
								local var_396_7 = Mathf.Lerp(iter_396_6.color.r, 0.5, (arg_393_1.time_ - 0) / var_396_6)

								iter_396_6.color = Color.New(var_396_7, var_396_7, var_396_7)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_6 and arg_393_1.time_ < 0 + var_396_6 + arg_396_0 and not isNil(var_396_5) and arg_393_1.var_.actorSpriteComps1056 then
				for iter_396_7, iter_396_8 in pairs(arg_393_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_396_8 then
						iter_396_8.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_393_1.var_.actorSpriteComps1056 = nil
			end

			local var_396_8 = 0
			local var_396_9 = 0.8

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_10 = arg_393_1:GetWordFromCfg(410082096)
				local var_396_11 = arg_393_1:FormatText(var_396_10.content)

				arg_393_1.text_.text = var_396_11

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_13 = 32 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 32)

				if (32 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 32)) > 0 and var_396_9 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_8
					end
				end

				arg_393_1.text_.text = var_396_11
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082096", "story_v_out_410082.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082096", "story_v_out_410082.awb") / 1000

					if var_396_14 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_8
					end

					if var_396_10.prefab_name ~= "" and arg_393_1.actors_[var_396_10.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_10.prefab_name].transform, "story_v_out_410082", "410082096", "story_v_out_410082.awb")

						arg_393_1:RecordAudio("410082096", var_396_15)
						arg_393_1:RecordAudio("410082096", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_410082", "410082096", "story_v_out_410082.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_410082", "410082096", "story_v_out_410082.awb")
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
				actorName = "1012",
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
	Play410082097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 410082097
		arg_397_1.duration_ = 20.27

		local var_397_0 = {
			zh = 9.7,
			ja = 20.266
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
				arg_397_0:Play410082098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 1.125

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:GetWordFromCfg(410082097)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 45 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 45)

				if (45 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 45)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082097", "story_v_out_410082.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082097", "story_v_out_410082.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_410082", "410082097", "story_v_out_410082.awb")

						arg_397_1:RecordAudio("410082097", var_400_6)
						arg_397_1:RecordAudio("410082097", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_410082", "410082097", "story_v_out_410082.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_410082", "410082097", "story_v_out_410082.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play410082098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 410082098
		arg_401_1.duration_ = 9.6

		local var_401_0 = {
			zh = 4.1,
			ja = 9.6
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
				arg_401_0:Play410082099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.5

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(410082098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 20 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 20)

				if (20 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 20)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082098", "story_v_out_410082.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082098", "story_v_out_410082.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_410082", "410082098", "story_v_out_410082.awb")

						arg_401_1:RecordAudio("410082098", var_404_6)
						arg_401_1:RecordAudio("410082098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_410082", "410082098", "story_v_out_410082.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_410082", "410082098", "story_v_out_410082.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play410082099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 410082099
		arg_405_1.duration_ = 3.23

		local var_405_0 = {
			zh = 3.233,
			ja = 3.2
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
				arg_405_0:Play410082100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1060 = arg_405_1.actors_["1060"].transform.localPosition
				arg_405_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("1060", 2)

				for iter_408_0 = 0, arg_405_1.actors_["1060"].transform.childCount - 1 do
					local var_408_0 = arg_405_1.actors_["1060"].transform:GetChild(iter_408_0)

					if var_408_0.name == "" or not string.find(var_408_0.name, "split") then
						var_408_0.gameObject:SetActive(true)
					else
						var_408_0.gameObject:SetActive(false)
					end
				end
			end

			local var_408_1 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 then
				arg_405_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_405_1.time_ - 0) / var_408_1)
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 then
				arg_405_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_408_2 = arg_405_1.actors_["1060"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps1060 == nil then
				arg_405_1.var_.actorSpriteComps1060 = var_408_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_3 = 0.034

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_3 and not isNil(var_408_2) then
				if arg_405_1.var_.actorSpriteComps1060 then
					for iter_408_1, iter_408_2 in pairs(arg_405_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_408_2 then
							if arg_405_1.isInRecall_ then
								iter_408_2.color = Color.New(Mathf.Lerp(iter_408_2.color.r, arg_405_1.hightColor1.r, (arg_405_1.time_ - 0) / var_408_3), Mathf.Lerp(iter_408_2.color.g, arg_405_1.hightColor1.g, (arg_405_1.time_ - 0) / var_408_3), (Mathf.Lerp(iter_408_2.color.b, arg_405_1.hightColor1.b, (arg_405_1.time_ - 0) / var_408_3)))
							else
								local var_408_4 = Mathf.Lerp(iter_408_2.color.r, 1, (arg_405_1.time_ - 0) / var_408_3)

								iter_408_2.color = Color.New(var_408_4, var_408_4, var_408_4)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_3 and arg_405_1.time_ < 0 + var_408_3 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps1060 then
				for iter_408_3, iter_408_4 in pairs(arg_405_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_408_4 then
						iter_408_4.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_405_1.var_.actorSpriteComps1060 = nil
			end

			local var_408_5 = arg_405_1.actors_["1012"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.actorSpriteComps1012 == nil then
				arg_405_1.var_.actorSpriteComps1012 = var_408_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_6 = 0.034

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_6 and not isNil(var_408_5) then
				if arg_405_1.var_.actorSpriteComps1012 then
					for iter_408_5, iter_408_6 in pairs(arg_405_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_408_6 then
							if arg_405_1.isInRecall_ then
								iter_408_6.color = Color.New(Mathf.Lerp(iter_408_6.color.r, arg_405_1.hightColor2.r, (arg_405_1.time_ - 0) / var_408_6), Mathf.Lerp(iter_408_6.color.g, arg_405_1.hightColor2.g, (arg_405_1.time_ - 0) / var_408_6), (Mathf.Lerp(iter_408_6.color.b, arg_405_1.hightColor2.b, (arg_405_1.time_ - 0) / var_408_6)))
							else
								local var_408_7 = Mathf.Lerp(iter_408_6.color.r, 0.5, (arg_405_1.time_ - 0) / var_408_6)

								iter_408_6.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_6 and arg_405_1.time_ < 0 + var_408_6 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.actorSpriteComps1012 then
				for iter_408_7, iter_408_8 in pairs(arg_405_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_408_8 then
						iter_408_8.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_405_1.var_.actorSpriteComps1012 = nil
			end

			local var_408_8 = 0
			local var_408_9 = 0.375

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(410082099)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_13 = 15 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 15)

				if (15 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 15)) > 0 and var_408_9 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082099", "story_v_out_410082.awb") ~= 0 then
					local var_408_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082099", "story_v_out_410082.awb") / 1000

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end

					if var_408_10.prefab_name ~= "" and arg_405_1.actors_[var_408_10.prefab_name] ~= nil then
						local var_408_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_10.prefab_name].transform, "story_v_out_410082", "410082099", "story_v_out_410082.awb")

						arg_405_1:RecordAudio("410082099", var_408_15)
						arg_405_1:RecordAudio("410082099", var_408_15)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_410082", "410082099", "story_v_out_410082.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_410082", "410082099", "story_v_out_410082.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_16 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_16 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_16

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_16 and arg_405_1.time_ < var_408_8 + var_408_16 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play410082100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 410082100
		arg_409_1.duration_ = 9.37

		local var_409_0 = {
			zh = 6.966,
			ja = 9.366
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
				arg_409_0:Play410082101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1012 = arg_409_1.actors_["1012"].transform.localPosition
				arg_409_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1012", 4)

				for iter_412_0 = 0, arg_409_1.actors_["1012"].transform.childCount - 1 do
					local var_412_0 = arg_409_1.actors_["1012"].transform:GetChild(iter_412_0)

					if var_412_0.name == "" or not string.find(var_412_0.name, "split") then
						var_412_0.gameObject:SetActive(true)
					else
						var_412_0.gameObject:SetActive(false)
					end
				end
			end

			local var_412_1 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				arg_409_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_409_1.time_ - 0) / var_412_1)
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 then
				arg_409_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_412_2 = arg_409_1.actors_["1012"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1012 == nil then
				arg_409_1.var_.actorSpriteComps1012 = var_412_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_3 = 0.034

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.actorSpriteComps1012 then
					for iter_412_1, iter_412_2 in pairs(arg_409_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_412_2 then
							if arg_409_1.isInRecall_ then
								iter_412_2.color = Color.New(Mathf.Lerp(iter_412_2.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_3), Mathf.Lerp(iter_412_2.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_3), (Mathf.Lerp(iter_412_2.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_3)))
							else
								local var_412_4 = Mathf.Lerp(iter_412_2.color.r, 1, (arg_409_1.time_ - 0) / var_412_3)

								iter_412_2.color = Color.New(var_412_4, var_412_4, var_412_4)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1012 then
				for iter_412_3, iter_412_4 in pairs(arg_409_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_412_4 then
						iter_412_4.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps1012 = nil
			end

			local var_412_5 = arg_409_1.actors_["1060"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps1060 == nil then
				arg_409_1.var_.actorSpriteComps1060 = var_412_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_6 = 0.034

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_6 and not isNil(var_412_5) then
				if arg_409_1.var_.actorSpriteComps1060 then
					for iter_412_5, iter_412_6 in pairs(arg_409_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_412_6 then
							if arg_409_1.isInRecall_ then
								iter_412_6.color = Color.New(Mathf.Lerp(iter_412_6.color.r, arg_409_1.hightColor2.r, (arg_409_1.time_ - 0) / var_412_6), Mathf.Lerp(iter_412_6.color.g, arg_409_1.hightColor2.g, (arg_409_1.time_ - 0) / var_412_6), (Mathf.Lerp(iter_412_6.color.b, arg_409_1.hightColor2.b, (arg_409_1.time_ - 0) / var_412_6)))
							else
								local var_412_7 = Mathf.Lerp(iter_412_6.color.r, 0.5, (arg_409_1.time_ - 0) / var_412_6)

								iter_412_6.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_6 and arg_409_1.time_ < 0 + var_412_6 + arg_412_0 and not isNil(var_412_5) and arg_409_1.var_.actorSpriteComps1060 then
				for iter_412_7, iter_412_8 in pairs(arg_409_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_412_8 then
						iter_412_8.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_409_1.var_.actorSpriteComps1060 = nil
			end

			local var_412_8 = 0
			local var_412_9 = 0.75

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_10 = arg_409_1:GetWordFromCfg(410082100)
				local var_412_11 = arg_409_1:FormatText(var_412_10.content)

				arg_409_1.text_.text = var_412_11

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_13 = 30 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 30)

				if (30 <= 0 and var_412_9 or var_412_9 * (utf8.len(var_412_11) / 30)) > 0 and var_412_9 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_8
					end
				end

				arg_409_1.text_.text = var_412_11
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082100", "story_v_out_410082.awb") ~= 0 then
					local var_412_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082100", "story_v_out_410082.awb") / 1000

					if var_412_14 + var_412_8 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_8
					end

					if var_412_10.prefab_name ~= "" and arg_409_1.actors_[var_412_10.prefab_name] ~= nil then
						local var_412_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_10.prefab_name].transform, "story_v_out_410082", "410082100", "story_v_out_410082.awb")

						arg_409_1:RecordAudio("410082100", var_412_15)
						arg_409_1:RecordAudio("410082100", var_412_15)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_410082", "410082100", "story_v_out_410082.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_410082", "410082100", "story_v_out_410082.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_16 = math.max(var_412_9, arg_409_1.talkMaxDuration)

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_8) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_8 + var_412_16 and arg_409_1.time_ < var_412_8 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play410082101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 410082101
		arg_413_1.duration_ = 3.7

		local var_413_0 = {
			zh = 3.3,
			ja = 3.7
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play410082102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1060 = arg_413_1.actors_["1060"].transform.localPosition
				arg_413_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1060", 2)

				for iter_416_0 = 0, arg_413_1.actors_["1060"].transform.childCount - 1 do
					local var_416_0 = arg_413_1.actors_["1060"].transform:GetChild(iter_416_0)

					if var_416_0.name == "" or not string.find(var_416_0.name, "split") then
						var_416_0.gameObject:SetActive(true)
					else
						var_416_0.gameObject:SetActive(false)
					end
				end
			end

			local var_416_1 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_1 then
				arg_413_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_413_1.time_ - 0) / var_416_1)
			end

			if arg_413_1.time_ >= 0 + var_416_1 and arg_413_1.time_ < 0 + var_416_1 + arg_416_0 then
				arg_413_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_416_2 = arg_413_1.actors_["1060"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps1060 == nil then
				arg_413_1.var_.actorSpriteComps1060 = var_416_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_3 = 0.034

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_2) then
				if arg_413_1.var_.actorSpriteComps1060 then
					for iter_416_1, iter_416_2 in pairs(arg_413_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_416_2 then
							if arg_413_1.isInRecall_ then
								iter_416_2.color = Color.New(Mathf.Lerp(iter_416_2.color.r, arg_413_1.hightColor1.r, (arg_413_1.time_ - 0) / var_416_3), Mathf.Lerp(iter_416_2.color.g, arg_413_1.hightColor1.g, (arg_413_1.time_ - 0) / var_416_3), (Mathf.Lerp(iter_416_2.color.b, arg_413_1.hightColor1.b, (arg_413_1.time_ - 0) / var_416_3)))
							else
								local var_416_4 = Mathf.Lerp(iter_416_2.color.r, 1, (arg_413_1.time_ - 0) / var_416_3)

								iter_416_2.color = Color.New(var_416_4, var_416_4, var_416_4)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps1060 then
				for iter_416_3, iter_416_4 in pairs(arg_413_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_416_4 then
						iter_416_4.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_413_1.var_.actorSpriteComps1060 = nil
			end

			local var_416_5 = arg_413_1.actors_["1012"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.actorSpriteComps1012 == nil then
				arg_413_1.var_.actorSpriteComps1012 = var_416_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_6 = 0.034

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_6 and not isNil(var_416_5) then
				if arg_413_1.var_.actorSpriteComps1012 then
					for iter_416_5, iter_416_6 in pairs(arg_413_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_416_6 then
							if arg_413_1.isInRecall_ then
								iter_416_6.color = Color.New(Mathf.Lerp(iter_416_6.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_6), Mathf.Lerp(iter_416_6.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_6), (Mathf.Lerp(iter_416_6.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_6)))
							else
								local var_416_7 = Mathf.Lerp(iter_416_6.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_6)

								iter_416_6.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_6 and arg_413_1.time_ < 0 + var_416_6 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.actorSpriteComps1012 then
				for iter_416_7, iter_416_8 in pairs(arg_413_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_416_8 then
						iter_416_8.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps1012 = nil
			end

			local var_416_8 = 0
			local var_416_9 = 0.45

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_10 = arg_413_1:GetWordFromCfg(410082101)
				local var_416_11 = arg_413_1:FormatText(var_416_10.content)

				arg_413_1.text_.text = var_416_11

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_13 = 18 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 18)

				if (18 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 18)) > 0 and var_416_9 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_8
					end
				end

				arg_413_1.text_.text = var_416_11
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082101", "story_v_out_410082.awb") ~= 0 then
					local var_416_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082101", "story_v_out_410082.awb") / 1000

					if var_416_14 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_14 + var_416_8
					end

					if var_416_10.prefab_name ~= "" and arg_413_1.actors_[var_416_10.prefab_name] ~= nil then
						local var_416_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_10.prefab_name].transform, "story_v_out_410082", "410082101", "story_v_out_410082.awb")

						arg_413_1:RecordAudio("410082101", var_416_15)
						arg_413_1:RecordAudio("410082101", var_416_15)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_410082", "410082101", "story_v_out_410082.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_410082", "410082101", "story_v_out_410082.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_16 = math.max(var_416_9, arg_413_1.talkMaxDuration)

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_16 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_8) / var_416_16

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_8 + var_416_16 and arg_413_1.time_ < var_416_8 + var_416_16 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410082102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 410082102
		arg_417_1.duration_ = 8.03

		local var_417_0 = {
			zh = 4.766,
			ja = 8.033
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
				arg_417_0:Play410082103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1012 = arg_417_1.actors_["1012"].transform.localPosition
				arg_417_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1012", 4)

				for iter_420_0 = 0, arg_417_1.actors_["1012"].transform.childCount - 1 do
					local var_420_0 = arg_417_1.actors_["1012"].transform:GetChild(iter_420_0)

					if var_420_0.name == "" or not string.find(var_420_0.name, "split") then
						var_420_0.gameObject:SetActive(true)
					else
						var_420_0.gameObject:SetActive(false)
					end
				end
			end

			local var_420_1 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_1 then
				arg_417_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_417_1.time_ - 0) / var_420_1)
			end

			if arg_417_1.time_ >= 0 + var_420_1 and arg_417_1.time_ < 0 + var_420_1 + arg_420_0 then
				arg_417_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_420_2 = arg_417_1.actors_["1012"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps1012 == nil then
				arg_417_1.var_.actorSpriteComps1012 = var_420_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_3 = 0.034

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_3 and not isNil(var_420_2) then
				if arg_417_1.var_.actorSpriteComps1012 then
					for iter_420_1, iter_420_2 in pairs(arg_417_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_420_2 then
							if arg_417_1.isInRecall_ then
								iter_420_2.color = Color.New(Mathf.Lerp(iter_420_2.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_3), Mathf.Lerp(iter_420_2.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_3), (Mathf.Lerp(iter_420_2.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_3)))
							else
								local var_420_4 = Mathf.Lerp(iter_420_2.color.r, 1, (arg_417_1.time_ - 0) / var_420_3)

								iter_420_2.color = Color.New(var_420_4, var_420_4, var_420_4)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_3 and arg_417_1.time_ < 0 + var_420_3 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps1012 then
				for iter_420_3, iter_420_4 in pairs(arg_417_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_420_4 then
						iter_420_4.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps1012 = nil
			end

			local var_420_5 = arg_417_1.actors_["1060"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_5) and arg_417_1.var_.actorSpriteComps1060 == nil then
				arg_417_1.var_.actorSpriteComps1060 = var_420_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_6 = 0.034

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_6 and not isNil(var_420_5) then
				if arg_417_1.var_.actorSpriteComps1060 then
					for iter_420_5, iter_420_6 in pairs(arg_417_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_420_6 then
							if arg_417_1.isInRecall_ then
								iter_420_6.color = Color.New(Mathf.Lerp(iter_420_6.color.r, arg_417_1.hightColor2.r, (arg_417_1.time_ - 0) / var_420_6), Mathf.Lerp(iter_420_6.color.g, arg_417_1.hightColor2.g, (arg_417_1.time_ - 0) / var_420_6), (Mathf.Lerp(iter_420_6.color.b, arg_417_1.hightColor2.b, (arg_417_1.time_ - 0) / var_420_6)))
							else
								local var_420_7 = Mathf.Lerp(iter_420_6.color.r, 0.5, (arg_417_1.time_ - 0) / var_420_6)

								iter_420_6.color = Color.New(var_420_7, var_420_7, var_420_7)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_6 and arg_417_1.time_ < 0 + var_420_6 + arg_420_0 and not isNil(var_420_5) and arg_417_1.var_.actorSpriteComps1060 then
				for iter_420_7, iter_420_8 in pairs(arg_417_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_420_8 then
						iter_420_8.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_417_1.var_.actorSpriteComps1060 = nil
			end

			local var_420_8 = 0
			local var_420_9 = 0.55

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_10 = arg_417_1:GetWordFromCfg(410082102)
				local var_420_11 = arg_417_1:FormatText(var_420_10.content)

				arg_417_1.text_.text = var_420_11

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_13 = 22 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 22)

				if (22 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 22)) > 0 and var_420_9 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_8
					end
				end

				arg_417_1.text_.text = var_420_11
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082102", "story_v_out_410082.awb") ~= 0 then
					local var_420_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082102", "story_v_out_410082.awb") / 1000

					if var_420_14 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_14 + var_420_8
					end

					if var_420_10.prefab_name ~= "" and arg_417_1.actors_[var_420_10.prefab_name] ~= nil then
						local var_420_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_10.prefab_name].transform, "story_v_out_410082", "410082102", "story_v_out_410082.awb")

						arg_417_1:RecordAudio("410082102", var_420_15)
						arg_417_1:RecordAudio("410082102", var_420_15)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_410082", "410082102", "story_v_out_410082.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_410082", "410082102", "story_v_out_410082.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_16 = math.max(var_420_9, arg_417_1.talkMaxDuration)

			if var_420_8 <= arg_417_1.time_ and arg_417_1.time_ < var_420_8 + var_420_16 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_8) / var_420_16

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_8 + var_420_16 and arg_417_1.time_ < var_420_8 + var_420_16 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410082103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 410082103
		arg_421_1.duration_ = 5.37

		local var_421_0 = {
			zh = 2.7,
			ja = 5.366
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play410082104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1060 = arg_421_1.actors_["1060"].transform.localPosition
				arg_421_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("1060", 2)

				for iter_424_0 = 0, arg_421_1.actors_["1060"].transform.childCount - 1 do
					local var_424_0 = arg_421_1.actors_["1060"].transform:GetChild(iter_424_0)

					if var_424_0.name == "split_3" or not string.find(var_424_0.name, "split") then
						var_424_0.gameObject:SetActive(true)
					else
						var_424_0.gameObject:SetActive(false)
					end
				end
			end

			local var_424_1 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_1 then
				arg_421_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_421_1.time_ - 0) / var_424_1)
			end

			if arg_421_1.time_ >= 0 + var_424_1 and arg_421_1.time_ < 0 + var_424_1 + arg_424_0 then
				arg_421_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_424_2 = arg_421_1.actors_["1060"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps1060 == nil then
				arg_421_1.var_.actorSpriteComps1060 = var_424_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_3 = 0.034

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_3 and not isNil(var_424_2) then
				if arg_421_1.var_.actorSpriteComps1060 then
					for iter_424_1, iter_424_2 in pairs(arg_421_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_424_2 then
							if arg_421_1.isInRecall_ then
								iter_424_2.color = Color.New(Mathf.Lerp(iter_424_2.color.r, arg_421_1.hightColor1.r, (arg_421_1.time_ - 0) / var_424_3), Mathf.Lerp(iter_424_2.color.g, arg_421_1.hightColor1.g, (arg_421_1.time_ - 0) / var_424_3), (Mathf.Lerp(iter_424_2.color.b, arg_421_1.hightColor1.b, (arg_421_1.time_ - 0) / var_424_3)))
							else
								local var_424_4 = Mathf.Lerp(iter_424_2.color.r, 1, (arg_421_1.time_ - 0) / var_424_3)

								iter_424_2.color = Color.New(var_424_4, var_424_4, var_424_4)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_3 and arg_421_1.time_ < 0 + var_424_3 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps1060 then
				for iter_424_3, iter_424_4 in pairs(arg_421_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_424_4 then
						iter_424_4.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_421_1.var_.actorSpriteComps1060 = nil
			end

			local var_424_5 = arg_421_1.actors_["1012"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.actorSpriteComps1012 == nil then
				arg_421_1.var_.actorSpriteComps1012 = var_424_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_6 = 0.034

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_6 and not isNil(var_424_5) then
				if arg_421_1.var_.actorSpriteComps1012 then
					for iter_424_5, iter_424_6 in pairs(arg_421_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_424_6 then
							if arg_421_1.isInRecall_ then
								iter_424_6.color = Color.New(Mathf.Lerp(iter_424_6.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_6), Mathf.Lerp(iter_424_6.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_6), (Mathf.Lerp(iter_424_6.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_6)))
							else
								local var_424_7 = Mathf.Lerp(iter_424_6.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_6)

								iter_424_6.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_6 and arg_421_1.time_ < 0 + var_424_6 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.actorSpriteComps1012 then
				for iter_424_7, iter_424_8 in pairs(arg_421_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_424_8 then
						iter_424_8.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps1012 = nil
			end

			local var_424_8 = 0
			local var_424_9 = 0.35

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_10 = arg_421_1:GetWordFromCfg(410082103)
				local var_424_11 = arg_421_1:FormatText(var_424_10.content)

				arg_421_1.text_.text = var_424_11

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_13 = 14 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 14)

				if (14 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 14)) > 0 and var_424_9 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_8
					end
				end

				arg_421_1.text_.text = var_424_11
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082103", "story_v_out_410082.awb") ~= 0 then
					local var_424_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082103", "story_v_out_410082.awb") / 1000

					if var_424_14 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_14 + var_424_8
					end

					if var_424_10.prefab_name ~= "" and arg_421_1.actors_[var_424_10.prefab_name] ~= nil then
						local var_424_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_10.prefab_name].transform, "story_v_out_410082", "410082103", "story_v_out_410082.awb")

						arg_421_1:RecordAudio("410082103", var_424_15)
						arg_421_1:RecordAudio("410082103", var_424_15)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_410082", "410082103", "story_v_out_410082.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_410082", "410082103", "story_v_out_410082.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_16 = math.max(var_424_9, arg_421_1.talkMaxDuration)

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_16 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_8) / var_424_16

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_8 + var_424_16 and arg_421_1.time_ < var_424_8 + var_424_16 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play410082104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 410082104
		arg_425_1.duration_ = 1.47

		local var_425_0 = {
			zh = 1.466,
			ja = 1.266
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
				arg_425_0:Play410082105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1012 = arg_425_1.actors_["1012"].transform.localPosition
				arg_425_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("1012", 4)

				for iter_428_0 = 0, arg_425_1.actors_["1012"].transform.childCount - 1 do
					local var_428_0 = arg_425_1.actors_["1012"].transform:GetChild(iter_428_0)

					if var_428_0.name == "" or not string.find(var_428_0.name, "split") then
						var_428_0.gameObject:SetActive(true)
					else
						var_428_0.gameObject:SetActive(false)
					end
				end
			end

			local var_428_1 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_1 then
				arg_425_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_425_1.time_ - 0) / var_428_1)
			end

			if arg_425_1.time_ >= 0 + var_428_1 and arg_425_1.time_ < 0 + var_428_1 + arg_428_0 then
				arg_425_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_428_2 = arg_425_1.actors_["1012"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_2) and arg_425_1.var_.actorSpriteComps1012 == nil then
				arg_425_1.var_.actorSpriteComps1012 = var_428_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_3 = 0.034

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_3 and not isNil(var_428_2) then
				if arg_425_1.var_.actorSpriteComps1012 then
					for iter_428_1, iter_428_2 in pairs(arg_425_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_428_2 then
							if arg_425_1.isInRecall_ then
								iter_428_2.color = Color.New(Mathf.Lerp(iter_428_2.color.r, arg_425_1.hightColor1.r, (arg_425_1.time_ - 0) / var_428_3), Mathf.Lerp(iter_428_2.color.g, arg_425_1.hightColor1.g, (arg_425_1.time_ - 0) / var_428_3), (Mathf.Lerp(iter_428_2.color.b, arg_425_1.hightColor1.b, (arg_425_1.time_ - 0) / var_428_3)))
							else
								local var_428_4 = Mathf.Lerp(iter_428_2.color.r, 1, (arg_425_1.time_ - 0) / var_428_3)

								iter_428_2.color = Color.New(var_428_4, var_428_4, var_428_4)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_3 and arg_425_1.time_ < 0 + var_428_3 + arg_428_0 and not isNil(var_428_2) and arg_425_1.var_.actorSpriteComps1012 then
				for iter_428_3, iter_428_4 in pairs(arg_425_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_428_4 then
						iter_428_4.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_425_1.var_.actorSpriteComps1012 = nil
			end

			local var_428_5 = arg_425_1.actors_["1060"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_5) and arg_425_1.var_.actorSpriteComps1060 == nil then
				arg_425_1.var_.actorSpriteComps1060 = var_428_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_6 = 0.034

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_6 and not isNil(var_428_5) then
				if arg_425_1.var_.actorSpriteComps1060 then
					for iter_428_5, iter_428_6 in pairs(arg_425_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_428_6 then
							if arg_425_1.isInRecall_ then
								iter_428_6.color = Color.New(Mathf.Lerp(iter_428_6.color.r, arg_425_1.hightColor2.r, (arg_425_1.time_ - 0) / var_428_6), Mathf.Lerp(iter_428_6.color.g, arg_425_1.hightColor2.g, (arg_425_1.time_ - 0) / var_428_6), (Mathf.Lerp(iter_428_6.color.b, arg_425_1.hightColor2.b, (arg_425_1.time_ - 0) / var_428_6)))
							else
								local var_428_7 = Mathf.Lerp(iter_428_6.color.r, 0.5, (arg_425_1.time_ - 0) / var_428_6)

								iter_428_6.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_6 and arg_425_1.time_ < 0 + var_428_6 + arg_428_0 and not isNil(var_428_5) and arg_425_1.var_.actorSpriteComps1060 then
				for iter_428_7, iter_428_8 in pairs(arg_425_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_428_8 then
						iter_428_8.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_425_1.var_.actorSpriteComps1060 = nil
			end

			local var_428_8 = 0
			local var_428_9 = 0.1

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_10 = arg_425_1:GetWordFromCfg(410082104)
				local var_428_11 = arg_425_1:FormatText(var_428_10.content)

				arg_425_1.text_.text = var_428_11

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_13 = 4 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 4)

				if (4 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 4)) > 0 and var_428_9 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_8
					end
				end

				arg_425_1.text_.text = var_428_11
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082104", "story_v_out_410082.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_out_410082", "410082104", "story_v_out_410082.awb") / 1000

					if var_428_14 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_8
					end

					if var_428_10.prefab_name ~= "" and arg_425_1.actors_[var_428_10.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_10.prefab_name].transform, "story_v_out_410082", "410082104", "story_v_out_410082.awb")

						arg_425_1:RecordAudio("410082104", var_428_15)
						arg_425_1:RecordAudio("410082104", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_410082", "410082104", "story_v_out_410082.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_410082", "410082104", "story_v_out_410082.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_9, arg_425_1.talkMaxDuration)

			if var_428_8 <= arg_425_1.time_ and arg_425_1.time_ < var_428_8 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_8) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_8 + var_428_16 and arg_425_1.time_ < var_428_8 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play410082105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 410082105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play410082106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1012"]) and arg_429_1.var_.actorSpriteComps1012 == nil then
				arg_429_1.var_.actorSpriteComps1012 = arg_429_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.034

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1012"]) then
				if arg_429_1.var_.actorSpriteComps1012 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1012"]) and arg_429_1.var_.actorSpriteComps1012 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps1012 = nil
			end

			local var_432_2 = arg_429_1.actors_["1012"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1012 = var_432_2.localPosition
				var_432_2.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("1012", 4)

				for iter_432_4 = 0, var_432_2.childCount - 1 do
					local var_432_3 = var_432_2:GetChild(iter_432_4)

					if var_432_3.name == "split_2" or not string.find(var_432_3.name, "split") then
						var_432_3.gameObject:SetActive(true)
					else
						var_432_3.gameObject:SetActive(false)
					end
				end
			end

			local var_432_4 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				var_432_2.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_429_1.time_ - 0) / var_432_4)
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				var_432_2.localPosition = Vector3.New(390, -465, 300)
			end

			local var_432_5 = 0
			local var_432_6 = 0.95

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_7 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(410082105).content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 38 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_7) / 38)

				if (38 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_7) / 38)) > 0 and var_432_6 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_5
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_6, arg_429_1.talkMaxDuration)

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_5) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_5 + var_432_10 and arg_429_1.time_ < var_432_5 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play410082106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 410082106
		arg_433_1.duration_ = 10.63

		local var_433_0 = {
			zh = 10.633,
			ja = 9.5
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play410082107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1012 = arg_433_1.actors_["1012"].transform.localPosition
				arg_433_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("1012", 4)

				for iter_436_0 = 0, arg_433_1.actors_["1012"].transform.childCount - 1 do
					local var_436_0 = arg_433_1.actors_["1012"].transform:GetChild(iter_436_0)

					if var_436_0.name == "split_3" or not string.find(var_436_0.name, "split") then
						var_436_0.gameObject:SetActive(true)
					else
						var_436_0.gameObject:SetActive(false)
					end
				end
			end

			local var_436_1 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_1 then
				arg_433_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_433_1.time_ - 0) / var_436_1)
			end

			if arg_433_1.time_ >= 0 + var_436_1 and arg_433_1.time_ < 0 + var_436_1 + arg_436_0 then
				arg_433_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_436_2 = arg_433_1.actors_["1012"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps1012 == nil then
				arg_433_1.var_.actorSpriteComps1012 = var_436_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_3 = 0.034

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_3 and not isNil(var_436_2) then
				if arg_433_1.var_.actorSpriteComps1012 then
					for iter_436_1, iter_436_2 in pairs(arg_433_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_436_2 then
							if arg_433_1.isInRecall_ then
								iter_436_2.color = Color.New(Mathf.Lerp(iter_436_2.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_3), Mathf.Lerp(iter_436_2.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_3), (Mathf.Lerp(iter_436_2.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_3)))
							else
								local var_436_4 = Mathf.Lerp(iter_436_2.color.r, 1, (arg_433_1.time_ - 0) / var_436_3)

								iter_436_2.color = Color.New(var_436_4, var_436_4, var_436_4)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_3 and arg_433_1.time_ < 0 + var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps1012 then
				for iter_436_3, iter_436_4 in pairs(arg_433_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_436_4 then
						iter_436_4.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps1012 = nil
			end

			local var_436_5 = 0
			local var_436_6 = 1.1

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_7 = arg_433_1:GetWordFromCfg(410082106)
				local var_436_8 = arg_433_1:FormatText(var_436_7.content)

				arg_433_1.text_.text = var_436_8

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_10 = 44 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 44)

				if (44 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_8) / 44)) > 0 and var_436_6 < var_436_10 then
					arg_433_1.talkMaxDuration = var_436_10

					if var_436_10 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_5
					end
				end

				arg_433_1.text_.text = var_436_8
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082106", "story_v_out_410082.awb") ~= 0 then
					local var_436_11 = manager.audio:GetVoiceLength("story_v_out_410082", "410082106", "story_v_out_410082.awb") / 1000

					if var_436_11 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_5
					end

					if var_436_7.prefab_name ~= "" and arg_433_1.actors_[var_436_7.prefab_name] ~= nil then
						local var_436_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_7.prefab_name].transform, "story_v_out_410082", "410082106", "story_v_out_410082.awb")

						arg_433_1:RecordAudio("410082106", var_436_12)
						arg_433_1:RecordAudio("410082106", var_436_12)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_410082", "410082106", "story_v_out_410082.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_410082", "410082106", "story_v_out_410082.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_13 = math.max(var_436_6, arg_433_1.talkMaxDuration)

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_13 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_5) / var_436_13

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_5 + var_436_13 and arg_433_1.time_ < var_436_5 + var_436_13 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play410082107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 410082107
		arg_437_1.duration_ = 2.33

		local var_437_0 = {
			zh = 2.066,
			ja = 2.333
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
			arg_437_1.auto_ = false
		end

		function arg_437_1.playNext_(arg_439_0)
			arg_437_1.onStoryFinished_()
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.125

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:GetWordFromCfg(410082107)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 5 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 5)

				if (5 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 5)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410082", "410082107", "story_v_out_410082.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_410082", "410082107", "story_v_out_410082.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_410082", "410082107", "story_v_out_410082.awb")

						arg_437_1:RecordAudio("410082107", var_440_6)
						arg_437_1:RecordAudio("410082107", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_410082", "410082107", "story_v_out_410082.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_410082", "410082107", "story_v_out_410082.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST61"
	},
	voices = {
		"story_v_out_410082.awb"
	}
}
