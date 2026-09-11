return {
	Play424121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424121001
		arg_1_1.duration_ = 5.63

		local var_1_0 = {
			zh = 5.532999999999,
			ja = 5.632999999999
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
				arg_1_0:Play424121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0116a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116a")
				var_4_0.name = "ST0116a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0116a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0116a

				arg_1_1.bgs_.ST0116a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0116a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1194"

			if arg_1_1.actors_["1194"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

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

			local var_4_12 = arg_1_1.actors_["1194"]

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1194 == nil then
				arg_1_1.var_.actorSpriteComps1194 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.999999999999 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1194 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.999999999999) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.999999999999) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.999999999999) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.999999999999) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.999999999999 + var_4_13 and arg_1_1.time_ < 1.999999999999 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1194 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1194 = nil
			end

			local var_4_15 = arg_1_1.actors_["1194"].transform

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1.var_.moveOldPos1194 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1194", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_4" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.999999999999 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1194, Vector3.New(-60, -360, -240), (arg_1_1.time_ - 1.999999999999) / var_4_17)
			end

			if arg_1_1.time_ >= 1.999999999999 + var_4_17 and arg_1_1.time_ < 1.999999999999 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-60, -360, -240)
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1194"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1194 = var_4_18.alpha
					arg_1_1.var_.characterEffect1194 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1194 = 0
			end

			local var_4_19 = 0.5

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_19 then
				if arg_1_1.var_.characterEffect1194 then
					arg_1_1.var_.characterEffect1194.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1194, 1, (arg_1_1.time_ - 2) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1194 then
				arg_1_1.var_.characterEffect1194.alpha = 1
			end

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_sad_1", "bgm_story_sad_1", "bgm_story_sad_1.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_story_sad_1", "bgm_story_sad_1")

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

			local var_4_27 = 1.999999999999
			local var_4_28 = 0.225

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(424121001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 9 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 9)

				if (9 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 9)) > 0 and var_4_28 < var_4_33 then
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

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121001", "story_v_out_424121.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_424121", "424121001", "story_v_out_424121.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_424121", "424121001", "story_v_out_424121.awb")

						arg_1_1:RecordAudio("424121001", var_4_35)
						arg_1_1:RecordAudio("424121001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424121", "424121001", "story_v_out_424121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424121", "424121001", "story_v_out_424121.awb")
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
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play424121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1194"]) and arg_9_1.var_.actorSpriteComps1194 == nil then
				arg_9_1.var_.actorSpriteComps1194 = arg_9_1.actors_["1194"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1194"]) then
				if arg_9_1.var_.actorSpriteComps1194 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1194:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1194"]) and arg_9_1.var_.actorSpriteComps1194 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1194 = nil
			end

			local var_12_2 = arg_9_1.actors_["1194"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1194 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1194", 7)

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
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1194, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_9_1.time_ and arg_9_1.time_ <= 0.034 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_146", "se_story_146_umbrella01", "")
			end

			local var_12_6 = 0
			local var_12_7 = 1.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_8 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(424121002).content)

				arg_9_1.text_.text = var_12_8

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 68 <= 0 and var_12_7 or var_12_7 * (utf8.len(var_12_8) / 68)

				if (68 <= 0 and var_12_7 or var_12_7 * (utf8.len(var_12_8) / 68)) > 0 and var_12_7 < var_12_10 then
					arg_9_1.talkMaxDuration = var_12_10

					if var_12_10 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_8
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_11 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_11 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_11

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_11 and arg_9_1.time_ < var_12_6 + var_12_11 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play424121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(424121003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 50 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 50)

				if (50 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 50)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play424121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424121004
		arg_17_1.duration_ = 13.73

		local var_17_0 = {
			zh = 5.133,
			ja = 13.733
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
				arg_17_0:Play424121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10155"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "10155"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["10155"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["10155"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10155 == nil then
				arg_17_1.var_.actorSpriteComps10155 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10155 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								iter_20_3.color = Color.New(Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_3.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_3.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10155 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10155 = nil
			end

			local var_20_5 = arg_17_1.actors_["10155"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10155 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10155", 3)

				for iter_20_6 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_6)

					if var_20_6.name == "split_1" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-40, -390, -250)
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.actors_["10155"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_8 then
					arg_17_1.var_.alphaOldValue10155 = var_20_8.alpha
					arg_17_1.var_.characterEffect10155 = var_20_8
				end

				arg_17_1.var_.alphaOldValue10155 = 0
			end

			local var_20_9 = 0.5

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.characterEffect10155 then
					arg_17_1.var_.characterEffect10155.alpha = Mathf.Lerp(arg_17_1.var_.alphaOldValue10155, 1, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.characterEffect10155 then
				arg_17_1.var_.characterEffect10155.alpha = 1
			end

			local var_20_10 = 0
			local var_20_11 = 0.4

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_12 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_12:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(424121004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 16 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_14) / 16)

				if (16 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_14) / 16)) > 0 and var_20_11 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16
					var_20_10 = var_20_10 + 0.3

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121004", "story_v_out_424121.awb") ~= 0 then
					local var_20_17 = manager.audio:GetVoiceLength("story_v_out_424121", "424121004", "story_v_out_424121.awb") / 1000

					if var_20_17 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_10
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_424121", "424121004", "story_v_out_424121.awb")

						arg_17_1:RecordAudio("424121004", var_20_18)
						arg_17_1:RecordAudio("424121004", var_20_18)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424121", "424121004", "story_v_out_424121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424121", "424121004", "story_v_out_424121.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = var_20_10 + 0.3
			local var_20_20 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play424121005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 424121005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play424121006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["10155"]) and arg_23_1.var_.actorSpriteComps10155 == nil then
				arg_23_1.var_.actorSpriteComps10155 = arg_23_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["10155"]) then
				if arg_23_1.var_.actorSpriteComps10155 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								iter_26_1.color = Color.New(Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_0), Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_0), (Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_0)))
							else
								local var_26_1 = Mathf.Lerp(iter_26_1.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_0)

								iter_26_1.color = Color.New(var_26_1, var_26_1, var_26_1)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["10155"]) and arg_23_1.var_.actorSpriteComps10155 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps10155 = nil
			end

			local var_26_2 = 0
			local var_26_3 = 0.75

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_4 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(424121005).content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_6 = 30 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 30)

				if (30 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 30)) > 0 and var_26_3 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_7 and arg_23_1.time_ < var_26_2 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play424121006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424121006
		arg_27_1.duration_ = 6.53

		local var_27_0 = {
			zh = 2.133,
			ja = 6.533
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
				arg_27_0:Play424121007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1194"]) and arg_27_1.var_.actorSpriteComps1194 == nil then
				arg_27_1.var_.actorSpriteComps1194 = arg_27_1.actors_["1194"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1194"]) then
				if arg_27_1.var_.actorSpriteComps1194 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1194:ToTable()) do
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

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1194"]) and arg_27_1.var_.actorSpriteComps1194 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1194 = nil
			end

			local var_30_2 = arg_27_1.actors_["1194"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1194 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1194", 4)

				for iter_30_4 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_4)

					if var_30_3.name == "split_4" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1194, Vector3.New(395, -360, -240), (arg_27_1.time_ - 0) / var_30_4)
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(395, -360, -240)
			end

			local var_30_5 = arg_27_1.actors_["10155"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10155 = var_30_5.localPosition
				var_30_5.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10155", 2)

				for iter_30_5 = 0, var_30_5.childCount - 1 do
					local var_30_6 = var_30_5:GetChild(iter_30_5)

					if var_30_6.name == "split_1" or not string.find(var_30_6.name, "split") then
						var_30_6.gameObject:SetActive(true)
					else
						var_30_6.gameObject:SetActive(false)
					end
				end
			end

			local var_30_7 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_27_1.time_ - 0) / var_30_7)
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_30_8 = 0
			local var_30_9 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(424121006)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 10 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 10)

				if (10 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 10)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121006", "story_v_out_424121.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121006", "story_v_out_424121.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_424121", "424121006", "story_v_out_424121.awb")

						arg_27_1:RecordAudio("424121006", var_30_15)
						arg_27_1:RecordAudio("424121006", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_424121", "424121006", "story_v_out_424121.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_424121", "424121006", "story_v_out_424121.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
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

		arg_27_1:InitPlayNodeList()
	end,
	Play424121007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424121007
		arg_31_1.duration_ = 3.63

		local var_31_0 = {
			zh = 1.4,
			ja = 3.633
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play424121008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["10155"]) and arg_31_1.var_.actorSpriteComps10155 == nil then
				arg_31_1.var_.actorSpriteComps10155 = arg_31_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["10155"]) then
				if arg_31_1.var_.actorSpriteComps10155 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 1, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["10155"]) and arg_31_1.var_.actorSpriteComps10155 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps10155 = nil
			end

			local var_34_2 = arg_31_1.actors_["1194"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1194 == nil then
				arg_31_1.var_.actorSpriteComps1194 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps1194 then
					for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_34_5 then
							if arg_31_1.isInRecall_ then
								iter_34_5.color = Color.New(Mathf.Lerp(iter_34_5.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_5.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_5.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_5.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_5.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1194 then
				for iter_34_6, iter_34_7 in pairs(arg_31_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_34_7 then
						iter_34_7.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps1194 = nil
			end

			local var_34_5 = arg_31_1.actors_["10155"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10155 = var_34_5.localPosition
				var_34_5.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10155", 2)

				for iter_34_8 = 0, var_34_5.childCount - 1 do
					local var_34_6 = var_34_5:GetChild(iter_34_8)

					if var_34_6.name == "split_4" then
						var_34_6:SetAsLastSibling()
						var_34_6.gameObject:SetActive(true)

						arg_31_1.var_.actorSpriteSplit10155 = var_34_6.gameObject:GetComponent(typeof(Image))

						arg_31_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_34_7 = 0.5

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				var_34_5.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_31_1.time_ - 0) / var_34_7)

				if arg_31_1.var_.actorSpriteSplit10155 ~= nil then
					arg_31_1.var_.actorSpriteSplit10155:SetAlpha((arg_31_1.time_ - 0) / var_34_7)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				var_34_5.localPosition = Vector3.New(-410, -390, -250)

				if arg_31_1.var_.actorSpriteSplit10155 ~= nil then
					arg_31_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_34_8 = 0
			local var_34_9 = 0.125

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(424121007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 5 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 5)

				if (5 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 5)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121007", "story_v_out_424121.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121007", "story_v_out_424121.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_424121", "424121007", "story_v_out_424121.awb")

						arg_31_1:RecordAudio("424121007", var_34_15)
						arg_31_1:RecordAudio("424121007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_424121", "424121007", "story_v_out_424121.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_424121", "424121007", "story_v_out_424121.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play424121008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424121008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play424121009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["10155"]) and arg_35_1.var_.actorSpriteComps10155 == nil then
				arg_35_1.var_.actorSpriteComps10155 = arg_35_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["10155"]) then
				if arg_35_1.var_.actorSpriteComps10155 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["10155"]) and arg_35_1.var_.actorSpriteComps10155 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps10155 = nil
			end

			local var_38_2 = arg_35_1.actors_["10155"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10155 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10155", 7)

				for iter_38_4 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_4)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_35_1.time_ - 0) / var_38_4)
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_38_5 = arg_35_1.actors_["1194"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1194 = var_38_5.localPosition
				var_38_5.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1194", 7)

				for iter_38_5 = 0, var_38_5.childCount - 1 do
					local var_38_6 = var_38_5:GetChild(iter_38_5)

					if var_38_6.name == "" or not string.find(var_38_6.name, "split") then
						var_38_6.gameObject:SetActive(true)
					else
						var_38_6.gameObject:SetActive(false)
					end
				end
			end

			local var_38_7 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1194, Vector3.New(0, -2000, 0), (arg_35_1.time_ - 0) / var_38_7)
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_35_1.time_ and arg_35_1.time_ <= 0.034 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_145", "se_story_145_footstep", "")
			end

			local var_38_9 = 0
			local var_38_10 = 0.95

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_11 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(424121008).content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 38 <= 0 and var_38_10 or var_38_10 * (utf8.len(var_38_11) / 38)

				if (38 <= 0 and var_38_10 or var_38_10 * (utf8.len(var_38_11) / 38)) > 0 and var_38_10 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_9 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_9
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_10, arg_35_1.talkMaxDuration)

			if var_38_9 <= arg_35_1.time_ and arg_35_1.time_ < var_38_9 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_9) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_9 + var_38_14 and arg_35_1.time_ < var_38_9 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_35_1:InitPlayNodeList()
	end,
	Play424121009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424121009
		arg_39_1.duration_ = 7.8

		local var_39_0 = {
			zh = 6.3,
			ja = 7.8
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424121010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["10154"] == nil then
				local var_42_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_42_0) then
					local var_42_1 = Object.Instantiate(var_42_0, arg_39_1.canvasGo_.transform)

					var_42_1.transform:SetSiblingIndex(1)

					var_42_1.name = "10154"
					var_42_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_["10154"] = var_42_1

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs((var_42_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_2 = arg_39_1.actors_["10154"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10154 == nil then
				arg_39_1.var_.actorSpriteComps10154 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps10154 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_3.color.r, 1, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_3.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps10154 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps10154 = nil
			end

			local var_42_5 = arg_39_1.actors_["10154"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10154 = var_42_5.localPosition
				var_42_5.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10154", 3)

				for iter_42_6 = 0, var_42_5.childCount - 1 do
					local var_42_6 = var_42_5:GetChild(iter_42_6)

					if var_42_6.name == "split_5" or not string.find(var_42_6.name, "split") then
						var_42_6.gameObject:SetActive(true)
					else
						var_42_6.gameObject:SetActive(false)
					end
				end
			end

			local var_42_7 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				var_42_5.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_39_1.time_ - 0) / var_42_7)
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				var_42_5.localPosition = Vector3.New(-20, -338, -538)
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_8 = arg_39_1.actors_["10154"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_42_8 then
					arg_39_1.var_.alphaOldValue10154 = var_42_8.alpha
					arg_39_1.var_.characterEffect10154 = var_42_8
				end

				arg_39_1.var_.alphaOldValue10154 = 0
			end

			local var_42_9 = 0.5

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 then
				if arg_39_1.var_.characterEffect10154 then
					arg_39_1.var_.characterEffect10154.alpha = Mathf.Lerp(arg_39_1.var_.alphaOldValue10154, 1, (arg_39_1.time_ - 0) / var_42_9)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 and arg_39_1.var_.characterEffect10154 then
				arg_39_1.var_.characterEffect10154.alpha = 1
			end

			local var_42_10 = 0
			local var_42_11 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_12 = arg_39_1:GetWordFromCfg(424121009)
				local var_42_13 = arg_39_1:FormatText(var_42_12.content)

				arg_39_1.text_.text = var_42_13

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_15 = 26 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 26)

				if (26 <= 0 and var_42_11 or var_42_11 * (utf8.len(var_42_13) / 26)) > 0 and var_42_11 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_10
					end
				end

				arg_39_1.text_.text = var_42_13
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121009", "story_v_out_424121.awb") ~= 0 then
					local var_42_16 = manager.audio:GetVoiceLength("story_v_out_424121", "424121009", "story_v_out_424121.awb") / 1000

					if var_42_16 + var_42_10 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_10
					end

					if var_42_12.prefab_name ~= "" and arg_39_1.actors_[var_42_12.prefab_name] ~= nil then
						local var_42_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_12.prefab_name].transform, "story_v_out_424121", "424121009", "story_v_out_424121.awb")

						arg_39_1:RecordAudio("424121009", var_42_17)
						arg_39_1:RecordAudio("424121009", var_42_17)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_424121", "424121009", "story_v_out_424121.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_424121", "424121009", "story_v_out_424121.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = math.max(var_42_11, arg_39_1.talkMaxDuration)

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_18 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_10) / var_42_18

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_10 + var_42_18 and arg_39_1.time_ < var_42_10 + var_42_18 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play424121010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 424121010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play424121011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10154"]) and arg_43_1.var_.actorSpriteComps10154 == nil then
				arg_43_1.var_.actorSpriteComps10154 = arg_43_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10154"]) then
				if arg_43_1.var_.actorSpriteComps10154 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								iter_46_1.color = Color.New(Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_0), Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_0), (Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_0)))
							else
								local var_46_1 = Mathf.Lerp(iter_46_1.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_0)

								iter_46_1.color = Color.New(var_46_1, var_46_1, var_46_1)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10154"]) and arg_43_1.var_.actorSpriteComps10154 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10154 = nil
			end

			local var_46_2 = arg_43_1.actors_["10154"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10154 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10154", 7)

				for iter_46_4 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_4)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_5 = 0
			local var_46_6 = 0.725

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(424121010).content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 29 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_7) / 29)

				if (29 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_7) / 29)) > 0 and var_46_6 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_6, arg_43_1.talkMaxDuration)

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_5) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_5 + var_46_10 and arg_43_1.time_ < var_46_5 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play424121011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 424121011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play424121012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.425

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

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(424121011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 17 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 17)

				if (17 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 17)) > 0 and var_50_0 < var_50_3 then
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
	Play424121012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 424121012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play424121013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.7

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(424121012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 28 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 28)

				if (28 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 28)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play424121013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 424121013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play424121014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.45

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(424121013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 18 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 18)

				if (18 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 18)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play424121014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 424121014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play424121015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 1 < arg_59_1.time_ and arg_59_1.time_ <= 1 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_cloth01", "")
			end

			local var_62_1 = 0
			local var_62_2 = 1.4

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(424121014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 56 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 56)

				if (56 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 56)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play424121015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 424121015
		arg_63_1.duration_ = 3.87

		local var_63_0 = {
			zh = 3.866,
			ja = 3.133
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
				arg_63_0:Play424121016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10154"]) and arg_63_1.var_.actorSpriteComps10154 == nil then
				arg_63_1.var_.actorSpriteComps10154 = arg_63_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10154"]) then
				if arg_63_1.var_.actorSpriteComps10154 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10154"]) and arg_63_1.var_.actorSpriteComps10154 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10154 = nil
			end

			local var_66_2 = arg_63_1.actors_["10154"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10154 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10154", 3)

				for iter_66_4 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_4)

					if var_66_3.name == "split_4" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_66_5 = 0
			local var_66_6 = 0.2

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(424121015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 8 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 8)

				if (8 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 8)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121015", "story_v_out_424121.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121015", "story_v_out_424121.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_424121", "424121015", "story_v_out_424121.awb")

						arg_63_1:RecordAudio("424121015", var_66_12)
						arg_63_1:RecordAudio("424121015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_424121", "424121015", "story_v_out_424121.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_424121", "424121015", "story_v_out_424121.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play424121016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 424121016
		arg_67_1.duration_ = 16.77

		local var_67_0 = {
			zh = 10.833,
			ja = 16.766
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
				arg_67_0:Play424121017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.bgs_.SS2404 == nil then
				local var_70_0 = Object.Instantiate(arg_67_1.paintGo_)

				var_70_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2404")
				var_70_0.name = "SS2404"
				var_70_0.transform.parent = arg_67_1.stage_.transform
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.bgs_.SS2404 = var_70_0
			end

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				local var_70_1 = arg_67_1.bgs_.SS2404

				arg_67_1.bgs_.SS2404.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_70_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_2 = var_70_1:GetComponent("SpriteRenderer")

				if var_70_2 and var_70_2.sprite then
					local var_70_3 = 2 * (var_70_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_70_1.transform.localScale = Vector3.New(var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "SS2404" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_4 = 4

			if 4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_4 + 0.3 and arg_67_1.time_ < var_70_4 + 0.3 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_5 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_6 = 2

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_6 then
				local var_70_7 = Color.New(0, 0, 0)

				var_70_7.a = Mathf.Lerp(0, 1, (arg_67_1.time_ - var_70_5) / var_70_6)
				arg_67_1.mask_.color = var_70_7
			end

			if arg_67_1.time_ >= var_70_5 + var_70_6 and arg_67_1.time_ < var_70_5 + var_70_6 + arg_70_0 then
				local var_70_8 = Color.New(0, 0, 0)

				var_70_8.a = 1
				arg_67_1.mask_.color = var_70_8
			end

			local var_70_9 = 2

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_10 = 2

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 then
				local var_70_11 = Color.New(0, 0, 0)

				var_70_11.a = Mathf.Lerp(1, 0, (arg_67_1.time_ - var_70_9) / var_70_10)
				arg_67_1.mask_.color = var_70_11
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 then
				local var_70_12 = Color.New(0, 0, 0)

				arg_67_1.mask_.enabled = false
				var_70_12.a = 0
				arg_67_1.mask_.color = var_70_12
			end

			local var_70_13 = arg_67_1.actors_["10154"]

			if 1.966 < arg_67_1.time_ and arg_67_1.time_ <= 1.966 + arg_70_0 and not isNil(var_70_13) and arg_67_1.var_.actorSpriteComps10154 == nil then
				arg_67_1.var_.actorSpriteComps10154 = var_70_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_14 = 0.034

			if 1.966 <= arg_67_1.time_ and arg_67_1.time_ < 1.966 + var_70_14 and not isNil(var_70_13) then
				if arg_67_1.var_.actorSpriteComps10154 then
					for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_70_3 then
							if arg_67_1.isInRecall_ then
								iter_70_3.color = Color.New(Mathf.Lerp(iter_70_3.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 1.966) / var_70_14), Mathf.Lerp(iter_70_3.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 1.966) / var_70_14), (Mathf.Lerp(iter_70_3.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 1.966) / var_70_14)))
							else
								local var_70_15 = Mathf.Lerp(iter_70_3.color.r, 0.5, (arg_67_1.time_ - 1.966) / var_70_14)

								iter_70_3.color = Color.New(var_70_15, var_70_15, var_70_15)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 1.966 + var_70_14 and arg_67_1.time_ < 1.966 + var_70_14 + arg_70_0 and not isNil(var_70_13) and arg_67_1.var_.actorSpriteComps10154 then
				for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_70_5 then
						iter_70_5.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps10154 = nil
			end

			local var_70_16 = arg_67_1.actors_["10154"].transform

			if 1.966 < arg_67_1.time_ and arg_67_1.time_ <= 1.966 + arg_70_0 then
				arg_67_1.var_.moveOldPos10154 = var_70_16.localPosition
				var_70_16.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10154", 7)

				for iter_70_6 = 0, var_70_16.childCount - 1 do
					local var_70_17 = var_70_16:GetChild(iter_70_6)

					if var_70_17.name == "" or not string.find(var_70_17.name, "split") then
						var_70_17.gameObject:SetActive(true)
					else
						var_70_17.gameObject:SetActive(false)
					end
				end
			end

			local var_70_18 = 0.001

			if 1.966 <= arg_67_1.time_ and arg_67_1.time_ < 1.966 + var_70_18 then
				var_70_16.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_67_1.time_ - 1.966) / var_70_18)
			end

			if arg_67_1.time_ >= 1.966 + var_70_18 and arg_67_1.time_ < 1.966 + var_70_18 + arg_70_0 then
				var_70_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_70_19 = arg_67_1.bgs_.SS2404.transform

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				arg_67_1.var_.moveOldPosSS2404 = var_70_19.localPosition
			end

			local var_70_20 = 3.55

			if 2 <= arg_67_1.time_ and arg_67_1.time_ < 2 + var_70_20 then
				var_70_19.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPosSS2404, Vector3.New(0, 0.5, 1), (arg_67_1.time_ - 2) / var_70_20)
			end

			if arg_67_1.time_ >= 2 + var_70_20 and arg_67_1.time_ < 2 + var_70_20 + arg_70_0 then
				var_70_19.localPosition = Vector3.New(0, 0.5, 1)
			end

			local var_70_21 = 4

			if 4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_21 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_21 + 1.55 and arg_67_1.time_ < var_70_21 + 1.55 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			if 0.3 < arg_67_1.time_ and arg_67_1.time_ <= 0.3 + arg_70_0 then
				arg_67_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if 1.66666666666667 < arg_67_1.time_ and arg_67_1.time_ <= 1.66666666666667 + arg_70_0 then
				arg_67_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_24 = 4
			local var_70_25 = 0.475

			if 4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_26 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_26:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_27 = arg_67_1:GetWordFromCfg(424121016)
				local var_70_28 = arg_67_1:FormatText(var_70_27.content)

				arg_67_1.text_.text = var_70_28

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_30 = 19 <= 0 and var_70_25 or var_70_25 * (utf8.len(var_70_28) / 19)

				if (19 <= 0 and var_70_25 or var_70_25 * (utf8.len(var_70_28) / 19)) > 0 and var_70_25 < var_70_30 then
					arg_67_1.talkMaxDuration = var_70_30
					var_70_24 = var_70_24 + 0.3

					if var_70_30 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_30 + var_70_24
					end
				end

				arg_67_1.text_.text = var_70_28
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121016", "story_v_out_424121.awb") ~= 0 then
					local var_70_31 = manager.audio:GetVoiceLength("story_v_out_424121", "424121016", "story_v_out_424121.awb") / 1000

					if var_70_31 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_24
					end

					if var_70_27.prefab_name ~= "" and arg_67_1.actors_[var_70_27.prefab_name] ~= nil then
						local var_70_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_27.prefab_name].transform, "story_v_out_424121", "424121016", "story_v_out_424121.awb")

						arg_67_1:RecordAudio("424121016", var_70_32)
						arg_67_1:RecordAudio("424121016", var_70_32)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_424121", "424121016", "story_v_out_424121.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_424121", "424121016", "story_v_out_424121.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_33 = var_70_24 + 0.3
			local var_70_34 = math.max(var_70_25, arg_67_1.talkMaxDuration)

			if var_70_24 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_33 + var_70_34 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_33) / var_70_34

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_33 + var_70_34 and arg_67_1.time_ < var_70_33 + var_70_34 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
				actorName = "SS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.55,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.7, 1),
					endPos = Vector3.New(0, 0.5, 1),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play424121017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424121017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play424121018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.425

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(424121017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 57 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 57)

				if (57 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 57)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play424121018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424121018
		arg_77_1.duration_ = 12.3

		local var_77_0 = {
			zh = 12.3,
			ja = 7.666
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
				arg_77_0:Play424121019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(424121018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 38 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 38)

				if (38 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 38)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121018", "story_v_out_424121.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121018", "story_v_out_424121.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_424121", "424121018", "story_v_out_424121.awb")

						arg_77_1:RecordAudio("424121018", var_80_6)
						arg_77_1:RecordAudio("424121018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424121", "424121018", "story_v_out_424121.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424121", "424121018", "story_v_out_424121.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play424121019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424121019
		arg_81_1.duration_ = 4.47

		local var_81_0 = {
			zh = 1.566,
			ja = 4.466
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
				arg_81_0:Play424121020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(424121019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 6 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 6)

				if (6 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 6)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121019", "story_v_out_424121.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121019", "story_v_out_424121.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_424121", "424121019", "story_v_out_424121.awb")

						arg_81_1:RecordAudio("424121019", var_84_6)
						arg_81_1:RecordAudio("424121019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_424121", "424121019", "story_v_out_424121.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_424121", "424121019", "story_v_out_424121.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play424121020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424121020
		arg_85_1.duration_ = 1.3

		local var_85_0 = {
			zh = 1.3,
			ja = 0.999999999999
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
				arg_85_0:Play424121021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.1

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_5")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(424121020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 4 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 4)

				if (4 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 4)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121020", "story_v_out_424121.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121020", "story_v_out_424121.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_424121", "424121020", "story_v_out_424121.awb")

						arg_85_1:RecordAudio("424121020", var_88_6)
						arg_85_1:RecordAudio("424121020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_424121", "424121020", "story_v_out_424121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_424121", "424121020", "story_v_out_424121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play424121021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424121021
		arg_89_1.duration_ = 35.13

		local var_89_0 = {
			zh = 15.633,
			ja = 35.133
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
				arg_89_0:Play424121022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(424121021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 54 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 54)

				if (54 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 54)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121021", "story_v_out_424121.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121021", "story_v_out_424121.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_424121", "424121021", "story_v_out_424121.awb")

						arg_89_1:RecordAudio("424121021", var_92_6)
						arg_89_1:RecordAudio("424121021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424121", "424121021", "story_v_out_424121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424121", "424121021", "story_v_out_424121.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play424121022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424121022
		arg_93_1.duration_ = 24.53

		local var_93_0 = {
			zh = 15.133,
			ja = 24.533
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
				arg_93_0:Play424121023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(424121022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 49)

				if (49 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 49)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121022", "story_v_out_424121.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121022", "story_v_out_424121.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_424121", "424121022", "story_v_out_424121.awb")

						arg_93_1:RecordAudio("424121022", var_96_6)
						arg_93_1:RecordAudio("424121022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_424121", "424121022", "story_v_out_424121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_424121", "424121022", "story_v_out_424121.awb")
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
	Play424121023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424121023
		arg_97_1.duration_ = 4.23

		local var_97_0 = {
			zh = 3,
			ja = 4.233
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
				arg_97_0:Play424121024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.175

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(424121023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 7 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 7)

				if (7 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 7)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121023", "story_v_out_424121.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121023", "story_v_out_424121.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_424121", "424121023", "story_v_out_424121.awb")

						arg_97_1:RecordAudio("424121023", var_100_6)
						arg_97_1:RecordAudio("424121023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_424121", "424121023", "story_v_out_424121.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_424121", "424121023", "story_v_out_424121.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play424121024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424121024
		arg_101_1.duration_ = 6.2

		local var_101_0 = {
			zh = 4.733,
			ja = 6.2
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
				arg_101_0:Play424121025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(424121024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 23)

				if (23 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 23)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121024", "story_v_out_424121.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121024", "story_v_out_424121.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_424121", "424121024", "story_v_out_424121.awb")

						arg_101_1:RecordAudio("424121024", var_104_6)
						arg_101_1:RecordAudio("424121024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_424121", "424121024", "story_v_out_424121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_424121", "424121024", "story_v_out_424121.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play424121025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 424121025
		arg_105_1.duration_ = 32

		local var_105_0 = {
			zh = 16.566,
			ja = 32
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
				arg_105_0:Play424121026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(424121025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 50 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 50)

				if (50 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 50)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121025", "story_v_out_424121.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121025", "story_v_out_424121.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_424121", "424121025", "story_v_out_424121.awb")

						arg_105_1:RecordAudio("424121025", var_108_6)
						arg_105_1:RecordAudio("424121025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_424121", "424121025", "story_v_out_424121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_424121", "424121025", "story_v_out_424121.awb")
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
	Play424121026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 424121026
		arg_109_1.duration_ = 5.13

		local var_109_0 = {
			zh = 4.7,
			ja = 5.133
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
				arg_109_0:Play424121027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_3")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(424121026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 21)

				if (21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 21)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121026", "story_v_out_424121.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121026", "story_v_out_424121.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_424121", "424121026", "story_v_out_424121.awb")

						arg_109_1:RecordAudio("424121026", var_112_6)
						arg_109_1:RecordAudio("424121026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_424121", "424121026", "story_v_out_424121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_424121", "424121026", "story_v_out_424121.awb")
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
	Play424121027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 424121027
		arg_113_1.duration_ = 29.7

		local var_113_0 = {
			zh = 16.266,
			ja = 29.7
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
				arg_113_0:Play424121028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(424121027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 44)

				if (44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 44)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121027", "story_v_out_424121.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121027", "story_v_out_424121.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_424121", "424121027", "story_v_out_424121.awb")

						arg_113_1:RecordAudio("424121027", var_116_6)
						arg_113_1:RecordAudio("424121027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_424121", "424121027", "story_v_out_424121.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_424121", "424121027", "story_v_out_424121.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play424121028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 424121028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play424121029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.725

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(424121028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 29 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 29)

				if (29 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 29)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play424121029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 424121029
		arg_121_1.duration_ = 8.42

		local var_121_0 = {
			zh = 2.999999999999,
			ja = 8.415999999999
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
				arg_121_0:Play424121030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_0 = 0.5

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				local var_124_1 = Color.New(1, 1, 1)

				var_124_1.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.mask_.color = var_124_1
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				local var_124_2 = Color.New(1, 1, 1)

				var_124_2.a = 1
				arg_121_1.mask_.color = var_124_2
			end

			local var_124_3 = 0.5

			if 0.5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_4 = 0.5

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 then
				local var_124_5 = Color.New(1, 1, 1)

				var_124_5.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_3) / var_124_4)
				arg_121_1.mask_.color = var_124_5
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 then
				local var_124_6 = Color.New(1, 1, 1)

				arg_121_1.mask_.enabled = false
				var_124_6.a = 0
				arg_121_1.mask_.color = var_124_6
			end

			local var_124_7 = arg_121_1.bgs_.SS2404.transform

			if 0.5 < arg_121_1.time_ and arg_121_1.time_ <= 0.5 + arg_124_0 then
				arg_121_1.var_.moveOldPosSS2404 = var_124_7.localPosition
			end

			local var_124_8 = 2.5

			if 0.5 <= arg_121_1.time_ and arg_121_1.time_ < 0.5 + var_124_8 then
				var_124_7.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPosSS2404, Vector3.New(0, 0.2, -4), (arg_121_1.time_ - 0.5) / var_124_8)
			end

			if arg_121_1.time_ >= 0.5 + var_124_8 and arg_121_1.time_ < 0.5 + var_124_8 + arg_124_0 then
				var_124_7.localPosition = Vector3.New(0, 0.2, -4)
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_9 = 0.849999999999
			local var_124_10 = 0.15

			if 0.849999999999 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_11 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_11:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_12 = arg_121_1:GetWordFromCfg(424121029)
				local var_124_13 = arg_121_1:FormatText(var_124_12.content)

				arg_121_1.text_.text = var_124_13

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 6 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_13) / 6)

				if (6 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_13) / 6)) > 0 and var_124_10 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15
					var_124_9 = var_124_9 + 0.3

					if var_124_15 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_9
					end
				end

				arg_121_1.text_.text = var_124_13
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121029", "story_v_out_424121.awb") ~= 0 then
					local var_124_16 = manager.audio:GetVoiceLength("story_v_out_424121", "424121029", "story_v_out_424121.awb") / 1000

					if var_124_16 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_9
					end

					if var_124_12.prefab_name ~= "" and arg_121_1.actors_[var_124_12.prefab_name] ~= nil then
						local var_124_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_12.prefab_name].transform, "story_v_out_424121", "424121029", "story_v_out_424121.awb")

						arg_121_1:RecordAudio("424121029", var_124_17)
						arg_121_1:RecordAudio("424121029", var_124_17)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_424121", "424121029", "story_v_out_424121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_424121", "424121029", "story_v_out_424121.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_18 = var_124_9 + 0.3
			local var_124_19 = math.max(var_124_10, arg_121_1.talkMaxDuration)

			if var_124_9 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_18 + var_124_19 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_18) / var_124_19

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_18 + var_124_19 and arg_121_1.time_ < var_124_18 + var_124_19 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.2, -3.8),
					endPos = Vector3.New(0, 0.2, -4),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play424121030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424121030
		arg_127_1.duration_ = 7.7

		local var_127_0 = {
			zh = 7.7,
			ja = 7
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
				arg_127_0:Play424121031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.625

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(424121030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 25 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 25)

				if (25 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 25)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121030", "story_v_out_424121.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121030", "story_v_out_424121.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_424121", "424121030", "story_v_out_424121.awb")

						arg_127_1:RecordAudio("424121030", var_130_6)
						arg_127_1:RecordAudio("424121030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424121", "424121030", "story_v_out_424121.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424121", "424121030", "story_v_out_424121.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424121031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424121031
		arg_131_1.duration_ = 22.53

		local var_131_0 = {
			zh = 12.833,
			ja = 22.533
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
				arg_131_0:Play424121032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.65

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(424121031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 26 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 26)

				if (26 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 26)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121031", "story_v_out_424121.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121031", "story_v_out_424121.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_424121", "424121031", "story_v_out_424121.awb")

						arg_131_1:RecordAudio("424121031", var_134_6)
						arg_131_1:RecordAudio("424121031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424121", "424121031", "story_v_out_424121.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424121", "424121031", "story_v_out_424121.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play424121032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424121032
		arg_135_1.duration_ = 10.63

		local var_135_0 = {
			zh = 6.8,
			ja = 10.633
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
				arg_135_0:Play424121033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.375

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(424121032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 15 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 15)

				if (15 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 15)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121032", "story_v_out_424121.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121032", "story_v_out_424121.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_424121", "424121032", "story_v_out_424121.awb")

						arg_135_1:RecordAudio("424121032", var_138_6)
						arg_135_1:RecordAudio("424121032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424121", "424121032", "story_v_out_424121.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424121", "424121032", "story_v_out_424121.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424121033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424121033
		arg_139_1.duration_ = 2

		local var_139_0 = {
			zh = 2,
			ja = 1.766
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
				arg_139_0:Play424121034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.175

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_5")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:GetWordFromCfg(424121033)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 7 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 7)

				if (7 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 7)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121033", "story_v_out_424121.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121033", "story_v_out_424121.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_424121", "424121033", "story_v_out_424121.awb")

						arg_139_1:RecordAudio("424121033", var_142_6)
						arg_139_1:RecordAudio("424121033", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_424121", "424121033", "story_v_out_424121.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_424121", "424121033", "story_v_out_424121.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play424121034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424121034
		arg_143_1.duration_ = 23.1

		local var_143_0 = {
			zh = 12.9,
			ja = 23.1
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
				arg_143_0:Play424121035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.7

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(424121034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 28)

				if (28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 28)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121034", "story_v_out_424121.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121034", "story_v_out_424121.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_424121", "424121034", "story_v_out_424121.awb")

						arg_143_1:RecordAudio("424121034", var_146_6)
						arg_143_1:RecordAudio("424121034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_424121", "424121034", "story_v_out_424121.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_424121", "424121034", "story_v_out_424121.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424121035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424121035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play424121036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.725

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(424121035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 29 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 29)

				if (29 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 29)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play424121036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424121036
		arg_151_1.duration_ = 3.2

		local var_151_0 = {
			zh = 3.2,
			ja = 1.633
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
				arg_151_0:Play424121037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.175

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_3")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(424121036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 7 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 7)

				if (7 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 7)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121036", "story_v_out_424121.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121036", "story_v_out_424121.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_424121", "424121036", "story_v_out_424121.awb")

						arg_151_1:RecordAudio("424121036", var_154_6)
						arg_151_1:RecordAudio("424121036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424121", "424121036", "story_v_out_424121.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424121", "424121036", "story_v_out_424121.awb")
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
	Play424121037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424121037
		arg_155_1.duration_ = 17.67

		local var_155_0 = {
			zh = 9.7,
			ja = 17.666
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
				arg_155_0:Play424121038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.925

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(424121037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 37 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 37)

				if (37 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 37)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121037", "story_v_out_424121.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121037", "story_v_out_424121.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_424121", "424121037", "story_v_out_424121.awb")

						arg_155_1:RecordAudio("424121037", var_158_6)
						arg_155_1:RecordAudio("424121037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424121", "424121037", "story_v_out_424121.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424121", "424121037", "story_v_out_424121.awb")
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
	Play424121038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424121038
		arg_159_1.duration_ = 4

		local var_159_0 = {
			zh = 4,
			ja = 3.733
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
				arg_159_0:Play424121039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_1")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(424121038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 10 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 10)

				if (10 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 10)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121038", "story_v_out_424121.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121038", "story_v_out_424121.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_424121", "424121038", "story_v_out_424121.awb")

						arg_159_1:RecordAudio("424121038", var_162_6)
						arg_159_1:RecordAudio("424121038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_424121", "424121038", "story_v_out_424121.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_424121", "424121038", "story_v_out_424121.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play424121039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424121039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play424121040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.6

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(424121039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 24 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 24)

				if (24 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 24)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play424121040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424121040
		arg_167_1.duration_ = 19.6

		local var_167_0 = {
			zh = 12.8,
			ja = 19.6
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
				arg_167_0:Play424121041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(424121040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 32 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 32)

				if (32 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 32)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121040", "story_v_out_424121.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121040", "story_v_out_424121.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_424121", "424121040", "story_v_out_424121.awb")

						arg_167_1:RecordAudio("424121040", var_170_6)
						arg_167_1:RecordAudio("424121040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424121", "424121040", "story_v_out_424121.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424121", "424121040", "story_v_out_424121.awb")
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
	Play424121041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424121041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424121042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.075

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(424121041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 43 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 43)

				if (43 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 43)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424121042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424121042
		arg_175_1.duration_ = 7.9

		local var_175_0 = {
			zh = 6.3,
			ja = 7.9
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
				arg_175_0:Play424121043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10153_split_4")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(424121042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121042", "story_v_out_424121.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121042", "story_v_out_424121.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_424121", "424121042", "story_v_out_424121.awb")

						arg_175_1:RecordAudio("424121042", var_178_6)
						arg_175_1:RecordAudio("424121042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_424121", "424121042", "story_v_out_424121.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_424121", "424121042", "story_v_out_424121.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play424121043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424121043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424121044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPosSS2404 = arg_179_1.bgs_.SS2404.transform.localPosition
			end

			local var_182_0 = 3.55

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.bgs_.SS2404.transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosSS2404, Vector3.New(0, -1, -4), (arg_179_1.time_ - 0) / var_182_0)
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.bgs_.SS2404.transform.localPosition = Vector3.New(0, -1, -4)
			end

			local var_182_1 = 0
			local var_182_2 = 0.55

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_3 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_3:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(424121043).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 22 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 22)

				if (22 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_4) / 22)) > 0 and var_182_2 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6
					var_182_1 = var_182_1 + 0.3

					if var_182_6 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = var_182_1 + 0.3
			local var_182_8 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_7) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.55,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.2, -4),
					endPos = Vector3.New(0, -1, -4),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play424121044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 424121044
		arg_185_1.duration_ = 27.33

		local var_185_0 = {
			zh = 12.9,
			ja = 27.333
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play424121045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.8

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(424121044)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 32)

				if (32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 32)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121044", "story_v_out_424121.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121044", "story_v_out_424121.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_424121", "424121044", "story_v_out_424121.awb")

						arg_185_1:RecordAudio("424121044", var_188_6)
						arg_185_1:RecordAudio("424121044", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_424121", "424121044", "story_v_out_424121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_424121", "424121044", "story_v_out_424121.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play424121045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 424121045
		arg_189_1.duration_ = 3.83

		local var_189_0 = {
			zh = 3.733,
			ja = 3.833
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
				arg_189_0:Play424121046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.35

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1194")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(424121045)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 14 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 14)

				if (14 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 14)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121045", "story_v_out_424121.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121045", "story_v_out_424121.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_424121", "424121045", "story_v_out_424121.awb")

						arg_189_1:RecordAudio("424121045", var_192_6)
						arg_189_1:RecordAudio("424121045", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_424121", "424121045", "story_v_out_424121.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_424121", "424121045", "story_v_out_424121.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play424121046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 424121046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play424121047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.175

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(424121046).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 7 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 7)

				if (7 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 7)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play424121047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 424121047
		arg_197_1.duration_ = 14.93

		local var_197_0 = {
			zh = 8.8,
			ja = 14.933
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
				arg_197_0:Play424121048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(424121047)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 23 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 23)

				if (23 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 23)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121047", "story_v_out_424121.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121047", "story_v_out_424121.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_424121", "424121047", "story_v_out_424121.awb")

						arg_197_1:RecordAudio("424121047", var_200_6)
						arg_197_1:RecordAudio("424121047", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_424121", "424121047", "story_v_out_424121.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_424121", "424121047", "story_v_out_424121.awb")
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
	Play424121048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 424121048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play424121049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.2

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(424121048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 8 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 8)

				if (8 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 8)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play424121049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 424121049
		arg_205_1.duration_ = 9.9

		local var_205_0 = {
			zh = 5.833,
			ja = 9.9
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
				arg_205_0:Play424121050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(424121049)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 14)

				if (14 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 14)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121049", "story_v_out_424121.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121049", "story_v_out_424121.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_424121", "424121049", "story_v_out_424121.awb")

						arg_205_1:RecordAudio("424121049", var_208_6)
						arg_205_1:RecordAudio("424121049", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_424121", "424121049", "story_v_out_424121.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_424121", "424121049", "story_v_out_424121.awb")
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
	Play424121050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 424121050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play424121051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(424121050).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 4 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 4)

				if (4 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 4)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play424121051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 424121051
		arg_213_1.duration_ = 1.73

		local var_213_0 = {
			zh = 1.733,
			ja = 1.7
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
				arg_213_0:Play424121052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.15

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_2 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_2:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(424121051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 6 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_4) / 6)

				if (6 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_4) / 6)) > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6
					var_216_0 = var_216_0 + 0.3

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121051", "story_v_out_424121.awb") ~= 0 then
					local var_216_7 = manager.audio:GetVoiceLength("story_v_out_424121", "424121051", "story_v_out_424121.awb") / 1000

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_424121", "424121051", "story_v_out_424121.awb")

						arg_213_1:RecordAudio("424121051", var_216_8)
						arg_213_1:RecordAudio("424121051", var_216_8)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_424121", "424121051", "story_v_out_424121.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_424121", "424121051", "story_v_out_424121.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_9 = var_216_0 + 0.3
			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_9) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play424121052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424121052
		arg_219_1.duration_ = 13.07

		local var_219_0 = {
			zh = 6.6,
			ja = 13.066
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
				arg_219_0:Play424121053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(424121052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 15 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 15)

				if (15 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 15)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121052", "story_v_out_424121.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121052", "story_v_out_424121.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_424121", "424121052", "story_v_out_424121.awb")

						arg_219_1:RecordAudio("424121052", var_222_6)
						arg_219_1:RecordAudio("424121052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_424121", "424121052", "story_v_out_424121.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_424121", "424121052", "story_v_out_424121.awb")
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
	Play424121053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424121053
		arg_223_1.duration_ = 10.47

		local var_223_0 = {
			zh = 10.466,
			ja = 8.233
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
				arg_223_0:Play424121054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.975

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_2 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_2:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(424121053)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 39 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_4) / 39)

				if (39 <= 0 and var_226_1 or var_226_1 * (utf8.len(var_226_4) / 39)) > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6
					var_226_0 = var_226_0 + 0.3

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121053", "story_v_out_424121.awb") ~= 0 then
					local var_226_7 = manager.audio:GetVoiceLength("story_v_out_424121", "424121053", "story_v_out_424121.awb") / 1000

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_424121", "424121053", "story_v_out_424121.awb")

						arg_223_1:RecordAudio("424121053", var_226_8)
						arg_223_1:RecordAudio("424121053", var_226_8)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_424121", "424121053", "story_v_out_424121.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_424121", "424121053", "story_v_out_424121.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_9 = var_226_0 + 0.3
			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_9) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 15,
				className = "StoryShakeNode",
				duration = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(4, 4, 4)
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play424121054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 424121054
		arg_229_1.duration_ = 11.3

		local var_229_0 = {
			zh = 8.466,
			ja = 11.3
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
				arg_229_0:Play424121055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.325

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(424121054)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 13 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 13)

				if (13 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 13)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121054", "story_v_out_424121.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121054", "story_v_out_424121.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_424121", "424121054", "story_v_out_424121.awb")

						arg_229_1:RecordAudio("424121054", var_232_6)
						arg_229_1:RecordAudio("424121054", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_424121", "424121054", "story_v_out_424121.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_424121", "424121054", "story_v_out_424121.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play424121055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 424121055
		arg_233_1.duration_ = 8.2

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play424121056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_9001
			local var_236_9000

			if arg_233_1.bgs_.SS2404a == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2404a")
				var_236_0.name = "SS2404a"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.SS2404a = var_236_0
			end

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= 1.2 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.SS2404a

				arg_233_1.bgs_.SS2404a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "SS2404a" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 3.2

			if 3.2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_4 + 0.3 and arg_233_1.time_ < var_236_4 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				local var_236_5 = arg_233_1.var_.effectbicuisi1

				if not arg_233_1.var_.effectbicuisi1 then
					var_236_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_236_5.name = "bicuisi1"
					arg_233_1.var_.effectbicuisi1 = var_236_5
				else
					var_236_5.transform:SetParent(var_236_9001)
				end

				var_236_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= 1.2 + arg_236_0 then
				if arg_233_1.var_.effectbicuisi1 then
					Object.Destroy(arg_233_1.var_.effectbicuisi1)

					arg_233_1.var_.effectbicuisi1 = nil
				end
			end

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= 1.2 + arg_236_0 then
				local var_236_8 = arg_233_1.var_.effectbicuisi2

				if not arg_233_1.var_.effectbicuisi2 then
					var_236_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_236_8.name = "bicuisi2"
					arg_233_1.var_.effectbicuisi2 = var_236_8
				else
					var_236_8.transform:SetParent(var_236_9000)
				end

				var_236_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_236_10 = arg_233_1.bgs_.SS2404a.transform

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= 1.2 + arg_236_0 then
				arg_233_1.var_.moveOldPosSS2404a = var_236_10.localPosition
			end

			local var_236_11 = 4.5

			if 1.2 <= arg_233_1.time_ and arg_233_1.time_ < 1.2 + var_236_11 then
				var_236_10.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPosSS2404a, Vector3.New(0, 1, 9), (arg_233_1.time_ - 1.2) / var_236_11)
			end

			if arg_233_1.time_ >= 1.2 + var_236_11 and arg_233_1.time_ < 1.2 + var_236_11 + arg_236_0 then
				var_236_10.localPosition = Vector3.New(0, 1, 9)
			end

			local var_236_12 = 1.2

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_12 + 3 and arg_233_1.time_ < var_236_12 + 3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_13 = 3.2
			local var_236_14 = 1.275

			if 3.2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_15 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_15:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_16 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(424121055).content)

				arg_233_1.text_.text = var_236_16

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_18 = 51 <= 0 and var_236_14 or var_236_14 * (utf8.len(var_236_16) / 51)

				if (51 <= 0 and var_236_14 or var_236_14 * (utf8.len(var_236_16) / 51)) > 0 and var_236_14 < var_236_18 then
					arg_233_1.talkMaxDuration = var_236_18
					var_236_13 = var_236_13 + 0.3

					if var_236_18 + var_236_13 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_13
					end
				end

				arg_233_1.text_.text = var_236_16
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_19 = var_236_13 + 0.3
			local var_236_20 = math.max(var_236_14, arg_233_1.talkMaxDuration)

			if var_236_13 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_19 + var_236_20 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_19) / var_236_20

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_19 + var_236_20 and arg_233_1.time_ < var_236_19 + var_236_20 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2404a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 4.5,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play424121056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424121056
		arg_239_1.duration_ = 3.93

		local var_239_0 = {
			zh = 3.933,
			ja = 3.066
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
				arg_239_0:Play424121057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.275

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(424121056)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 11 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 11)

				if (11 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 11)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121056", "story_v_out_424121.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121056", "story_v_out_424121.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_424121", "424121056", "story_v_out_424121.awb")

						arg_239_1:RecordAudio("424121056", var_242_6)
						arg_239_1:RecordAudio("424121056", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_424121", "424121056", "story_v_out_424121.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_424121", "424121056", "story_v_out_424121.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play424121057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424121057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424121058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.05

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(424121057).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 42 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 42)

				if (42 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 42)) > 0 and var_246_0 < var_246_3 then
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
	Play424121058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424121058
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play424121059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(424121058).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 40 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 40)

				if (40 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 40)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play424121059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424121059
		arg_251_1.duration_ = 15.27

		local var_251_0 = {
			zh = 10,
			ja = 15.266
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
				arg_251_0:Play424121060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.875

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10154_split_4")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(424121059)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 35 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 35)

				if (35 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 35)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121059", "story_v_out_424121.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121059", "story_v_out_424121.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_424121", "424121059", "story_v_out_424121.awb")

						arg_251_1:RecordAudio("424121059", var_254_6)
						arg_251_1:RecordAudio("424121059", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424121", "424121059", "story_v_out_424121.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424121", "424121059", "story_v_out_424121.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play424121060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424121060
		arg_255_1.duration_ = 6.3

		local var_255_0 = {
			zh = 6.2,
			ja = 6.3
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
				arg_255_0:Play424121061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if arg_255_1.bgs_.ST0116 == nil then
				local var_258_0 = Object.Instantiate(arg_255_1.paintGo_)

				var_258_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116")
				var_258_0.name = "ST0116"
				var_258_0.transform.parent = arg_255_1.stage_.transform
				var_258_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.bgs_.ST0116 = var_258_0
			end

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= 2 + arg_258_0 then
				local var_258_1 = arg_255_1.bgs_.ST0116

				arg_255_1.bgs_.ST0116.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_2 = var_258_1:GetComponent("SpriteRenderer")

				if var_258_2 and var_258_2.sprite then
					local var_258_3 = 2 * (var_258_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_1.transform.localScale = Vector3.New(var_258_3 / var_258_2.sprite.bounds.size.y < var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x and var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x or var_258_3 / var_258_2.sprite.bounds.size.y, var_258_3 / var_258_2.sprite.bounds.size.y < var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x and var_258_3 * manager.ui.mainCameraCom_.aspect / var_258_2.sprite.bounds.size.x or var_258_3 / var_258_2.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "ST0116" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_4 = 4

			if 4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			if arg_255_1.time_ >= var_258_4 + 0.3 and arg_255_1.time_ < var_258_4 + 0.3 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			local var_258_5 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_6 = 2

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 then
				local var_258_7 = Color.New(0, 0, 0)

				var_258_7.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_5) / var_258_6)
				arg_255_1.mask_.color = var_258_7
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 then
				local var_258_8 = Color.New(0, 0, 0)

				var_258_8.a = 1
				arg_255_1.mask_.color = var_258_8
			end

			local var_258_9 = 2

			if 2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_10 = 2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 then
				local var_258_11 = Color.New(0, 0, 0)

				var_258_11.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_9) / var_258_10)
				arg_255_1.mask_.color = var_258_11
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 then
				local var_258_12 = Color.New(0, 0, 0)

				arg_255_1.mask_.enabled = false
				var_258_12.a = 0
				arg_255_1.mask_.color = var_258_12
			end

			local var_258_13 = "10153"

			if arg_255_1.actors_["10153"] == nil then
				local var_258_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_258_14) then
					local var_258_15 = Object.Instantiate(var_258_14, arg_255_1.canvasGo_.transform)

					var_258_15.transform:SetSiblingIndex(1)

					var_258_15.name = var_258_13
					var_258_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_255_1.actors_[var_258_13] = var_258_15

					if arg_255_1.isInRecall_ then
						for iter_258_2, iter_258_3 in ipairs((var_258_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_258_16 = arg_255_1.actors_["10153"]

			if 3.8 < arg_255_1.time_ and arg_255_1.time_ <= 3.8 + arg_258_0 and not isNil(var_258_16) and arg_255_1.var_.actorSpriteComps10153 == nil then
				arg_255_1.var_.actorSpriteComps10153 = var_258_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_17 = 0.2

			if 3.8 <= arg_255_1.time_ and arg_255_1.time_ < 3.8 + var_258_17 and not isNil(var_258_16) then
				if arg_255_1.var_.actorSpriteComps10153 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								iter_258_5.color = Color.New(Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 3.8) / var_258_17), Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 3.8) / var_258_17), (Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 3.8) / var_258_17)))
							else
								local var_258_18 = Mathf.Lerp(iter_258_5.color.r, 1, (arg_255_1.time_ - 3.8) / var_258_17)

								iter_258_5.color = Color.New(var_258_18, var_258_18, var_258_18)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 3.8 + var_258_17 and arg_255_1.time_ < 3.8 + var_258_17 + arg_258_0 and not isNil(var_258_16) and arg_255_1.var_.actorSpriteComps10153 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_258_7 then
						iter_258_7.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10153 = nil
			end

			local var_258_19 = arg_255_1.actors_["10153"].transform

			if 3.8 < arg_255_1.time_ and arg_255_1.time_ <= 3.8 + arg_258_0 then
				arg_255_1.var_.moveOldPos10153 = var_258_19.localPosition
				var_258_19.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10153", 3)

				for iter_258_8 = 0, var_258_19.childCount - 1 do
					local var_258_20 = var_258_19:GetChild(iter_258_8)

					if var_258_20.name == "" or not string.find(var_258_20.name, "split") then
						var_258_20.gameObject:SetActive(true)
					else
						var_258_20.gameObject:SetActive(false)
					end
				end
			end

			local var_258_21 = 0.001

			if 3.8 <= arg_255_1.time_ and arg_255_1.time_ < 3.8 + var_258_21 then
				var_258_19.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_255_1.time_ - 3.8) / var_258_21)
			end

			if arg_255_1.time_ >= 3.8 + var_258_21 and arg_255_1.time_ < 3.8 + var_258_21 + arg_258_0 then
				var_258_19.localPosition = Vector3.New(-60, -395, -330)
			end

			if 3.8 < arg_255_1.time_ and arg_255_1.time_ <= 3.8 + arg_258_0 then
				local var_258_22 = arg_255_1.actors_["10153"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_258_22 then
					arg_255_1.var_.alphaOldValue10153 = var_258_22.alpha
					arg_255_1.var_.characterEffect10153 = var_258_22
				end

				arg_255_1.var_.alphaOldValue10153 = 0
			end

			local var_258_23 = 0.5

			if 3.8 <= arg_255_1.time_ and arg_255_1.time_ < 3.8 + var_258_23 then
				if arg_255_1.var_.characterEffect10153 then
					arg_255_1.var_.characterEffect10153.alpha = Mathf.Lerp(arg_255_1.var_.alphaOldValue10153, 1, (arg_255_1.time_ - 3.8) / var_258_23)
				end
			end

			if arg_255_1.time_ >= 3.8 + var_258_23 and arg_255_1.time_ < 3.8 + var_258_23 + arg_258_0 and arg_255_1.var_.characterEffect10153 then
				arg_255_1.var_.characterEffect10153.alpha = 1
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_24 = 4
			local var_258_25 = 0.25

			if 4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_24 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_26 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_26:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_27 = arg_255_1:GetWordFromCfg(424121060)
				local var_258_28 = arg_255_1:FormatText(var_258_27.content)

				arg_255_1.text_.text = var_258_28

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_30 = 10 <= 0 and var_258_25 or var_258_25 * (utf8.len(var_258_28) / 10)

				if (10 <= 0 and var_258_25 or var_258_25 * (utf8.len(var_258_28) / 10)) > 0 and var_258_25 < var_258_30 then
					arg_255_1.talkMaxDuration = var_258_30
					var_258_24 = var_258_24 + 0.3

					if var_258_30 + var_258_24 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_30 + var_258_24
					end
				end

				arg_255_1.text_.text = var_258_28
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121060", "story_v_out_424121.awb") ~= 0 then
					local var_258_31 = manager.audio:GetVoiceLength("story_v_out_424121", "424121060", "story_v_out_424121.awb") / 1000

					if var_258_31 + var_258_24 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_31 + var_258_24
					end

					if var_258_27.prefab_name ~= "" and arg_255_1.actors_[var_258_27.prefab_name] ~= nil then
						local var_258_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_27.prefab_name].transform, "story_v_out_424121", "424121060", "story_v_out_424121.awb")

						arg_255_1:RecordAudio("424121060", var_258_32)
						arg_255_1:RecordAudio("424121060", var_258_32)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424121", "424121060", "story_v_out_424121.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424121", "424121060", "story_v_out_424121.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_33 = var_258_24 + 0.3
			local var_258_34 = math.max(var_258_25, arg_255_1.talkMaxDuration)

			if var_258_24 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_33 + var_258_34 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_33) / var_258_34

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_33 + var_258_34 and arg_255_1.time_ < var_258_33 + var_258_34 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play424121061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 424121061
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play424121062(arg_261_1)
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
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10153"]) and arg_261_1.var_.actorSpriteComps10153 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10153 = nil
			end

			local var_264_2 = arg_261_1.actors_["10153"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10153 = var_264_2.localPosition
				var_264_2.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10153", 7)

				for iter_264_4 = 0, var_264_2.childCount - 1 do
					local var_264_3 = var_264_2:GetChild(iter_264_4)

					if var_264_3.name == "" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_2.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_261_1.time_ - 0) / var_264_4)
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_264_5 = 0
			local var_264_6 = 0.675

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_7 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(424121061).content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 27 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 27)

				if (27 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 27)) > 0 and var_264_6 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_10 and arg_261_1.time_ < var_264_5 + var_264_10 + arg_264_0 then
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
	Play424121062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 424121062
		arg_265_1.duration_ = 3.33

		local var_265_0 = {
			zh = 2.733,
			ja = 3.333
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
				arg_265_0:Play424121063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if arg_265_1.actors_["1094"] == nil then
				local var_268_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_268_0) then
					local var_268_1 = Object.Instantiate(var_268_0, arg_265_1.canvasGo_.transform)

					var_268_1.transform:SetSiblingIndex(1)

					var_268_1.name = "1094"
					var_268_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_265_1.actors_["1094"] = var_268_1

					if arg_265_1.isInRecall_ then
						for iter_268_0, iter_268_1 in ipairs((var_268_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_268_1.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_268_2 = arg_265_1.actors_["1094"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1094 == nil then
				arg_265_1.var_.actorSpriteComps1094 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps1094 then
					for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_268_3 then
							if arg_265_1.isInRecall_ then
								iter_268_3.color = Color.New(Mathf.Lerp(iter_268_3.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_3.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_3.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_3.color.r, 1, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_3.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps1094 then
				for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_268_5 then
						iter_268_5.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1094 = nil
			end

			local var_268_5 = arg_265_1.actors_["1094"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1094 = var_268_5.localPosition
				var_268_5.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1094", 3)

				for iter_268_6 = 0, var_268_5.childCount - 1 do
					local var_268_6 = var_268_5:GetChild(iter_268_6)

					if var_268_6.name == "split_4" or not string.find(var_268_6.name, "split") then
						var_268_6.gameObject:SetActive(true)
					else
						var_268_6.gameObject:SetActive(false)
					end
				end
			end

			local var_268_7 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				var_268_5.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_265_1.time_ - 0) / var_268_7)
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				var_268_5.localPosition = Vector3.New(0, -335, -230)
			end

			local var_268_8 = 0
			local var_268_9 = 0.15

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(424121062)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 6 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 6)

				if (6 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 6)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121062", "story_v_out_424121.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121062", "story_v_out_424121.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_424121", "424121062", "story_v_out_424121.awb")

						arg_265_1:RecordAudio("424121062", var_268_15)
						arg_265_1:RecordAudio("424121062", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_424121", "424121062", "story_v_out_424121.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_424121", "424121062", "story_v_out_424121.awb")
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
				actorName = "1094",
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
	Play424121063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 424121063
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play424121064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1094"]) and arg_269_1.var_.actorSpriteComps1094 == nil then
				arg_269_1.var_.actorSpriteComps1094 = arg_269_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1094"]) then
				if arg_269_1.var_.actorSpriteComps1094 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								iter_272_1.color = Color.New(Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_0), Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_0), (Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_0)))
							else
								local var_272_1 = Mathf.Lerp(iter_272_1.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_0)

								iter_272_1.color = Color.New(var_272_1, var_272_1, var_272_1)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1094"]) and arg_269_1.var_.actorSpriteComps1094 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1094 = nil
			end

			local var_272_2 = arg_269_1.actors_["1094"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1094 = var_272_2.localPosition
				var_272_2.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1094", 7)

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
				var_272_2.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_269_1.time_ - 0) / var_272_4)
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_272_5 = 0
			local var_272_6 = 0.975

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(424121063).content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 39 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_7) / 39)

				if (39 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_7) / 39)) > 0 and var_272_6 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_10 and arg_269_1.time_ < var_272_5 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play424121064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 424121064
		arg_273_1.duration_ = 7.63

		local var_273_0 = {
			zh = 6.133,
			ja = 7.633
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
				arg_273_0:Play424121065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10153"]) and arg_273_1.var_.actorSpriteComps10153 == nil then
				arg_273_1.var_.actorSpriteComps10153 = arg_273_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10153"]) then
				if arg_273_1.var_.actorSpriteComps10153 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 1, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10153"]) and arg_273_1.var_.actorSpriteComps10153 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps10153 = nil
			end

			local var_276_2 = arg_273_1.actors_["10153"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10153 = var_276_2.localPosition
				var_276_2.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10153", 3)

				for iter_276_4 = 0, var_276_2.childCount - 1 do
					local var_276_3 = var_276_2:GetChild(iter_276_4)

					if var_276_3.name == "split_1" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_2.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_273_1.time_ - 0) / var_276_4)
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_2.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_276_5 = 0
			local var_276_6 = 0.525

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(424121064)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 21 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 21)

				if (21 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 21)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121064", "story_v_out_424121.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121064", "story_v_out_424121.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_424121", "424121064", "story_v_out_424121.awb")

						arg_273_1:RecordAudio("424121064", var_276_12)
						arg_273_1:RecordAudio("424121064", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_424121", "424121064", "story_v_out_424121.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_424121", "424121064", "story_v_out_424121.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_13 and arg_273_1.time_ < var_276_5 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play424121065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 424121065
		arg_277_1.duration_ = 3.1

		local var_277_0 = {
			zh = 2.566,
			ja = 3.1
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
				arg_277_0:Play424121066(arg_277_1)
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
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10153"]) and arg_277_1.var_.actorSpriteComps10153 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps10153 = nil
			end

			local var_280_2 = 0
			local var_280_3 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_4 = arg_277_1:GetWordFromCfg(424121065)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 11 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 11)

				if (11 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 11)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121065", "story_v_out_424121.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_424121", "424121065", "story_v_out_424121.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_out_424121", "424121065", "story_v_out_424121.awb")

						arg_277_1:RecordAudio("424121065", var_280_9)
						arg_277_1:RecordAudio("424121065", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_424121", "424121065", "story_v_out_424121.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_424121", "424121065", "story_v_out_424121.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_10 and arg_277_1.time_ < var_280_2 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play424121066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 424121066
		arg_281_1.duration_ = 6.5

		local var_281_0 = {
			zh = 6.5,
			ja = 5.7
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
				arg_281_0:Play424121067(arg_281_1)
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
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 1, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10153"]) and arg_281_1.var_.actorSpriteComps10153 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps10153 = nil
			end

			local var_284_2 = arg_281_1.actors_["10153"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10153 = var_284_2.localPosition
				var_284_2.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10153", 3)

				for iter_284_4 = 0, var_284_2.childCount - 1 do
					local var_284_3 = var_284_2:GetChild(iter_284_4)

					if var_284_3.name == "split_4" then
						var_284_3:SetAsLastSibling()
						var_284_3.gameObject:SetActive(true)

						arg_281_1.var_.actorSpriteSplit10153 = var_284_3.gameObject:GetComponent(typeof(Image))

						arg_281_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_284_4 = 0.5

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_2.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_281_1.time_ - 0) / var_284_4)

				if arg_281_1.var_.actorSpriteSplit10153 ~= nil then
					arg_281_1.var_.actorSpriteSplit10153:SetAlpha((arg_281_1.time_ - 0) / var_284_4)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_2.localPosition = Vector3.New(-60, -395, -330)

				if arg_281_1.var_.actorSpriteSplit10153 ~= nil then
					arg_281_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_284_5 = 0
			local var_284_6 = 0.4

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(424121066)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 16 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 16)

				if (16 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 16)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121066", "story_v_out_424121.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121066", "story_v_out_424121.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_424121", "424121066", "story_v_out_424121.awb")

						arg_281_1:RecordAudio("424121066", var_284_12)
						arg_281_1:RecordAudio("424121066", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_424121", "424121066", "story_v_out_424121.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_424121", "424121066", "story_v_out_424121.awb")
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play424121067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 424121067
		arg_285_1.duration_ = 4.07

		local var_285_0 = {
			zh = 4.066,
			ja = 3.633
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
				arg_285_0:Play424121068(arg_285_1)
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
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10153"]) and arg_285_1.var_.actorSpriteComps10153 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps10153 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_4 = arg_285_1:GetWordFromCfg(424121067)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 14 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 14)

				if (14 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 14)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121067", "story_v_out_424121.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_424121", "424121067", "story_v_out_424121.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_424121", "424121067", "story_v_out_424121.awb")

						arg_285_1:RecordAudio("424121067", var_288_9)
						arg_285_1:RecordAudio("424121067", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_424121", "424121067", "story_v_out_424121.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_424121", "424121067", "story_v_out_424121.awb")
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
	Play424121068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 424121068
		arg_289_1.duration_ = 6.5

		local var_289_0 = {
			zh = 5.733,
			ja = 6.5
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
				arg_289_0:Play424121069(arg_289_1)
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
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 1, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10153"]) and arg_289_1.var_.actorSpriteComps10153 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10153 = nil
			end

			local var_292_2 = arg_289_1.actors_["10153"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10153 = var_292_2.localPosition
				var_292_2.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10153", 3)

				for iter_292_4 = 0, var_292_2.childCount - 1 do
					local var_292_3 = var_292_2:GetChild(iter_292_4)

					if var_292_3.name == "split_1" then
						var_292_3:SetAsLastSibling()
						var_292_3.gameObject:SetActive(true)

						arg_289_1.var_.actorSpriteSplit10153 = var_292_3.gameObject:GetComponent(typeof(Image))

						arg_289_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_292_4 = 0.5

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_2.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10153, Vector3.New(-60, -395, -330), (arg_289_1.time_ - 0) / var_292_4)

				if arg_289_1.var_.actorSpriteSplit10153 ~= nil then
					arg_289_1.var_.actorSpriteSplit10153:SetAlpha((arg_289_1.time_ - 0) / var_292_4)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_2.localPosition = Vector3.New(-60, -395, -330)

				if arg_289_1.var_.actorSpriteSplit10153 ~= nil then
					arg_289_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_292_5 = 0
			local var_292_6 = 0.6

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:GetWordFromCfg(424121068)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 24 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 24)

				if (24 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 24)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121068", "story_v_out_424121.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121068", "story_v_out_424121.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_424121", "424121068", "story_v_out_424121.awb")

						arg_289_1:RecordAudio("424121068", var_292_12)
						arg_289_1:RecordAudio("424121068", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_424121", "424121068", "story_v_out_424121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_424121", "424121068", "story_v_out_424121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_13 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_13 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_13

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_13 and arg_289_1.time_ < var_292_5 + var_292_13 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play424121069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 424121069
		arg_293_1.duration_ = 5.07

		local var_293_0 = {
			zh = 4.4,
			ja = 5.066
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
				arg_293_0:Play424121070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 == nil then
				arg_293_1.var_.actorSpriteComps1094 = arg_293_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1094"]) then
				if arg_293_1.var_.actorSpriteComps1094 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1094"]) and arg_293_1.var_.actorSpriteComps1094 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1094 = nil
			end

			local var_296_2 = arg_293_1.actors_["10153"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10153 == nil then
				arg_293_1.var_.actorSpriteComps10153 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps10153 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								iter_296_5.color = Color.New(Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_5.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_5.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10153 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_296_7 then
						iter_296_7.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps10153 = nil
			end

			local var_296_5 = arg_293_1.actors_["1094"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1094 = var_296_5.localPosition
				var_296_5.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1094", 4)

				for iter_296_8 = 0, var_296_5.childCount - 1 do
					local var_296_6 = var_296_5:GetChild(iter_296_8)

					if var_296_6.name == "split_1" or not string.find(var_296_6.name, "split") then
						var_296_6.gameObject:SetActive(true)
					else
						var_296_6.gameObject:SetActive(false)
					end
				end
			end

			local var_296_7 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				var_296_5.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_293_1.time_ - 0) / var_296_7)
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				var_296_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_296_8 = arg_293_1.actors_["10153"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10153 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10153", 2)

				for iter_296_9 = 0, var_296_8.childCount - 1 do
					local var_296_9 = var_296_8:GetChild(iter_296_9)

					if var_296_9.name == "" or not string.find(var_296_9.name, "split") then
						var_296_9.gameObject:SetActive(true)
					else
						var_296_9.gameObject:SetActive(false)
					end
				end
			end

			local var_296_10 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_10 then
				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_293_1.time_ - 0) / var_296_10)
			end

			if arg_293_1.time_ >= 0 + var_296_10 and arg_293_1.time_ < 0 + var_296_10 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_296_11 = 0
			local var_296_12 = 0.425

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_13 = arg_293_1:GetWordFromCfg(424121069)
				local var_296_14 = arg_293_1:FormatText(var_296_13.content)

				arg_293_1.text_.text = var_296_14

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_16 = 17 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_14) / 17)

				if (17 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_14) / 17)) > 0 and var_296_12 < var_296_16 then
					arg_293_1.talkMaxDuration = var_296_16

					if var_296_16 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_14
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121069", "story_v_out_424121.awb") ~= 0 then
					local var_296_17 = manager.audio:GetVoiceLength("story_v_out_424121", "424121069", "story_v_out_424121.awb") / 1000

					if var_296_17 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_17 + var_296_11
					end

					if var_296_13.prefab_name ~= "" and arg_293_1.actors_[var_296_13.prefab_name] ~= nil then
						local var_296_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_13.prefab_name].transform, "story_v_out_424121", "424121069", "story_v_out_424121.awb")

						arg_293_1:RecordAudio("424121069", var_296_18)
						arg_293_1:RecordAudio("424121069", var_296_18)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_424121", "424121069", "story_v_out_424121.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_424121", "424121069", "story_v_out_424121.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_19 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 <= arg_293_1.time_ and arg_293_1.time_ < var_296_11 + var_296_19 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_11) / var_296_19

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_11 + var_296_19 and arg_293_1.time_ < var_296_11 + var_296_19 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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
				actorName = "10153",
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
	Play424121070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 424121070
		arg_297_1.duration_ = 10.67

		local var_297_0 = {
			zh = 9.233,
			ja = 10.666
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
				arg_297_0:Play424121071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10153"]) and arg_297_1.var_.actorSpriteComps10153 == nil then
				arg_297_1.var_.actorSpriteComps10153 = arg_297_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10153"]) then
				if arg_297_1.var_.actorSpriteComps10153 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 1, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10153"]) and arg_297_1.var_.actorSpriteComps10153 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10153 = nil
			end

			local var_300_2 = arg_297_1.actors_["1094"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1094 == nil then
				arg_297_1.var_.actorSpriteComps1094 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps1094 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								iter_300_5.color = Color.New(Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_5.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_5.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps1094 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_300_7 then
						iter_300_7.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1094 = nil
			end

			local var_300_5 = arg_297_1.actors_["10153"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10153 = var_300_5.localPosition
				var_300_5.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10153", 2)

				for iter_300_8 = 0, var_300_5.childCount - 1 do
					local var_300_6 = var_300_5:GetChild(iter_300_8)

					if var_300_6.name == "split_1" or not string.find(var_300_6.name, "split") then
						var_300_6.gameObject:SetActive(true)
					else
						var_300_6.gameObject:SetActive(false)
					end
				end
			end

			local var_300_7 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				var_300_5.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_297_1.time_ - 0) / var_300_7)
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				var_300_5.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_300_8 = 0
			local var_300_9 = 0.9

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(424121070)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 34 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 34)

				if (34 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 34)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121070", "story_v_out_424121.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121070", "story_v_out_424121.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_424121", "424121070", "story_v_out_424121.awb")

						arg_297_1:RecordAudio("424121070", var_300_15)
						arg_297_1:RecordAudio("424121070", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_424121", "424121070", "story_v_out_424121.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_424121", "424121070", "story_v_out_424121.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play424121071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 424121071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play424121072(arg_301_1)
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
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["10153"]) and arg_301_1.var_.actorSpriteComps10153 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10153 = nil
			end

			local var_304_2 = arg_301_1.actors_["10153"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10153 = var_304_2.localPosition
				var_304_2.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10153", 7)

				for iter_304_4 = 0, var_304_2.childCount - 1 do
					local var_304_3 = var_304_2:GetChild(iter_304_4)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_301_1.time_ - 0) / var_304_4)
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_304_5 = arg_301_1.actors_["1094"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1094 = var_304_5.localPosition
				var_304_5.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1094", 7)

				for iter_304_5 = 0, var_304_5.childCount - 1 do
					local var_304_6 = var_304_5:GetChild(iter_304_5)

					if var_304_6.name == "" or not string.find(var_304_6.name, "split") then
						var_304_6.gameObject:SetActive(true)
					else
						var_304_6.gameObject:SetActive(false)
					end
				end
			end

			local var_304_7 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				var_304_5.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_301_1.time_ - 0) / var_304_7)
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				var_304_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_304_8 = 0
			local var_304_9 = 0.5

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(424121071).content)

				arg_301_1.text_.text = var_304_10

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_12 = 20 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_10) / 20)

				if (20 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_10) / 20)) > 0 and var_304_9 < var_304_12 then
					arg_301_1.talkMaxDuration = var_304_12

					if var_304_12 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_10
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_13 and arg_301_1.time_ < var_304_8 + var_304_13 + arg_304_0 then
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

		arg_301_1:InitPlayNodeList()
	end,
	Play424121072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 424121072
		arg_305_1.duration_ = 3.5

		local var_305_0 = {
			zh = 2.966,
			ja = 3.5
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
				arg_305_0:Play424121073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1094"]) and arg_305_1.var_.actorSpriteComps1094 == nil then
				arg_305_1.var_.actorSpriteComps1094 = arg_305_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1094"]) then
				if arg_305_1.var_.actorSpriteComps1094 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1094"]) and arg_305_1.var_.actorSpriteComps1094 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1094 = nil
			end

			local var_308_2 = arg_305_1.actors_["1094"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1094 = var_308_2.localPosition
				var_308_2.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1094", 2)

				for iter_308_4 = 0, var_308_2.childCount - 1 do
					local var_308_3 = var_308_2:GetChild(iter_308_4)

					if var_308_3.name == "split_4" then
						var_308_3:SetAsLastSibling()
						var_308_3.gameObject:SetActive(true)

						arg_305_1.var_.actorSpriteSplit1094 = var_308_3.gameObject:GetComponent(typeof(Image))

						arg_305_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_308_4 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				var_308_2.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_305_1.time_ - 0) / var_308_4)

				if arg_305_1.var_.actorSpriteSplit1094 ~= nil then
					arg_305_1.var_.actorSpriteSplit1094:SetAlpha((arg_305_1.time_ - 0) / var_308_4)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				var_308_2.localPosition = Vector3.New(-380, -335, -230)

				if arg_305_1.var_.actorSpriteSplit1094 ~= nil then
					arg_305_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_308_5 = 0
			local var_308_6 = 0.2

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(424121072)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 8 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 8)

				if (8 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 8)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121072", "story_v_out_424121.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121072", "story_v_out_424121.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_424121", "424121072", "story_v_out_424121.awb")

						arg_305_1:RecordAudio("424121072", var_308_12)
						arg_305_1:RecordAudio("424121072", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_424121", "424121072", "story_v_out_424121.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_424121", "424121072", "story_v_out_424121.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play424121073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 424121073
		arg_309_1.duration_ = 7.57

		local var_309_0 = {
			zh = 5.9,
			ja = 7.566
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
				arg_309_0:Play424121074(arg_309_1)
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
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 1, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10153"]) and arg_309_1.var_.actorSpriteComps10153 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps10153 = nil
			end

			local var_312_2 = arg_309_1.actors_["1094"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1094 == nil then
				arg_309_1.var_.actorSpriteComps1094 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps1094 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								iter_312_5.color = Color.New(Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_3), Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_3), (Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_3)))
							else
								local var_312_4 = Mathf.Lerp(iter_312_5.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_3)

								iter_312_5.color = Color.New(var_312_4, var_312_4, var_312_4)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps1094 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_312_7 then
						iter_312_7.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps1094 = nil
			end

			local var_312_5 = arg_309_1.actors_["10153"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10153 = var_312_5.localPosition
				var_312_5.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10153", 4)

				for iter_312_8 = 0, var_312_5.childCount - 1 do
					local var_312_6 = var_312_5:GetChild(iter_312_8)

					if var_312_6.name == "split_1" or not string.find(var_312_6.name, "split") then
						var_312_6.gameObject:SetActive(true)
					else
						var_312_6.gameObject:SetActive(false)
					end
				end
			end

			local var_312_7 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				var_312_5.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_309_1.time_ - 0) / var_312_7)
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				var_312_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_312_8 = 0
			local var_312_9 = 0.65

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(424121073)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_13 = 26 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 26)

				if (26 <= 0 and var_312_9 or var_312_9 * (utf8.len(var_312_11) / 26)) > 0 and var_312_9 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_8
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121073", "story_v_out_424121.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121073", "story_v_out_424121.awb") / 1000

					if var_312_14 + var_312_8 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_8
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_424121", "424121073", "story_v_out_424121.awb")

						arg_309_1:RecordAudio("424121073", var_312_15)
						arg_309_1:RecordAudio("424121073", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_424121", "424121073", "story_v_out_424121.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_424121", "424121073", "story_v_out_424121.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_9, arg_309_1.talkMaxDuration)

			if var_312_8 <= arg_309_1.time_ and arg_309_1.time_ < var_312_8 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_8) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_8 + var_312_16 and arg_309_1.time_ < var_312_8 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play424121074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 424121074
		arg_313_1.duration_ = 5.1

		local var_313_0 = {
			zh = 5.1,
			ja = 4.833
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
				arg_313_0:Play424121075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10153 = arg_313_1.actors_["10153"].transform.localPosition
				arg_313_1.actors_["10153"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10153", 4)

				for iter_316_0 = 0, arg_313_1.actors_["10153"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["10153"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_2" then
						var_316_0:SetAsLastSibling()
						var_316_0.gameObject:SetActive(true)

						arg_313_1.var_.actorSpriteSplit10153 = var_316_0.gameObject:GetComponent(typeof(Image))

						arg_313_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["10153"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_313_1.time_ - 0) / var_316_1)

				if arg_313_1.var_.actorSpriteSplit10153 ~= nil then
					arg_313_1.var_.actorSpriteSplit10153:SetAlpha((arg_313_1.time_ - 0) / var_316_1)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["10153"].transform.localPosition = Vector3.New(400, -395, -330)

				if arg_313_1.var_.actorSpriteSplit10153 ~= nil then
					arg_313_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_316_2 = 0
			local var_316_3 = 0.475

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
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

				local var_316_4 = arg_313_1:GetWordFromCfg(424121074)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 19 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 19)

				if (19 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 19)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121074", "story_v_out_424121.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_424121", "424121074", "story_v_out_424121.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_424121", "424121074", "story_v_out_424121.awb")

						arg_313_1:RecordAudio("424121074", var_316_9)
						arg_313_1:RecordAudio("424121074", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_424121", "424121074", "story_v_out_424121.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_424121", "424121074", "story_v_out_424121.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
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
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play424121075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 424121075
		arg_317_1.duration_ = 1

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play424121076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1094"]) and arg_317_1.var_.actorSpriteComps1094 == nil then
				arg_317_1.var_.actorSpriteComps1094 = arg_317_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1094"]) then
				if arg_317_1.var_.actorSpriteComps1094 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 1, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1094"]) and arg_317_1.var_.actorSpriteComps1094 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps1094 = nil
			end

			local var_320_2 = arg_317_1.actors_["10153"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10153 == nil then
				arg_317_1.var_.actorSpriteComps10153 = var_320_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_3 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.actorSpriteComps10153 then
					for iter_320_4, iter_320_5 in pairs(arg_317_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_320_5 then
							if arg_317_1.isInRecall_ then
								iter_320_5.color = Color.New(Mathf.Lerp(iter_320_5.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_3), Mathf.Lerp(iter_320_5.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_3), (Mathf.Lerp(iter_320_5.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_3)))
							else
								local var_320_4 = Mathf.Lerp(iter_320_5.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_3)

								iter_320_5.color = Color.New(var_320_4, var_320_4, var_320_4)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.actorSpriteComps10153 then
				for iter_320_6, iter_320_7 in pairs(arg_317_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_320_7 then
						iter_320_7.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10153 = nil
			end

			local var_320_5 = arg_317_1.actors_["1094"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1094 = var_320_5.localPosition
				var_320_5.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1094", 2)

				for iter_320_8 = 0, var_320_5.childCount - 1 do
					local var_320_6 = var_320_5:GetChild(iter_320_8)

					if var_320_6.name == "split_2" then
						var_320_6:SetAsLastSibling()
						var_320_6.gameObject:SetActive(true)

						arg_317_1.var_.actorSpriteSplit1094 = var_320_6.gameObject:GetComponent(typeof(Image))

						arg_317_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_320_7 = 0.5

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				var_320_5.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_317_1.time_ - 0) / var_320_7)

				if arg_317_1.var_.actorSpriteSplit1094 ~= nil then
					arg_317_1.var_.actorSpriteSplit1094:SetAlpha((arg_317_1.time_ - 0) / var_320_7)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				var_320_5.localPosition = Vector3.New(-380, -335, -230)

				if arg_317_1.var_.actorSpriteSplit1094 ~= nil then
					arg_317_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_320_8 = 0
			local var_320_9 = 0.05

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:GetWordFromCfg(424121075)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.text_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 2 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 2)

				if (2 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 2)) > 0 and var_320_9 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_11
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121075", "story_v_out_424121.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_424121", "424121075", "story_v_out_424121.awb") / 1000

					if var_320_14 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_8
					end

					if var_320_10.prefab_name ~= "" and arg_317_1.actors_[var_320_10.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_10.prefab_name].transform, "story_v_out_424121", "424121075", "story_v_out_424121.awb")

						arg_317_1:RecordAudio("424121075", var_320_15)
						arg_317_1:RecordAudio("424121075", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_424121", "424121075", "story_v_out_424121.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_424121", "424121075", "story_v_out_424121.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_16 and arg_317_1.time_ < var_320_8 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play424121076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 424121076
		arg_321_1.duration_ = 4.87

		local var_321_0 = {
			zh = 3.033,
			ja = 4.866
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
				arg_321_0:Play424121077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1094"]) and arg_321_1.var_.actorSpriteComps1094 == nil then
				arg_321_1.var_.actorSpriteComps1094 = arg_321_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1094"]) then
				if arg_321_1.var_.actorSpriteComps1094 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1094"]) and arg_321_1.var_.actorSpriteComps1094 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps1094 = nil
			end

			local var_324_2 = 0
			local var_324_3 = 0.45

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_4 = arg_321_1:GetWordFromCfg(424121076)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 18 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 18)

				if (18 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 18)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121076", "story_v_out_424121.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_424121", "424121076", "story_v_out_424121.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_out_424121", "424121076", "story_v_out_424121.awb")

						arg_321_1:RecordAudio("424121076", var_324_9)
						arg_321_1:RecordAudio("424121076", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_424121", "424121076", "story_v_out_424121.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_424121", "424121076", "story_v_out_424121.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play424121077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 424121077
		arg_325_1.duration_ = 5.77

		local var_325_0 = {
			zh = 3.733,
			ja = 5.766
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play424121078(arg_325_1)
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
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 1, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10153"]) and arg_325_1.var_.actorSpriteComps10153 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps10153 = nil
			end

			local var_328_2 = arg_325_1.actors_["10153"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10153 = var_328_2.localPosition
				var_328_2.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10153", 4)

				for iter_328_4 = 0, var_328_2.childCount - 1 do
					local var_328_3 = var_328_2:GetChild(iter_328_4)

					if var_328_3.name == "" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_2.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_325_1.time_ - 0) / var_328_4)
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_2.localPosition = Vector3.New(400, -395, -330)
			end

			local var_328_5 = 0
			local var_328_6 = 0.275

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(424121077)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 11 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 11)

				if (11 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 11)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121077", "story_v_out_424121.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121077", "story_v_out_424121.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_424121", "424121077", "story_v_out_424121.awb")

						arg_325_1:RecordAudio("424121077", var_328_12)
						arg_325_1:RecordAudio("424121077", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_424121", "424121077", "story_v_out_424121.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_424121", "424121077", "story_v_out_424121.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_13 and arg_325_1.time_ < var_328_5 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play424121078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 424121078
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play424121079(arg_329_1)
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
								iter_332_1.color = Color.New(Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor2.r, (arg_329_1.time_ - 0) / var_332_0), Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor2.g, (arg_329_1.time_ - 0) / var_332_0), (Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor2.b, (arg_329_1.time_ - 0) / var_332_0)))
							else
								local var_332_1 = Mathf.Lerp(iter_332_1.color.r, 0.5, (arg_329_1.time_ - 0) / var_332_0)

								iter_332_1.color = Color.New(var_332_1, var_332_1, var_332_1)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10153"]) and arg_329_1.var_.actorSpriteComps10153 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_329_1.var_.actorSpriteComps10153 = nil
			end

			local var_332_2 = arg_329_1.actors_["10153"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10153 = var_332_2.localPosition
				var_332_2.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("10153", 7)

				for iter_332_4 = 0, var_332_2.childCount - 1 do
					local var_332_3 = var_332_2:GetChild(iter_332_4)

					if var_332_3.name == "" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_2.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_329_1.time_ - 0) / var_332_4)
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_332_5 = arg_329_1.actors_["1094"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1094 = var_332_5.localPosition
				var_332_5.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1094", 7)

				for iter_332_5 = 0, var_332_5.childCount - 1 do
					local var_332_6 = var_332_5:GetChild(iter_332_5)

					if var_332_6.name == "" or not string.find(var_332_6.name, "split") then
						var_332_6.gameObject:SetActive(true)
					else
						var_332_6.gameObject:SetActive(false)
					end
				end
			end

			local var_332_7 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				var_332_5.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_329_1.time_ - 0) / var_332_7)
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				var_332_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_329_1.time_ and arg_329_1.time_ <= 0.2 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_7", "se_story_7_leaves", "")
			end

			local var_332_9 = 0
			local var_332_10 = 0.6

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_11 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(424121078).content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 24 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_11) / 24)

				if (24 <= 0 and var_332_10 or var_332_10 * (utf8.len(var_332_11) / 24)) > 0 and var_332_10 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_9
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_10, arg_329_1.talkMaxDuration)

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_9) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_9 + var_332_14 and arg_329_1.time_ < var_332_9 + var_332_14 + arg_332_0 then
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

		arg_329_1:InitPlayNodeList()
	end,
	Play424121079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 424121079
		arg_333_1.duration_ = 3.67

		local var_333_0 = {
			zh = 3.666,
			ja = 3.4
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
				arg_333_0:Play424121080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1094"]) and arg_333_1.var_.actorSpriteComps1094 == nil then
				arg_333_1.var_.actorSpriteComps1094 = arg_333_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1094"]) then
				if arg_333_1.var_.actorSpriteComps1094 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 1, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1094"]) and arg_333_1.var_.actorSpriteComps1094 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps1094 = nil
			end

			local var_336_2 = arg_333_1.actors_["1094"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1094 = var_336_2.localPosition
				var_336_2.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1094", 3)

				for iter_336_4 = 0, var_336_2.childCount - 1 do
					local var_336_3 = var_336_2:GetChild(iter_336_4)

					if var_336_3.name == "split_1" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_2.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_333_1.time_ - 0) / var_336_4)
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_336_5 = 0
			local var_336_6 = 0.275

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(424121079)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 11 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 11)

				if (11 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 11)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121079", "story_v_out_424121.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121079", "story_v_out_424121.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_424121", "424121079", "story_v_out_424121.awb")

						arg_333_1:RecordAudio("424121079", var_336_12)
						arg_333_1:RecordAudio("424121079", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_424121", "424121079", "story_v_out_424121.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_424121", "424121079", "story_v_out_424121.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play424121080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 424121080
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play424121081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1094"]) and arg_337_1.var_.actorSpriteComps1094 == nil then
				arg_337_1.var_.actorSpriteComps1094 = arg_337_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1094"]) then
				if arg_337_1.var_.actorSpriteComps1094 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_0), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_0), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_0)))
							else
								local var_340_1 = Mathf.Lerp(iter_340_1.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_0)

								iter_340_1.color = Color.New(var_340_1, var_340_1, var_340_1)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1094"]) and arg_337_1.var_.actorSpriteComps1094 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps1094 = nil
			end

			local var_340_2 = arg_337_1.actors_["1094"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1094 = var_340_2.localPosition
				var_340_2.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1094", 7)

				for iter_340_4 = 0, var_340_2.childCount - 1 do
					local var_340_3 = var_340_2:GetChild(iter_340_4)

					if var_340_3.name == "" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				var_340_2.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_337_1.time_ - 0) / var_340_4)
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				var_340_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_340_5 = 0
			local var_340_6 = 0.525

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(424121080).content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 21 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 21)

				if (21 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 21)) > 0 and var_340_6 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_10 and arg_337_1.time_ < var_340_5 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play424121081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 424121081
		arg_341_1.duration_ = 4.9

		local var_341_0 = {
			zh = 3.533,
			ja = 4.9
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
				arg_341_0:Play424121082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.475

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_1 = arg_341_1:GetWordFromCfg(424121081)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 19 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 19)

				if (19 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 19)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121081", "story_v_out_424121.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121081", "story_v_out_424121.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_424121", "424121081", "story_v_out_424121.awb")

						arg_341_1:RecordAudio("424121081", var_344_6)
						arg_341_1:RecordAudio("424121081", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_424121", "424121081", "story_v_out_424121.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_424121", "424121081", "story_v_out_424121.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play424121082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 424121082
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play424121083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.55

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_1 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(424121082).content)

				arg_345_1.text_.text = var_348_1

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_3 = 22 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 22)

				if (22 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_1) / 22)) > 0 and var_348_0 < var_348_3 then
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
	Play424121083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 424121083
		arg_349_1.duration_ = 7

		local var_349_0 = {
			zh = 5.6,
			ja = 7
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
				arg_349_0:Play424121084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.675

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:GetWordFromCfg(424121083)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 27 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 27)

				if (27 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 27)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121083", "story_v_out_424121.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_424121", "424121083", "story_v_out_424121.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_424121", "424121083", "story_v_out_424121.awb")

						arg_349_1:RecordAudio("424121083", var_352_6)
						arg_349_1:RecordAudio("424121083", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_424121", "424121083", "story_v_out_424121.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_424121", "424121083", "story_v_out_424121.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play424121084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 424121084
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play424121085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.125

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(424121084).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 45 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 45)

				if (45 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 45)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play424121085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 424121085
		arg_357_1.duration_ = 3.3

		local var_357_0 = {
			zh = 2.333,
			ja = 3.3
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
				arg_357_0:Play424121086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1094"]) and arg_357_1.var_.actorSpriteComps1094 == nil then
				arg_357_1.var_.actorSpriteComps1094 = arg_357_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1094"]) then
				if arg_357_1.var_.actorSpriteComps1094 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 1, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1094"]) and arg_357_1.var_.actorSpriteComps1094 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1094 = nil
			end

			local var_360_2 = arg_357_1.actors_["1094"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1094 = var_360_2.localPosition
				var_360_2.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1094", 3)

				for iter_360_4 = 0, var_360_2.childCount - 1 do
					local var_360_3 = var_360_2:GetChild(iter_360_4)

					if var_360_3.name == "split_4" then
						var_360_3:SetAsLastSibling()
						var_360_3.gameObject:SetActive(true)

						arg_357_1.var_.actorSpriteSplit1094 = var_360_3.gameObject:GetComponent(typeof(Image))

						arg_357_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_360_4 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				var_360_2.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_357_1.time_ - 0) / var_360_4)

				if arg_357_1.var_.actorSpriteSplit1094 ~= nil then
					arg_357_1.var_.actorSpriteSplit1094:SetAlpha((arg_357_1.time_ - 0) / var_360_4)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				var_360_2.localPosition = Vector3.New(0, -335, -230)

				if arg_357_1.var_.actorSpriteSplit1094 ~= nil then
					arg_357_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_360_5 = 0
			local var_360_6 = 0.2

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(424121085)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 8 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 8)

				if (8 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 8)) > 0 and var_360_6 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121085", "story_v_out_424121.awb") ~= 0 then
					local var_360_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121085", "story_v_out_424121.awb") / 1000

					if var_360_11 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_5
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_out_424121", "424121085", "story_v_out_424121.awb")

						arg_357_1:RecordAudio("424121085", var_360_12)
						arg_357_1:RecordAudio("424121085", var_360_12)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_424121", "424121085", "story_v_out_424121.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_424121", "424121085", "story_v_out_424121.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_13 and arg_357_1.time_ < var_360_5 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play424121086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 424121086
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play424121087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1094"]) and arg_361_1.var_.actorSpriteComps1094 == nil then
				arg_361_1.var_.actorSpriteComps1094 = arg_361_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1094"]) then
				if arg_361_1.var_.actorSpriteComps1094 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor2.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor2.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor2.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 0.5, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1094"]) and arg_361_1.var_.actorSpriteComps1094 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_361_1.var_.actorSpriteComps1094 = nil
			end

			local var_364_2 = arg_361_1.actors_["1094"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1094 = var_364_2.localPosition
				var_364_2.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("1094", 7)

				for iter_364_4 = 0, var_364_2.childCount - 1 do
					local var_364_3 = var_364_2:GetChild(iter_364_4)

					if var_364_3.name == "" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_2.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_361_1.time_ - 0) / var_364_4)
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_361_1.time_ and arg_361_1.time_ <= 0.133333333333333 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_walk02", "")
			end

			local var_364_6 = 0
			local var_364_7 = 0.825

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_8 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(424121086).content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_10 = 33 <= 0 and var_364_7 or var_364_7 * (utf8.len(var_364_8) / 33)

				if (33 <= 0 and var_364_7 or var_364_7 * (utf8.len(var_364_8) / 33)) > 0 and var_364_7 < var_364_10 then
					arg_361_1.talkMaxDuration = var_364_10

					if var_364_10 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_10 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_11 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_11 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_11

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_11 and arg_361_1.time_ < var_364_6 + var_364_11 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play424121087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 424121087
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play424121088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.175

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
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

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(424121087).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 7 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 7)

				if (7 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 7)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play424121088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 424121088
		arg_369_1.duration_ = 4.47

		local var_369_0 = {
			zh = 4.466,
			ja = 4.266
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
				arg_369_0:Play424121089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1094"]) and arg_369_1.var_.actorSpriteComps1094 == nil then
				arg_369_1.var_.actorSpriteComps1094 = arg_369_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1094"]) then
				if arg_369_1.var_.actorSpriteComps1094 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1094"]) and arg_369_1.var_.actorSpriteComps1094 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1094 = nil
			end

			local var_372_2 = arg_369_1.actors_["1094"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1094 = var_372_2.localPosition
				var_372_2.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1094", 3)

				for iter_372_4 = 0, var_372_2.childCount - 1 do
					local var_372_3 = var_372_2:GetChild(iter_372_4)

					if var_372_3.name == "split_2" then
						var_372_3:SetAsLastSibling()
						var_372_3.gameObject:SetActive(true)

						arg_369_1.var_.actorSpriteSplit1094 = var_372_3.gameObject:GetComponent(typeof(Image))

						arg_369_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_372_4 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_2.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_369_1.time_ - 0) / var_372_4)

				if arg_369_1.var_.actorSpriteSplit1094 ~= nil then
					arg_369_1.var_.actorSpriteSplit1094:SetAlpha((arg_369_1.time_ - 0) / var_372_4)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_2.localPosition = Vector3.New(0, -335, -230)

				if arg_369_1.var_.actorSpriteSplit1094 ~= nil then
					arg_369_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_372_5 = 0
			local var_372_6 = 0.425

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(424121088)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_10 = 17 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 17)

				if (17 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 17)) > 0 and var_372_6 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121088", "story_v_out_424121.awb") ~= 0 then
					local var_372_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121088", "story_v_out_424121.awb") / 1000

					if var_372_11 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_5
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_424121", "424121088", "story_v_out_424121.awb")

						arg_369_1:RecordAudio("424121088", var_372_12)
						arg_369_1:RecordAudio("424121088", var_372_12)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_424121", "424121088", "story_v_out_424121.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_424121", "424121088", "story_v_out_424121.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play424121089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 424121089
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play424121090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1094"]) and arg_373_1.var_.actorSpriteComps1094 == nil then
				arg_373_1.var_.actorSpriteComps1094 = arg_373_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1094"]) then
				if arg_373_1.var_.actorSpriteComps1094 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1094"]) and arg_373_1.var_.actorSpriteComps1094 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps1094 = nil
			end

			local var_376_2 = 0
			local var_376_3 = 0.4

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
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

				local var_376_4 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(424121089).content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_6 = 16 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 16)

				if (16 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_4) / 16)) > 0 and var_376_3 < var_376_6 then
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
	Play424121090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 424121090
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play424121091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0.0749999999999999 < arg_377_1.time_ and arg_377_1.time_ <= 0.0749999999999999 + arg_380_0 then
				arg_377_1:AudioAction("play", "effect", "se_story_146", "se_story_146_straw", "")
			end

			local var_380_1 = 0
			local var_380_2 = 1.075

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(424121090).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 43 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 43)

				if (43 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 43)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play424121091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 424121091
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play424121092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.8

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(424121091).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 32 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 32)

				if (32 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 32)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play424121092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 424121092
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play424121093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.675

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

				local var_388_1 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(424121092).content)

				arg_385_1.text_.text = var_388_1

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_3 = 27 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 27)

				if (27 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_1) / 27)) > 0 and var_388_0 < var_388_3 then
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
	Play424121093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424121093
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424121094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.475

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(424121093).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 19 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 19)

				if (19 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 19)) > 0 and var_392_0 < var_392_3 then
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
	Play424121094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 424121094
		arg_393_1.duration_ = 4.57

		local var_393_0 = {
			zh = 4.566,
			ja = 3.933
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
				arg_393_0:Play424121095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1094"]) and arg_393_1.var_.actorSpriteComps1094 == nil then
				arg_393_1.var_.actorSpriteComps1094 = arg_393_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1094"]) then
				if arg_393_1.var_.actorSpriteComps1094 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								iter_396_1.color = Color.New(Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_0), Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_0), (Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_0)))
							else
								local var_396_1 = Mathf.Lerp(iter_396_1.color.r, 1, (arg_393_1.time_ - 0) / var_396_0)

								iter_396_1.color = Color.New(var_396_1, var_396_1, var_396_1)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1094"]) and arg_393_1.var_.actorSpriteComps1094 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1094 = nil
			end

			local var_396_2 = arg_393_1.actors_["1094"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1094 = var_396_2.localPosition
				var_396_2.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1094", 3)

				for iter_396_4 = 0, var_396_2.childCount - 1 do
					local var_396_3 = var_396_2:GetChild(iter_396_4)

					if var_396_3.name == "split_1" then
						var_396_3:SetAsLastSibling()
						var_396_3.gameObject:SetActive(true)

						arg_393_1.var_.actorSpriteSplit1094 = var_396_3.gameObject:GetComponent(typeof(Image))

						arg_393_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_396_4 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				var_396_2.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_393_1.time_ - 0) / var_396_4)

				if arg_393_1.var_.actorSpriteSplit1094 ~= nil then
					arg_393_1.var_.actorSpriteSplit1094:SetAlpha((arg_393_1.time_ - 0) / var_396_4)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				var_396_2.localPosition = Vector3.New(0, -335, -230)

				if arg_393_1.var_.actorSpriteSplit1094 ~= nil then
					arg_393_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_396_5 = 0
			local var_396_6 = 0.35

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
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

				local var_396_7 = arg_393_1:GetWordFromCfg(424121094)
				local var_396_8 = arg_393_1:FormatText(var_396_7.content)

				arg_393_1.text_.text = var_396_8

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 14 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 14)

				if (14 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 14)) > 0 and var_396_6 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_8
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121094", "story_v_out_424121.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121094", "story_v_out_424121.awb") / 1000

					if var_396_11 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_5
					end

					if var_396_7.prefab_name ~= "" and arg_393_1.actors_[var_396_7.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_7.prefab_name].transform, "story_v_out_424121", "424121094", "story_v_out_424121.awb")

						arg_393_1:RecordAudio("424121094", var_396_12)
						arg_393_1:RecordAudio("424121094", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_424121", "424121094", "story_v_out_424121.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_424121", "424121094", "story_v_out_424121.awb")
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
				actorName = "1094",
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
	Play424121095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424121095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play424121096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1094"]) and arg_397_1.var_.actorSpriteComps1094 == nil then
				arg_397_1.var_.actorSpriteComps1094 = arg_397_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1094"]) then
				if arg_397_1.var_.actorSpriteComps1094 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1094"]) and arg_397_1.var_.actorSpriteComps1094 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1094 = nil
			end

			local var_400_2 = 0
			local var_400_3 = 1.05

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
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

				local var_400_4 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(424121095).content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 42 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 42)

				if (42 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 42)) > 0 and var_400_3 < var_400_6 then
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
	Play424121096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424121096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424121097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.925

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

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(424121096).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 37 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 37)

				if (37 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 37)) > 0 and var_404_0 < var_404_3 then
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
	Play424121097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424121097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424121098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.575

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(424121097).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 23 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 23)

				if (23 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 23)) > 0 and var_408_0 < var_408_3 then
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
	Play424121098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424121098
		arg_409_1.duration_ = 12.93

		local var_409_0 = {
			zh = 8.9,
			ja = 12.933
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
				arg_409_0:Play424121099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1094"]) and arg_409_1.var_.actorSpriteComps1094 == nil then
				arg_409_1.var_.actorSpriteComps1094 = arg_409_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1094"]) then
				if arg_409_1.var_.actorSpriteComps1094 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 1, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1094"]) and arg_409_1.var_.actorSpriteComps1094 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps1094 = nil
			end

			local var_412_2 = arg_409_1.actors_["1094"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1094 = var_412_2.localPosition
				var_412_2.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1094", 3)

				for iter_412_4 = 0, var_412_2.childCount - 1 do
					local var_412_3 = var_412_2:GetChild(iter_412_4)

					if var_412_3.name == "split_4" then
						var_412_3:SetAsLastSibling()
						var_412_3.gameObject:SetActive(true)

						arg_409_1.var_.actorSpriteSplit1094 = var_412_3.gameObject:GetComponent(typeof(Image))

						arg_409_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_412_4 = 0.775

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				var_412_2.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_409_1.time_ - 0) / var_412_4)

				if arg_409_1.var_.actorSpriteSplit1094 ~= nil then
					arg_409_1.var_.actorSpriteSplit1094:SetAlpha((arg_409_1.time_ - 0) / var_412_4)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				var_412_2.localPosition = Vector3.New(0, -335, -230)

				if arg_409_1.var_.actorSpriteSplit1094 ~= nil then
					arg_409_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_412_5 = 0
			local var_412_6 = 0.775

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_7 = arg_409_1:GetWordFromCfg(424121098)
				local var_412_8 = arg_409_1:FormatText(var_412_7.content)

				arg_409_1.text_.text = var_412_8

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_10 = 31 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_8) / 31)

				if (31 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_8) / 31)) > 0 and var_412_6 < var_412_10 then
					arg_409_1.talkMaxDuration = var_412_10

					if var_412_10 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_8
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121098", "story_v_out_424121.awb") ~= 0 then
					local var_412_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121098", "story_v_out_424121.awb") / 1000

					if var_412_11 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_11 + var_412_5
					end

					if var_412_7.prefab_name ~= "" and arg_409_1.actors_[var_412_7.prefab_name] ~= nil then
						local var_412_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_7.prefab_name].transform, "story_v_out_424121", "424121098", "story_v_out_424121.awb")

						arg_409_1:RecordAudio("424121098", var_412_12)
						arg_409_1:RecordAudio("424121098", var_412_12)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_424121", "424121098", "story_v_out_424121.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_424121", "424121098", "story_v_out_424121.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_13 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_13 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_13

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_13 and arg_409_1.time_ < var_412_5 + var_412_13 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.775,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play424121099 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424121099
		arg_413_1.duration_ = 1

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"

			SetActive(arg_413_1.choicesGo_, true)

			for iter_414_0, iter_414_1 in ipairs(arg_413_1.choices_) do
				SetActive(iter_414_1.go, iter_414_0 <= 2)
			end

			arg_413_1.choices_[1].txt.text = arg_413_1:FormatText(StoryChoiceCfg[1490].name)
			arg_413_1.choices_[2].txt.text = arg_413_1:FormatText(StoryChoiceCfg[1491].name)
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424121100(arg_413_1)
			end

			if arg_415_0 == 2 then
				arg_413_0:Play424121100(arg_413_1)
			end

			arg_413_1:RecordChoiceLog(424121099, 1490, 1491)
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1094"]) and arg_413_1.var_.actorSpriteComps1094 == nil then
				arg_413_1.var_.actorSpriteComps1094 = arg_413_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1094"]) then
				if arg_413_1.var_.actorSpriteComps1094 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								iter_416_1.color = Color.New(Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_0), Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_0), (Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_0)))
							else
								local var_416_1 = Mathf.Lerp(iter_416_1.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_0)

								iter_416_1.color = Color.New(var_416_1, var_416_1, var_416_1)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1094"]) and arg_413_1.var_.actorSpriteComps1094 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps1094 = nil
			end

			local var_416_2 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			if arg_413_1.time_ >= var_416_2 + 0.6 and arg_413_1.time_ < var_416_2 + 0.6 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play424121100 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 424121100
		arg_417_1.duration_ = 6.2

		local var_417_0 = {
			zh = 4.133,
			ja = 6.2
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
				arg_417_0:Play424121101(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1094"]) and arg_417_1.var_.actorSpriteComps1094 == nil then
				arg_417_1.var_.actorSpriteComps1094 = arg_417_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1094"]) then
				if arg_417_1.var_.actorSpriteComps1094 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1094"]) and arg_417_1.var_.actorSpriteComps1094 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps1094 = nil
			end

			local var_420_2 = arg_417_1.actors_["1094"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1094 = var_420_2.localPosition
				var_420_2.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1094", 3)

				for iter_420_4 = 0, var_420_2.childCount - 1 do
					local var_420_3 = var_420_2:GetChild(iter_420_4)

					if var_420_3.name == "split_1" then
						var_420_3:SetAsLastSibling()
						var_420_3.gameObject:SetActive(true)

						arg_417_1.var_.actorSpriteSplit1094 = var_420_3.gameObject:GetComponent(typeof(Image))

						arg_417_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_420_4 = 0.5

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				var_420_2.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_417_1.time_ - 0) / var_420_4)

				if arg_417_1.var_.actorSpriteSplit1094 ~= nil then
					arg_417_1.var_.actorSpriteSplit1094:SetAlpha((arg_417_1.time_ - 0) / var_420_4)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				var_420_2.localPosition = Vector3.New(0, -335, -230)

				if arg_417_1.var_.actorSpriteSplit1094 ~= nil then
					arg_417_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_420_5 = 0
			local var_420_6 = 0.275

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_7 = arg_417_1:GetWordFromCfg(424121100)
				local var_420_8 = arg_417_1:FormatText(var_420_7.content)

				arg_417_1.text_.text = var_420_8

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 11 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 11)

				if (11 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 11)) > 0 and var_420_6 < var_420_10 then
					arg_417_1.talkMaxDuration = var_420_10

					if var_420_10 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_8
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121100", "story_v_out_424121.awb") ~= 0 then
					local var_420_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121100", "story_v_out_424121.awb") / 1000

					if var_420_11 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_5
					end

					if var_420_7.prefab_name ~= "" and arg_417_1.actors_[var_420_7.prefab_name] ~= nil then
						local var_420_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_7.prefab_name].transform, "story_v_out_424121", "424121100", "story_v_out_424121.awb")

						arg_417_1:RecordAudio("424121100", var_420_12)
						arg_417_1:RecordAudio("424121100", var_420_12)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_424121", "424121100", "story_v_out_424121.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_424121", "424121100", "story_v_out_424121.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_13 and arg_417_1.time_ < var_420_5 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play424121101 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 424121101
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play424121102(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1094"]) and arg_421_1.var_.actorSpriteComps1094 == nil then
				arg_421_1.var_.actorSpriteComps1094 = arg_421_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1094"]) then
				if arg_421_1.var_.actorSpriteComps1094 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1094"]) and arg_421_1.var_.actorSpriteComps1094 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps1094 = nil
			end

			local var_424_2 = 0
			local var_424_3 = 0.85

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_4 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(424121101).content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_6 = 34 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 34)

				if (34 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 34)) > 0 and var_424_3 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_2
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_3, arg_421_1.talkMaxDuration)

			if var_424_2 <= arg_421_1.time_ and arg_421_1.time_ < var_424_2 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_2) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_2 + var_424_7 and arg_421_1.time_ < var_424_2 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play424121102 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 424121102
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play424121103(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.175

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(424121102).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 7 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 7)

				if (7 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 7)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play424121103 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 424121103
		arg_429_1.duration_ = 11.1

		local var_429_0 = {
			zh = 7.766,
			ja = 11.1
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play424121104(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1094"]) and arg_429_1.var_.actorSpriteComps1094 == nil then
				arg_429_1.var_.actorSpriteComps1094 = arg_429_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1094"]) then
				if arg_429_1.var_.actorSpriteComps1094 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								iter_432_1.color = Color.New(Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor1.r, (arg_429_1.time_ - 0) / var_432_0), Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor1.g, (arg_429_1.time_ - 0) / var_432_0), (Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor1.b, (arg_429_1.time_ - 0) / var_432_0)))
							else
								local var_432_1 = Mathf.Lerp(iter_432_1.color.r, 1, (arg_429_1.time_ - 0) / var_432_0)

								iter_432_1.color = Color.New(var_432_1, var_432_1, var_432_1)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1094"]) and arg_429_1.var_.actorSpriteComps1094 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_429_1.var_.actorSpriteComps1094 = nil
			end

			local var_432_2 = arg_429_1.actors_["1094"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1094 = var_432_2.localPosition
				var_432_2.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("1094", 3)

				for iter_432_4 = 0, var_432_2.childCount - 1 do
					local var_432_3 = var_432_2:GetChild(iter_432_4)

					if var_432_3.name == "split_2" then
						var_432_3:SetAsLastSibling()
						var_432_3.gameObject:SetActive(true)

						arg_429_1.var_.actorSpriteSplit1094 = var_432_3.gameObject:GetComponent(typeof(Image))

						arg_429_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_432_4 = 0.5

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				var_432_2.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_429_1.time_ - 0) / var_432_4)

				if arg_429_1.var_.actorSpriteSplit1094 ~= nil then
					arg_429_1.var_.actorSpriteSplit1094:SetAlpha((arg_429_1.time_ - 0) / var_432_4)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				var_432_2.localPosition = Vector3.New(0, -335, -230)

				if arg_429_1.var_.actorSpriteSplit1094 ~= nil then
					arg_429_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_432_5 = 0
			local var_432_6 = 0.7

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_7 = arg_429_1:GetWordFromCfg(424121103)
				local var_432_8 = arg_429_1:FormatText(var_432_7.content)

				arg_429_1.text_.text = var_432_8

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_10 = 28 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 28)

				if (28 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 28)) > 0 and var_432_6 < var_432_10 then
					arg_429_1.talkMaxDuration = var_432_10

					if var_432_10 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_5
					end
				end

				arg_429_1.text_.text = var_432_8
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121103", "story_v_out_424121.awb") ~= 0 then
					local var_432_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121103", "story_v_out_424121.awb") / 1000

					if var_432_11 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_5
					end

					if var_432_7.prefab_name ~= "" and arg_429_1.actors_[var_432_7.prefab_name] ~= nil then
						local var_432_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_7.prefab_name].transform, "story_v_out_424121", "424121103", "story_v_out_424121.awb")

						arg_429_1:RecordAudio("424121103", var_432_12)
						arg_429_1:RecordAudio("424121103", var_432_12)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_424121", "424121103", "story_v_out_424121.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_424121", "424121103", "story_v_out_424121.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_13 = math.max(var_432_6, arg_429_1.talkMaxDuration)

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_13 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_5) / var_432_13

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_5 + var_432_13 and arg_429_1.time_ < var_432_5 + var_432_13 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play424121104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 424121104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play424121105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1094"]) and arg_433_1.var_.actorSpriteComps1094 == nil then
				arg_433_1.var_.actorSpriteComps1094 = arg_433_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1094"]) then
				if arg_433_1.var_.actorSpriteComps1094 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								iter_436_1.color = Color.New(Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor2.r, (arg_433_1.time_ - 0) / var_436_0), Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor2.g, (arg_433_1.time_ - 0) / var_436_0), (Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor2.b, (arg_433_1.time_ - 0) / var_436_0)))
							else
								local var_436_1 = Mathf.Lerp(iter_436_1.color.r, 0.5, (arg_433_1.time_ - 0) / var_436_0)

								iter_436_1.color = Color.New(var_436_1, var_436_1, var_436_1)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1094"]) and arg_433_1.var_.actorSpriteComps1094 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_436_3 then
						iter_436_3.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_433_1.var_.actorSpriteComps1094 = nil
			end

			local var_436_2 = arg_433_1.actors_["1094"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1094 = var_436_2.localPosition
				var_436_2.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("1094", 7)

				for iter_436_4 = 0, var_436_2.childCount - 1 do
					local var_436_3 = var_436_2:GetChild(iter_436_4)

					if var_436_3.name == "" or not string.find(var_436_3.name, "split") then
						var_436_3.gameObject:SetActive(true)
					else
						var_436_3.gameObject:SetActive(false)
					end
				end
			end

			local var_436_4 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				var_436_2.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_433_1.time_ - 0) / var_436_4)
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				var_436_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_436_5 = 0
			local var_436_6 = 0.875

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_7 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(424121104).content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 35 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_7) / 35)

				if (35 <= 0 and var_436_6 or var_436_6 * (utf8.len(var_436_7) / 35)) > 0 and var_436_6 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_5 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_5
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_10 = math.max(var_436_6, arg_433_1.talkMaxDuration)

			if var_436_5 <= arg_433_1.time_ and arg_433_1.time_ < var_436_5 + var_436_10 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_5) / var_436_10

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_5 + var_436_10 and arg_433_1.time_ < var_436_5 + var_436_10 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play424121105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 424121105
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play424121106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.85

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(424121105).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 34 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 34)

				if (34 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 34)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play424121106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424121106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play424121107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.275

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

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(424121106).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 11 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 11)

				if (11 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 11)) > 0 and var_444_0 < var_444_3 then
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
	Play424121107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424121107
		arg_445_1.duration_ = 1.73

		local var_445_0 = {
			zh = 1.433,
			ja = 1.733
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
				arg_445_0:Play424121108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1094"]) and arg_445_1.var_.actorSpriteComps1094 == nil then
				arg_445_1.var_.actorSpriteComps1094 = arg_445_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1094"]) then
				if arg_445_1.var_.actorSpriteComps1094 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1094"]) and arg_445_1.var_.actorSpriteComps1094 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_445_1.var_.actorSpriteComps1094 = nil
			end

			local var_448_2 = arg_445_1.actors_["1094"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1094 = var_448_2.localPosition
				var_448_2.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("1094", 3)

				for iter_448_4 = 0, var_448_2.childCount - 1 do
					local var_448_3 = var_448_2:GetChild(iter_448_4)

					if var_448_3.name == "split_1" or not string.find(var_448_3.name, "split") then
						var_448_3.gameObject:SetActive(true)
					else
						var_448_3.gameObject:SetActive(false)
					end
				end
			end

			local var_448_4 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				var_448_2.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_445_1.time_ - 0) / var_448_4)
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				var_448_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_448_5 = 0
			local var_448_6 = 0.15

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:GetWordFromCfg(424121107)
				local var_448_8 = arg_445_1:FormatText(var_448_7.content)

				arg_445_1.text_.text = var_448_8

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_10 = 6 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 6)

				if (6 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_8) / 6)) > 0 and var_448_6 < var_448_10 then
					arg_445_1.talkMaxDuration = var_448_10

					if var_448_10 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_8
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121107", "story_v_out_424121.awb") ~= 0 then
					local var_448_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121107", "story_v_out_424121.awb") / 1000

					if var_448_11 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_11 + var_448_5
					end

					if var_448_7.prefab_name ~= "" and arg_445_1.actors_[var_448_7.prefab_name] ~= nil then
						local var_448_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_7.prefab_name].transform, "story_v_out_424121", "424121107", "story_v_out_424121.awb")

						arg_445_1:RecordAudio("424121107", var_448_12)
						arg_445_1:RecordAudio("424121107", var_448_12)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_424121", "424121107", "story_v_out_424121.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_424121", "424121107", "story_v_out_424121.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play424121108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424121108
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play424121109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1094"]) and arg_449_1.var_.actorSpriteComps1094 == nil then
				arg_449_1.var_.actorSpriteComps1094 = arg_449_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1094"]) then
				if arg_449_1.var_.actorSpriteComps1094 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1094"]) and arg_449_1.var_.actorSpriteComps1094 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_449_1.var_.actorSpriteComps1094 = nil
			end

			local var_452_2 = 0
			local var_452_3 = 0.25

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

				local var_452_4 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(424121108).content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_6 = 10 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 10)

				if (10 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 10)) > 0 and var_452_3 < var_452_6 then
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
	Play424121109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424121109
		arg_453_1.duration_ = 20.57

		local var_453_0 = {
			zh = 14.8,
			ja = 20.566
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
				arg_453_0:Play424121110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1094"]) and arg_453_1.var_.actorSpriteComps1094 == nil then
				arg_453_1.var_.actorSpriteComps1094 = arg_453_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1094"]) then
				if arg_453_1.var_.actorSpriteComps1094 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1094"]) and arg_453_1.var_.actorSpriteComps1094 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_453_1.var_.actorSpriteComps1094 = nil
			end

			local var_456_2 = arg_453_1.actors_["1094"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1094 = var_456_2.localPosition
				var_456_2.localScale = Vector3.New(1, 1, 1)

				arg_453_1:CheckSpriteTmpPos("1094", 3)

				for iter_456_4 = 0, var_456_2.childCount - 1 do
					local var_456_3 = var_456_2:GetChild(iter_456_4)

					if var_456_3.name == "split_4" then
						var_456_3:SetAsLastSibling()
						var_456_3.gameObject:SetActive(true)

						arg_453_1.var_.actorSpriteSplit1094 = var_456_3.gameObject:GetComponent(typeof(Image))

						arg_453_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_456_4 = 0.5

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				var_456_2.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_453_1.time_ - 0) / var_456_4)

				if arg_453_1.var_.actorSpriteSplit1094 ~= nil then
					arg_453_1.var_.actorSpriteSplit1094:SetAlpha((arg_453_1.time_ - 0) / var_456_4)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				var_456_2.localPosition = Vector3.New(0, -335, -230)

				if arg_453_1.var_.actorSpriteSplit1094 ~= nil then
					arg_453_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_456_5 = 0
			local var_456_6 = 1.125

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_7 = arg_453_1:GetWordFromCfg(424121109)
				local var_456_8 = arg_453_1:FormatText(var_456_7.content)

				arg_453_1.text_.text = var_456_8

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_10 = 45 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 45)

				if (45 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 45)) > 0 and var_456_6 < var_456_10 then
					arg_453_1.talkMaxDuration = var_456_10

					if var_456_10 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_5
					end
				end

				arg_453_1.text_.text = var_456_8
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121109", "story_v_out_424121.awb") ~= 0 then
					local var_456_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121109", "story_v_out_424121.awb") / 1000

					if var_456_11 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_5
					end

					if var_456_7.prefab_name ~= "" and arg_453_1.actors_[var_456_7.prefab_name] ~= nil then
						local var_456_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_7.prefab_name].transform, "story_v_out_424121", "424121109", "story_v_out_424121.awb")

						arg_453_1:RecordAudio("424121109", var_456_12)
						arg_453_1:RecordAudio("424121109", var_456_12)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_424121", "424121109", "story_v_out_424121.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_424121", "424121109", "story_v_out_424121.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play424121110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424121110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play424121111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1094"]) and arg_457_1.var_.actorSpriteComps1094 == nil then
				arg_457_1.var_.actorSpriteComps1094 = arg_457_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_0 = 0.2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1094"]) then
				if arg_457_1.var_.actorSpriteComps1094 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1094"]) and arg_457_1.var_.actorSpriteComps1094 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_460_3 then
						iter_460_3.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_457_1.var_.actorSpriteComps1094 = nil
			end

			local var_460_2 = 0
			local var_460_3 = 0.3

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

				local var_460_4 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(424121110).content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 12 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 12)

				if (12 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 12)) > 0 and var_460_3 < var_460_6 then
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
	Play424121111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424121111
		arg_461_1.duration_ = 7.63

		local var_461_0 = {
			zh = 7.366,
			ja = 7.633
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play424121112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1094"]) and arg_461_1.var_.actorSpriteComps1094 == nil then
				arg_461_1.var_.actorSpriteComps1094 = arg_461_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1094"]) then
				if arg_461_1.var_.actorSpriteComps1094 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								iter_464_1.color = Color.New(Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, (arg_461_1.time_ - 0) / var_464_0), Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, (arg_461_1.time_ - 0) / var_464_0), (Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, (arg_461_1.time_ - 0) / var_464_0)))
							else
								local var_464_1 = Mathf.Lerp(iter_464_1.color.r, 1, (arg_461_1.time_ - 0) / var_464_0)

								iter_464_1.color = Color.New(var_464_1, var_464_1, var_464_1)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1094"]) and arg_461_1.var_.actorSpriteComps1094 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps1094 = nil
			end

			local var_464_2 = arg_461_1.actors_["1094"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1094 = var_464_2.localPosition
				var_464_2.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("1094", 3)

				for iter_464_4 = 0, var_464_2.childCount - 1 do
					local var_464_3 = var_464_2:GetChild(iter_464_4)

					if var_464_3.name == "split_1" then
						var_464_3:SetAsLastSibling()
						var_464_3.gameObject:SetActive(true)

						arg_461_1.var_.actorSpriteSplit1094 = var_464_3.gameObject:GetComponent(typeof(Image))

						arg_461_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_464_4 = 0.5

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_461_1.time_ - 0) / var_464_4)

				if arg_461_1.var_.actorSpriteSplit1094 ~= nil then
					arg_461_1.var_.actorSpriteSplit1094:SetAlpha((arg_461_1.time_ - 0) / var_464_4)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(0, -335, -230)

				if arg_461_1.var_.actorSpriteSplit1094 ~= nil then
					arg_461_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_464_5 = 0
			local var_464_6 = 0.6

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:GetWordFromCfg(424121111)
				local var_464_8 = arg_461_1:FormatText(var_464_7.content)

				arg_461_1.text_.text = var_464_8

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_10 = 24 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 24)

				if (24 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 24)) > 0 and var_464_6 < var_464_10 then
					arg_461_1.talkMaxDuration = var_464_10

					if var_464_10 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_8
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424121", "424121111", "story_v_out_424121.awb") ~= 0 then
					local var_464_11 = manager.audio:GetVoiceLength("story_v_out_424121", "424121111", "story_v_out_424121.awb") / 1000

					if var_464_11 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_11 + var_464_5
					end

					if var_464_7.prefab_name ~= "" and arg_461_1.actors_[var_464_7.prefab_name] ~= nil then
						local var_464_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_7.prefab_name].transform, "story_v_out_424121", "424121111", "story_v_out_424121.awb")

						arg_461_1:RecordAudio("424121111", var_464_12)
						arg_461_1:RecordAudio("424121111", var_464_12)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_424121", "424121111", "story_v_out_424121.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_424121", "424121111", "story_v_out_424121.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_13 = math.max(var_464_6, arg_461_1.talkMaxDuration)

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_13 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_5) / var_464_13

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_5 + var_464_13 and arg_461_1.time_ < var_464_5 + var_464_13 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play424121112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424121112
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424121113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1094"]) and arg_465_1.var_.actorSpriteComps1094 == nil then
				arg_465_1.var_.actorSpriteComps1094 = arg_465_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1094"]) then
				if arg_465_1.var_.actorSpriteComps1094 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								iter_468_1.color = Color.New(Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, (arg_465_1.time_ - 0) / var_468_0), Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, (arg_465_1.time_ - 0) / var_468_0), (Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, (arg_465_1.time_ - 0) / var_468_0)))
							else
								local var_468_1 = Mathf.Lerp(iter_468_1.color.r, 0.5, (arg_465_1.time_ - 0) / var_468_0)

								iter_468_1.color = Color.New(var_468_1, var_468_1, var_468_1)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1094"]) and arg_465_1.var_.actorSpriteComps1094 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps1094 = nil
			end

			local var_468_2 = 0
			local var_468_3 = 0.375

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(424121112).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 15 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 15)

				if (15 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 15)) > 0 and var_468_3 < var_468_6 then
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

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play424121113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 424121113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play424121114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1094 = arg_469_1.actors_["1094"].transform.localPosition
				arg_469_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("1094", 7)

				for iter_472_0 = 0, arg_469_1.actors_["1094"].transform.childCount - 1 do
					local var_472_0 = arg_469_1.actors_["1094"].transform:GetChild(iter_472_0)

					if var_472_0.name == "" or not string.find(var_472_0.name, "split") then
						var_472_0.gameObject:SetActive(true)
					else
						var_472_0.gameObject:SetActive(false)
					end
				end
			end

			local var_472_1 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_1 then
				arg_469_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_469_1.time_ - 0) / var_472_1)
			end

			if arg_469_1.time_ >= 0 + var_472_1 and arg_469_1.time_ < 0 + var_472_1 + arg_472_0 then
				arg_469_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_472_2 = 0
			local var_472_3 = 0.9

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(424121113).content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_6 = 36 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_4) / 36)

				if (36 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_4) / 36)) > 0 and var_472_3 < var_472_6 then
					arg_469_1.talkMaxDuration = var_472_6

					if var_472_6 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_7 and arg_469_1.time_ < var_472_2 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
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

		arg_469_1:InitPlayNodeList()
	end,
	Play424121114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 424121114
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play424121115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 1

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(424121114).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 40 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 40)

				if (40 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 40)) > 0 and var_476_0 < var_476_3 then
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
	Play424121115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 424121115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play424121116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.325

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(424121115).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 13 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 13)

				if (13 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 13)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play424121116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 424121116
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play424121117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.525

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(424121116).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 21 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 21)

				if (21 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 21)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play424121117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424121117
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424121118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.725

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(424121117).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 29 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 29)

				if (29 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 29)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424121118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 424121118
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play424121119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 1.3

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(424121118).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 52 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 52)

				if (52 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 52)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play424121119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 424121119
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
			arg_493_1.auto_ = false
		end

		function arg_493_1.playNext_(arg_495_0)
			arg_493_1.onStoryFinished_()
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.65

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(424121119).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 26 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 26)

				if (26 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 26)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0116a",
		"TextureConfig/Background/SS2404",
		"TextureConfig/Background/SS2404a",
		"TextureConfig/Background/ST0116"
	},
	voices = {
		"story_v_out_424121.awb"
	}
}
