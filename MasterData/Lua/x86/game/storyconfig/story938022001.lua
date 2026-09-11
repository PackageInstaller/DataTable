return {
	Play938022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938022002(arg_1_1)
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

			local var_4_9 = "108301"

			if arg_1_1.actors_["108301"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

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

			local var_4_12 = arg_1_1.actors_["108301"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps108301 == nil then
				arg_1_1.var_.actorSpriteComps108301 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps108301 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps108301 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps108301 = nil
			end

			local var_4_15 = arg_1_1.actors_["108301"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos108301 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("108301", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_2" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -360, -195)
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_22 = arg_1_1.actors_["108301"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_22 then
					arg_1_1.var_.alphaOldValue108301 = var_4_22.alpha
					arg_1_1.var_.characterEffect108301 = var_4_22
				end

				arg_1_1.var_.alphaOldValue108301 = 0
			end

			local var_4_23 = 0.5

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_23 then
				if arg_1_1.var_.characterEffect108301 then
					arg_1_1.var_.characterEffect108301.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue108301, 1, (arg_1_1.time_ - 2) / var_4_23)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_23 and arg_1_1.time_ < 2 + var_4_23 + arg_4_0 and arg_1_1.var_.characterEffect108301 then
				arg_1_1.var_.characterEffect108301.alpha = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_27 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938022001).content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 26)

				if (26 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 26)) > 0 and var_4_25 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_24 = var_4_24 + 0.3

					if var_4_29 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_24 + 0.3
			local var_4_31 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938022002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938022002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938022003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["108301"]) and arg_8_1.var_.actorSpriteComps108301 == nil then
				arg_8_1.var_.actorSpriteComps108301 = arg_8_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["108301"]) then
				if arg_8_1.var_.actorSpriteComps108301 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_11_1 then
							if arg_8_1.isInRecall_ then
								iter_11_1.color = Color.New(Mathf.Lerp(iter_11_1.color.r, arg_8_1.hightColor2.r, (arg_8_1.time_ - 0) / var_11_0), Mathf.Lerp(iter_11_1.color.g, arg_8_1.hightColor2.g, (arg_8_1.time_ - 0) / var_11_0), (Mathf.Lerp(iter_11_1.color.b, arg_8_1.hightColor2.b, (arg_8_1.time_ - 0) / var_11_0)))
							else
								local var_11_1 = Mathf.Lerp(iter_11_1.color.r, 0.5, (arg_8_1.time_ - 0) / var_11_0)

								iter_11_1.color = Color.New(var_11_1, var_11_1, var_11_1)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["108301"]) and arg_8_1.var_.actorSpriteComps108301 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_11_3 then
						iter_11_3.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps108301 = nil
			end

			local var_11_2 = 0
			local var_11_3 = 0.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_4 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938022002).content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 14 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 14)

				if (14 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 14)) > 0 and var_11_3 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_2 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_2
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_3, arg_8_1.talkMaxDuration)

			if var_11_2 <= arg_8_1.time_ and arg_8_1.time_ < var_11_2 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_2) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_2 + var_11_7 and arg_8_1.time_ < var_11_2 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938022003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938022003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938022004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos108301 = arg_12_1.actors_["108301"].transform.localPosition
				arg_12_1.actors_["108301"].transform.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("108301", 7)

				for iter_15_0 = 0, arg_12_1.actors_["108301"].transform.childCount - 1 do
					local var_15_0 = arg_12_1.actors_["108301"].transform:GetChild(iter_15_0)

					if var_15_0.name == "" or not string.find(var_15_0.name, "split") then
						var_15_0.gameObject:SetActive(true)
					else
						var_15_0.gameObject:SetActive(false)
					end
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["108301"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0) / var_15_1)
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["108301"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_2 = 0
			local var_15_3 = 1.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938022003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 53 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 53)

				if (53 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 53)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
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
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play938022004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938022004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938022005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.675

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938022004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 67 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 67)

				if (67 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 67)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play938022005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938022005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938022006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["108301"]) and arg_20_1.var_.actorSpriteComps108301 == nil then
				arg_20_1.var_.actorSpriteComps108301 = arg_20_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["108301"]) then
				if arg_20_1.var_.actorSpriteComps108301 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["108301"]) and arg_20_1.var_.actorSpriteComps108301 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps108301 = nil
			end

			local var_23_2 = arg_20_1.actors_["108301"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos108301 = var_23_2.localPosition
				var_23_2.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("108301", 3)

				for iter_23_4 = 0, var_23_2.childCount - 1 do
					local var_23_3 = var_23_2:GetChild(iter_23_4)

					if var_23_3.name == "" or not string.find(var_23_3.name, "split") then
						var_23_3.gameObject:SetActive(true)
					else
						var_23_3.gameObject:SetActive(false)
					end
				end
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_2.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_20_1.time_ - 0) / var_23_4)
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_23_5 = 0
			local var_23_6 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_7 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938022005).content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 30 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 30)

				if (30 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 30)) > 0 and var_23_6 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_10 and arg_20_1.time_ < var_23_5 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play938022006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938022006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938022007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["108301"]) and arg_24_1.var_.actorSpriteComps108301 == nil then
				arg_24_1.var_.actorSpriteComps108301 = arg_24_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["108301"]) then
				if arg_24_1.var_.actorSpriteComps108301 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["108301"]) and arg_24_1.var_.actorSpriteComps108301 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps108301 = nil
			end

			local var_27_2 = 0
			local var_27_3 = 1.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938022006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 46 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 46)

				if (46 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 46)) > 0 and var_27_3 < var_27_6 then
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

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play938022007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938022007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938022008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["108301"]) and arg_28_1.var_.actorSpriteComps108301 == nil then
				arg_28_1.var_.actorSpriteComps108301 = arg_28_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["108301"]) then
				if arg_28_1.var_.actorSpriteComps108301 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["108301"]) and arg_28_1.var_.actorSpriteComps108301 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps108301 = nil
			end

			local var_31_2 = arg_28_1.actors_["108301"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos108301 = var_31_2.localPosition
				var_31_2.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("108301", 3)

				for iter_31_4 = 0, var_31_2.childCount - 1 do
					local var_31_3 = var_31_2:GetChild(iter_31_4)

					if var_31_3.name == "split_5" then
						var_31_3:SetAsLastSibling()
						var_31_3.gameObject:SetActive(true)

						arg_28_1.var_.actorSpriteSplit108301 = var_31_3.gameObject:GetComponent(typeof(Image))

						arg_28_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_31_4 = 0.5

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_2.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_28_1.time_ - 0) / var_31_4)

				if arg_28_1.var_.actorSpriteSplit108301 ~= nil then
					arg_28_1.var_.actorSpriteSplit108301:SetAlpha((arg_28_1.time_ - 0) / var_31_4)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_2.localPosition = Vector3.New(0, -360, -195)

				if arg_28_1.var_.actorSpriteSplit108301 ~= nil then
					arg_28_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_31_5 = 0
			local var_31_6 = 1.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938022007).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 55 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 55)

				if (55 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 55)) > 0 and var_31_6 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_10 and arg_28_1.time_ < var_31_5 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play938022008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938022008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938022009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["108301"]) and arg_32_1.var_.actorSpriteComps108301 == nil then
				arg_32_1.var_.actorSpriteComps108301 = arg_32_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["108301"]) then
				if arg_32_1.var_.actorSpriteComps108301 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["108301"]) and arg_32_1.var_.actorSpriteComps108301 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps108301 = nil
			end

			local var_35_2 = 0
			local var_35_3 = 1.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_4 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938022008).content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 43 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 43)

				if (43 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 43)) > 0 and var_35_3 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_7 and arg_32_1.time_ < var_35_2 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play938022009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938022009
		arg_36_1.duration_ = 7

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938022010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_9000

			if 1.3 < arg_36_1.time_ and arg_36_1.time_ <= 1.3 + arg_39_0 then
				local var_39_0 = arg_36_1.bgs_.ST0119

				arg_36_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_1 = var_39_0:GetComponent("SpriteRenderer")

				if var_39_1 and var_39_1.sprite then
					local var_39_2 = 2 * (var_39_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_0.transform.localScale = Vector3.New(var_39_2 / var_39_1.sprite.bounds.size.y < var_39_2 * manager.ui.mainCameraCom_.aspect / var_39_1.sprite.bounds.size.x and var_39_2 * manager.ui.mainCameraCom_.aspect / var_39_1.sprite.bounds.size.x or var_39_2 / var_39_1.sprite.bounds.size.y, var_39_2 / var_39_1.sprite.bounds.size.y < var_39_2 * manager.ui.mainCameraCom_.aspect / var_39_1.sprite.bounds.size.x and var_39_2 * manager.ui.mainCameraCom_.aspect / var_39_1.sprite.bounds.size.x or var_39_2 / var_39_1.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "ST0119" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_3 = 1.3

			if 1.3 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_3 + 0.3 and arg_36_1.time_ < var_39_3 + 0.3 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				local var_39_4 = arg_36_1.var_.effectzhuanchang1

				if not arg_36_1.var_.effectzhuanchang1 then
					var_39_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_39_4.name = "zhuanchang1"
					arg_36_1.var_.effectzhuanchang1 = var_39_4
				else
					var_39_4.transform:SetParent(var_39_9000)
				end

				var_39_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_39_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_39_6 = "106603"

			if arg_36_1.actors_["106603"] == nil then
				local var_39_7 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_39_7) then
					local var_39_8 = Object.Instantiate(var_39_7, arg_36_1.canvasGo_.transform)

					var_39_8.transform:SetSiblingIndex(1)

					var_39_8.name = var_39_6
					var_39_8.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_36_1.actors_[var_39_6] = var_39_8

					if arg_36_1.isInRecall_ then
						for iter_39_2, iter_39_3 in ipairs((var_39_8:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_39_9 = arg_36_1.actors_["106603"]

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_9:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_10 and not isNil(var_39_9) then
				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								iter_39_5.color = Color.New(Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor1.r, (arg_36_1.time_ - 2) / var_39_10), Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor1.g, (arg_36_1.time_ - 2) / var_39_10), (Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor1.b, (arg_36_1.time_ - 2) / var_39_10)))
							else
								local var_39_11 = Mathf.Lerp(iter_39_5.color.r, 1, (arg_36_1.time_ - 2) / var_39_10)

								iter_39_5.color = Color.New(var_39_11, var_39_11, var_39_11)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 2 + var_39_10 and arg_36_1.time_ < 2 + var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_12 = arg_36_1.actors_["108301"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos108301 = var_39_12.localPosition
				var_39_12.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("108301", 7)

				for iter_39_8 = 0, var_39_12.childCount - 1 do
					local var_39_13 = var_39_12:GetChild(iter_39_8)

					if var_39_13.name == "" or not string.find(var_39_13.name, "split") then
						var_39_13.gameObject:SetActive(true)
					else
						var_39_13.gameObject:SetActive(false)
					end
				end
			end

			local var_39_14 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_14 then
				var_39_12.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_14)
			end

			if arg_36_1.time_ >= 0 + var_39_14 and arg_36_1.time_ < 0 + var_39_14 + arg_39_0 then
				var_39_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_15 = arg_36_1.actors_["106603"].transform

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_15.localPosition
				var_39_15.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 2)

				for iter_39_9 = 0, var_39_15.childCount - 1 do
					local var_39_16 = var_39_15:GetChild(iter_39_9)

					if var_39_16.name == "" or not string.find(var_39_16.name, "split") then
						var_39_16.gameObject:SetActive(true)
					else
						var_39_16.gameObject:SetActive(false)
					end
				end
			end

			local var_39_17 = 0.001

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_17 then
				var_39_15.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_36_1.time_ - 2) / var_39_17)
			end

			if arg_36_1.time_ >= 2 + var_39_17 and arg_36_1.time_ < 2 + var_39_17 + arg_39_0 then
				var_39_15.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				local var_39_18 = arg_36_1.actors_["106603"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_39_18 then
					arg_36_1.var_.alphaOldValue106603 = var_39_18.alpha
					arg_36_1.var_.characterEffect106603 = var_39_18
				end

				arg_36_1.var_.alphaOldValue106603 = 0
			end

			local var_39_19 = 0.5

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_19 then
				if arg_36_1.var_.characterEffect106603 then
					arg_36_1.var_.characterEffect106603.alpha = Mathf.Lerp(arg_36_1.var_.alphaOldValue106603, 1, (arg_36_1.time_ - 2) / var_39_19)
				end
			end

			if arg_36_1.time_ >= 2 + var_39_19 and arg_36_1.time_ < 2 + var_39_19 + arg_39_0 and arg_36_1.var_.characterEffect106603 then
				arg_36_1.var_.characterEffect106603.alpha = 1
			end

			local var_39_20 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_20 + 2.5 and arg_36_1.time_ < var_39_20 + 2.5 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_21 = 2
			local var_39_22 = 0.75

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_23 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_23:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_24 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938022009).content)

				arg_36_1.text_.text = var_39_24

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_26 = 30 <= 0 and var_39_22 or var_39_22 * (utf8.len(var_39_24) / 30)

				if (30 <= 0 and var_39_22 or var_39_22 * (utf8.len(var_39_24) / 30)) > 0 and var_39_22 < var_39_26 then
					arg_36_1.talkMaxDuration = var_39_26
					var_39_21 = var_39_21 + 0.3

					if var_39_26 + var_39_21 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_26 + var_39_21
					end
				end

				arg_36_1.text_.text = var_39_24
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_27 = var_39_21 + 0.3
			local var_39_28 = math.max(var_39_22, arg_36_1.talkMaxDuration)

			if var_39_21 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_27 + var_39_28 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_27) / var_39_28

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_27 + var_39_28 and arg_36_1.time_ < var_39_27 + var_39_28 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play938022010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 938022010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play938022011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["128404"] == nil then
				local var_45_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_45_0) then
					local var_45_1 = Object.Instantiate(var_45_0, arg_42_1.canvasGo_.transform)

					var_45_1.transform:SetSiblingIndex(1)

					var_45_1.name = "128404"
					var_45_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_["128404"] = var_45_1

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs((var_45_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_2 = arg_42_1.actors_["128404"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps128404 == nil then
				arg_42_1.var_.actorSpriteComps128404 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps128404 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								iter_45_3.color = Color.New(Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_3.color.r, 1, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_3.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps128404 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_45_5 then
						iter_45_5.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps128404 = nil
			end

			local var_45_5 = arg_42_1.actors_["106603"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps106603 == nil then
				arg_42_1.var_.actorSpriteComps106603 = var_45_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.actorSpriteComps106603 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								iter_45_7.color = Color.New(Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_6), Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_6), (Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_6)))
							else
								local var_45_7 = Mathf.Lerp(iter_45_7.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_6)

								iter_45_7.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps106603 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_45_9 then
						iter_45_9.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps106603 = nil
			end

			local var_45_8 = arg_42_1.actors_["128404"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos128404 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("128404", 4)

				for iter_45_10 = 0, var_45_8.childCount - 1 do
					local var_45_9 = var_45_8:GetChild(iter_45_10)

					if var_45_9.name == "split_3" or not string.find(var_45_9.name, "split") then
						var_45_9.gameObject:SetActive(true)
					else
						var_45_9.gameObject:SetActive(false)
					end
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_42_1.time_ - 0) / var_45_10)
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				local var_45_11 = arg_42_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_45_11 then
					arg_42_1.var_.alphaOldValue128404 = var_45_11.alpha
					arg_42_1.var_.characterEffect128404 = var_45_11
				end

				arg_42_1.var_.alphaOldValue128404 = 0
			end

			local var_45_12 = 0.5

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_12 then
				if arg_42_1.var_.characterEffect128404 then
					arg_42_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_42_1.var_.alphaOldValue128404, 1, (arg_42_1.time_ - 0) / var_45_12)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_12 and arg_42_1.time_ < 0 + var_45_12 + arg_45_0 and arg_42_1.var_.characterEffect128404 then
				arg_42_1.var_.characterEffect128404.alpha = 1
			end

			local var_45_13 = 0
			local var_45_14 = 1.15

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_15 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(938022010).content)

				arg_42_1.text_.text = var_45_15

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 46 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_15) / 46)

				if (46 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_15) / 46)) > 0 and var_45_14 < var_45_17 then
					arg_42_1.talkMaxDuration = var_45_17

					if var_45_17 + var_45_13 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_13
					end
				end

				arg_42_1.text_.text = var_45_15
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_14, arg_42_1.talkMaxDuration)

			if var_45_13 <= arg_42_1.time_ and arg_42_1.time_ < var_45_13 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_13) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_13 + var_45_18 and arg_42_1.time_ < var_45_13 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play938022011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 938022011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play938022012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["104902"] == nil then
				local var_49_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_49_0) then
					local var_49_1 = Object.Instantiate(var_49_0, arg_46_1.canvasGo_.transform)

					var_49_1.transform:SetSiblingIndex(1)

					var_49_1.name = "104902"
					var_49_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_["104902"] = var_49_1

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs((var_49_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_2 = arg_46_1.actors_["104902"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps104902 == nil then
				arg_46_1.var_.actorSpriteComps104902 = var_49_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_3 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.actorSpriteComps104902 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								iter_49_3.color = Color.New(Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_3), Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_3), (Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_3)))
							else
								local var_49_4 = Mathf.Lerp(iter_49_3.color.r, 1, (arg_46_1.time_ - 0) / var_49_3)

								iter_49_3.color = Color.New(var_49_4, var_49_4, var_49_4)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps104902 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_49_5 then
						iter_49_5.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps104902 = nil
			end

			local var_49_5 = arg_46_1.actors_["128404"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.actorSpriteComps128404 == nil then
				arg_46_1.var_.actorSpriteComps128404 = var_49_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_6 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_6 and not isNil(var_49_5) then
				if arg_46_1.var_.actorSpriteComps128404 then
					for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_49_7 then
							if arg_46_1.isInRecall_ then
								iter_49_7.color = Color.New(Mathf.Lerp(iter_49_7.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_6), Mathf.Lerp(iter_49_7.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_6), (Mathf.Lerp(iter_49_7.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_6)))
							else
								local var_49_7 = Mathf.Lerp(iter_49_7.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_6)

								iter_49_7.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_6 and arg_46_1.time_ < 0 + var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.actorSpriteComps128404 then
				for iter_49_8, iter_49_9 in pairs(arg_46_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_49_9 then
						iter_49_9.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps128404 = nil
			end

			local var_49_8 = arg_46_1.actors_["104902"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos104902 = var_49_8.localPosition
				var_49_8.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("104902", 2)

				for iter_49_10 = 0, var_49_8.childCount - 1 do
					local var_49_9 = var_49_8:GetChild(iter_49_10)

					if var_49_9.name == "split_3" or not string.find(var_49_9.name, "split") then
						var_49_9.gameObject:SetActive(true)
					else
						var_49_9.gameObject:SetActive(false)
					end
				end
			end

			local var_49_10 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_10 then
				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_46_1.time_ - 0) / var_49_10)
			end

			if arg_46_1.time_ >= 0 + var_49_10 and arg_46_1.time_ < 0 + var_49_10 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_49_11 = arg_46_1.actors_["106603"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos106603 = var_49_11.localPosition
				var_49_11.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("106603", 7)

				for iter_49_11 = 0, var_49_11.childCount - 1 do
					local var_49_12 = var_49_11:GetChild(iter_49_11)

					if var_49_12.name == "split_1" or not string.find(var_49_12.name, "split") then
						var_49_12.gameObject:SetActive(true)
					else
						var_49_12.gameObject:SetActive(false)
					end
				end
			end

			local var_49_13 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_13 then
				var_49_11.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_46_1.time_ - 0) / var_49_13)
			end

			if arg_46_1.time_ >= 0 + var_49_13 and arg_46_1.time_ < 0 + var_49_13 + arg_49_0 then
				var_49_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_14 = 0
			local var_49_15 = 1

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_14 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_16 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(938022011).content)

				arg_46_1.text_.text = var_49_16

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_18 = 40 <= 0 and var_49_15 or var_49_15 * (utf8.len(var_49_16) / 40)

				if (40 <= 0 and var_49_15 or var_49_15 * (utf8.len(var_49_16) / 40)) > 0 and var_49_15 < var_49_18 then
					arg_46_1.talkMaxDuration = var_49_18

					if var_49_18 + var_49_14 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_18 + var_49_14
					end
				end

				arg_46_1.text_.text = var_49_16
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_19 = math.max(var_49_15, arg_46_1.talkMaxDuration)

			if var_49_14 <= arg_46_1.time_ and arg_46_1.time_ < var_49_14 + var_49_19 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_14) / var_49_19

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_14 + var_49_19 and arg_46_1.time_ < var_49_14 + var_49_19 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play938022012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938022012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938022013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["10144"] == nil then
				local var_53_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_53_0) then
					local var_53_1 = Object.Instantiate(var_53_0, arg_50_1.canvasGo_.transform)

					var_53_1.transform:SetSiblingIndex(1)

					var_53_1.name = "10144"
					var_53_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_50_1.actors_["10144"] = var_53_1

					if arg_50_1.isInRecall_ then
						for iter_53_0, iter_53_1 in ipairs((var_53_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_53_1.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_53_2 = arg_50_1.actors_["10144"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps10144 == nil then
				arg_50_1.var_.actorSpriteComps10144 = var_53_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_3 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.actorSpriteComps10144 then
					for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_53_3 then
							if arg_50_1.isInRecall_ then
								iter_53_3.color = Color.New(Mathf.Lerp(iter_53_3.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 0) / var_53_3), Mathf.Lerp(iter_53_3.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 0) / var_53_3), (Mathf.Lerp(iter_53_3.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 0) / var_53_3)))
							else
								local var_53_4 = Mathf.Lerp(iter_53_3.color.r, 1, (arg_50_1.time_ - 0) / var_53_3)

								iter_53_3.color = Color.New(var_53_4, var_53_4, var_53_4)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.actorSpriteComps10144 then
				for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_53_5 then
						iter_53_5.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10144 = nil
			end

			local var_53_5 = arg_50_1.actors_["104902"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.actorSpriteComps104902 == nil then
				arg_50_1.var_.actorSpriteComps104902 = var_53_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_6 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_6 and not isNil(var_53_5) then
				if arg_50_1.var_.actorSpriteComps104902 then
					for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_53_7 then
							if arg_50_1.isInRecall_ then
								iter_53_7.color = Color.New(Mathf.Lerp(iter_53_7.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_6), Mathf.Lerp(iter_53_7.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_6), (Mathf.Lerp(iter_53_7.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_6)))
							else
								local var_53_7 = Mathf.Lerp(iter_53_7.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_6)

								iter_53_7.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_6 and arg_50_1.time_ < 0 + var_53_6 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.actorSpriteComps104902 then
				for iter_53_8, iter_53_9 in pairs(arg_50_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_53_9 then
						iter_53_9.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps104902 = nil
			end

			local var_53_8 = arg_50_1.actors_["10144"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10144 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10144", 4)

				for iter_53_10 = 0, var_53_8.childCount - 1 do
					local var_53_9 = var_53_8:GetChild(iter_53_10)

					if var_53_9.name == "split_5" or not string.find(var_53_9.name, "split") then
						var_53_9.gameObject:SetActive(true)
					else
						var_53_9.gameObject:SetActive(false)
					end
				end
			end

			local var_53_10 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_10 then
				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_50_1.time_ - 0) / var_53_10)
			end

			if arg_50_1.time_ >= 0 + var_53_10 and arg_50_1.time_ < 0 + var_53_10 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_53_11 = arg_50_1.actors_["128404"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos128404 = var_53_11.localPosition
				var_53_11.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("128404", 7)

				for iter_53_11 = 0, var_53_11.childCount - 1 do
					local var_53_12 = var_53_11:GetChild(iter_53_11)

					if var_53_12.name == "" or not string.find(var_53_12.name, "split") then
						var_53_12.gameObject:SetActive(true)
					else
						var_53_12.gameObject:SetActive(false)
					end
				end
			end

			local var_53_13 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_13 then
				var_53_11.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_50_1.time_ - 0) / var_53_13)
			end

			if arg_50_1.time_ >= 0 + var_53_13 and arg_50_1.time_ < 0 + var_53_13 + arg_53_0 then
				var_53_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_14 = 0
			local var_53_15 = 1.45

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_16 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(938022012).content)

				arg_50_1.text_.text = var_53_16

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_18 = 58 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_16) / 58)

				if (58 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_16) / 58)) > 0 and var_53_15 < var_53_18 then
					arg_50_1.talkMaxDuration = var_53_18

					if var_53_18 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_18 + var_53_14
					end
				end

				arg_50_1.text_.text = var_53_16
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_19 = math.max(var_53_15, arg_50_1.talkMaxDuration)

			if var_53_14 <= arg_50_1.time_ and arg_50_1.time_ < var_53_14 + var_53_19 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_14) / var_53_19

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_14 + var_53_19 and arg_50_1.time_ < var_53_14 + var_53_19 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play938022013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938022013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938022014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10144"]) and arg_54_1.var_.actorSpriteComps10144 == nil then
				arg_54_1.var_.actorSpriteComps10144 = arg_54_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10144"]) then
				if arg_54_1.var_.actorSpriteComps10144 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor2.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor2.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor2.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 0.5, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10144"]) and arg_54_1.var_.actorSpriteComps10144 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps10144 = nil
			end

			local var_57_2 = arg_54_1.actors_["10144"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos10144 = var_57_2.localPosition
				var_57_2.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10144", 7)

				for iter_57_4 = 0, var_57_2.childCount - 1 do
					local var_57_3 = var_57_2:GetChild(iter_57_4)

					if var_57_3.name == "" or not string.find(var_57_3.name, "split") then
						var_57_3.gameObject:SetActive(true)
					else
						var_57_3.gameObject:SetActive(false)
					end
				end
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_54_1.time_ - 0) / var_57_4)
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_57_5 = arg_54_1.actors_["104902"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos104902 = var_57_5.localPosition
				var_57_5.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("104902", 7)

				for iter_57_5 = 0, var_57_5.childCount - 1 do
					local var_57_6 = var_57_5:GetChild(iter_57_5)

					if var_57_6.name == "" or not string.find(var_57_6.name, "split") then
						var_57_6.gameObject:SetActive(true)
					else
						var_57_6.gameObject:SetActive(false)
					end
				end
			end

			local var_57_7 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				var_57_5.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_54_1.time_ - 0) / var_57_7)
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				var_57_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_57_8 = 0
			local var_57_9 = 1.35

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(938022013).content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_12 = 54 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_10) / 54)

				if (54 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_10) / 54)) > 0 and var_57_9 < var_57_12 then
					arg_54_1.talkMaxDuration = var_57_12

					if var_57_12 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_13 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_13 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_13

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_13 and arg_54_1.time_ < var_57_8 + var_57_13 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play938022014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938022014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938022015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.175

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(938022014).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 7 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 7)

				if (7 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 7)) > 0 and var_61_0 < var_61_3 then
					arg_58_1.talkMaxDuration = var_61_3

					if var_61_3 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_3 + 0
					end
				end

				arg_58_1.text_.text = var_61_1
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_4 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_4

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play938022015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938022015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938022016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["128404"]) and arg_62_1.var_.actorSpriteComps128404 == nil then
				arg_62_1.var_.actorSpriteComps128404 = arg_62_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["128404"]) then
				if arg_62_1.var_.actorSpriteComps128404 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["128404"]) and arg_62_1.var_.actorSpriteComps128404 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps128404 = nil
			end

			local var_65_2 = arg_62_1.actors_["128404"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos128404 = var_65_2.localPosition
				var_65_2.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("128404", 2)

				for iter_65_4 = 0, var_65_2.childCount - 1 do
					local var_65_3 = var_65_2:GetChild(iter_65_4)

					if var_65_3.name == "split_3" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_2.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_62_1.time_ - 0) / var_65_4)
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_65_5 = 0
			local var_65_6 = 1.25

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_7 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(938022015).content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 50 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 50)

				if (50 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 50)) > 0 and var_65_6 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_5 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_5
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_6, arg_62_1.talkMaxDuration)

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_5) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_5 + var_65_10 and arg_62_1.time_ < var_65_5 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play938022016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938022016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938022017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["108301"]) and arg_66_1.var_.actorSpriteComps108301 == nil then
				arg_66_1.var_.actorSpriteComps108301 = arg_66_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["108301"]) then
				if arg_66_1.var_.actorSpriteComps108301 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 1, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["108301"]) and arg_66_1.var_.actorSpriteComps108301 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps108301 = nil
			end

			local var_69_2 = arg_66_1.actors_["128404"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps128404 == nil then
				arg_66_1.var_.actorSpriteComps128404 = var_69_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_3 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.actorSpriteComps128404 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								iter_69_5.color = Color.New(Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_3), Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_3), (Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_3)))
							else
								local var_69_4 = Mathf.Lerp(iter_69_5.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_3)

								iter_69_5.color = Color.New(var_69_4, var_69_4, var_69_4)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps128404 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_69_7 then
						iter_69_7.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps128404 = nil
			end

			local var_69_5 = arg_66_1.actors_["108301"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos108301 = var_69_5.localPosition
				var_69_5.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("108301", 4)

				for iter_69_8 = 0, var_69_5.childCount - 1 do
					local var_69_6 = var_69_5:GetChild(iter_69_8)

					if var_69_6.name == "split_1" or not string.find(var_69_6.name, "split") then
						var_69_6.gameObject:SetActive(true)
					else
						var_69_6.gameObject:SetActive(false)
					end
				end
			end

			local var_69_7 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				var_69_5.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_66_1.time_ - 0) / var_69_7)
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				var_69_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_69_8 = 0
			local var_69_9 = 1.175

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_10 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(938022016).content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_12 = 47 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_10) / 47)

				if (47 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_10) / 47)) > 0 and var_69_9 < var_69_12 then
					arg_66_1.talkMaxDuration = var_69_12

					if var_69_12 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_13 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_13 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_13

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_13 and arg_66_1.time_ < var_69_8 + var_69_13 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play938022017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 938022017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play938022018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["128404"]) and arg_70_1.var_.actorSpriteComps128404 == nil then
				arg_70_1.var_.actorSpriteComps128404 = arg_70_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["128404"]) then
				if arg_70_1.var_.actorSpriteComps128404 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["128404"]) and arg_70_1.var_.actorSpriteComps128404 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps128404 = nil
			end

			local var_73_2 = arg_70_1.actors_["108301"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps108301 == nil then
				arg_70_1.var_.actorSpriteComps108301 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps108301 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_5.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_5.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps108301 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps108301 = nil
			end

			local var_73_5 = arg_70_1.actors_["128404"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos128404 = var_73_5.localPosition
				var_73_5.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("128404", 2)

				for iter_73_8 = 0, var_73_5.childCount - 1 do
					local var_73_6 = var_73_5:GetChild(iter_73_8)

					if var_73_6.name == "split_4" then
						var_73_6:SetAsLastSibling()
						var_73_6.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit128404 = var_73_6.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_73_7 = 0.5

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_70_1.time_ - 0) / var_73_7)

				if arg_70_1.var_.actorSpriteSplit128404 ~= nil then
					arg_70_1.var_.actorSpriteSplit128404:SetAlpha((arg_70_1.time_ - 0) / var_73_7)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_70_1.var_.actorSpriteSplit128404 ~= nil then
					arg_70_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_73_8 = 0
			local var_73_9 = 0.75

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(938022017).content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_12 = 30 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_10) / 30)

				if (30 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_10) / 30)) > 0 and var_73_9 < var_73_12 then
					arg_70_1.talkMaxDuration = var_73_12

					if var_73_12 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_13 and arg_70_1.time_ < var_73_8 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play938022018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 938022018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play938022019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["128404"]) and arg_74_1.var_.actorSpriteComps128404 == nil then
				arg_74_1.var_.actorSpriteComps128404 = arg_74_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["128404"]) then
				if arg_74_1.var_.actorSpriteComps128404 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["128404"]) and arg_74_1.var_.actorSpriteComps128404 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps128404 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 1.125

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(938022018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 45 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 45)

				if (45 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 45)) > 0 and var_77_3 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_7 and arg_74_1.time_ < var_77_2 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play938022019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938022019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938022020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["106603"]) and arg_78_1.var_.actorSpriteComps106603 == nil then
				arg_78_1.var_.actorSpriteComps106603 = arg_78_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["106603"]) then
				if arg_78_1.var_.actorSpriteComps106603 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								iter_81_1.color = Color.New(Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, (arg_78_1.time_ - 0) / var_81_0), Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, (arg_78_1.time_ - 0) / var_81_0), (Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, (arg_78_1.time_ - 0) / var_81_0)))
							else
								local var_81_1 = Mathf.Lerp(iter_81_1.color.r, 1, (arg_78_1.time_ - 0) / var_81_0)

								iter_81_1.color = Color.New(var_81_1, var_81_1, var_81_1)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["106603"]) and arg_78_1.var_.actorSpriteComps106603 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps106603 = nil
			end

			local var_81_2 = arg_78_1.actors_["106603"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos106603 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("106603", 3)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_78_1.time_ - 0) / var_81_4)
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_81_5 = arg_78_1.actors_["128404"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos128404 = var_81_5.localPosition
				var_81_5.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("128404", 7)

				for iter_81_5 = 0, var_81_5.childCount - 1 do
					local var_81_6 = var_81_5:GetChild(iter_81_5)

					if var_81_6.name == "" or not string.find(var_81_6.name, "split") then
						var_81_6.gameObject:SetActive(true)
					else
						var_81_6.gameObject:SetActive(false)
					end
				end
			end

			local var_81_7 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				var_81_5.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_78_1.time_ - 0) / var_81_7)
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				var_81_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_8 = arg_78_1.actors_["108301"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos108301 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("108301", 7)

				for iter_81_6 = 0, var_81_8.childCount - 1 do
					local var_81_9 = var_81_8:GetChild(iter_81_6)

					if var_81_9.name == "" or not string.find(var_81_9.name, "split") then
						var_81_9.gameObject:SetActive(true)
					else
						var_81_9.gameObject:SetActive(false)
					end
				end
			end

			local var_81_10 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_10 then
				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_78_1.time_ - 0) / var_81_10)
			end

			if arg_78_1.time_ >= 0 + var_81_10 and arg_78_1.time_ < 0 + var_81_10 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_11 = 0
			local var_81_12 = 0.525

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_13 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(938022019).content)

				arg_78_1.text_.text = var_81_13

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 21 <= 0 and var_81_12 or var_81_12 * (utf8.len(var_81_13) / 21)

				if (21 <= 0 and var_81_12 or var_81_12 * (utf8.len(var_81_13) / 21)) > 0 and var_81_12 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_13
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_16 and arg_78_1.time_ < var_81_11 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play938022020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938022020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938022021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["106603"]) and arg_82_1.var_.actorSpriteComps106603 == nil then
				arg_82_1.var_.actorSpriteComps106603 = arg_82_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["106603"]) then
				if arg_82_1.var_.actorSpriteComps106603 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 0.5, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["106603"]) and arg_82_1.var_.actorSpriteComps106603 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_82_1.var_.actorSpriteComps106603 = nil
			end

			local var_85_2 = 0
			local var_85_3 = 1.325

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(938022020).content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 53 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 53)

				if (53 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 53)) > 0 and var_85_3 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_7 and arg_82_1.time_ < var_85_2 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play938022021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938022021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938022022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10144"]) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = arg_86_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10144"]) then
				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 1, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10144"]) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_2 = arg_86_1.actors_["10144"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10144 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10144", 3)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "split_2" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_89_5 = 0
			local var_89_6 = 1.225

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(938022021).content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 49 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 49)

				if (49 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 49)) > 0 and var_89_6 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_5
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_6, arg_86_1.talkMaxDuration)

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_5) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_5 + var_89_10 and arg_86_1.time_ < var_89_5 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play938022022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938022022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938022023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10144 = arg_90_1.actors_["10144"].transform.localPosition
				arg_90_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10144", 3)

				for iter_93_0 = 0, arg_90_1.actors_["10144"].transform.childCount - 1 do
					local var_93_0 = arg_90_1.actors_["10144"].transform:GetChild(iter_93_0)

					if var_93_0.name == "" or not string.find(var_93_0.name, "split") then
						var_93_0.gameObject:SetActive(true)
					else
						var_93_0.gameObject:SetActive(false)
					end
				end
			end

			local var_93_1 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 then
				arg_90_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_90_1.time_ - 0) / var_93_1)
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 then
				arg_90_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_93_2 = 0
			local var_93_3 = 1.025

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(938022022).content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 41 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 41)

				if (41 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 41)) > 0 and var_93_3 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_7 and arg_90_1.time_ < var_93_2 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938022023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938022023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938022024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10144"]) and arg_94_1.var_.actorSpriteComps10144 == nil then
				arg_94_1.var_.actorSpriteComps10144 = arg_94_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10144"]) then
				if arg_94_1.var_.actorSpriteComps10144 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10144"]) and arg_94_1.var_.actorSpriteComps10144 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps10144 = nil
			end

			local var_97_2 = 0
			local var_97_3 = 0.125

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(938022023).content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_6 = 5 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_4) / 5)

				if (5 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_4) / 5)) > 0 and var_97_3 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_7 and arg_94_1.time_ < var_97_2 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play938022024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938022024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938022025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["108301"]) and arg_98_1.var_.actorSpriteComps108301 == nil then
				arg_98_1.var_.actorSpriteComps108301 = arg_98_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["108301"]) then
				if arg_98_1.var_.actorSpriteComps108301 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 1, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["108301"]) and arg_98_1.var_.actorSpriteComps108301 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_98_1.var_.actorSpriteComps108301 = nil
			end

			local var_101_2 = arg_98_1.actors_["108301"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos108301 = var_101_2.localPosition
				var_101_2.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("108301", 2)

				for iter_101_4 = 0, var_101_2.childCount - 1 do
					local var_101_3 = var_101_2:GetChild(iter_101_4)

					if var_101_3.name == "split_2" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_98_1.time_ - 0) / var_101_4)
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_101_5 = arg_98_1.actors_["10144"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10144 = var_101_5.localPosition
				var_101_5.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("10144", 7)

				for iter_101_5 = 0, var_101_5.childCount - 1 do
					local var_101_6 = var_101_5:GetChild(iter_101_5)

					if var_101_6.name == "" or not string.find(var_101_6.name, "split") then
						var_101_6.gameObject:SetActive(true)
					else
						var_101_6.gameObject:SetActive(false)
					end
				end
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_98_1.time_ - 0) / var_101_7)
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_101_8 = 0
			local var_101_9 = 0.2

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(938022024).content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_12 = 8 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_10) / 8)

				if (8 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_10) / 8)) > 0 and var_101_9 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_13 and arg_98_1.time_ < var_101_8 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play938022025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938022025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938022026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["10144"]) and arg_102_1.var_.actorSpriteComps10144 == nil then
				arg_102_1.var_.actorSpriteComps10144 = arg_102_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["10144"]) then
				if arg_102_1.var_.actorSpriteComps10144 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 1, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["10144"]) and arg_102_1.var_.actorSpriteComps10144 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps10144 = nil
			end

			local var_105_2 = arg_102_1.actors_["108301"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps108301 == nil then
				arg_102_1.var_.actorSpriteComps108301 = var_105_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_3 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.actorSpriteComps108301 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								iter_105_5.color = Color.New(Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_3), Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_3), (Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_3)))
							else
								local var_105_4 = Mathf.Lerp(iter_105_5.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_3)

								iter_105_5.color = Color.New(var_105_4, var_105_4, var_105_4)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps108301 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_105_7 then
						iter_105_7.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps108301 = nil
			end

			local var_105_5 = arg_102_1.actors_["10144"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10144 = var_105_5.localPosition
				var_105_5.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("10144", 4)

				for iter_105_8 = 0, var_105_5.childCount - 1 do
					local var_105_6 = var_105_5:GetChild(iter_105_8)

					if var_105_6.name == "" or not string.find(var_105_6.name, "split") then
						var_105_6.gameObject:SetActive(true)
					else
						var_105_6.gameObject:SetActive(false)
					end
				end
			end

			local var_105_7 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				var_105_5.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_102_1.time_ - 0) / var_105_7)
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				var_105_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_105_8 = 0
			local var_105_9 = 1.125

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(938022025).content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_12 = 45 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_10) / 45)

				if (45 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_10) / 45)) > 0 and var_105_9 < var_105_12 then
					arg_102_1.talkMaxDuration = var_105_12

					if var_105_12 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_13 and arg_102_1.time_ < var_105_8 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938022026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938022026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938022027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10144"]) and arg_106_1.var_.actorSpriteComps10144 == nil then
				arg_106_1.var_.actorSpriteComps10144 = arg_106_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10144"]) then
				if arg_106_1.var_.actorSpriteComps10144 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor2.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor2.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor2.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 0.5, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10144"]) and arg_106_1.var_.actorSpriteComps10144 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps10144 = nil
			end

			local var_109_2 = arg_106_1.actors_["10144"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10144 = var_109_2.localPosition
				var_109_2.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("10144", 7)

				for iter_109_4 = 0, var_109_2.childCount - 1 do
					local var_109_3 = var_109_2:GetChild(iter_109_4)

					if var_109_3.name == "" or not string.find(var_109_3.name, "split") then
						var_109_3.gameObject:SetActive(true)
					else
						var_109_3.gameObject:SetActive(false)
					end
				end
			end

			local var_109_4 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				var_109_2.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_106_1.time_ - 0) / var_109_4)
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				var_109_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_109_5 = arg_106_1.actors_["108301"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_5.localPosition
				var_109_5.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 7)

				for iter_109_5 = 0, var_109_5.childCount - 1 do
					local var_109_6 = var_109_5:GetChild(iter_109_5)

					if var_109_6.name == "" or not string.find(var_109_6.name, "split") then
						var_109_6.gameObject:SetActive(true)
					else
						var_109_6.gameObject:SetActive(false)
					end
				end
			end

			local var_109_7 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_106_1.time_ - 0) / var_109_7)
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_109_8 = 0
			local var_109_9 = 1.575

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(938022026).content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_12 = 63 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 63)

				if (63 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 63)) > 0 and var_109_9 < var_109_12 then
					arg_106_1.talkMaxDuration = var_109_12

					if var_109_12 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_13 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_13 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_13

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_13 and arg_106_1.time_ < var_109_8 + var_109_13 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play938022027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938022027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938022028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["108301"]) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = arg_110_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["108301"]) then
				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								iter_113_1.color = Color.New(Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, (arg_110_1.time_ - 0) / var_113_0), Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, (arg_110_1.time_ - 0) / var_113_0), (Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, (arg_110_1.time_ - 0) / var_113_0)))
							else
								local var_113_1 = Mathf.Lerp(iter_113_1.color.r, 1, (arg_110_1.time_ - 0) / var_113_0)

								iter_113_1.color = Color.New(var_113_1, var_113_1, var_113_1)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["108301"]) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_2 = arg_110_1.actors_["108301"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos108301 = var_113_2.localPosition
				var_113_2.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("108301", 3)

				for iter_113_4 = 0, var_113_2.childCount - 1 do
					local var_113_3 = var_113_2:GetChild(iter_113_4)

					if var_113_3.name == "split_3" or not string.find(var_113_3.name, "split") then
						var_113_3.gameObject:SetActive(true)
					else
						var_113_3.gameObject:SetActive(false)
					end
				end
			end

			local var_113_4 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_110_1.time_ - 0) / var_113_4)
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_113_5 = 0
			local var_113_6 = 0.55

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_7 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(938022027).content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 22 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 22)

				if (22 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 22)) > 0 and var_113_6 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_5
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_6, arg_110_1.talkMaxDuration)

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_5) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_5 + var_113_10 and arg_110_1.time_ < var_113_5 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play938022028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938022028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938022029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = arg_114_1.actors_["108301"].transform.localPosition
				arg_114_1.actors_["108301"].transform.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 3)

				for iter_117_0 = 0, arg_114_1.actors_["108301"].transform.childCount - 1 do
					local var_117_0 = arg_114_1.actors_["108301"].transform:GetChild(iter_117_0)

					if var_117_0.name == "split_2" then
						var_117_0:SetAsLastSibling()
						var_117_0.gameObject:SetActive(true)

						arg_114_1.var_.actorSpriteSplit108301 = var_117_0.gameObject:GetComponent(typeof(Image))

						arg_114_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_117_1 = 0.5

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["108301"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_114_1.time_ - 0) / var_117_1)

				if arg_114_1.var_.actorSpriteSplit108301 ~= nil then
					arg_114_1.var_.actorSpriteSplit108301:SetAlpha((arg_114_1.time_ - 0) / var_117_1)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["108301"].transform.localPosition = Vector3.New(0, -360, -195)

				if arg_114_1.var_.actorSpriteSplit108301 ~= nil then
					arg_114_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_117_2 = 0
			local var_117_3 = 1.025

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(938022028).content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 41 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 41)

				if (41 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 41)) > 0 and var_117_3 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_7 and arg_114_1.time_ < var_117_2 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938022029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938022029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938022030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["108301"]) and arg_118_1.var_.actorSpriteComps108301 == nil then
				arg_118_1.var_.actorSpriteComps108301 = arg_118_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["108301"]) then
				if arg_118_1.var_.actorSpriteComps108301 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["108301"]) and arg_118_1.var_.actorSpriteComps108301 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps108301 = nil
			end

			local var_121_2 = 0
			local var_121_3 = 1.375

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_4 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(938022029).content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_6 = 55 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_4) / 55)

				if (55 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_4) / 55)) > 0 and var_121_3 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_7 and arg_118_1.time_ < var_121_2 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play938022030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938022030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938022031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["108301"]) and arg_122_1.var_.actorSpriteComps108301 == nil then
				arg_122_1.var_.actorSpriteComps108301 = arg_122_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["108301"]) then
				if arg_122_1.var_.actorSpriteComps108301 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 1, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["108301"]) and arg_122_1.var_.actorSpriteComps108301 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps108301 = nil
			end

			local var_125_2 = arg_122_1.actors_["108301"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos108301 = var_125_2.localPosition
				var_125_2.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("108301", 3)

				for iter_125_4 = 0, var_125_2.childCount - 1 do
					local var_125_3 = var_125_2:GetChild(iter_125_4)

					if var_125_3.name == "split_5" then
						var_125_3:SetAsLastSibling()
						var_125_3.gameObject:SetActive(true)

						arg_122_1.var_.actorSpriteSplit108301 = var_125_3.gameObject:GetComponent(typeof(Image))

						arg_122_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_125_4 = 0.5

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				var_125_2.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_122_1.time_ - 0) / var_125_4)

				if arg_122_1.var_.actorSpriteSplit108301 ~= nil then
					arg_122_1.var_.actorSpriteSplit108301:SetAlpha((arg_122_1.time_ - 0) / var_125_4)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				var_125_2.localPosition = Vector3.New(0, -360, -195)

				if arg_122_1.var_.actorSpriteSplit108301 ~= nil then
					arg_122_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_125_5 = 0
			local var_125_6 = 1.1

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_7 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(938022030).content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 44 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_7) / 44)

				if (44 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_7) / 44)) > 0 and var_125_6 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_5
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_6, arg_122_1.talkMaxDuration)

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_5) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_5 + var_125_10 and arg_122_1.time_ < var_125_5 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play938022031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938022031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938022032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["108301"]) and arg_126_1.var_.actorSpriteComps108301 == nil then
				arg_126_1.var_.actorSpriteComps108301 = arg_126_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["108301"]) then
				if arg_126_1.var_.actorSpriteComps108301 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["108301"]) and arg_126_1.var_.actorSpriteComps108301 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps108301 = nil
			end

			local var_129_2 = 0
			local var_129_3 = 1.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_4 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(938022031).content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 64 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_4) / 64)

				if (64 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_4) / 64)) > 0 and var_129_3 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_7 and arg_126_1.time_ < var_129_2 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play938022032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938022032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938022033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["108301"]) and arg_130_1.var_.actorSpriteComps108301 == nil then
				arg_130_1.var_.actorSpriteComps108301 = arg_130_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["108301"]) then
				if arg_130_1.var_.actorSpriteComps108301 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 1, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["108301"]) and arg_130_1.var_.actorSpriteComps108301 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_130_1.var_.actorSpriteComps108301 = nil
			end

			local var_133_2 = arg_130_1.actors_["108301"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos108301 = var_133_2.localPosition
				var_133_2.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("108301", 3)

				for iter_133_4 = 0, var_133_2.childCount - 1 do
					local var_133_3 = var_133_2:GetChild(iter_133_4)

					if var_133_3.name == "split_5" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_130_1.time_ - 0) / var_133_4)
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_133_5 = 0
			local var_133_6 = 0.75

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(938022032).content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 30 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 30)

				if (30 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 30)) > 0 and var_133_6 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_10 and arg_130_1.time_ < var_133_5 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play938022033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 938022033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play938022034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["108301"]) and arg_134_1.var_.actorSpriteComps108301 == nil then
				arg_134_1.var_.actorSpriteComps108301 = arg_134_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["108301"]) then
				if arg_134_1.var_.actorSpriteComps108301 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["108301"]) and arg_134_1.var_.actorSpriteComps108301 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps108301 = nil
			end

			local var_137_2 = 0
			local var_137_3 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_4 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(938022033).content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_6 = 40 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_4) / 40)

				if (40 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_4) / 40)) > 0 and var_137_3 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_7 and arg_134_1.time_ < var_137_2 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play938022034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 938022034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play938022035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10144"]) and arg_138_1.var_.actorSpriteComps10144 == nil then
				arg_138_1.var_.actorSpriteComps10144 = arg_138_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10144"]) then
				if arg_138_1.var_.actorSpriteComps10144 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 1, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10144"]) and arg_138_1.var_.actorSpriteComps10144 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps10144 = nil
			end

			local var_141_2 = arg_138_1.actors_["108301"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos108301 = var_141_2.localPosition
				var_141_2.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("108301", 7)

				for iter_141_4 = 0, var_141_2.childCount - 1 do
					local var_141_3 = var_141_2:GetChild(iter_141_4)

					if var_141_3.name == "" or not string.find(var_141_3.name, "split") then
						var_141_3.gameObject:SetActive(true)
					else
						var_141_3.gameObject:SetActive(false)
					end
				end
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_2.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_138_1.time_ - 0) / var_141_4)
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_141_5 = arg_138_1.actors_["10144"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10144 = var_141_5.localPosition
				var_141_5.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10144", 3)

				for iter_141_5 = 0, var_141_5.childCount - 1 do
					local var_141_6 = var_141_5:GetChild(iter_141_5)

					if var_141_6.name == "split_2" or not string.find(var_141_6.name, "split") then
						var_141_6.gameObject:SetActive(true)
					else
						var_141_6.gameObject:SetActive(false)
					end
				end
			end

			local var_141_7 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_138_1.time_ - 0) / var_141_7)
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_141_8 = 0
			local var_141_9 = 0.875

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_10 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(938022034).content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_12 = 35 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_10) / 35)

				if (35 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_10) / 35)) > 0 and var_141_9 < var_141_12 then
					arg_138_1.talkMaxDuration = var_141_12

					if var_141_12 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_8
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_9, arg_138_1.talkMaxDuration)

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_8) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_8 + var_141_13 and arg_138_1.time_ < var_141_8 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play938022035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 938022035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play938022036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10144 = arg_142_1.actors_["10144"].transform.localPosition
				arg_142_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10144", 3)

				for iter_145_0 = 0, arg_142_1.actors_["10144"].transform.childCount - 1 do
					local var_145_0 = arg_142_1.actors_["10144"].transform:GetChild(iter_145_0)

					if var_145_0.name == "split_5" then
						var_145_0:SetAsLastSibling()
						var_145_0.gameObject:SetActive(true)

						arg_142_1.var_.actorSpriteSplit10144 = var_145_0.gameObject:GetComponent(typeof(Image))

						arg_142_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_145_1 = 0.5

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_142_1.time_ - 0) / var_145_1)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha((arg_142_1.time_ - 0) / var_145_1)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_145_2 = 0
			local var_145_3 = 0.475

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(938022035).content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 19 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_4) / 19)

				if (19 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_4) / 19)) > 0 and var_145_3 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_7 and arg_142_1.time_ < var_145_2 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play938022036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 938022036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play938022037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10144"]) and arg_146_1.var_.actorSpriteComps10144 == nil then
				arg_146_1.var_.actorSpriteComps10144 = arg_146_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10144"]) then
				if arg_146_1.var_.actorSpriteComps10144 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10144"]) and arg_146_1.var_.actorSpriteComps10144 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps10144 = nil
			end

			local var_149_2 = 0
			local var_149_3 = 0.125

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_4 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(938022036).content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 5 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 5)

				if (5 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 5)) > 0 and var_149_3 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_7 and arg_146_1.time_ < var_149_2 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play938022037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 938022037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play938022038(arg_150_1)
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

					if var_153_3.name == "split_1" then
						var_153_3:SetAsLastSibling()
						var_153_3.gameObject:SetActive(true)

						arg_150_1.var_.actorSpriteSplit10144 = var_153_3.gameObject:GetComponent(typeof(Image))

						arg_150_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_153_4 = 0.5

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				var_153_2.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_150_1.time_ - 0) / var_153_4)

				if arg_150_1.var_.actorSpriteSplit10144 ~= nil then
					arg_150_1.var_.actorSpriteSplit10144:SetAlpha((arg_150_1.time_ - 0) / var_153_4)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				var_153_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_150_1.var_.actorSpriteSplit10144 ~= nil then
					arg_150_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_153_5 = 0
			local var_153_6 = 1.775

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
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

				local var_153_7 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(938022037).content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 71 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_7) / 71)

				if (71 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_7) / 71)) > 0 and var_153_6 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_10 and arg_150_1.time_ < var_153_5 + var_153_10 + arg_153_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play938022038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938022038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938022039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10144"]) and arg_154_1.var_.actorSpriteComps10144 == nil then
				arg_154_1.var_.actorSpriteComps10144 = arg_154_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10144"]) then
				if arg_154_1.var_.actorSpriteComps10144 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10144"]) and arg_154_1.var_.actorSpriteComps10144 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps10144 = nil
			end

			local var_157_2 = 0
			local var_157_3 = 1.5

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_4 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(938022038).content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_6 = 60 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 60)

				if (60 <= 0 and var_157_3 or var_157_3 * (utf8.len(var_157_4) / 60)) > 0 and var_157_3 < var_157_6 then
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

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play938022039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938022039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938022040(arg_158_1)
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
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor1.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor1.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor1.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 1, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10144"]) and arg_158_1.var_.actorSpriteComps10144 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_158_1.var_.actorSpriteComps10144 = nil
			end

			local var_161_2 = arg_158_1.actors_["10144"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10144 = var_161_2.localPosition
				var_161_2.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10144", 3)

				for iter_161_4 = 0, var_161_2.childCount - 1 do
					local var_161_3 = var_161_2:GetChild(iter_161_4)

					if var_161_3.name == "split_3" then
						var_161_3:SetAsLastSibling()
						var_161_3.gameObject:SetActive(true)

						arg_158_1.var_.actorSpriteSplit10144 = var_161_3.gameObject:GetComponent(typeof(Image))

						arg_158_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_161_4 = 0.5

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				var_161_2.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_158_1.time_ - 0) / var_161_4)

				if arg_158_1.var_.actorSpriteSplit10144 ~= nil then
					arg_158_1.var_.actorSpriteSplit10144:SetAlpha((arg_158_1.time_ - 0) / var_161_4)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_158_1.var_.actorSpriteSplit10144 ~= nil then
					arg_158_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_161_5 = 0
			local var_161_6 = 1.625

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_7 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(938022039).content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 65 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 65)

				if (65 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 65)) > 0 and var_161_6 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_5
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_6, arg_158_1.talkMaxDuration)

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_5) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_5 + var_161_10 and arg_158_1.time_ < var_161_5 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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

		arg_158_1:InitPlayNodeList()
	end,
	Play938022040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938022040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938022041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10144 = arg_162_1.actors_["10144"].transform.localPosition
				arg_162_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10144", 3)

				for iter_165_0 = 0, arg_162_1.actors_["10144"].transform.childCount - 1 do
					local var_165_0 = arg_162_1.actors_["10144"].transform:GetChild(iter_165_0)

					if var_165_0.name == "" then
						var_165_0:SetAsLastSibling()
						var_165_0.gameObject:SetActive(true)

						arg_162_1.var_.actorSpriteSplit10144 = var_165_0.gameObject:GetComponent(typeof(Image))

						arg_162_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_165_1 = 0.5

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_162_1.time_ - 0) / var_165_1)

				if arg_162_1.var_.actorSpriteSplit10144 ~= nil then
					arg_162_1.var_.actorSpriteSplit10144:SetAlpha((arg_162_1.time_ - 0) / var_165_1)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_162_1.var_.actorSpriteSplit10144 ~= nil then
					arg_162_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_165_2 = 0
			local var_165_3 = 0.9

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(938022040).content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 36 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 36)

				if (36 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 36)) > 0 and var_165_3 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_7 and arg_162_1.time_ < var_165_2 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play938022041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938022041
		arg_166_1.duration_ = 5.9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938022042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_9000

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10144"]) and arg_166_1.var_.actorSpriteComps10144 == nil then
				arg_166_1.var_.actorSpriteComps10144 = arg_166_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10144"]) then
				if arg_166_1.var_.actorSpriteComps10144 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10144"]) and arg_166_1.var_.actorSpriteComps10144 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps10144 = nil
			end

			local var_169_2 = arg_166_1.actors_["10144"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10144 = var_169_2.localPosition
				var_169_2.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10144", 7)

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
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_166_1.time_ - 0) / var_169_4)
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_5 = manager.ui.mainCamera.transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.shakeOldPos = var_169_5.localPosition
			end

			local var_169_6 = 2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 then
				local var_169_7, var_169_8 = math.modf((arg_166_1.time_ - 0) / 0.066)

				var_169_5.localPosition = Vector3.New(var_169_8 * 0.13, var_169_8 * 0.13, var_169_8 * 0.13) + arg_166_1.var_.shakeOldPos
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 then
				var_169_5.localPosition = arg_166_1.var_.shakeOldPos
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				local var_169_9 = arg_166_1.var_.effecttaizixiajiang1

				if not arg_166_1.var_.effecttaizixiajiang1 then
					var_169_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_169_9.name = "taizixiajiang1"
					arg_166_1.var_.effecttaizixiajiang1 = var_169_9
				else
					var_169_9.transform:SetParent(var_169_9000)
				end

				var_169_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_169_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_169_9.transform.localScale = Vector3.New(var_169_9.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_169_9.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_169_9.transform.localScale.z)
			end

			local var_169_11 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_11 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_11 + 2 and arg_166_1.time_ < var_169_11 + 2 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_12 = 0.9
			local var_169_13 = 1.1

			if 0.9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_12 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_14 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_14:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_15 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(938022041).content)

				arg_166_1.text_.text = var_169_15

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_17 = 44 <= 0 and var_169_13 or var_169_13 * (utf8.len(var_169_15) / 44)

				if (44 <= 0 and var_169_13 or var_169_13 * (utf8.len(var_169_15) / 44)) > 0 and var_169_13 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17
					var_169_12 = var_169_12 + 0.3

					if var_169_17 + var_169_12 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_12
					end
				end

				arg_166_1.text_.text = var_169_15
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_18 = var_169_12 + 0.3
			local var_169_19 = math.max(var_169_13, arg_166_1.talkMaxDuration)

			if var_169_12 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_19 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_18) / var_169_19

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_18 + var_169_19 and arg_166_1.time_ < var_169_18 + var_169_19 + arg_169_0 then
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
	Play938022042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 938022042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play938022043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.675

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(938022042).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 67 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 67)

				if (67 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 67)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play938022043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 938022043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play938022044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["10144"]) and arg_176_1.var_.actorSpriteComps10144 == nil then
				arg_176_1.var_.actorSpriteComps10144 = arg_176_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["10144"]) then
				if arg_176_1.var_.actorSpriteComps10144 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["10144"]) and arg_176_1.var_.actorSpriteComps10144 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_179_3 then
						iter_179_3.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps10144 = nil
			end

			local var_179_2 = arg_176_1.actors_["10144"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10144 = var_179_2.localPosition
				var_179_2.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10144", 3)

				for iter_179_4 = 0, var_179_2.childCount - 1 do
					local var_179_3 = var_179_2:GetChild(iter_179_4)

					if var_179_3.name == "split_2" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_176_1.time_ - 0) / var_179_4)
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_179_5 = 0
			local var_179_6 = 0.775

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(938022043).content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 31 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 31)

				if (31 <= 0 and var_179_6 or var_179_6 * (utf8.len(var_179_7) / 31)) > 0 and var_179_6 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_10 and arg_176_1.time_ < var_179_5 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play938022044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 938022044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play938022045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10144"]) and arg_180_1.var_.actorSpriteComps10144 == nil then
				arg_180_1.var_.actorSpriteComps10144 = arg_180_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10144"]) then
				if arg_180_1.var_.actorSpriteComps10144 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10144"]) and arg_180_1.var_.actorSpriteComps10144 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10144 = nil
			end

			local var_183_2 = 0
			local var_183_3 = 1.075

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(938022044).content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 43 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_4) / 43)

				if (43 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_4) / 43)) > 0 and var_183_3 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_7 and arg_180_1.time_ < var_183_2 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play938022045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 938022045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play938022046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10144"]) and arg_184_1.var_.actorSpriteComps10144 == nil then
				arg_184_1.var_.actorSpriteComps10144 = arg_184_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10144"]) then
				if arg_184_1.var_.actorSpriteComps10144 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10144"]) and arg_184_1.var_.actorSpriteComps10144 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps10144 = nil
			end

			local var_187_2 = arg_184_1.actors_["10144"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10144 = var_187_2.localPosition
				var_187_2.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10144", 3)

				for iter_187_4 = 0, var_187_2.childCount - 1 do
					local var_187_3 = var_187_2:GetChild(iter_187_4)

					if var_187_3.name == "split_1" then
						var_187_3:SetAsLastSibling()
						var_187_3.gameObject:SetActive(true)

						arg_184_1.var_.actorSpriteSplit10144 = var_187_3.gameObject:GetComponent(typeof(Image))

						arg_184_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_187_4 = 0.5

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				var_187_2.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_184_1.time_ - 0) / var_187_4)

				if arg_184_1.var_.actorSpriteSplit10144 ~= nil then
					arg_184_1.var_.actorSpriteSplit10144:SetAlpha((arg_184_1.time_ - 0) / var_187_4)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				var_187_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_184_1.var_.actorSpriteSplit10144 ~= nil then
					arg_184_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_187_5 = 0
			local var_187_6 = 1.025

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(938022045).content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 41 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_7) / 41)

				if (41 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_7) / 41)) > 0 and var_187_6 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_10 and arg_184_1.time_ < var_187_5 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play938022046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 938022046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play938022047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10144 = arg_188_1.actors_["10144"].transform.localPosition
				arg_188_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10144", 3)

				for iter_191_0 = 0, arg_188_1.actors_["10144"].transform.childCount - 1 do
					local var_191_0 = arg_188_1.actors_["10144"].transform:GetChild(iter_191_0)

					if var_191_0.name == "" or not string.find(var_191_0.name, "split") then
						var_191_0.gameObject:SetActive(true)
					else
						var_191_0.gameObject:SetActive(false)
					end
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_188_1.time_ - 0) / var_191_1)
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_191_2 = 0
			local var_191_3 = 1.55

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(938022046).content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_6 = 62 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_4) / 62)

				if (62 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_4) / 62)) > 0 and var_191_3 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_7 and arg_188_1.time_ < var_191_2 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play938022047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 938022047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play938022048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10144"]) and arg_192_1.var_.actorSpriteComps10144 == nil then
				arg_192_1.var_.actorSpriteComps10144 = arg_192_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10144"]) then
				if arg_192_1.var_.actorSpriteComps10144 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10144"]) and arg_192_1.var_.actorSpriteComps10144 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10144 = nil
			end

			local var_195_2 = 0
			local var_195_3 = 0.25

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_4 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(938022047).content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_6 = 10 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 10)

				if (10 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 10)) > 0 and var_195_3 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_2 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_2
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_3, arg_192_1.talkMaxDuration)

			if var_195_2 <= arg_192_1.time_ and arg_192_1.time_ < var_195_2 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_2) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_2 + var_195_7 and arg_192_1.time_ < var_195_2 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play938022048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 938022048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play938022049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10144"]) and arg_196_1.var_.actorSpriteComps10144 == nil then
				arg_196_1.var_.actorSpriteComps10144 = arg_196_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10144"]) then
				if arg_196_1.var_.actorSpriteComps10144 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10144"]) and arg_196_1.var_.actorSpriteComps10144 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10144 = nil
			end

			local var_199_2 = arg_196_1.actors_["10144"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_2.localPosition
				var_199_2.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 3)

				for iter_199_4 = 0, var_199_2.childCount - 1 do
					local var_199_3 = var_199_2:GetChild(iter_199_4)

					if var_199_3.name == "split_7" then
						var_199_3:SetAsLastSibling()
						var_199_3.gameObject:SetActive(true)

						arg_196_1.var_.actorSpriteSplit10144 = var_199_3.gameObject:GetComponent(typeof(Image))

						arg_196_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_199_4 = 0.5

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				var_199_2.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_196_1.time_ - 0) / var_199_4)

				if arg_196_1.var_.actorSpriteSplit10144 ~= nil then
					arg_196_1.var_.actorSpriteSplit10144:SetAlpha((arg_196_1.time_ - 0) / var_199_4)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				var_199_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_196_1.var_.actorSpriteSplit10144 ~= nil then
					arg_196_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_199_5 = 0
			local var_199_6 = 1.5

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(938022048).content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 60 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 60)

				if (60 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 60)) > 0 and var_199_6 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_10 and arg_196_1.time_ < var_199_5 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play938022049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 938022049
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play938022050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 2 < arg_200_1.time_ and arg_200_1.time_ <= 2 + arg_203_0 then
				local var_203_0 = arg_200_1.bgs_.ST0119

				arg_200_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_203_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_1 = var_203_0:GetComponent("SpriteRenderer")

				if var_203_1 and var_203_1.sprite then
					local var_203_2 = 2 * (var_203_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_203_0.transform.localScale = Vector3.New(var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST0119" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_3 = 4

			if 4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_3 + 0.3 and arg_200_1.time_ < var_203_3 + 0.3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_4 = 0

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_5 = 2

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_5 then
				local var_203_6 = Color.New(0, 0, 0)

				var_203_6.a = Mathf.Lerp(0, 1, (arg_200_1.time_ - var_203_4) / var_203_5)
				arg_200_1.mask_.color = var_203_6
			end

			if arg_200_1.time_ >= var_203_4 + var_203_5 and arg_200_1.time_ < var_203_4 + var_203_5 + arg_203_0 then
				local var_203_7 = Color.New(0, 0, 0)

				var_203_7.a = 1
				arg_200_1.mask_.color = var_203_7
			end

			local var_203_8 = 2

			if 2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_9 = 2

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 then
				local var_203_10 = Color.New(0, 0, 0)

				var_203_10.a = Mathf.Lerp(1, 0, (arg_200_1.time_ - var_203_8) / var_203_9)
				arg_200_1.mask_.color = var_203_10
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 then
				local var_203_11 = Color.New(0, 0, 0)

				arg_200_1.mask_.enabled = false
				var_203_11.a = 0
				arg_200_1.mask_.color = var_203_11
			end

			local var_203_12 = arg_200_1.actors_["10144"]

			if 1.966 < arg_200_1.time_ and arg_200_1.time_ <= 1.966 + arg_203_0 and not isNil(var_203_12) and arg_200_1.var_.actorSpriteComps10144 == nil then
				arg_200_1.var_.actorSpriteComps10144 = var_203_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_13 = 0.034

			if 1.966 <= arg_200_1.time_ and arg_200_1.time_ < 1.966 + var_203_13 and not isNil(var_203_12) then
				if arg_200_1.var_.actorSpriteComps10144 then
					for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_203_3 then
							if arg_200_1.isInRecall_ then
								iter_203_3.color = Color.New(Mathf.Lerp(iter_203_3.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 1.966) / var_203_13), Mathf.Lerp(iter_203_3.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 1.966) / var_203_13), (Mathf.Lerp(iter_203_3.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 1.966) / var_203_13)))
							else
								local var_203_14 = Mathf.Lerp(iter_203_3.color.r, 0.5, (arg_200_1.time_ - 1.966) / var_203_13)

								iter_203_3.color = Color.New(var_203_14, var_203_14, var_203_14)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 1.966 + var_203_13 and arg_200_1.time_ < 1.966 + var_203_13 + arg_203_0 and not isNil(var_203_12) and arg_200_1.var_.actorSpriteComps10144 then
				for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_203_5 then
						iter_203_5.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10144 = nil
			end

			local var_203_15 = arg_200_1.actors_["10144"].transform

			if 1.966 < arg_200_1.time_ and arg_200_1.time_ <= 1.966 + arg_203_0 then
				arg_200_1.var_.moveOldPos10144 = var_203_15.localPosition
				var_203_15.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10144", 7)

				for iter_203_6 = 0, var_203_15.childCount - 1 do
					local var_203_16 = var_203_15:GetChild(iter_203_6)

					if var_203_16.name == "" or not string.find(var_203_16.name, "split") then
						var_203_16.gameObject:SetActive(true)
					else
						var_203_16.gameObject:SetActive(false)
					end
				end
			end

			local var_203_17 = 0.001

			if 1.966 <= arg_200_1.time_ and arg_200_1.time_ < 1.966 + var_203_17 then
				var_203_15.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_200_1.time_ - 1.966) / var_203_17)
			end

			if arg_200_1.time_ >= 1.966 + var_203_17 and arg_200_1.time_ < 1.966 + var_203_17 + arg_203_0 then
				var_203_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_18 = 4
			local var_203_19 = 1.7

			if 4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_18 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_20 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_20:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_21 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(938022049).content)

				arg_200_1.text_.text = var_203_21

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_23 = 68 <= 0 and var_203_19 or var_203_19 * (utf8.len(var_203_21) / 68)

				if (68 <= 0 and var_203_19 or var_203_19 * (utf8.len(var_203_21) / 68)) > 0 and var_203_19 < var_203_23 then
					arg_200_1.talkMaxDuration = var_203_23
					var_203_18 = var_203_18 + 0.3

					if var_203_23 + var_203_18 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_18
					end
				end

				arg_200_1.text_.text = var_203_21
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_24 = var_203_18 + 0.3
			local var_203_25 = math.max(var_203_19, arg_200_1.talkMaxDuration)

			if var_203_18 + 0.3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_24 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_24) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_24 + var_203_25 and arg_200_1.time_ < var_203_24 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play938022050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938022050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938022051(arg_206_1)
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
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10144"]) and arg_206_1.var_.actorSpriteComps10144 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps10144 = nil
			end

			local var_209_2 = arg_206_1.actors_["10144"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10144 = var_209_2.localPosition
				var_209_2.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10144", 3)

				for iter_209_4 = 0, var_209_2.childCount - 1 do
					local var_209_3 = var_209_2:GetChild(iter_209_4)

					if var_209_3.name == "" or not string.find(var_209_3.name, "split") then
						var_209_3.gameObject:SetActive(true)
					else
						var_209_3.gameObject:SetActive(false)
					end
				end
			end

			local var_209_4 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				var_209_2.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_206_1.time_ - 0) / var_209_4)
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				var_209_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_209_5 = 0
			local var_209_6 = 0.95

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_7 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(938022050).content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 38 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_7) / 38)

				if (38 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_7) / 38)) > 0 and var_209_6 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_10 and arg_206_1.time_ < var_209_5 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play938022051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938022051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938022052(arg_210_1)
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
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10144"]) and arg_210_1.var_.actorSpriteComps10144 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps10144 = nil
			end

			local var_213_2 = 0
			local var_213_3 = 0.175

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_4 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(938022051).content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 7 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_4) / 7)

				if (7 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_4) / 7)) > 0 and var_213_3 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_7 and arg_210_1.time_ < var_213_2 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play938022052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938022052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938022053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10144 = arg_214_1.actors_["10144"].transform.localPosition
				arg_214_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10144", 7)

				for iter_217_0 = 0, arg_214_1.actors_["10144"].transform.childCount - 1 do
					local var_217_0 = arg_214_1.actors_["10144"].transform:GetChild(iter_217_0)

					if var_217_0.name == "" or not string.find(var_217_0.name, "split") then
						var_217_0.gameObject:SetActive(true)
					else
						var_217_0.gameObject:SetActive(false)
					end
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_214_1.time_ - 0) / var_217_1)
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_2 = 0
			local var_217_3 = 1.025

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(938022052).content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 41 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_4) / 41)

				if (41 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_4) / 41)) > 0 and var_217_3 < var_217_6 then
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

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play938022053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938022053
		arg_218_1.duration_ = 7

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938022054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_9001
			local var_221_9000

			if arg_218_1.bgs_.SP93801 == nil then
				local var_221_0 = Object.Instantiate(arg_218_1.paintGo_)

				var_221_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP93801")
				var_221_0.name = "SP93801"
				var_221_0.transform.parent = arg_218_1.stage_.transform
				var_221_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.bgs_.SP93801 = var_221_0
			end

			if 1.15 < arg_218_1.time_ and arg_218_1.time_ <= 1.15 + arg_221_0 then
				local var_221_1 = arg_218_1.bgs_.SP93801

				arg_218_1.bgs_.SP93801.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_221_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_221_2 = var_221_1:GetComponent("SpriteRenderer")

				if var_221_2 and var_221_2.sprite then
					local var_221_3 = 2 * (var_221_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_221_1.transform.localScale = Vector3.New(var_221_3 / var_221_2.sprite.bounds.size.y < var_221_3 * manager.ui.mainCameraCom_.aspect / var_221_2.sprite.bounds.size.x and var_221_3 * manager.ui.mainCameraCom_.aspect / var_221_2.sprite.bounds.size.x or var_221_3 / var_221_2.sprite.bounds.size.y, var_221_3 / var_221_2.sprite.bounds.size.y < var_221_3 * manager.ui.mainCameraCom_.aspect / var_221_2.sprite.bounds.size.x and var_221_3 * manager.ui.mainCameraCom_.aspect / var_221_2.sprite.bounds.size.x or var_221_3 / var_221_2.sprite.bounds.size.y, 0)
				end

				for iter_221_0, iter_221_1 in pairs(arg_218_1.bgs_) do
					if iter_221_0 ~= "SP93801" then
						iter_221_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				local var_221_4 = arg_218_1.var_.effectxuanguangzhuanchang1

				if not arg_218_1.var_.effectxuanguangzhuanchang1 then
					var_221_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_221_4.name = "xuanguangzhuanchang1"
					arg_218_1.var_.effectxuanguangzhuanchang1 = var_221_4
				else
					var_221_4.transform:SetParent(var_221_9001)
				end

				var_221_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_6 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_221_4.transform.localScale = Vector3.New(var_221_4.transform.localScale.x * var_221_6, var_221_4.transform.localScale.y * var_221_6, var_221_4.transform.localScale.z * var_221_6)
			end

			if 1.2 < arg_218_1.time_ and arg_218_1.time_ <= 1.2 + arg_221_0 then
				if arg_218_1.var_.effectxuanguangzhuanchang1 then
					Object.Destroy(arg_218_1.var_.effectxuanguangzhuanchang1)

					arg_218_1.var_.effectxuanguangzhuanchang1 = nil
				end
			end

			if 1 < arg_218_1.time_ and arg_218_1.time_ <= 1 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_boxing02", "")
			end

			if 0.3 < arg_218_1.time_ and arg_218_1.time_ <= 0.3 + arg_221_0 then
				arg_218_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 1.3 < arg_218_1.time_ and arg_218_1.time_ <= 1.3 + arg_221_0 then
				local var_221_10 = arg_218_1.var_.effectxuanguangzhuanchang2

				if not arg_218_1.var_.effectxuanguangzhuanchang2 then
					var_221_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_221_10.name = "xuanguangzhuanchang2"
					arg_218_1.var_.effectxuanguangzhuanchang2 = var_221_10
				else
					var_221_10.transform:SetParent(var_221_9000)
				end

				var_221_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_12 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_221_10.transform.localScale = Vector3.New(var_221_10.transform.localScale.x * var_221_12, var_221_10.transform.localScale.y * var_221_12, var_221_10.transform.localScale.z * var_221_12)
			end

			if 2.53333333333333 < arg_218_1.time_ and arg_218_1.time_ <= 2.53333333333333 + arg_221_0 then
				if arg_218_1.var_.effectxuanguangzhuanchang2 then
					Object.Destroy(arg_218_1.var_.effectxuanguangzhuanchang2)

					arg_218_1.var_.effectxuanguangzhuanchang2 = nil
				end
			end

			local var_221_14 = arg_218_1.bgs_.SP93801.transform

			if 1.16666666666667 < arg_218_1.time_ and arg_218_1.time_ <= 1.16666666666667 + arg_221_0 then
				arg_218_1.var_.moveOldPosSP93801 = var_221_14.localPosition
			end

			local var_221_15 = 2.8

			if 1.16666666666667 <= arg_218_1.time_ and arg_218_1.time_ < 1.16666666666667 + var_221_15 then
				var_221_14.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPosSP93801, Vector3.New(-2.62, 0, 4), (arg_218_1.time_ - 1.16666666666667) / var_221_15)
			end

			if arg_218_1.time_ >= 1.16666666666667 + var_221_15 and arg_218_1.time_ < 1.16666666666667 + var_221_15 + arg_221_0 then
				var_221_14.localPosition = Vector3.New(-2.62, 0, 4)
			end

			local var_221_16 = 0

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_16 + arg_221_0 then
				arg_218_1.allBtn_.enabled = false
			end

			if arg_218_1.time_ >= var_221_16 + 3.966666666666 and arg_218_1.time_ < var_221_16 + 3.966666666666 + arg_221_0 then
				arg_218_1.allBtn_.enabled = true
			end

			if arg_218_1.frameCnt_ <= 1 then
				arg_218_1.dialog_:SetActive(false)
			end

			local var_221_17 = 2
			local var_221_18 = 1.475

			if 2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0

				arg_218_1.dialog_:SetActive(true)

				arg_218_1.dialogCg_.alpha = 0

				local var_221_19 = LeanTween.value(arg_218_1.dialog_, 0, 1, 0.3)

				var_221_19:setOnUpdate(LuaHelper.FloatAction(function(arg_222_0)
					arg_218_1.dialogCg_.alpha = arg_222_0
				end))
				var_221_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_218_1.dialog_)
					var_221_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_218_1.duration_ = arg_218_1.duration_ + 0.3

				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_20 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(938022053).content)

				arg_218_1.text_.text = var_221_20

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_22 = 59 <= 0 and var_221_18 or var_221_18 * (utf8.len(var_221_20) / 59)

				if (59 <= 0 and var_221_18 or var_221_18 * (utf8.len(var_221_20) / 59)) > 0 and var_221_18 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22
					var_221_17 = var_221_17 + 0.3

					if var_221_22 + var_221_17 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_17
					end
				end

				arg_218_1.text_.text = var_221_20
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_23 = var_221_17 + 0.3
			local var_221_24 = math.max(var_221_18, arg_218_1.talkMaxDuration)

			if var_221_17 + 0.3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_23 + var_221_24 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_23) / var_221_24

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_23 + var_221_24 and arg_218_1.time_ < var_221_23 + var_221_24 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.72, 0.5, 4),
					endPos = Vector3.New(-2.62, 0, 4),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938022054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 938022054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play938022055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.475

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(938022054).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 19 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 19)

				if (19 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 19)) > 0 and var_227_0 < var_227_3 then
					arg_224_1.talkMaxDuration = var_227_3

					if var_227_3 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_3 + 0
					end
				end

				arg_224_1.text_.text = var_227_1
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_4 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_4

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play938022055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 938022055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play938022056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.45

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(938022055).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 18)

				if (18 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 18)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play938022056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 938022056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play938022057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.1

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(938022056).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 44 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 44)

				if (44 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 44)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play938022057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 938022057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play938022058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.625

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(938022057).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 25 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 25)

				if (25 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 25)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play938022058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 938022058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play938022059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.475

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(938022058).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 59 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 59)

				if (59 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 59)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play938022059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 938022059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play938022060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.4

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(938022059).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 16 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 16)

				if (16 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 16)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play938022060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 938022060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play938022061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.675

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(938022060).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 27 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 27)

				if (27 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 27)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play938022061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 938022061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play938022062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.85

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(938022061).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 34 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 34)

				if (34 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 34)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play938022062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 938022062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play938022063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.325

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(938022062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 13 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 13)

				if (13 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 13)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play938022063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 938022063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play938022064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.525

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(938022063).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 21 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 21)

				if (21 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 21)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play938022064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 938022064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play938022065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.5

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(938022064).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 20 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 20)

				if (20 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 20)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play938022065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 938022065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play938022066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.75

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(938022065).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 30 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 30)

				if (30 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 30)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play938022066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 938022066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play938022067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.65

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(938022066).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 26 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 26)

				if (26 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 26)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play938022067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 938022067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play938022068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.325

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(938022067).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 13 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 13)

				if (13 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 13)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play938022068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 938022068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play938022069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.6

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(938022068).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 24 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 24)

				if (24 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 24)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play938022069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 938022069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play938022070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPosSP93801 = arg_284_1.bgs_.SP93801.transform.localPosition
			end

			local var_287_0 = 2.8

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.bgs_.SP93801.transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPosSP93801, Vector3.New(0, 1, 10), (arg_284_1.time_ - 0) / var_287_0)
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.bgs_.SP93801.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_287_1 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_1 + 2.8 and arg_284_1.time_ < var_287_1 + 2.8 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_2 = 0
			local var_287_3 = 0.825

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_4 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_4:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(938022069).content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 33 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 33)

				if (33 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_5) / 33)) > 0 and var_287_3 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7
					var_287_2 = var_287_2 + 0.3

					if var_287_7 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = var_287_2 + 0.3
			local var_287_9 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_9 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_8) / var_287_9

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_8 + var_287_9 and arg_284_1.time_ < var_287_8 + var_287_9 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.62, 0, 4),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play938022070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938022070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938022071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.325

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(938022070).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 13 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 13)

				if (13 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 13)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play938022071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938022071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938022072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.3

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
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

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(938022071).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 12 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 12)

				if (12 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 12)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play938022072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 938022072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play938022073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.475

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(938022072).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 19 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 19)

				if (19 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 19)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play938022073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 938022073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play938022074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.5

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
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

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(938022073).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 20 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 20)

				if (20 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 20)) > 0 and var_305_0 < var_305_3 then
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
	Play938022074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938022074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938022075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.85

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(938022074).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 34 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 34)

				if (34 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 34)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play938022075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938022075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938022076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.65

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(938022075).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 26 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 26)

				if (26 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 26)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938022076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938022076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938022077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.15

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(938022076).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 46 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 46)

				if (46 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 46)) > 0 and var_317_0 < var_317_3 then
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
	Play938022077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938022077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
			arg_318_1.auto_ = false
		end

		function arg_318_1.playNext_(arg_320_0)
			arg_318_1.onStoryFinished_()
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.allBtn_.enabled = false
			end

			if arg_318_1.time_ >= 0 + 2.8 and arg_318_1.time_ < 0 + 2.8 + arg_321_0 then
				arg_318_1.allBtn_.enabled = true
			end

			local var_321_0 = arg_318_1.bgs_.SP93801.transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPosSP93801 = var_321_0.localPosition
			end

			local var_321_1 = 2.8

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_1 then
				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPosSP93801, Vector3.New(0, 0, 6), (arg_318_1.time_ - 0) / var_321_1)
			end

			if arg_318_1.time_ >= 0 + var_321_1 and arg_318_1.time_ < 0 + var_321_1 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, 0, 6)
			end

			local var_321_2 = 0
			local var_321_3 = 0.625

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_4 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(938022077).content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_6 = 25 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 25)

				if (25 <= 0 and var_321_3 or var_321_3 * (utf8.len(var_321_4) / 25)) > 0 and var_321_3 < var_321_6 then
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

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0, 6),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/SP93801"
	},
	voices = {}
}
