return {
	Play410091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410091001
		arg_1_1.duration_ = 7.83

		local var_1_0 = {
			zh = 5.033,
			ja = 7.833
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
				arg_1_0:Play410091002(arg_1_1)
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

			local var_4_8 = "1012"

			if arg_1_1.actors_["1012"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

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

			local var_4_11 = arg_1_1.actors_["1012"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1012 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1012", 2)

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
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_4_14 = "1056"

			if arg_1_1.actors_["1056"] == nil then
				local var_4_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

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

			local var_4_17 = arg_1_1.actors_["1056"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1056 = var_4_17.localPosition
				var_4_17.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1056", 4)

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
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_1_1.time_ - 2) / var_4_19)
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(390, -350, -180)
			end

			local var_4_20 = arg_1_1.actors_["1012"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps1012 == nil then
				arg_1_1.var_.actorSpriteComps1012 = var_4_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_21 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.actorSpriteComps1012 then
					for iter_4_8, iter_4_9 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_21 and arg_1_1.time_ < 2 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.actorSpriteComps1012 then
				for iter_4_10, iter_4_11 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_4_11 then
						iter_4_11.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1012 = nil
			end

			local var_4_23 = arg_1_1.actors_["1056"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.actorSpriteComps1056 == nil then
				arg_1_1.var_.actorSpriteComps1056 = var_4_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_24 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_24 and not isNil(var_4_23) then
				if arg_1_1.var_.actorSpriteComps1056 then
					for iter_4_12, iter_4_13 in pairs(arg_1_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_24 and arg_1_1.time_ < 2 + var_4_24 + arg_4_0 and not isNil(var_4_23) and arg_1_1.var_.actorSpriteComps1056 then
				for iter_4_14, iter_4_15 in pairs(arg_1_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_4_15 then
						iter_4_15.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_1_1.var_.actorSpriteComps1056 = nil
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
			local var_4_33 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(410091001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 16 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 16)

				if (16 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 16)) > 0 and var_4_33 < var_4_38 then
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

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091001", "story_v_out_410091.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_410091", "410091001", "story_v_out_410091.awb") / 1000

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end

					if var_4_35.prefab_name ~= "" and arg_1_1.actors_[var_4_35.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_35.prefab_name].transform, "story_v_out_410091", "410091001", "story_v_out_410091.awb")

						arg_1_1:RecordAudio("410091001", var_4_40)
						arg_1_1:RecordAudio("410091001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410091", "410091001", "story_v_out_410091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410091", "410091001", "story_v_out_410091.awb")
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
				actorName = "1012",
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
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410091002
		arg_9_1.duration_ = 12.6

		local var_9_0 = {
			zh = 4.833,
			ja = 12.6
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
				arg_9_0:Play410091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056 = arg_9_1.actors_["1056"].transform.localPosition
				arg_9_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1056", 4)

				for iter_12_0 = 0, arg_9_1.actors_["1056"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["1056"].transform:GetChild(iter_12_0)

					if var_12_0.name == "split_2" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_12_2 = arg_9_1.actors_["1056"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1056 == nil then
				arg_9_1.var_.actorSpriteComps1056 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps1056 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1056 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_12_4 then
						iter_12_4.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1056 = nil
			end

			local var_12_5 = arg_9_1.actors_["1012"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1012 == nil then
				arg_9_1.var_.actorSpriteComps1012 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps1012 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps1012 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_12_8 then
						iter_12_8.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1012 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.5

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(410091002)
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

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091002", "story_v_out_410091.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091002", "story_v_out_410091.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_410091", "410091002", "story_v_out_410091.awb")

						arg_9_1:RecordAudio("410091002", var_12_15)
						arg_9_1:RecordAudio("410091002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410091", "410091002", "story_v_out_410091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410091", "410091002", "story_v_out_410091.awb")
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
				actorName = "1056",
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
	Play410091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410091003
		arg_13_1.duration_ = 13.7

		local var_13_0 = {
			zh = 5.666,
			ja = 13.7
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
				arg_13_0:Play410091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1012 = arg_13_1.actors_["1012"].transform.localPosition
				arg_13_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1012", 2)

				for iter_16_0 = 0, arg_13_1.actors_["1012"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1012"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_16_2 = arg_13_1.actors_["1012"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1012 == nil then
				arg_13_1.var_.actorSpriteComps1012 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1012 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1012 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1012 = nil
			end

			local var_16_5 = arg_13_1.actors_["1056"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1056 == nil then
				arg_13_1.var_.actorSpriteComps1056 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps1056 then
					for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_16_6 then
							if arg_13_1.isInRecall_ then
								iter_16_6.color = Color.New(Mathf.Lerp(iter_16_6.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_6.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_6.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_6.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_6.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1056 then
				for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_16_8 then
						iter_16_8.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1056 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(410091003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 24 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 24)

				if (24 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 24)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091003", "story_v_out_410091.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091003", "story_v_out_410091.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_410091", "410091003", "story_v_out_410091.awb")

						arg_13_1:RecordAudio("410091003", var_16_15)
						arg_13_1:RecordAudio("410091003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410091", "410091003", "story_v_out_410091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410091", "410091003", "story_v_out_410091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play410091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410091004
		arg_17_1.duration_ = 10.73

		local var_17_0 = {
			zh = 4.8,
			ja = 10.733
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
				arg_17_0:Play410091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056 = arg_17_1.actors_["1056"].transform.localPosition
				arg_17_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1056", 4)

				for iter_20_0 = 0, arg_17_1.actors_["1056"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["1056"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_20_2 = arg_17_1.actors_["1056"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1056 == nil then
				arg_17_1.var_.actorSpriteComps1056 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1056 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1056 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1056 = nil
			end

			local var_20_5 = arg_17_1.actors_["1056"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1056", 7)

				for iter_20_5 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_5)

					if var_20_6.name == "" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_20_8 = "1060"

			if arg_17_1.actors_["1060"] == nil then
				local var_20_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_20_9) then
					local var_20_10 = Object.Instantiate(var_20_9, arg_17_1.canvasGo_.transform)

					var_20_10.transform:SetSiblingIndex(1)

					var_20_10.name = var_20_8
					var_20_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_8] = var_20_10

					if arg_17_1.isInRecall_ then
						for iter_20_6, iter_20_7 in ipairs((var_20_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_7.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_11 = arg_17_1.actors_["1060"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1060 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1060", 4)

				for iter_20_8 = 0, var_20_11.childCount - 1 do
					local var_20_12 = var_20_11:GetChild(iter_20_8)

					if var_20_12.name == "" or not string.find(var_20_12.name, "split") then
						var_20_12.gameObject:SetActive(true)
					else
						var_20_12.gameObject:SetActive(false)
					end
				end
			end

			local var_20_13 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_13 then
				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_17_1.time_ - 0) / var_20_13)
			end

			if arg_17_1.time_ >= 0 + var_20_13 and arg_17_1.time_ < 0 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_20_14 = arg_17_1.actors_["1012"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps1012 == nil then
				arg_17_1.var_.actorSpriteComps1012 = var_20_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_15 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_15 and not isNil(var_20_14) then
				if arg_17_1.var_.actorSpriteComps1012 then
					for iter_20_9, iter_20_10 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_20_10 then
							if arg_17_1.isInRecall_ then
								iter_20_10.color = Color.New(Mathf.Lerp(iter_20_10.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_15), Mathf.Lerp(iter_20_10.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_15), (Mathf.Lerp(iter_20_10.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_15)))
							else
								local var_20_16 = Mathf.Lerp(iter_20_10.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_15)

								iter_20_10.color = Color.New(var_20_16, var_20_16, var_20_16)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_15 and arg_17_1.time_ < 0 + var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.actorSpriteComps1012 then
				for iter_20_11, iter_20_12 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_20_12 then
						iter_20_12.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1012 = nil
			end

			local var_20_17 = arg_17_1.actors_["1060"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.actorSpriteComps1060 == nil then
				arg_17_1.var_.actorSpriteComps1060 = var_20_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_18 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_18 and not isNil(var_20_17) then
				if arg_17_1.var_.actorSpriteComps1060 then
					for iter_20_13, iter_20_14 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_20_14 then
							if arg_17_1.isInRecall_ then
								iter_20_14.color = Color.New(Mathf.Lerp(iter_20_14.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_18), Mathf.Lerp(iter_20_14.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_18), (Mathf.Lerp(iter_20_14.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_18)))
							else
								local var_20_19 = Mathf.Lerp(iter_20_14.color.r, 1, (arg_17_1.time_ - 0) / var_20_18)

								iter_20_14.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_18 and arg_17_1.time_ < 0 + var_20_18 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.actorSpriteComps1060 then
				for iter_20_15, iter_20_16 in pairs(arg_17_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_20_16 then
						iter_20_16.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1060 = nil
			end

			local var_20_20 = 0
			local var_20_21 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_22 = arg_17_1:GetWordFromCfg(410091004)
				local var_20_23 = arg_17_1:FormatText(var_20_22.content)

				arg_17_1.text_.text = var_20_23

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 23 <= 0 and var_20_21 or var_20_21 * (utf8.len(var_20_23) / 23)

				if (23 <= 0 and var_20_21 or var_20_21 * (utf8.len(var_20_23) / 23)) > 0 and var_20_21 < var_20_25 then
					arg_17_1.talkMaxDuration = var_20_25

					if var_20_25 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_25 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_23
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091004", "story_v_out_410091.awb") ~= 0 then
					local var_20_26 = manager.audio:GetVoiceLength("story_v_out_410091", "410091004", "story_v_out_410091.awb") / 1000

					if var_20_26 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_26 + var_20_20
					end

					if var_20_22.prefab_name ~= "" and arg_17_1.actors_[var_20_22.prefab_name] ~= nil then
						local var_20_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_22.prefab_name].transform, "story_v_out_410091", "410091004", "story_v_out_410091.awb")

						arg_17_1:RecordAudio("410091004", var_20_27)
						arg_17_1:RecordAudio("410091004", var_20_27)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410091", "410091004", "story_v_out_410091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410091", "410091004", "story_v_out_410091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_28 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_28 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_28

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_28 and arg_17_1.time_ < var_20_20 + var_20_28 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play410091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410091005
		arg_21_1.duration_ = 11.37

		local var_21_0 = {
			zh = 8.4,
			ja = 11.366
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
				arg_21_0:Play410091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1012 = arg_21_1.actors_["1012"].transform.localPosition
				arg_21_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1012", 2)

				for iter_24_0 = 0, arg_21_1.actors_["1012"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1012"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_24_2 = arg_21_1.actors_["1012"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1012 == nil then
				arg_21_1.var_.actorSpriteComps1012 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1012 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1012 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1012 = nil
			end

			local var_24_5 = arg_21_1.actors_["1060"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_8 then
						iter_24_8.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(410091005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 41 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 41)

				if (41 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 41)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091005", "story_v_out_410091.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091005", "story_v_out_410091.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_410091", "410091005", "story_v_out_410091.awb")

						arg_21_1:RecordAudio("410091005", var_24_15)
						arg_21_1:RecordAudio("410091005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410091", "410091005", "story_v_out_410091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410091", "410091005", "story_v_out_410091.awb")
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
				actorName = "1012",
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
	Play410091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410091006
		arg_25_1.duration_ = 12.5

		local var_25_0 = {
			zh = 7.8,
			ja = 12.5
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
				arg_25_0:Play410091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.875

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(410091006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 35 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 35)

				if (35 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 35)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091006", "story_v_out_410091.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091006", "story_v_out_410091.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_410091", "410091006", "story_v_out_410091.awb")

						arg_25_1:RecordAudio("410091006", var_28_6)
						arg_25_1:RecordAudio("410091006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410091", "410091006", "story_v_out_410091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410091", "410091006", "story_v_out_410091.awb")
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
	Play410091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410091007
		arg_29_1.duration_ = 4.53

		local var_29_0 = {
			zh = 2.366,
			ja = 4.533
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
				arg_29_0:Play410091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1060 = arg_29_1.actors_["1060"].transform.localPosition
				arg_29_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1060", 4)

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
				arg_29_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1060"].transform.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_32_2 = arg_29_1.actors_["1012"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1012 == nil then
				arg_29_1.var_.actorSpriteComps1012 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1012 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1012 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1012 = nil
			end

			local var_32_5 = arg_29_1.actors_["1060"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1060 == nil then
				arg_29_1.var_.actorSpriteComps1060 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps1060 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								iter_32_6.color = Color.New(Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_6), Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_6), (Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_6)))
							else
								local var_32_7 = Mathf.Lerp(iter_32_6.color.r, 1, (arg_29_1.time_ - 0) / var_32_6)

								iter_32_6.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1060 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_32_8 then
						iter_32_8.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1060 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(410091007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)

				if (6 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 6)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091007", "story_v_out_410091.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091007", "story_v_out_410091.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_410091", "410091007", "story_v_out_410091.awb")

						arg_29_1:RecordAudio("410091007", var_32_15)
						arg_29_1:RecordAudio("410091007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410091", "410091007", "story_v_out_410091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410091", "410091007", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410091008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1012 = arg_33_1.actors_["1012"].transform.localPosition
				arg_33_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1012", 7)

				for iter_36_0 = 0, arg_33_1.actors_["1012"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1012"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_36_2 = arg_33_1.actors_["1056"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1056 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1056", 7)

				for iter_36_1 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_1)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_36_5 = arg_33_1.actors_["1012"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps1012 == nil then
				arg_33_1.var_.actorSpriteComps1012 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps1012 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								iter_36_3.color = Color.New(Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_3.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_3.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps1012 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_36_5 then
						iter_36_5.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps1012 = nil
			end

			local var_36_8 = arg_33_1.actors_["1056"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1056 == nil then
				arg_33_1.var_.actorSpriteComps1056 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 and not isNil(var_36_8) then
				if arg_33_1.var_.actorSpriteComps1056 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								iter_36_7.color = Color.New(Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_9), Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_9), (Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_9)))
							else
								local var_36_10 = Mathf.Lerp(iter_36_7.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_9)

								iter_36_7.color = Color.New(var_36_10, var_36_10, var_36_10)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1056 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_36_9 then
						iter_36_9.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps1056 = nil
			end

			local var_36_11 = arg_33_1.actors_["1060"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1060 = var_36_11.localPosition
				var_36_11.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1060", 7)

				for iter_36_10 = 0, var_36_11.childCount - 1 do
					local var_36_12 = var_36_11:GetChild(iter_36_10)

					if var_36_12.name == "" or not string.find(var_36_12.name, "split") then
						var_36_12.gameObject:SetActive(true)
					else
						var_36_12.gameObject:SetActive(false)
					end
				end
			end

			local var_36_13 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_13 then
				var_36_11.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1060, Vector3.New(0, -2000, -180), (arg_33_1.time_ - 0) / var_36_13)
			end

			if arg_33_1.time_ >= 0 + var_36_13 and arg_33_1.time_ < 0 + var_36_13 + arg_36_0 then
				var_36_11.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_36_14 = 0
			local var_36_15 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_16 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(410091008).content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_18 = 33 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_16) / 33)

				if (33 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_16) / 33)) > 0 and var_36_15 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_19 and arg_33_1.time_ < var_36_14 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play410091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410091009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.925

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410091009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 77 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 77)

				if (77 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 77)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410091010
		arg_41_1.duration_ = 4.77

		local var_41_0 = {
			zh = 4.233,
			ja = 4.766
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
				arg_41_0:Play410091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(410091010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 16 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 16)

				if (16 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 16)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091010", "story_v_out_410091.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091010", "story_v_out_410091.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_410091", "410091010", "story_v_out_410091.awb")

						arg_41_1:RecordAudio("410091010", var_44_6)
						arg_41_1:RecordAudio("410091010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410091", "410091010", "story_v_out_410091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410091", "410091010", "story_v_out_410091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play410091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410091011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(410091011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 44 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 44)

				if (44 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 44)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410091012
		arg_49_1.duration_ = 6.43

		local var_49_0 = {
			zh = 5.2,
			ja = 6.433
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
				arg_49_0:Play410091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1056 = arg_49_1.actors_["1056"].transform.localPosition
				arg_49_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1056", 3)

				for iter_52_0 = 0, arg_49_1.actors_["1056"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1056"].transform:GetChild(iter_52_0)

					if var_52_0.name == "split_1" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_52_2 = arg_49_1.actors_["1056"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1056 == nil then
				arg_49_1.var_.actorSpriteComps1056 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1056 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1056 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1056 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.625

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(410091012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 25 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 25)

				if (25 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 25)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091012", "story_v_out_410091.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091012", "story_v_out_410091.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_410091", "410091012", "story_v_out_410091.awb")

						arg_49_1:RecordAudio("410091012", var_52_12)
						arg_49_1:RecordAudio("410091012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410091", "410091012", "story_v_out_410091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410091", "410091012", "story_v_out_410091.awb")
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

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play410091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410091013
		arg_53_1.duration_ = 6.4

		local var_53_0 = {
			zh = 6.4,
			ja = 5.833
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
				arg_53_0:Play410091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1056"]) and arg_53_1.var_.actorSpriteComps1056 == nil then
				arg_53_1.var_.actorSpriteComps1056 = arg_53_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1056"]) then
				if arg_53_1.var_.actorSpriteComps1056 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1056"]) and arg_53_1.var_.actorSpriteComps1056 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1056 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(410091013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 23 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 23)

				if (23 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 23)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091013", "story_v_out_410091.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_410091", "410091013", "story_v_out_410091.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_410091", "410091013", "story_v_out_410091.awb")

						arg_53_1:RecordAudio("410091013", var_56_9)
						arg_53_1:RecordAudio("410091013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410091", "410091013", "story_v_out_410091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410091", "410091013", "story_v_out_410091.awb")
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

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410091014
		arg_57_1.duration_ = 14.03

		local var_57_0 = {
			zh = 6.4,
			ja = 14.033
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
				arg_57_0:Play410091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1056 = arg_57_1.actors_["1056"].transform.localPosition
				arg_57_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1056", 3)

				for iter_60_0 = 0, arg_57_1.actors_["1056"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1056"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_60_2 = arg_57_1.actors_["1056"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1056 == nil then
				arg_57_1.var_.actorSpriteComps1056 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1056 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								iter_60_2.color = Color.New(Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_2.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_2.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1056 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1056 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.75

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(410091014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 30 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 30)

				if (30 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 30)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091014", "story_v_out_410091.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091014", "story_v_out_410091.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_410091", "410091014", "story_v_out_410091.awb")

						arg_57_1:RecordAudio("410091014", var_60_12)
						arg_57_1:RecordAudio("410091014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410091", "410091014", "story_v_out_410091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410091", "410091014", "story_v_out_410091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play410091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410091015
		arg_61_1.duration_ = 9.93

		local var_61_0 = {
			zh = 8.8,
			ja = 9.933
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
				arg_61_0:Play410091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1056"]) and arg_61_1.var_.actorSpriteComps1056 == nil then
				arg_61_1.var_.actorSpriteComps1056 = arg_61_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1056"]) then
				if arg_61_1.var_.actorSpriteComps1056 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1056"]) and arg_61_1.var_.actorSpriteComps1056 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1056 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.675

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:GetWordFromCfg(410091015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 27 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 27)

				if (27 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 27)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091015", "story_v_out_410091.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_410091", "410091015", "story_v_out_410091.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_410091", "410091015", "story_v_out_410091.awb")

						arg_61_1:RecordAudio("410091015", var_64_9)
						arg_61_1:RecordAudio("410091015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410091", "410091015", "story_v_out_410091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410091", "410091015", "story_v_out_410091.awb")
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
	Play410091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410091016
		arg_65_1.duration_ = 6.4

		local var_65_0 = {
			zh = 6.4,
			ja = 6.366
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
				arg_65_0:Play410091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1056 = arg_65_1.actors_["1056"].transform.localPosition
				arg_65_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1056", 3)

				for iter_68_0 = 0, arg_65_1.actors_["1056"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["1056"].transform:GetChild(iter_68_0)

					if var_68_0.name == "split_1" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1056, Vector3.New(0, -350, -180), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["1056"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_68_2 = arg_65_1.actors_["1056"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1056 == nil then
				arg_65_1.var_.actorSpriteComps1056 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1056 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1056 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1056 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.8

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(410091016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 32 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 32)

				if (32 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 32)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091016", "story_v_out_410091.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091016", "story_v_out_410091.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_410091", "410091016", "story_v_out_410091.awb")

						arg_65_1:RecordAudio("410091016", var_68_12)
						arg_65_1:RecordAudio("410091016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410091", "410091016", "story_v_out_410091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410091", "410091016", "story_v_out_410091.awb")
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

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play410091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410091017
		arg_69_1.duration_ = 7.5

		local var_69_0 = {
			zh = 7.5,
			ja = 6.533
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
				arg_69_0:Play410091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.875

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(410091017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)

				if (35 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 35)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091017", "story_v_out_410091.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091017", "story_v_out_410091.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_410091", "410091017", "story_v_out_410091.awb")

						arg_69_1:RecordAudio("410091017", var_72_6)
						arg_69_1:RecordAudio("410091017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410091", "410091017", "story_v_out_410091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410091", "410091017", "story_v_out_410091.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410091018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410091018
		arg_73_1.duration_ = 7.83

		local var_73_0 = {
			zh = 7.833,
			ja = 6.933
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
				arg_73_0:Play410091019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(410091018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 31 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 31)

				if (31 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 31)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091018", "story_v_out_410091.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091018", "story_v_out_410091.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_410091", "410091018", "story_v_out_410091.awb")

						arg_73_1:RecordAudio("410091018", var_76_6)
						arg_73_1:RecordAudio("410091018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410091", "410091018", "story_v_out_410091.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410091", "410091018", "story_v_out_410091.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410091019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410091019
		arg_77_1.duration_ = 1.63

		local var_77_0 = {
			zh = 1.633,
			ja = 1.2
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
				arg_77_0:Play410091020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1056"]) and arg_77_1.var_.actorSpriteComps1056 == nil then
				arg_77_1.var_.actorSpriteComps1056 = arg_77_1.actors_["1056"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1056"]) then
				if arg_77_1.var_.actorSpriteComps1056 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1056"]) and arg_77_1.var_.actorSpriteComps1056 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1056 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_4 = arg_77_1:GetWordFromCfg(410091019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 4 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 4)

				if (4 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 4)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091019", "story_v_out_410091.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_410091", "410091019", "story_v_out_410091.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_410091", "410091019", "story_v_out_410091.awb")

						arg_77_1:RecordAudio("410091019", var_80_9)
						arg_77_1:RecordAudio("410091019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410091", "410091019", "story_v_out_410091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410091", "410091019", "story_v_out_410091.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play410091020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410091020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play410091021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1056 = arg_81_1.actors_["1056"].transform.localPosition
				arg_81_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1056", 7)

				for iter_84_0 = 0, arg_81_1.actors_["1056"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["1056"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1056"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_84_2 = 0
			local var_84_3 = 1.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(410091020).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 48 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 48)

				if (48 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 48)) > 0 and var_84_3 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_7 and arg_81_1.time_ < var_84_2 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play410091021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410091021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play410091022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.875

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(410091021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 35 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 35)

				if (35 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 35)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play410091022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410091022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play410091023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.525

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

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(410091022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 61 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 61)

				if (61 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 61)) > 0 and var_92_0 < var_92_3 then
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
	Play410091023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410091023
		arg_93_1.duration_ = 5.23

		local var_93_0 = {
			zh = 4.5,
			ja = 5.233
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
				arg_93_0:Play410091024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1060 = arg_93_1.actors_["1060"].transform.localPosition
				arg_93_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1060", 2)

				for iter_96_0 = 0, arg_93_1.actors_["1060"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1060"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_96_2 = arg_93_1.actors_["1056"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1056 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1056", 4)

				for iter_96_1 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_1)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_96_5 = arg_93_1.actors_["1060"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps1060 == nil then
				arg_93_1.var_.actorSpriteComps1060 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps1060 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 1, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps1060 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1060 = nil
			end

			local var_96_8 = arg_93_1.actors_["1056"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1056 == nil then
				arg_93_1.var_.actorSpriteComps1056 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps1056 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps1056 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1056 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.5

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(410091023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 20 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 20)

				if (20 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 20)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091023", "story_v_out_410091.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_410091", "410091023", "story_v_out_410091.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_410091", "410091023", "story_v_out_410091.awb")

						arg_93_1:RecordAudio("410091023", var_96_18)
						arg_93_1:RecordAudio("410091023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410091", "410091023", "story_v_out_410091.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410091", "410091023", "story_v_out_410091.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play410091024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410091024
		arg_97_1.duration_ = 4.6

		local var_97_0 = {
			zh = 4.6,
			ja = 3.633
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
				arg_97_0:Play410091025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1056 = arg_97_1.actors_["1056"].transform.localPosition
				arg_97_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1056", 4)

				for iter_100_0 = 0, arg_97_1.actors_["1056"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["1056"].transform:GetChild(iter_100_0)

					if var_100_0.name == "split_2" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_100_2 = arg_97_1.actors_["1056"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1056 == nil then
				arg_97_1.var_.actorSpriteComps1056 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps1056 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								iter_100_2.color = Color.New(Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_2.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_2.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps1056 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_100_4 then
						iter_100_4.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps1056 = nil
			end

			local var_100_5 = arg_97_1.actors_["1060"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1060 == nil then
				arg_97_1.var_.actorSpriteComps1060 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 0.034

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps1060 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								iter_100_6.color = Color.New(Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_6.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_6.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps1060 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_100_8 then
						iter_100_8.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1060 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.475

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(410091024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 19 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 19)

				if (19 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 19)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091024", "story_v_out_410091.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091024", "story_v_out_410091.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_410091", "410091024", "story_v_out_410091.awb")

						arg_97_1:RecordAudio("410091024", var_100_15)
						arg_97_1:RecordAudio("410091024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410091", "410091024", "story_v_out_410091.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410091", "410091024", "story_v_out_410091.awb")
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
				actorName = "1056",
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
	Play410091025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410091025
		arg_101_1.duration_ = 7.93

		local var_101_0 = {
			zh = 5.033,
			ja = 7.933
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
				arg_101_0:Play410091026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1060 = arg_101_1.actors_["1060"].transform.localPosition
				arg_101_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1060", 2)

				for iter_104_0 = 0, arg_101_1.actors_["1060"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["1060"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_104_2 = arg_101_1.actors_["1060"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1060 == nil then
				arg_101_1.var_.actorSpriteComps1060 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1060 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1060 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1060 = nil
			end

			local var_104_5 = arg_101_1.actors_["1056"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps1056 == nil then
				arg_101_1.var_.actorSpriteComps1056 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps1056 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								iter_104_6.color = Color.New(Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_6.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_6.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps1056 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_104_8 then
						iter_104_8.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1056 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.725

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(410091025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 29 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 29)

				if (29 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 29)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091025", "story_v_out_410091.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091025", "story_v_out_410091.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_410091", "410091025", "story_v_out_410091.awb")

						arg_101_1:RecordAudio("410091025", var_104_15)
						arg_101_1:RecordAudio("410091025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410091", "410091025", "story_v_out_410091.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410091", "410091025", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410091026
		arg_105_1.duration_ = 3.07

		local var_105_0 = {
			zh = 2.433,
			ja = 3.066
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
				arg_105_0:Play410091027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1056 = arg_105_1.actors_["1056"].transform.localPosition
				arg_105_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1056", 4)

				for iter_108_0 = 0, arg_105_1.actors_["1056"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["1056"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_4" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_108_2 = arg_105_1.actors_["1056"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps1056 == nil then
				arg_105_1.var_.actorSpriteComps1056 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps1056 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								iter_108_2.color = Color.New(Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_2.color.r, 1, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_2.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps1056 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps1056 = nil
			end

			local var_108_5 = arg_105_1.actors_["1060"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1060 == nil then
				arg_105_1.var_.actorSpriteComps1060 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps1060 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								iter_108_6.color = Color.New(Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_6.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_6.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1060 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_108_8 then
						iter_108_8.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps1060 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(410091026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 8 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 8)

				if (8 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 8)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091026", "story_v_out_410091.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091026", "story_v_out_410091.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_410091", "410091026", "story_v_out_410091.awb")

						arg_105_1:RecordAudio("410091026", var_108_15)
						arg_105_1:RecordAudio("410091026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410091", "410091026", "story_v_out_410091.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410091", "410091026", "story_v_out_410091.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play410091027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410091027
		arg_109_1.duration_ = 5.7

		local var_109_0 = {
			zh = 4.2,
			ja = 5.7
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
				arg_109_0:Play410091028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1060 = arg_109_1.actors_["1060"].transform.localPosition
				arg_109_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1060", 2)

				for iter_112_0 = 0, arg_109_1.actors_["1060"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["1060"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_112_2 = arg_109_1.actors_["1060"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1060 == nil then
				arg_109_1.var_.actorSpriteComps1060 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps1060 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1060 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1060 = nil
			end

			local var_112_5 = arg_109_1.actors_["1056"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1056 == nil then
				arg_109_1.var_.actorSpriteComps1056 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps1056 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								iter_112_6.color = Color.New(Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_6.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_6.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1056 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_112_8 then
						iter_112_8.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps1056 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.45

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(410091027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 18 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 18)

				if (18 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 18)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091027", "story_v_out_410091.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091027", "story_v_out_410091.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_410091", "410091027", "story_v_out_410091.awb")

						arg_109_1:RecordAudio("410091027", var_112_15)
						arg_109_1:RecordAudio("410091027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410091", "410091027", "story_v_out_410091.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410091", "410091027", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410091028
		arg_113_1.duration_ = 8.93

		local var_113_0 = {
			zh = 4.5,
			ja = 8.933
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
				arg_113_0:Play410091029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1056 = arg_113_1.actors_["1056"].transform.localPosition
				arg_113_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1056", 4)

				for iter_116_0 = 0, arg_113_1.actors_["1056"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["1056"].transform:GetChild(iter_116_0)

					if var_116_0.name == "split_2" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_116_2 = arg_113_1.actors_["1056"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1056 == nil then
				arg_113_1.var_.actorSpriteComps1056 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps1056 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1056 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps1056 = nil
			end

			local var_116_5 = arg_113_1.actors_["1060"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps1060 == nil then
				arg_113_1.var_.actorSpriteComps1060 = var_116_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_6 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.actorSpriteComps1060 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								iter_116_6.color = Color.New(Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_6), Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_6), (Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_6)))
							else
								local var_116_7 = Mathf.Lerp(iter_116_6.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_6)

								iter_116_6.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.actorSpriteComps1060 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_116_8 then
						iter_116_8.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1060 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(410091028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)

				if (22 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 22)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091028", "story_v_out_410091.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091028", "story_v_out_410091.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_410091", "410091028", "story_v_out_410091.awb")

						arg_113_1:RecordAudio("410091028", var_116_15)
						arg_113_1:RecordAudio("410091028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410091", "410091028", "story_v_out_410091.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410091", "410091028", "story_v_out_410091.awb")
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
				actorName = "1056",
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
	Play410091029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410091029
		arg_117_1.duration_ = 5.5

		local var_117_0 = {
			zh = 3.233,
			ja = 5.5
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
				arg_117_0:Play410091030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1060 = arg_117_1.actors_["1060"].transform.localPosition
				arg_117_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1060", 2)

				for iter_120_0 = 0, arg_117_1.actors_["1060"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1060"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_120_2 = arg_117_1.actors_["1060"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1060 == nil then
				arg_117_1.var_.actorSpriteComps1060 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps1060 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1060 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1060 = nil
			end

			local var_120_5 = arg_117_1.actors_["1056"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps1056 == nil then
				arg_117_1.var_.actorSpriteComps1056 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps1056 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								iter_120_6.color = Color.New(Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_6.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_6.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps1056 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_120_8 then
						iter_120_8.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps1056 = nil
			end

			local var_120_8 = 0
			local var_120_9 = 0.45

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(410091029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 18 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 18)

				if (18 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 18)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091029", "story_v_out_410091.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091029", "story_v_out_410091.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_410091", "410091029", "story_v_out_410091.awb")

						arg_117_1:RecordAudio("410091029", var_120_15)
						arg_117_1:RecordAudio("410091029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410091", "410091029", "story_v_out_410091.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410091", "410091029", "story_v_out_410091.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play410091030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410091030
		arg_121_1.duration_ = 4.17

		local var_121_0 = {
			zh = 3.566,
			ja = 4.166
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
				arg_121_0:Play410091031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1056 = arg_121_1.actors_["1056"].transform.localPosition
				arg_121_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1056", 4)

				for iter_124_0 = 0, arg_121_1.actors_["1056"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["1056"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_2" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_124_2 = arg_121_1.actors_["1056"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps1056 == nil then
				arg_121_1.var_.actorSpriteComps1056 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps1056 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								iter_124_2.color = Color.New(Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_2.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_2.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps1056 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_124_4 then
						iter_124_4.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1056 = nil
			end

			local var_124_5 = arg_121_1.actors_["1060"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1060 == nil then
				arg_121_1.var_.actorSpriteComps1060 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps1060 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								iter_124_6.color = Color.New(Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_6.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_6.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps1060 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_124_8 then
						iter_124_8.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1060 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(410091030)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 16 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 16)

				if (16 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 16)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091030", "story_v_out_410091.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091030", "story_v_out_410091.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_410091", "410091030", "story_v_out_410091.awb")

						arg_121_1:RecordAudio("410091030", var_124_15)
						arg_121_1:RecordAudio("410091030", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410091", "410091030", "story_v_out_410091.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410091", "410091030", "story_v_out_410091.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play410091031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410091031
		arg_125_1.duration_ = 8.07

		local var_125_0 = {
			zh = 6.3,
			ja = 8.066
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
				arg_125_0:Play410091032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.85

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(410091031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 34 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 34)

				if (34 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 34)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091031", "story_v_out_410091.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091031", "story_v_out_410091.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_410091", "410091031", "story_v_out_410091.awb")

						arg_125_1:RecordAudio("410091031", var_128_6)
						arg_125_1:RecordAudio("410091031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410091", "410091031", "story_v_out_410091.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410091", "410091031", "story_v_out_410091.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play410091032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410091032
		arg_129_1.duration_ = 6.8

		local var_129_0 = {
			zh = 6.5,
			ja = 6.8
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
				arg_129_0:Play410091033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.bgs_.ST61 == nil then
				local var_132_0 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61")
				var_132_0.name = "ST61"
				var_132_0.transform.parent = arg_129_1.stage_.transform
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_.ST61 = var_132_0
			end

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				local var_132_1 = arg_129_1.bgs_.ST61

				arg_129_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_2 = var_132_1:GetComponent("SpriteRenderer")

				if var_132_2 and var_132_2.sprite then
					local var_132_3 = 2 * (var_132_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_1.transform.localScale = Vector3.New(var_132_3 / var_132_2.sprite.bounds.size.y < var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x and var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x or var_132_3 / var_132_2.sprite.bounds.size.y, var_132_3 / var_132_2.sprite.bounds.size.y < var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x and var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x or var_132_3 / var_132_2.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "ST61" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_4 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_5 = 2

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_5 then
				local var_132_6 = Color.New(0, 0, 0)

				var_132_6.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_4) / var_132_5)
				arg_129_1.mask_.color = var_132_6
			end

			if arg_129_1.time_ >= var_132_4 + var_132_5 and arg_129_1.time_ < var_132_4 + var_132_5 + arg_132_0 then
				local var_132_7 = Color.New(0, 0, 0)

				var_132_7.a = 1
				arg_129_1.mask_.color = var_132_7
			end

			local var_132_8 = 2

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_9 = 2

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 then
				local var_132_10 = Color.New(0, 0, 0)

				var_132_10.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_8) / var_132_9)
				arg_129_1.mask_.color = var_132_10
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 then
				local var_132_11 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_11.a = 0
				arg_129_1.mask_.color = var_132_11
			end

			local var_132_12 = arg_129_1.actors_["1056"].transform

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				arg_129_1.var_.moveOldPos1056 = var_132_12.localPosition
				var_132_12.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1056", 7)

				for iter_132_2 = 0, var_132_12.childCount - 1 do
					local var_132_13 = var_132_12:GetChild(iter_132_2)

					if var_132_13.name == "" or not string.find(var_132_13.name, "split") then
						var_132_13.gameObject:SetActive(true)
					else
						var_132_13.gameObject:SetActive(false)
					end
				end
			end

			local var_132_14 = 0.001

			if 2 <= arg_129_1.time_ and arg_129_1.time_ < 2 + var_132_14 then
				var_132_12.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1056, Vector3.New(0, -2000, -180), (arg_129_1.time_ - 2) / var_132_14)
			end

			if arg_129_1.time_ >= 2 + var_132_14 and arg_129_1.time_ < 2 + var_132_14 + arg_132_0 then
				var_132_12.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_132_15 = arg_129_1.actors_["1060"].transform

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				arg_129_1.var_.moveOldPos1060 = var_132_15.localPosition
				var_132_15.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1060", 7)

				for iter_132_3 = 0, var_132_15.childCount - 1 do
					local var_132_16 = var_132_15:GetChild(iter_132_3)

					if var_132_16.name == "" or not string.find(var_132_16.name, "split") then
						var_132_16.gameObject:SetActive(true)
					else
						var_132_16.gameObject:SetActive(false)
					end
				end
			end

			local var_132_17 = 0.001

			if 2 <= arg_129_1.time_ and arg_129_1.time_ < 2 + var_132_17 then
				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_129_1.time_ - 2) / var_132_17)
			end

			if arg_129_1.time_ >= 2 + var_132_17 and arg_129_1.time_ < 2 + var_132_17 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_132_18 = arg_129_1.actors_["1060"]

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.actorSpriteComps1060 == nil then
				arg_129_1.var_.actorSpriteComps1060 = var_132_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_19 = 0.034

			if 2 <= arg_129_1.time_ and arg_129_1.time_ < 2 + var_132_19 and not isNil(var_132_18) then
				if arg_129_1.var_.actorSpriteComps1060 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								iter_132_5.color = Color.New(Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 2) / var_132_19), Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 2) / var_132_19), (Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 2) / var_132_19)))
							else
								local var_132_20 = Mathf.Lerp(iter_132_5.color.r, 0.5, (arg_129_1.time_ - 2) / var_132_19)

								iter_132_5.color = Color.New(var_132_20, var_132_20, var_132_20)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 2 + var_132_19 and arg_129_1.time_ < 2 + var_132_19 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.actorSpriteComps1060 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_132_7 then
						iter_132_7.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps1060 = nil
			end

			local var_132_21 = arg_129_1.actors_["1060"].transform

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= 4 + arg_132_0 then
				arg_129_1.var_.moveOldPos1060 = var_132_21.localPosition
				var_132_21.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1060", 3)

				for iter_132_8 = 0, var_132_21.childCount - 1 do
					local var_132_22 = var_132_21:GetChild(iter_132_8)

					if var_132_22.name == "" or not string.find(var_132_22.name, "split") then
						var_132_22.gameObject:SetActive(true)
					else
						var_132_22.gameObject:SetActive(false)
					end
				end
			end

			local var_132_23 = 0.001

			if 4 <= arg_129_1.time_ and arg_129_1.time_ < 4 + var_132_23 then
				var_132_21.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_129_1.time_ - 4) / var_132_23)
			end

			if arg_129_1.time_ >= 4 + var_132_23 and arg_129_1.time_ < 4 + var_132_23 + arg_132_0 then
				var_132_21.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_132_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_26 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_26

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_26
						arg_129_1.bgmTxt2_.text = var_132_26
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.2 < arg_129_1.time_ and arg_129_1.time_ <= 0.2 + arg_132_0 then
				arg_129_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_132_29 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_29 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_29

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_29
						arg_129_1.bgmTxt2_.text = var_132_29
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_30 = 4
			local var_132_31 = 0.25

			if 4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_32 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_32:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_129_1.dialogCg_.alpha = arg_135_0
				end))
				var_132_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[599].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_33 = arg_129_1:GetWordFromCfg(410091032)
				local var_132_34 = arg_129_1:FormatText(var_132_33.content)

				arg_129_1.text_.text = var_132_34

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_36 = 10 <= 0 and var_132_31 or var_132_31 * (utf8.len(var_132_34) / 10)

				if (10 <= 0 and var_132_31 or var_132_31 * (utf8.len(var_132_34) / 10)) > 0 and var_132_31 < var_132_36 then
					arg_129_1.talkMaxDuration = var_132_36
					var_132_30 = var_132_30 + 0.3

					if var_132_36 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_36 + var_132_30
					end
				end

				arg_129_1.text_.text = var_132_34
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091032", "story_v_out_410091.awb") ~= 0 then
					local var_132_37 = manager.audio:GetVoiceLength("story_v_out_410091", "410091032", "story_v_out_410091.awb") / 1000

					if var_132_37 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_37 + var_132_30
					end

					if var_132_33.prefab_name ~= "" and arg_129_1.actors_[var_132_33.prefab_name] ~= nil then
						local var_132_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_33.prefab_name].transform, "story_v_out_410091", "410091032", "story_v_out_410091.awb")

						arg_129_1:RecordAudio("410091032", var_132_38)
						arg_129_1:RecordAudio("410091032", var_132_38)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410091", "410091032", "story_v_out_410091.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410091", "410091032", "story_v_out_410091.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_39 = var_132_30 + 0.3
			local var_132_40 = math.max(var_132_31, arg_129_1.talkMaxDuration)

			if var_132_30 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_39 + var_132_40 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_39) / var_132_40

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_39 + var_132_40 and arg_129_1.time_ < var_132_39 + var_132_40 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410091033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410091033
		arg_137_1.duration_ = 7.17

		local var_137_0 = {
			zh = 3.333,
			ja = 7.166
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
				arg_137_0:Play410091034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1060 = arg_137_1.actors_["1060"].transform.localPosition
				arg_137_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1060", 3)

				for iter_140_0 = 0, arg_137_1.actors_["1060"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1060"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_140_2 = arg_137_1.actors_["1060"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1060 == nil then
				arg_137_1.var_.actorSpriteComps1060 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps1060 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps1060 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1060 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(410091033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 20 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 20)

				if (20 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 20)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091033", "story_v_out_410091.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091033", "story_v_out_410091.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_410091", "410091033", "story_v_out_410091.awb")

						arg_137_1:RecordAudio("410091033", var_140_12)
						arg_137_1:RecordAudio("410091033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410091", "410091033", "story_v_out_410091.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410091", "410091033", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410091034
		arg_141_1.duration_ = 8.23

		local var_141_0 = {
			zh = 5.5,
			ja = 8.233
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
				arg_141_0:Play410091035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1060"]) and arg_141_1.var_.actorSpriteComps1060 == nil then
				arg_141_1.var_.actorSpriteComps1060 = arg_141_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1060"]) then
				if arg_141_1.var_.actorSpriteComps1060 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1060"]) and arg_141_1.var_.actorSpriteComps1060 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps1060 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 0.725

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[599].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_4 = arg_141_1:GetWordFromCfg(410091034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 29 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 29)

				if (29 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 29)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091034", "story_v_out_410091.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_410091", "410091034", "story_v_out_410091.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_410091", "410091034", "story_v_out_410091.awb")

						arg_141_1:RecordAudio("410091034", var_144_9)
						arg_141_1:RecordAudio("410091034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410091", "410091034", "story_v_out_410091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410091", "410091034", "story_v_out_410091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410091035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410091035
		arg_145_1.duration_ = 7.4

		local var_145_0 = {
			zh = 5.533,
			ja = 7.4
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
				arg_145_0:Play410091036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1060 = arg_145_1.actors_["1060"].transform.localPosition
				arg_145_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1060", 3)

				for iter_148_0 = 0, arg_145_1.actors_["1060"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1060"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_2" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_148_2 = arg_145_1.actors_["1060"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1060 == nil then
				arg_145_1.var_.actorSpriteComps1060 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1060 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1060 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1060 = nil
			end

			local var_148_5 = 0
			local var_148_6 = 0.55

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(410091035)
				local var_148_8 = arg_145_1:FormatText(var_148_7.content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 22 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 22)

				if (22 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 22)) > 0 and var_148_6 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091035", "story_v_out_410091.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091035", "story_v_out_410091.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_410091", "410091035", "story_v_out_410091.awb")

						arg_145_1:RecordAudio("410091035", var_148_12)
						arg_145_1:RecordAudio("410091035", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410091", "410091035", "story_v_out_410091.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410091", "410091035", "story_v_out_410091.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_13 and arg_145_1.time_ < var_148_5 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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
	Play410091036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410091036
		arg_149_1.duration_ = 3.9

		local var_149_0 = {
			zh = 3.9,
			ja = 1.9
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410091037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1060"]) and arg_149_1.var_.actorSpriteComps1060 == nil then
				arg_149_1.var_.actorSpriteComps1060 = arg_149_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1060"]) then
				if arg_149_1.var_.actorSpriteComps1060 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1060"]) and arg_149_1.var_.actorSpriteComps1060 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1060 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.5

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[599].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:GetWordFromCfg(410091036)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 20 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 20)

				if (20 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 20)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091036", "story_v_out_410091.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_410091", "410091036", "story_v_out_410091.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_410091", "410091036", "story_v_out_410091.awb")

						arg_149_1:RecordAudio("410091036", var_152_9)
						arg_149_1:RecordAudio("410091036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410091", "410091036", "story_v_out_410091.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410091", "410091036", "story_v_out_410091.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410091037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410091037
		arg_153_1.duration_ = 5.13

		local var_153_0 = {
			zh = 3.333,
			ja = 5.133
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
				arg_153_0:Play410091038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1060 = arg_153_1.actors_["1060"].transform.localPosition
				arg_153_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1060", 3)

				for iter_156_0 = 0, arg_153_1.actors_["1060"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1060"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_156_2 = arg_153_1.actors_["1060"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1060 == nil then
				arg_153_1.var_.actorSpriteComps1060 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1060 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1060 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1060 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.35

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(410091037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 14 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 14)

				if (14 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 14)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091037", "story_v_out_410091.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091037", "story_v_out_410091.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_410091", "410091037", "story_v_out_410091.awb")

						arg_153_1:RecordAudio("410091037", var_156_12)
						arg_153_1:RecordAudio("410091037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410091", "410091037", "story_v_out_410091.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410091", "410091037", "story_v_out_410091.awb")
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
	Play410091038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410091038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410091039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1060 = arg_157_1.actors_["1060"].transform.localPosition
				arg_157_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1060", 7)

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
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_160_2 = 0
			local var_160_3 = 1.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(410091038).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 57 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 57)

				if (57 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 57)) > 0 and var_160_3 < var_160_6 then
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
	Play410091039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410091039
		arg_161_1.duration_ = 6.17

		local var_161_0 = {
			zh = 2.966,
			ja = 6.166
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
				arg_161_0:Play410091040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1060 = arg_161_1.actors_["1060"].transform.localPosition
				arg_161_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1060", 3)

				for iter_164_0 = 0, arg_161_1.actors_["1060"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["1060"].transform:GetChild(iter_164_0)

					if var_164_0.name == "split_4" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_164_2 = arg_161_1.actors_["1060"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1060 == nil then
				arg_161_1.var_.actorSpriteComps1060 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps1060 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								iter_164_2.color = Color.New(Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_2.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_2.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1060 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_164_4 then
						iter_164_4.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1060 = nil
			end

			local var_164_5 = 0
			local var_164_6 = 0.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
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

				local var_164_7 = arg_161_1:GetWordFromCfg(410091039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 17 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 17)

				if (17 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 17)) > 0 and var_164_6 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091039", "story_v_out_410091.awb") ~= 0 then
					local var_164_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091039", "story_v_out_410091.awb") / 1000

					if var_164_11 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_5
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_410091", "410091039", "story_v_out_410091.awb")

						arg_161_1:RecordAudio("410091039", var_164_12)
						arg_161_1:RecordAudio("410091039", var_164_12)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410091", "410091039", "story_v_out_410091.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410091", "410091039", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410091040
		arg_165_1.duration_ = 4.83

		local var_165_0 = {
			zh = 2.233,
			ja = 4.833
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
				arg_165_0:Play410091041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(410091040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 5 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 5)

				if (5 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 5)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091040", "story_v_out_410091.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091040", "story_v_out_410091.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_410091", "410091040", "story_v_out_410091.awb")

						arg_165_1:RecordAudio("410091040", var_168_6)
						arg_165_1:RecordAudio("410091040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410091", "410091040", "story_v_out_410091.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410091", "410091040", "story_v_out_410091.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play410091041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410091041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410091042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1060 = arg_169_1.actors_["1060"].transform.localPosition
				arg_169_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1060", 7)

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
				arg_169_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
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
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1060 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1060 = nil
			end

			local var_172_5 = 0
			local var_172_6 = 1.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(410091041).content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 69 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 69)

				if (69 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 69)) > 0 and var_172_6 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_10 and arg_169_1.time_ < var_172_5 + var_172_10 + arg_172_0 then
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
	Play410091042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410091042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play410091043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.275

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

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(410091042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 51 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 51)

				if (51 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 51)) > 0 and var_176_0 < var_176_3 then
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
	Play410091043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410091043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play410091044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(410091043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 40 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 40)

				if (40 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 40)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play410091044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410091044
		arg_181_1.duration_ = 4.9

		local var_181_0 = {
			zh = 2.4,
			ja = 4.9
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
				arg_181_0:Play410091045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1060 = arg_181_1.actors_["1060"].transform.localPosition
				arg_181_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1060", 3)

				for iter_184_0 = 0, arg_181_1.actors_["1060"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["1060"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_3" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_184_2 = arg_181_1.actors_["1060"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1060 == nil then
				arg_181_1.var_.actorSpriteComps1060 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1060 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1060 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1060 = nil
			end

			local var_184_5 = 0
			local var_184_6 = 0.2

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:GetWordFromCfg(410091044)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 8 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 8)

				if (8 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 8)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091044", "story_v_out_410091.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091044", "story_v_out_410091.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_410091", "410091044", "story_v_out_410091.awb")

						arg_181_1:RecordAudio("410091044", var_184_12)
						arg_181_1:RecordAudio("410091044", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410091", "410091044", "story_v_out_410091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410091", "410091044", "story_v_out_410091.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play410091045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410091045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410091046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1060"]) and arg_185_1.var_.actorSpriteComps1060 == nil then
				arg_185_1.var_.actorSpriteComps1060 = arg_185_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1060"]) then
				if arg_185_1.var_.actorSpriteComps1060 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1060"]) and arg_185_1.var_.actorSpriteComps1060 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1060 = nil
			end

			local var_188_2 = 0
			local var_188_3 = 1.125

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

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(410091045).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 45 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 45)

				if (45 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 45)) > 0 and var_188_3 < var_188_6 then
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
	Play410091046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410091046
		arg_189_1.duration_ = 6.9

		local var_189_0 = {
			zh = 4.3,
			ja = 6.9
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
				arg_189_0:Play410091047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1060 = arg_189_1.actors_["1060"].transform.localPosition
				arg_189_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1060", 3)

				for iter_192_0 = 0, arg_189_1.actors_["1060"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1060"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_1" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
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
			local var_192_6 = 0.6

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

				local var_192_7 = arg_189_1:GetWordFromCfg(410091046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 24 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 24)

				if (24 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 24)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091046", "story_v_out_410091.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091046", "story_v_out_410091.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_410091", "410091046", "story_v_out_410091.awb")

						arg_189_1:RecordAudio("410091046", var_192_12)
						arg_189_1:RecordAudio("410091046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410091", "410091046", "story_v_out_410091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410091", "410091046", "story_v_out_410091.awb")
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
	Play410091047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410091047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410091048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1060"]) and arg_193_1.var_.actorSpriteComps1060 == nil then
				arg_193_1.var_.actorSpriteComps1060 = arg_193_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1060"]) then
				if arg_193_1.var_.actorSpriteComps1060 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1060"]) and arg_193_1.var_.actorSpriteComps1060 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1060 = nil
			end

			local var_196_2 = 0
			local var_196_3 = 1.05

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_4 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(410091047).content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 42 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_4) / 42)

				if (42 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_4) / 42)) > 0 and var_196_3 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_7 and arg_193_1.time_ < var_196_2 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play410091048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410091048
		arg_197_1.duration_ = 4.3

		local var_197_0 = {
			zh = 2.166,
			ja = 4.3
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
				arg_197_0:Play410091049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060 = arg_197_1.actors_["1060"].transform.localPosition
				arg_197_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1060", 3)

				for iter_200_0 = 0, arg_197_1.actors_["1060"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1060"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_3" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_200_2 = arg_197_1.actors_["1060"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1060 == nil then
				arg_197_1.var_.actorSpriteComps1060 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1060 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1060 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps1060 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(410091048)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 12 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 12)

				if (12 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 12)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091048", "story_v_out_410091.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091048", "story_v_out_410091.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_410091", "410091048", "story_v_out_410091.awb")

						arg_197_1:RecordAudio("410091048", var_200_12)
						arg_197_1:RecordAudio("410091048", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410091", "410091048", "story_v_out_410091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410091", "410091048", "story_v_out_410091.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play410091049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410091049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410091050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1060 = arg_201_1.actors_["1060"].transform.localPosition
				arg_201_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1060", 7)

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
				arg_201_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
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
								iter_204_2.color = Color.New(Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_2.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_2.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps1060 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1060 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 1.075

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(410091049).content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 43 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_7) / 43)

				if (43 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_7) / 43)) > 0 and var_204_6 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_10 and arg_201_1.time_ < var_204_5 + var_204_10 + arg_204_0 then
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
	Play410091050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410091050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410091051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.025

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(410091050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 41 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 41)

				if (41 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 41)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play410091051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410091051
		arg_209_1.duration_ = 8.6

		local var_209_0 = {
			zh = 8.6,
			ja = 7.433
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
				arg_209_0:Play410091052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060 = arg_209_1.actors_["1060"].transform.localPosition
				arg_209_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1060", 3)

				for iter_212_0 = 0, arg_209_1.actors_["1060"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["1060"].transform:GetChild(iter_212_0)

					if var_212_0.name == "split_3" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_212_2 = arg_209_1.actors_["1060"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1060 == nil then
				arg_209_1.var_.actorSpriteComps1060 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps1060 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1060 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_212_4 then
						iter_212_4.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1060 = nil
			end

			local var_212_5 = 0
			local var_212_6 = 0.875

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(410091051)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 35 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 35)

				if (35 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 35)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091051", "story_v_out_410091.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091051", "story_v_out_410091.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_410091", "410091051", "story_v_out_410091.awb")

						arg_209_1:RecordAudio("410091051", var_212_12)
						arg_209_1:RecordAudio("410091051", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410091", "410091051", "story_v_out_410091.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410091", "410091051", "story_v_out_410091.awb")
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
	Play410091052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410091052
		arg_213_1.duration_ = 11.4

		local var_213_0 = {
			zh = 7.333,
			ja = 11.4
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
				arg_213_0:Play410091053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.625

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(410091052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 25 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 25)

				if (25 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 25)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091052", "story_v_out_410091.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091052", "story_v_out_410091.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_410091", "410091052", "story_v_out_410091.awb")

						arg_213_1:RecordAudio("410091052", var_216_6)
						arg_213_1:RecordAudio("410091052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410091", "410091052", "story_v_out_410091.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410091", "410091052", "story_v_out_410091.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play410091053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410091053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410091054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1060"]) and arg_217_1.var_.actorSpriteComps1060 == nil then
				arg_217_1.var_.actorSpriteComps1060 = arg_217_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1060"]) then
				if arg_217_1.var_.actorSpriteComps1060 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1060"]) and arg_217_1.var_.actorSpriteComps1060 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps1060 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.875

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(410091053).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 35 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 35)

				if (35 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 35)) > 0 and var_220_3 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_7 and arg_217_1.time_ < var_220_2 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410091054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410091054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play410091055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.5

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(410091054).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 60 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 60)

				if (60 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 60)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play410091055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410091055
		arg_225_1.duration_ = 5

		local var_225_0 = {
			zh = 3.066,
			ja = 5
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
				arg_225_0:Play410091056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1060 = arg_225_1.actors_["1060"].transform.localPosition
				arg_225_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1060", 3)

				for iter_228_0 = 0, arg_225_1.actors_["1060"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["1060"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_228_2 = arg_225_1.actors_["1060"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_3 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_4 then
						iter_228_4.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_5 = 0
			local var_228_6 = 0.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(410091055)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 13 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 13)

				if (13 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 13)) > 0 and var_228_6 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091055", "story_v_out_410091.awb") ~= 0 then
					local var_228_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091055", "story_v_out_410091.awb") / 1000

					if var_228_11 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_5
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_410091", "410091055", "story_v_out_410091.awb")

						arg_225_1:RecordAudio("410091055", var_228_12)
						arg_225_1:RecordAudio("410091055", var_228_12)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410091", "410091055", "story_v_out_410091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410091", "410091055", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410091056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play410091057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1060"]) and arg_229_1.var_.actorSpriteComps1060 == nil then
				arg_229_1.var_.actorSpriteComps1060 = arg_229_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1060"]) then
				if arg_229_1.var_.actorSpriteComps1060 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1060"]) and arg_229_1.var_.actorSpriteComps1060 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps1060 = nil
			end

			local var_232_2 = 0
			local var_232_3 = 1.325

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(410091056).content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 53 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 53)

				if (53 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 53)) > 0 and var_232_3 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_7 and arg_229_1.time_ < var_232_2 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play410091057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410091057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410091058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 1.2

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

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(410091057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 48 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 48)

				if (48 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 48)) > 0 and var_236_0 < var_236_3 then
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
	Play410091058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410091058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410091059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.325

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(410091058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 53 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 53)

				if (53 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 53)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play410091059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410091059
		arg_241_1.duration_ = 3.47

		local var_241_0 = {
			zh = 1.466,
			ja = 3.466
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
				arg_241_0:Play410091060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1060 = arg_241_1.actors_["1060"].transform.localPosition
				arg_241_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1060", 3)

				for iter_244_0 = 0, arg_241_1.actors_["1060"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["1060"].transform:GetChild(iter_244_0)

					if var_244_0.name == "split_4" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_244_2 = arg_241_1.actors_["1060"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1060 == nil then
				arg_241_1.var_.actorSpriteComps1060 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps1060 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps1060 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1060 = nil
			end

			local var_244_5 = 0
			local var_244_6 = 0.15

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(410091059)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 6 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 6)

				if (6 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 6)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091059", "story_v_out_410091.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091059", "story_v_out_410091.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_410091", "410091059", "story_v_out_410091.awb")

						arg_241_1:RecordAudio("410091059", var_244_12)
						arg_241_1:RecordAudio("410091059", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410091", "410091059", "story_v_out_410091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410091", "410091059", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410091060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410091061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1060 = arg_245_1.actors_["1060"].transform.localPosition
				arg_245_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1060", 7)

				for iter_248_0 = 0, arg_245_1.actors_["1060"].transform.childCount - 1 do
					local var_248_0 = arg_245_1.actors_["1060"].transform:GetChild(iter_248_0)

					if var_248_0.name == "split_4" or not string.find(var_248_0.name, "split") then
						var_248_0.gameObject:SetActive(true)
					else
						var_248_0.gameObject:SetActive(false)
					end
				end
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				arg_245_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_245_1.time_ - 0) / var_248_1)
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				arg_245_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_248_2 = 0
			local var_248_3 = 1.375

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

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(410091060).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 55 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 55)

				if (55 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 55)) > 0 and var_248_3 < var_248_6 then
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

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play410091061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410091061
		arg_249_1.duration_ = 3.37

		local var_249_0 = {
			zh = 2,
			ja = 3.366
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
				arg_249_0:Play410091062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1060 = arg_249_1.actors_["1060"].transform.localPosition
				arg_249_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1060", 3)

				for iter_252_0 = 0, arg_249_1.actors_["1060"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1060"].transform:GetChild(iter_252_0)

					if var_252_0.name == "split_3" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["1060"].transform.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_252_2 = arg_249_1.actors_["1060"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1060 == nil then
				arg_249_1.var_.actorSpriteComps1060 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps1060 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps1060 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_252_4 then
						iter_252_4.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1060 = nil
			end

			local var_252_5 = 0
			local var_252_6 = 0.15

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(410091061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 6 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 6)

				if (6 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 6)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091061", "story_v_out_410091.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091061", "story_v_out_410091.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_410091", "410091061", "story_v_out_410091.awb")

						arg_249_1:RecordAudio("410091061", var_252_12)
						arg_249_1:RecordAudio("410091061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410091", "410091061", "story_v_out_410091.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410091", "410091061", "story_v_out_410091.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play410091062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410091062
		arg_253_1.duration_ = 9.5

		local var_253_0 = {
			zh = 8.433,
			ja = 9.5
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
				arg_253_0:Play410091063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 2 < arg_253_1.time_ and arg_253_1.time_ <= 2 + arg_256_0 then
				local var_256_0 = arg_253_1.bgs_.L01f

				arg_253_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_1 = var_256_0:GetComponent("SpriteRenderer")

				if var_256_1 and var_256_1.sprite then
					local var_256_2 = 2 * (var_256_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_0.transform.localScale = Vector3.New(var_256_2 / var_256_1.sprite.bounds.size.y < var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x and var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x or var_256_2 / var_256_1.sprite.bounds.size.y, var_256_2 / var_256_1.sprite.bounds.size.y < var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x and var_256_2 * manager.ui.mainCameraCom_.aspect / var_256_1.sprite.bounds.size.x or var_256_2 / var_256_1.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "L01f" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_3 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_4 = 2

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_4 then
				local var_256_5 = Color.New(0, 0, 0)

				var_256_5.a = Mathf.Lerp(0, 1, (arg_253_1.time_ - var_256_3) / var_256_4)
				arg_253_1.mask_.color = var_256_5
			end

			if arg_253_1.time_ >= var_256_3 + var_256_4 and arg_253_1.time_ < var_256_3 + var_256_4 + arg_256_0 then
				local var_256_6 = Color.New(0, 0, 0)

				var_256_6.a = 1
				arg_253_1.mask_.color = var_256_6
			end

			local var_256_7 = 2

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_8 = 2

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_8 then
				local var_256_9 = Color.New(0, 0, 0)

				var_256_9.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_7) / var_256_8)
				arg_253_1.mask_.color = var_256_9
			end

			if arg_253_1.time_ >= var_256_7 + var_256_8 and arg_253_1.time_ < var_256_7 + var_256_8 + arg_256_0 then
				local var_256_10 = Color.New(0, 0, 0)

				arg_253_1.mask_.enabled = false
				var_256_10.a = 0
				arg_253_1.mask_.color = var_256_10
			end

			local var_256_11 = arg_253_1.actors_["1060"].transform

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= 2 + arg_256_0 then
				arg_253_1.var_.moveOldPos1060 = var_256_11.localPosition
				var_256_11.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1060", 7)

				for iter_256_2 = 0, var_256_11.childCount - 1 do
					local var_256_12 = var_256_11:GetChild(iter_256_2)

					if var_256_12.name == "" or not string.find(var_256_12.name, "split") then
						var_256_12.gameObject:SetActive(true)
					else
						var_256_12.gameObject:SetActive(false)
					end
				end
			end

			local var_256_13 = 0.001

			if 2 <= arg_253_1.time_ and arg_253_1.time_ < 2 + var_256_13 then
				var_256_11.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_253_1.time_ - 2) / var_256_13)
			end

			if arg_253_1.time_ >= 2 + var_256_13 and arg_253_1.time_ < 2 + var_256_13 + arg_256_0 then
				var_256_11.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_256_14 = arg_253_1.actors_["1012"].transform

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= 4 + arg_256_0 then
				arg_253_1.var_.moveOldPos1012 = var_256_14.localPosition
				var_256_14.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1012", 3)

				for iter_256_3 = 0, var_256_14.childCount - 1 do
					local var_256_15 = var_256_14:GetChild(iter_256_3)

					if var_256_15.name == "" or not string.find(var_256_15.name, "split") then
						var_256_15.gameObject:SetActive(true)
					else
						var_256_15.gameObject:SetActive(false)
					end
				end
			end

			local var_256_16 = 0.001

			if 4 <= arg_253_1.time_ and arg_253_1.time_ < 4 + var_256_16 then
				var_256_14.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_253_1.time_ - 4) / var_256_16)
			end

			if arg_253_1.time_ >= 4 + var_256_16 and arg_253_1.time_ < 4 + var_256_16 + arg_256_0 then
				var_256_14.localPosition = Vector3.New(0, -465, 300)
			end

			local var_256_17 = arg_253_1.actors_["1060"]

			if 2 < arg_253_1.time_ and arg_253_1.time_ <= 2 + arg_256_0 and not isNil(var_256_17) and arg_253_1.var_.actorSpriteComps1060 == nil then
				arg_253_1.var_.actorSpriteComps1060 = var_256_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_18 = 0.034

			if 2 <= arg_253_1.time_ and arg_253_1.time_ < 2 + var_256_18 and not isNil(var_256_17) then
				if arg_253_1.var_.actorSpriteComps1060 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 2) / var_256_18), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 2) / var_256_18), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 2) / var_256_18)))
							else
								local var_256_19 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 2) / var_256_18)

								iter_256_5.color = Color.New(var_256_19, var_256_19, var_256_19)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 2 + var_256_18 and arg_253_1.time_ < 2 + var_256_18 + arg_256_0 and not isNil(var_256_17) and arg_253_1.var_.actorSpriteComps1060 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1060 = nil
			end

			local var_256_20 = arg_253_1.actors_["1012"]

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= 4 + arg_256_0 and not isNil(var_256_20) and arg_253_1.var_.actorSpriteComps1012 == nil then
				arg_253_1.var_.actorSpriteComps1012 = var_256_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_21 = 0.034

			if 4 <= arg_253_1.time_ and arg_253_1.time_ < 4 + var_256_21 and not isNil(var_256_20) then
				if arg_253_1.var_.actorSpriteComps1012 then
					for iter_256_8, iter_256_9 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_256_9 then
							if arg_253_1.isInRecall_ then
								iter_256_9.color = Color.New(Mathf.Lerp(iter_256_9.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 4) / var_256_21), Mathf.Lerp(iter_256_9.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 4) / var_256_21), (Mathf.Lerp(iter_256_9.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 4) / var_256_21)))
							else
								local var_256_22 = Mathf.Lerp(iter_256_9.color.r, 1, (arg_253_1.time_ - 4) / var_256_21)

								iter_256_9.color = Color.New(var_256_22, var_256_22, var_256_22)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 4 + var_256_21 and arg_253_1.time_ < 4 + var_256_21 + arg_256_0 and not isNil(var_256_20) and arg_253_1.var_.actorSpriteComps1012 then
				for iter_256_10, iter_256_11 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_256_11 then
						iter_256_11.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1012 = nil
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_256_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_25 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_25

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_25
						arg_253_1.bgmTxt2_.text = var_256_25
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_253_1.time_ and arg_253_1.time_ <= 0.266666666666667 + arg_256_0 then
				arg_253_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_256_28 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_28 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_28

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_28
						arg_253_1.bgmTxt2_.text = var_256_28
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_29 = 4
			local var_256_30 = 0.625

			if 4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_29 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_31 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_31:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_253_1.dialogCg_.alpha = arg_259_0
				end))
				var_256_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_32 = arg_253_1:GetWordFromCfg(410091062)
				local var_256_33 = arg_253_1:FormatText(var_256_32.content)

				arg_253_1.text_.text = var_256_33

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_35 = 25 <= 0 and var_256_30 or var_256_30 * (utf8.len(var_256_33) / 25)

				if (25 <= 0 and var_256_30 or var_256_30 * (utf8.len(var_256_33) / 25)) > 0 and var_256_30 < var_256_35 then
					arg_253_1.talkMaxDuration = var_256_35
					var_256_29 = var_256_29 + 0.3

					if var_256_35 + var_256_29 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_35 + var_256_29
					end
				end

				arg_253_1.text_.text = var_256_33
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091062", "story_v_out_410091.awb") ~= 0 then
					local var_256_36 = manager.audio:GetVoiceLength("story_v_out_410091", "410091062", "story_v_out_410091.awb") / 1000

					if var_256_36 + var_256_29 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_36 + var_256_29
					end

					if var_256_32.prefab_name ~= "" and arg_253_1.actors_[var_256_32.prefab_name] ~= nil then
						local var_256_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_32.prefab_name].transform, "story_v_out_410091", "410091062", "story_v_out_410091.awb")

						arg_253_1:RecordAudio("410091062", var_256_37)
						arg_253_1:RecordAudio("410091062", var_256_37)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410091", "410091062", "story_v_out_410091.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410091", "410091062", "story_v_out_410091.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_38 = var_256_29 + 0.3
			local var_256_39 = math.max(var_256_30, arg_253_1.talkMaxDuration)

			if var_256_29 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_38 + var_256_39 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_38) / var_256_39

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_38 + var_256_39 and arg_253_1.time_ < var_256_38 + var_256_39 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play410091063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410091063
		arg_261_1.duration_ = 6.03

		local var_261_0 = {
			zh = 4.9,
			ja = 6.033
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
				arg_261_0:Play410091064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.525

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
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

				local var_264_1 = arg_261_1:GetWordFromCfg(410091063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 21 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 21)

				if (21 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 21)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091063", "story_v_out_410091.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091063", "story_v_out_410091.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_410091", "410091063", "story_v_out_410091.awb")

						arg_261_1:RecordAudio("410091063", var_264_6)
						arg_261_1:RecordAudio("410091063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410091", "410091063", "story_v_out_410091.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410091", "410091063", "story_v_out_410091.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play410091064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410091064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play410091065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1012"]) and arg_265_1.var_.actorSpriteComps1012 == nil then
				arg_265_1.var_.actorSpriteComps1012 = arg_265_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1012"]) then
				if arg_265_1.var_.actorSpriteComps1012 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1012"]) and arg_265_1.var_.actorSpriteComps1012 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps1012 = nil
			end

			local var_268_2 = 0
			local var_268_3 = 1.325

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(410091064).content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 53 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 53)

				if (53 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 53)) > 0 and var_268_3 < var_268_6 then
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
	Play410091065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410091065
		arg_269_1.duration_ = 6.5

		local var_269_0 = {
			zh = 6.4,
			ja = 6.5
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
				arg_269_0:Play410091066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1012 = arg_269_1.actors_["1012"].transform.localPosition
				arg_269_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1012", 3)

				for iter_272_0 = 0, arg_269_1.actors_["1012"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["1012"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_3" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["1012"].transform.localPosition = Vector3.New(0, -465, 300)
			end

			local var_272_2 = arg_269_1.actors_["1012"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1012 == nil then
				arg_269_1.var_.actorSpriteComps1012 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps1012 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1012 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1012 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.525

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(410091065)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 21 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 21)

				if (21 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 21)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091065", "story_v_out_410091.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091065", "story_v_out_410091.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_410091", "410091065", "story_v_out_410091.awb")

						arg_269_1:RecordAudio("410091065", var_272_12)
						arg_269_1:RecordAudio("410091065", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410091", "410091065", "story_v_out_410091.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410091", "410091065", "story_v_out_410091.awb")
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
				actorName = "1012",
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
	Play410091066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410091066
		arg_273_1.duration_ = 13

		local var_273_0 = {
			zh = 6.066,
			ja = 13
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
				arg_273_0:Play410091067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1012 = arg_273_1.actors_["1012"].transform.localPosition
				arg_273_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1012", 2)

				for iter_276_0 = 0, arg_273_1.actors_["1012"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["1012"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_276_2 = arg_273_1.actors_["1060"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1060 = var_276_2.localPosition
				var_276_2.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1060", 4)

				for iter_276_1 = 0, var_276_2.childCount - 1 do
					local var_276_3 = var_276_2:GetChild(iter_276_1)

					if var_276_3.name == "split_3" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_273_1.time_ - 0) / var_276_4)
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_276_5 = arg_273_1.actors_["1012"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps1012 == nil then
				arg_273_1.var_.actorSpriteComps1012 = var_276_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_6 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.actorSpriteComps1012 then
					for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_276_3 then
							if arg_273_1.isInRecall_ then
								iter_276_3.color = Color.New(Mathf.Lerp(iter_276_3.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_6), Mathf.Lerp(iter_276_3.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_6), (Mathf.Lerp(iter_276_3.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_6)))
							else
								local var_276_7 = Mathf.Lerp(iter_276_3.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_6)

								iter_276_3.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps1012 then
				for iter_276_4, iter_276_5 in pairs(arg_273_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_276_5 then
						iter_276_5.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps1012 = nil
			end

			local var_276_8 = arg_273_1.actors_["1060"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.actorSpriteComps1060 == nil then
				arg_273_1.var_.actorSpriteComps1060 = var_276_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_9 and not isNil(var_276_8) then
				if arg_273_1.var_.actorSpriteComps1060 then
					for iter_276_6, iter_276_7 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_276_7 then
							if arg_273_1.isInRecall_ then
								iter_276_7.color = Color.New(Mathf.Lerp(iter_276_7.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_9), Mathf.Lerp(iter_276_7.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_9), (Mathf.Lerp(iter_276_7.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_9)))
							else
								local var_276_10 = Mathf.Lerp(iter_276_7.color.r, 1, (arg_273_1.time_ - 0) / var_276_9)

								iter_276_7.color = Color.New(var_276_10, var_276_10, var_276_10)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_9 and arg_273_1.time_ < 0 + var_276_9 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.actorSpriteComps1060 then
				for iter_276_8, iter_276_9 in pairs(arg_273_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_276_9 then
						iter_276_9.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1060 = nil
			end

			local var_276_11 = 0
			local var_276_12 = 0.85

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_13 = arg_273_1:GetWordFromCfg(410091066)
				local var_276_14 = arg_273_1:FormatText(var_276_13.content)

				arg_273_1.text_.text = var_276_14

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_16 = 34 <= 0 and var_276_12 or var_276_12 * (utf8.len(var_276_14) / 34)

				if (34 <= 0 and var_276_12 or var_276_12 * (utf8.len(var_276_14) / 34)) > 0 and var_276_12 < var_276_16 then
					arg_273_1.talkMaxDuration = var_276_16

					if var_276_16 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_16 + var_276_11
					end
				end

				arg_273_1.text_.text = var_276_14
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091066", "story_v_out_410091.awb") ~= 0 then
					local var_276_17 = manager.audio:GetVoiceLength("story_v_out_410091", "410091066", "story_v_out_410091.awb") / 1000

					if var_276_17 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_17 + var_276_11
					end

					if var_276_13.prefab_name ~= "" and arg_273_1.actors_[var_276_13.prefab_name] ~= nil then
						local var_276_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_13.prefab_name].transform, "story_v_out_410091", "410091066", "story_v_out_410091.awb")

						arg_273_1:RecordAudio("410091066", var_276_18)
						arg_273_1:RecordAudio("410091066", var_276_18)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410091", "410091066", "story_v_out_410091.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410091", "410091066", "story_v_out_410091.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_19 = math.max(var_276_12, arg_273_1.talkMaxDuration)

			if var_276_11 <= arg_273_1.time_ and arg_273_1.time_ < var_276_11 + var_276_19 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_11) / var_276_19

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_11 + var_276_19 and arg_273_1.time_ < var_276_11 + var_276_19 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play410091067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410091067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play410091068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1060"]) and arg_277_1.var_.actorSpriteComps1060 == nil then
				arg_277_1.var_.actorSpriteComps1060 = arg_277_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1060"]) then
				if arg_277_1.var_.actorSpriteComps1060 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1060"]) and arg_277_1.var_.actorSpriteComps1060 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps1060 = nil
			end

			local var_280_2 = 0
			local var_280_3 = 1.05

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(410091067).content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_6 = 42 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_4) / 42)

				if (42 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_4) / 42)) > 0 and var_280_3 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_7 and arg_277_1.time_ < var_280_2 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play410091068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410091068
		arg_281_1.duration_ = 9.53

		local var_281_0 = {
			zh = 4.933,
			ja = 9.533
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
				arg_281_0:Play410091069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1012 = arg_281_1.actors_["1012"].transform.localPosition
				arg_281_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1012", 2)

				for iter_284_0 = 0, arg_281_1.actors_["1012"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["1012"].transform:GetChild(iter_284_0)

					if var_284_0.name == "" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_284_2 = arg_281_1.actors_["1012"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1012 == nil then
				arg_281_1.var_.actorSpriteComps1012 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1012 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1012 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1012 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.6

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(410091068)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 24 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 24)

				if (24 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 24)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091068", "story_v_out_410091.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_410091", "410091068", "story_v_out_410091.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_410091", "410091068", "story_v_out_410091.awb")

						arg_281_1:RecordAudio("410091068", var_284_12)
						arg_281_1:RecordAudio("410091068", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410091", "410091068", "story_v_out_410091.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410091", "410091068", "story_v_out_410091.awb")
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
				actorName = "1012",
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
	Play410091069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410091069
		arg_285_1.duration_ = 4.27

		local var_285_0 = {
			zh = 1.833,
			ja = 4.266
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
				arg_285_0:Play410091070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1060 = arg_285_1.actors_["1060"].transform.localPosition
				arg_285_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1060", 4)

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
				arg_285_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["1060"].transform.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_288_2 = arg_285_1.actors_["1060"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1060 == nil then
				arg_285_1.var_.actorSpriteComps1060 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps1060 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps1060 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1060 = nil
			end

			local var_288_5 = arg_285_1.actors_["1012"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1012 == nil then
				arg_285_1.var_.actorSpriteComps1012 = var_288_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_6 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.actorSpriteComps1012 then
					for iter_288_5, iter_288_6 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.actorSpriteComps1012 then
				for iter_288_7, iter_288_8 in pairs(arg_285_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_288_8 then
						iter_288_8.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1012 = nil
			end

			local var_288_8 = 0
			local var_288_9 = 0.15

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
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

				local var_288_10 = arg_285_1:GetWordFromCfg(410091069)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 6 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 6)

				if (6 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 6)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091069", "story_v_out_410091.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091069", "story_v_out_410091.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_410091", "410091069", "story_v_out_410091.awb")

						arg_285_1:RecordAudio("410091069", var_288_15)
						arg_285_1:RecordAudio("410091069", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410091", "410091069", "story_v_out_410091.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410091", "410091069", "story_v_out_410091.awb")
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
				actorName = "1060",
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
	Play410091070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410091070
		arg_289_1.duration_ = 3.1

		local var_289_0 = {
			zh = 1,
			ja = 3.1
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
				arg_289_0:Play410091071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1012 = arg_289_1.actors_["1012"].transform.localPosition
				arg_289_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1012", 2)

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
				arg_289_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
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
			local var_292_9 = 0.1

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

				local var_292_10 = arg_289_1:GetWordFromCfg(410091070)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 4 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 4)

				if (4 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 4)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091070", "story_v_out_410091.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_out_410091", "410091070", "story_v_out_410091.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_out_410091", "410091070", "story_v_out_410091.awb")

						arg_289_1:RecordAudio("410091070", var_292_15)
						arg_289_1:RecordAudio("410091070", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410091", "410091070", "story_v_out_410091.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410091", "410091070", "story_v_out_410091.awb")
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
	Play410091071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410091071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play410091072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1012 = arg_293_1.actors_["1012"].transform.localPosition
				arg_293_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1012", 7)

				for iter_296_0 = 0, arg_293_1.actors_["1012"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1012"].transform:GetChild(iter_296_0)

					if var_296_0.name == "" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_296_2 = arg_293_1.actors_["1060"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1060 = var_296_2.localPosition
				var_296_2.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1060", 7)

				for iter_296_1 = 0, var_296_2.childCount - 1 do
					local var_296_3 = var_296_2:GetChild(iter_296_1)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_2.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_293_1.time_ - 0) / var_296_4)
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_296_5 = arg_293_1.actors_["1012"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1012 == nil then
				arg_293_1.var_.actorSpriteComps1012 = var_296_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_6 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_6 and not isNil(var_296_5) then
				if arg_293_1.var_.actorSpriteComps1012 then
					for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_296_3 then
							if arg_293_1.isInRecall_ then
								iter_296_3.color = Color.New(Mathf.Lerp(iter_296_3.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_6), Mathf.Lerp(iter_296_3.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_6), (Mathf.Lerp(iter_296_3.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_6)))
							else
								local var_296_7 = Mathf.Lerp(iter_296_3.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_6)

								iter_296_3.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_6 and arg_293_1.time_ < 0 + var_296_6 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.actorSpriteComps1012 then
				for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_296_5 then
						iter_296_5.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps1012 = nil
			end

			local var_296_8 = arg_293_1.actors_["1060"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps1060 == nil then
				arg_293_1.var_.actorSpriteComps1060 = var_296_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_9 and not isNil(var_296_8) then
				if arg_293_1.var_.actorSpriteComps1060 then
					for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_296_7 then
							if arg_293_1.isInRecall_ then
								iter_296_7.color = Color.New(Mathf.Lerp(iter_296_7.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_9), Mathf.Lerp(iter_296_7.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_9), (Mathf.Lerp(iter_296_7.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_9)))
							else
								local var_296_10 = Mathf.Lerp(iter_296_7.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_9)

								iter_296_7.color = Color.New(var_296_10, var_296_10, var_296_10)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_9 and arg_293_1.time_ < 0 + var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps1060 then
				for iter_296_8, iter_296_9 in pairs(arg_293_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_296_9 then
						iter_296_9.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps1060 = nil
			end

			local var_296_11 = 0
			local var_296_12 = 1.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_13 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(410091071).content)

				arg_293_1.text_.text = var_296_13

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_15 = 49 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_13) / 49)

				if (49 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_13) / 49)) > 0 and var_296_12 < var_296_15 then
					arg_293_1.talkMaxDuration = var_296_15

					if var_296_15 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_13
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 <= arg_293_1.time_ and arg_293_1.time_ < var_296_11 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_11) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_11 + var_296_16 and arg_293_1.time_ < var_296_11 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play410091072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410091072
		arg_297_1.duration_ = 7.2

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410091073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_0 = 2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				local var_300_1 = Color.New(0, 0, 0)

				var_300_1.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.mask_.color = var_300_1
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				local var_300_2 = Color.New(0, 0, 0)

				var_300_2.a = 1
				arg_297_1.mask_.color = var_300_2
			end

			local var_300_3 = 2

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_4 = 2

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_4 then
				local var_300_5 = Color.New(0, 0, 0)

				var_300_5.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_3) / var_300_4)
				arg_297_1.mask_.color = var_300_5
			end

			if arg_297_1.time_ >= var_300_3 + var_300_4 and arg_297_1.time_ < var_300_3 + var_300_4 + arg_300_0 then
				local var_300_6 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_6.a = 0
				arg_297_1.mask_.color = var_300_6
			end

			local var_300_7 = "LZ0105"

			if arg_297_1.bgs_.LZ0105 == nil then
				local var_300_8 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_7)
				var_300_8.name = var_300_7
				var_300_8.transform.parent = arg_297_1.stage_.transform
				var_300_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_7] = var_300_8
			end

			local var_300_9 = arg_297_1.bgs_.LZ0105.transform

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				arg_297_1.var_.moveOldPosLZ0105 = var_300_9.localPosition
			end

			local var_300_10 = 0.001

			if 2 <= arg_297_1.time_ and arg_297_1.time_ < 2 + var_300_10 then
				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPosLZ0105, Vector3.New(0, 1, 8), (arg_297_1.time_ - 2) / var_300_10)
			end

			if arg_297_1.time_ >= 2 + var_300_10 and arg_297_1.time_ < 2 + var_300_10 + arg_300_0 then
				var_300_9.localPosition = Vector3.New(0, 1, 8)
			end

			local var_300_11 = arg_297_1.bgs_.LZ0105.transform

			if 2.034 < arg_297_1.time_ and arg_297_1.time_ <= 2.034 + arg_300_0 then
				arg_297_1.var_.moveOldPosLZ0105 = var_300_11.localPosition
			end

			local var_300_12 = 4

			if 2.034 <= arg_297_1.time_ and arg_297_1.time_ < 2.034 + var_300_12 then
				var_300_11.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPosLZ0105, Vector3.New(0, 1, 10), (arg_297_1.time_ - 2.034) / var_300_12)
			end

			if arg_297_1.time_ >= 2.034 + var_300_12 and arg_297_1.time_ < 2.034 + var_300_12 + arg_300_0 then
				var_300_11.localPosition = Vector3.New(0, 1, 10)
			end

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				local var_300_13 = arg_297_1.bgs_.LZ0105

				arg_297_1.bgs_.LZ0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_14 = var_300_13:GetComponent("SpriteRenderer")

				if var_300_14 and var_300_14.sprite then
					local var_300_15 = 2 * (var_300_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_13.transform.localScale = Vector3.New(var_300_15 / var_300_14.sprite.bounds.size.y < var_300_15 * manager.ui.mainCameraCom_.aspect / var_300_14.sprite.bounds.size.x and var_300_15 * manager.ui.mainCameraCom_.aspect / var_300_14.sprite.bounds.size.x or var_300_15 / var_300_14.sprite.bounds.size.y, var_300_15 / var_300_14.sprite.bounds.size.y < var_300_15 * manager.ui.mainCameraCom_.aspect / var_300_14.sprite.bounds.size.x and var_300_15 * manager.ui.mainCameraCom_.aspect / var_300_14.sprite.bounds.size.x or var_300_15 / var_300_14.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "LZ0105" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_16 = 2

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= var_300_16 + 3.63333333333333 and arg_297_1.time_ < var_300_16 + 3.63333333333333 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_17 = 4
			local var_300_18 = 0.075

			if 4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_17 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_19 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_19:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_20 = arg_297_1:GetWordFromCfg(410091072)
				local var_300_21 = arg_297_1:FormatText(var_300_20.content)

				arg_297_1.text_.text = var_300_21

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_23 = 3 <= 0 and var_300_18 or var_300_18 * (utf8.len(var_300_21) / 3)

				if (3 <= 0 and var_300_18 or var_300_18 * (utf8.len(var_300_21) / 3)) > 0 and var_300_18 < var_300_23 then
					arg_297_1.talkMaxDuration = var_300_23
					var_300_17 = var_300_17 + 0.3

					if var_300_23 + var_300_17 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_17
					end
				end

				arg_297_1.text_.text = var_300_21
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091072", "story_v_out_410091.awb") ~= 0 then
					local var_300_24 = manager.audio:GetVoiceLength("story_v_out_410091", "410091072", "story_v_out_410091.awb") / 1000

					if var_300_24 + var_300_17 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_17
					end

					if var_300_20.prefab_name ~= "" and arg_297_1.actors_[var_300_20.prefab_name] ~= nil then
						local var_300_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_20.prefab_name].transform, "story_v_out_410091", "410091072", "story_v_out_410091.awb")

						arg_297_1:RecordAudio("410091072", var_300_25)
						arg_297_1:RecordAudio("410091072", var_300_25)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410091", "410091072", "story_v_out_410091.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410091", "410091072", "story_v_out_410091.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_26 = var_300_17 + 0.3
			local var_300_27 = math.max(var_300_18, arg_297_1.talkMaxDuration)

			if var_300_17 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_26 + var_300_27 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_26) / var_300_27

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_26 + var_300_27 and arg_297_1.time_ < var_300_26 + var_300_27 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LZ0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LZ0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play410091073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 410091073
		arg_303_1.duration_ = 9.4

		local var_303_0 = {
			zh = 6.133,
			ja = 9.4
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play410091074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.7

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(410091073)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 28 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 28)

				if (28 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 28)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091073", "story_v_out_410091.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091073", "story_v_out_410091.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_410091", "410091073", "story_v_out_410091.awb")

						arg_303_1:RecordAudio("410091073", var_306_6)
						arg_303_1:RecordAudio("410091073", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_410091", "410091073", "story_v_out_410091.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_410091", "410091073", "story_v_out_410091.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play410091074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 410091074
		arg_307_1.duration_ = 8.23

		local var_307_0 = {
			zh = 5.466,
			ja = 8.233
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
				arg_307_0:Play410091075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.775

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(410091074)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 31 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 31)

				if (31 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 31)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091074", "story_v_out_410091.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091074", "story_v_out_410091.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_410091", "410091074", "story_v_out_410091.awb")

						arg_307_1:RecordAudio("410091074", var_310_6)
						arg_307_1:RecordAudio("410091074", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_410091", "410091074", "story_v_out_410091.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_410091", "410091074", "story_v_out_410091.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play410091075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 410091075
		arg_311_1.duration_ = 6.83

		local var_311_0 = {
			zh = 4.133,
			ja = 6.833
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
				arg_311_0:Play410091076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.65

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(410091075)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 26 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 26)

				if (26 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 26)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091075", "story_v_out_410091.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091075", "story_v_out_410091.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_410091", "410091075", "story_v_out_410091.awb")

						arg_311_1:RecordAudio("410091075", var_314_6)
						arg_311_1:RecordAudio("410091075", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_410091", "410091075", "story_v_out_410091.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_410091", "410091075", "story_v_out_410091.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play410091076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 410091076
		arg_315_1.duration_ = 17.1

		local var_315_0 = {
			zh = 10.933,
			ja = 17.1
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
				arg_315_0:Play410091077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 1.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(410091076)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 56 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 56)

				if (56 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 56)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091076", "story_v_out_410091.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091076", "story_v_out_410091.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_410091", "410091076", "story_v_out_410091.awb")

						arg_315_1:RecordAudio("410091076", var_318_6)
						arg_315_1:RecordAudio("410091076", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_410091", "410091076", "story_v_out_410091.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_410091", "410091076", "story_v_out_410091.awb")
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
	Play410091077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 410091077
		arg_319_1.duration_ = 12.2

		local var_319_0 = {
			zh = 8.766,
			ja = 12.2
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
				arg_319_0:Play410091078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:GetWordFromCfg(410091077)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 40 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 40)

				if (40 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 40)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091077", "story_v_out_410091.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091077", "story_v_out_410091.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_410091", "410091077", "story_v_out_410091.awb")

						arg_319_1:RecordAudio("410091077", var_322_6)
						arg_319_1:RecordAudio("410091077", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_410091", "410091077", "story_v_out_410091.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_410091", "410091077", "story_v_out_410091.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play410091078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 410091078
		arg_323_1.duration_ = 3.67

		local var_323_0 = {
			zh = 3.533,
			ja = 3.666
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
				arg_323_0:Play410091079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.4

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:GetWordFromCfg(410091078)
				local var_326_2 = arg_323_1:FormatText(var_326_1.content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 16 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 16)

				if (16 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_2) / 16)) > 0 and var_326_0 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + 0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091078", "story_v_out_410091.awb") ~= 0 then
					local var_326_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091078", "story_v_out_410091.awb") / 1000

					if var_326_5 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + 0
					end

					if var_326_1.prefab_name ~= "" and arg_323_1.actors_[var_326_1.prefab_name] ~= nil then
						local var_326_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_1.prefab_name].transform, "story_v_out_410091", "410091078", "story_v_out_410091.awb")

						arg_323_1:RecordAudio("410091078", var_326_6)
						arg_323_1:RecordAudio("410091078", var_326_6)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_410091", "410091078", "story_v_out_410091.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_410091", "410091078", "story_v_out_410091.awb")
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
	Play410091079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 410091079
		arg_327_1.duration_ = 8.87

		local var_327_0 = {
			zh = 6.433,
			ja = 8.866
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
				arg_327_0:Play410091080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.8

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(410091079)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 32 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 32)

				if (32 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 32)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091079", "story_v_out_410091.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091079", "story_v_out_410091.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_410091", "410091079", "story_v_out_410091.awb")

						arg_327_1:RecordAudio("410091079", var_330_6)
						arg_327_1:RecordAudio("410091079", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_410091", "410091079", "story_v_out_410091.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_410091", "410091079", "story_v_out_410091.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play410091080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 410091080
		arg_331_1.duration_ = 12.53

		local var_331_0 = {
			zh = 8.9,
			ja = 12.533
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
				arg_331_0:Play410091081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.075

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(410091080)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 43 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 43)

				if (43 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 43)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091080", "story_v_out_410091.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091080", "story_v_out_410091.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_410091", "410091080", "story_v_out_410091.awb")

						arg_331_1:RecordAudio("410091080", var_334_6)
						arg_331_1:RecordAudio("410091080", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_410091", "410091080", "story_v_out_410091.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_410091", "410091080", "story_v_out_410091.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play410091081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 410091081
		arg_335_1.duration_ = 16.17

		local var_335_0 = {
			zh = 7.833,
			ja = 16.166
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play410091082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.875

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:GetWordFromCfg(410091081)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 35 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 35)

				if (35 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 35)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091081", "story_v_out_410091.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091081", "story_v_out_410091.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_410091", "410091081", "story_v_out_410091.awb")

						arg_335_1:RecordAudio("410091081", var_338_6)
						arg_335_1:RecordAudio("410091081", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_410091", "410091081", "story_v_out_410091.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_410091", "410091081", "story_v_out_410091.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play410091082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 410091082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play410091083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 1.25

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(410091082).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 50 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 50)

				if (50 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 50)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play410091083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 410091083
		arg_343_1.duration_ = 2.9

		local var_343_0 = {
			zh = 2.9,
			ja = 1.8
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
				arg_343_0:Play410091084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.25

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(410091083)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 10 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 10)

				if (10 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 10)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091083", "story_v_out_410091.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091083", "story_v_out_410091.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_410091", "410091083", "story_v_out_410091.awb")

						arg_343_1:RecordAudio("410091083", var_346_6)
						arg_343_1:RecordAudio("410091083", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_410091", "410091083", "story_v_out_410091.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_410091", "410091083", "story_v_out_410091.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play410091084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 410091084
		arg_347_1.duration_ = 7.73

		local var_347_0 = {
			zh = 3,
			ja = 7.733
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
				arg_347_0:Play410091085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.3

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(410091084)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)

				if (12 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 12)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091084", "story_v_out_410091.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091084", "story_v_out_410091.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_410091", "410091084", "story_v_out_410091.awb")

						arg_347_1:RecordAudio("410091084", var_350_6)
						arg_347_1:RecordAudio("410091084", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_410091", "410091084", "story_v_out_410091.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_410091", "410091084", "story_v_out_410091.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play410091085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 410091085
		arg_351_1.duration_ = 7.33

		local var_351_0 = {
			zh = 6.266,
			ja = 7.333
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play410091086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.625

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(410091085)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 25 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 25)

				if (25 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 25)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091085", "story_v_out_410091.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091085", "story_v_out_410091.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_410091", "410091085", "story_v_out_410091.awb")

						arg_351_1:RecordAudio("410091085", var_354_6)
						arg_351_1:RecordAudio("410091085", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_410091", "410091085", "story_v_out_410091.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_410091", "410091085", "story_v_out_410091.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play410091086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 410091086
		arg_355_1.duration_ = 3.03

		local var_355_0 = {
			zh = 2.833,
			ja = 3.033
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play410091087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.325

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:GetWordFromCfg(410091086)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 13)

				if (13 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 13)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091086", "story_v_out_410091.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091086", "story_v_out_410091.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_410091", "410091086", "story_v_out_410091.awb")

						arg_355_1:RecordAudio("410091086", var_358_6)
						arg_355_1:RecordAudio("410091086", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_410091", "410091086", "story_v_out_410091.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_410091", "410091086", "story_v_out_410091.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play410091087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 410091087
		arg_359_1.duration_ = 10.17

		local var_359_0 = {
			zh = 7,
			ja = 10.166
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
				arg_359_0:Play410091088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.775

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(410091087)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 31 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 31)

				if (31 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 31)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091087", "story_v_out_410091.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091087", "story_v_out_410091.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_410091", "410091087", "story_v_out_410091.awb")

						arg_359_1:RecordAudio("410091087", var_362_6)
						arg_359_1:RecordAudio("410091087", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_410091", "410091087", "story_v_out_410091.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_410091", "410091087", "story_v_out_410091.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play410091088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 410091088
		arg_363_1.duration_ = 15.13

		local var_363_0 = {
			zh = 9.766,
			ja = 15.133
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play410091089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.2

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:GetWordFromCfg(410091088)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 48 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 48)

				if (48 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 48)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091088", "story_v_out_410091.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091088", "story_v_out_410091.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_410091", "410091088", "story_v_out_410091.awb")

						arg_363_1:RecordAudio("410091088", var_366_6)
						arg_363_1:RecordAudio("410091088", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_410091", "410091088", "story_v_out_410091.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_410091", "410091088", "story_v_out_410091.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play410091089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 410091089
		arg_367_1.duration_ = 10.63

		local var_367_0 = {
			zh = 8.966,
			ja = 10.633
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
			arg_367_1.auto_ = false
		end

		function arg_367_1.playNext_(arg_369_0)
			arg_367_1.onStoryFinished_()
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.85

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(410091089)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 34 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 34)

				if (34 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 34)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410091", "410091089", "story_v_out_410091.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_410091", "410091089", "story_v_out_410091.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_410091", "410091089", "story_v_out_410091.awb")

						arg_367_1:RecordAudio("410091089", var_370_6)
						arg_367_1:RecordAudio("410091089", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_410091", "410091089", "story_v_out_410091.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_410091", "410091089", "story_v_out_410091.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/LZ0105"
	},
	voices = {
		"story_v_out_410091.awb"
	}
}
