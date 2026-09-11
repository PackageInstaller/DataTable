return {
	Play938021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0119 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0119")
				var_4_0.name = "ST0119"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0119 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0119

				arg_1_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0119" then
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

			local var_4_9 = "128404"

			if arg_1_1.actors_["128404"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

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

			local var_4_12 = arg_1_1.actors_["128404"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_15 = arg_1_1.actors_["128404"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 2)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_5" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2
			local var_4_24 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938021001).content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 9)

				if (9 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 9)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_23 = var_4_23 + 0.3

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_23 + 0.3
			local var_4_30 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938021002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["108301"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "108301"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["108301"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["108301"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps108301 == nil then
				arg_8_1.var_.actorSpriteComps108301 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps108301 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps108301 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps108301 = nil
			end

			local var_11_5 = arg_8_1.actors_["128404"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps128404 == nil then
				arg_8_1.var_.actorSpriteComps128404 = var_11_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.actorSpriteComps128404 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps128404 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_11_9 then
						iter_11_9.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps128404 = nil
			end

			local var_11_8 = arg_8_1.actors_["108301"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos108301 = var_11_8.localPosition
				var_11_8.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("108301", 4)

				for iter_11_10 = 0, var_11_8.childCount - 1 do
					local var_11_9 = var_11_8:GetChild(iter_11_10)

					if var_11_9.name == "split_4" or not string.find(var_11_9.name, "split") then
						var_11_9.gameObject:SetActive(true)
					else
						var_11_9.gameObject:SetActive(false)
					end
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_8_1.time_ - 0) / var_11_10)
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(460, -360, -195)
			end

			local var_11_11 = 0
			local var_11_12 = 0.625

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_13 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938021002).content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 25 <= 0 and var_11_12 or var_11_12 * (utf8.len(var_11_13) / 25)

				if (25 <= 0 and var_11_12 or var_11_12 * (utf8.len(var_11_13) / 25)) > 0 and var_11_12 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_11 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_11
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_12, arg_8_1.talkMaxDuration)

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_11) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_11 + var_11_16 and arg_8_1.time_ < var_11_11 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["108301"]) and arg_12_1.var_.actorSpriteComps108301 == nil then
				arg_12_1.var_.actorSpriteComps108301 = arg_12_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["108301"]) then
				if arg_12_1.var_.actorSpriteComps108301 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								iter_15_1.color = Color.New(Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor2.r, (arg_12_1.time_ - 0) / var_15_0), Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor2.g, (arg_12_1.time_ - 0) / var_15_0), (Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor2.b, (arg_12_1.time_ - 0) / var_15_0)))
							else
								local var_15_1 = Mathf.Lerp(iter_15_1.color.r, 0.5, (arg_12_1.time_ - 0) / var_15_0)

								iter_15_1.color = Color.New(var_15_1, var_15_1, var_15_1)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["108301"]) and arg_12_1.var_.actorSpriteComps108301 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps108301 = nil
			end

			local var_15_2 = arg_12_1.actors_["108301"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos108301 = var_15_2.localPosition
				var_15_2.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("108301", 7)

				for iter_15_4 = 0, var_15_2.childCount - 1 do
					local var_15_3 = var_15_2:GetChild(iter_15_4)

					if var_15_3.name == "" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_2.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0) / var_15_4)
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_5 = arg_12_1.actors_["128404"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos128404 = var_15_5.localPosition
				var_15_5.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("128404", 7)

				for iter_15_5 = 0, var_15_5.childCount - 1 do
					local var_15_6 = var_15_5:GetChild(iter_15_5)

					if var_15_6.name == "" or not string.find(var_15_6.name, "split") then
						var_15_6.gameObject:SetActive(true)
					else
						var_15_6.gameObject:SetActive(false)
					end
				end
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0) / var_15_7)
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_8 = "10144"

			if arg_12_1.actors_["10144"] == nil then
				local var_15_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_15_9) then
					local var_15_10 = Object.Instantiate(var_15_9, arg_12_1.canvasGo_.transform)

					var_15_10.transform:SetSiblingIndex(1)

					var_15_10.name = var_15_8
					var_15_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_[var_15_8] = var_15_10

					if arg_12_1.isInRecall_ then
						for iter_15_6, iter_15_7 in ipairs((var_15_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_15_7.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_11 = arg_12_1.actors_["10144"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10144 = var_15_11.localPosition
				var_15_11.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10144", 7)

				for iter_15_8 = 0, var_15_11.childCount - 1 do
					local var_15_12 = var_15_11:GetChild(iter_15_8)

					if var_15_12.name == "" or not string.find(var_15_12.name, "split") then
						var_15_12.gameObject:SetActive(true)
					else
						var_15_12.gameObject:SetActive(false)
					end
				end
			end

			local var_15_13 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_13 then
				var_15_11.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0) / var_15_13)
			end

			if arg_12_1.time_ >= 0 + var_15_13 and arg_12_1.time_ < 0 + var_15_13 + arg_15_0 then
				var_15_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_14 = 0
			local var_15_15 = 1.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938021003).content)

				arg_12_1.text_.text = var_15_16

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_18 = 47 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_16) / 47)

				if (47 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_16) / 47)) > 0 and var_15_15 < var_15_18 then
					arg_12_1.talkMaxDuration = var_15_18

					if var_15_18 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_14
					end
				end

				arg_12_1.text_.text = var_15_16
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_19 = math.max(var_15_15, arg_12_1.talkMaxDuration)

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_19 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_14) / var_15_19

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_14 + var_15_19 and arg_12_1.time_ < var_15_14 + var_15_19 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["10144"]) and arg_16_1.var_.actorSpriteComps10144 == nil then
				arg_16_1.var_.actorSpriteComps10144 = arg_16_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["10144"]) then
				if arg_16_1.var_.actorSpriteComps10144 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["10144"]) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_2 = arg_16_1.actors_["10144"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10144 = var_19_2.localPosition
				var_19_2.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10144", 3)

				for iter_19_4 = 0, var_19_2.childCount - 1 do
					local var_19_3 = var_19_2:GetChild(iter_19_4)

					if var_19_3.name == "split_2" or not string.find(var_19_3.name, "split") then
						var_19_3.gameObject:SetActive(true)
					else
						var_19_3.gameObject:SetActive(false)
					end
				end
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_2.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_16_1.time_ - 0) / var_19_4)
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_19_5 = 0
			local var_19_6 = 1.5

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938021004).content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 60 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 60)

				if (60 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 60)) > 0 and var_19_6 < var_19_9 then
					arg_16_1.talkMaxDuration = var_19_9

					if var_19_9 + var_19_5 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_5
					end
				end

				arg_16_1.text_.text = var_19_7
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_6, arg_16_1.talkMaxDuration)

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_5) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_5 + var_19_10 and arg_16_1.time_ < var_19_5 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.725

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938021005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 29 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 29)

				if (29 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 29)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10144 = arg_24_1.actors_["10144"].transform.localPosition
				arg_24_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10144", 3)

				for iter_27_0 = 0, arg_24_1.actors_["10144"].transform.childCount - 1 do
					local var_27_0 = arg_24_1.actors_["10144"].transform:GetChild(iter_27_0)

					if var_27_0.name == "" or not string.find(var_27_0.name, "split") then
						var_27_0.gameObject:SetActive(true)
					else
						var_27_0.gameObject:SetActive(false)
					end
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_24_1.time_ - 0) / var_27_1)
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_27_2 = 0
			local var_27_3 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938021006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 11 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 11)

				if (11 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 11)) > 0 and var_27_3 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_7 and arg_24_1.time_ < var_27_2 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10144 = arg_28_1.actors_["10144"].transform.localPosition
				arg_28_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10144", 3)

				for iter_31_0 = 0, arg_28_1.actors_["10144"].transform.childCount - 1 do
					local var_31_0 = arg_28_1.actors_["10144"].transform:GetChild(iter_31_0)

					if var_31_0.name == "" or not string.find(var_31_0.name, "split") then
						var_31_0.gameObject:SetActive(true)
					else
						var_31_0.gameObject:SetActive(false)
					end
				end
			end

			local var_31_1 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 then
				arg_28_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_28_1.time_ - 0) / var_31_1)
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_31_2 = 0
			local var_31_3 = 1.35

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938021007).content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 54 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_4) / 54)

				if (54 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_4) / 54)) > 0 and var_31_3 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_7 and arg_28_1.time_ < var_31_2 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938021008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["104902"] == nil then
				local var_35_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_35_0) then
					local var_35_1 = Object.Instantiate(var_35_0, arg_32_1.canvasGo_.transform)

					var_35_1.transform:SetSiblingIndex(1)

					var_35_1.name = "104902"
					var_35_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_32_1.actors_["104902"] = var_35_1

					if arg_32_1.isInRecall_ then
						for iter_35_0, iter_35_1 in ipairs((var_35_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_35_1.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_35_2 = arg_32_1.actors_["104902"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps104902 == nil then
				arg_32_1.var_.actorSpriteComps104902 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps104902 then
					for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_35_3 then
							if arg_32_1.isInRecall_ then
								iter_35_3.color = Color.New(Mathf.Lerp(iter_35_3.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_3), Mathf.Lerp(iter_35_3.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_3), (Mathf.Lerp(iter_35_3.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_3)))
							else
								local var_35_4 = Mathf.Lerp(iter_35_3.color.r, 1, (arg_32_1.time_ - 0) / var_35_3)

								iter_35_3.color = Color.New(var_35_4, var_35_4, var_35_4)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps104902 then
				for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_35_5 then
						iter_35_5.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps104902 = nil
			end

			local var_35_5 = arg_32_1.actors_["10144"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = var_35_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_35_7 then
							if arg_32_1.isInRecall_ then
								iter_35_7.color = Color.New(Mathf.Lerp(iter_35_7.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_6), Mathf.Lerp(iter_35_7.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_6), (Mathf.Lerp(iter_35_7.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_6)))
							else
								local var_35_7 = Mathf.Lerp(iter_35_7.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_6)

								iter_35_7.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_8, iter_35_9 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_9 then
						iter_35_9.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_8 = arg_32_1.actors_["10144"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10144 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10144", 7)

				for iter_35_10 = 0, var_35_8.childCount - 1 do
					local var_35_9 = var_35_8:GetChild(iter_35_10)

					if var_35_9.name == "" or not string.find(var_35_9.name, "split") then
						var_35_9.gameObject:SetActive(true)
					else
						var_35_9.gameObject:SetActive(false)
					end
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_32_1.time_ - 0) / var_35_10)
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_35_11 = arg_32_1.actors_["104902"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos104902 = var_35_11.localPosition
				var_35_11.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("104902", 2)

				for iter_35_11 = 0, var_35_11.childCount - 1 do
					local var_35_12 = var_35_11:GetChild(iter_35_11)

					if var_35_12.name == "" or not string.find(var_35_12.name, "split") then
						var_35_12.gameObject:SetActive(true)
					else
						var_35_12.gameObject:SetActive(false)
					end
				end
			end

			local var_35_13 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_13 then
				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_32_1.time_ - 0) / var_35_13)
			end

			if arg_32_1.time_ >= 0 + var_35_13 and arg_32_1.time_ < 0 + var_35_13 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_35_14 = 0
			local var_35_15 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_16 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938021008).content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_18 = 7 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_16) / 7)

				if (7 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_16) / 7)) > 0 and var_35_15 < var_35_18 then
					arg_32_1.talkMaxDuration = var_35_18

					if var_35_18 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_14
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_19 = math.max(var_35_15, arg_32_1.talkMaxDuration)

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_19 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_14) / var_35_19

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_14 + var_35_19 and arg_32_1.time_ < var_35_14 + var_35_19 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
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
	Play938021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938021009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["106603"] == nil then
				local var_39_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_39_0) then
					local var_39_1 = Object.Instantiate(var_39_0, arg_36_1.canvasGo_.transform)

					var_39_1.transform:SetSiblingIndex(1)

					var_39_1.name = "106603"
					var_39_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_36_1.actors_["106603"] = var_39_1

					if arg_36_1.isInRecall_ then
						for iter_39_0, iter_39_1 in ipairs((var_39_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_39_1.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_39_2 = arg_36_1.actors_["106603"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_39_3 then
							if arg_36_1.isInRecall_ then
								iter_39_3.color = Color.New(Mathf.Lerp(iter_39_3.color.r, arg_36_1.hightColor1.r, (arg_36_1.time_ - 0) / var_39_3), Mathf.Lerp(iter_39_3.color.g, arg_36_1.hightColor1.g, (arg_36_1.time_ - 0) / var_39_3), (Mathf.Lerp(iter_39_3.color.b, arg_36_1.hightColor1.b, (arg_36_1.time_ - 0) / var_39_3)))
							else
								local var_39_4 = Mathf.Lerp(iter_39_3.color.r, 1, (arg_36_1.time_ - 0) / var_39_3)

								iter_39_3.color = Color.New(var_39_4, var_39_4, var_39_4)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_5 then
						iter_39_5.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_5 = arg_36_1.actors_["104902"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.actorSpriteComps104902 == nil then
				arg_36_1.var_.actorSpriteComps104902 = var_39_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_6 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.actorSpriteComps104902 then
					for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_39_7 then
							if arg_36_1.isInRecall_ then
								iter_39_7.color = Color.New(Mathf.Lerp(iter_39_7.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_6), Mathf.Lerp(iter_39_7.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_6), (Mathf.Lerp(iter_39_7.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_6)))
							else
								local var_39_7 = Mathf.Lerp(iter_39_7.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_6)

								iter_39_7.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.actorSpriteComps104902 then
				for iter_39_8, iter_39_9 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_39_9 then
						iter_39_9.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps104902 = nil
			end

			local var_39_8 = arg_36_1.actors_["106603"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_8.localPosition
				var_39_8.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 4)

				for iter_39_10 = 0, var_39_8.childCount - 1 do
					local var_39_9 = var_39_8:GetChild(iter_39_10)

					if var_39_9.name == "" or not string.find(var_39_9.name, "split") then
						var_39_9.gameObject:SetActive(true)
					else
						var_39_9.gameObject:SetActive(false)
					end
				end
			end

			local var_39_10 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_10 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_36_1.time_ - 0) / var_39_10)
			end

			if arg_36_1.time_ >= 0 + var_39_10 and arg_36_1.time_ < 0 + var_39_10 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_39_11 = 0
			local var_39_12 = 0.625

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938021009).content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 25 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_13) / 25)

				if (25 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_13) / 25)) > 0 and var_39_12 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_11 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_11
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_12, arg_36_1.talkMaxDuration)

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_11) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_11 + var_39_16 and arg_36_1.time_ < var_39_11 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play938021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938021010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10144"]) and arg_40_1.var_.actorSpriteComps10144 == nil then
				arg_40_1.var_.actorSpriteComps10144 = arg_40_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10144"]) then
				if arg_40_1.var_.actorSpriteComps10144 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10144"]) and arg_40_1.var_.actorSpriteComps10144 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps10144 = nil
			end

			local var_43_2 = arg_40_1.actors_["106603"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps106603 == nil then
				arg_40_1.var_.actorSpriteComps106603 = var_43_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.actorSpriteComps106603 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps106603 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_43_7 then
						iter_43_7.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps106603 = nil
			end

			local var_43_5 = arg_40_1.actors_["10144"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10144 = var_43_5.localPosition
				var_43_5.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10144", 3)

				for iter_43_8 = 0, var_43_5.childCount - 1 do
					local var_43_6 = var_43_5:GetChild(iter_43_8)

					if var_43_6.name == "" or not string.find(var_43_6.name, "split") then
						var_43_6.gameObject:SetActive(true)
					else
						var_43_6.gameObject:SetActive(false)
					end
				end
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_40_1.time_ - 0) / var_43_7)
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_43_8 = arg_40_1.actors_["106603"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos106603 = var_43_8.localPosition
				var_43_8.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("106603", 7)

				for iter_43_9 = 0, var_43_8.childCount - 1 do
					local var_43_9 = var_43_8:GetChild(iter_43_9)

					if var_43_9.name == "" or not string.find(var_43_9.name, "split") then
						var_43_9.gameObject:SetActive(true)
					else
						var_43_9.gameObject:SetActive(false)
					end
				end
			end

			local var_43_10 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_10 then
				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_40_1.time_ - 0) / var_43_10)
			end

			if arg_40_1.time_ >= 0 + var_43_10 and arg_40_1.time_ < 0 + var_43_10 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_11 = arg_40_1.actors_["104902"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos104902 = var_43_11.localPosition
				var_43_11.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("104902", 7)

				for iter_43_10 = 0, var_43_11.childCount - 1 do
					local var_43_12 = var_43_11:GetChild(iter_43_10)

					if var_43_12.name == "" or not string.find(var_43_12.name, "split") then
						var_43_12.gameObject:SetActive(true)
					else
						var_43_12.gameObject:SetActive(false)
					end
				end
			end

			local var_43_13 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_13 then
				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_40_1.time_ - 0) / var_43_13)
			end

			if arg_40_1.time_ >= 0 + var_43_13 and arg_40_1.time_ < 0 + var_43_13 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_43_14 = 0
			local var_43_15 = 1.525

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_16 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(938021010).content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_18 = 61 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_16) / 61)

				if (61 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_16) / 61)) > 0 and var_43_15 < var_43_18 then
					arg_40_1.talkMaxDuration = var_43_18

					if var_43_18 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_14
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_19 = math.max(var_43_15, arg_40_1.talkMaxDuration)

			if var_43_14 <= arg_40_1.time_ and arg_40_1.time_ < var_43_14 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_14) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_14 + var_43_19 and arg_40_1.time_ < var_43_14 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
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
	Play938021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938021011
		arg_44_1.duration_ = 6.4

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_9001
			local var_47_9000

			if arg_44_1.bgs_.ST0108 == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0108")
				var_47_0.name = "ST0108"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.ST0108 = var_47_0
			end

			if 0.866666666666667 < arg_44_1.time_ and arg_44_1.time_ <= 0.866666666666667 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.ST0108

				arg_44_1.bgs_.ST0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "ST0108" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = 0.866666666666667

			if 0.866666666666667 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			if arg_44_1.time_ >= var_47_4 + 0.133333333333333 and arg_44_1.time_ < var_47_4 + 0.133333333333333 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_5 = arg_44_1.var_.effectzhuanchang12312

				if not arg_44_1.var_.effectzhuanchang12312 then
					var_47_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_47_5.name = "zhuanchang12312"
					arg_44_1.var_.effectzhuanchang12312 = var_47_5
				else
					var_47_5.transform:SetParent(var_47_9001)
				end

				var_47_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_47_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_47_5.transform.localScale = Vector3.New(var_47_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_47_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_47_5.transform.localScale.z)
			end

			local var_47_7 = arg_44_1.actors_["10144"]

			if 0.866666666666667 < arg_44_1.time_ and arg_44_1.time_ <= 0.866666666666667 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.actorSpriteComps10144 == nil then
				arg_44_1.var_.actorSpriteComps10144 = var_47_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_8 = 0.133333333333333

			if 0.866666666666667 <= arg_44_1.time_ and arg_44_1.time_ < 0.866666666666667 + var_47_8 and not isNil(var_47_7) then
				if arg_44_1.var_.actorSpriteComps10144 then
					for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_47_3 then
							if arg_44_1.isInRecall_ then
								iter_47_3.color = Color.New(Mathf.Lerp(iter_47_3.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0.866666666666667) / var_47_8), Mathf.Lerp(iter_47_3.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0.866666666666667) / var_47_8), (Mathf.Lerp(iter_47_3.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0.866666666666667) / var_47_8)))
							else
								local var_47_9 = Mathf.Lerp(iter_47_3.color.r, 0.5, (arg_44_1.time_ - 0.866666666666667) / var_47_8)

								iter_47_3.color = Color.New(var_47_9, var_47_9, var_47_9)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0.866666666666667 + var_47_8 and arg_44_1.time_ < 0.866666666666667 + var_47_8 + arg_47_0 and not isNil(var_47_7) and arg_44_1.var_.actorSpriteComps10144 then
				for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_47_5 then
						iter_47_5.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps10144 = nil
			end

			local var_47_10 = arg_44_1.actors_["10144"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10144 = var_47_10.localPosition
				var_47_10.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10144", 7)

				for iter_47_6 = 0, var_47_10.childCount - 1 do
					local var_47_11 = var_47_10:GetChild(iter_47_6)

					if var_47_11.name == "" or not string.find(var_47_11.name, "split") then
						var_47_11.gameObject:SetActive(true)
					else
						var_47_11.gameObject:SetActive(false)
					end
				end
			end

			local var_47_12 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_12 then
				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_44_1.time_ - 0) / var_47_12)
			end

			if arg_44_1.time_ >= 0 + var_47_12 and arg_44_1.time_ < 0 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_44_1.time_ and arg_44_1.time_ <= 1 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 0.3 < arg_44_1.time_ and arg_44_1.time_ <= 0.3 + arg_47_0 then
				arg_44_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 0.1 < arg_44_1.time_ and arg_44_1.time_ <= 0.1 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			if 0.866666666666667 < arg_44_1.time_ and arg_44_1.time_ <= 0.866666666666667 + arg_47_0 then
				local var_47_16 = arg_44_1.var_.effectshujuliuzhuanchang1

				if not arg_44_1.var_.effectshujuliuzhuanchang1 then
					var_47_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), manager.ui.mainCamera.transform)
					var_47_16.name = "shujuliuzhuanchang1"
					arg_44_1.var_.effectshujuliuzhuanchang1 = var_47_16
				else
					var_47_16.transform:SetParent(var_47_9000)
				end

				var_47_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_47_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_18 = 1.4
			local var_47_19 = 0.6

			if 1.4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_20 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_20:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_21 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(938021011).content)

				arg_44_1.text_.text = var_47_21

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_23 = 24 <= 0 and var_47_19 or var_47_19 * (utf8.len(var_47_21) / 24)

				if (24 <= 0 and var_47_19 or var_47_19 * (utf8.len(var_47_21) / 24)) > 0 and var_47_19 < var_47_23 then
					arg_44_1.talkMaxDuration = var_47_23
					var_47_18 = var_47_18 + 0.3

					if var_47_23 + var_47_18 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_18
					end
				end

				arg_44_1.text_.text = var_47_21
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_24 = var_47_18 + 0.3
			local var_47_25 = math.max(var_47_19, arg_44_1.talkMaxDuration)

			if var_47_18 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_24 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_24) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_24 + var_47_25 and arg_44_1.time_ < var_47_24 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play938021012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938021012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938021013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.65

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(938021012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 66 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 66)

				if (66 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 66)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play938021013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938021013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938021014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["128404"]) and arg_54_1.var_.actorSpriteComps128404 == nil then
				arg_54_1.var_.actorSpriteComps128404 = arg_54_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["128404"]) then
				if arg_54_1.var_.actorSpriteComps128404 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 1, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["128404"]) and arg_54_1.var_.actorSpriteComps128404 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps128404 = nil
			end

			local var_57_2 = arg_54_1.actors_["128404"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = var_57_2.localPosition
				var_57_2.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				for iter_57_4 = 0, var_57_2.childCount - 1 do
					local var_57_3 = var_57_2:GetChild(iter_57_4)

					if var_57_3.name == "split_5" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_54_1.time_ - 0) / var_57_4)
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				if arg_54_1.var_.effectshujuliuzhuanchang1 then
					Object.Destroy(arg_54_1.var_.effectshujuliuzhuanchang1)

					arg_54_1.var_.effectshujuliuzhuanchang1 = nil
				end
			end

			local var_57_6 = 0
			local var_57_7 = 0.325

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_8 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(938021013).content)

				arg_54_1.text_.text = var_57_8

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_10 = 13 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_8) / 13)

				if (13 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_8) / 13)) > 0 and var_57_7 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_8
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_11 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_11 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_11

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_11 and arg_54_1.time_ < var_57_6 + var_57_11 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play938021014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938021014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938021015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10144"]) and arg_58_1.var_.actorSpriteComps10144 == nil then
				arg_58_1.var_.actorSpriteComps10144 = arg_58_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10144"]) then
				if arg_58_1.var_.actorSpriteComps10144 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10144"]) and arg_58_1.var_.actorSpriteComps10144 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10144 = nil
			end

			local var_61_2 = arg_58_1.actors_["128404"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								iter_61_5.color = Color.New(Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_5.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_5.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_7 then
						iter_61_7.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_5 = arg_58_1.actors_["10144"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10144 = var_61_5.localPosition
				var_61_5.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10144", 4)

				for iter_61_8 = 0, var_61_5.childCount - 1 do
					local var_61_6 = var_61_5:GetChild(iter_61_8)

					if var_61_6.name == "split_1" or not string.find(var_61_6.name, "split") then
						var_61_6.gameObject:SetActive(true)
					else
						var_61_6.gameObject:SetActive(false)
					end
				end
			end

			local var_61_7 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				var_61_5.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_58_1.time_ - 0) / var_61_7)
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				var_61_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_61_8 = 0
			local var_61_9 = 1.75

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(938021014).content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_12 = 70 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_10) / 70)

				if (70 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_10) / 70)) > 0 and var_61_9 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_13 and arg_58_1.time_ < var_61_8 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play938021015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938021015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938021016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10144 = arg_62_1.actors_["10144"].transform.localPosition
				arg_62_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10144", 4)

				for iter_65_0 = 0, arg_62_1.actors_["10144"].transform.childCount - 1 do
					local var_65_0 = arg_62_1.actors_["10144"].transform:GetChild(iter_65_0)

					if var_65_0.name == "" or not string.find(var_65_0.name, "split") then
						var_65_0.gameObject:SetActive(true)
					else
						var_65_0.gameObject:SetActive(false)
					end
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_62_1.time_ - 0) / var_65_1)
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_65_2 = 0
			local var_65_3 = 1.35

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(938021015).content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 54 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 54)

				if (54 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 54)) > 0 and var_65_3 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_7 and arg_62_1.time_ < var_65_2 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play938021016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938021016
		arg_66_1.duration_ = 6.1

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938021017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_9000

			if 0.934 < arg_66_1.time_ and arg_66_1.time_ <= 0.934 + arg_69_0 then
				local var_69_0 = arg_66_1.bgs_.ST0119

				arg_66_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_1 = var_69_0:GetComponent("SpriteRenderer")

				if var_69_1 and var_69_1.sprite then
					local var_69_2 = 2 * (var_69_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_0.transform.localScale = Vector3.New(var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST0119" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_3 = 0.934

			if 0.934 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_3 + 0.3 and arg_66_1.time_ < var_69_3 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				local var_69_4 = arg_66_1.var_.effecthuanchangjing123

				if not arg_66_1.var_.effecthuanchangjing123 then
					var_69_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_69_4.name = "huanchangjing123"
					arg_66_1.var_.effecthuanchangjing123 = var_69_4
				else
					var_69_4.transform:SetParent(var_69_9000)
				end

				var_69_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_69_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_69_6 = arg_66_1.actors_["10144"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.actorSpriteComps10144 == nil then
				arg_66_1.var_.actorSpriteComps10144 = var_69_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_7 = 0.034

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 and not isNil(var_69_6) then
				if arg_66_1.var_.actorSpriteComps10144 then
					for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_69_3 then
							if arg_66_1.isInRecall_ then
								iter_69_3.color = Color.New(Mathf.Lerp(iter_69_3.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_7), Mathf.Lerp(iter_69_3.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_7), (Mathf.Lerp(iter_69_3.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_7)))
							else
								local var_69_8 = Mathf.Lerp(iter_69_3.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_7)

								iter_69_3.color = Color.New(var_69_8, var_69_8, var_69_8)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 and not isNil(var_69_6) and arg_66_1.var_.actorSpriteComps10144 then
				for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_69_5 then
						iter_69_5.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps10144 = nil
			end

			local var_69_9 = arg_66_1.actors_["128404"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos128404 = var_69_9.localPosition
				var_69_9.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("128404", 7)

				for iter_69_6 = 0, var_69_9.childCount - 1 do
					local var_69_10 = var_69_9:GetChild(iter_69_6)

					if var_69_10.name == "" or not string.find(var_69_10.name, "split") then
						var_69_10.gameObject:SetActive(true)
					else
						var_69_10.gameObject:SetActive(false)
					end
				end
			end

			local var_69_11 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_11 then
				var_69_9.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_66_1.time_ - 0) / var_69_11)
			end

			if arg_66_1.time_ >= 0 + var_69_11 and arg_66_1.time_ < 0 + var_69_11 + arg_69_0 then
				var_69_9.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_69_12 = arg_66_1.actors_["10144"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10144 = var_69_12.localPosition
				var_69_12.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("10144", 7)

				for iter_69_7 = 0, var_69_12.childCount - 1 do
					local var_69_13 = var_69_12:GetChild(iter_69_7)

					if var_69_13.name == "" or not string.find(var_69_13.name, "split") then
						var_69_13.gameObject:SetActive(true)
					else
						var_69_13.gameObject:SetActive(false)
					end
				end
			end

			local var_69_14 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_14 then
				var_69_12.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_66_1.time_ - 0) / var_69_14)
			end

			if arg_66_1.time_ >= 0 + var_69_14 and arg_66_1.time_ < 0 + var_69_14 + arg_69_0 then
				var_69_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_66_1.time_ and arg_66_1.time_ <= 1 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 0.3 < arg_66_1.time_ and arg_66_1.time_ <= 0.3 + arg_69_0 then
				arg_66_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= 1.1 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			local var_69_18 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_18 + 2.1 and arg_66_1.time_ < var_69_18 + 2.1 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_19 = 1.1
			local var_69_20 = 1.25

			if 1.1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_21 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_21:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_22 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(938021016).content)

				arg_66_1.text_.text = var_69_22

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_24 = 50 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_22) / 50)

				if (50 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_22) / 50)) > 0 and var_69_20 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24
					var_69_19 = var_69_19 + 0.3

					if var_69_24 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_19
					end
				end

				arg_66_1.text_.text = var_69_22
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = var_69_19 + 0.3
			local var_69_26 = math.max(var_69_20, arg_66_1.talkMaxDuration)

			if var_69_19 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_25 + var_69_26 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_25) / var_69_26

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_25 + var_69_26 and arg_66_1.time_ < var_69_25 + var_69_26 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play938021017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938021017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938021018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["10144"]) and arg_72_1.var_.actorSpriteComps10144 == nil then
				arg_72_1.var_.actorSpriteComps10144 = arg_72_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["10144"]) then
				if arg_72_1.var_.actorSpriteComps10144 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["10144"]) and arg_72_1.var_.actorSpriteComps10144 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps10144 = nil
			end

			local var_75_2 = arg_72_1.actors_["10144"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10144 = var_75_2.localPosition
				var_75_2.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10144", 3)

				for iter_75_4 = 0, var_75_2.childCount - 1 do
					local var_75_3 = var_75_2:GetChild(iter_75_4)

					if var_75_3.name == "split_2" or not string.find(var_75_3.name, "split") then
						var_75_3.gameObject:SetActive(true)
					else
						var_75_3.gameObject:SetActive(false)
					end
				end
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_2.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_72_1.time_ - 0) / var_75_4)
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				local var_75_5 = arg_72_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_75_5 then
					arg_72_1.var_.alphaOldValue10144 = var_75_5.alpha
					arg_72_1.var_.characterEffect10144 = var_75_5
				end

				arg_72_1.var_.alphaOldValue10144 = 0
			end

			local var_75_6 = 0.0166666666666667

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 then
				if arg_72_1.var_.characterEffect10144 then
					arg_72_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_72_1.var_.alphaOldValue10144, 1, (arg_72_1.time_ - 0) / var_75_6)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and arg_72_1.var_.characterEffect10144 then
				arg_72_1.var_.characterEffect10144.alpha = 1
			end

			local var_75_7 = 0
			local var_75_8 = 1.175

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_9 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(938021017).content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 47 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 47)

				if (47 <= 0 and var_75_8 or var_75_8 * (utf8.len(var_75_9) / 47)) > 0 and var_75_8 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_12 and arg_72_1.time_ < var_75_7 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938021018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938021018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938021019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10144"]) and arg_76_1.var_.actorSpriteComps10144 == nil then
				arg_76_1.var_.actorSpriteComps10144 = arg_76_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10144"]) then
				if arg_76_1.var_.actorSpriteComps10144 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10144"]) and arg_76_1.var_.actorSpriteComps10144 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps10144 = nil
			end

			local var_79_2 = arg_76_1.actors_["10144"].transform

			if 0.366666666666667 < arg_76_1.time_ and arg_76_1.time_ <= 0.366666666666667 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_2.localPosition
				var_79_2.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10144", 7)

				for iter_79_4 = 0, var_79_2.childCount - 1 do
					local var_79_3 = var_79_2:GetChild(iter_79_4)

					if var_79_3.name == "" or not string.find(var_79_3.name, "split") then
						var_79_3.gameObject:SetActive(true)
					else
						var_79_3.gameObject:SetActive(false)
					end
				end
			end

			local var_79_4 = 0.001

			if 0.366666666666667 <= arg_76_1.time_ and arg_76_1.time_ < 0.366666666666667 + var_79_4 then
				var_79_2.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0.366666666666667) / var_79_4)
			end

			if arg_76_1.time_ >= 0.366666666666667 + var_79_4 and arg_76_1.time_ < 0.366666666666667 + var_79_4 + arg_79_0 then
				var_79_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_5 = arg_76_1.actors_["10144"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				for iter_79_5 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_5)

					if var_79_6.name == "split_2" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.366666666666667

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, Vector3.New(-31.5, -500, -285.9), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(-31.5, -500, -285.9)
			end

			local var_79_8 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			if arg_76_1.time_ >= var_79_8 + 0.5 and arg_76_1.time_ < var_79_8 + 0.5 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_9 = 0
			local var_79_10 = 1.35

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_11 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(938021018).content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 54 <= 0 and var_79_10 or var_79_10 * (utf8.len(var_79_11) / 54)

				if (54 <= 0 and var_79_10 or var_79_10 * (utf8.len(var_79_11) / 54)) > 0 and var_79_10 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_9 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_9
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_10, arg_76_1.talkMaxDuration)

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_9) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_9 + var_79_14 and arg_76_1.time_ < var_79_9 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.366666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-31.5, -381.1, -285.9),
					endPos = Vector3.New(-31.5, -500, -285.9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play938021019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938021019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938021020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_152", "se_story_152_crowd", "")
			end

			local var_83_1 = 0
			local var_83_2 = 1.625

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(938021019).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 65 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 65)

				if (65 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 65)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938021020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 938021020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play938021021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["108301"]) and arg_84_1.var_.actorSpriteComps108301 == nil then
				arg_84_1.var_.actorSpriteComps108301 = arg_84_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["108301"]) then
				if arg_84_1.var_.actorSpriteComps108301 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["108301"]) and arg_84_1.var_.actorSpriteComps108301 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps108301 = nil
			end

			local var_87_2 = arg_84_1.actors_["108301"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos108301 = var_87_2.localPosition
				var_87_2.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("108301", 2)

				for iter_87_4 = 0, var_87_2.childCount - 1 do
					local var_87_3 = var_87_2:GetChild(iter_87_4)

					if var_87_3.name == "split_3" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_84_1.time_ - 0) / var_87_4)
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_87_5 = 0
			local var_87_6 = 0.975

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(938021020).content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 39 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 39)

				if (39 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 39)) > 0 and var_87_6 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_10 and arg_84_1.time_ < var_87_5 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play938021021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 938021021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play938021022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["128404"]) and arg_88_1.var_.actorSpriteComps128404 == nil then
				arg_88_1.var_.actorSpriteComps128404 = arg_88_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["128404"]) then
				if arg_88_1.var_.actorSpriteComps128404 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 1, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["128404"]) and arg_88_1.var_.actorSpriteComps128404 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps128404 = nil
			end

			local var_91_2 = arg_88_1.actors_["108301"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps108301 == nil then
				arg_88_1.var_.actorSpriteComps108301 = var_91_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_3 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.actorSpriteComps108301 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								iter_91_5.color = Color.New(Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_3), Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_3), (Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_3)))
							else
								local var_91_4 = Mathf.Lerp(iter_91_5.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_3)

								iter_91_5.color = Color.New(var_91_4, var_91_4, var_91_4)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps108301 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_91_7 then
						iter_91_7.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps108301 = nil
			end

			local var_91_5 = arg_88_1.actors_["128404"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos128404 = var_91_5.localPosition
				var_91_5.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("128404", 4)

				for iter_91_8 = 0, var_91_5.childCount - 1 do
					local var_91_6 = var_91_5:GetChild(iter_91_8)

					if var_91_6.name == "split_2" or not string.find(var_91_6.name, "split") then
						var_91_6.gameObject:SetActive(true)
					else
						var_91_6.gameObject:SetActive(false)
					end
				end
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_88_1.time_ - 0) / var_91_7)
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_91_8 = 0
			local var_91_9 = 0.825

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(938021021).content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_12 = 33 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_10) / 33)

				if (33 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_10) / 33)) > 0 and var_91_9 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_13 and arg_88_1.time_ < var_91_8 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play938021022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 938021022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play938021023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["128404"]) and arg_92_1.var_.actorSpriteComps128404 == nil then
				arg_92_1.var_.actorSpriteComps128404 = arg_92_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["128404"]) then
				if arg_92_1.var_.actorSpriteComps128404 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["128404"]) and arg_92_1.var_.actorSpriteComps128404 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps128404 = nil
			end

			local var_95_2 = 0
			local var_95_3 = 0.525

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_4 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(938021022).content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 21 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 21)

				if (21 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_4) / 21)) > 0 and var_95_3 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_7 and arg_92_1.time_ < var_95_2 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play938021023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 938021023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play938021024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["128404"]) and arg_96_1.var_.actorSpriteComps128404 == nil then
				arg_96_1.var_.actorSpriteComps128404 = arg_96_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["128404"]) then
				if arg_96_1.var_.actorSpriteComps128404 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["128404"]) and arg_96_1.var_.actorSpriteComps128404 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps128404 = nil
			end

			local var_99_2 = arg_96_1.actors_["128404"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos128404 = var_99_2.localPosition
				var_99_2.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("128404", 4)

				for iter_99_4 = 0, var_99_2.childCount - 1 do
					local var_99_3 = var_99_2:GetChild(iter_99_4)

					if var_99_3.name == "" or not string.find(var_99_3.name, "split") then
						var_99_3.gameObject:SetActive(true)
					else
						var_99_3.gameObject:SetActive(false)
					end
				end
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_2.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_96_1.time_ - 0) / var_99_4)
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_2.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_99_5 = 0
			local var_99_6 = 1.275

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(938021023).content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 51 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 51)

				if (51 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 51)) > 0 and var_99_6 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_10 and arg_96_1.time_ < var_99_5 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 938021024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play938021025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["128404"]) and arg_100_1.var_.actorSpriteComps128404 == nil then
				arg_100_1.var_.actorSpriteComps128404 = arg_100_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["128404"]) then
				if arg_100_1.var_.actorSpriteComps128404 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 0.5, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["128404"]) and arg_100_1.var_.actorSpriteComps128404 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps128404 = nil
			end

			local var_103_2 = 0
			local var_103_3 = 1.05

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_4 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(938021024).content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 42 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_4) / 42)

				if (42 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_4) / 42)) > 0 and var_103_3 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_7 and arg_100_1.time_ < var_103_2 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play938021025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 938021025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play938021026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["128404"]) and arg_104_1.var_.actorSpriteComps128404 == nil then
				arg_104_1.var_.actorSpriteComps128404 = arg_104_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["128404"]) then
				if arg_104_1.var_.actorSpriteComps128404 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["128404"]) and arg_104_1.var_.actorSpriteComps128404 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps128404 = nil
			end

			local var_107_2 = arg_104_1.actors_["128404"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos128404 = var_107_2.localPosition
				var_107_2.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("128404", 4)

				for iter_107_4 = 0, var_107_2.childCount - 1 do
					local var_107_3 = var_107_2:GetChild(iter_107_4)

					if var_107_3.name == "split_4" then
						var_107_3:SetAsLastSibling()
						var_107_3.gameObject:SetActive(true)

						arg_104_1.var_.actorSpriteSplit128404 = var_107_3.gameObject:GetComponent(typeof(Image))

						arg_104_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_107_4 = 0.5

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				var_107_2.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_104_1.time_ - 0) / var_107_4)

				if arg_104_1.var_.actorSpriteSplit128404 ~= nil then
					arg_104_1.var_.actorSpriteSplit128404:SetAlpha((arg_104_1.time_ - 0) / var_107_4)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				var_107_2.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_104_1.var_.actorSpriteSplit128404 ~= nil then
					arg_104_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_107_5 = 0
			local var_107_6 = 0.525

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(938021025).content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 21 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_7) / 21)

				if (21 <= 0 and var_107_6 or var_107_6 * (utf8.len(var_107_7) / 21)) > 0 and var_107_6 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_5
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_6, arg_104_1.talkMaxDuration)

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_5) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_5 + var_107_10 and arg_104_1.time_ < var_107_5 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play938021026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 938021026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play938021027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["128404"]) and arg_108_1.var_.actorSpriteComps128404 == nil then
				arg_108_1.var_.actorSpriteComps128404 = arg_108_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["128404"]) then
				if arg_108_1.var_.actorSpriteComps128404 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["128404"]) and arg_108_1.var_.actorSpriteComps128404 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps128404 = nil
			end

			local var_111_2 = 0
			local var_111_3 = 0.1

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_4 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(938021026).content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 4 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_4) / 4)

				if (4 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_4) / 4)) > 0 and var_111_3 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_7 and arg_108_1.time_ < var_111_2 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play938021027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 938021027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play938021028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["128404"]) and arg_112_1.var_.actorSpriteComps128404 == nil then
				arg_112_1.var_.actorSpriteComps128404 = arg_112_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["128404"]) then
				if arg_112_1.var_.actorSpriteComps128404 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["128404"]) and arg_112_1.var_.actorSpriteComps128404 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps128404 = nil
			end

			local var_115_2 = arg_112_1.actors_["128404"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos128404 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("128404", 4)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "" then
						var_115_3:SetAsLastSibling()
						var_115_3.gameObject:SetActive(true)

						arg_112_1.var_.actorSpriteSplit128404 = var_115_3.gameObject:GetComponent(typeof(Image))

						arg_112_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_115_4 = 0.5

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_112_1.time_ - 0) / var_115_4)

				if arg_112_1.var_.actorSpriteSplit128404 ~= nil then
					arg_112_1.var_.actorSpriteSplit128404:SetAlpha((arg_112_1.time_ - 0) / var_115_4)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_112_1.var_.actorSpriteSplit128404 ~= nil then
					arg_112_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_115_5 = 0
			local var_115_6 = 0.4

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(938021027).content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 16 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 16)

				if (16 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 16)) > 0 and var_115_6 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_10 and arg_112_1.time_ < var_115_5 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play938021028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 938021028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play938021029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["104902"]) and arg_116_1.var_.actorSpriteComps104902 == nil then
				arg_116_1.var_.actorSpriteComps104902 = arg_116_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["104902"]) then
				if arg_116_1.var_.actorSpriteComps104902 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["104902"]) and arg_116_1.var_.actorSpriteComps104902 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps104902 = nil
			end

			local var_119_2 = arg_116_1.actors_["128404"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps128404 == nil then
				arg_116_1.var_.actorSpriteComps128404 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps128404 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps128404 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps128404 = nil
			end

			local var_119_5 = arg_116_1.actors_["104902"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos104902 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("104902", 2)

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
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_119_8 = arg_116_1.actors_["108301"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos108301 = var_119_8.localPosition
				var_119_8.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("108301", 7)

				for iter_119_9 = 0, var_119_8.childCount - 1 do
					local var_119_9 = var_119_8:GetChild(iter_119_9)

					if var_119_9.name == "" or not string.find(var_119_9.name, "split") then
						var_119_9.gameObject:SetActive(true)
					else
						var_119_9.gameObject:SetActive(false)
					end
				end
			end

			local var_119_10 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_10 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0) / var_119_10)
			end

			if arg_116_1.time_ >= 0 + var_119_10 and arg_116_1.time_ < 0 + var_119_10 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_11 = 0
			local var_119_12 = 1.05

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_13 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(938021028).content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 42 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 42)

				if (42 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 42)) > 0 and var_119_12 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_16 and arg_116_1.time_ < var_119_11 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 938021029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play938021030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["106603"]) and arg_120_1.var_.actorSpriteComps106603 == nil then
				arg_120_1.var_.actorSpriteComps106603 = arg_120_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["106603"]) then
				if arg_120_1.var_.actorSpriteComps106603 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["106603"]) and arg_120_1.var_.actorSpriteComps106603 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps106603 = nil
			end

			local var_123_2 = arg_120_1.actors_["104902"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps104902 == nil then
				arg_120_1.var_.actorSpriteComps104902 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps104902 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps104902 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps104902 = nil
			end

			local var_123_5 = arg_120_1.actors_["106603"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos106603 = var_123_5.localPosition
				var_123_5.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("106603", 2)

				for iter_123_8 = 0, var_123_5.childCount - 1 do
					local var_123_6 = var_123_5:GetChild(iter_123_8)

					if var_123_6.name == "" or not string.find(var_123_6.name, "split") then
						var_123_6.gameObject:SetActive(true)
					else
						var_123_6.gameObject:SetActive(false)
					end
				end
			end

			local var_123_7 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				var_123_5.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_120_1.time_ - 0) / var_123_7)
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				var_123_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_123_8 = arg_120_1.actors_["104902"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos104902 = var_123_8.localPosition
				var_123_8.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("104902", 7)

				for iter_123_9 = 0, var_123_8.childCount - 1 do
					local var_123_9 = var_123_8:GetChild(iter_123_9)

					if var_123_9.name == "" or not string.find(var_123_9.name, "split") then
						var_123_9.gameObject:SetActive(true)
					else
						var_123_9.gameObject:SetActive(false)
					end
				end
			end

			local var_123_10 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_10 then
				var_123_8.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_120_1.time_ - 0) / var_123_10)
			end

			if arg_120_1.time_ >= 0 + var_123_10 and arg_120_1.time_ < 0 + var_123_10 + arg_123_0 then
				var_123_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_123_11 = 0
			local var_123_12 = 0.5

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_13 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(938021029).content)

				arg_120_1.text_.text = var_123_13

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_15 = 20 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 20)

				if (20 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 20)) > 0 and var_123_12 < var_123_15 then
					arg_120_1.talkMaxDuration = var_123_15

					if var_123_15 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_13
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_16 and arg_120_1.time_ < var_123_11 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play938021030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 938021030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play938021031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["128404"]) and arg_124_1.var_.actorSpriteComps128404 == nil then
				arg_124_1.var_.actorSpriteComps128404 = arg_124_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["128404"]) then
				if arg_124_1.var_.actorSpriteComps128404 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["128404"]) and arg_124_1.var_.actorSpriteComps128404 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps128404 = nil
			end

			local var_127_2 = arg_124_1.actors_["106603"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps106603 == nil then
				arg_124_1.var_.actorSpriteComps106603 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps106603 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps106603 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps106603 = nil
			end

			local var_127_5 = arg_124_1.actors_["128404"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos128404 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("128404", 4)

				for iter_127_8 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_8)

					if var_127_6.name == "split_6" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_127_8 = 0
			local var_127_9 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(938021030).content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_12 = 21 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 21)

				if (21 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 21)) > 0 and var_127_9 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_13 and arg_124_1.time_ < var_127_8 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 938021031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play938021032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["106603"]) and arg_128_1.var_.actorSpriteComps106603 == nil then
				arg_128_1.var_.actorSpriteComps106603 = arg_128_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["106603"]) then
				if arg_128_1.var_.actorSpriteComps106603 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["106603"]) and arg_128_1.var_.actorSpriteComps106603 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps106603 = nil
			end

			local var_131_2 = arg_128_1.actors_["128404"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps128404 == nil then
				arg_128_1.var_.actorSpriteComps128404 = var_131_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_3 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.actorSpriteComps128404 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps128404 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_131_7 then
						iter_131_7.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps128404 = nil
			end

			local var_131_5 = arg_128_1.actors_["106603"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos106603 = var_131_5.localPosition
				var_131_5.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("106603", 2)

				for iter_131_8 = 0, var_131_5.childCount - 1 do
					local var_131_6 = var_131_5:GetChild(iter_131_8)

					if var_131_6.name == "split_6" or not string.find(var_131_6.name, "split") then
						var_131_6.gameObject:SetActive(true)
					else
						var_131_6.gameObject:SetActive(false)
					end
				end
			end

			local var_131_7 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				var_131_5.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_128_1.time_ - 0) / var_131_7)
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				var_131_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_131_8 = 0
			local var_131_9 = 1.45

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(938021031).content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_12 = 58 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_10) / 58)

				if (58 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_10) / 58)) > 0 and var_131_9 < var_131_12 then
					arg_128_1.talkMaxDuration = var_131_12

					if var_131_12 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_13 and arg_128_1.time_ < var_131_8 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play938021032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 938021032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play938021033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["104902"]) and arg_132_1.var_.actorSpriteComps104902 == nil then
				arg_132_1.var_.actorSpriteComps104902 = arg_132_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["104902"]) then
				if arg_132_1.var_.actorSpriteComps104902 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["104902"]) and arg_132_1.var_.actorSpriteComps104902 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps104902 = nil
			end

			local var_135_2 = arg_132_1.actors_["106603"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps106603 == nil then
				arg_132_1.var_.actorSpriteComps106603 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps106603 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps106603 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps106603 = nil
			end

			local var_135_5 = arg_132_1.actors_["104902"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos104902 = var_135_5.localPosition
				var_135_5.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("104902", 2)

				for iter_135_8 = 0, var_135_5.childCount - 1 do
					local var_135_6 = var_135_5:GetChild(iter_135_8)

					if var_135_6.name == "split_2" or not string.find(var_135_6.name, "split") then
						var_135_6.gameObject:SetActive(true)
					else
						var_135_6.gameObject:SetActive(false)
					end
				end
			end

			local var_135_7 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_132_1.time_ - 0) / var_135_7)
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_135_8 = arg_132_1.actors_["106603"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos106603 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("106603", 7)

				for iter_135_9 = 0, var_135_8.childCount - 1 do
					local var_135_9 = var_135_8:GetChild(iter_135_9)

					if var_135_9.name == "" or not string.find(var_135_9.name, "split") then
						var_135_9.gameObject:SetActive(true)
					else
						var_135_9.gameObject:SetActive(false)
					end
				end
			end

			local var_135_10 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_10 then
				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_132_1.time_ - 0) / var_135_10)
			end

			if arg_132_1.time_ >= 0 + var_135_10 and arg_132_1.time_ < 0 + var_135_10 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_11 = 0
			local var_135_12 = 0.275

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(938021032).content)

				arg_132_1.text_.text = var_135_13

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 11 <= 0 and var_135_12 or var_135_12 * (utf8.len(var_135_13) / 11)

				if (11 <= 0 and var_135_12 or var_135_12 * (utf8.len(var_135_13) / 11)) > 0 and var_135_12 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_11 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_11
					end
				end

				arg_132_1.text_.text = var_135_13
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_12, arg_132_1.talkMaxDuration)

			if var_135_11 <= arg_132_1.time_ and arg_132_1.time_ < var_135_11 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_11) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_11 + var_135_16 and arg_132_1.time_ < var_135_11 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
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
	Play938021033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938021033
		arg_136_1.duration_ = 1

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"

			SetActive(arg_136_1.choicesGo_, true)

			for iter_137_0, iter_137_1 in ipairs(arg_136_1.choices_) do
				SetActive(iter_137_1.go, iter_137_0 <= 2)
			end

			arg_136_1.choices_[1].txt.text = arg_136_1:FormatText(StoryChoiceCfg[1780].name)
			arg_136_1.choices_[2].txt.text = arg_136_1:FormatText(StoryChoiceCfg[1781].name)
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938021034(arg_136_1)
			end

			if arg_138_0 == 2 then
				arg_136_0:Play938021034(arg_136_1)
			end

			arg_136_1:RecordChoiceLog(938021033, 1780, 1781)
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["104902"]) and arg_136_1.var_.actorSpriteComps104902 == nil then
				arg_136_1.var_.actorSpriteComps104902 = arg_136_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["104902"]) then
				if arg_136_1.var_.actorSpriteComps104902 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["104902"]) and arg_136_1.var_.actorSpriteComps104902 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps104902 = nil
			end

			local var_139_2 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= var_139_2 + 0.6 and arg_136_1.time_ < var_139_2 + 0.6 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play938021034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938021034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938021035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.65

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(938021034).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 26 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 26)

				if (26 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 26)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play938021035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938021035
		arg_144_1.duration_ = 9

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938021036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 2 < arg_144_1.time_ and arg_144_1.time_ <= 2 + arg_147_0 then
				local var_147_0 = arg_144_1.bgs_.ST0119

				arg_144_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_147_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_1 = var_147_0:GetComponent("SpriteRenderer")

				if var_147_1 and var_147_1.sprite then
					local var_147_2 = 2 * (var_147_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_147_0.transform.localScale = Vector3.New(var_147_2 / var_147_1.sprite.bounds.size.y < var_147_2 * manager.ui.mainCameraCom_.aspect / var_147_1.sprite.bounds.size.x and var_147_2 * manager.ui.mainCameraCom_.aspect / var_147_1.sprite.bounds.size.x or var_147_2 / var_147_1.sprite.bounds.size.y, var_147_2 / var_147_1.sprite.bounds.size.y < var_147_2 * manager.ui.mainCameraCom_.aspect / var_147_1.sprite.bounds.size.x and var_147_2 * manager.ui.mainCameraCom_.aspect / var_147_1.sprite.bounds.size.x or var_147_2 / var_147_1.sprite.bounds.size.y, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "ST0119" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_147_3 = 4

			if 4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_3 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			if arg_144_1.time_ >= var_147_3 + 0.3 and arg_144_1.time_ < var_147_3 + 0.3 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			local var_147_4 = 0

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_5 = 2

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_5 then
				local var_147_6 = Color.New(0, 0, 0)

				var_147_6.a = Mathf.Lerp(0, 1, (arg_144_1.time_ - var_147_4) / var_147_5)
				arg_144_1.mask_.color = var_147_6
			end

			if arg_144_1.time_ >= var_147_4 + var_147_5 and arg_144_1.time_ < var_147_4 + var_147_5 + arg_147_0 then
				local var_147_7 = Color.New(0, 0, 0)

				var_147_7.a = 1
				arg_144_1.mask_.color = var_147_7
			end

			local var_147_8 = 2

			if 2 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_9 = 2

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_9 then
				local var_147_10 = Color.New(0, 0, 0)

				var_147_10.a = Mathf.Lerp(1, 0, (arg_144_1.time_ - var_147_8) / var_147_9)
				arg_144_1.mask_.color = var_147_10
			end

			if arg_144_1.time_ >= var_147_8 + var_147_9 and arg_144_1.time_ < var_147_8 + var_147_9 + arg_147_0 then
				local var_147_11 = Color.New(0, 0, 0)

				arg_144_1.mask_.enabled = false
				var_147_11.a = 0
				arg_144_1.mask_.color = var_147_11
			end

			local var_147_12 = arg_144_1.actors_["104902"].transform

			if 1.966 < arg_144_1.time_ and arg_144_1.time_ <= 1.966 + arg_147_0 then
				arg_144_1.var_.moveOldPos104902 = var_147_12.localPosition
				var_147_12.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("104902", 7)

				for iter_147_2 = 0, var_147_12.childCount - 1 do
					local var_147_13 = var_147_12:GetChild(iter_147_2)

					if var_147_13.name == "" or not string.find(var_147_13.name, "split") then
						var_147_13.gameObject:SetActive(true)
					else
						var_147_13.gameObject:SetActive(false)
					end
				end
			end

			local var_147_14 = 0.001

			if 1.966 <= arg_144_1.time_ and arg_144_1.time_ < 1.966 + var_147_14 then
				var_147_12.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_144_1.time_ - 1.966) / var_147_14)
			end

			if arg_144_1.time_ >= 1.966 + var_147_14 and arg_144_1.time_ < 1.966 + var_147_14 + arg_147_0 then
				var_147_12.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_147_15 = arg_144_1.actors_["128404"].transform

			if 1.966 < arg_144_1.time_ and arg_144_1.time_ <= 1.966 + arg_147_0 then
				arg_144_1.var_.moveOldPos128404 = var_147_15.localPosition
				var_147_15.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("128404", 7)

				for iter_147_3 = 0, var_147_15.childCount - 1 do
					local var_147_16 = var_147_15:GetChild(iter_147_3)

					if var_147_16.name == "" or not string.find(var_147_16.name, "split") then
						var_147_16.gameObject:SetActive(true)
					else
						var_147_16.gameObject:SetActive(false)
					end
				end
			end

			local var_147_17 = 0.001

			if 1.966 <= arg_144_1.time_ and arg_144_1.time_ < 1.966 + var_147_17 then
				var_147_15.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 1.966) / var_147_17)
			end

			if arg_144_1.time_ >= 1.966 + var_147_17 and arg_144_1.time_ < 1.966 + var_147_17 + arg_147_0 then
				var_147_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_18 = 4
			local var_147_19 = 1.25

			if 4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_20 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_20:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_21 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(938021035).content)

				arg_144_1.text_.text = var_147_21

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_23 = 50 <= 0 and var_147_19 or var_147_19 * (utf8.len(var_147_21) / 50)

				if (50 <= 0 and var_147_19 or var_147_19 * (utf8.len(var_147_21) / 50)) > 0 and var_147_19 < var_147_23 then
					arg_144_1.talkMaxDuration = var_147_23
					var_147_18 = var_147_18 + 0.3

					if var_147_23 + var_147_18 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_18
					end
				end

				arg_144_1.text_.text = var_147_21
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_24 = var_147_18 + 0.3
			local var_147_25 = math.max(var_147_19, arg_144_1.talkMaxDuration)

			if var_147_18 + 0.3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_24 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_24) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_24 + var_147_25 and arg_144_1.time_ < var_147_24 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play938021036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 938021036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play938021037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10144"]) and arg_150_1.var_.actorSpriteComps10144 == nil then
				arg_150_1.var_.actorSpriteComps10144 = arg_150_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10144"]) then
				if arg_150_1.var_.actorSpriteComps10144 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10144"]) and arg_150_1.var_.actorSpriteComps10144 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps10144 = nil
			end

			local var_153_2 = arg_150_1.actors_["10144"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10144 = var_153_2.localPosition
				var_153_2.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("10144", 3)

				for iter_153_4 = 0, var_153_2.childCount - 1 do
					local var_153_3 = var_153_2:GetChild(iter_153_4)

					if var_153_3.name == "split_2" or not string.find(var_153_3.name, "split") then
						var_153_3.gameObject:SetActive(true)
					else
						var_153_3.gameObject:SetActive(false)
					end
				end
			end

			local var_153_4 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				var_153_2.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_150_1.time_ - 0) / var_153_4)
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				var_153_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				local var_153_5 = arg_150_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_153_5 then
					arg_150_1.var_.alphaOldValue10144 = var_153_5.alpha
					arg_150_1.var_.characterEffect10144 = var_153_5
				end

				arg_150_1.var_.alphaOldValue10144 = 0
			end

			local var_153_6 = 0.0333333333333333

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 then
				if arg_150_1.var_.characterEffect10144 then
					arg_150_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_150_1.var_.alphaOldValue10144, 1, (arg_150_1.time_ - 0) / var_153_6)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and arg_150_1.var_.characterEffect10144 then
				arg_150_1.var_.characterEffect10144.alpha = 1
			end

			local var_153_7 = 0
			local var_153_8 = 0.95

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_9 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(938021036).content)

				arg_150_1.text_.text = var_153_9

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 38 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_9) / 38)

				if (38 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_9) / 38)) > 0 and var_153_8 < var_153_11 then
					arg_150_1.talkMaxDuration = var_153_11

					if var_153_11 + var_153_7 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_7
					end
				end

				arg_150_1.text_.text = var_153_9
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_8, arg_150_1.talkMaxDuration)

			if var_153_7 <= arg_150_1.time_ and arg_150_1.time_ < var_153_7 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_7) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_7 + var_153_12 and arg_150_1.time_ < var_153_7 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play938021037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938021037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938021038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10144 = arg_154_1.actors_["10144"].transform.localPosition
				arg_154_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("10144", 3)

				for iter_157_0 = 0, arg_154_1.actors_["10144"].transform.childCount - 1 do
					local var_157_0 = arg_154_1.actors_["10144"].transform:GetChild(iter_157_0)

					if var_157_0.name == "split_1" then
						var_157_0:SetAsLastSibling()
						var_157_0.gameObject:SetActive(true)

						arg_154_1.var_.actorSpriteSplit10144 = var_157_0.gameObject:GetComponent(typeof(Image))

						arg_154_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_157_1 = 0.5

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_154_1.time_ - 0) / var_157_1)

				if arg_154_1.var_.actorSpriteSplit10144 ~= nil then
					arg_154_1.var_.actorSpriteSplit10144:SetAlpha((arg_154_1.time_ - 0) / var_157_1)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_154_1.var_.actorSpriteSplit10144 ~= nil then
					arg_154_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_157_2 = 0
			local var_157_3 = 0.625

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_4 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(938021037).content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_6 = 25 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 25)

				if (25 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 25)) > 0 and var_157_3 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_2 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_2
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_3, arg_154_1.talkMaxDuration)

			if var_157_2 <= arg_154_1.time_ and arg_154_1.time_ < var_157_2 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_2) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_2 + var_157_7 and arg_154_1.time_ < var_157_2 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play938021038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938021038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938021039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10144"]) and arg_158_1.var_.actorSpriteComps10144 == nil then
				arg_158_1.var_.actorSpriteComps10144 = arg_158_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10144"]) then
				if arg_158_1.var_.actorSpriteComps10144 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 0.5, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10144"]) and arg_158_1.var_.actorSpriteComps10144 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps10144 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.125

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_4 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(938021038).content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 5 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 5)

				if (5 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 5)) > 0 and var_161_3 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_7 and arg_158_1.time_ < var_161_2 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play938021039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938021039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938021040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.35

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(938021039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 54 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 54)

				if (54 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 54)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938021040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938021040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938021041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10144"]) and arg_166_1.var_.actorSpriteComps10144 == nil then
				arg_166_1.var_.actorSpriteComps10144 = arg_166_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10144"]) then
				if arg_166_1.var_.actorSpriteComps10144 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 1, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10144"]) and arg_166_1.var_.actorSpriteComps10144 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10144 = nil
			end

			local var_169_2 = arg_166_1.actors_["10144"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10144 = var_169_2.localPosition
				var_169_2.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10144", 3)

				for iter_169_4 = 0, var_169_2.childCount - 1 do
					local var_169_3 = var_169_2:GetChild(iter_169_4)

					if var_169_3.name == "" or not string.find(var_169_3.name, "split") then
						var_169_3.gameObject:SetActive(true)
					else
						var_169_3.gameObject:SetActive(false)
					end
				end
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_166_1.time_ - 0) / var_169_4)
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_169_5 = 0
			local var_169_6 = 0.975

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(938021040).content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 39 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 39)

				if (39 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 39)) > 0 and var_169_6 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_10 and arg_166_1.time_ < var_169_5 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play938021041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938021041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938021042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10144"]) and arg_170_1.var_.actorSpriteComps10144 == nil then
				arg_170_1.var_.actorSpriteComps10144 = arg_170_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10144"]) then
				if arg_170_1.var_.actorSpriteComps10144 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10144"]) and arg_170_1.var_.actorSpriteComps10144 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps10144 = nil
			end

			local var_173_2 = 0
			local var_173_3 = 0.225

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_4 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(938021041).content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 9 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_4) / 9)

				if (9 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_4) / 9)) > 0 and var_173_3 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_7 and arg_170_1.time_ < var_173_2 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play938021042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938021042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938021043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10144"]) and arg_174_1.var_.actorSpriteComps10144 == nil then
				arg_174_1.var_.actorSpriteComps10144 = arg_174_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10144"]) then
				if arg_174_1.var_.actorSpriteComps10144 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10144"]) and arg_174_1.var_.actorSpriteComps10144 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_2 = arg_174_1.actors_["10144"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10144 = var_177_2.localPosition
				var_177_2.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10144", 3)

				for iter_177_4 = 0, var_177_2.childCount - 1 do
					local var_177_3 = var_177_2:GetChild(iter_177_4)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_2.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_174_1.time_ - 0) / var_177_4)
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_177_5 = 0
			local var_177_6 = 1.6

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(938021042).content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 64 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_7) / 64)

				if (64 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_7) / 64)) > 0 and var_177_6 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_10 and arg_174_1.time_ < var_177_5 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play938021043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938021043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938021044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = arg_178_1.actors_["10144"].transform.localPosition
				arg_178_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 3)

				for iter_181_0 = 0, arg_178_1.actors_["10144"].transform.childCount - 1 do
					local var_181_0 = arg_178_1.actors_["10144"].transform:GetChild(iter_181_0)

					if var_181_0.name == "" or not string.find(var_181_0.name, "split") then
						var_181_0.gameObject:SetActive(true)
					else
						var_181_0.gameObject:SetActive(false)
					end
				end
			end

			local var_181_1 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_1 then
				arg_178_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_178_1.time_ - 0) / var_181_1)
			end

			if arg_178_1.time_ >= 0 + var_181_1 and arg_178_1.time_ < 0 + var_181_1 + arg_181_0 then
				arg_178_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_181_2 = 0
			local var_181_3 = 1.075

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(938021043).content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 43 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 43)

				if (43 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 43)) > 0 and var_181_3 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_7 and arg_178_1.time_ < var_181_2 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play938021044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 938021044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play938021045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10144"]) and arg_182_1.var_.actorSpriteComps10144 == nil then
				arg_182_1.var_.actorSpriteComps10144 = arg_182_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10144"]) then
				if arg_182_1.var_.actorSpriteComps10144 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10144"]) and arg_182_1.var_.actorSpriteComps10144 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps10144 = nil
			end

			local var_185_2 = arg_182_1.actors_["10144"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10144 = var_185_2.localPosition
				var_185_2.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10144", 7)

				for iter_185_4 = 0, var_185_2.childCount - 1 do
					local var_185_3 = var_185_2:GetChild(iter_185_4)

					if var_185_3.name == "" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_2.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_182_1.time_ - 0) / var_185_4)
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_185_5 = 0
			local var_185_6 = 1.55

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(938021044).content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 62 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_7) / 62)

				if (62 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_7) / 62)) > 0 and var_185_6 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_10 and arg_182_1.time_ < var_185_5 + var_185_10 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play938021045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 938021045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play938021046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(938021045).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 22 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 22)

				if (22 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 22)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play938021046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 938021046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play938021047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10144"]) and arg_190_1.var_.actorSpriteComps10144 == nil then
				arg_190_1.var_.actorSpriteComps10144 = arg_190_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10144"]) then
				if arg_190_1.var_.actorSpriteComps10144 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 1, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10144"]) and arg_190_1.var_.actorSpriteComps10144 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps10144 = nil
			end

			local var_193_2 = arg_190_1.actors_["10144"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos10144 = var_193_2.localPosition
				var_193_2.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("10144", 3)

				for iter_193_4 = 0, var_193_2.childCount - 1 do
					local var_193_3 = var_193_2:GetChild(iter_193_4)

					if var_193_3.name == "split_7" or not string.find(var_193_3.name, "split") then
						var_193_3.gameObject:SetActive(true)
					else
						var_193_3.gameObject:SetActive(false)
					end
				end
			end

			local var_193_4 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				var_193_2.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_190_1.time_ - 0) / var_193_4)
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				var_193_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_193_5 = 0
			local var_193_6 = 1

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_7 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(938021046).content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 40 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_7) / 40)

				if (40 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_7) / 40)) > 0 and var_193_6 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_5
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_6, arg_190_1.talkMaxDuration)

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_5) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_5 + var_193_10 and arg_190_1.time_ < var_193_5 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play938021047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 938021047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play938021048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["10144"]) and arg_194_1.var_.actorSpriteComps10144 == nil then
				arg_194_1.var_.actorSpriteComps10144 = arg_194_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["10144"]) then
				if arg_194_1.var_.actorSpriteComps10144 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor2.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor2.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor2.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 0.5, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10144"]) and arg_194_1.var_.actorSpriteComps10144 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_194_1.var_.actorSpriteComps10144 = nil
			end

			local var_197_2 = 0
			local var_197_3 = 0.875

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_4 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(938021047).content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_6 = 35 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_4) / 35)

				if (35 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_4) / 35)) > 0 and var_197_3 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_7 and arg_194_1.time_ < var_197_2 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play938021048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 938021048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play938021049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10144"]) and arg_198_1.var_.actorSpriteComps10144 == nil then
				arg_198_1.var_.actorSpriteComps10144 = arg_198_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10144"]) then
				if arg_198_1.var_.actorSpriteComps10144 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10144"]) and arg_198_1.var_.actorSpriteComps10144 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps10144 = nil
			end

			local var_201_2 = arg_198_1.actors_["10144"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10144 = var_201_2.localPosition
				var_201_2.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10144", 3)

				for iter_201_4 = 0, var_201_2.childCount - 1 do
					local var_201_3 = var_201_2:GetChild(iter_201_4)

					if var_201_3.name == "split_1" then
						var_201_3:SetAsLastSibling()
						var_201_3.gameObject:SetActive(true)

						arg_198_1.var_.actorSpriteSplit10144 = var_201_3.gameObject:GetComponent(typeof(Image))

						arg_198_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_201_4 = 0.5

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				var_201_2.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_198_1.time_ - 0) / var_201_4)

				if arg_198_1.var_.actorSpriteSplit10144 ~= nil then
					arg_198_1.var_.actorSpriteSplit10144:SetAlpha((arg_198_1.time_ - 0) / var_201_4)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				var_201_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_198_1.var_.actorSpriteSplit10144 ~= nil then
					arg_198_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_201_5 = 0
			local var_201_6 = 1.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(938021048).content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 63 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 63)

				if (63 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_7) / 63)) > 0 and var_201_6 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_10 and arg_198_1.time_ < var_201_5 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play938021049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 938021049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play938021050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10144 = arg_202_1.actors_["10144"].transform.localPosition
				arg_202_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10144", 3)

				for iter_205_0 = 0, arg_202_1.actors_["10144"].transform.childCount - 1 do
					local var_205_0 = arg_202_1.actors_["10144"].transform:GetChild(iter_205_0)

					if var_205_0.name == "" or not string.find(var_205_0.name, "split") then
						var_205_0.gameObject:SetActive(true)
					else
						var_205_0.gameObject:SetActive(false)
					end
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_202_1.time_ - 0) / var_205_1)
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_205_2 = 0
			local var_205_3 = 1.1

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(938021049).content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_6 = 44 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_4) / 44)

				if (44 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_4) / 44)) > 0 and var_205_3 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_7 and arg_202_1.time_ < var_205_2 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938021050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938021051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10144"]) and arg_206_1.var_.actorSpriteComps10144 == nil then
				arg_206_1.var_.actorSpriteComps10144 = arg_206_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10144"]) then
				if arg_206_1.var_.actorSpriteComps10144 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10144"]) and arg_206_1.var_.actorSpriteComps10144 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps10144 = nil
			end

			local var_209_2 = 0
			local var_209_3 = 0.65

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_4 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(938021050).content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 26 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 26)

				if (26 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 26)) > 0 and var_209_3 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_7 and arg_206_1.time_ < var_209_2 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play938021051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938021051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938021052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10144"]) and arg_210_1.var_.actorSpriteComps10144 == nil then
				arg_210_1.var_.actorSpriteComps10144 = arg_210_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10144"]) then
				if arg_210_1.var_.actorSpriteComps10144 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10144"]) and arg_210_1.var_.actorSpriteComps10144 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10144 = nil
			end

			local var_213_2 = arg_210_1.actors_["10144"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10144 = var_213_2.localPosition
				var_213_2.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10144", 3)

				for iter_213_4 = 0, var_213_2.childCount - 1 do
					local var_213_3 = var_213_2:GetChild(iter_213_4)

					if var_213_3.name == "split_2" then
						var_213_3:SetAsLastSibling()
						var_213_3.gameObject:SetActive(true)

						arg_210_1.var_.actorSpriteSplit10144 = var_213_3.gameObject:GetComponent(typeof(Image))

						arg_210_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_213_4 = 0.5

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				var_213_2.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_210_1.time_ - 0) / var_213_4)

				if arg_210_1.var_.actorSpriteSplit10144 ~= nil then
					arg_210_1.var_.actorSpriteSplit10144:SetAlpha((arg_210_1.time_ - 0) / var_213_4)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				var_213_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_210_1.var_.actorSpriteSplit10144 ~= nil then
					arg_210_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_213_5 = 0
			local var_213_6 = 0.675

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(938021051).content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 27 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 27)

				if (27 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 27)) > 0 and var_213_6 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_10 and arg_210_1.time_ < var_213_5 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play938021052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938021052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938021053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 1.375

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(938021052).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 55 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 55)

				if (55 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 55)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play938021053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938021053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938021054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10144 = arg_218_1.actors_["10144"].transform.localPosition
				arg_218_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10144", 3)

				for iter_221_0 = 0, arg_218_1.actors_["10144"].transform.childCount - 1 do
					local var_221_0 = arg_218_1.actors_["10144"].transform:GetChild(iter_221_0)

					if var_221_0.name == "" then
						var_221_0:SetAsLastSibling()
						var_221_0.gameObject:SetActive(true)

						arg_218_1.var_.actorSpriteSplit10144 = var_221_0.gameObject:GetComponent(typeof(Image))

						arg_218_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_221_1 = 0.5

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_218_1.time_ - 0) / var_221_1)

				if arg_218_1.var_.actorSpriteSplit10144 ~= nil then
					arg_218_1.var_.actorSpriteSplit10144:SetAlpha((arg_218_1.time_ - 0) / var_221_1)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_218_1.var_.actorSpriteSplit10144 ~= nil then
					arg_218_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_221_2 = 0
			local var_221_3 = 0.75

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(938021053).content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 30 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 30)

				if (30 <= 0 and var_221_3 or var_221_3 * (utf8.len(var_221_4) / 30)) > 0 and var_221_3 < var_221_6 then
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938021054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938021054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938021055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10144"]) and arg_222_1.var_.actorSpriteComps10144 == nil then
				arg_222_1.var_.actorSpriteComps10144 = arg_222_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10144"]) then
				if arg_222_1.var_.actorSpriteComps10144 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10144"]) and arg_222_1.var_.actorSpriteComps10144 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10144 = nil
			end

			local var_225_2 = 0
			local var_225_3 = 0.55

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

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_4 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(938021054).content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_6 = 22 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_4) / 22)

				if (22 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_4) / 22)) > 0 and var_225_3 < var_225_6 then
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
	Play938021055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938021055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play938021056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10144"]) and arg_226_1.var_.actorSpriteComps10144 == nil then
				arg_226_1.var_.actorSpriteComps10144 = arg_226_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10144"]) then
				if arg_226_1.var_.actorSpriteComps10144 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10144"]) and arg_226_1.var_.actorSpriteComps10144 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10144 = nil
			end

			local var_229_2 = arg_226_1.actors_["10144"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10144 = var_229_2.localPosition
				var_229_2.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10144", 3)

				for iter_229_4 = 0, var_229_2.childCount - 1 do
					local var_229_3 = var_229_2:GetChild(iter_229_4)

					if var_229_3.name == "split_2" or not string.find(var_229_3.name, "split") then
						var_229_3.gameObject:SetActive(true)
					else
						var_229_3.gameObject:SetActive(false)
					end
				end
			end

			local var_229_4 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				var_229_2.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_226_1.time_ - 0) / var_229_4)
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				var_229_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_229_5 = 0
			local var_229_6 = 1.25

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_7 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(938021055).content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 50 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_7) / 50)

				if (50 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_7) / 50)) > 0 and var_229_6 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_10 and arg_226_1.time_ < var_229_5 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 938021056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play938021057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10144"]) and arg_230_1.var_.actorSpriteComps10144 == nil then
				arg_230_1.var_.actorSpriteComps10144 = arg_230_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10144"]) then
				if arg_230_1.var_.actorSpriteComps10144 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10144"]) and arg_230_1.var_.actorSpriteComps10144 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10144 = nil
			end

			local var_233_2 = 0
			local var_233_3 = 0.7

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_4 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(938021056).content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_6 = 28 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 28)

				if (28 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 28)) > 0 and var_233_3 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_7 and arg_230_1.time_ < var_233_2 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play938021057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 938021057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play938021058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10144"]) and arg_234_1.var_.actorSpriteComps10144 == nil then
				arg_234_1.var_.actorSpriteComps10144 = arg_234_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10144"]) then
				if arg_234_1.var_.actorSpriteComps10144 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10144"]) and arg_234_1.var_.actorSpriteComps10144 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10144 = nil
			end

			local var_237_2 = arg_234_1.actors_["10144"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10144 = var_237_2.localPosition
				var_237_2.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10144", 3)

				for iter_237_4 = 0, var_237_2.childCount - 1 do
					local var_237_3 = var_237_2:GetChild(iter_237_4)

					if var_237_3.name == "split_1" then
						var_237_3:SetAsLastSibling()
						var_237_3.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit10144 = var_237_3.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_237_4 = 0.5

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				var_237_2.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_234_1.time_ - 0) / var_237_4)

				if arg_234_1.var_.actorSpriteSplit10144 ~= nil then
					arg_234_1.var_.actorSpriteSplit10144:SetAlpha((arg_234_1.time_ - 0) / var_237_4)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				var_237_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_234_1.var_.actorSpriteSplit10144 ~= nil then
					arg_234_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_237_5 = 0
			local var_237_6 = 1.5

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(938021057).content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 60 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 60)

				if (60 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 60)) > 0 and var_237_6 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_5
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_6, arg_234_1.talkMaxDuration)

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_5) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_5 + var_237_10 and arg_234_1.time_ < var_237_5 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play938021058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 938021058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play938021059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10144"]) and arg_238_1.var_.actorSpriteComps10144 == nil then
				arg_238_1.var_.actorSpriteComps10144 = arg_238_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10144"]) then
				if arg_238_1.var_.actorSpriteComps10144 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10144"]) and arg_238_1.var_.actorSpriteComps10144 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps10144 = nil
			end

			local var_241_2 = 0
			local var_241_3 = 0.275

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_4 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(938021058).content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 11 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 11)

				if (11 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 11)) > 0 and var_241_3 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_7 and arg_238_1.time_ < var_241_2 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play938021059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 938021059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play938021060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10144"]) and arg_242_1.var_.actorSpriteComps10144 == nil then
				arg_242_1.var_.actorSpriteComps10144 = arg_242_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10144"]) then
				if arg_242_1.var_.actorSpriteComps10144 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10144"]) and arg_242_1.var_.actorSpriteComps10144 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps10144 = nil
			end

			local var_245_2 = arg_242_1.actors_["10144"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10144 = var_245_2.localPosition
				var_245_2.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10144", 3)

				for iter_245_4 = 0, var_245_2.childCount - 1 do
					local var_245_3 = var_245_2:GetChild(iter_245_4)

					if var_245_3.name == "" or not string.find(var_245_3.name, "split") then
						var_245_3.gameObject:SetActive(true)
					else
						var_245_3.gameObject:SetActive(false)
					end
				end
			end

			local var_245_4 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				var_245_2.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_242_1.time_ - 0) / var_245_4)
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				var_245_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_245_5 = 0
			local var_245_6 = 0.175

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_7 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(938021059).content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 7 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_7) / 7)

				if (7 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_7) / 7)) > 0 and var_245_6 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_5
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_6, arg_242_1.talkMaxDuration)

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_5) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_5 + var_245_10 and arg_242_1.time_ < var_245_5 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 938021060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play938021061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["10144"]) and arg_246_1.var_.actorSpriteComps10144 == nil then
				arg_246_1.var_.actorSpriteComps10144 = arg_246_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["10144"]) then
				if arg_246_1.var_.actorSpriteComps10144 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["10144"]) and arg_246_1.var_.actorSpriteComps10144 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps10144 = nil
			end

			local var_249_2 = 0
			local var_249_3 = 0.4

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

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(938021060).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 16 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 16)

				if (16 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 16)) > 0 and var_249_3 < var_249_6 then
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
	Play938021061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938021061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938021062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10144 = arg_250_1.actors_["10144"].transform.localPosition
				arg_250_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10144", 7)

				for iter_253_0 = 0, arg_250_1.actors_["10144"].transform.childCount - 1 do
					local var_253_0 = arg_250_1.actors_["10144"].transform:GetChild(iter_253_0)

					if var_253_0.name == "" or not string.find(var_253_0.name, "split") then
						var_253_0.gameObject:SetActive(true)
					else
						var_253_0.gameObject:SetActive(false)
					end
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_250_1.time_ - 0) / var_253_1)
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_253_2 = 0
			local var_253_3 = 1.5

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(938021061).content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 60 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 60)

				if (60 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 60)) > 0 and var_253_3 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_7 and arg_250_1.time_ < var_253_2 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938021062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938021062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938021063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if arg_254_1.actors_["104701"] == nil then
				local var_257_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_257_0) then
					local var_257_1 = Object.Instantiate(var_257_0, arg_254_1.canvasGo_.transform)

					var_257_1.transform:SetSiblingIndex(1)

					var_257_1.name = "104701"
					var_257_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_254_1.actors_["104701"] = var_257_1

					if arg_254_1.isInRecall_ then
						for iter_257_0, iter_257_1 in ipairs((var_257_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_257_1.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_257_2 = arg_254_1.actors_["104701"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps104701 == nil then
				arg_254_1.var_.actorSpriteComps104701 = var_257_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_3 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.actorSpriteComps104701 then
					for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_257_3 then
							if arg_254_1.isInRecall_ then
								iter_257_3.color = Color.New(Mathf.Lerp(iter_257_3.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_3), Mathf.Lerp(iter_257_3.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_3), (Mathf.Lerp(iter_257_3.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_3)))
							else
								local var_257_4 = Mathf.Lerp(iter_257_3.color.r, 1, (arg_254_1.time_ - 0) / var_257_3)

								iter_257_3.color = Color.New(var_257_4, var_257_4, var_257_4)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps104701 then
				for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_257_5 then
						iter_257_5.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps104701 = nil
			end

			local var_257_5 = arg_254_1.actors_["104701"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos104701 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("104701", 2)

				for iter_257_6 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_6)

					if var_257_6.name == "split_1" or not string.find(var_257_6.name, "split") then
						var_257_6.gameObject:SetActive(true)
					else
						var_257_6.gameObject:SetActive(false)
					end
				end
			end

			local var_257_7 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_254_1.time_ - 0) / var_257_7)
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				local var_257_8 = arg_254_1.actors_["104701"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_257_8 then
					arg_254_1.var_.alphaOldValue104701 = var_257_8.alpha
					arg_254_1.var_.characterEffect104701 = var_257_8
				end

				arg_254_1.var_.alphaOldValue104701 = 0
			end

			local var_257_9 = 0.5

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_9 then
				if arg_254_1.var_.characterEffect104701 then
					arg_254_1.var_.characterEffect104701.alpha = Mathf.Lerp(arg_254_1.var_.alphaOldValue104701, 1, (arg_254_1.time_ - 0) / var_257_9)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_9 and arg_254_1.time_ < 0 + var_257_9 + arg_257_0 and arg_254_1.var_.characterEffect104701 then
				arg_254_1.var_.characterEffect104701.alpha = 1
			end

			local var_257_10 = 0
			local var_257_11 = 1.025

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_12 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(938021062).content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_14 = 41 <= 0 and var_257_11 or var_257_11 * (utf8.len(var_257_12) / 41)

				if (41 <= 0 and var_257_11 or var_257_11 * (utf8.len(var_257_12) / 41)) > 0 and var_257_11 < var_257_14 then
					arg_254_1.talkMaxDuration = var_257_14

					if var_257_14 + var_257_10 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_10
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_15 = math.max(var_257_11, arg_254_1.talkMaxDuration)

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_15 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_10) / var_257_15

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_10 + var_257_15 and arg_254_1.time_ < var_257_10 + var_257_15 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
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
	Play938021063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938021063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938021064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["128404"]) and arg_258_1.var_.actorSpriteComps128404 == nil then
				arg_258_1.var_.actorSpriteComps128404 = arg_258_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["128404"]) then
				if arg_258_1.var_.actorSpriteComps128404 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["128404"]) and arg_258_1.var_.actorSpriteComps128404 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps128404 = nil
			end

			local var_261_2 = arg_258_1.actors_["104701"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps104701 == nil then
				arg_258_1.var_.actorSpriteComps104701 = var_261_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_3 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 and not isNil(var_261_2) then
				if arg_258_1.var_.actorSpriteComps104701 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps104701 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_261_7 then
						iter_261_7.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps104701 = nil
			end

			local var_261_5 = arg_258_1.actors_["128404"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos128404 = var_261_5.localPosition
				var_261_5.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("128404", 4)

				for iter_261_8 = 0, var_261_5.childCount - 1 do
					local var_261_6 = var_261_5:GetChild(iter_261_8)

					if var_261_6.name == "split_3" or not string.find(var_261_6.name, "split") then
						var_261_6.gameObject:SetActive(true)
					else
						var_261_6.gameObject:SetActive(false)
					end
				end
			end

			local var_261_7 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_258_1.time_ - 0) / var_261_7)
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				local var_261_8 = arg_258_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_261_8 then
					arg_258_1.var_.alphaOldValue128404 = var_261_8.alpha
					arg_258_1.var_.characterEffect128404 = var_261_8
				end

				arg_258_1.var_.alphaOldValue128404 = 0
			end

			local var_261_9 = 0.5

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_9 then
				if arg_258_1.var_.characterEffect128404 then
					arg_258_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_258_1.var_.alphaOldValue128404, 1, (arg_258_1.time_ - 0) / var_261_9)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_9 and arg_258_1.time_ < 0 + var_261_9 + arg_261_0 and arg_258_1.var_.characterEffect128404 then
				arg_258_1.var_.characterEffect128404.alpha = 1
			end

			local var_261_10 = 0
			local var_261_11 = 1.35

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_12 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(938021063).content)

				arg_258_1.text_.text = var_261_12

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_14 = 54 <= 0 and var_261_11 or var_261_11 * (utf8.len(var_261_12) / 54)

				if (54 <= 0 and var_261_11 or var_261_11 * (utf8.len(var_261_12) / 54)) > 0 and var_261_11 < var_261_14 then
					arg_258_1.talkMaxDuration = var_261_14

					if var_261_14 + var_261_10 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_10
					end
				end

				arg_258_1.text_.text = var_261_12
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_11, arg_258_1.talkMaxDuration)

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_10) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_10 + var_261_15 and arg_258_1.time_ < var_261_10 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938021064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938021065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["104902"]) and arg_262_1.var_.actorSpriteComps104902 == nil then
				arg_262_1.var_.actorSpriteComps104902 = arg_262_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["104902"]) then
				if arg_262_1.var_.actorSpriteComps104902 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								iter_265_1.color = Color.New(Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_0), Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_0), (Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_0)))
							else
								local var_265_1 = Mathf.Lerp(iter_265_1.color.r, 1, (arg_262_1.time_ - 0) / var_265_0)

								iter_265_1.color = Color.New(var_265_1, var_265_1, var_265_1)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["104902"]) and arg_262_1.var_.actorSpriteComps104902 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps104902 = nil
			end

			local var_265_2 = arg_262_1.actors_["128404"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = var_265_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_3 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								iter_265_5.color = Color.New(Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, (arg_262_1.time_ - 0) / var_265_3), Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, (arg_262_1.time_ - 0) / var_265_3), (Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, (arg_262_1.time_ - 0) / var_265_3)))
							else
								local var_265_4 = Mathf.Lerp(iter_265_5.color.r, 0.5, (arg_262_1.time_ - 0) / var_265_3)

								iter_265_5.color = Color.New(var_265_4, var_265_4, var_265_4)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_7 then
						iter_265_7.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_5 = arg_262_1.actors_["104902"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos104902 = var_265_5.localPosition
				var_265_5.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("104902", 3)

				for iter_265_8 = 0, var_265_5.childCount - 1 do
					local var_265_6 = var_265_5:GetChild(iter_265_8)

					if var_265_6.name == "split_2" or not string.find(var_265_6.name, "split") then
						var_265_6.gameObject:SetActive(true)
					else
						var_265_6.gameObject:SetActive(false)
					end
				end
			end

			local var_265_7 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				var_265_5.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos104902, Vector3.New(0, -335, -360), (arg_262_1.time_ - 0) / var_265_7)
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				var_265_5.localPosition = Vector3.New(0, -335, -360)
			end

			local var_265_8 = arg_262_1.actors_["104701"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos104701 = var_265_8.localPosition
				var_265_8.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("104701", 2)

				for iter_265_9 = 0, var_265_8.childCount - 1 do
					local var_265_9 = var_265_8:GetChild(iter_265_9)

					if var_265_9.name == "" or not string.find(var_265_9.name, "split") then
						var_265_9.gameObject:SetActive(true)
					else
						var_265_9.gameObject:SetActive(false)
					end
				end
			end

			local var_265_10 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_10 then
				var_265_8.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_262_1.time_ - 0) / var_265_10)
			end

			if arg_262_1.time_ >= 0 + var_265_10 and arg_262_1.time_ < 0 + var_265_10 + arg_265_0 then
				var_265_8.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				local var_265_11 = arg_262_1.actors_["104902"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_265_11 then
					arg_262_1.var_.alphaOldValue104902 = var_265_11.alpha
					arg_262_1.var_.characterEffect104902 = var_265_11
				end

				arg_262_1.var_.alphaOldValue104902 = 0
			end

			local var_265_12 = 0.5

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_12 then
				if arg_262_1.var_.characterEffect104902 then
					arg_262_1.var_.characterEffect104902.alpha = Mathf.Lerp(arg_262_1.var_.alphaOldValue104902, 1, (arg_262_1.time_ - 0) / var_265_12)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_12 and arg_262_1.time_ < 0 + var_265_12 + arg_265_0 and arg_262_1.var_.characterEffect104902 then
				arg_262_1.var_.characterEffect104902.alpha = 1
			end

			local var_265_13 = 0
			local var_265_14 = 0.975

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_15 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(938021064).content)

				arg_262_1.text_.text = var_265_15

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_17 = 39 <= 0 and var_265_14 or var_265_14 * (utf8.len(var_265_15) / 39)

				if (39 <= 0 and var_265_14 or var_265_14 * (utf8.len(var_265_15) / 39)) > 0 and var_265_14 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_13 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_13
					end
				end

				arg_262_1.text_.text = var_265_15
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_18 = math.max(var_265_14, arg_262_1.talkMaxDuration)

			if var_265_13 <= arg_262_1.time_ and arg_262_1.time_ < var_265_13 + var_265_18 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_13) / var_265_18

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_13 + var_265_18 and arg_262_1.time_ < var_265_13 + var_265_18 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
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
	Play938021065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938021065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938021066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["104902"]) and arg_266_1.var_.actorSpriteComps104902 == nil then
				arg_266_1.var_.actorSpriteComps104902 = arg_266_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["104902"]) then
				if arg_266_1.var_.actorSpriteComps104902 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["104902"]) and arg_266_1.var_.actorSpriteComps104902 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps104902 = nil
			end

			local var_269_2 = 0
			local var_269_3 = 0.25

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

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(938021065).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 10 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 10)

				if (10 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 10)) > 0 and var_269_3 < var_269_6 then
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
	Play938021066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938021066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938021067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 1.225

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(938021066).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 49 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 49)

				if (49 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 49)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play938021067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938021067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938021068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.325

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_108301_split_5")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(938021067).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 13 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 13)

				if (13 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 13)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938021068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938021068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938021069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.475

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_4")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(938021068).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 19 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 19)

				if (19 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 19)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play938021069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 938021069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play938021070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["108301"]) and arg_282_1.var_.actorSpriteComps108301 == nil then
				arg_282_1.var_.actorSpriteComps108301 = arg_282_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["108301"]) then
				if arg_282_1.var_.actorSpriteComps108301 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["108301"]) and arg_282_1.var_.actorSpriteComps108301 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps108301 = nil
			end

			local var_285_2 = arg_282_1.actors_["106603"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps106603 == nil then
				arg_282_1.var_.actorSpriteComps106603 = var_285_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_3 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.actorSpriteComps106603 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								iter_285_5.color = Color.New(Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_3), Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_3), (Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_3)))
							else
								local var_285_4 = Mathf.Lerp(iter_285_5.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_3)

								iter_285_5.color = Color.New(var_285_4, var_285_4, var_285_4)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps106603 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_285_7 then
						iter_285_7.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps106603 = nil
			end

			local var_285_5 = arg_282_1.actors_["108301"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos108301 = var_285_5.localPosition
				var_285_5.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("108301", 2)

				for iter_285_8 = 0, var_285_5.childCount - 1 do
					local var_285_6 = var_285_5:GetChild(iter_285_8)

					if var_285_6.name == "split_2" or not string.find(var_285_6.name, "split") then
						var_285_6.gameObject:SetActive(true)
					else
						var_285_6.gameObject:SetActive(false)
					end
				end
			end

			local var_285_7 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				var_285_5.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_282_1.time_ - 0) / var_285_7)
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				var_285_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_285_8 = arg_282_1.actors_["104701"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos104701 = var_285_8.localPosition
				var_285_8.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("104701", 7)

				for iter_285_9 = 0, var_285_8.childCount - 1 do
					local var_285_9 = var_285_8:GetChild(iter_285_9)

					if var_285_9.name == "split_1" or not string.find(var_285_9.name, "split") then
						var_285_9.gameObject:SetActive(true)
					else
						var_285_9.gameObject:SetActive(false)
					end
				end
			end

			local var_285_10 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_10 then
				var_285_8.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_282_1.time_ - 0) / var_285_10)
			end

			if arg_282_1.time_ >= 0 + var_285_10 and arg_282_1.time_ < 0 + var_285_10 + arg_285_0 then
				var_285_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_11 = arg_282_1.actors_["104902"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos104902 = var_285_11.localPosition
				var_285_11.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("104902", 7)

				for iter_285_10 = 0, var_285_11.childCount - 1 do
					local var_285_12 = var_285_11:GetChild(iter_285_10)

					if var_285_12.name == "split_1" or not string.find(var_285_12.name, "split") then
						var_285_12.gameObject:SetActive(true)
					else
						var_285_12.gameObject:SetActive(false)
					end
				end
			end

			local var_285_13 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_13 then
				var_285_11.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos104902, Vector3.New(0, -2000, 0), (arg_282_1.time_ - 0) / var_285_13)
			end

			if arg_282_1.time_ >= 0 + var_285_13 and arg_282_1.time_ < 0 + var_285_13 + arg_285_0 then
				var_285_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_14 = arg_282_1.actors_["128404"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos128404 = var_285_14.localPosition
				var_285_14.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("128404", 7)

				for iter_285_11 = 0, var_285_14.childCount - 1 do
					local var_285_15 = var_285_14:GetChild(iter_285_11)

					if var_285_15.name == "split_1" or not string.find(var_285_15.name, "split") then
						var_285_15.gameObject:SetActive(true)
					else
						var_285_15.gameObject:SetActive(false)
					end
				end
			end

			local var_285_16 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_16 then
				var_285_14.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_282_1.time_ - 0) / var_285_16)
			end

			if arg_282_1.time_ >= 0 + var_285_16 and arg_282_1.time_ < 0 + var_285_16 + arg_285_0 then
				var_285_14.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_17 = 0
			local var_285_18 = 0.7

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_17 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_19 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(938021069).content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_21 = 28 <= 0 and var_285_18 or var_285_18 * (utf8.len(var_285_19) / 28)

				if (28 <= 0 and var_285_18 or var_285_18 * (utf8.len(var_285_19) / 28)) > 0 and var_285_18 < var_285_21 then
					arg_282_1.talkMaxDuration = var_285_21

					if var_285_21 + var_285_17 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_21 + var_285_17
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_18, arg_282_1.talkMaxDuration)

			if var_285_17 <= arg_282_1.time_ and arg_282_1.time_ < var_285_17 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_17) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_17 + var_285_22 and arg_282_1.time_ < var_285_17 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play938021070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 938021070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play938021071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["106603"]) and arg_286_1.var_.actorSpriteComps106603 == nil then
				arg_286_1.var_.actorSpriteComps106603 = arg_286_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["106603"]) then
				if arg_286_1.var_.actorSpriteComps106603 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["106603"]) and arg_286_1.var_.actorSpriteComps106603 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps106603 = nil
			end

			local var_289_2 = arg_286_1.actors_["108301"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps108301 == nil then
				arg_286_1.var_.actorSpriteComps108301 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps108301 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps108301 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_289_7 then
						iter_289_7.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps108301 = nil
			end

			local var_289_5 = arg_286_1.actors_["106603"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos106603 = var_289_5.localPosition
				var_289_5.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("106603", 4)

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
				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_286_1.time_ - 0) / var_289_7)
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_289_8 = 0
			local var_289_9 = 0.85

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_10 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(938021070).content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_12 = 34 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_10) / 34)

				if (34 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_10) / 34)) > 0 and var_289_9 < var_289_12 then
					arg_286_1.talkMaxDuration = var_289_12

					if var_289_12 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_12 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_13 and arg_286_1.time_ < var_289_8 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play938021071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938021071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938021072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["106603"]) and arg_290_1.var_.actorSpriteComps106603 == nil then
				arg_290_1.var_.actorSpriteComps106603 = arg_290_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["106603"]) then
				if arg_290_1.var_.actorSpriteComps106603 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["106603"]) and arg_290_1.var_.actorSpriteComps106603 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps106603 = nil
			end

			local var_293_2 = arg_290_1.actors_["106603"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos106603 = var_293_2.localPosition
				var_293_2.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("106603", 7)

				for iter_293_4 = 0, var_293_2.childCount - 1 do
					local var_293_3 = var_293_2:GetChild(iter_293_4)

					if var_293_3.name == "" or not string.find(var_293_3.name, "split") then
						var_293_3.gameObject:SetActive(true)
					else
						var_293_3.gameObject:SetActive(false)
					end
				end
			end

			local var_293_4 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				var_293_2.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_290_1.time_ - 0) / var_293_4)
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				var_293_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_5 = arg_290_1.actors_["108301"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos108301 = var_293_5.localPosition
				var_293_5.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("108301", 7)

				for iter_293_5 = 0, var_293_5.childCount - 1 do
					local var_293_6 = var_293_5:GetChild(iter_293_5)

					if var_293_6.name == "" or not string.find(var_293_6.name, "split") then
						var_293_6.gameObject:SetActive(true)
					else
						var_293_6.gameObject:SetActive(false)
					end
				end
			end

			local var_293_7 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				var_293_5.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_290_1.time_ - 0) / var_293_7)
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				var_293_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_8 = 0
			local var_293_9 = 1.425

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_10 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(938021071).content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_12 = 57 <= 0 and var_293_9 or var_293_9 * (utf8.len(var_293_10) / 57)

				if (57 <= 0 and var_293_9 or var_293_9 * (utf8.len(var_293_10) / 57)) > 0 and var_293_9 < var_293_12 then
					arg_290_1.talkMaxDuration = var_293_12

					if var_293_12 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_12 + var_293_8
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_9, arg_290_1.talkMaxDuration)

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_13 and arg_290_1.time_ < var_293_8 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play938021072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938021072
		arg_294_1.duration_ = 5.6

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938021073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_297_0 = 0.6

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				local var_297_1, var_297_2 = math.modf((arg_294_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_297_2 * 0.13, var_297_2 * 0.13, var_297_2 * 0.13) + arg_294_1.var_.shakeOldPos
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				manager.ui.mainCamera.transform.localPosition = arg_294_1.var_.shakeOldPos
			end

			local var_297_3 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_3 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			if arg_294_1.time_ >= var_297_3 + 0.6 and arg_294_1.time_ < var_297_3 + 0.6 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_4 = 0.6
			local var_297_5 = 0.525

			if 0.6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_6 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_6:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_7 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(938021072).content)

				arg_294_1.text_.text = var_297_7

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_9 = 21 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 21)

				if (21 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 21)) > 0 and var_297_5 < var_297_9 then
					arg_294_1.talkMaxDuration = var_297_9
					var_297_4 = var_297_4 + 0.3

					if var_297_9 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_9 + var_297_4
					end
				end

				arg_294_1.text_.text = var_297_7
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = var_297_4 + 0.3
			local var_297_11 = math.max(var_297_5, arg_294_1.talkMaxDuration)

			if var_297_4 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_10) / var_297_11

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play938021073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 938021073
		arg_300_1.duration_ = 9

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play938021074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 2 < arg_300_1.time_ and arg_300_1.time_ <= 2 + arg_303_0 then
				local var_303_0 = arg_300_1.bgs_.ST0119

				arg_300_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_303_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_1 = var_303_0:GetComponent("SpriteRenderer")

				if var_303_1 and var_303_1.sprite then
					local var_303_2 = 2 * (var_303_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_303_0.transform.localScale = Vector3.New(var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "ST0119" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_3 = 4

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			if arg_300_1.time_ >= var_303_3 + 0.3 and arg_300_1.time_ < var_303_3 + 0.3 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_4 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_5 = 2

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_5 then
				local var_303_6 = Color.New(0, 0, 0)

				var_303_6.a = Mathf.Lerp(0, 1, (arg_300_1.time_ - var_303_4) / var_303_5)
				arg_300_1.mask_.color = var_303_6
			end

			if arg_300_1.time_ >= var_303_4 + var_303_5 and arg_300_1.time_ < var_303_4 + var_303_5 + arg_303_0 then
				local var_303_7 = Color.New(0, 0, 0)

				var_303_7.a = 1
				arg_300_1.mask_.color = var_303_7
			end

			local var_303_8 = 2

			if 2 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_9 = 2

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_9 then
				local var_303_10 = Color.New(0, 0, 0)

				var_303_10.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_8) / var_303_9)
				arg_300_1.mask_.color = var_303_10
			end

			if arg_300_1.time_ >= var_303_8 + var_303_9 and arg_300_1.time_ < var_303_8 + var_303_9 + arg_303_0 then
				local var_303_11 = Color.New(0, 0, 0)

				arg_300_1.mask_.enabled = false
				var_303_11.a = 0
				arg_300_1.mask_.color = var_303_11
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_12 = 4
			local var_303_13 = 0.25

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_14 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_14:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_15 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(938021073).content)

				arg_300_1.text_.text = var_303_15

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_17 = 10 <= 0 and var_303_13 or var_303_13 * (utf8.len(var_303_15) / 10)

				if (10 <= 0 and var_303_13 or var_303_13 * (utf8.len(var_303_15) / 10)) > 0 and var_303_13 < var_303_17 then
					arg_300_1.talkMaxDuration = var_303_17
					var_303_12 = var_303_12 + 0.3

					if var_303_17 + var_303_12 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_17 + var_303_12
					end
				end

				arg_300_1.text_.text = var_303_15
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_18 = var_303_12 + 0.3
			local var_303_19 = math.max(var_303_13, arg_300_1.talkMaxDuration)

			if var_303_12 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_18 + var_303_19 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_18) / var_303_19

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_18 + var_303_19 and arg_300_1.time_ < var_303_18 + var_303_19 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play938021074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938021074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938021075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["108301"]) and arg_306_1.var_.actorSpriteComps108301 == nil then
				arg_306_1.var_.actorSpriteComps108301 = arg_306_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["108301"]) then
				if arg_306_1.var_.actorSpriteComps108301 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["108301"]) and arg_306_1.var_.actorSpriteComps108301 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps108301 = nil
			end

			local var_309_2 = arg_306_1.actors_["108301"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos108301 = var_309_2.localPosition
				var_309_2.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("108301", 3)

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
				var_309_2.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos108301, Vector3.New(-77.5, -399.1, -303.3), (arg_306_1.time_ - 0) / var_309_4)
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				var_309_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_309_5 = 0
			local var_309_6 = 0.45

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

				local var_309_7 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(938021074).content)

				arg_306_1.text_.text = var_309_7

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 18 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_7) / 18)

				if (18 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_7) / 18)) > 0 and var_309_6 < var_309_9 then
					arg_306_1.talkMaxDuration = var_309_9

					if var_309_9 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_5
					end
				end

				arg_306_1.text_.text = var_309_7
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_6, arg_306_1.talkMaxDuration)

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_5) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_5 + var_309_10 and arg_306_1.time_ < var_309_5 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938021075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938021075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938021076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["108301"]) and arg_310_1.var_.actorSpriteComps108301 == nil then
				arg_310_1.var_.actorSpriteComps108301 = arg_310_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["108301"]) then
				if arg_310_1.var_.actorSpriteComps108301 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["108301"]) and arg_310_1.var_.actorSpriteComps108301 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps108301 = nil
			end

			local var_313_2 = 0
			local var_313_3 = 0.625

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

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_4 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(938021075).content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 25 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 25)

				if (25 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 25)) > 0 and var_313_3 < var_313_6 then
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
	Play938021076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938021076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938021077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["108301"]) and arg_314_1.var_.actorSpriteComps108301 == nil then
				arg_314_1.var_.actorSpriteComps108301 = arg_314_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["108301"]) then
				if arg_314_1.var_.actorSpriteComps108301 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 1, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["108301"]) and arg_314_1.var_.actorSpriteComps108301 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps108301 = nil
			end

			local var_317_2 = 0
			local var_317_3 = 1.275

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(938021076).content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_6 = 51 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_4) / 51)

				if (51 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_4) / 51)) > 0 and var_317_3 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_7 and arg_314_1.time_ < var_317_2 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play938021077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938021077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play938021078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["108301"]) and arg_318_1.var_.actorSpriteComps108301 == nil then
				arg_318_1.var_.actorSpriteComps108301 = arg_318_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["108301"]) then
				if arg_318_1.var_.actorSpriteComps108301 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["108301"]) and arg_318_1.var_.actorSpriteComps108301 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps108301 = nil
			end

			local var_321_2 = 0
			local var_321_3 = 0.45

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_4 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(938021077).content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_6 = 18 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 18)

				if (18 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 18)) > 0 and var_321_3 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_7 and arg_318_1.time_ < var_321_2 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play938021078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 938021078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play938021079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["108301"]) and arg_322_1.var_.actorSpriteComps108301 == nil then
				arg_322_1.var_.actorSpriteComps108301 = arg_322_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["108301"]) then
				if arg_322_1.var_.actorSpriteComps108301 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 1, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["108301"]) and arg_322_1.var_.actorSpriteComps108301 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_322_1.var_.actorSpriteComps108301 = nil
			end

			local var_325_2 = 0
			local var_325_3 = 0.775

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(938021078).content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 31 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 31)

				if (31 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_4) / 31)) > 0 and var_325_3 < var_325_6 then
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
	Play938021079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 938021079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play938021080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["108301"]) and arg_326_1.var_.actorSpriteComps108301 == nil then
				arg_326_1.var_.actorSpriteComps108301 = arg_326_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["108301"]) then
				if arg_326_1.var_.actorSpriteComps108301 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 0.5, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["108301"]) and arg_326_1.var_.actorSpriteComps108301 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_326_1.var_.actorSpriteComps108301 = nil
			end

			local var_329_2 = 0
			local var_329_3 = 0.25

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_4 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(938021079).content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_6 = 10 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 10)

				if (10 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 10)) > 0 and var_329_3 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_7 and arg_326_1.time_ < var_329_2 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play938021080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 938021080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play938021081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["108301"]) and arg_330_1.var_.actorSpriteComps108301 == nil then
				arg_330_1.var_.actorSpriteComps108301 = arg_330_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["108301"]) then
				if arg_330_1.var_.actorSpriteComps108301 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["108301"]) and arg_330_1.var_.actorSpriteComps108301 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps108301 = nil
			end

			local var_333_2 = arg_330_1.actors_["108301"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos108301 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("108301", 3)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "split_2" then
						var_333_3:SetAsLastSibling()
						var_333_3.gameObject:SetActive(true)

						arg_330_1.var_.actorSpriteSplit108301 = var_333_3.gameObject:GetComponent(typeof(Image))

						arg_330_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_333_4 = 0.5

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos108301, Vector3.New(-77.5, -399.1, -303.3), (arg_330_1.time_ - 0) / var_333_4)

				if arg_330_1.var_.actorSpriteSplit108301 ~= nil then
					arg_330_1.var_.actorSpriteSplit108301:SetAlpha((arg_330_1.time_ - 0) / var_333_4)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_330_1.var_.actorSpriteSplit108301 ~= nil then
					arg_330_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_333_5 = 0
			local var_333_6 = 0.1

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
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

				local var_333_7 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(938021080).content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 4 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_7) / 4)

				if (4 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_7) / 4)) > 0 and var_333_6 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_10 and arg_330_1.time_ < var_333_5 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play938021081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 938021081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play938021082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["108301"]) and arg_334_1.var_.actorSpriteComps108301 == nil then
				arg_334_1.var_.actorSpriteComps108301 = arg_334_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["108301"]) then
				if arg_334_1.var_.actorSpriteComps108301 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["108301"]) and arg_334_1.var_.actorSpriteComps108301 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps108301 = nil
			end

			local var_337_2 = 0
			local var_337_3 = 0.1

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_4 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(938021081).content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 4 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 4)

				if (4 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 4)) > 0 and var_337_3 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_7 and arg_334_1.time_ < var_337_2 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play938021082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938021082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938021083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["108301"]) and arg_338_1.var_.actorSpriteComps108301 == nil then
				arg_338_1.var_.actorSpriteComps108301 = arg_338_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["108301"]) then
				if arg_338_1.var_.actorSpriteComps108301 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["108301"]) and arg_338_1.var_.actorSpriteComps108301 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps108301 = nil
			end

			local var_341_2 = arg_338_1.actors_["108301"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos108301 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("108301", 3)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "split_5" then
						var_341_3:SetAsLastSibling()
						var_341_3.gameObject:SetActive(true)

						arg_338_1.var_.actorSpriteSplit108301 = var_341_3.gameObject:GetComponent(typeof(Image))

						arg_338_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_341_4 = 0.5

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos108301, Vector3.New(-77.5, -399.1, -303.3), (arg_338_1.time_ - 0) / var_341_4)

				if arg_338_1.var_.actorSpriteSplit108301 ~= nil then
					arg_338_1.var_.actorSpriteSplit108301:SetAlpha((arg_338_1.time_ - 0) / var_341_4)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_338_1.var_.actorSpriteSplit108301 ~= nil then
					arg_338_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_341_5 = 0
			local var_341_6 = 0.075

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(938021082).content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 3 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 3)

				if (3 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 3)) > 0 and var_341_6 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_5
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_6, arg_338_1.talkMaxDuration)

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_5) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_5 + var_341_10 and arg_338_1.time_ < var_341_5 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play938021083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938021083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["108301"]) and arg_342_1.var_.actorSpriteComps108301 == nil then
				arg_342_1.var_.actorSpriteComps108301 = arg_342_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["108301"]) then
				if arg_342_1.var_.actorSpriteComps108301 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["108301"]) and arg_342_1.var_.actorSpriteComps108301 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps108301 = nil
			end

			local var_345_2 = 0
			local var_345_3 = 0.425

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_4 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(938021083).content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 17 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 17)

				if (17 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 17)) > 0 and var_345_3 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_7 and arg_342_1.time_ < var_345_2 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/ST0108"
	},
	voices = {}
}
