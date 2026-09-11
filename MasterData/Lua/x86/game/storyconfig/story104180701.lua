return {
	Play418071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418071001
		arg_1_1.duration_ = 7.97

		local var_1_0 = {
			ja = 7.966,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_1_0:Play418071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST40 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST40")
				var_4_0.name = "ST40"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST40 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST40

				arg_1_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST40" then
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

			local var_4_9 = "1073"

			if arg_1_1.actors_["1073"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

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

			local var_4_12 = arg_1_1.actors_["1073"]

			if 1.78835209617391 < arg_1_1.time_ and arg_1_1.time_ <= 1.78835209617391 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1073 == nil then
				arg_1_1.var_.actorSpriteComps1073 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.78835209617391 <= arg_1_1.time_ and arg_1_1.time_ < 1.78835209617391 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1073 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.78835209617391) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.78835209617391) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.78835209617391) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.78835209617391) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.78835209617391 + var_4_13 and arg_1_1.time_ < 1.78835209617391 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1073 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1073 = nil
			end

			local var_4_15 = arg_1_1.actors_["1073"].transform

			if 1.78835209617391 < arg_1_1.time_ and arg_1_1.time_ <= 1.78835209617391 + arg_4_0 then
				arg_1_1.var_.moveOldPos1073 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1073", 2)

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

			if 1.78835209617391 <= arg_1_1.time_ and arg_1_1.time_ < 1.78835209617391 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_1_1.time_ - 1.78835209617391) / var_4_17)
			end

			if arg_1_1.time_ >= 1.78835209617391 + var_4_17 and arg_1_1.time_ < 1.78835209617391 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 2
			local var_4_23 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(418071001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 27 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 27)

				if (27 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 27)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")

						arg_1_1:RecordAudio("418071001", var_4_30)
						arg_1_1:RecordAudio("418071001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071001", "story_v_side_old_418071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.78835209617391,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play418071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418071002
		arg_8_1.duration_ = 10.17

		local var_8_0 = {
			ja = 10.166,
			CriLanguages = 9.4,
			zh = 9.4
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
				arg_8_0:Play418071003(arg_8_1)
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

			local var_11_5 = arg_8_1.actors_["1073"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1073 == nil then
				arg_8_1.var_.actorSpriteComps1073 = var_11_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.actorSpriteComps1073 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_11_7 then
							if arg_8_1.isInRecall_ then
								iter_11_7.color = Color.New(Mathf.Lerp(iter_11_7.color.r, arg_8_1.hightColor2.r, (arg_8_1.time_ - 0) / var_11_6), Mathf.Lerp(iter_11_7.color.g, arg_8_1.hightColor2.g, (arg_8_1.time_ - 0) / var_11_6), (Mathf.Lerp(iter_11_7.color.b, arg_8_1.hightColor2.b, (arg_8_1.time_ - 0) / var_11_6)))
							else
								local var_11_7 = Mathf.Lerp(iter_11_7.color.r, 0.5, (arg_8_1.time_ - 0) / var_11_6)

								iter_11_7.color = Color.New(var_11_7, var_11_7, var_11_7)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1073 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_11_9 then
						iter_11_9.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps1073 = nil
			end

			local var_11_8 = arg_8_1.actors_["10135"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10135 = var_11_8.localPosition
				var_11_8.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10135", 4)

				for iter_11_10 = 0, var_11_8.childCount - 1 do
					local var_11_9 = var_11_8:GetChild(iter_11_10)

					if var_11_9.name == "" or not string.find(var_11_9.name, "split") then
						var_11_9.gameObject:SetActive(true)
					else
						var_11_9.gameObject:SetActive(false)
					end
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_8_1.time_ - 0) / var_11_10)
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_11_11 = 0
			local var_11_12 = 1.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
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

				local var_11_13 = arg_8_1:GetWordFromCfg(418071002)
				local var_11_14 = arg_8_1:FormatText(var_11_13.content)

				arg_8_1.text_.text = var_11_14

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_16 = 45 <= 0 and var_11_12 or var_11_12 * (utf8.len(var_11_14) / 45)

				if (45 <= 0 and var_11_12 or var_11_12 * (utf8.len(var_11_14) / 45)) > 0 and var_11_12 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_11 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_11
					end
				end

				arg_8_1.text_.text = var_11_14
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb") ~= 0 then
					local var_11_17 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb") / 1000

					if var_11_17 + var_11_11 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_11
					end

					if var_11_13.prefab_name ~= "" and arg_8_1.actors_[var_11_13.prefab_name] ~= nil then
						local var_11_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_13.prefab_name].transform, "story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")

						arg_8_1:RecordAudio("418071002", var_11_18)
						arg_8_1:RecordAudio("418071002", var_11_18)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071002", "story_v_side_old_418071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_19 = math.max(var_11_12, arg_8_1.talkMaxDuration)

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_19 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_11) / var_11_19

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_11 + var_11_19 and arg_8_1.time_ < var_11_11 + var_11_19 + arg_11_0 then
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
	Play418071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418071003
		arg_12_1.duration_ = 9.03

		local var_12_0 = {
			ja = 9.033,
			CriLanguages = 7.633,
			zh = 7.633
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
				arg_12_0:Play418071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1073"]) and arg_12_1.var_.actorSpriteComps1073 == nil then
				arg_12_1.var_.actorSpriteComps1073 = arg_12_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1073"]) then
				if arg_12_1.var_.actorSpriteComps1073 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								iter_15_1.color = Color.New(Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, (arg_12_1.time_ - 0) / var_15_0), Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, (arg_12_1.time_ - 0) / var_15_0), (Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, (arg_12_1.time_ - 0) / var_15_0)))
							else
								local var_15_1 = Mathf.Lerp(iter_15_1.color.r, 1, (arg_12_1.time_ - 0) / var_15_0)

								iter_15_1.color = Color.New(var_15_1, var_15_1, var_15_1)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1073"]) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_2 = arg_12_1.actors_["10135"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps10135 == nil then
				arg_12_1.var_.actorSpriteComps10135 = var_15_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_3 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.actorSpriteComps10135 then
					for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_15_5 then
							if arg_12_1.isInRecall_ then
								iter_15_5.color = Color.New(Mathf.Lerp(iter_15_5.color.r, arg_12_1.hightColor2.r, (arg_12_1.time_ - 0) / var_15_3), Mathf.Lerp(iter_15_5.color.g, arg_12_1.hightColor2.g, (arg_12_1.time_ - 0) / var_15_3), (Mathf.Lerp(iter_15_5.color.b, arg_12_1.hightColor2.b, (arg_12_1.time_ - 0) / var_15_3)))
							else
								local var_15_4 = Mathf.Lerp(iter_15_5.color.r, 0.5, (arg_12_1.time_ - 0) / var_15_3)

								iter_15_5.color = Color.New(var_15_4, var_15_4, var_15_4)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps10135 then
				for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_15_7 then
						iter_15_7.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps10135 = nil
			end

			local var_15_5 = arg_12_1.actors_["1073"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_5.localPosition
				var_15_5.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 2)

				for iter_15_8 = 0, var_15_5.childCount - 1 do
					local var_15_6 = var_15_5:GetChild(iter_15_8)

					if var_15_6.name == "split_2" or not string.find(var_15_6.name, "split") then
						var_15_6.gameObject:SetActive(true)
					else
						var_15_6.gameObject:SetActive(false)
					end
				end
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_12_1.time_ - 0) / var_15_7)
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_15_8 = 0
			local var_15_9 = 0.95

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(418071003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 38 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 38)

				if (38 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 38)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")

						arg_12_1:RecordAudio("418071003", var_15_15)
						arg_12_1:RecordAudio("418071003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071003", "story_v_side_old_418071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play418071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418071004
		arg_16_1.duration_ = 9.23

		local var_16_0 = {
			ja = 9.233,
			CriLanguages = 6.033,
			zh = 6.033
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
				arg_16_0:Play418071005(arg_16_1)
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

			local var_19_2 = arg_16_1.actors_["1073"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps1073 == nil then
				arg_16_1.var_.actorSpriteComps1073 = var_19_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_3 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.actorSpriteComps1073 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_19_5 then
							if arg_16_1.isInRecall_ then
								iter_19_5.color = Color.New(Mathf.Lerp(iter_19_5.color.r, arg_16_1.hightColor2.r, (arg_16_1.time_ - 0) / var_19_3), Mathf.Lerp(iter_19_5.color.g, arg_16_1.hightColor2.g, (arg_16_1.time_ - 0) / var_19_3), (Mathf.Lerp(iter_19_5.color.b, arg_16_1.hightColor2.b, (arg_16_1.time_ - 0) / var_19_3)))
							else
								local var_19_4 = Mathf.Lerp(iter_19_5.color.r, 0.5, (arg_16_1.time_ - 0) / var_19_3)

								iter_19_5.color = Color.New(var_19_4, var_19_4, var_19_4)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps1073 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_19_7 then
						iter_19_7.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps1073 = nil
			end

			local var_19_5 = arg_16_1.actors_["10135"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10135 = var_19_5.localPosition
				var_19_5.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10135", 4)

				for iter_19_8 = 0, var_19_5.childCount - 1 do
					local var_19_6 = var_19_5:GetChild(iter_19_8)

					if var_19_6.name == "split_2" or not string.find(var_19_6.name, "split") then
						var_19_6.gameObject:SetActive(true)
					else
						var_19_6.gameObject:SetActive(false)
					end
				end
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_16_1.time_ - 0) / var_19_7)
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_19_8 = 0
			local var_19_9 = 0.775

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
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

				local var_19_10 = arg_16_1:GetWordFromCfg(418071004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 31 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 31)

				if (31 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 31)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")

						arg_16_1:RecordAudio("418071004", var_19_15)
						arg_16_1:RecordAudio("418071004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071004", "story_v_side_old_418071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
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
	Play418071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418071005
		arg_20_1.duration_ = 10.4

		local var_20_0 = {
			ja = 10.4,
			CriLanguages = 7.966,
			zh = 7.966
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
				arg_20_0:Play418071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1073"]) and arg_20_1.var_.actorSpriteComps1073 == nil then
				arg_20_1.var_.actorSpriteComps1073 = arg_20_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1073"]) then
				if arg_20_1.var_.actorSpriteComps1073 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								iter_23_1.color = Color.New(Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_0), Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_0), (Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_0)))
							else
								local var_23_1 = Mathf.Lerp(iter_23_1.color.r, 1, (arg_20_1.time_ - 0) / var_23_0)

								iter_23_1.color = Color.New(var_23_1, var_23_1, var_23_1)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1073"]) and arg_20_1.var_.actorSpriteComps1073 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps1073 = nil
			end

			local var_23_2 = arg_20_1.actors_["10135"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps10135 == nil then
				arg_20_1.var_.actorSpriteComps10135 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps10135 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_23_5 then
							if arg_20_1.isInRecall_ then
								iter_23_5.color = Color.New(Mathf.Lerp(iter_23_5.color.r, arg_20_1.hightColor2.r, (arg_20_1.time_ - 0) / var_23_3), Mathf.Lerp(iter_23_5.color.g, arg_20_1.hightColor2.g, (arg_20_1.time_ - 0) / var_23_3), (Mathf.Lerp(iter_23_5.color.b, arg_20_1.hightColor2.b, (arg_20_1.time_ - 0) / var_23_3)))
							else
								local var_23_4 = Mathf.Lerp(iter_23_5.color.r, 0.5, (arg_20_1.time_ - 0) / var_23_3)

								iter_23_5.color = Color.New(var_23_4, var_23_4, var_23_4)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps10135 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_23_7 then
						iter_23_7.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_20_1.var_.actorSpriteComps10135 = nil
			end

			local var_23_5 = arg_20_1.actors_["1073"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1073 = var_23_5.localPosition
				var_23_5.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1073", 2)

				for iter_23_8 = 0, var_23_5.childCount - 1 do
					local var_23_6 = var_23_5:GetChild(iter_23_8)

					if var_23_6.name == "split_5" or not string.find(var_23_6.name, "split") then
						var_23_6.gameObject:SetActive(true)
					else
						var_23_6.gameObject:SetActive(false)
					end
				end
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_20_1.time_ - 0) / var_23_7)
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_23_8 = 0
			local var_23_9 = 1.1

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
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

				local var_23_10 = arg_20_1:GetWordFromCfg(418071005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 44 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 44)

				if (44 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 44)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")

						arg_20_1:RecordAudio("418071005", var_23_15)
						arg_20_1:RecordAudio("418071005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071005", "story_v_side_old_418071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
	Play418071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418071006
		arg_24_1.duration_ = 2.83

		local var_24_0 = {
			ja = 2.833,
			CriLanguages = 1.466,
			zh = 1.466
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
				arg_24_0:Play418071007(arg_24_1)
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

				arg_24_1:CheckSpriteTmpPos("10135", 4)

				for iter_27_8 = 0, var_27_5.childCount - 1 do
					local var_27_6 = var_27_5:GetChild(iter_27_8)

					if var_27_6.name == "" or not string.find(var_27_6.name, "split") then
						var_27_6.gameObject:SetActive(true)
					else
						var_27_6.gameObject:SetActive(false)
					end
				end
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_24_1.time_ - 0) / var_27_7)
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_27_8 = 0
			local var_27_9 = 0.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
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

				local var_27_10 = arg_24_1:GetWordFromCfg(418071006)
				local var_27_11 = arg_24_1:FormatText(var_27_10.content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 6 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 6)

				if (6 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 6)) > 0 and var_27_9 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb") / 1000

					if var_27_14 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_8
					end

					if var_27_10.prefab_name ~= "" and arg_24_1.actors_[var_27_10.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_10.prefab_name].transform, "story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")

						arg_24_1:RecordAudio("418071006", var_27_15)
						arg_24_1:RecordAudio("418071006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071006", "story_v_side_old_418071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_16 and arg_24_1.time_ < var_27_8 + var_27_16 + arg_27_0 then
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
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play418071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418071007
		arg_28_1.duration_ = 8.43

		local var_28_0 = {
			ja = 8.433,
			CriLanguages = 4.8,
			zh = 4.8
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
				arg_28_0:Play418071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1073"]) and arg_28_1.var_.actorSpriteComps1073 == nil then
				arg_28_1.var_.actorSpriteComps1073 = arg_28_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1073"]) then
				if arg_28_1.var_.actorSpriteComps1073 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								iter_31_1.color = Color.New(Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor1.r, (arg_28_1.time_ - 0) / var_31_0), Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor1.g, (arg_28_1.time_ - 0) / var_31_0), (Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor1.b, (arg_28_1.time_ - 0) / var_31_0)))
							else
								local var_31_1 = Mathf.Lerp(iter_31_1.color.r, 1, (arg_28_1.time_ - 0) / var_31_0)

								iter_31_1.color = Color.New(var_31_1, var_31_1, var_31_1)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1073"]) and arg_28_1.var_.actorSpriteComps1073 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps1073 = nil
			end

			local var_31_2 = arg_28_1.actors_["10135"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps10135 == nil then
				arg_28_1.var_.actorSpriteComps10135 = var_31_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.actorSpriteComps10135 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_31_5 then
							if arg_28_1.isInRecall_ then
								iter_31_5.color = Color.New(Mathf.Lerp(iter_31_5.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_3), Mathf.Lerp(iter_31_5.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_3), (Mathf.Lerp(iter_31_5.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_3)))
							else
								local var_31_4 = Mathf.Lerp(iter_31_5.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_3)

								iter_31_5.color = Color.New(var_31_4, var_31_4, var_31_4)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps10135 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_31_7 then
						iter_31_7.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps10135 = nil
			end

			local var_31_5 = arg_28_1.actors_["1073"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1073 = var_31_5.localPosition
				var_31_5.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1073", 2)

				for iter_31_8 = 0, var_31_5.childCount - 1 do
					local var_31_6 = var_31_5:GetChild(iter_31_8)

					if var_31_6.name == "split_1" or not string.find(var_31_6.name, "split") then
						var_31_6.gameObject:SetActive(true)
					else
						var_31_6.gameObject:SetActive(false)
					end
				end
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_28_1.time_ - 0) / var_31_7)
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_31_8 = 0
			local var_31_9 = 0.575

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(418071007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 23 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 23)

				if (23 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 23)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")

						arg_28_1:RecordAudio("418071007", var_31_15)
						arg_28_1:RecordAudio("418071007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071007", "story_v_side_old_418071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play418071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418071008
		arg_32_1.duration_ = 5.7

		local var_32_0 = {
			ja = 5.6,
			CriLanguages = 5.7,
			zh = 5.7
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
				arg_32_0:Play418071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10135"]) and arg_32_1.var_.actorSpriteComps10135 == nil then
				arg_32_1.var_.actorSpriteComps10135 = arg_32_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10135"]) then
				if arg_32_1.var_.actorSpriteComps10135 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 1, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10135"]) and arg_32_1.var_.actorSpriteComps10135 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps10135 = nil
			end

			local var_35_2 = arg_32_1.actors_["1073"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1073 == nil then
				arg_32_1.var_.actorSpriteComps1073 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps1073 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								iter_35_5.color = Color.New(Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_3), Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_3), (Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_3)))
							else
								local var_35_4 = Mathf.Lerp(iter_35_5.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_3)

								iter_35_5.color = Color.New(var_35_4, var_35_4, var_35_4)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps1073 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_35_7 then
						iter_35_7.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps1073 = nil
			end

			local var_35_5 = arg_32_1.actors_["10135"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10135 = var_35_5.localPosition
				var_35_5.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10135", 4)

				for iter_35_8 = 0, var_35_5.childCount - 1 do
					local var_35_6 = var_35_5:GetChild(iter_35_8)

					if var_35_6.name == "" or not string.find(var_35_6.name, "split") then
						var_35_6.gameObject:SetActive(true)
					else
						var_35_6.gameObject:SetActive(false)
					end
				end
			end

			local var_35_7 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_32_1.time_ - 0) / var_35_7)
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_35_8 = 0
			local var_35_9 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(418071008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 21 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 21)

				if (21 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 21)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")

						arg_32_1:RecordAudio("418071008", var_35_15)
						arg_32_1:RecordAudio("418071008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071008", "story_v_side_old_418071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play418071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418071009
		arg_36_1.duration_ = 7.37

		local var_36_0 = {
			ja = 7.366,
			CriLanguages = 6.1,
			zh = 6.1
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
				arg_36_0:Play418071010(arg_36_1)
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

			local var_39_2 = arg_36_1.actors_["10135"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10135 == nil then
				arg_36_1.var_.actorSpriteComps10135 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps10135 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								iter_39_5.color = Color.New(Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_3), Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_3), (Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_3)))
							else
								local var_39_4 = Mathf.Lerp(iter_39_5.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_3)

								iter_39_5.color = Color.New(var_39_4, var_39_4, var_39_4)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10135 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps10135 = nil
			end

			local var_39_5 = arg_36_1.actors_["1073"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1073 = var_39_5.localPosition
				var_39_5.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1073", 2)

				for iter_39_8 = 0, var_39_5.childCount - 1 do
					local var_39_6 = var_39_5:GetChild(iter_39_8)

					if var_39_6.name == "" or not string.find(var_39_6.name, "split") then
						var_39_6.gameObject:SetActive(true)
					else
						var_39_6.gameObject:SetActive(false)
					end
				end
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_36_1.time_ - 0) / var_39_7)
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_39_8 = 0
			local var_39_9 = 0.575

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

				local var_39_10 = arg_36_1:GetWordFromCfg(418071009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 23 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 23)

				if (23 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 23)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")

						arg_36_1:RecordAudio("418071009", var_39_15)
						arg_36_1:RecordAudio("418071009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071009", "story_v_side_old_418071.awb")
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
	Play418071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418071010
		arg_40_1.duration_ = 10.77

		local var_40_0 = {
			ja = 10.766,
			CriLanguages = 10,
			zh = 10
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
				arg_40_0:Play418071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10135"]) and arg_40_1.var_.actorSpriteComps10135 == nil then
				arg_40_1.var_.actorSpriteComps10135 = arg_40_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10135"]) then
				if arg_40_1.var_.actorSpriteComps10135 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 1, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10135"]) and arg_40_1.var_.actorSpriteComps10135 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps10135 = nil
			end

			local var_43_2 = arg_40_1.actors_["1073"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = var_43_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								iter_43_5.color = Color.New(Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor2.r, (arg_40_1.time_ - 0) / var_43_3), Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor2.g, (arg_40_1.time_ - 0) / var_43_3), (Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor2.b, (arg_40_1.time_ - 0) / var_43_3)))
							else
								local var_43_4 = Mathf.Lerp(iter_43_5.color.r, 0.5, (arg_40_1.time_ - 0) / var_43_3)

								iter_43_5.color = Color.New(var_43_4, var_43_4, var_43_4)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_7 then
						iter_43_7.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_5 = arg_40_1.actors_["10135"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10135 = var_43_5.localPosition
				var_43_5.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10135", 4)

				for iter_43_8 = 0, var_43_5.childCount - 1 do
					local var_43_6 = var_43_5:GetChild(iter_43_8)

					if var_43_6.name == "split_2" or not string.find(var_43_6.name, "split") then
						var_43_6.gameObject:SetActive(true)
					else
						var_43_6.gameObject:SetActive(false)
					end
				end
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_40_1.time_ - 0) / var_43_7)
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_43_8 = 0
			local var_43_9 = 1.125

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(418071010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 45 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 45)

				if (45 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 45)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")

						arg_40_1:RecordAudio("418071010", var_43_15)
						arg_40_1:RecordAudio("418071010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071010", "story_v_side_old_418071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_16 and arg_40_1.time_ < var_43_8 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play418071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418071011
		arg_44_1.duration_ = 7.93

		local var_44_0 = {
			ja = 7.933,
			CriLanguages = 6.6,
			zh = 6.6
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
				arg_44_0:Play418071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1073"]) and arg_44_1.var_.actorSpriteComps1073 == nil then
				arg_44_1.var_.actorSpriteComps1073 = arg_44_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1073"]) then
				if arg_44_1.var_.actorSpriteComps1073 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								iter_47_1.color = Color.New(Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_0), Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_0), (Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_0)))
							else
								local var_47_1 = Mathf.Lerp(iter_47_1.color.r, 1, (arg_44_1.time_ - 0) / var_47_0)

								iter_47_1.color = Color.New(var_47_1, var_47_1, var_47_1)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1073"]) and arg_44_1.var_.actorSpriteComps1073 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps1073 = nil
			end

			local var_47_2 = arg_44_1.actors_["10135"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps10135 == nil then
				arg_44_1.var_.actorSpriteComps10135 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps10135 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								iter_47_5.color = Color.New(Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_5.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_5.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps10135 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_47_7 then
						iter_47_7.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps10135 = nil
			end

			local var_47_5 = 0
			local var_47_6 = 0.775

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:GetWordFromCfg(418071011)
				local var_47_8 = arg_44_1:FormatText(var_47_7.content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 31 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 31)

				if (31 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 31)) > 0 and var_47_6 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb") ~= 0 then
					local var_47_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb") / 1000

					if var_47_11 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_5
					end

					if var_47_7.prefab_name ~= "" and arg_44_1.actors_[var_47_7.prefab_name] ~= nil then
						local var_47_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_7.prefab_name].transform, "story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")

						arg_44_1:RecordAudio("418071011", var_47_12)
						arg_44_1:RecordAudio("418071011", var_47_12)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071011", "story_v_side_old_418071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_13 and arg_44_1.time_ < var_47_5 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418071012
		arg_48_1.duration_ = 8.87

		local var_48_0 = {
			ja = 7.933,
			CriLanguages = 8.866,
			zh = 8.866
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
				arg_48_0:Play418071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10135"]) and arg_48_1.var_.actorSpriteComps10135 == nil then
				arg_48_1.var_.actorSpriteComps10135 = arg_48_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10135"]) then
				if arg_48_1.var_.actorSpriteComps10135 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10135"]) and arg_48_1.var_.actorSpriteComps10135 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps10135 = nil
			end

			local var_51_2 = arg_48_1.actors_["1073"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps1073 == nil then
				arg_48_1.var_.actorSpriteComps1073 = var_51_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_3 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.actorSpriteComps1073 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								iter_51_5.color = Color.New(Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_3), Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_3), (Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_3)))
							else
								local var_51_4 = Mathf.Lerp(iter_51_5.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_3)

								iter_51_5.color = Color.New(var_51_4, var_51_4, var_51_4)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.actorSpriteComps1073 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_51_7 then
						iter_51_7.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps1073 = nil
			end

			local var_51_5 = 0
			local var_51_6 = 1.1

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(418071012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 44 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 44)

				if (44 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 44)) > 0 and var_51_6 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb") ~= 0 then
					local var_51_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb") / 1000

					if var_51_11 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_5
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")

						arg_48_1:RecordAudio("418071012", var_51_12)
						arg_48_1:RecordAudio("418071012", var_51_12)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071012", "story_v_side_old_418071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_13 and arg_48_1.time_ < var_51_5 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play418071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418071013
		arg_52_1.duration_ = 1.53

		local var_52_0 = {
			ja = 1.533,
			CriLanguages = 1.166,
			zh = 1.166
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
				arg_52_0:Play418071014(arg_52_1)
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
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 1, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1073"]) and arg_52_1.var_.actorSpriteComps1073 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps1073 = nil
			end

			local var_55_2 = arg_52_1.actors_["10135"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps10135 == nil then
				arg_52_1.var_.actorSpriteComps10135 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps10135 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								iter_55_5.color = Color.New(Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, (arg_52_1.time_ - 0) / var_55_3), Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, (arg_52_1.time_ - 0) / var_55_3), (Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, (arg_52_1.time_ - 0) / var_55_3)))
							else
								local var_55_4 = Mathf.Lerp(iter_55_5.color.r, 0.5, (arg_52_1.time_ - 0) / var_55_3)

								iter_55_5.color = Color.New(var_55_4, var_55_4, var_55_4)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps10135 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps10135 = nil
			end

			local var_55_5 = 0
			local var_55_6 = 0.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_7 = arg_52_1:GetWordFromCfg(418071013)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 4 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 4)

				if (4 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 4)) > 0 and var_55_6 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb") ~= 0 then
					local var_55_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb") / 1000

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")

						arg_52_1:RecordAudio("418071013", var_55_12)
						arg_52_1:RecordAudio("418071013", var_55_12)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071013", "story_v_side_old_418071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_5) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_5 + var_55_13 and arg_52_1.time_ < var_55_5 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play418071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418071014
		arg_56_1.duration_ = 13.33

		local var_56_0 = {
			ja = 13.333,
			CriLanguages = 10.066,
			zh = 10.066
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
				arg_56_0:Play418071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10135"]) and arg_56_1.var_.actorSpriteComps10135 == nil then
				arg_56_1.var_.actorSpriteComps10135 = arg_56_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10135"]) then
				if arg_56_1.var_.actorSpriteComps10135 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10135"]) and arg_56_1.var_.actorSpriteComps10135 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps10135 = nil
			end

			local var_59_2 = arg_56_1.actors_["1073"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1073 == nil then
				arg_56_1.var_.actorSpriteComps1073 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps1073 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_59_5 then
							if arg_56_1.isInRecall_ then
								iter_59_5.color = Color.New(Mathf.Lerp(iter_59_5.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_3), Mathf.Lerp(iter_59_5.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_3), (Mathf.Lerp(iter_59_5.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_3)))
							else
								local var_59_4 = Mathf.Lerp(iter_59_5.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_3)

								iter_59_5.color = Color.New(var_59_4, var_59_4, var_59_4)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps1073 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_59_7 then
						iter_59_7.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps1073 = nil
			end

			local var_59_5 = arg_56_1.actors_["10135"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10135 = var_59_5.localPosition
				var_59_5.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10135", 4)

				for iter_59_8 = 0, var_59_5.childCount - 1 do
					local var_59_6 = var_59_5:GetChild(iter_59_8)

					if var_59_6.name == "" or not string.find(var_59_6.name, "split") then
						var_59_6.gameObject:SetActive(true)
					else
						var_59_6.gameObject:SetActive(false)
					end
				end
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_56_1.time_ - 0) / var_59_7)
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_59_8 = 0
			local var_59_9 = 1.25

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:GetWordFromCfg(418071014)
				local var_59_11 = arg_56_1:FormatText(var_59_10.content)

				arg_56_1.text_.text = var_59_11

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 50 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 50)

				if (50 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_11) / 50)) > 0 and var_59_9 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_11
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb") / 1000

					if var_59_14 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_8
					end

					if var_59_10.prefab_name ~= "" and arg_56_1.actors_[var_59_10.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_10.prefab_name].transform, "story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")

						arg_56_1:RecordAudio("418071014", var_59_15)
						arg_56_1:RecordAudio("418071014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071014", "story_v_side_old_418071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_16 and arg_56_1.time_ < var_59_8 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play418071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 418071015
		arg_60_1.duration_ = 10.3

		local var_60_0 = {
			ja = 10.3,
			CriLanguages = 7.466,
			zh = 7.466
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
				arg_60_0:Play418071016(arg_60_1)
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
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 1, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1073"]) and arg_60_1.var_.actorSpriteComps1073 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps1073 = nil
			end

			local var_63_2 = arg_60_1.actors_["10135"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps10135 == nil then
				arg_60_1.var_.actorSpriteComps10135 = var_63_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_3 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.actorSpriteComps10135 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								iter_63_5.color = Color.New(Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_3), Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_3), (Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_3)))
							else
								local var_63_4 = Mathf.Lerp(iter_63_5.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_3)

								iter_63_5.color = Color.New(var_63_4, var_63_4, var_63_4)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps10135 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_63_7 then
						iter_63_7.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps10135 = nil
			end

			local var_63_5 = arg_60_1.actors_["1073"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1073 = var_63_5.localPosition
				var_63_5.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1073", 2)

				for iter_63_8 = 0, var_63_5.childCount - 1 do
					local var_63_6 = var_63_5:GetChild(iter_63_8)

					if var_63_6.name == "" or not string.find(var_63_6.name, "split") then
						var_63_6.gameObject:SetActive(true)
					else
						var_63_6.gameObject:SetActive(false)
					end
				end
			end

			local var_63_7 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_60_1.time_ - 0) / var_63_7)
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_63_8 = 0
			local var_63_9 = 0.975

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(418071015)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 39 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 39)

				if (39 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 39)) > 0 and var_63_9 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb") / 1000

					if var_63_14 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_8
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")

						arg_60_1:RecordAudio("418071015", var_63_15)
						arg_60_1:RecordAudio("418071015", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071015", "story_v_side_old_418071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_16 and arg_60_1.time_ < var_63_8 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play418071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 418071016
		arg_64_1.duration_ = 6.3

		local var_64_0 = {
			ja = 6.3,
			CriLanguages = 4.233,
			zh = 4.233
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play418071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10135"]) and arg_64_1.var_.actorSpriteComps10135 == nil then
				arg_64_1.var_.actorSpriteComps10135 = arg_64_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10135"]) then
				if arg_64_1.var_.actorSpriteComps10135 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 1, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10135"]) and arg_64_1.var_.actorSpriteComps10135 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps10135 = nil
			end

			local var_67_2 = arg_64_1.actors_["1073"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1073 == nil then
				arg_64_1.var_.actorSpriteComps1073 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps1073 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_67_5 then
							if arg_64_1.isInRecall_ then
								iter_67_5.color = Color.New(Mathf.Lerp(iter_67_5.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_3), Mathf.Lerp(iter_67_5.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_3), (Mathf.Lerp(iter_67_5.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_3)))
							else
								local var_67_4 = Mathf.Lerp(iter_67_5.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_3)

								iter_67_5.color = Color.New(var_67_4, var_67_4, var_67_4)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps1073 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps1073 = nil
			end

			local var_67_5 = arg_64_1.actors_["10135"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10135 = var_67_5.localPosition
				var_67_5.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10135", 4)

				for iter_67_8 = 0, var_67_5.childCount - 1 do
					local var_67_6 = var_67_5:GetChild(iter_67_8)

					if var_67_6.name == "" or not string.find(var_67_6.name, "split") then
						var_67_6.gameObject:SetActive(true)
					else
						var_67_6.gameObject:SetActive(false)
					end
				end
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_64_1.time_ - 0) / var_67_7)
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_67_8 = 0
			local var_67_9 = 0.525

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_10 = arg_64_1:GetWordFromCfg(418071016)
				local var_67_11 = arg_64_1:FormatText(var_67_10.content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 21 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 21)

				if (21 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 21)) > 0 and var_67_9 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb") / 1000

					if var_67_14 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_8
					end

					if var_67_10.prefab_name ~= "" and arg_64_1.actors_[var_67_10.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_10.prefab_name].transform, "story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")

						arg_64_1:RecordAudio("418071016", var_67_15)
						arg_64_1:RecordAudio("418071016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071016", "story_v_side_old_418071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_8) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_8 + var_67_16 and arg_64_1.time_ < var_67_8 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play418071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 418071017
		arg_68_1.duration_ = 16.2

		local var_68_0 = {
			ja = 16.2,
			CriLanguages = 11.666,
			zh = 11.666
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
				arg_68_0:Play418071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1073"]) and arg_68_1.var_.actorSpriteComps1073 == nil then
				arg_68_1.var_.actorSpriteComps1073 = arg_68_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1073"]) then
				if arg_68_1.var_.actorSpriteComps1073 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1073"]) and arg_68_1.var_.actorSpriteComps1073 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps1073 = nil
			end

			local var_71_2 = arg_68_1.actors_["10135"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.actorSpriteComps10135 == nil then
				arg_68_1.var_.actorSpriteComps10135 = var_71_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_3 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.actorSpriteComps10135 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_71_5 then
							if arg_68_1.isInRecall_ then
								iter_71_5.color = Color.New(Mathf.Lerp(iter_71_5.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_3), Mathf.Lerp(iter_71_5.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_3), (Mathf.Lerp(iter_71_5.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_3)))
							else
								local var_71_4 = Mathf.Lerp(iter_71_5.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_3)

								iter_71_5.color = Color.New(var_71_4, var_71_4, var_71_4)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.actorSpriteComps10135 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_71_7 then
						iter_71_7.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps10135 = nil
			end

			local var_71_5 = arg_68_1.actors_["1073"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1073 = var_71_5.localPosition
				var_71_5.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("1073", 2)

				for iter_71_8 = 0, var_71_5.childCount - 1 do
					local var_71_6 = var_71_5:GetChild(iter_71_8)

					if var_71_6.name == "split_5" or not string.find(var_71_6.name, "split") then
						var_71_6.gameObject:SetActive(true)
					else
						var_71_6.gameObject:SetActive(false)
					end
				end
			end

			local var_71_7 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				var_71_5.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_68_1.time_ - 0) / var_71_7)
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				var_71_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_71_8 = 0
			local var_71_9 = 1.4

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_8 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_10 = arg_68_1:GetWordFromCfg(418071017)
				local var_71_11 = arg_68_1:FormatText(var_71_10.content)

				arg_68_1.text_.text = var_71_11

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_13 = 56 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 56)

				if (56 <= 0 and var_71_9 or var_71_9 * (utf8.len(var_71_11) / 56)) > 0 and var_71_9 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_8
					end
				end

				arg_68_1.text_.text = var_71_11
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb") / 1000

					if var_71_14 + var_71_8 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_8
					end

					if var_71_10.prefab_name ~= "" and arg_68_1.actors_[var_71_10.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_10.prefab_name].transform, "story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")

						arg_68_1:RecordAudio("418071017", var_71_15)
						arg_68_1:RecordAudio("418071017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071017", "story_v_side_old_418071.awb")
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
	Play418071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 418071018
		arg_72_1.duration_ = 19.07

		local var_72_0 = {
			ja = 19.066,
			CriLanguages = 17.566,
			zh = 17.566
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
				arg_72_0:Play418071019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 2.125

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
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

				local var_75_1 = arg_72_1:GetWordFromCfg(418071018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 85 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 85)

				if (85 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 85)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")

						arg_72_1:RecordAudio("418071018", var_75_6)
						arg_72_1:RecordAudio("418071018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071018", "story_v_side_old_418071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play418071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 418071019
		arg_76_1.duration_ = 14.23

		local var_76_0 = {
			ja = 14.233,
			CriLanguages = 13.933,
			zh = 13.933
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
				arg_76_0:Play418071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1073 = arg_76_1.actors_["1073"].transform.localPosition
				arg_76_1.actors_["1073"].transform.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1073", 2)

				for iter_79_0 = 0, arg_76_1.actors_["1073"].transform.childCount - 1 do
					local var_79_0 = arg_76_1.actors_["1073"].transform:GetChild(iter_79_0)

					if var_79_0.name == "" or not string.find(var_79_0.name, "split") then
						var_79_0.gameObject:SetActive(true)
					else
						var_79_0.gameObject:SetActive(false)
					end
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["1073"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_76_1.time_ - 0) / var_79_1)
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["1073"].transform.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_79_2 = 0
			local var_79_3 = 1.7

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(418071019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 68 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 68)

				if (68 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 68)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")

						arg_76_1:RecordAudio("418071019", var_79_9)
						arg_76_1:RecordAudio("418071019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071019", "story_v_side_old_418071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play418071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 418071020
		arg_80_1.duration_ = 3.27

		local var_80_0 = {
			ja = 3,
			CriLanguages = 3.266,
			zh = 3.266
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
				arg_80_0:Play418071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10135"]) and arg_80_1.var_.actorSpriteComps10135 == nil then
				arg_80_1.var_.actorSpriteComps10135 = arg_80_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10135"]) then
				if arg_80_1.var_.actorSpriteComps10135 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10135"]) and arg_80_1.var_.actorSpriteComps10135 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps10135 = nil
			end

			local var_83_2 = arg_80_1.actors_["1073"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1073 == nil then
				arg_80_1.var_.actorSpriteComps1073 = var_83_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_3 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.actorSpriteComps1073 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1073 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_83_7 then
						iter_83_7.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_80_1.var_.actorSpriteComps1073 = nil
			end

			local var_83_5 = arg_80_1.actors_["10135"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10135 = var_83_5.localPosition
				var_83_5.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10135", 4)

				for iter_83_8 = 0, var_83_5.childCount - 1 do
					local var_83_6 = var_83_5:GetChild(iter_83_8)

					if var_83_6.name == "" or not string.find(var_83_6.name, "split") then
						var_83_6.gameObject:SetActive(true)
					else
						var_83_6.gameObject:SetActive(false)
					end
				end
			end

			local var_83_7 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_80_1.time_ - 0) / var_83_7)
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_83_8 = 0
			local var_83_9 = 0.375

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:GetWordFromCfg(418071020)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 15 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 15)

				if (15 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 15)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb") / 1000

					if var_83_14 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_8
					end

					if var_83_10.prefab_name ~= "" and arg_80_1.actors_[var_83_10.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_10.prefab_name].transform, "story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")

						arg_80_1:RecordAudio("418071020", var_83_15)
						arg_80_1:RecordAudio("418071020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071020", "story_v_side_old_418071.awb")
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
				actorName = "10135",
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
	Play418071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 418071021
		arg_84_1.duration_ = 12.97

		local var_84_0 = {
			ja = 12.966,
			CriLanguages = 10.366,
			zh = 10.366
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play418071022(arg_84_1)
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
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 1, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1073"]) and arg_84_1.var_.actorSpriteComps1073 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps1073 = nil
			end

			local var_87_2 = arg_84_1.actors_["10135"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps10135 == nil then
				arg_84_1.var_.actorSpriteComps10135 = var_87_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_3 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.actorSpriteComps10135 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								iter_87_5.color = Color.New(Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_3), Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_3), (Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_3)))
							else
								local var_87_4 = Mathf.Lerp(iter_87_5.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_3)

								iter_87_5.color = Color.New(var_87_4, var_87_4, var_87_4)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps10135 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_87_7 then
						iter_87_7.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps10135 = nil
			end

			local var_87_5 = 0
			local var_87_6 = 1.275

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:GetWordFromCfg(418071021)
				local var_87_8 = arg_84_1:FormatText(var_87_7.content)

				arg_84_1.text_.text = var_87_8

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 51 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 51)

				if (51 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 51)) > 0 and var_87_6 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_8
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb") ~= 0 then
					local var_87_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb") / 1000

					if var_87_11 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_5
					end

					if var_87_7.prefab_name ~= "" and arg_84_1.actors_[var_87_7.prefab_name] ~= nil then
						local var_87_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_7.prefab_name].transform, "story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")

						arg_84_1:RecordAudio("418071021", var_87_12)
						arg_84_1:RecordAudio("418071021", var_87_12)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071021", "story_v_side_old_418071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_13 and arg_84_1.time_ < var_87_5 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play418071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 418071022
		arg_88_1.duration_ = 14.23

		local var_88_0 = {
			ja = 14.233,
			CriLanguages = 10.1,
			zh = 10.1
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play418071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.35

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(418071022)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 54 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 54)

				if (54 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 54)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")

						arg_88_1:RecordAudio("418071022", var_91_6)
						arg_88_1:RecordAudio("418071022", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071022", "story_v_side_old_418071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play418071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 418071023
		arg_92_1.duration_ = 4.73

		local var_92_0 = {
			ja = 4.2,
			CriLanguages = 4.733,
			zh = 4.733
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
				arg_92_0:Play418071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10135"]) and arg_92_1.var_.actorSpriteComps10135 == nil then
				arg_92_1.var_.actorSpriteComps10135 = arg_92_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10135"]) then
				if arg_92_1.var_.actorSpriteComps10135 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 1, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10135"]) and arg_92_1.var_.actorSpriteComps10135 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps10135 = nil
			end

			local var_95_2 = arg_92_1.actors_["1073"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1073 == nil then
				arg_92_1.var_.actorSpriteComps1073 = var_95_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_3 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.actorSpriteComps1073 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								iter_95_5.color = Color.New(Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_3), Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_3), (Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_3)))
							else
								local var_95_4 = Mathf.Lerp(iter_95_5.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_3)

								iter_95_5.color = Color.New(var_95_4, var_95_4, var_95_4)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1073 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_95_7 then
						iter_95_7.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps1073 = nil
			end

			local var_95_5 = arg_92_1.actors_["10135"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10135 = var_95_5.localPosition
				var_95_5.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10135", 4)

				for iter_95_8 = 0, var_95_5.childCount - 1 do
					local var_95_6 = var_95_5:GetChild(iter_95_8)

					if var_95_6.name == "" or not string.find(var_95_6.name, "split") then
						var_95_6.gameObject:SetActive(true)
					else
						var_95_6.gameObject:SetActive(false)
					end
				end
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_92_1.time_ - 0) / var_95_7)
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_95_8 = 0
			local var_95_9 = 0.625

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(418071023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 25 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 25)

				if (25 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 25)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")

						arg_92_1:RecordAudio("418071023", var_95_15)
						arg_92_1:RecordAudio("418071023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071023", "story_v_side_old_418071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play418071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 418071024
		arg_96_1.duration_ = 15.97

		local var_96_0 = {
			ja = 15.966,
			CriLanguages = 12.566,
			zh = 12.566
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
				arg_96_0:Play418071025(arg_96_1)
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
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 1, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1073"]) and arg_96_1.var_.actorSpriteComps1073 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps1073 = nil
			end

			local var_99_2 = arg_96_1.actors_["10135"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps10135 == nil then
				arg_96_1.var_.actorSpriteComps10135 = var_99_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_3 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.actorSpriteComps10135 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								iter_99_5.color = Color.New(Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_3), Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_3), (Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_3)))
							else
								local var_99_4 = Mathf.Lerp(iter_99_5.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_3)

								iter_99_5.color = Color.New(var_99_4, var_99_4, var_99_4)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.actorSpriteComps10135 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_99_7 then
						iter_99_7.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps10135 = nil
			end

			local var_99_5 = arg_96_1.actors_["1073"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1073 = var_99_5.localPosition
				var_99_5.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1073", 2)

				for iter_99_8 = 0, var_99_5.childCount - 1 do
					local var_99_6 = var_99_5:GetChild(iter_99_8)

					if var_99_6.name == "split_4" or not string.find(var_99_6.name, "split") then
						var_99_6.gameObject:SetActive(true)
					else
						var_99_6.gameObject:SetActive(false)
					end
				end
			end

			local var_99_7 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_96_1.time_ - 0) / var_99_7)
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_99_8 = 0
			local var_99_9 = 1.425

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(418071024)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 57 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 57)

				if (57 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 57)) > 0 and var_99_9 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb") / 1000

					if var_99_14 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_8
					end

					if var_99_10.prefab_name ~= "" and arg_96_1.actors_[var_99_10.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_10.prefab_name].transform, "story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")

						arg_96_1:RecordAudio("418071024", var_99_15)
						arg_96_1:RecordAudio("418071024", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071024", "story_v_side_old_418071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_16 and arg_96_1.time_ < var_99_8 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play418071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 418071025
		arg_100_1.duration_ = 10.1

		local var_100_0 = {
			ja = 10.1,
			CriLanguages = 7.5,
			zh = 7.5
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
				arg_100_0:Play418071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1073 = arg_100_1.actors_["1073"].transform.localPosition
				arg_100_1.actors_["1073"].transform.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1073", 2)

				for iter_103_0 = 0, arg_100_1.actors_["1073"].transform.childCount - 1 do
					local var_103_0 = arg_100_1.actors_["1073"].transform:GetChild(iter_103_0)

					if var_103_0.name == "" or not string.find(var_103_0.name, "split") then
						var_103_0.gameObject:SetActive(true)
					else
						var_103_0.gameObject:SetActive(false)
					end
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["1073"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_100_1.time_ - 0) / var_103_1)
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["1073"].transform.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_103_2 = 0
			local var_103_3 = 1

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

				local var_103_4 = arg_100_1:GetWordFromCfg(418071025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 40 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 40)

				if (40 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 40)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")

						arg_100_1:RecordAudio("418071025", var_103_9)
						arg_100_1:RecordAudio("418071025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071025", "story_v_side_old_418071.awb")
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

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play418071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 418071026
		arg_104_1.duration_ = 8.07

		local var_104_0 = {
			ja = 8.066,
			CriLanguages = 6.6,
			zh = 6.6
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
				arg_104_0:Play418071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10135"]) and arg_104_1.var_.actorSpriteComps10135 == nil then
				arg_104_1.var_.actorSpriteComps10135 = arg_104_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10135"]) then
				if arg_104_1.var_.actorSpriteComps10135 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 1, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10135"]) and arg_104_1.var_.actorSpriteComps10135 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps10135 = nil
			end

			local var_107_2 = arg_104_1.actors_["1073"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1073 == nil then
				arg_104_1.var_.actorSpriteComps1073 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps1073 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_5.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_5.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps1073 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps1073 = nil
			end

			local var_107_5 = arg_104_1.actors_["10135"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10135 = var_107_5.localPosition
				var_107_5.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10135", 4)

				for iter_107_8 = 0, var_107_5.childCount - 1 do
					local var_107_6 = var_107_5:GetChild(iter_107_8)

					if var_107_6.name == "" or not string.find(var_107_6.name, "split") then
						var_107_6.gameObject:SetActive(true)
					else
						var_107_6.gameObject:SetActive(false)
					end
				end
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_104_1.time_ - 0) / var_107_7)
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_107_8 = 0
			local var_107_9 = 0.725

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(418071026)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 29 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 29)

				if (29 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 29)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")

						arg_104_1:RecordAudio("418071026", var_107_15)
						arg_104_1:RecordAudio("418071026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071026", "story_v_side_old_418071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play418071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 418071027
		arg_108_1.duration_ = 15.6

		local var_108_0 = {
			ja = 15.6,
			CriLanguages = 10.5,
			zh = 10.5
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
				arg_108_0:Play418071028(arg_108_1)
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
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1073"]) and arg_108_1.var_.actorSpriteComps1073 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1073 = nil
			end

			local var_111_2 = arg_108_1.actors_["10135"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10135 == nil then
				arg_108_1.var_.actorSpriteComps10135 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps10135 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								iter_111_5.color = Color.New(Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_5.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_5.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10135 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_111_7 then
						iter_111_7.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps10135 = nil
			end

			local var_111_5 = 0
			local var_111_6 = 1.3

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(418071027)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 52 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 52)

				if (52 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 52)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")

						arg_108_1:RecordAudio("418071027", var_111_12)
						arg_108_1:RecordAudio("418071027", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071027", "story_v_side_old_418071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play418071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 418071028
		arg_112_1.duration_ = 14.9

		local var_112_0 = {
			ja = 14.9,
			CriLanguages = 10.7,
			zh = 10.7
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
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play418071029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.05

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(418071028)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 42 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 42)

				if (42 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 42)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")

						arg_112_1:RecordAudio("418071028", var_115_6)
						arg_112_1:RecordAudio("418071028", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071028", "story_v_side_old_418071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play418071029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 418071029
		arg_116_1.duration_ = 21.13

		local var_116_0 = {
			ja = 21.133,
			CriLanguages = 14.166,
			zh = 14.166
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play418071030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10135"]) and arg_116_1.var_.actorSpriteComps10135 == nil then
				arg_116_1.var_.actorSpriteComps10135 = arg_116_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10135"]) then
				if arg_116_1.var_.actorSpriteComps10135 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10135"]) and arg_116_1.var_.actorSpriteComps10135 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps10135 = nil
			end

			local var_119_2 = arg_116_1.actors_["1073"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1073 == nil then
				arg_116_1.var_.actorSpriteComps1073 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps1073 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_3), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_3), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_3)))
							else
								local var_119_4 = Mathf.Lerp(iter_119_5.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_3)

								iter_119_5.color = Color.New(var_119_4, var_119_4, var_119_4)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps1073 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps1073 = nil
			end

			local var_119_5 = arg_116_1.actors_["1073"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1073 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1073", 2)

				for iter_119_8 = 0, var_119_5.childCount - 1 do
					local var_119_6 = var_119_5:GetChild(iter_119_8)

					if var_119_6.name == "" or not string.find(var_119_6.name, "split") then
						var_119_6.gameObject:SetActive(true)
					else
						var_119_6.gameObject:SetActive(false)
					end
				end
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_119_8 = 0
			local var_119_9 = 1.6

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(418071029)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 64 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 64)

				if (64 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 64)) > 0 and var_119_9 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb") / 1000

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")

						arg_116_1:RecordAudio("418071029", var_119_15)
						arg_116_1:RecordAudio("418071029", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071029", "story_v_side_old_418071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_16 and arg_116_1.time_ < var_119_8 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play418071030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 418071030
		arg_120_1.duration_ = 12.23

		local var_120_0 = {
			ja = 12,
			CriLanguages = 12.233,
			zh = 12.233
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play418071031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1073"]) and arg_120_1.var_.actorSpriteComps1073 == nil then
				arg_120_1.var_.actorSpriteComps1073 = arg_120_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1073"]) then
				if arg_120_1.var_.actorSpriteComps1073 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1073"]) and arg_120_1.var_.actorSpriteComps1073 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps1073 = nil
			end

			local var_123_2 = arg_120_1.actors_["10135"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10135 == nil then
				arg_120_1.var_.actorSpriteComps10135 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps10135 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10135 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps10135 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 1.45

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(418071030)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 58 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 58)

				if (58 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 58)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")

						arg_120_1:RecordAudio("418071030", var_123_12)
						arg_120_1:RecordAudio("418071030", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071030", "story_v_side_old_418071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play418071031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 418071031
		arg_124_1.duration_ = 5.6

		local var_124_0 = {
			ja = 5.6,
			CriLanguages = 4,
			zh = 4
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play418071032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10135"]) and arg_124_1.var_.actorSpriteComps10135 == nil then
				arg_124_1.var_.actorSpriteComps10135 = arg_124_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10135"]) then
				if arg_124_1.var_.actorSpriteComps10135 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 1, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10135"]) and arg_124_1.var_.actorSpriteComps10135 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps10135 = nil
			end

			local var_127_2 = arg_124_1.actors_["1073"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1073 == nil then
				arg_124_1.var_.actorSpriteComps1073 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps1073 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps1073 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1073 = nil
			end

			local var_127_5 = arg_124_1.actors_["10135"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10135 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10135", 4)

				for iter_127_8 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_8)

					if var_127_6.name == "split_5" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_127_8 = 0
			local var_127_9 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(418071031)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 21 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 21)

				if (21 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 21)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")

						arg_124_1:RecordAudio("418071031", var_127_15)
						arg_124_1:RecordAudio("418071031", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071031", "story_v_side_old_418071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play418071032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 418071032
		arg_128_1.duration_ = 8.63

		local var_128_0 = {
			ja = 8.633,
			CriLanguages = 6.8,
			zh = 6.8
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play418071033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1073"]) and arg_128_1.var_.actorSpriteComps1073 == nil then
				arg_128_1.var_.actorSpriteComps1073 = arg_128_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1073"]) then
				if arg_128_1.var_.actorSpriteComps1073 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1073"]) and arg_128_1.var_.actorSpriteComps1073 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps1073 = nil
			end

			local var_131_2 = arg_128_1.actors_["10135"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps10135 == nil then
				arg_128_1.var_.actorSpriteComps10135 = var_131_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_3 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.actorSpriteComps10135 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								iter_131_5.color = Color.New(Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_3), Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_3), (Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_3)))
							else
								local var_131_4 = Mathf.Lerp(iter_131_5.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_3)

								iter_131_5.color = Color.New(var_131_4, var_131_4, var_131_4)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps10135 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_131_7 then
						iter_131_7.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps10135 = nil
			end

			local var_131_5 = 0
			local var_131_6 = 0.825

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(418071032)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 33 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 33)

				if (33 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 33)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")

						arg_128_1:RecordAudio("418071032", var_131_12)
						arg_128_1:RecordAudio("418071032", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071032", "story_v_side_old_418071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play418071033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 418071033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play418071034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1073"]) and arg_132_1.var_.actorSpriteComps1073 == nil then
				arg_132_1.var_.actorSpriteComps1073 = arg_132_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1073"]) then
				if arg_132_1.var_.actorSpriteComps1073 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1073"]) and arg_132_1.var_.actorSpriteComps1073 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps1073 = nil
			end

			local var_135_2 = arg_132_1.actors_["1073"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1073 = var_135_2.localPosition
				var_135_2.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1073", 7)

				for iter_135_4 = 0, var_135_2.childCount - 1 do
					local var_135_3 = var_135_2:GetChild(iter_135_4)

					if var_135_3.name == "" or not string.find(var_135_3.name, "split") then
						var_135_3.gameObject:SetActive(true)
					else
						var_135_3.gameObject:SetActive(false)
					end
				end
			end

			local var_135_4 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				var_135_2.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_132_1.time_ - 0) / var_135_4)
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				var_135_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_5 = arg_132_1.actors_["10135"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10135 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10135", 7)

				for iter_135_5 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_5)

					if var_135_6.name == "" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_8 = 0
			local var_135_9 = 0.625

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(418071033).content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_12 = 25 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_10) / 25)

				if (25 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_10) / 25)) > 0 and var_135_9 < var_135_12 then
					arg_132_1.talkMaxDuration = var_135_12

					if var_135_12 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_13 and arg_132_1.time_ < var_135_8 + var_135_13 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play418071034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 418071034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play418071035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 1.125

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(418071034).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 45 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 45)

				if (45 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 45)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play418071035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 418071035
		arg_140_1.duration_ = 10.93

		local var_140_0 = {
			ja = 10.933,
			CriLanguages = 7.5,
			zh = 7.5
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play418071036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1073"]) and arg_140_1.var_.actorSpriteComps1073 == nil then
				arg_140_1.var_.actorSpriteComps1073 = arg_140_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1073"]) then
				if arg_140_1.var_.actorSpriteComps1073 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1073"]) and arg_140_1.var_.actorSpriteComps1073 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1073 = nil
			end

			local var_143_2 = arg_140_1.actors_["1073"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1073 = var_143_2.localPosition
				var_143_2.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1073", 2)

				for iter_143_4 = 0, var_143_2.childCount - 1 do
					local var_143_3 = var_143_2:GetChild(iter_143_4)

					if var_143_3.name == "" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_140_1.time_ - 0) / var_143_4)
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_143_5 = 0
			local var_143_6 = 0.975

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:GetWordFromCfg(418071035)
				local var_143_8 = arg_140_1:FormatText(var_143_7.content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 39 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_8) / 39)

				if (39 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_8) / 39)) > 0 and var_143_6 < var_143_10 then
					arg_140_1.talkMaxDuration = var_143_10

					if var_143_10 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb") ~= 0 then
					local var_143_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb") / 1000

					if var_143_11 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_5
					end

					if var_143_7.prefab_name ~= "" and arg_140_1.actors_[var_143_7.prefab_name] ~= nil then
						local var_143_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_7.prefab_name].transform, "story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")

						arg_140_1:RecordAudio("418071035", var_143_12)
						arg_140_1:RecordAudio("418071035", var_143_12)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071035", "story_v_side_old_418071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_13 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_13 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_13

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_13 and arg_140_1.time_ < var_143_5 + var_143_13 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play418071036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 418071036
		arg_144_1.duration_ = 10.33

		local var_144_0 = {
			ja = 10.333,
			CriLanguages = 8.666,
			zh = 8.666
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play418071037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10135"]) and arg_144_1.var_.actorSpriteComps10135 == nil then
				arg_144_1.var_.actorSpriteComps10135 = arg_144_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10135"]) then
				if arg_144_1.var_.actorSpriteComps10135 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 1, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10135"]) and arg_144_1.var_.actorSpriteComps10135 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps10135 = nil
			end

			local var_147_2 = arg_144_1.actors_["1073"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1073 == nil then
				arg_144_1.var_.actorSpriteComps1073 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps1073 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								iter_147_5.color = Color.New(Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor2.r, (arg_144_1.time_ - 0) / var_147_3), Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor2.g, (arg_144_1.time_ - 0) / var_147_3), (Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor2.b, (arg_144_1.time_ - 0) / var_147_3)))
							else
								local var_147_4 = Mathf.Lerp(iter_147_5.color.r, 0.5, (arg_144_1.time_ - 0) / var_147_3)

								iter_147_5.color = Color.New(var_147_4, var_147_4, var_147_4)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps1073 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_147_7 then
						iter_147_7.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps1073 = nil
			end

			local var_147_5 = arg_144_1.actors_["10135"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10135 = var_147_5.localPosition
				var_147_5.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10135", 4)

				for iter_147_8 = 0, var_147_5.childCount - 1 do
					local var_147_6 = var_147_5:GetChild(iter_147_8)

					if var_147_6.name == "" or not string.find(var_147_6.name, "split") then
						var_147_6.gameObject:SetActive(true)
					else
						var_147_6.gameObject:SetActive(false)
					end
				end
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_144_1.time_ - 0) / var_147_7)
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_147_8 = 0
			local var_147_9 = 0.875

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:GetWordFromCfg(418071036)
				local var_147_11 = arg_144_1:FormatText(var_147_10.content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 35 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 35)

				if (35 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 35)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb") / 1000

					if var_147_14 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_8
					end

					if var_147_10.prefab_name ~= "" and arg_144_1.actors_[var_147_10.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_10.prefab_name].transform, "story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")

						arg_144_1:RecordAudio("418071036", var_147_15)
						arg_144_1:RecordAudio("418071036", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071036", "story_v_side_old_418071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_16 and arg_144_1.time_ < var_147_8 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play418071037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 418071037
		arg_148_1.duration_ = 10.4

		local var_148_0 = {
			ja = 10.4,
			CriLanguages = 8.233,
			zh = 8.233
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play418071038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1073"]) and arg_148_1.var_.actorSpriteComps1073 == nil then
				arg_148_1.var_.actorSpriteComps1073 = arg_148_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1073"]) then
				if arg_148_1.var_.actorSpriteComps1073 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1073"]) and arg_148_1.var_.actorSpriteComps1073 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps1073 = nil
			end

			local var_151_2 = arg_148_1.actors_["10135"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps10135 == nil then
				arg_148_1.var_.actorSpriteComps10135 = var_151_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_3 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.actorSpriteComps10135 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								iter_151_5.color = Color.New(Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_3), Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_3), (Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_3)))
							else
								local var_151_4 = Mathf.Lerp(iter_151_5.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_3)

								iter_151_5.color = Color.New(var_151_4, var_151_4, var_151_4)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.actorSpriteComps10135 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_151_7 then
						iter_151_7.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps10135 = nil
			end

			local var_151_5 = 0
			local var_151_6 = 1.025

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:GetWordFromCfg(418071037)
				local var_151_8 = arg_148_1:FormatText(var_151_7.content)

				arg_148_1.text_.text = var_151_8

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 41 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 41)

				if (41 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 41)) > 0 and var_151_6 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_8
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb") ~= 0 then
					local var_151_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb") / 1000

					if var_151_11 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_5
					end

					if var_151_7.prefab_name ~= "" and arg_148_1.actors_[var_151_7.prefab_name] ~= nil then
						local var_151_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_7.prefab_name].transform, "story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")

						arg_148_1:RecordAudio("418071037", var_151_12)
						arg_148_1:RecordAudio("418071037", var_151_12)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071037", "story_v_side_old_418071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_13 and arg_148_1.time_ < var_151_5 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play418071038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 418071038
		arg_152_1.duration_ = 1.97

		local var_152_0 = {
			ja = 1.5,
			CriLanguages = 1.966,
			zh = 1.966
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play418071039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["10135"]) and arg_152_1.var_.actorSpriteComps10135 == nil then
				arg_152_1.var_.actorSpriteComps10135 = arg_152_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["10135"]) then
				if arg_152_1.var_.actorSpriteComps10135 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 1, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["10135"]) and arg_152_1.var_.actorSpriteComps10135 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_152_1.var_.actorSpriteComps10135 = nil
			end

			local var_155_2 = arg_152_1.actors_["1073"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps1073 == nil then
				arg_152_1.var_.actorSpriteComps1073 = var_155_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_3 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.actorSpriteComps1073 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_155_5 then
							if arg_152_1.isInRecall_ then
								iter_155_5.color = Color.New(Mathf.Lerp(iter_155_5.color.r, arg_152_1.hightColor2.r, (arg_152_1.time_ - 0) / var_155_3), Mathf.Lerp(iter_155_5.color.g, arg_152_1.hightColor2.g, (arg_152_1.time_ - 0) / var_155_3), (Mathf.Lerp(iter_155_5.color.b, arg_152_1.hightColor2.b, (arg_152_1.time_ - 0) / var_155_3)))
							else
								local var_155_4 = Mathf.Lerp(iter_155_5.color.r, 0.5, (arg_152_1.time_ - 0) / var_155_3)

								iter_155_5.color = Color.New(var_155_4, var_155_4, var_155_4)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.actorSpriteComps1073 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_155_7 then
						iter_155_7.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps1073 = nil
			end

			local var_155_5 = arg_152_1.actors_["10135"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10135 = var_155_5.localPosition
				var_155_5.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10135", 4)

				for iter_155_8 = 0, var_155_5.childCount - 1 do
					local var_155_6 = var_155_5:GetChild(iter_155_8)

					if var_155_6.name == "split_5" or not string.find(var_155_6.name, "split") then
						var_155_6.gameObject:SetActive(true)
					else
						var_155_6.gameObject:SetActive(false)
					end
				end
			end

			local var_155_7 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				var_155_5.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_152_1.time_ - 0) / var_155_7)
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				var_155_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_155_8 = 0
			local var_155_9 = 0.05

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_10 = arg_152_1:GetWordFromCfg(418071038)
				local var_155_11 = arg_152_1:FormatText(var_155_10.content)

				arg_152_1.text_.text = var_155_11

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 2 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 2)

				if (2 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 2)) > 0 and var_155_9 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_11
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb") / 1000

					if var_155_14 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_8
					end

					if var_155_10.prefab_name ~= "" and arg_152_1.actors_[var_155_10.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_10.prefab_name].transform, "story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")

						arg_152_1:RecordAudio("418071038", var_155_15)
						arg_152_1:RecordAudio("418071038", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071038", "story_v_side_old_418071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_16 and arg_152_1.time_ < var_155_8 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play418071039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 418071039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play418071040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["10135"]) and arg_156_1.var_.actorSpriteComps10135 == nil then
				arg_156_1.var_.actorSpriteComps10135 = arg_156_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["10135"]) then
				if arg_156_1.var_.actorSpriteComps10135 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["10135"]) and arg_156_1.var_.actorSpriteComps10135 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps10135 = nil
			end

			local var_159_2 = arg_156_1.actors_["1073"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1073 = var_159_2.localPosition
				var_159_2.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1073", 7)

				for iter_159_4 = 0, var_159_2.childCount - 1 do
					local var_159_3 = var_159_2:GetChild(iter_159_4)

					if var_159_3.name == "" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_2.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_156_1.time_ - 0) / var_159_4)
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_5 = arg_156_1.actors_["10135"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10135 = var_159_5.localPosition
				var_159_5.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10135", 7)

				for iter_159_5 = 0, var_159_5.childCount - 1 do
					local var_159_6 = var_159_5:GetChild(iter_159_5)

					if var_159_6.name == "" or not string.find(var_159_6.name, "split") then
						var_159_6.gameObject:SetActive(true)
					else
						var_159_6.gameObject:SetActive(false)
					end
				end
			end

			local var_159_7 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				var_159_5.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_156_1.time_ - 0) / var_159_7)
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				var_159_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_159_8 = 0
			local var_159_9 = 1.375

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_10 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(418071039).content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_12 = 55 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_10) / 55)

				if (55 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_10) / 55)) > 0 and var_159_9 < var_159_12 then
					arg_156_1.talkMaxDuration = var_159_12

					if var_159_12 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_13 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_13 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_13

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_13 and arg_156_1.time_ < var_159_8 + var_159_13 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play418071040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 418071040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play418071041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.975

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(418071040).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 39 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 39)

				if (39 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 39)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play418071041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 418071041
		arg_164_1.duration_ = 6.67

		local var_164_0 = {
			ja = 6.033,
			CriLanguages = 6.666,
			zh = 6.666
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play418071042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10135"]) and arg_164_1.var_.actorSpriteComps10135 == nil then
				arg_164_1.var_.actorSpriteComps10135 = arg_164_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10135"]) then
				if arg_164_1.var_.actorSpriteComps10135 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								iter_167_1.color = Color.New(Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_0), Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_0), (Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_0)))
							else
								local var_167_1 = Mathf.Lerp(iter_167_1.color.r, 1, (arg_164_1.time_ - 0) / var_167_0)

								iter_167_1.color = Color.New(var_167_1, var_167_1, var_167_1)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10135"]) and arg_164_1.var_.actorSpriteComps10135 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_167_3 then
						iter_167_3.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps10135 = nil
			end

			local var_167_2 = arg_164_1.actors_["10135"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10135 = var_167_2.localPosition
				var_167_2.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10135", 4)

				for iter_167_4 = 0, var_167_2.childCount - 1 do
					local var_167_3 = var_167_2:GetChild(iter_167_4)

					if var_167_3.name == "" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				var_167_2.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_164_1.time_ - 0) / var_167_4)
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				var_167_2.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_167_5 = 0
			local var_167_6 = 0.85

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(418071041)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 33 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 33)

				if (33 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 33)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")

						arg_164_1:RecordAudio("418071041", var_167_12)
						arg_164_1:RecordAudio("418071041", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071041", "story_v_side_old_418071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play418071042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 418071042
		arg_168_1.duration_ = 3.73

		local var_168_0 = {
			ja = 2.9,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play418071043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1073"]) and arg_168_1.var_.actorSpriteComps1073 == nil then
				arg_168_1.var_.actorSpriteComps1073 = arg_168_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1073"]) then
				if arg_168_1.var_.actorSpriteComps1073 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								iter_171_1.color = Color.New(Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_0), Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_0), (Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_0)))
							else
								local var_171_1 = Mathf.Lerp(iter_171_1.color.r, 1, (arg_168_1.time_ - 0) / var_171_0)

								iter_171_1.color = Color.New(var_171_1, var_171_1, var_171_1)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1073"]) and arg_168_1.var_.actorSpriteComps1073 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_171_3 then
						iter_171_3.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps1073 = nil
			end

			local var_171_2 = arg_168_1.actors_["10135"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10135 == nil then
				arg_168_1.var_.actorSpriteComps10135 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps10135 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_171_5 then
							if arg_168_1.isInRecall_ then
								iter_171_5.color = Color.New(Mathf.Lerp(iter_171_5.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_5.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_5.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_5.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_5.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10135 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_171_7 then
						iter_171_7.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps10135 = nil
			end

			local var_171_5 = arg_168_1.actors_["1073"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1073 = var_171_5.localPosition
				var_171_5.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1073", 2)

				for iter_171_8 = 0, var_171_5.childCount - 1 do
					local var_171_6 = var_171_5:GetChild(iter_171_8)

					if var_171_6.name == "" or not string.find(var_171_6.name, "split") then
						var_171_6.gameObject:SetActive(true)
					else
						var_171_6.gameObject:SetActive(false)
					end
				end
			end

			local var_171_7 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				var_171_5.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_168_1.time_ - 0) / var_171_7)
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				var_171_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_171_8 = 0
			local var_171_9 = 0.425

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_10 = arg_168_1:GetWordFromCfg(418071042)
				local var_171_11 = arg_168_1:FormatText(var_171_10.content)

				arg_168_1.text_.text = var_171_11

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 17 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 17)

				if (17 <= 0 and var_171_9 or var_171_9 * (utf8.len(var_171_11) / 17)) > 0 and var_171_9 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_11
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb") / 1000

					if var_171_14 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_8
					end

					if var_171_10.prefab_name ~= "" and arg_168_1.actors_[var_171_10.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_10.prefab_name].transform, "story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")

						arg_168_1:RecordAudio("418071042", var_171_15)
						arg_168_1:RecordAudio("418071042", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071042", "story_v_side_old_418071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_16 and arg_168_1.time_ < var_171_8 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play418071043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 418071043
		arg_172_1.duration_ = 11.8

		local var_172_0 = {
			ja = 11.8,
			CriLanguages = 6.066,
			zh = 6.066
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play418071044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10135"]) and arg_172_1.var_.actorSpriteComps10135 == nil then
				arg_172_1.var_.actorSpriteComps10135 = arg_172_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10135"]) then
				if arg_172_1.var_.actorSpriteComps10135 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 1, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10135"]) and arg_172_1.var_.actorSpriteComps10135 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_172_1.var_.actorSpriteComps10135 = nil
			end

			local var_175_2 = arg_172_1.actors_["1073"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps1073 == nil then
				arg_172_1.var_.actorSpriteComps1073 = var_175_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_3 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.actorSpriteComps1073 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								iter_175_5.color = Color.New(Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_3), Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_3), (Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_3)))
							else
								local var_175_4 = Mathf.Lerp(iter_175_5.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_3)

								iter_175_5.color = Color.New(var_175_4, var_175_4, var_175_4)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps1073 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_175_7 then
						iter_175_7.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps1073 = nil
			end

			local var_175_5 = 0
			local var_175_6 = 0.625

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(418071043)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 25 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 25)

				if (25 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 25)) > 0 and var_175_6 < var_175_10 then
					arg_172_1.talkMaxDuration = var_175_10

					if var_175_10 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb") ~= 0 then
					local var_175_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb") / 1000

					if var_175_11 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_5
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")

						arg_172_1:RecordAudio("418071043", var_175_12)
						arg_172_1:RecordAudio("418071043", var_175_12)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071043", "story_v_side_old_418071.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_13 and arg_172_1.time_ < var_175_5 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play418071044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 418071044
		arg_176_1.duration_ = 6.13

		local var_176_0 = {
			ja = 5.4,
			CriLanguages = 6.133,
			zh = 6.133
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play418071045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1073"]) and arg_176_1.var_.actorSpriteComps1073 == nil then
				arg_176_1.var_.actorSpriteComps1073 = arg_176_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1073"]) then
				if arg_176_1.var_.actorSpriteComps1073 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								iter_179_1.color = Color.New(Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_0), Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_0), (Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_0)))
							else
								local var_179_1 = Mathf.Lerp(iter_179_1.color.r, 1, (arg_176_1.time_ - 0) / var_179_0)

								iter_179_1.color = Color.New(var_179_1, var_179_1, var_179_1)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1073"]) and arg_176_1.var_.actorSpriteComps1073 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_179_3 then
						iter_179_3.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps1073 = nil
			end

			local var_179_2 = arg_176_1.actors_["10135"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10135 == nil then
				arg_176_1.var_.actorSpriteComps10135 = var_179_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_3 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_3 and not isNil(var_179_2) then
				if arg_176_1.var_.actorSpriteComps10135 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								iter_179_5.color = Color.New(Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, (arg_176_1.time_ - 0) / var_179_3), Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, (arg_176_1.time_ - 0) / var_179_3), (Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, (arg_176_1.time_ - 0) / var_179_3)))
							else
								local var_179_4 = Mathf.Lerp(iter_179_5.color.r, 0.5, (arg_176_1.time_ - 0) / var_179_3)

								iter_179_5.color = Color.New(var_179_4, var_179_4, var_179_4)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_3 and arg_176_1.time_ < 0 + var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.actorSpriteComps10135 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_179_7 then
						iter_179_7.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps10135 = nil
			end

			local var_179_5 = arg_176_1.actors_["1073"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1073 = var_179_5.localPosition
				var_179_5.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1073", 2)

				for iter_179_8 = 0, var_179_5.childCount - 1 do
					local var_179_6 = var_179_5:GetChild(iter_179_8)

					if var_179_6.name == "split_2" or not string.find(var_179_6.name, "split") then
						var_179_6.gameObject:SetActive(true)
					else
						var_179_6.gameObject:SetActive(false)
					end
				end
			end

			local var_179_7 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				var_179_5.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_176_1.time_ - 0) / var_179_7)
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				var_179_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_179_8 = 0
			local var_179_9 = 0.525

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_10 = arg_176_1:GetWordFromCfg(418071044)
				local var_179_11 = arg_176_1:FormatText(var_179_10.content)

				arg_176_1.text_.text = var_179_11

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 21 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 21)

				if (21 <= 0 and var_179_9 or var_179_9 * (utf8.len(var_179_11) / 21)) > 0 and var_179_9 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_8
					end
				end

				arg_176_1.text_.text = var_179_11
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb") / 1000

					if var_179_14 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_8
					end

					if var_179_10.prefab_name ~= "" and arg_176_1.actors_[var_179_10.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_10.prefab_name].transform, "story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")

						arg_176_1:RecordAudio("418071044", var_179_15)
						arg_176_1:RecordAudio("418071044", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071044", "story_v_side_old_418071.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_16 and arg_176_1.time_ < var_179_8 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play418071045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 418071045
		arg_180_1.duration_ = 5.6

		local var_180_0 = {
			ja = 5.6,
			CriLanguages = 5.566,
			zh = 5.566
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play418071046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10135"]) and arg_180_1.var_.actorSpriteComps10135 == nil then
				arg_180_1.var_.actorSpriteComps10135 = arg_180_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10135"]) then
				if arg_180_1.var_.actorSpriteComps10135 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10135"]) and arg_180_1.var_.actorSpriteComps10135 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10135 = nil
			end

			local var_183_2 = arg_180_1.actors_["1073"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1073 == nil then
				arg_180_1.var_.actorSpriteComps1073 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps1073 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								iter_183_5.color = Color.New(Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_3), Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_3), (Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_3)))
							else
								local var_183_4 = Mathf.Lerp(iter_183_5.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_3)

								iter_183_5.color = Color.New(var_183_4, var_183_4, var_183_4)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps1073 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_183_7 then
						iter_183_7.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps1073 = nil
			end

			local var_183_5 = arg_180_1.actors_["10135"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10135 = var_183_5.localPosition
				var_183_5.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10135", 4)

				for iter_183_8 = 0, var_183_5.childCount - 1 do
					local var_183_6 = var_183_5:GetChild(iter_183_8)

					if var_183_6.name == "split_2" or not string.find(var_183_6.name, "split") then
						var_183_6.gameObject:SetActive(true)
					else
						var_183_6.gameObject:SetActive(false)
					end
				end
			end

			local var_183_7 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				var_183_5.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_180_1.time_ - 0) / var_183_7)
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				var_183_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_183_8 = 0
			local var_183_9 = 0.65

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_10 = arg_180_1:GetWordFromCfg(418071045)
				local var_183_11 = arg_180_1:FormatText(var_183_10.content)

				arg_180_1.text_.text = var_183_11

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 26 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 26)

				if (26 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 26)) > 0 and var_183_9 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_11
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb") / 1000

					if var_183_14 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_8
					end

					if var_183_10.prefab_name ~= "" and arg_180_1.actors_[var_183_10.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_10.prefab_name].transform, "story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")

						arg_180_1:RecordAudio("418071045", var_183_15)
						arg_180_1:RecordAudio("418071045", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071045", "story_v_side_old_418071.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_16 and arg_180_1.time_ < var_183_8 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play418071046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 418071046
		arg_184_1.duration_ = 3.9

		local var_184_0 = {
			ja = 3.633,
			CriLanguages = 3.9,
			zh = 3.9
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play418071047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1073"]) and arg_184_1.var_.actorSpriteComps1073 == nil then
				arg_184_1.var_.actorSpriteComps1073 = arg_184_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1073"]) then
				if arg_184_1.var_.actorSpriteComps1073 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 1, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1073"]) and arg_184_1.var_.actorSpriteComps1073 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps1073 = nil
			end

			local var_187_2 = arg_184_1.actors_["10135"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps10135 == nil then
				arg_184_1.var_.actorSpriteComps10135 = var_187_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_3 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_3 and not isNil(var_187_2) then
				if arg_184_1.var_.actorSpriteComps10135 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								iter_187_5.color = Color.New(Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_3), Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_3), (Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_3)))
							else
								local var_187_4 = Mathf.Lerp(iter_187_5.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_3)

								iter_187_5.color = Color.New(var_187_4, var_187_4, var_187_4)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_3 and arg_184_1.time_ < 0 + var_187_3 + arg_187_0 and not isNil(var_187_2) and arg_184_1.var_.actorSpriteComps10135 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_187_7 then
						iter_187_7.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10135 = nil
			end

			local var_187_5 = arg_184_1.actors_["1073"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1073 = var_187_5.localPosition
				var_187_5.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("1073", 2)

				for iter_187_8 = 0, var_187_5.childCount - 1 do
					local var_187_6 = var_187_5:GetChild(iter_187_8)

					if var_187_6.name == "" or not string.find(var_187_6.name, "split") then
						var_187_6.gameObject:SetActive(true)
					else
						var_187_6.gameObject:SetActive(false)
					end
				end
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_5.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_184_1.time_ - 0) / var_187_7)
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_187_8 = 0
			local var_187_9 = 0.35

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_10 = arg_184_1:GetWordFromCfg(418071046)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 14 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 14)

				if (14 <= 0 and var_187_9 or var_187_9 * (utf8.len(var_187_11) / 14)) > 0 and var_187_9 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb") / 1000

					if var_187_14 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_8
					end

					if var_187_10.prefab_name ~= "" and arg_184_1.actors_[var_187_10.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_10.prefab_name].transform, "story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")

						arg_184_1:RecordAudio("418071046", var_187_15)
						arg_184_1:RecordAudio("418071046", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071046", "story_v_side_old_418071.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_16 and arg_184_1.time_ < var_187_8 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play418071047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 418071047
		arg_188_1.duration_ = 4.4

		local var_188_0 = {
			ja = 4.4,
			CriLanguages = 3.8,
			zh = 3.8
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play418071048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10135"]) and arg_188_1.var_.actorSpriteComps10135 == nil then
				arg_188_1.var_.actorSpriteComps10135 = arg_188_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10135"]) then
				if arg_188_1.var_.actorSpriteComps10135 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10135"]) and arg_188_1.var_.actorSpriteComps10135 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps10135 = nil
			end

			local var_191_2 = arg_188_1.actors_["1073"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1073 == nil then
				arg_188_1.var_.actorSpriteComps1073 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps1073 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								iter_191_5.color = Color.New(Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_5.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_5.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1073 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_191_7 then
						iter_191_7.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps1073 = nil
			end

			local var_191_5 = arg_188_1.actors_["10135"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10135 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10135", 4)

				for iter_191_8 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_8)

					if var_191_6.name == "" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10135, Vector3.New(432.72, -363.6, -305.9), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(432.72, -363.6, -305.9)
			end

			local var_191_8 = 0
			local var_191_9 = 0.425

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(418071047)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 17 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 17)

				if (17 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_11) / 17)) > 0 and var_191_9 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb") / 1000

					if var_191_14 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_8
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")

						arg_188_1:RecordAudio("418071047", var_191_15)
						arg_188_1:RecordAudio("418071047", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071047", "story_v_side_old_418071.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_16 and arg_188_1.time_ < var_191_8 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play418071048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 418071048
		arg_192_1.duration_ = 7.53

		local var_192_0 = {
			ja = 7.533,
			CriLanguages = 7,
			zh = 7
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play418071049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1073"]) and arg_192_1.var_.actorSpriteComps1073 == nil then
				arg_192_1.var_.actorSpriteComps1073 = arg_192_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1073"]) then
				if arg_192_1.var_.actorSpriteComps1073 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 1, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1073"]) and arg_192_1.var_.actorSpriteComps1073 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps1073 = nil
			end

			local var_195_2 = arg_192_1.actors_["10135"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10135 == nil then
				arg_192_1.var_.actorSpriteComps10135 = var_195_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_3 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.actorSpriteComps10135 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								iter_195_5.color = Color.New(Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_3), Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_3), (Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_3)))
							else
								local var_195_4 = Mathf.Lerp(iter_195_5.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_3)

								iter_195_5.color = Color.New(var_195_4, var_195_4, var_195_4)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10135 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_195_7 then
						iter_195_7.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10135 = nil
			end

			local var_195_5 = arg_192_1.actors_["1073"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1073 = var_195_5.localPosition
				var_195_5.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1073", 2)

				for iter_195_8 = 0, var_195_5.childCount - 1 do
					local var_195_6 = var_195_5:GetChild(iter_195_8)

					if var_195_6.name == "split_4" or not string.find(var_195_6.name, "split") then
						var_195_6.gameObject:SetActive(true)
					else
						var_195_6.gameObject:SetActive(false)
					end
				end
			end

			local var_195_7 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				var_195_5.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_192_1.time_ - 0) / var_195_7)
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				var_195_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_195_8 = 0
			local var_195_9 = 0.775

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(418071048)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 31 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 31)

				if (31 <= 0 and var_195_9 or var_195_9 * (utf8.len(var_195_11) / 31)) > 0 and var_195_9 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb") ~= 0 then
					local var_195_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb") / 1000

					if var_195_14 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_8
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")

						arg_192_1:RecordAudio("418071048", var_195_15)
						arg_192_1:RecordAudio("418071048", var_195_15)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071048", "story_v_side_old_418071.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play418071049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 418071049
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			ja = 7.6,
			CriLanguages = 5.033,
			zh = 5.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play418071050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10135"]) and arg_196_1.var_.actorSpriteComps10135 == nil then
				arg_196_1.var_.actorSpriteComps10135 = arg_196_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10135"]) then
				if arg_196_1.var_.actorSpriteComps10135 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 1, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10135"]) and arg_196_1.var_.actorSpriteComps10135 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10135 = nil
			end

			local var_199_2 = arg_196_1.actors_["1073"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps1073 == nil then
				arg_196_1.var_.actorSpriteComps1073 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps1073 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								iter_199_5.color = Color.New(Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_5.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_5.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps1073 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_199_7 then
						iter_199_7.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps1073 = nil
			end

			local var_199_5 = 0
			local var_199_6 = 0.65

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:GetWordFromCfg(418071049)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 26 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 26)

				if (26 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 26)) > 0 and var_199_6 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb") ~= 0 then
					local var_199_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb") / 1000

					if var_199_11 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_5
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")

						arg_196_1:RecordAudio("418071049", var_199_12)
						arg_196_1:RecordAudio("418071049", var_199_12)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071049", "story_v_side_old_418071.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_13 and arg_196_1.time_ < var_199_5 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play418071050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 418071050
		arg_200_1.duration_ = 8.87

		local var_200_0 = {
			ja = 7.1,
			CriLanguages = 8.866,
			zh = 8.866
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play418071051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1073"]) and arg_200_1.var_.actorSpriteComps1073 == nil then
				arg_200_1.var_.actorSpriteComps1073 = arg_200_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1073"]) then
				if arg_200_1.var_.actorSpriteComps1073 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1073"]) and arg_200_1.var_.actorSpriteComps1073 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps1073 = nil
			end

			local var_203_2 = arg_200_1.actors_["10135"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10135 == nil then
				arg_200_1.var_.actorSpriteComps10135 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10135 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10135 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10135 = nil
			end

			local var_203_5 = arg_200_1.actors_["1073"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1073 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1073", 2)

				for iter_203_8 = 0, var_203_5.childCount - 1 do
					local var_203_6 = var_203_5:GetChild(iter_203_8)

					if var_203_6.name == "split_5" or not string.find(var_203_6.name, "split") then
						var_203_6.gameObject:SetActive(true)
					else
						var_203_6.gameObject:SetActive(false)
					end
				end
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_200_1.time_ - 0) / var_203_7)
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_203_8 = 0
			local var_203_9 = 0.95

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:GetWordFromCfg(418071050)
				local var_203_11 = arg_200_1:FormatText(var_203_10.content)

				arg_200_1.text_.text = var_203_11

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 38 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 38)

				if (38 <= 0 and var_203_9 or var_203_9 * (utf8.len(var_203_11) / 38)) > 0 and var_203_9 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_11
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb") ~= 0 then
					local var_203_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb") / 1000

					if var_203_14 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_8
					end

					if var_203_10.prefab_name ~= "" and arg_200_1.actors_[var_203_10.prefab_name] ~= nil then
						local var_203_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_10.prefab_name].transform, "story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")

						arg_200_1:RecordAudio("418071050", var_203_15)
						arg_200_1:RecordAudio("418071050", var_203_15)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071050", "story_v_side_old_418071.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play418071051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 418071051
		arg_204_1.duration_ = 14.4

		local var_204_0 = {
			ja = 14.4,
			CriLanguages = 11,
			zh = 11
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play418071052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10135"]) and arg_204_1.var_.actorSpriteComps10135 == nil then
				arg_204_1.var_.actorSpriteComps10135 = arg_204_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10135"]) then
				if arg_204_1.var_.actorSpriteComps10135 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 1, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10135"]) and arg_204_1.var_.actorSpriteComps10135 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10135 = nil
			end

			local var_207_2 = arg_204_1.actors_["1073"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps1073 == nil then
				arg_204_1.var_.actorSpriteComps1073 = var_207_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.actorSpriteComps1073 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								iter_207_5.color = Color.New(Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_3), Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_3), (Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_3)))
							else
								local var_207_4 = Mathf.Lerp(iter_207_5.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_3)

								iter_207_5.color = Color.New(var_207_4, var_207_4, var_207_4)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.actorSpriteComps1073 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_207_7 then
						iter_207_7.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps1073 = nil
			end

			local var_207_5 = 0
			local var_207_6 = 1.35

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_7 = arg_204_1:GetWordFromCfg(418071051)
				local var_207_8 = arg_204_1:FormatText(var_207_7.content)

				arg_204_1.text_.text = var_207_8

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 54 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 54)

				if (54 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_8) / 54)) > 0 and var_207_6 < var_207_10 then
					arg_204_1.talkMaxDuration = var_207_10

					if var_207_10 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_8
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb") ~= 0 then
					local var_207_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb") / 1000

					if var_207_11 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_5
					end

					if var_207_7.prefab_name ~= "" and arg_204_1.actors_[var_207_7.prefab_name] ~= nil then
						local var_207_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_7.prefab_name].transform, "story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")

						arg_204_1:RecordAudio("418071051", var_207_12)
						arg_204_1:RecordAudio("418071051", var_207_12)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071051", "story_v_side_old_418071.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_13 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_13 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_13

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_13 and arg_204_1.time_ < var_207_5 + var_207_13 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play418071052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 418071052
		arg_208_1.duration_ = 2.07

		local var_208_0 = {
			ja = 1.866,
			CriLanguages = 2.066,
			zh = 2.066
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play418071053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1073"]) and arg_208_1.var_.actorSpriteComps1073 == nil then
				arg_208_1.var_.actorSpriteComps1073 = arg_208_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1073"]) then
				if arg_208_1.var_.actorSpriteComps1073 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								iter_211_1.color = Color.New(Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_0), Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_0), (Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_0)))
							else
								local var_211_1 = Mathf.Lerp(iter_211_1.color.r, 1, (arg_208_1.time_ - 0) / var_211_0)

								iter_211_1.color = Color.New(var_211_1, var_211_1, var_211_1)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1073"]) and arg_208_1.var_.actorSpriteComps1073 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_211_3 then
						iter_211_3.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps1073 = nil
			end

			local var_211_2 = arg_208_1.actors_["10135"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10135 == nil then
				arg_208_1.var_.actorSpriteComps10135 = var_211_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_3 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_3 and not isNil(var_211_2) then
				if arg_208_1.var_.actorSpriteComps10135 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								iter_211_5.color = Color.New(Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor2.r, (arg_208_1.time_ - 0) / var_211_3), Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor2.g, (arg_208_1.time_ - 0) / var_211_3), (Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor2.b, (arg_208_1.time_ - 0) / var_211_3)))
							else
								local var_211_4 = Mathf.Lerp(iter_211_5.color.r, 0.5, (arg_208_1.time_ - 0) / var_211_3)

								iter_211_5.color = Color.New(var_211_4, var_211_4, var_211_4)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_3 and arg_208_1.time_ < 0 + var_211_3 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.actorSpriteComps10135 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_211_7 then
						iter_211_7.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_208_1.var_.actorSpriteComps10135 = nil
			end

			local var_211_5 = 0
			local var_211_6 = 0.075

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_7 = arg_208_1:GetWordFromCfg(418071052)
				local var_211_8 = arg_208_1:FormatText(var_211_7.content)

				arg_208_1.text_.text = var_211_8

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 3 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 3)

				if (3 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 3)) > 0 and var_211_6 < var_211_10 then
					arg_208_1.talkMaxDuration = var_211_10

					if var_211_10 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_5
					end
				end

				arg_208_1.text_.text = var_211_8
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb") ~= 0 then
					local var_211_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb") / 1000

					if var_211_11 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_5
					end

					if var_211_7.prefab_name ~= "" and arg_208_1.actors_[var_211_7.prefab_name] ~= nil then
						local var_211_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_7.prefab_name].transform, "story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")

						arg_208_1:RecordAudio("418071052", var_211_12)
						arg_208_1:RecordAudio("418071052", var_211_12)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071052", "story_v_side_old_418071.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_6, arg_208_1.talkMaxDuration)

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_5) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_5 + var_211_13 and arg_208_1.time_ < var_211_5 + var_211_13 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play418071053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 418071053
		arg_212_1.duration_ = 7.9

		local var_212_0 = {
			ja = 6.933,
			CriLanguages = 7.9,
			zh = 7.9
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play418071054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10135"]) and arg_212_1.var_.actorSpriteComps10135 == nil then
				arg_212_1.var_.actorSpriteComps10135 = arg_212_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["10135"]) then
				if arg_212_1.var_.actorSpriteComps10135 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 1, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["10135"]) and arg_212_1.var_.actorSpriteComps10135 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps10135 = nil
			end

			local var_215_2 = arg_212_1.actors_["1073"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps1073 == nil then
				arg_212_1.var_.actorSpriteComps1073 = var_215_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_3 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.actorSpriteComps1073 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								iter_215_5.color = Color.New(Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor2.r, (arg_212_1.time_ - 0) / var_215_3), Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor2.g, (arg_212_1.time_ - 0) / var_215_3), (Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor2.b, (arg_212_1.time_ - 0) / var_215_3)))
							else
								local var_215_4 = Mathf.Lerp(iter_215_5.color.r, 0.5, (arg_212_1.time_ - 0) / var_215_3)

								iter_215_5.color = Color.New(var_215_4, var_215_4, var_215_4)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.actorSpriteComps1073 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_215_7 then
						iter_215_7.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps1073 = nil
			end

			local var_215_5 = 0
			local var_215_6 = 0.925

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(418071053)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 37 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 37)

				if (37 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 37)) > 0 and var_215_6 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_5
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb") ~= 0 then
					local var_215_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb") / 1000

					if var_215_11 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_5
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")

						arg_212_1:RecordAudio("418071053", var_215_12)
						arg_212_1:RecordAudio("418071053", var_215_12)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071053", "story_v_side_old_418071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_13 = math.max(var_215_6, arg_212_1.talkMaxDuration)

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_13 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_5) / var_215_13

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_5 + var_215_13 and arg_212_1.time_ < var_215_5 + var_215_13 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play418071054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 418071054
		arg_216_1.duration_ = 2.8

		local var_216_0 = {
			ja = 2.8,
			CriLanguages = 2.333,
			zh = 2.333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play418071055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1073"]) and arg_216_1.var_.actorSpriteComps1073 == nil then
				arg_216_1.var_.actorSpriteComps1073 = arg_216_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1073"]) then
				if arg_216_1.var_.actorSpriteComps1073 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 1, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1073"]) and arg_216_1.var_.actorSpriteComps1073 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps1073 = nil
			end

			local var_219_2 = arg_216_1.actors_["10135"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10135 == nil then
				arg_216_1.var_.actorSpriteComps10135 = var_219_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_3 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.actorSpriteComps10135 then
					for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_219_5 then
							if arg_216_1.isInRecall_ then
								iter_219_5.color = Color.New(Mathf.Lerp(iter_219_5.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_3), Mathf.Lerp(iter_219_5.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_3), (Mathf.Lerp(iter_219_5.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_3)))
							else
								local var_219_4 = Mathf.Lerp(iter_219_5.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_3)

								iter_219_5.color = Color.New(var_219_4, var_219_4, var_219_4)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.actorSpriteComps10135 then
				for iter_219_6, iter_219_7 in pairs(arg_216_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_219_7 then
						iter_219_7.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps10135 = nil
			end

			local var_219_5 = arg_216_1.actors_["1073"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1073 = var_219_5.localPosition
				var_219_5.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1073", 2)

				for iter_219_8 = 0, var_219_5.childCount - 1 do
					local var_219_6 = var_219_5:GetChild(iter_219_8)

					if var_219_6.name == "" or not string.find(var_219_6.name, "split") then
						var_219_6.gameObject:SetActive(true)
					else
						var_219_6.gameObject:SetActive(false)
					end
				end
			end

			local var_219_7 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				var_219_5.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1073, Vector3.New(-405.76, -414.5, -207.2), (arg_216_1.time_ - 0) / var_219_7)
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				var_219_5.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_219_8 = 0
			local var_219_9 = 0.15

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(418071054)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 6 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 6)

				if (6 <= 0 and var_219_9 or var_219_9 * (utf8.len(var_219_11) / 6)) > 0 and var_219_9 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb") / 1000

					if var_219_14 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_8
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")

						arg_216_1:RecordAudio("418071054", var_219_15)
						arg_216_1:RecordAudio("418071054", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071054", "story_v_side_old_418071.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play418071055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 418071055
		arg_220_1.duration_ = 7.8

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play418071056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 1.36666666666667 < arg_220_1.time_ and arg_220_1.time_ <= 1.36666666666667 + arg_223_0 and not isNil(arg_220_1.actors_["1073"]) and arg_220_1.var_.actorSpriteComps1073 == nil then
				arg_220_1.var_.actorSpriteComps1073 = arg_220_1.actors_["1073"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 1.36666666666667 <= arg_220_1.time_ and arg_220_1.time_ < 1.36666666666667 + var_223_0 and not isNil(arg_220_1.actors_["1073"]) then
				if arg_220_1.var_.actorSpriteComps1073 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 1.36666666666667) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 1.36666666666667) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 1.36666666666667) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 0.5, (arg_220_1.time_ - 1.36666666666667) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 1.36666666666667 + var_223_0 and arg_220_1.time_ < 1.36666666666667 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1073"]) and arg_220_1.var_.actorSpriteComps1073 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps1073 = nil
			end

			local var_223_2 = arg_220_1.actors_["1073"].transform

			if 1.36666666666667 < arg_220_1.time_ and arg_220_1.time_ <= 1.36666666666667 + arg_223_0 then
				arg_220_1.var_.moveOldPos1073 = var_223_2.localPosition
				var_223_2.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1073", 7)

				for iter_223_4 = 0, var_223_2.childCount - 1 do
					local var_223_3 = var_223_2:GetChild(iter_223_4)

					if var_223_3.name == "" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if 1.36666666666667 <= arg_220_1.time_ and arg_220_1.time_ < 1.36666666666667 + var_223_4 then
				var_223_2.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_220_1.time_ - 1.36666666666667) / var_223_4)
			end

			if arg_220_1.time_ >= 1.36666666666667 + var_223_4 and arg_220_1.time_ < 1.36666666666667 + var_223_4 + arg_223_0 then
				var_223_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_5 = arg_220_1.actors_["10135"].transform

			if 1.36666666666667 < arg_220_1.time_ and arg_220_1.time_ <= 1.36666666666667 + arg_223_0 then
				arg_220_1.var_.moveOldPos10135 = var_223_5.localPosition
				var_223_5.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10135", 7)

				for iter_223_5 = 0, var_223_5.childCount - 1 do
					local var_223_6 = var_223_5:GetChild(iter_223_5)

					if var_223_6.name == "" or not string.find(var_223_6.name, "split") then
						var_223_6.gameObject:SetActive(true)
					else
						var_223_6.gameObject:SetActive(false)
					end
				end
			end

			local var_223_7 = 0.001

			if 1.36666666666667 <= arg_220_1.time_ and arg_220_1.time_ < 1.36666666666667 + var_223_7 then
				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_220_1.time_ - 1.36666666666667) / var_223_7)
			end

			if arg_220_1.time_ >= 1.36666666666667 + var_223_7 and arg_220_1.time_ < 1.36666666666667 + var_223_7 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.40066666666667 < arg_220_1.time_ and arg_220_1.time_ <= 1.40066666666667 + arg_223_0 then
				local var_223_8 = arg_220_1.bgs_.ST40

				arg_220_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_223_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_223_9 = var_223_8:GetComponent("SpriteRenderer")

				if var_223_9 and var_223_9.sprite then
					local var_223_10 = 2 * (var_223_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_223_8.transform.localScale = Vector3.New(var_223_10 / var_223_9.sprite.bounds.size.y < var_223_10 * manager.ui.mainCameraCom_.aspect / var_223_9.sprite.bounds.size.x and var_223_10 * manager.ui.mainCameraCom_.aspect / var_223_9.sprite.bounds.size.x or var_223_10 / var_223_9.sprite.bounds.size.y, var_223_10 / var_223_9.sprite.bounds.size.y < var_223_10 * manager.ui.mainCameraCom_.aspect / var_223_9.sprite.bounds.size.x and var_223_10 * manager.ui.mainCameraCom_.aspect / var_223_9.sprite.bounds.size.x or var_223_10 / var_223_9.sprite.bounds.size.y, 0)
				end

				for iter_223_6, iter_223_7 in pairs(arg_220_1.bgs_) do
					if iter_223_6 ~= "ST40" then
						iter_223_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_223_11 = 0

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_12 = 1.4

			if var_223_11 <= arg_220_1.time_ and arg_220_1.time_ < var_223_11 + var_223_12 then
				local var_223_13 = Color.New(0, 0, 0)

				var_223_13.a = Mathf.Lerp(0, 1, (arg_220_1.time_ - var_223_11) / var_223_12)
				arg_220_1.mask_.color = var_223_13
			end

			if arg_220_1.time_ >= var_223_11 + var_223_12 and arg_220_1.time_ < var_223_11 + var_223_12 + arg_223_0 then
				local var_223_14 = Color.New(0, 0, 0)

				var_223_14.a = 1
				arg_220_1.mask_.color = var_223_14
			end

			local var_223_15 = 1.4

			if 1.4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_16 = 1.4

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_16 then
				local var_223_17 = Color.New(0, 0, 0)

				var_223_17.a = Mathf.Lerp(1, 0, (arg_220_1.time_ - var_223_15) / var_223_16)
				arg_220_1.mask_.color = var_223_17
			end

			if arg_220_1.time_ >= var_223_15 + var_223_16 and arg_220_1.time_ < var_223_15 + var_223_16 + arg_223_0 then
				local var_223_18 = Color.New(0, 0, 0)

				arg_220_1.mask_.enabled = false
				var_223_18.a = 0
				arg_220_1.mask_.color = var_223_18
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_19 = 2.8
			local var_223_20 = 0.15

			if 2.8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_19 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_21 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_21:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_22 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(418071055).content)

				arg_220_1.text_.text = var_223_22

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_24 = 6 <= 0 and var_223_20 or var_223_20 * (utf8.len(var_223_22) / 6)

				if (6 <= 0 and var_223_20 or var_223_20 * (utf8.len(var_223_22) / 6)) > 0 and var_223_20 < var_223_24 then
					arg_220_1.talkMaxDuration = var_223_24
					var_223_19 = var_223_19 + 0.3

					if var_223_24 + var_223_19 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_24 + var_223_19
					end
				end

				arg_220_1.text_.text = var_223_22
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_25 = var_223_19 + 0.3
			local var_223_26 = math.max(var_223_20, arg_220_1.talkMaxDuration)

			if var_223_19 + 0.3 <= arg_220_1.time_ and arg_220_1.time_ < var_223_25 + var_223_26 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_25) / var_223_26

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_25 + var_223_26 and arg_220_1.time_ < var_223_25 + var_223_26 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play418071056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 418071056
		arg_226_1.duration_ = 2.8

		local var_226_0 = {
			ja = 2.8,
			CriLanguages = 1.866,
			zh = 1.866
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
				arg_226_0:Play418071057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if arg_226_1.actors_["107301"] == nil then
				local var_229_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "107301")

				if not isNil(var_229_0) then
					local var_229_1 = Object.Instantiate(var_229_0, arg_226_1.canvasGo_.transform)

					var_229_1.transform:SetSiblingIndex(1)

					var_229_1.name = "107301"
					var_229_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_226_1.actors_["107301"] = var_229_1

					if arg_226_1.isInRecall_ then
						for iter_229_0, iter_229_1 in ipairs((var_229_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_229_1.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_229_2 = arg_226_1.actors_["107301"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps107301 == nil then
				arg_226_1.var_.actorSpriteComps107301 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps107301 then
					for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_229_3 then
							if arg_226_1.isInRecall_ then
								iter_229_3.color = Color.New(Mathf.Lerp(iter_229_3.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_3.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_3.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_3.color.r, 1, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_3.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps107301 then
				for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_229_5 then
						iter_229_5.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps107301 = nil
			end

			local var_229_5 = arg_226_1.actors_["1073"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1073 = var_229_5.localPosition
				var_229_5.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1073", 7)

				for iter_229_6 = 0, var_229_5.childCount - 1 do
					local var_229_6 = var_229_5:GetChild(iter_229_6)

					if var_229_6.name == "" or not string.find(var_229_6.name, "split") then
						var_229_6.gameObject:SetActive(true)
					else
						var_229_6.gameObject:SetActive(false)
					end
				end
			end

			local var_229_7 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				var_229_5.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_226_1.time_ - 0) / var_229_7)
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				var_229_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_8 = arg_226_1.actors_["10135"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10135 = var_229_8.localPosition
				var_229_8.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10135", 7)

				for iter_229_7 = 0, var_229_8.childCount - 1 do
					local var_229_9 = var_229_8:GetChild(iter_229_7)

					if var_229_9.name == "" or not string.find(var_229_9.name, "split") then
						var_229_9.gameObject:SetActive(true)
					else
						var_229_9.gameObject:SetActive(false)
					end
				end
			end

			local var_229_10 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_10 then
				var_229_8.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_226_1.time_ - 0) / var_229_10)
			end

			if arg_226_1.time_ >= 0 + var_229_10 and arg_226_1.time_ < 0 + var_229_10 + arg_229_0 then
				var_229_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_11 = arg_226_1.actors_["107301"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos107301 = var_229_11.localPosition
				var_229_11.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("107301", 3)

				for iter_229_8 = 0, var_229_11.childCount - 1 do
					local var_229_12 = var_229_11:GetChild(iter_229_8)

					if var_229_12.name == "split_4" or not string.find(var_229_12.name, "split") then
						var_229_12.gameObject:SetActive(true)
					else
						var_229_12.gameObject:SetActive(false)
					end
				end
			end

			local var_229_13 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_13 then
				var_229_11.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos107301, Vector3.New(-14.4, -367.6, -201.9), (arg_226_1.time_ - 0) / var_229_13)
			end

			if arg_226_1.time_ >= 0 + var_229_13 and arg_226_1.time_ < 0 + var_229_13 + arg_229_0 then
				var_229_11.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_229_14 = 0
			local var_229_15 = 0.2

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_16 = arg_226_1:GetWordFromCfg(418071056)
				local var_229_17 = arg_226_1:FormatText(var_229_16.content)

				arg_226_1.text_.text = var_229_17

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_19 = 8 <= 0 and var_229_15 or var_229_15 * (utf8.len(var_229_17) / 8)

				if (8 <= 0 and var_229_15 or var_229_15 * (utf8.len(var_229_17) / 8)) > 0 and var_229_15 < var_229_19 then
					arg_226_1.talkMaxDuration = var_229_19

					if var_229_19 + var_229_14 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_19 + var_229_14
					end
				end

				arg_226_1.text_.text = var_229_17
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb") ~= 0 then
					local var_229_20 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb") / 1000

					if var_229_20 + var_229_14 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_20 + var_229_14
					end

					if var_229_16.prefab_name ~= "" and arg_226_1.actors_[var_229_16.prefab_name] ~= nil then
						local var_229_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_16.prefab_name].transform, "story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")

						arg_226_1:RecordAudio("418071056", var_229_21)
						arg_226_1:RecordAudio("418071056", var_229_21)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071056", "story_v_side_old_418071.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_22 = math.max(var_229_15, arg_226_1.talkMaxDuration)

			if var_229_14 <= arg_226_1.time_ and arg_226_1.time_ < var_229_14 + var_229_22 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_14) / var_229_22

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_14 + var_229_22 and arg_226_1.time_ < var_229_14 + var_229_22 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "107301",
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
	Play418071057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 418071057
		arg_230_1.duration_ = 4.87

		local var_230_0 = {
			ja = 4.6,
			CriLanguages = 4.866,
			zh = 4.866
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
				arg_230_0:Play418071058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10135"]) and arg_230_1.var_.actorSpriteComps10135 == nil then
				arg_230_1.var_.actorSpriteComps10135 = arg_230_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10135"]) then
				if arg_230_1.var_.actorSpriteComps10135 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10135"]) and arg_230_1.var_.actorSpriteComps10135 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps10135 = nil
			end

			local var_233_2 = arg_230_1.actors_["107301"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps107301 == nil then
				arg_230_1.var_.actorSpriteComps107301 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps107301 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps107301:ToTable()) do
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

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps107301 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps107301 = nil
			end

			local var_233_5 = arg_230_1.actors_["107301"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos107301 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("107301", 4)

				for iter_233_8 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_8)

					if var_233_6.name == "split_4" or not string.find(var_233_6.name, "split") then
						var_233_6.gameObject:SetActive(true)
					else
						var_233_6.gameObject:SetActive(false)
					end
				end
			end

			local var_233_7 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos107301, Vector3.New(500, -367.6, -206), (arg_230_1.time_ - 0) / var_233_7)
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(500, -367.6, -206)
			end

			local var_233_8 = arg_230_1.actors_["10135"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10135 = var_233_8.localPosition
				var_233_8.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10135", 2)

				for iter_233_9 = 0, var_233_8.childCount - 1 do
					local var_233_9 = var_233_8:GetChild(iter_233_9)

					if var_233_9.name == "split_2" or not string.find(var_233_9.name, "split") then
						var_233_9.gameObject:SetActive(true)
					else
						var_233_9.gameObject:SetActive(false)
					end
				end
			end

			local var_233_10 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_10 then
				var_233_8.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10135, Vector3.New(-448.9, -363.6, -305.9), (arg_230_1.time_ - 0) / var_233_10)
			end

			if arg_230_1.time_ >= 0 + var_233_10 and arg_230_1.time_ < 0 + var_233_10 + arg_233_0 then
				var_233_8.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_233_11 = arg_230_1.actors_["1073"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1073 = var_233_11.localPosition
				var_233_11.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1073", 7)

				for iter_233_10 = 0, var_233_11.childCount - 1 do
					local var_233_12 = var_233_11:GetChild(iter_233_10)

					if var_233_12.name == "" or not string.find(var_233_12.name, "split") then
						var_233_12.gameObject:SetActive(true)
					else
						var_233_12.gameObject:SetActive(false)
					end
				end
			end

			local var_233_13 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_13 then
				var_233_11.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1073, Vector3.New(0, -2000, 0), (arg_230_1.time_ - 0) / var_233_13)
			end

			if arg_230_1.time_ >= 0 + var_233_13 and arg_230_1.time_ < 0 + var_233_13 + arg_233_0 then
				var_233_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_233_14 = 0
			local var_233_15 = 0.5

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_16 = arg_230_1:GetWordFromCfg(418071057)
				local var_233_17 = arg_230_1:FormatText(var_233_16.content)

				arg_230_1.text_.text = var_233_17

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_19 = 20 <= 0 and var_233_15 or var_233_15 * (utf8.len(var_233_17) / 20)

				if (20 <= 0 and var_233_15 or var_233_15 * (utf8.len(var_233_17) / 20)) > 0 and var_233_15 < var_233_19 then
					arg_230_1.talkMaxDuration = var_233_19

					if var_233_19 + var_233_14 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_14
					end
				end

				arg_230_1.text_.text = var_233_17
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb") ~= 0 then
					local var_233_20 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb") / 1000

					if var_233_20 + var_233_14 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_14
					end

					if var_233_16.prefab_name ~= "" and arg_230_1.actors_[var_233_16.prefab_name] ~= nil then
						local var_233_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_16.prefab_name].transform, "story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")

						arg_230_1:RecordAudio("418071057", var_233_21)
						arg_230_1:RecordAudio("418071057", var_233_21)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071057", "story_v_side_old_418071.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_22 = math.max(var_233_15, arg_230_1.talkMaxDuration)

			if var_233_14 <= arg_230_1.time_ and arg_230_1.time_ < var_233_14 + var_233_22 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_14) / var_233_22

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_14 + var_233_22 and arg_230_1.time_ < var_233_14 + var_233_22 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
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

		arg_230_1:InitPlayNodeList()
	end,
	Play418071058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 418071058
		arg_234_1.duration_ = 9.5

		local var_234_0 = {
			ja = 9.5,
			CriLanguages = 8,
			zh = 8
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
				arg_234_0:Play418071059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10135 = arg_234_1.actors_["10135"].transform.localPosition
				arg_234_1.actors_["10135"].transform.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10135", 2)

				for iter_237_0 = 0, arg_234_1.actors_["10135"].transform.childCount - 1 do
					local var_237_0 = arg_234_1.actors_["10135"].transform:GetChild(iter_237_0)

					if var_237_0.name == "split_1" or not string.find(var_237_0.name, "split") then
						var_237_0.gameObject:SetActive(true)
					else
						var_237_0.gameObject:SetActive(false)
					end
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["10135"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10135, Vector3.New(-448.9, -363.6, -305.9), (arg_234_1.time_ - 0) / var_237_1)
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["10135"].transform.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_237_2 = 0
			local var_237_3 = 0.75

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(418071058)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 30 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 30)

				if (30 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 30)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")

						arg_234_1:RecordAudio("418071058", var_237_9)
						arg_234_1:RecordAudio("418071058", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071058", "story_v_side_old_418071.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play418071059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 418071059
		arg_238_1.duration_ = 2.27

		local var_238_0 = {
			ja = 2.066,
			CriLanguages = 2.266,
			zh = 2.266
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
				arg_238_0:Play418071060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["107301"]) and arg_238_1.var_.actorSpriteComps107301 == nil then
				arg_238_1.var_.actorSpriteComps107301 = arg_238_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["107301"]) then
				if arg_238_1.var_.actorSpriteComps107301 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps107301:ToTable()) do
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

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["107301"]) and arg_238_1.var_.actorSpriteComps107301 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps107301 = nil
			end

			local var_241_2 = arg_238_1.actors_["10135"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps10135 == nil then
				arg_238_1.var_.actorSpriteComps10135 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps10135 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps10135 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_241_7 then
						iter_241_7.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps10135 = nil
			end

			local var_241_5 = arg_238_1.actors_["107301"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos107301 = var_241_5.localPosition
				var_241_5.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("107301", 4)

				for iter_241_8 = 0, var_241_5.childCount - 1 do
					local var_241_6 = var_241_5:GetChild(iter_241_8)

					if var_241_6.name == "split_4" or not string.find(var_241_6.name, "split") then
						var_241_6.gameObject:SetActive(true)
					else
						var_241_6.gameObject:SetActive(false)
					end
				end
			end

			local var_241_7 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				var_241_5.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos107301, Vector3.New(500, -367.6, -206), (arg_238_1.time_ - 0) / var_241_7)
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				var_241_5.localPosition = Vector3.New(500, -367.6, -206)
			end

			local var_241_8 = 0
			local var_241_9 = 0.125

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_10 = arg_238_1:GetWordFromCfg(418071059)
				local var_241_11 = arg_238_1:FormatText(var_241_10.content)

				arg_238_1.text_.text = var_241_11

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 5 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 5)

				if (5 <= 0 and var_241_9 or var_241_9 * (utf8.len(var_241_11) / 5)) > 0 and var_241_9 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_11
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb") / 1000

					if var_241_14 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_8
					end

					if var_241_10.prefab_name ~= "" and arg_238_1.actors_[var_241_10.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_10.prefab_name].transform, "story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")

						arg_238_1:RecordAudio("418071059", var_241_15)
						arg_238_1:RecordAudio("418071059", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071059", "story_v_side_old_418071.awb")
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
				actorName = "107301",
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
	Play418071060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 418071060
		arg_242_1.duration_ = 9

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play418071061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.bgs_.ST1003a == nil then
				local var_245_0 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST1003a")
				var_245_0.name = "ST1003a"
				var_245_0.transform.parent = arg_242_1.stage_.transform
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_.ST1003a = var_245_0
			end

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= 2 + arg_245_0 then
				local var_245_1 = arg_242_1.bgs_.ST1003a

				arg_242_1.bgs_.ST1003a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_2 = var_245_1:GetComponent("SpriteRenderer")

				if var_245_2 and var_245_2.sprite then
					local var_245_3 = 2 * (var_245_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_1.transform.localScale = Vector3.New(var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "ST1003a" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.allBtn_.enabled = false
			end

			if arg_242_1.time_ >= var_245_4 + 0.3 and arg_242_1.time_ < var_245_4 + 0.3 + arg_245_0 then
				arg_242_1.allBtn_.enabled = true
			end

			local var_245_5 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_6 = 2

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_6 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_5) / var_245_6)
				arg_242_1.mask_.color = var_245_7
			end

			if arg_242_1.time_ >= var_245_5 + var_245_6 and arg_242_1.time_ < var_245_5 + var_245_6 + arg_245_0 then
				local var_245_8 = Color.New(0, 0, 0)

				var_245_8.a = 1
				arg_242_1.mask_.color = var_245_8
			end

			local var_245_9 = 2

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_10 = 2

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_10 then
				local var_245_11 = Color.New(0, 0, 0)

				var_245_11.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_9) / var_245_10)
				arg_242_1.mask_.color = var_245_11
			end

			if arg_242_1.time_ >= var_245_9 + var_245_10 and arg_242_1.time_ < var_245_9 + var_245_10 + arg_245_0 then
				local var_245_12 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_12.a = 0
				arg_242_1.mask_.color = var_245_12
			end

			local var_245_13 = arg_242_1.actors_["107301"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_13) and arg_242_1.var_.actorSpriteComps107301 == nil then
				arg_242_1.var_.actorSpriteComps107301 = var_245_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_14 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_14 and not isNil(var_245_13) then
				if arg_242_1.var_.actorSpriteComps107301 then
					for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_245_3 then
							if arg_242_1.isInRecall_ then
								iter_245_3.color = Color.New(Mathf.Lerp(iter_245_3.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_14), Mathf.Lerp(iter_245_3.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_14), (Mathf.Lerp(iter_245_3.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_14)))
							else
								local var_245_15 = Mathf.Lerp(iter_245_3.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_14)

								iter_245_3.color = Color.New(var_245_15, var_245_15, var_245_15)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_14 and arg_242_1.time_ < 0 + var_245_14 + arg_245_0 and not isNil(var_245_13) and arg_242_1.var_.actorSpriteComps107301 then
				for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_245_5 then
						iter_245_5.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps107301 = nil
			end

			local var_245_16 = arg_242_1.actors_["107301"].transform

			if 1.988 < arg_242_1.time_ and arg_242_1.time_ <= 1.988 + arg_245_0 then
				arg_242_1.var_.moveOldPos107301 = var_245_16.localPosition
				var_245_16.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("107301", 7)

				for iter_245_6 = 0, var_245_16.childCount - 1 do
					local var_245_17 = var_245_16:GetChild(iter_245_6)

					if var_245_17.name == "" or not string.find(var_245_17.name, "split") then
						var_245_17.gameObject:SetActive(true)
					else
						var_245_17.gameObject:SetActive(false)
					end
				end
			end

			local var_245_18 = 0.001

			if 1.988 <= arg_242_1.time_ and arg_242_1.time_ < 1.988 + var_245_18 then
				var_245_16.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos107301, Vector3.New(0, -2000, 0), (arg_242_1.time_ - 1.988) / var_245_18)
			end

			if arg_242_1.time_ >= 1.988 + var_245_18 and arg_242_1.time_ < 1.988 + var_245_18 + arg_245_0 then
				var_245_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.533333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 0.533333333333333 + arg_245_0 then
				arg_242_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_245_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_21 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_21

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_21
						arg_242_1.bgmTxt2_.text = var_245_21
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 0.533333333333333 + arg_245_0 then
				arg_242_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 1.83333333333333 < arg_242_1.time_ and arg_242_1.time_ <= 1.83333333333333 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= 4 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_245_25 = arg_242_1.actors_["10135"].transform

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= 2 + arg_245_0 then
				arg_242_1.var_.moveOldPos10135 = var_245_25.localPosition
				var_245_25.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10135", 7)

				for iter_245_7 = 0, var_245_25.childCount - 1 do
					local var_245_26 = var_245_25:GetChild(iter_245_7)

					if var_245_26.name == "split_2" or not string.find(var_245_26.name, "split") then
						var_245_26.gameObject:SetActive(true)
					else
						var_245_26.gameObject:SetActive(false)
					end
				end
			end

			local var_245_27 = 0.001

			if 2 <= arg_242_1.time_ and arg_242_1.time_ < 2 + var_245_27 then
				var_245_25.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_242_1.time_ - 2) / var_245_27)
			end

			if arg_242_1.time_ >= 2 + var_245_27 and arg_242_1.time_ < 2 + var_245_27 + arg_245_0 then
				var_245_25.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_28 = 3.999999999999
			local var_245_29 = 0.7

			if 3.999999999999 < arg_242_1.time_ and arg_242_1.time_ <= var_245_28 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_30 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_30:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_242_1.dialogCg_.alpha = arg_247_0
				end))
				var_245_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_31 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(418071060).content)

				arg_242_1.text_.text = var_245_31

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_33 = 28 <= 0 and var_245_29 or var_245_29 * (utf8.len(var_245_31) / 28)

				if (28 <= 0 and var_245_29 or var_245_29 * (utf8.len(var_245_31) / 28)) > 0 and var_245_29 < var_245_33 then
					arg_242_1.talkMaxDuration = var_245_33
					var_245_28 = var_245_28 + 0.3

					if var_245_33 + var_245_28 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_33 + var_245_28
					end
				end

				arg_242_1.text_.text = var_245_31
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_34 = var_245_28 + 0.3
			local var_245_35 = math.max(var_245_29, arg_242_1.talkMaxDuration)

			if var_245_28 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_34 + var_245_35 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_34) / var_245_35

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_34 + var_245_35 and arg_242_1.time_ < var_245_34 + var_245_35 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.988,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play418071061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 418071061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play418071062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.725

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(418071061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 29 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 29)

				if (29 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 29)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play418071062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 418071062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play418071063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.725

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(418071062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 29 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 29)

				if (29 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 29)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play418071063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 418071063
		arg_257_1.duration_ = 4.37

		local var_257_0 = {
			ja = 3.2,
			CriLanguages = 4.366,
			zh = 4.366
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
				arg_257_0:Play418071064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.325

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(418071063)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 13 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 13)

				if (13 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 13)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")

						arg_257_1:RecordAudio("418071063", var_260_6)
						arg_257_1:RecordAudio("418071063", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071063", "story_v_side_old_418071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play418071064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 418071064
		arg_261_1.duration_ = 6.67

		local var_261_0 = {
			ja = 6.666,
			CriLanguages = 6.166,
			zh = 6.166
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
				arg_261_0:Play418071065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["107301"]) and arg_261_1.var_.actorSpriteComps107301 == nil then
				arg_261_1.var_.actorSpriteComps107301 = arg_261_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["107301"]) then
				if arg_261_1.var_.actorSpriteComps107301 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps107301:ToTable()) do
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

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["107301"]) and arg_261_1.var_.actorSpriteComps107301 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps107301 = nil
			end

			local var_264_2 = arg_261_1.actors_["10135"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10135 == nil then
				arg_261_1.var_.actorSpriteComps10135 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10135 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								iter_264_5.color = Color.New(Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_5.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_5.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10135 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_264_7 then
						iter_264_7.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10135 = nil
			end

			local var_264_5 = arg_261_1.actors_["10135"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10135 = var_264_5.localPosition
				var_264_5.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10135", 7)

				for iter_264_8 = 0, var_264_5.childCount - 1 do
					local var_264_6 = var_264_5:GetChild(iter_264_8)

					if var_264_6.name == "" or not string.find(var_264_6.name, "split") then
						var_264_6.gameObject:SetActive(true)
					else
						var_264_6.gameObject:SetActive(false)
					end
				end
			end

			local var_264_7 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				var_264_5.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_261_1.time_ - 0) / var_264_7)
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				var_264_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_264_8 = arg_261_1.actors_["107301"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos107301 = var_264_8.localPosition
				var_264_8.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("107301", 3)

				for iter_264_9 = 0, var_264_8.childCount - 1 do
					local var_264_9 = var_264_8:GetChild(iter_264_9)

					if var_264_9.name == "" or not string.find(var_264_9.name, "split") then
						var_264_9.gameObject:SetActive(true)
					else
						var_264_9.gameObject:SetActive(false)
					end
				end
			end

			local var_264_10 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_10 then
				var_264_8.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos107301, Vector3.New(-14.4, -367.6, -201.9), (arg_261_1.time_ - 0) / var_264_10)
			end

			if arg_261_1.time_ >= 0 + var_264_10 and arg_261_1.time_ < 0 + var_264_10 + arg_264_0 then
				var_264_8.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_264_11 = 0
			local var_264_12 = 0.575

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_13 = arg_261_1:GetWordFromCfg(418071064)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_16 = 23 <= 0 and var_264_12 or var_264_12 * (utf8.len(var_264_14) / 23)

				if (23 <= 0 and var_264_12 or var_264_12 * (utf8.len(var_264_14) / 23)) > 0 and var_264_12 < var_264_16 then
					arg_261_1.talkMaxDuration = var_264_16

					if var_264_16 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_11
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb") ~= 0 then
					local var_264_17 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb") / 1000

					if var_264_17 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_11
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")

						arg_261_1:RecordAudio("418071064", var_264_18)
						arg_261_1:RecordAudio("418071064", var_264_18)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071064", "story_v_side_old_418071.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_19 = math.max(var_264_12, arg_261_1.talkMaxDuration)

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_19 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_11) / var_264_19

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_11 + var_264_19 and arg_261_1.time_ < var_264_11 + var_264_19 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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
				actorName = "107301",
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
	Play418071065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 418071065
		arg_265_1.duration_ = 6.8

		local var_265_0 = {
			ja = 6.8,
			CriLanguages = 5.366,
			zh = 5.366
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
				arg_265_0:Play418071066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10135"]) and arg_265_1.var_.actorSpriteComps10135 == nil then
				arg_265_1.var_.actorSpriteComps10135 = arg_265_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10135"]) then
				if arg_265_1.var_.actorSpriteComps10135 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 1, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10135"]) and arg_265_1.var_.actorSpriteComps10135 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps10135 = nil
			end

			local var_268_2 = arg_265_1.actors_["107301"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps107301 == nil then
				arg_265_1.var_.actorSpriteComps107301 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps107301 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								iter_268_5.color = Color.New(Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_5.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_5.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps107301 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_268_7 then
						iter_268_7.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps107301 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 0.475

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_7 = arg_265_1:GetWordFromCfg(418071065)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 19 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 19)

				if (19 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 19)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")

						arg_265_1:RecordAudio("418071065", var_268_12)
						arg_265_1:RecordAudio("418071065", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071065", "story_v_side_old_418071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_13 and arg_265_1.time_ < var_268_5 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play418071066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 418071066
		arg_269_1.duration_ = 8.1

		local var_269_0 = {
			ja = 8.1,
			CriLanguages = 6.3,
			zh = 6.3
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
			arg_269_1.auto_ = false
		end

		function arg_269_1.playNext_(arg_271_0)
			arg_269_1.onStoryFinished_()
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["107301"]) and arg_269_1.var_.actorSpriteComps107301 == nil then
				arg_269_1.var_.actorSpriteComps107301 = arg_269_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["107301"]) then
				if arg_269_1.var_.actorSpriteComps107301 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps107301:ToTable()) do
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

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["107301"]) and arg_269_1.var_.actorSpriteComps107301 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps107301 = nil
			end

			local var_272_2 = arg_269_1.actors_["10135"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10135 == nil then
				arg_269_1.var_.actorSpriteComps10135 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10135 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								iter_272_5.color = Color.New(Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_5.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_5.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10135 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_272_7 then
						iter_272_7.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps10135 = nil
			end

			local var_272_5 = arg_269_1.actors_["107301"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos107301 = var_272_5.localPosition
				var_272_5.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("107301", 3)

				for iter_272_8 = 0, var_272_5.childCount - 1 do
					local var_272_6 = var_272_5:GetChild(iter_272_8)

					if var_272_6.name == "split_4" or not string.find(var_272_6.name, "split") then
						var_272_6.gameObject:SetActive(true)
					else
						var_272_6.gameObject:SetActive(false)
					end
				end
			end

			local var_272_7 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos107301, Vector3.New(-14.4, -367.6, -201.9), (arg_269_1.time_ - 0) / var_272_7)
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_272_8 = 0
			local var_272_9 = 0.675

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(418071066)
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

				if manager.audio:GetVoiceLength("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb") ~= 0 then
					local var_272_14 = manager.audio:GetVoiceLength("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb") / 1000

					if var_272_14 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_8
					end

					if var_272_10.prefab_name ~= "" and arg_269_1.actors_[var_272_10.prefab_name] ~= nil then
						local var_272_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_10.prefab_name].transform, "story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")

						arg_269_1:RecordAudio("418071066", var_272_15)
						arg_269_1:RecordAudio("418071066", var_272_15)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_418071", "418071066", "story_v_side_old_418071.awb")
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
				actorName = "107301",
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
	assets = {
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/ST1003a"
	},
	voices = {
		"story_v_side_old_418071.awb"
	}
}
