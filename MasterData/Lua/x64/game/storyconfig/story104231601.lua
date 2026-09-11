return {
	Play423161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play423161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I25f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25f")
				var_4_0.name = "I25f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25f

				arg_1_1.bgs_.I25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25f" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.475

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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(423161001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 19 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 19)

				if (19 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 19)) > 0 and var_4_17 < var_4_21 then
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
	Play423161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423161002
		arg_9_1.duration_ = 3.13

		local var_9_0 = {
			zh = 2,
			ja = 3.133
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
				arg_9_0:Play423161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1083"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1083"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1083"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["1083"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1083 == nil then
				arg_9_1.var_.actorSpriteComps1083 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps1083 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps1083 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1083 = nil
			end

			local var_12_5 = arg_9_1.actors_["1083"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1083 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1083", 3)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "split_7" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue1083 = var_12_8.alpha
					arg_9_1.var_.characterEffect1083 = var_12_8
				end

				arg_9_1.var_.alphaOldValue1083 = 0
			end

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect1083 then
					arg_9_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1083, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect1083 then
				arg_9_1.var_.characterEffect1083.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(423161002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 10 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 10)

				if (10 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 10)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161002", "story_v_out_423161.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_423161", "423161002", "story_v_out_423161.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_423161", "423161002", "story_v_out_423161.awb")

						arg_9_1:RecordAudio("423161002", var_12_17)
						arg_9_1:RecordAudio("423161002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423161", "423161002", "story_v_out_423161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423161", "423161002", "story_v_out_423161.awb")
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
	Play423161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423161003
		arg_13_1.duration_ = 4.8

		local var_13_0 = {
			zh = 2.9,
			ja = 4.8
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
				arg_13_0:Play423161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(423161003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)

				if (18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161003", "story_v_out_423161.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_423161", "423161003", "story_v_out_423161.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_423161", "423161003", "story_v_out_423161.awb")

						arg_13_1:RecordAudio("423161003", var_16_6)
						arg_13_1:RecordAudio("423161003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423161", "423161003", "story_v_out_423161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423161", "423161003", "story_v_out_423161.awb")
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
	Play423161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423161004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423161005(arg_17_1)
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
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1083"]) and arg_17_1.var_.actorSpriteComps1083 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1083 = nil
			end

			local var_20_2 = arg_17_1.actors_["1083"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1083 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1083", 7)

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
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_5 = 0
			local var_20_6 = 1.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(423161004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 43 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 43)

				if (43 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 43)) > 0 and var_20_6 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_10 and arg_17_1.time_ < var_20_5 + var_20_10 + arg_20_0 then
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
	Play423161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423161005
		arg_21_1.duration_ = 3.93

		local var_21_0 = {
			zh = 1.966,
			ja = 3.933
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
				arg_21_0:Play423161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1083"]) and arg_21_1.var_.actorSpriteComps1083 == nil then
				arg_21_1.var_.actorSpriteComps1083 = arg_21_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1083"]) then
				if arg_21_1.var_.actorSpriteComps1083 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1083"]) and arg_21_1.var_.actorSpriteComps1083 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1083 = nil
			end

			local var_24_2 = arg_21_1.actors_["1083"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1083 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1083", 3)

				for iter_24_4 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_4)

					if var_24_3.name == "split_7" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_24_5 = 0
			local var_24_6 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
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

				local var_24_7 = arg_21_1:GetWordFromCfg(423161005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 13 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 13)

				if (13 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 13)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161005", "story_v_out_423161.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_423161", "423161005", "story_v_out_423161.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_423161", "423161005", "story_v_out_423161.awb")

						arg_21_1:RecordAudio("423161005", var_24_12)
						arg_21_1:RecordAudio("423161005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423161", "423161005", "story_v_out_423161.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423161", "423161005", "story_v_out_423161.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
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
	Play423161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423161006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423161007(arg_25_1)
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
			local var_28_3 = 0.425

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

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(423161006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 17 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 17)

				if (17 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 17)) > 0 and var_28_3 < var_28_6 then
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
	Play423161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423161007
		arg_29_1.duration_ = 7.93

		local var_29_0 = {
			zh = 6.4,
			ja = 7.933
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
				arg_29_0:Play423161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1083"]) and arg_29_1.var_.actorSpriteComps1083 == nil then
				arg_29_1.var_.actorSpriteComps1083 = arg_29_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1083"]) then
				if arg_29_1.var_.actorSpriteComps1083 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1083"]) and arg_29_1.var_.actorSpriteComps1083 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1083 = nil
			end

			local var_32_2 = arg_29_1.actors_["1083"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1083 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1083", 3)

				for iter_32_4 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_4)

					if var_32_3.name == "split_7" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_32_5 = 0
			local var_32_6 = 0.9

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(423161007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 36 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 36)

				if (36 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 36)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161007", "story_v_out_423161.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_423161", "423161007", "story_v_out_423161.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_423161", "423161007", "story_v_out_423161.awb")

						arg_29_1:RecordAudio("423161007", var_32_12)
						arg_29_1:RecordAudio("423161007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423161", "423161007", "story_v_out_423161.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423161", "423161007", "story_v_out_423161.awb")
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
				actorName = "1083",
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
	Play423161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423161008
		arg_33_1.duration_ = 7.6

		local var_33_0 = {
			zh = 3.466,
			ja = 7.6
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
				arg_33_0:Play423161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1083 = arg_33_1.actors_["1083"].transform.localPosition
				arg_33_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1083", 3)

				for iter_36_0 = 0, arg_33_1.actors_["1083"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["1083"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_36_2 = 0
			local var_36_3 = 0.45

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
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

				local var_36_4 = arg_33_1:GetWordFromCfg(423161008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)

				if (18 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 18)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161008", "story_v_out_423161.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_423161", "423161008", "story_v_out_423161.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_423161", "423161008", "story_v_out_423161.awb")

						arg_33_1:RecordAudio("423161008", var_36_9)
						arg_33_1:RecordAudio("423161008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423161", "423161008", "story_v_out_423161.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423161", "423161008", "story_v_out_423161.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
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
	Play423161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423161009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 == nil then
				arg_37_1.var_.actorSpriteComps1083 = arg_37_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1083"]) then
				if arg_37_1.var_.actorSpriteComps1083 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1083 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(423161009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 19)

				if (19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 19)) > 0 and var_40_3 < var_40_6 then
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423161010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423161010
		arg_41_1.duration_ = 4.7

		local var_41_0 = {
			zh = 4.4,
			ja = 4.7
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
				arg_41_0:Play423161011(arg_41_1)
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

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
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

			local var_44_5 = 0
			local var_44_6 = 0.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
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

				local var_44_7 = arg_41_1:GetWordFromCfg(423161010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 22 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 22)

				if (22 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 22)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161010", "story_v_out_423161.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_423161", "423161010", "story_v_out_423161.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_423161", "423161010", "story_v_out_423161.awb")

						arg_41_1:RecordAudio("423161010", var_44_12)
						arg_41_1:RecordAudio("423161010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423161", "423161010", "story_v_out_423161.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423161", "423161010", "story_v_out_423161.awb")
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
	Play423161011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423161011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play423161012(arg_45_1)
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

			if 0.034 < arg_45_1.time_ and arg_45_1.time_ <= 0.034 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_side_1059", "se_story_1059_motorcycle", "")
			end

			local var_48_6 = 0
			local var_48_7 = 1.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(423161011).content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 50 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 50)

				if (50 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 50)) > 0 and var_48_7 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_11 and arg_45_1.time_ < var_48_6 + var_48_11 + arg_48_0 then
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
	Play423161012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423161012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423161013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(423161012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)

				if (10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play423161013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423161013
		arg_53_1.duration_ = 9

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play423161014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_9000

			if arg_53_1.bgs_.ST0113 == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0113")
				var_56_0.name = "ST0113"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.ST0113 = var_56_0
			end

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.ST0113

				arg_53_1.bgs_.ST0113.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "ST0113" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 4

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_4 + 0.3 and arg_53_1.time_ < var_56_4 + 0.3 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_5 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_6 = 2

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 then
				local var_56_7 = Color.New(0, 0, 0)

				var_56_7.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_5) / var_56_6)
				arg_53_1.mask_.color = var_56_7
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 then
				local var_56_8 = Color.New(0, 0, 0)

				var_56_8.a = 1
				arg_53_1.mask_.color = var_56_8
			end

			local var_56_9 = 2

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_10 = 2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 then
				local var_56_11 = Color.New(0, 0, 0)

				var_56_11.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_9) / var_56_10)
				arg_53_1.mask_.color = var_56_11
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 then
				local var_56_12 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_12.a = 0
				arg_53_1.mask_.color = var_56_12
			end

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				local var_56_13 = arg_53_1.var_.effectaishizhuiche

				if not arg_53_1.var_.effectaishizhuiche then
					var_56_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_56_13.name = "aishizhuiche"
					arg_53_1.var_.effectaishizhuiche = var_56_13
				else
					var_56_13.transform:SetParent(var_56_9000)
				end

				var_56_13.transform.localPosition = Vector3.New(0, 0, -2)
				var_56_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_56_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_56_2, iter_56_3 in ipairs((var_56_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_56_3.transform.localScale = Vector3.New(iter_56_3.transform.localScale.x / var_56_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_56_3.transform.localScale.y / var_56_15, iter_56_3.transform.localScale.z)
				end
			end

			local var_56_17 = arg_53_1.bgs_.ST0113.transform

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				arg_53_1.var_.moveOldPosST0113 = var_56_17.localPosition
			end

			local var_56_18 = 2.9

			if 2 <= arg_53_1.time_ and arg_53_1.time_ < 2 + var_56_18 then
				var_56_17.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPosST0113, Vector3.New(0, 1, 9.5), (arg_53_1.time_ - 2) / var_56_18)
			end

			if arg_53_1.time_ >= 2 + var_56_18 and arg_53_1.time_ < 2 + var_56_18 + arg_56_0 then
				var_56_17.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_56_19 = 4

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_19 + 0.9 and arg_53_1.time_ < var_56_19 + 0.9 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.53333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 1.53333333333333 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			if 4.3 < arg_53_1.time_ and arg_53_1.time_ <= 4.3 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle01", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_23 = 4
			local var_56_24 = 1.325

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_25 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_25:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(423161013).content)

				arg_53_1.text_.text = var_56_26

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 53 <= 0 and var_56_24 or var_56_24 * (utf8.len(var_56_26) / 53)

				if (53 <= 0 and var_56_24 or var_56_24 * (utf8.len(var_56_26) / 53)) > 0 and var_56_24 < var_56_28 then
					arg_53_1.talkMaxDuration = var_56_28
					var_56_23 = var_56_23 + 0.3

					if var_56_28 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_23
					end
				end

				arg_53_1.text_.text = var_56_26
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_29 = var_56_23 + 0.3
			local var_56_30 = math.max(var_56_24, arg_53_1.talkMaxDuration)

			if var_56_23 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_29 + var_56_30 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_29) / var_56_30

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_29 + var_56_30 and arg_53_1.time_ < var_56_29 + var_56_30 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0113",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.9,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play423161014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423161014
		arg_59_1.duration_ = 4.73

		local var_59_0 = {
			zh = 3.2,
			ja = 4.733
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
				arg_59_0:Play423161015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1083"]) and arg_59_1.var_.actorSpriteComps1083 == nil then
				arg_59_1.var_.actorSpriteComps1083 = arg_59_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1083"]) then
				if arg_59_1.var_.actorSpriteComps1083 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1083"]) and arg_59_1.var_.actorSpriteComps1083 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps1083 = nil
			end

			local var_62_2 = arg_59_1.actors_["1083"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1083 = var_62_2.localPosition
				var_62_2.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1083", 3)

				for iter_62_4 = 0, var_62_2.childCount - 1 do
					local var_62_3 = var_62_2:GetChild(iter_62_4)

					if var_62_3.name == "split_7" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_2.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_59_1.time_ - 0) / var_62_4)
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_5 = arg_59_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_62_5 then
					arg_59_1.var_.alphaOldValue1083 = var_62_5.alpha
					arg_59_1.var_.characterEffect1083 = var_62_5
				end

				arg_59_1.var_.alphaOldValue1083 = 0
			end

			local var_62_6 = 0.5

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 then
				if arg_59_1.var_.characterEffect1083 then
					arg_59_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_59_1.var_.alphaOldValue1083, 1, (arg_59_1.time_ - 0) / var_62_6)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 and arg_59_1.var_.characterEffect1083 then
				arg_59_1.var_.characterEffect1083.alpha = 1
			end

			local var_62_7 = 0
			local var_62_8 = 0.5

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(423161014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 20 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 20)

				if (20 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 20)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161014", "story_v_out_423161.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_423161", "423161014", "story_v_out_423161.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_423161", "423161014", "story_v_out_423161.awb")

						arg_59_1:RecordAudio("423161014", var_62_14)
						arg_59_1:RecordAudio("423161014", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423161", "423161014", "story_v_out_423161.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423161", "423161014", "story_v_out_423161.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_7) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_7 + var_62_15 and arg_59_1.time_ < var_62_7 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play423161015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423161015
		arg_63_1.duration_ = 4.5

		local var_63_0 = {
			zh = 2.4,
			ja = 4.5
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
				arg_63_0:Play423161016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(423161015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 15 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 15)

				if (15 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 15)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161015", "story_v_out_423161.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_423161", "423161015", "story_v_out_423161.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_423161", "423161015", "story_v_out_423161.awb")

						arg_63_1:RecordAudio("423161015", var_66_6)
						arg_63_1:RecordAudio("423161015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_423161", "423161015", "story_v_out_423161.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_423161", "423161015", "story_v_out_423161.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play423161016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 423161016
		arg_67_1.duration_ = 5.6

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play423161017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1083"]) and arg_67_1.var_.actorSpriteComps1083 == nil then
				arg_67_1.var_.actorSpriteComps1083 = arg_67_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1083"]) then
				if arg_67_1.var_.actorSpriteComps1083 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1083"]) and arg_67_1.var_.actorSpriteComps1083 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_70_3 then
						iter_70_3.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps1083 = nil
			end

			local var_70_2 = arg_67_1.actors_["1083"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1083 = var_70_2.localPosition
				var_70_2.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1083", 7)

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
				var_70_2.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_67_1.time_ - 0) / var_70_4)
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_67_1.time_ and arg_67_1.time_ <= 0.2 + arg_70_0 then
				arg_67_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun", "")
			end

			local var_70_6 = manager.ui.mainCamera.transform

			if 0.2 < arg_67_1.time_ and arg_67_1.time_ <= 0.2 + arg_70_0 then
				arg_67_1.var_.shakeOldPos = var_70_6.localPosition
			end

			local var_70_7 = 0.6

			if 0.2 <= arg_67_1.time_ and arg_67_1.time_ < 0.2 + var_70_7 then
				local var_70_8, var_70_9 = math.modf((arg_67_1.time_ - 0.2) / 0.066)

				var_70_6.localPosition = Vector3.New(var_70_9 * 0.13, var_70_9 * 0.13, var_70_9 * 0.13) + arg_67_1.var_.shakeOldPos
			end

			if arg_67_1.time_ >= 0.2 + var_70_7 and arg_67_1.time_ < 0.2 + var_70_7 + arg_70_0 then
				var_70_6.localPosition = arg_67_1.var_.shakeOldPos
			end

			local var_70_10 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_10 + 0.8 and arg_67_1.time_ < var_70_10 + 0.8 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_11 = 0.6
			local var_70_12 = 1.275

			if 0.6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_13 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_13:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_14 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(423161016).content)

				arg_67_1.text_.text = var_70_14

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_16 = 51 <= 0 and var_70_12 or var_70_12 * (utf8.len(var_70_14) / 51)

				if (51 <= 0 and var_70_12 or var_70_12 * (utf8.len(var_70_14) / 51)) > 0 and var_70_12 < var_70_16 then
					arg_67_1.talkMaxDuration = var_70_16
					var_70_11 = var_70_11 + 0.3

					if var_70_16 + var_70_11 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_11
					end
				end

				arg_67_1.text_.text = var_70_14
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_17 = var_70_11 + 0.3
			local var_70_18 = math.max(var_70_12, arg_67_1.talkMaxDuration)

			if var_70_11 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_17 + var_70_18 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_17) / var_70_18

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_17 + var_70_18 and arg_67_1.time_ < var_70_17 + var_70_18 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play423161017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423161017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play423161018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.9

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

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(423161017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 36 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 36)

				if (36 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 36)) > 0 and var_76_0 < var_76_3 then
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
	Play423161018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423161018
		arg_77_1.duration_ = 6.9

		local var_77_0 = {
			zh = 5.433,
			ja = 6.9
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
				arg_77_0:Play423161019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(423161018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 17 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 17)

				if (17 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 17)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161018", "story_v_out_423161.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_423161", "423161018", "story_v_out_423161.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_423161", "423161018", "story_v_out_423161.awb")

						arg_77_1:RecordAudio("423161018", var_80_6)
						arg_77_1:RecordAudio("423161018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423161", "423161018", "story_v_out_423161.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423161", "423161018", "story_v_out_423161.awb")
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
	Play423161019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423161019
		arg_81_1.duration_ = 5.23

		local var_81_0 = {
			zh = 5.233,
			ja = 4.033
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
				arg_81_0:Play423161020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(423161019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 20 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 20)

				if (20 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 20)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161019", "story_v_out_423161.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_423161", "423161019", "story_v_out_423161.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_423161", "423161019", "story_v_out_423161.awb")

						arg_81_1:RecordAudio("423161019", var_84_6)
						arg_81_1:RecordAudio("423161019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_423161", "423161019", "story_v_out_423161.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_423161", "423161019", "story_v_out_423161.awb")
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
	Play423161020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423161020
		arg_85_1.duration_ = 6.73

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423161021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_9004
			local var_88_9003
			local var_88_9002
			local var_88_9001
			local var_88_9000

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_0 = arg_85_1.var_.effectyudianzidan1

				if not arg_85_1.var_.effectyudianzidan1 then
					var_88_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_88_0.name = "yudianzidan1"
					arg_85_1.var_.effectyudianzidan1 = var_88_0
				else
					var_88_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_88_0.transform.localPosition = Vector3.New(-0.61, -0.83, -0.3)
				var_88_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				if arg_85_1.var_.effectyudianzidan1 then
					Object.Destroy(arg_85_1.var_.effectyudianzidan1)

					arg_85_1.var_.effectyudianzidan1 = nil
				end
			end

			if 0.133333333333333 < arg_85_1.time_ and arg_85_1.time_ <= 0.133333333333333 + arg_88_0 then
				local var_88_3 = arg_85_1.var_.effectyudianzidan2

				if not arg_85_1.var_.effectyudianzidan2 then
					var_88_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_88_3.name = "yudianzidan2"
					arg_85_1.var_.effectyudianzidan2 = var_88_3
				else
					var_88_3.transform:SetParent(var_88_9004)
				end

				var_88_3.transform.localPosition = Vector3.New(0, -0.83, 0)
				var_88_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.13333333333333 < arg_85_1.time_ and arg_85_1.time_ <= 2.13333333333333 + arg_88_0 then
				if arg_85_1.var_.effectyudianzidan2 then
					Object.Destroy(arg_85_1.var_.effectyudianzidan2)

					arg_85_1.var_.effectyudianzidan2 = nil
				end
			end

			if 0.266666666666668 < arg_85_1.time_ and arg_85_1.time_ <= 0.266666666666668 + arg_88_0 then
				local var_88_6 = arg_85_1.var_.effectyudianzidan3

				if not arg_85_1.var_.effectyudianzidan3 then
					var_88_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_88_6.name = "yudianzidan3"
					arg_85_1.var_.effectyudianzidan3 = var_88_6
				else
					var_88_6.transform:SetParent(var_88_9003)
				end

				var_88_6.transform.localPosition = Vector3.New(-0.27, -1.21, 0)
				var_88_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.26666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 2.26666666666667 + arg_88_0 then
				if arg_85_1.var_.effectyudianzidan3 then
					Object.Destroy(arg_85_1.var_.effectyudianzidan3)

					arg_85_1.var_.effectyudianzidan3 = nil
				end
			end

			if 0.433333333333335 < arg_85_1.time_ and arg_85_1.time_ <= 0.433333333333335 + arg_88_0 then
				local var_88_9 = arg_85_1.var_.effectyudianzidan4

				if not arg_85_1.var_.effectyudianzidan4 then
					var_88_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_88_9.name = "yudianzidan4"
					arg_85_1.var_.effectyudianzidan4 = var_88_9
				else
					var_88_9.transform:SetParent(var_88_9001)
				end

				var_88_9.transform.localPosition = Vector3.New(-0.61, -0.83, 0)
				var_88_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.43333333333333 < arg_85_1.time_ and arg_85_1.time_ <= 2.43333333333333 + arg_88_0 then
				if arg_85_1.var_.effectyudianzidan4 then
					Object.Destroy(arg_85_1.var_.effectyudianzidan4)

					arg_85_1.var_.effectyudianzidan4 = nil
				end
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_12 = arg_85_1.var_.effectyudianhuichen1

				if not arg_85_1.var_.effectyudianhuichen1 then
					var_88_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_88_12.name = "yudianhuichen1"
					arg_85_1.var_.effectyudianhuichen1 = var_88_12
				else
					var_88_12.transform:SetParent(var_88_9002)
				end

				var_88_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				if arg_85_1.var_.effectyudianhuichen1 then
					Object.Destroy(arg_85_1.var_.effectyudianhuichen1)

					arg_85_1.var_.effectyudianhuichen1 = nil
				end
			end

			if 0.266666666666668 < arg_85_1.time_ and arg_85_1.time_ <= 0.266666666666668 + arg_88_0 then
				local var_88_15 = arg_85_1.var_.effectyudianhuichen2

				if not arg_85_1.var_.effectyudianhuichen2 then
					var_88_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_88_15.name = "yudianhuichen2"
					arg_85_1.var_.effectyudianhuichen2 = var_88_15
				else
					var_88_15.transform:SetParent(var_88_9000)
				end

				var_88_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.26666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 2.26666666666667 + arg_88_0 then
				if arg_85_1.var_.effectyudianhuichen2 then
					Object.Destroy(arg_85_1.var_.effectyudianhuichen2)

					arg_85_1.var_.effectyudianhuichen2 = nil
				end
			end

			local var_88_18 = manager.ui.mainCamera.transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_18.localPosition
			end

			local var_88_19 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_19 then
				local var_88_20, var_88_21 = math.modf((arg_85_1.time_ - 0) / 0.066)

				var_88_18.localPosition = Vector3.New(var_88_21 * 0.13, var_88_21 * 0.13, var_88_21 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= 0 + var_88_19 and arg_85_1.time_ < 0 + var_88_19 + arg_88_0 then
				var_88_18.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_22 = manager.ui.mainCamera.transform

			if 0.133333333333333 < arg_85_1.time_ and arg_85_1.time_ <= 0.133333333333333 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_22.localPosition
			end

			local var_88_23 = 0.2

			if 0.133333333333333 <= arg_85_1.time_ and arg_85_1.time_ < 0.133333333333333 + var_88_23 then
				local var_88_24, var_88_25 = math.modf((arg_85_1.time_ - 0.133333333333333) / 0.066)

				var_88_22.localPosition = Vector3.New(var_88_25 * 0.13, var_88_25 * 0.13, var_88_25 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= 0.133333333333333 + var_88_23 and arg_85_1.time_ < 0.133333333333333 + var_88_23 + arg_88_0 then
				var_88_22.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_26 = manager.ui.mainCamera.transform

			if 0.266666666666668 < arg_85_1.time_ and arg_85_1.time_ <= 0.266666666666668 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_26.localPosition
			end

			local var_88_27 = 0.2

			if 0.266666666666668 <= arg_85_1.time_ and arg_85_1.time_ < 0.266666666666668 + var_88_27 then
				local var_88_28, var_88_29 = math.modf((arg_85_1.time_ - 0.266666666666668) / 0.066)

				var_88_26.localPosition = Vector3.New(var_88_29 * 0.13, var_88_29 * 0.13, var_88_29 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= 0.266666666666668 + var_88_27 and arg_85_1.time_ < 0.266666666666668 + var_88_27 + arg_88_0 then
				var_88_26.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_30 = manager.ui.mainCamera.transform

			if 0.433333333333335 < arg_85_1.time_ and arg_85_1.time_ <= 0.433333333333335 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_30.localPosition
			end

			local var_88_31 = 0.2

			if 0.433333333333335 <= arg_85_1.time_ and arg_85_1.time_ < 0.433333333333335 + var_88_31 then
				local var_88_32, var_88_33 = math.modf((arg_85_1.time_ - 0.433333333333335) / 0.066)

				var_88_30.localPosition = Vector3.New(var_88_33 * 0.13, var_88_33 * 0.13, var_88_33 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= 0.433333333333335 + var_88_31 and arg_85_1.time_ < 0.433333333333335 + var_88_31 + arg_88_0 then
				var_88_30.localPosition = arg_85_1.var_.shakeOldPos
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_136", "se_story_136_gun", "")
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_35 = 1.73333333333333
			local var_88_36 = 1.3

			if 1.73333333333333 < arg_85_1.time_ and arg_85_1.time_ <= var_88_35 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_37 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_37:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_38 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(423161020).content)

				arg_85_1.text_.text = var_88_38

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_40 = 52 <= 0 and var_88_36 or var_88_36 * (utf8.len(var_88_38) / 52)

				if (52 <= 0 and var_88_36 or var_88_36 * (utf8.len(var_88_38) / 52)) > 0 and var_88_36 < var_88_40 then
					arg_85_1.talkMaxDuration = var_88_40
					var_88_35 = var_88_35 + 0.3

					if var_88_40 + var_88_35 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_40 + var_88_35
					end
				end

				arg_85_1.text_.text = var_88_38
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_41 = var_88_35 + 0.3
			local var_88_42 = math.max(var_88_36, arg_85_1.talkMaxDuration)

			if var_88_35 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_41 + var_88_42 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_41) / var_88_42

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_41 + var_88_42 and arg_85_1.time_ < var_88_41 + var_88_42 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423161021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423161021
		arg_91_1.duration_ = 7

		local var_91_0 = {
			zh = 4.2,
			ja = 7
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
				arg_91_0:Play423161022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1083"]) and arg_91_1.var_.actorSpriteComps1083 == nil then
				arg_91_1.var_.actorSpriteComps1083 = arg_91_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1083"]) then
				if arg_91_1.var_.actorSpriteComps1083 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1083"]) and arg_91_1.var_.actorSpriteComps1083 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1083 = nil
			end

			local var_94_2 = arg_91_1.actors_["1083"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1083 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1083", 3)

				for iter_94_4 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_4)

					if var_94_3.name == "split_7" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_94_5 = 0
			local var_94_6 = 0.475

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(423161021)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 19 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 19)

				if (19 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 19)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161021", "story_v_out_423161.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_423161", "423161021", "story_v_out_423161.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_423161", "423161021", "story_v_out_423161.awb")

						arg_91_1:RecordAudio("423161021", var_94_12)
						arg_91_1:RecordAudio("423161021", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423161", "423161021", "story_v_out_423161.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423161", "423161021", "story_v_out_423161.awb")
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
				actorName = "1083",
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
	Play423161022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423161022
		arg_95_1.duration_ = 5.27

		local var_95_0 = {
			zh = 4.666,
			ja = 5.266
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play423161023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1083 = arg_95_1.actors_["1083"].transform.localPosition
				arg_95_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1083", 3)

				for iter_98_0 = 0, arg_95_1.actors_["1083"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1083"].transform:GetChild(iter_98_0)

					if var_98_0.name == "split_7" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_98_2 = 0
			local var_98_3 = 0.575

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(423161022)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 20 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 20)

				if (20 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 20)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161022", "story_v_out_423161.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_423161", "423161022", "story_v_out_423161.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_423161", "423161022", "story_v_out_423161.awb")

						arg_95_1:RecordAudio("423161022", var_98_9)
						arg_95_1:RecordAudio("423161022", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_423161", "423161022", "story_v_out_423161.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_423161", "423161022", "story_v_out_423161.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play423161023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423161023
		arg_99_1.duration_ = 5.43

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play423161024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1083"]) and arg_99_1.var_.actorSpriteComps1083 == nil then
				arg_99_1.var_.actorSpriteComps1083 = arg_99_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1083"]) then
				if arg_99_1.var_.actorSpriteComps1083 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1083"]) and arg_99_1.var_.actorSpriteComps1083 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps1083 = nil
			end

			local var_102_2 = arg_99_1.actors_["1083"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1083 = var_102_2.localPosition
				var_102_2.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1083", 7)

				for iter_102_4 = 0, var_102_2.childCount - 1 do
					local var_102_3 = var_102_2:GetChild(iter_102_4)

					if var_102_3.name == "" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_99_1.time_ - 0) / var_102_4)
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_5 = manager.ui.mainCamera.transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = var_102_5.localPosition
			end

			local var_102_6 = 0.6

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 then
				local var_102_7, var_102_8 = math.modf((arg_99_1.time_ - 0) / 0.066)

				var_102_5.localPosition = Vector3.New(var_102_8 * 0.02, var_102_8 * 0.02, var_102_8 * 0.02) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 then
				var_102_5.localPosition = arg_99_1.var_.shakeOldPos
			end

			local var_102_9 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_9 + 0.433333333333333 and arg_99_1.time_ < var_102_9 + 0.433333333333333 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			if 0.6 < arg_99_1.time_ and arg_99_1.time_ <= 0.6 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle02", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_11 = 0.433333333333333
			local var_102_12 = 1.35

			if 0.433333333333333 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_13 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_13:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(423161023).content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 54 <= 0 and var_102_12 or var_102_12 * (utf8.len(var_102_14) / 54)

				if (54 <= 0 and var_102_12 or var_102_12 * (utf8.len(var_102_14) / 54)) > 0 and var_102_12 < var_102_16 then
					arg_99_1.talkMaxDuration = var_102_16
					var_102_11 = var_102_11 + 0.3

					if var_102_16 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_17 = var_102_11 + 0.3
			local var_102_18 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_17 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_17) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_17 + var_102_18 and arg_99_1.time_ < var_102_17 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play423161024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423161024
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play423161025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0.1 < arg_105_1.time_ and arg_105_1.time_ <= 0.1 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_108_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_105_1.time_ and arg_105_1.time_ <= 0.1 + arg_108_0 then
				arg_105_1.var_.shakeOldPos = var_108_1.localPosition
			end

			local var_108_2 = 0.6

			if 0.1 <= arg_105_1.time_ and arg_105_1.time_ < 0.1 + var_108_2 then
				local var_108_3, var_108_4 = math.modf((arg_105_1.time_ - 0.1) / 0.066)

				var_108_1.localPosition = Vector3.New(var_108_4 * 0.02, var_108_4 * 0.02, var_108_4 * 0.02) + arg_105_1.var_.shakeOldPos
			end

			if arg_105_1.time_ >= 0.1 + var_108_2 and arg_105_1.time_ < 0.1 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = arg_105_1.var_.shakeOldPos
			end

			local var_108_5 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_5 + 0.7 and arg_105_1.time_ < var_108_5 + 0.7 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_6 = 0
			local var_108_7 = 1.225

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(423161024).content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 49 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_8) / 49)

				if (49 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_8) / 49)) > 0 and var_108_7 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_11 and arg_105_1.time_ < var_108_6 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play423161025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423161025
		arg_109_1.duration_ = 6.6

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play423161026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_0 = 1

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				local var_112_1 = Color.New(1, 1, 1)

				var_112_1.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.mask_.color = var_112_1
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				local var_112_2 = Color.New(1, 1, 1)

				var_112_2.a = 1
				arg_109_1.mask_.color = var_112_2
			end

			local var_112_3 = 1

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_4 = 0.6

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_4 then
				local var_112_5 = Color.New(1, 1, 1)

				var_112_5.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_3) / var_112_4)
				arg_109_1.mask_.color = var_112_5
			end

			if arg_109_1.time_ >= var_112_3 + var_112_4 and arg_109_1.time_ < var_112_3 + var_112_4 + arg_112_0 then
				local var_112_6 = Color.New(1, 1, 1)

				arg_109_1.mask_.enabled = false
				var_112_6.a = 0
				arg_109_1.mask_.color = var_112_6
			end

			local var_112_7 = "I24f"

			if arg_109_1.bgs_.I24f == nil then
				local var_112_8 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_7)
				var_112_8.name = var_112_7
				var_112_8.transform.parent = arg_109_1.stage_.transform
				var_112_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_7] = var_112_8
			end

			local var_112_9 = arg_109_1.bgs_.I24f.transform

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				arg_109_1.var_.moveOldPosI24f = var_112_9.localPosition
			end

			local var_112_10 = 1

			if 1 <= arg_109_1.time_ and arg_109_1.time_ < 1 + var_112_10 then
				var_112_9.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPosI24f, Vector3.New(0, 1, 8), (arg_109_1.time_ - 1) / var_112_10)
			end

			if arg_109_1.time_ >= 1 + var_112_10 and arg_109_1.time_ < 1 + var_112_10 + arg_112_0 then
				var_112_9.localPosition = Vector3.New(0, 1, 8)
			end

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				local var_112_11 = arg_109_1.bgs_.I24f

				arg_109_1.bgs_.I24f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_12 = var_112_11:GetComponent("SpriteRenderer")

				if var_112_12 and var_112_12.sprite then
					local var_112_13 = 2 * (var_112_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_11.transform.localScale = Vector3.New(var_112_13 / var_112_12.sprite.bounds.size.y < var_112_13 * manager.ui.mainCameraCom_.aspect / var_112_12.sprite.bounds.size.x and var_112_13 * manager.ui.mainCameraCom_.aspect / var_112_12.sprite.bounds.size.x or var_112_13 / var_112_12.sprite.bounds.size.y, var_112_13 / var_112_12.sprite.bounds.size.y < var_112_13 * manager.ui.mainCameraCom_.aspect / var_112_12.sprite.bounds.size.x and var_112_13 * manager.ui.mainCameraCom_.aspect / var_112_12.sprite.bounds.size.x or var_112_13 / var_112_12.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "I24f" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_144", "se_story_144_motorcycle", "")
			end

			if 0.6 < arg_109_1.time_ and arg_109_1.time_ <= 0.6 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_144", "se_story_144_metal02", "")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("stop", "effect", "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			if 0.6 < arg_109_1.time_ and arg_109_1.time_ <= 0.6 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_train_roof", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_18 = 1.6
			local var_112_19 = 2

			if 1.6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_20 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_20:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_21 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(423161025).content)

				arg_109_1.text_.text = var_112_21

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_23 = 80 <= 0 and var_112_19 or var_112_19 * (utf8.len(var_112_21) / 80)

				if (80 <= 0 and var_112_19 or var_112_19 * (utf8.len(var_112_21) / 80)) > 0 and var_112_19 < var_112_23 then
					arg_109_1.talkMaxDuration = var_112_23
					var_112_18 = var_112_18 + 0.3

					if var_112_23 + var_112_18 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_18
					end
				end

				arg_109_1.text_.text = var_112_21
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_24 = var_112_18 + 0.3
			local var_112_25 = math.max(var_112_19, arg_109_1.talkMaxDuration)

			if var_112_18 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_24 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_24) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_24 + var_112_25 and arg_109_1.time_ < var_112_24 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "I24f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.easeOutCirc
				}
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play423161026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423161026
		arg_115_1.duration_ = 5.53

		local var_115_0 = {
			zh = 3.6,
			ja = 5.533
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
				arg_115_0:Play423161027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.4

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_2 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_2:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(423161026)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 16 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_4) / 16)

				if (16 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_4) / 16)) > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6
					var_118_0 = var_118_0 + 0.3

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161026", "story_v_out_423161.awb") ~= 0 then
					local var_118_7 = manager.audio:GetVoiceLength("story_v_out_423161", "423161026", "story_v_out_423161.awb") / 1000

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_423161", "423161026", "story_v_out_423161.awb")

						arg_115_1:RecordAudio("423161026", var_118_8)
						arg_115_1:RecordAudio("423161026", var_118_8)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_423161", "423161026", "story_v_out_423161.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_423161", "423161026", "story_v_out_423161.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_9 = var_118_0 + 0.3
			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_9) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play423161027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423161027
		arg_121_1.duration_ = 3.83

		local var_121_0 = {
			zh = 3.833,
			ja = 3.733
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
				arg_121_0:Play423161028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1083"]) and arg_121_1.var_.actorSpriteComps1083 == nil then
				arg_121_1.var_.actorSpriteComps1083 = arg_121_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1083"]) then
				if arg_121_1.var_.actorSpriteComps1083 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1083"]) and arg_121_1.var_.actorSpriteComps1083 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps1083 = nil
			end

			local var_124_2 = arg_121_1.actors_["1083"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1083 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1083", 3)

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
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				local var_124_5 = arg_121_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_5 then
					arg_121_1.var_.alphaOldValue1083 = var_124_5.alpha
					arg_121_1.var_.characterEffect1083 = var_124_5
				end

				arg_121_1.var_.alphaOldValue1083 = 0
			end

			local var_124_6 = 0.5

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 then
				if arg_121_1.var_.characterEffect1083 then
					arg_121_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_121_1.var_.alphaOldValue1083, 1, (arg_121_1.time_ - 0) / var_124_6)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and arg_121_1.var_.characterEffect1083 then
				arg_121_1.var_.characterEffect1083.alpha = 1
			end

			local var_124_7 = 0
			local var_124_8 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(423161027)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 13 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 13)

				if (13 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 13)) > 0 and var_124_8 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161027", "story_v_out_423161.awb") ~= 0 then
					local var_124_13 = manager.audio:GetVoiceLength("story_v_out_423161", "423161027", "story_v_out_423161.awb") / 1000

					if var_124_13 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_7
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_out_423161", "423161027", "story_v_out_423161.awb")

						arg_121_1:RecordAudio("423161027", var_124_14)
						arg_121_1:RecordAudio("423161027", var_124_14)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_423161", "423161027", "story_v_out_423161.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_423161", "423161027", "story_v_out_423161.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_15 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_15 and arg_121_1.time_ < var_124_7 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play423161028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423161028
		arg_125_1.duration_ = 6.1

		local var_125_0 = {
			zh = 5.266,
			ja = 6.1
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
				arg_125_0:Play423161029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(423161028)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 22 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 22)

				if (22 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 22)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161028", "story_v_out_423161.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_423161", "423161028", "story_v_out_423161.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_423161", "423161028", "story_v_out_423161.awb")

						arg_125_1:RecordAudio("423161028", var_128_6)
						arg_125_1:RecordAudio("423161028", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423161", "423161028", "story_v_out_423161.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423161", "423161028", "story_v_out_423161.awb")
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
	Play423161029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423161029
		arg_129_1.duration_ = 6.67

		local var_129_0 = {
			zh = 4.8,
			ja = 6.666
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
			arg_129_1.auto_ = false
		end

		function arg_129_1.playNext_(arg_131_0)
			arg_129_1.onStoryFinished_()
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1083 = arg_129_1.actors_["1083"].transform.localPosition
				arg_129_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1083", 3)

				for iter_132_0 = 0, arg_129_1.actors_["1083"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["1083"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_7" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_132_2 = 0
			local var_132_3 = 0.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(423161029)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 18 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 18)

				if (18 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 18)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423161", "423161029", "story_v_out_423161.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_423161", "423161029", "story_v_out_423161.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_423161", "423161029", "story_v_out_423161.awb")

						arg_129_1:RecordAudio("423161029", var_132_9)
						arg_129_1:RecordAudio("423161029", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_423161", "423161029", "story_v_out_423161.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_423161", "423161029", "story_v_out_423161.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25f",
		"TextureConfig/Background/ST0113",
		"TextureConfig/Background/I24f"
	},
	voices = {
		"story_v_out_423161.awb"
	}
}
