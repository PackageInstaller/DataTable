return {
	Play938051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST13")
				var_4_0.name = "ST13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST13

				arg_1_1.bgs_.ST13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST13" then
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

					if var_4_16.name == "split_1" or not string.find(var_4_16.name, "split") then
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
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_knock02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 1.999999999999
			local var_4_24 = 0.2

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
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

				local var_4_26 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938051001).content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 8)

				if (8 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 8)) > 0 and var_4_24 < var_4_28 then
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
	Play938051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["106603"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "106603"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["106603"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["106603"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps106603 == nil then
				arg_8_1.var_.actorSpriteComps106603 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps106603 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps106603 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps106603 = nil
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

			local var_11_8 = arg_8_1.actors_["106603"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos106603 = var_11_8.localPosition
				var_11_8.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("106603", 4)

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
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_8_1.time_ - 0) / var_11_10)
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door04", "")
			end

			local var_11_12 = 0
			local var_11_13 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938051002).content)

				arg_8_1.text_.text = var_11_14

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_16 = 8 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_14) / 8)

				if (8 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_14) / 8)) > 0 and var_11_13 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_14
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_17 = math.max(var_11_13, arg_8_1.talkMaxDuration)

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_12) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_12 + var_11_17 and arg_8_1.time_ < var_11_12 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play938051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["104902"] == nil then
				local var_15_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_15_0) then
					local var_15_1 = Object.Instantiate(var_15_0, arg_12_1.canvasGo_.transform)

					var_15_1.transform:SetSiblingIndex(1)

					var_15_1.name = "104902"
					var_15_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_["104902"] = var_15_1

					if arg_12_1.isInRecall_ then
						for iter_15_0, iter_15_1 in ipairs((var_15_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_15_1.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_2 = arg_12_1.actors_["104902"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps104902 == nil then
				arg_12_1.var_.actorSpriteComps104902 = var_15_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_3 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 and not isNil(var_15_2) then
				if arg_12_1.var_.actorSpriteComps104902 then
					for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_15_3 then
							if arg_12_1.isInRecall_ then
								iter_15_3.color = Color.New(Mathf.Lerp(iter_15_3.color.r, arg_12_1.hightColor1.r, (arg_12_1.time_ - 0) / var_15_3), Mathf.Lerp(iter_15_3.color.g, arg_12_1.hightColor1.g, (arg_12_1.time_ - 0) / var_15_3), (Mathf.Lerp(iter_15_3.color.b, arg_12_1.hightColor1.b, (arg_12_1.time_ - 0) / var_15_3)))
							else
								local var_15_4 = Mathf.Lerp(iter_15_3.color.r, 1, (arg_12_1.time_ - 0) / var_15_3)

								iter_15_3.color = Color.New(var_15_4, var_15_4, var_15_4)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 and not isNil(var_15_2) and arg_12_1.var_.actorSpriteComps104902 then
				for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_15_5 then
						iter_15_5.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps104902 = nil
			end

			local var_15_5 = arg_12_1.actors_["106603"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.actorSpriteComps106603 == nil then
				arg_12_1.var_.actorSpriteComps106603 = var_15_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.actorSpriteComps106603 then
					for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_15_7 then
							if arg_12_1.isInRecall_ then
								iter_15_7.color = Color.New(Mathf.Lerp(iter_15_7.color.r, arg_12_1.hightColor2.r, (arg_12_1.time_ - 0) / var_15_6), Mathf.Lerp(iter_15_7.color.g, arg_12_1.hightColor2.g, (arg_12_1.time_ - 0) / var_15_6), (Mathf.Lerp(iter_15_7.color.b, arg_12_1.hightColor2.b, (arg_12_1.time_ - 0) / var_15_6)))
							else
								local var_15_7 = Mathf.Lerp(iter_15_7.color.r, 0.5, (arg_12_1.time_ - 0) / var_15_6)

								iter_15_7.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.actorSpriteComps106603 then
				for iter_15_8, iter_15_9 in pairs(arg_12_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_15_9 then
						iter_15_9.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps106603 = nil
			end

			local var_15_8 = arg_12_1.actors_["104902"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos104902 = var_15_8.localPosition
				var_15_8.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("104902", 2)

				for iter_15_10 = 0, var_15_8.childCount - 1 do
					local var_15_9 = var_15_8:GetChild(iter_15_10)

					if var_15_9.name == "" or not string.find(var_15_9.name, "split") then
						var_15_9.gameObject:SetActive(true)
					else
						var_15_9.gameObject:SetActive(false)
					end
				end
			end

			local var_15_10 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_10 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_12_1.time_ - 0) / var_15_10)
			end

			if arg_12_1.time_ >= 0 + var_15_10 and arg_12_1.time_ < 0 + var_15_10 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_15_11 = arg_12_1.actors_["128404"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos128404 = var_15_11.localPosition
				var_15_11.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("128404", 7)

				for iter_15_11 = 0, var_15_11.childCount - 1 do
					local var_15_12 = var_15_11:GetChild(iter_15_11)

					if var_15_12.name == "" or not string.find(var_15_12.name, "split") then
						var_15_12.gameObject:SetActive(true)
					else
						var_15_12.gameObject:SetActive(false)
					end
				end
			end

			local var_15_13 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_13 then
				var_15_11.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0) / var_15_13)
			end

			if arg_12_1.time_ >= 0 + var_15_13 and arg_12_1.time_ < 0 + var_15_13 + arg_15_0 then
				var_15_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_14 = 0
			local var_15_15 = 0.7

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938051003).content)

				arg_12_1.text_.text = var_15_16

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_18 = 28 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_16) / 28)

				if (28 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_16) / 28)) > 0 and var_15_15 < var_15_18 then
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

		arg_12_1:InitPlayNodeList()
	end,
	Play938051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938051004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["106603"]) and arg_16_1.var_.actorSpriteComps106603 == nil then
				arg_16_1.var_.actorSpriteComps106603 = arg_16_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["106603"]) then
				if arg_16_1.var_.actorSpriteComps106603 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["106603"]) and arg_16_1.var_.actorSpriteComps106603 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps106603 = nil
			end

			local var_19_2 = arg_16_1.actors_["104902"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps104902 == nil then
				arg_16_1.var_.actorSpriteComps104902 = var_19_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_3 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.actorSpriteComps104902 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps104902 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_19_7 then
						iter_19_7.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps104902 = nil
			end

			local var_19_5 = arg_16_1.actors_["106603"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos106603 = var_19_5.localPosition
				var_19_5.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("106603", 4)

				for iter_19_8 = 0, var_19_5.childCount - 1 do
					local var_19_6 = var_19_5:GetChild(iter_19_8)

					if var_19_6.name == "" or not string.find(var_19_6.name, "split") then
						var_19_6.gameObject:SetActive(true)
					else
						var_19_6.gameObject:SetActive(false)
					end
				end
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_16_1.time_ - 0) / var_19_7)
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_19_8 = 0
			local var_19_9 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938051004).content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_12 = 18 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 18)

				if (18 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 18)) > 0 and var_19_9 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_13 and arg_16_1.time_ < var_19_8 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play938051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["128404"]) and arg_20_1.var_.actorSpriteComps128404 == nil then
				arg_20_1.var_.actorSpriteComps128404 = arg_20_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["128404"]) then
				if arg_20_1.var_.actorSpriteComps128404 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["128404"]) and arg_20_1.var_.actorSpriteComps128404 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps128404 = nil
			end

			local var_23_2 = arg_20_1.actors_["106603"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps106603 == nil then
				arg_20_1.var_.actorSpriteComps106603 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps106603 then
					for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps106603 then
				for iter_23_6, iter_23_7 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_23_7 then
						iter_23_7.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_20_1.var_.actorSpriteComps106603 = nil
			end

			local var_23_5 = arg_20_1.actors_["128404"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos128404 = var_23_5.localPosition
				var_23_5.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("128404", 2)

				for iter_23_8 = 0, var_23_5.childCount - 1 do
					local var_23_6 = var_23_5:GetChild(iter_23_8)

					if var_23_6.name == "split_4" or not string.find(var_23_6.name, "split") then
						var_23_6.gameObject:SetActive(true)
					else
						var_23_6.gameObject:SetActive(false)
					end
				end
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_20_1.time_ - 0) / var_23_7)
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_23_8 = arg_20_1.actors_["104902"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos104902 = var_23_8.localPosition
				var_23_8.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("104902", 7)

				for iter_23_9 = 0, var_23_8.childCount - 1 do
					local var_23_9 = var_23_8:GetChild(iter_23_9)

					if var_23_9.name == "" or not string.find(var_23_9.name, "split") then
						var_23_9.gameObject:SetActive(true)
					else
						var_23_9.gameObject:SetActive(false)
					end
				end
			end

			local var_23_10 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_10 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_20_1.time_ - 0) / var_23_10)
			end

			if arg_20_1.time_ >= 0 + var_23_10 and arg_20_1.time_ < 0 + var_23_10 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_23_11 = 0
			local var_23_12 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938051005).content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 35 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_13) / 35)

				if (35 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_13) / 35)) > 0 and var_23_12 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_16 and arg_20_1.time_ < var_23_11 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
				actorName = "104902",
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
	Play938051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938051006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["106603"]) and arg_24_1.var_.actorSpriteComps106603 == nil then
				arg_24_1.var_.actorSpriteComps106603 = arg_24_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["106603"]) then
				if arg_24_1.var_.actorSpriteComps106603 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["106603"]) and arg_24_1.var_.actorSpriteComps106603 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps106603 = nil
			end

			local var_27_2 = arg_24_1.actors_["128404"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps128404 == nil then
				arg_24_1.var_.actorSpriteComps128404 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps128404 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps128404 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_27_7 then
						iter_27_7.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps128404 = nil
			end

			local var_27_5 = arg_24_1.actors_["106603"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos106603 = var_27_5.localPosition
				var_27_5.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("106603", 4)

				for iter_27_8 = 0, var_27_5.childCount - 1 do
					local var_27_6 = var_27_5:GetChild(iter_27_8)

					if var_27_6.name == "split_1" or not string.find(var_27_6.name, "split") then
						var_27_6.gameObject:SetActive(true)
					else
						var_27_6.gameObject:SetActive(false)
					end
				end
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_24_1.time_ - 0) / var_27_7)
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_27_8 = 0
			local var_27_9 = 0.525

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_10 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938051006).content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_12 = 21 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_10) / 21)

				if (21 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_10) / 21)) > 0 and var_27_9 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_13 and arg_24_1.time_ < var_27_8 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play938051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938051007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["128404"]) and arg_28_1.var_.actorSpriteComps128404 == nil then
				arg_28_1.var_.actorSpriteComps128404 = arg_28_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["128404"]) then
				if arg_28_1.var_.actorSpriteComps128404 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["128404"]) and arg_28_1.var_.actorSpriteComps128404 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps128404 = nil
			end

			local var_31_2 = arg_28_1.actors_["106603"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps106603 == nil then
				arg_28_1.var_.actorSpriteComps106603 = var_31_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.actorSpriteComps106603 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps106603 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_31_7 then
						iter_31_7.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps106603 = nil
			end

			local var_31_5 = arg_28_1.actors_["128404"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_5.localPosition
				var_31_5.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 2)

				for iter_31_8 = 0, var_31_5.childCount - 1 do
					local var_31_6 = var_31_5:GetChild(iter_31_8)

					if var_31_6.name == "" then
						var_31_6:SetAsLastSibling()
						var_31_6.gameObject:SetActive(true)

						arg_28_1.var_.actorSpriteSplit128404 = var_31_6.gameObject:GetComponent(typeof(Image))

						arg_28_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_31_7 = 0.5

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_28_1.time_ - 0) / var_31_7)

				if arg_28_1.var_.actorSpriteSplit128404 ~= nil then
					arg_28_1.var_.actorSpriteSplit128404:SetAlpha((arg_28_1.time_ - 0) / var_31_7)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_28_1.var_.actorSpriteSplit128404 ~= nil then
					arg_28_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_31_8 = 0
			local var_31_9 = 0.675

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938051007).content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_12 = 27 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_10) / 27)

				if (27 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_10) / 27)) > 0 and var_31_9 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_13 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_13 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_13

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_13 and arg_28_1.time_ < var_31_8 + var_31_13 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play938051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938051008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["106603"]) and arg_32_1.var_.actorSpriteComps106603 == nil then
				arg_32_1.var_.actorSpriteComps106603 = arg_32_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["106603"]) then
				if arg_32_1.var_.actorSpriteComps106603 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["106603"]) and arg_32_1.var_.actorSpriteComps106603 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps106603 = nil
			end

			local var_35_2 = arg_32_1.actors_["128404"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps128404 == nil then
				arg_32_1.var_.actorSpriteComps128404 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps128404 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps128404 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_35_7 then
						iter_35_7.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps128404 = nil
			end

			local var_35_5 = arg_32_1.actors_["106603"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos106603 = var_35_5.localPosition
				var_35_5.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("106603", 4)

				for iter_35_8 = 0, var_35_5.childCount - 1 do
					local var_35_6 = var_35_5:GetChild(iter_35_8)

					if var_35_6.name == "split_5" then
						var_35_6:SetAsLastSibling()
						var_35_6.gameObject:SetActive(true)

						arg_32_1.var_.actorSpriteSplit106603 = var_35_6.gameObject:GetComponent(typeof(Image))

						arg_32_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_35_7 = 0.5

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_32_1.time_ - 0) / var_35_7)

				if arg_32_1.var_.actorSpriteSplit106603 ~= nil then
					arg_32_1.var_.actorSpriteSplit106603:SetAlpha((arg_32_1.time_ - 0) / var_35_7)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(453.9, -399.1, -303.3)

				if arg_32_1.var_.actorSpriteSplit106603 ~= nil then
					arg_32_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_35_8 = 0
			local var_35_9 = 0.975

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938051008).content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 39 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_10) / 39)

				if (39 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_10) / 39)) > 0 and var_35_9 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_13 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_13 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_13

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_13 and arg_32_1.time_ < var_35_8 + var_35_13 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play938051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938051009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["104902"]) and arg_36_1.var_.actorSpriteComps104902 == nil then
				arg_36_1.var_.actorSpriteComps104902 = arg_36_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["104902"]) then
				if arg_36_1.var_.actorSpriteComps104902 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["104902"]) and arg_36_1.var_.actorSpriteComps104902 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps104902 = nil
			end

			local var_39_2 = arg_36_1.actors_["106603"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_5 = arg_36_1.actors_["104902"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos104902 = var_39_5.localPosition
				var_39_5.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("104902", 2)

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
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_36_1.time_ - 0) / var_39_7)
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_39_8 = arg_36_1.actors_["128404"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos128404 = var_39_8.localPosition
				var_39_8.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("128404", 7)

				for iter_39_9 = 0, var_39_8.childCount - 1 do
					local var_39_9 = var_39_8:GetChild(iter_39_9)

					if var_39_9.name == "" or not string.find(var_39_9.name, "split") then
						var_39_9.gameObject:SetActive(true)
					else
						var_39_9.gameObject:SetActive(false)
					end
				end
			end

			local var_39_10 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_10 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_10)
			end

			if arg_36_1.time_ >= 0 + var_39_10 and arg_36_1.time_ < 0 + var_39_10 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_11 = 0
			local var_39_12 = 0.2

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938051009).content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 8 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_13) / 8)

				if (8 <= 0 and var_39_12 or var_39_12 * (utf8.len(var_39_13) / 8)) > 0 and var_39_12 < var_39_15 then
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

		arg_36_1:InitPlayNodeList()
	end,
	Play938051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938051010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["104902"]) and arg_40_1.var_.actorSpriteComps104902 == nil then
				arg_40_1.var_.actorSpriteComps104902 = arg_40_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["104902"]) then
				if arg_40_1.var_.actorSpriteComps104902 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor2.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor2.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor2.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 0.5, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["104902"]) and arg_40_1.var_.actorSpriteComps104902 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps104902 = nil
			end

			local var_43_2 = arg_40_1.actors_["104902"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos104902 = var_43_2.localPosition
				var_43_2.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("104902", 7)

				for iter_43_4 = 0, var_43_2.childCount - 1 do
					local var_43_3 = var_43_2:GetChild(iter_43_4)

					if var_43_3.name == "" or not string.find(var_43_3.name, "split") then
						var_43_3.gameObject:SetActive(true)
					else
						var_43_3.gameObject:SetActive(false)
					end
				end
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_40_1.time_ - 0) / var_43_4)
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_43_5 = arg_40_1.actors_["106603"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos106603 = var_43_5.localPosition
				var_43_5.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("106603", 7)

				for iter_43_5 = 0, var_43_5.childCount - 1 do
					local var_43_6 = var_43_5:GetChild(iter_43_5)

					if var_43_6.name == "" or not string.find(var_43_6.name, "split") then
						var_43_6.gameObject:SetActive(true)
					else
						var_43_6.gameObject:SetActive(false)
					end
				end
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_40_1.time_ - 0) / var_43_7)
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_8 = 0
			local var_43_9 = 0.725

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(938051010).content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_12 = 29 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_10) / 29)

				if (29 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_10) / 29)) > 0 and var_43_9 < var_43_12 then
					arg_40_1.talkMaxDuration = var_43_12

					if var_43_12 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_13 and arg_40_1.time_ < var_43_8 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play938051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938051011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["106603"]) and arg_44_1.var_.actorSpriteComps106603 == nil then
				arg_44_1.var_.actorSpriteComps106603 = arg_44_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["106603"]) then
				if arg_44_1.var_.actorSpriteComps106603 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["106603"]) and arg_44_1.var_.actorSpriteComps106603 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps106603 = nil
			end

			local var_47_2 = arg_44_1.actors_["106603"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos106603 = var_47_2.localPosition
				var_47_2.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("106603", 3)

				for iter_47_4 = 0, var_47_2.childCount - 1 do
					local var_47_3 = var_47_2:GetChild(iter_47_4)

					if var_47_3.name == "split_1" or not string.find(var_47_3.name, "split") then
						var_47_3.gameObject:SetActive(true)
					else
						var_47_3.gameObject:SetActive(false)
					end
				end
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_2.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_44_1.time_ - 0) / var_47_4)
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_47_5 = 0
			local var_47_6 = 0.525

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(938051011).content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 21 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 21)

				if (21 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 21)) > 0 and var_47_6 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_10 and arg_44_1.time_ < var_47_5 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play938051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938051012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["106603"]) and arg_48_1.var_.actorSpriteComps106603 == nil then
				arg_48_1.var_.actorSpriteComps106603 = arg_48_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["106603"]) then
				if arg_48_1.var_.actorSpriteComps106603 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["106603"]) and arg_48_1.var_.actorSpriteComps106603 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps106603 = nil
			end

			local var_51_2 = arg_48_1.actors_["106603"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos106603 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("106603", 7)

				for iter_51_4 = 0, var_51_2.childCount - 1 do
					local var_51_3 = var_51_2:GetChild(iter_51_4)

					if var_51_3.name == "" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_51_5 = 0
			local var_51_6 = 1.025

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(938051012).content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 41 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 41)

				if (41 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 41)) > 0 and var_51_6 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_10 and arg_48_1.time_ < var_51_5 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play938051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938051013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(938051013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 16 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 16)

				if (16 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 16)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play938051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938051014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["106603"]) and arg_56_1.var_.actorSpriteComps106603 == nil then
				arg_56_1.var_.actorSpriteComps106603 = arg_56_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["106603"]) then
				if arg_56_1.var_.actorSpriteComps106603 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["106603"]) and arg_56_1.var_.actorSpriteComps106603 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps106603 = nil
			end

			local var_59_2 = arg_56_1.actors_["106603"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos106603 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("106603", 3)

				for iter_59_4 = 0, var_59_2.childCount - 1 do
					local var_59_3 = var_59_2:GetChild(iter_59_4)

					if var_59_3.name == "" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_59_5 = 0
			local var_59_6 = 0.7

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(938051014).content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 28 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 28)

				if (28 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 28)) > 0 and var_59_6 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_10 and arg_56_1.time_ < var_59_5 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play938051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938051015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["106603"]) and arg_60_1.var_.actorSpriteComps106603 == nil then
				arg_60_1.var_.actorSpriteComps106603 = arg_60_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["106603"]) then
				if arg_60_1.var_.actorSpriteComps106603 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["106603"]) and arg_60_1.var_.actorSpriteComps106603 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps106603 = nil
			end

			local var_63_2 = 0
			local var_63_3 = 1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_4 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(938051015).content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 40 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_4) / 40)

				if (40 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_4) / 40)) > 0 and var_63_3 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_7 and arg_60_1.time_ < var_63_2 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play938051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938051016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["106603"]) and arg_64_1.var_.actorSpriteComps106603 == nil then
				arg_64_1.var_.actorSpriteComps106603 = arg_64_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["106603"]) then
				if arg_64_1.var_.actorSpriteComps106603 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["106603"]) and arg_64_1.var_.actorSpriteComps106603 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps106603 = nil
			end

			local var_67_2 = arg_64_1.actors_["106603"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos106603 = var_67_2.localPosition
				var_67_2.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("106603", 3)

				for iter_67_4 = 0, var_67_2.childCount - 1 do
					local var_67_3 = var_67_2:GetChild(iter_67_4)

					if var_67_3.name == "split_1" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_2.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_64_1.time_ - 0) / var_67_4)
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_67_5 = 0
			local var_67_6 = 0.55

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(938051016).content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 22 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 22)

				if (22 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 22)) > 0 and var_67_6 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_10 and arg_64_1.time_ < var_67_5 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play938051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938051017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["106603"]) and arg_68_1.var_.actorSpriteComps106603 == nil then
				arg_68_1.var_.actorSpriteComps106603 = arg_68_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["106603"]) then
				if arg_68_1.var_.actorSpriteComps106603 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["106603"]) and arg_68_1.var_.actorSpriteComps106603 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps106603 = nil
			end

			local var_71_2 = 0
			local var_71_3 = 0.075

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_4 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(938051017).content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 3 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 3)

				if (3 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 3)) > 0 and var_71_3 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_7 and arg_68_1.time_ < var_71_2 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play938051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938051018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["106603"]) and arg_72_1.var_.actorSpriteComps106603 == nil then
				arg_72_1.var_.actorSpriteComps106603 = arg_72_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["106603"]) then
				if arg_72_1.var_.actorSpriteComps106603 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["106603"]) and arg_72_1.var_.actorSpriteComps106603 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps106603 = nil
			end

			local var_75_2 = arg_72_1.actors_["106603"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos106603 = var_75_2.localPosition
				var_75_2.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("106603", 3)

				for iter_75_4 = 0, var_75_2.childCount - 1 do
					local var_75_3 = var_75_2:GetChild(iter_75_4)

					if var_75_3.name == "split_5" then
						var_75_3:SetAsLastSibling()
						var_75_3.gameObject:SetActive(true)

						arg_72_1.var_.actorSpriteSplit106603 = var_75_3.gameObject:GetComponent(typeof(Image))

						arg_72_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_75_4 = 0.5

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_2.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_72_1.time_ - 0) / var_75_4)

				if arg_72_1.var_.actorSpriteSplit106603 ~= nil then
					arg_72_1.var_.actorSpriteSplit106603:SetAlpha((arg_72_1.time_ - 0) / var_75_4)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_72_1.var_.actorSpriteSplit106603 ~= nil then
					arg_72_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_75_5 = 0
			local var_75_6 = 0.325

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_7 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(938051018).content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 13 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 13)

				if (13 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 13)) > 0 and var_75_6 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_5 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_5
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_6, arg_72_1.talkMaxDuration)

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_5) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_5 + var_75_10 and arg_72_1.time_ < var_75_5 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938051019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["106603"]) and arg_76_1.var_.actorSpriteComps106603 == nil then
				arg_76_1.var_.actorSpriteComps106603 = arg_76_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["106603"]) then
				if arg_76_1.var_.actorSpriteComps106603 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["106603"]) and arg_76_1.var_.actorSpriteComps106603 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps106603 = nil
			end

			local var_79_2 = arg_76_1.actors_["106603"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos106603 = var_79_2.localPosition
				var_79_2.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("106603", 7)

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

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				var_79_2.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0) / var_79_4)
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				var_79_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_5 = 0
			local var_79_6 = 0.975

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_7 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(938051019).content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 39 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_7) / 39)

				if (39 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_7) / 39)) > 0 and var_79_6 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_5
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_6, arg_76_1.talkMaxDuration)

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_5) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_5 + var_79_10 and arg_76_1.time_ < var_79_5 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play938051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938051020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.4

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(938051020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 16 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 16)

				if (16 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 16)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 938051021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play938051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["106603"]) and arg_84_1.var_.actorSpriteComps106603 == nil then
				arg_84_1.var_.actorSpriteComps106603 = arg_84_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["106603"]) then
				if arg_84_1.var_.actorSpriteComps106603 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["106603"]) and arg_84_1.var_.actorSpriteComps106603 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps106603 = nil
			end

			local var_87_2 = arg_84_1.actors_["106603"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos106603 = var_87_2.localPosition
				var_87_2.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("106603", 3)

				for iter_87_4 = 0, var_87_2.childCount - 1 do
					local var_87_3 = var_87_2:GetChild(iter_87_4)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_84_1.time_ - 0) / var_87_4)
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_87_5 = 0
			local var_87_6 = 0.225

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(938051021).content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 9 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 9)

				if (9 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 9)) > 0 and var_87_6 < var_87_9 then
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
				actorName = "106603",
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
	Play938051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 938051022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play938051023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["106603"]) and arg_88_1.var_.actorSpriteComps106603 == nil then
				arg_88_1.var_.actorSpriteComps106603 = arg_88_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["106603"]) then
				if arg_88_1.var_.actorSpriteComps106603 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["106603"]) and arg_88_1.var_.actorSpriteComps106603 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps106603 = nil
			end

			local var_91_2 = 0
			local var_91_3 = 0.15

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_4 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(938051022).content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_6 = 6 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_4) / 6)

				if (6 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_4) / 6)) > 0 and var_91_3 < var_91_6 then
					arg_88_1.talkMaxDuration = var_91_6

					if var_91_6 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_6 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_7 and arg_88_1.time_ < var_91_2 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play938051023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 938051023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play938051024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["106603"]) and arg_92_1.var_.actorSpriteComps106603 == nil then
				arg_92_1.var_.actorSpriteComps106603 = arg_92_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["106603"]) then
				if arg_92_1.var_.actorSpriteComps106603 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["106603"]) and arg_92_1.var_.actorSpriteComps106603 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps106603 = nil
			end

			local var_95_2 = arg_92_1.actors_["106603"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos106603 = var_95_2.localPosition
				var_95_2.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("106603", 3)

				for iter_95_4 = 0, var_95_2.childCount - 1 do
					local var_95_3 = var_95_2:GetChild(iter_95_4)

					if var_95_3.name == "split_6" then
						var_95_3:SetAsLastSibling()
						var_95_3.gameObject:SetActive(true)

						arg_92_1.var_.actorSpriteSplit106603 = var_95_3.gameObject:GetComponent(typeof(Image))

						arg_92_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_95_4 = 0.5

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_2.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_92_1.time_ - 0) / var_95_4)

				if arg_92_1.var_.actorSpriteSplit106603 ~= nil then
					arg_92_1.var_.actorSpriteSplit106603:SetAlpha((arg_92_1.time_ - 0) / var_95_4)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_92_1.var_.actorSpriteSplit106603 ~= nil then
					arg_92_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_95_5 = 0
			local var_95_6 = 0.675

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(938051023).content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 27 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_7) / 27)

				if (27 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_7) / 27)) > 0 and var_95_6 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_10 and arg_92_1.time_ < var_95_5 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play938051024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 938051024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play938051025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos106603 = arg_96_1.actors_["106603"].transform.localPosition
				arg_96_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("106603", 3)

				for iter_99_0 = 0, arg_96_1.actors_["106603"].transform.childCount - 1 do
					local var_99_0 = arg_96_1.actors_["106603"].transform:GetChild(iter_99_0)

					if var_99_0.name == "" then
						var_99_0:SetAsLastSibling()
						var_99_0.gameObject:SetActive(true)

						arg_96_1.var_.actorSpriteSplit106603 = var_99_0.gameObject:GetComponent(typeof(Image))

						arg_96_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_99_1 = 0.5

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_96_1.time_ - 0) / var_99_1)

				if arg_96_1.var_.actorSpriteSplit106603 ~= nil then
					arg_96_1.var_.actorSpriteSplit106603:SetAlpha((arg_96_1.time_ - 0) / var_99_1)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["106603"].transform.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_96_1.var_.actorSpriteSplit106603 ~= nil then
					arg_96_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_99_2 = 0
			local var_99_3 = 0.25

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(938051024).content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 10 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 10)

				if (10 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 10)) > 0 and var_99_3 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_7 and arg_96_1.time_ < var_99_2 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play938051025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 938051025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play938051026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["106603"]) and arg_100_1.var_.actorSpriteComps106603 == nil then
				arg_100_1.var_.actorSpriteComps106603 = arg_100_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["106603"]) then
				if arg_100_1.var_.actorSpriteComps106603 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["106603"]) and arg_100_1.var_.actorSpriteComps106603 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps106603 = nil
			end

			local var_103_2 = arg_100_1.actors_["106603"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos106603 = var_103_2.localPosition
				var_103_2.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("106603", 7)

				for iter_103_4 = 0, var_103_2.childCount - 1 do
					local var_103_3 = var_103_2:GetChild(iter_103_4)

					if var_103_3.name == "" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_100_1.time_ - 0) / var_103_4)
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_103_5 = 0
			local var_103_6 = 0.575

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(938051025).content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 23 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 23)

				if (23 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 23)) > 0 and var_103_6 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_10 and arg_100_1.time_ < var_103_5 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play938051026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 938051026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play938051027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.7

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(938051026).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 28 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 28)

				if (28 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 28)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play938051027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 938051027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play938051028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.375

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
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

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(938051027).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 15 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 15)

				if (15 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 15)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play938051028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 938051028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play938051029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["106603"]) and arg_112_1.var_.actorSpriteComps106603 == nil then
				arg_112_1.var_.actorSpriteComps106603 = arg_112_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["106603"]) then
				if arg_112_1.var_.actorSpriteComps106603 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["106603"]) and arg_112_1.var_.actorSpriteComps106603 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps106603 = nil
			end

			local var_115_2 = arg_112_1.actors_["106603"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos106603 = var_115_2.localPosition
				var_115_2.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("106603", 3)

				for iter_115_4 = 0, var_115_2.childCount - 1 do
					local var_115_3 = var_115_2:GetChild(iter_115_4)

					if var_115_3.name == "split_6" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_2.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_112_1.time_ - 0) / var_115_4)
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_115_5 = 0
			local var_115_6 = 0.575

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(938051028).content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 23 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 23)

				if (23 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 23)) > 0 and var_115_6 < var_115_9 then
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play938051029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 938051029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play938051030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["106603"]) and arg_116_1.var_.actorSpriteComps106603 == nil then
				arg_116_1.var_.actorSpriteComps106603 = arg_116_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["106603"]) then
				if arg_116_1.var_.actorSpriteComps106603 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["106603"]) and arg_116_1.var_.actorSpriteComps106603 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps106603 = nil
			end

			local var_119_2 = 0
			local var_119_3 = 0.6

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_4 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(938051029).content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_6 = 24 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_4) / 24)

				if (24 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_4) / 24)) > 0 and var_119_3 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_7 and arg_116_1.time_ < var_119_2 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play938051030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 938051030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
			arg_120_1.auto_ = false
		end

		function arg_120_1.playNext_(arg_122_0)
			arg_120_1.onStoryFinished_()
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

			local var_123_2 = arg_120_1.actors_["106603"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos106603 = var_123_2.localPosition
				var_123_2.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("106603", 3)

				for iter_123_4 = 0, var_123_2.childCount - 1 do
					local var_123_3 = var_123_2:GetChild(iter_123_4)

					if var_123_3.name == "split_1" then
						var_123_3:SetAsLastSibling()
						var_123_3.gameObject:SetActive(true)

						arg_120_1.var_.actorSpriteSplit106603 = var_123_3.gameObject:GetComponent(typeof(Image))

						arg_120_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_123_4 = 0.5

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				var_123_2.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_120_1.time_ - 0) / var_123_4)

				if arg_120_1.var_.actorSpriteSplit106603 ~= nil then
					arg_120_1.var_.actorSpriteSplit106603:SetAlpha((arg_120_1.time_ - 0) / var_123_4)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				var_123_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_120_1.var_.actorSpriteSplit106603 ~= nil then
					arg_120_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_123_5 = 0
			local var_123_6 = 0.35

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
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

				local var_123_7 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(938051030).content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 14 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_7) / 14)

				if (14 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_7) / 14)) > 0 and var_123_6 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_10 and arg_120_1.time_ < var_123_5 + var_123_10 + arg_123_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST13"
	},
	voices = {}
}
