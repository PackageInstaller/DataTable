return {
	Play938032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938032002(arg_1_1)
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938032001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 13)

				if (13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 13)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938032002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["104902"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "104902"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["104902"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["104902"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps104902 == nil then
				arg_8_1.var_.actorSpriteComps104902 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps104902 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps104902 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps104902 = nil
			end

			local var_11_5 = arg_8_1.actors_["104902"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos104902 = var_11_5.localPosition
				var_11_5.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("104902", 3)

				for iter_11_6 = 0, var_11_5.childCount - 1 do
					local var_11_6 = var_11_5:GetChild(iter_11_6)

					if var_11_6.name == "split_1" or not string.find(var_11_6.name, "split") then
						var_11_6.gameObject:SetActive(true)
					else
						var_11_6.gameObject:SetActive(false)
					end
				end
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos104902, Vector3.New(0, -335, -360), (arg_8_1.time_ - 0) / var_11_7)
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -335, -360)
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_8 = arg_8_1.actors_["104902"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_11_8 then
					arg_8_1.var_.alphaOldValue104902 = var_11_8.alpha
					arg_8_1.var_.characterEffect104902 = var_11_8
				end

				arg_8_1.var_.alphaOldValue104902 = 0
			end

			local var_11_9 = 0.5

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				if arg_8_1.var_.characterEffect104902 then
					arg_8_1.var_.characterEffect104902.alpha = Mathf.Lerp(arg_8_1.var_.alphaOldValue104902, 1, (arg_8_1.time_ - 0) / var_11_9)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 and arg_8_1.var_.characterEffect104902 then
				arg_8_1.var_.characterEffect104902.alpha = 1
			end

			local var_11_10 = 0
			local var_11_11 = 0.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938032002).content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 17 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_12) / 17)

				if (17 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_12) / 17)) > 0 and var_11_11 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_15 and arg_8_1.time_ < var_11_10 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play938032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938032003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["104902"]) and arg_12_1.var_.actorSpriteComps104902 == nil then
				arg_12_1.var_.actorSpriteComps104902 = arg_12_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["104902"]) then
				if arg_12_1.var_.actorSpriteComps104902 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["104902"]) and arg_12_1.var_.actorSpriteComps104902 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_12_1.var_.actorSpriteComps104902 = nil
			end

			local var_15_2 = 0
			local var_15_3 = 0.4

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938032003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 16 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 16)

				if (16 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 16)) > 0 and var_15_3 < var_15_6 then
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

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos104902 = arg_16_1.actors_["104902"].transform.localPosition
				arg_16_1.actors_["104902"].transform.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("104902", 7)

				for iter_19_0 = 0, arg_16_1.actors_["104902"].transform.childCount - 1 do
					local var_19_0 = arg_16_1.actors_["104902"].transform:GetChild(iter_19_0)

					if var_19_0.name == "" or not string.find(var_19_0.name, "split") then
						var_19_0.gameObject:SetActive(true)
					else
						var_19_0.gameObject:SetActive(false)
					end
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["104902"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_16_1.time_ - 0) / var_19_1)
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["104902"].transform.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_19_2 = 0
			local var_19_3 = 1.275

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938032004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 51 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 51)

				if (51 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 51)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play938032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["108301"] == nil then
				local var_23_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_23_0) then
					local var_23_1 = Object.Instantiate(var_23_0, arg_20_1.canvasGo_.transform)

					var_23_1.transform:SetSiblingIndex(1)

					var_23_1.name = "108301"
					var_23_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_["108301"] = var_23_1

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs((var_23_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_2 = arg_20_1.actors_["108301"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps108301 == nil then
				arg_20_1.var_.actorSpriteComps108301 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps108301 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_23_3 then
							if arg_20_1.isInRecall_ then
								iter_23_3.color = Color.New(Mathf.Lerp(iter_23_3.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_3), Mathf.Lerp(iter_23_3.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_3), (Mathf.Lerp(iter_23_3.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_3)))
							else
								local var_23_4 = Mathf.Lerp(iter_23_3.color.r, 1, (arg_20_1.time_ - 0) / var_23_3)

								iter_23_3.color = Color.New(var_23_4, var_23_4, var_23_4)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps108301 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_23_5 then
						iter_23_5.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps108301 = nil
			end

			local var_23_5 = arg_20_1.actors_["108301"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos108301 = var_23_5.localPosition
				var_23_5.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("108301", 3)

				for iter_23_6 = 0, var_23_5.childCount - 1 do
					local var_23_6 = var_23_5:GetChild(iter_23_6)

					if var_23_6.name == "split_5" or not string.find(var_23_6.name, "split") then
						var_23_6.gameObject:SetActive(true)
					else
						var_23_6.gameObject:SetActive(false)
					end
				end
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_20_1.time_ - 0) / var_23_7)
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0, -360, -195)
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_8 = arg_20_1.actors_["108301"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_23_8 then
					arg_20_1.var_.alphaOldValue108301 = var_23_8.alpha
					arg_20_1.var_.characterEffect108301 = var_23_8
				end

				arg_20_1.var_.alphaOldValue108301 = 0
			end

			local var_23_9 = 0.5

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				if arg_20_1.var_.characterEffect108301 then
					arg_20_1.var_.characterEffect108301.alpha = Mathf.Lerp(arg_20_1.var_.alphaOldValue108301, 1, (arg_20_1.time_ - 0) / var_23_9)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 and arg_20_1.var_.characterEffect108301 then
				arg_20_1.var_.characterEffect108301.alpha = 1
			end

			local var_23_10 = 0
			local var_23_11 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
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

				local var_23_12 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938032005).content)

				arg_20_1.text_.text = var_23_12

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_14 = 17 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_12) / 17)

				if (17 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_12) / 17)) > 0 and var_23_11 < var_23_14 then
					arg_20_1.talkMaxDuration = var_23_14

					if var_23_14 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_12
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_15 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_15 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_15

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_15 and arg_20_1.time_ < var_23_10 + var_23_15 + arg_23_0 then
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
	Play938032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938032006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938032007(arg_24_1)
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
			local var_27_3 = 0.575

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

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938032006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 23 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 23)

				if (23 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 23)) > 0 and var_27_3 < var_27_6 then
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
	Play938032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.975

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938032007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 39 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 39)

				if (39 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 39)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play938032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938032008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938032009(arg_32_1)
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
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 1, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["108301"]) and arg_32_1.var_.actorSpriteComps108301 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps108301 = nil
			end

			local var_35_2 = arg_32_1.actors_["108301"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos108301 = var_35_2.localPosition
				var_35_2.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("108301", 3)

				for iter_35_4 = 0, var_35_2.childCount - 1 do
					local var_35_3 = var_35_2:GetChild(iter_35_4)

					if var_35_3.name == "split_1" then
						var_35_3:SetAsLastSibling()
						var_35_3.gameObject:SetActive(true)

						arg_32_1.var_.actorSpriteSplit108301 = var_35_3.gameObject:GetComponent(typeof(Image))

						arg_32_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_35_4 = 0.5

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_32_1.time_ - 0) / var_35_4)

				if arg_32_1.var_.actorSpriteSplit108301 ~= nil then
					arg_32_1.var_.actorSpriteSplit108301:SetAlpha((arg_32_1.time_ - 0) / var_35_4)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -360, -195)

				if arg_32_1.var_.actorSpriteSplit108301 ~= nil then
					arg_32_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_35_5 = 0
			local var_35_6 = 0.2

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_7 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938032008).content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 8 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_7) / 8)

				if (8 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_7) / 8)) > 0 and var_35_6 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_10 and arg_32_1.time_ < var_35_5 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play938032009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938032009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938032010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["108301"]) and arg_36_1.var_.actorSpriteComps108301 == nil then
				arg_36_1.var_.actorSpriteComps108301 = arg_36_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["108301"]) then
				if arg_36_1.var_.actorSpriteComps108301 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								iter_39_1.color = Color.New(Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_0), Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_0), (Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_0)))
							else
								local var_39_1 = Mathf.Lerp(iter_39_1.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_0)

								iter_39_1.color = Color.New(var_39_1, var_39_1, var_39_1)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["108301"]) and arg_36_1.var_.actorSpriteComps108301 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps108301 = nil
			end

			local var_39_2 = 0
			local var_39_3 = 0.25

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_4 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938032009).content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 10 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 10)

				if (10 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 10)) > 0 and var_39_3 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_7 and arg_36_1.time_ < var_39_2 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play938032010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938032010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938032011(arg_40_1)
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
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 1, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["104902"]) and arg_40_1.var_.actorSpriteComps104902 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps104902 = nil
			end

			local var_43_2 = arg_40_1.actors_["108301"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos108301 = var_43_2.localPosition
				var_43_2.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("108301", 7)

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
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_40_1.time_ - 0) / var_43_4)
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_43_5 = arg_40_1.actors_["104902"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos104902 = var_43_5.localPosition
				var_43_5.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("104902", 2)

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
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_40_1.time_ - 0) / var_43_7)
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_43_8 = 0
			local var_43_9 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(938032010).content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_12 = 16 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_10) / 16)

				if (16 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_10) / 16)) > 0 and var_43_9 < var_43_12 then
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
	Play938032011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938032011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938032012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["128404"] == nil then
				local var_47_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_47_0) then
					local var_47_1 = Object.Instantiate(var_47_0, arg_44_1.canvasGo_.transform)

					var_47_1.transform:SetSiblingIndex(1)

					var_47_1.name = "128404"
					var_47_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_44_1.actors_["128404"] = var_47_1

					if arg_44_1.isInRecall_ then
						for iter_47_0, iter_47_1 in ipairs((var_47_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_47_1.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_47_2 = arg_44_1.actors_["128404"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps128404 == nil then
				arg_44_1.var_.actorSpriteComps128404 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps128404 then
					for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_47_3 then
							if arg_44_1.isInRecall_ then
								iter_47_3.color = Color.New(Mathf.Lerp(iter_47_3.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_3.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_3.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_3.color.r, 1, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_3.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps128404 then
				for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_47_5 then
						iter_47_5.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps128404 = nil
			end

			local var_47_5 = arg_44_1.actors_["104902"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.actorSpriteComps104902 == nil then
				arg_44_1.var_.actorSpriteComps104902 = var_47_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_6 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_6 and not isNil(var_47_5) then
				if arg_44_1.var_.actorSpriteComps104902 then
					for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_47_7 then
							if arg_44_1.isInRecall_ then
								iter_47_7.color = Color.New(Mathf.Lerp(iter_47_7.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_6), Mathf.Lerp(iter_47_7.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_6), (Mathf.Lerp(iter_47_7.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_6)))
							else
								local var_47_7 = Mathf.Lerp(iter_47_7.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_6)

								iter_47_7.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_6 and arg_44_1.time_ < 0 + var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.actorSpriteComps104902 then
				for iter_47_8, iter_47_9 in pairs(arg_44_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_47_9 then
						iter_47_9.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps104902 = nil
			end

			local var_47_8 = arg_44_1.actors_["128404"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos128404 = var_47_8.localPosition
				var_47_8.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("128404", 4)

				for iter_47_10 = 0, var_47_8.childCount - 1 do
					local var_47_9 = var_47_8:GetChild(iter_47_10)

					if var_47_9.name == "split_3" or not string.find(var_47_9.name, "split") then
						var_47_9.gameObject:SetActive(true)
					else
						var_47_9.gameObject:SetActive(false)
					end
				end
			end

			local var_47_10 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_10 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_44_1.time_ - 0) / var_47_10)
			end

			if arg_44_1.time_ >= 0 + var_47_10 and arg_44_1.time_ < 0 + var_47_10 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_47_11 = 0
			local var_47_12 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(938032011).content)

				arg_44_1.text_.text = var_47_13

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 7 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_13) / 7)

				if (7 <= 0 and var_47_12 or var_47_12 * (utf8.len(var_47_13) / 7)) > 0 and var_47_12 < var_47_15 then
					arg_44_1.talkMaxDuration = var_47_15

					if var_47_15 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_15 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_13
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_16 and arg_44_1.time_ < var_47_11 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play938032012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938032012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938032013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["128404"]) and arg_48_1.var_.actorSpriteComps128404 == nil then
				arg_48_1.var_.actorSpriteComps128404 = arg_48_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["128404"]) then
				if arg_48_1.var_.actorSpriteComps128404 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["128404"]) and arg_48_1.var_.actorSpriteComps128404 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps128404 = nil
			end

			local var_51_2 = arg_48_1.actors_["128404"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos128404 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("128404", 7)

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
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_51_5 = arg_48_1.actors_["104902"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos104902 = var_51_5.localPosition
				var_51_5.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("104902", 7)

				for iter_51_5 = 0, var_51_5.childCount - 1 do
					local var_51_6 = var_51_5:GetChild(iter_51_5)

					if var_51_6.name == "" or not string.find(var_51_6.name, "split") then
						var_51_6.gameObject:SetActive(true)
					else
						var_51_6.gameObject:SetActive(false)
					end
				end
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_48_1.time_ - 0) / var_51_7)
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_51_8 = 0
			local var_51_9 = 1.6

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(938032012).content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_12 = 64 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 64)

				if (64 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 64)) > 0 and var_51_9 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_13 and arg_48_1.time_ < var_51_8 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play938032013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938032013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938032014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["106603"] == nil then
				local var_55_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_55_0) then
					local var_55_1 = Object.Instantiate(var_55_0, arg_52_1.canvasGo_.transform)

					var_55_1.transform:SetSiblingIndex(1)

					var_55_1.name = "106603"
					var_55_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_52_1.actors_["106603"] = var_55_1

					if arg_52_1.isInRecall_ then
						for iter_55_0, iter_55_1 in ipairs((var_55_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_55_1.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_55_2 = arg_52_1.actors_["106603"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps106603 == nil then
				arg_52_1.var_.actorSpriteComps106603 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps106603 then
					for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_55_3 then
							if arg_52_1.isInRecall_ then
								iter_55_3.color = Color.New(Mathf.Lerp(iter_55_3.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_3), Mathf.Lerp(iter_55_3.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_3), (Mathf.Lerp(iter_55_3.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_3)))
							else
								local var_55_4 = Mathf.Lerp(iter_55_3.color.r, 1, (arg_52_1.time_ - 0) / var_55_3)

								iter_55_3.color = Color.New(var_55_4, var_55_4, var_55_4)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps106603 then
				for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_55_5 then
						iter_55_5.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps106603 = nil
			end

			local var_55_5 = arg_52_1.actors_["106603"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos106603 = var_55_5.localPosition
				var_55_5.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("106603", 2)

				for iter_55_6 = 0, var_55_5.childCount - 1 do
					local var_55_6 = var_55_5:GetChild(iter_55_6)

					if var_55_6.name == "split_1" or not string.find(var_55_6.name, "split") then
						var_55_6.gameObject:SetActive(true)
					else
						var_55_6.gameObject:SetActive(false)
					end
				end
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_52_1.time_ - 0) / var_55_7)
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_55_8 = 0
			local var_55_9 = 0.875

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(938032013).content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 35 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_10) / 35)

				if (35 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_10) / 35)) > 0 and var_55_9 < var_55_12 then
					arg_52_1.talkMaxDuration = var_55_12

					if var_55_12 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_13 and arg_52_1.time_ < var_55_8 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play938032014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938032014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938032015(arg_56_1)
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
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["106603"]) and arg_56_1.var_.actorSpriteComps106603 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps106603 = nil
			end

			local var_59_2 = 0
			local var_59_3 = 0.15

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_4 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(938032014).content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 6 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_4) / 6)

				if (6 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_4) / 6)) > 0 and var_59_3 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_7 and arg_56_1.time_ < var_59_2 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play938032015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938032015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938032016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["128404"]) and arg_60_1.var_.actorSpriteComps128404 == nil then
				arg_60_1.var_.actorSpriteComps128404 = arg_60_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["128404"]) then
				if arg_60_1.var_.actorSpriteComps128404 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["128404"]) and arg_60_1.var_.actorSpriteComps128404 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps128404 = nil
			end

			local var_63_2 = arg_60_1.actors_["128404"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos128404 = var_63_2.localPosition
				var_63_2.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("128404", 4)

				for iter_63_4 = 0, var_63_2.childCount - 1 do
					local var_63_3 = var_63_2:GetChild(iter_63_4)

					if var_63_3.name == "split_4" or not string.find(var_63_3.name, "split") then
						var_63_3.gameObject:SetActive(true)
					else
						var_63_3.gameObject:SetActive(false)
					end
				end
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_2.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_60_1.time_ - 0) / var_63_4)
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_2.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_63_5 = 0
			local var_63_6 = 0.35

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(938032015).content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 14 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 14)

				if (14 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 14)) > 0 and var_63_6 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_10 and arg_60_1.time_ < var_63_5 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play938032016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938032016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938032017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["104902"]) and arg_64_1.var_.actorSpriteComps104902 == nil then
				arg_64_1.var_.actorSpriteComps104902 = arg_64_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["104902"]) then
				if arg_64_1.var_.actorSpriteComps104902 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["104902"]) and arg_64_1.var_.actorSpriteComps104902 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps104902 = nil
			end

			local var_67_2 = arg_64_1.actors_["128404"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps128404 == nil then
				arg_64_1.var_.actorSpriteComps128404 = var_67_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_3 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.actorSpriteComps128404 then
					for iter_67_4, iter_67_5 in pairs(arg_64_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.actorSpriteComps128404 then
				for iter_67_6, iter_67_7 in pairs(arg_64_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_67_7 then
						iter_67_7.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps128404 = nil
			end

			local var_67_5 = arg_64_1.actors_["104902"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos104902 = var_67_5.localPosition
				var_67_5.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("104902", 4)

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
				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_64_1.time_ - 0) / var_67_7)
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_67_8 = arg_64_1.actors_["128404"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos128404 = var_67_8.localPosition
				var_67_8.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("128404", 7)

				for iter_67_9 = 0, var_67_8.childCount - 1 do
					local var_67_9 = var_67_8:GetChild(iter_67_9)

					if var_67_9.name == "" or not string.find(var_67_9.name, "split") then
						var_67_9.gameObject:SetActive(true)
					else
						var_67_9.gameObject:SetActive(false)
					end
				end
			end

			local var_67_10 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_10 then
				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_64_1.time_ - 0) / var_67_10)
			end

			if arg_64_1.time_ >= 0 + var_67_10 and arg_64_1.time_ < 0 + var_67_10 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_11 = 0
			local var_67_12 = 0.625

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(938032016).content)

				arg_64_1.text_.text = var_67_13

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 25 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_13) / 25)

				if (25 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_13) / 25)) > 0 and var_67_12 < var_67_15 then
					arg_64_1.talkMaxDuration = var_67_15

					if var_67_15 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_13
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_16 and arg_64_1.time_ < var_67_11 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play938032017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938032017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938032018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["104902"]) and arg_68_1.var_.actorSpriteComps104902 == nil then
				arg_68_1.var_.actorSpriteComps104902 = arg_68_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["104902"]) then
				if arg_68_1.var_.actorSpriteComps104902 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["104902"]) and arg_68_1.var_.actorSpriteComps104902 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps104902 = nil
			end

			local var_71_2 = 0
			local var_71_3 = 0.525

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

				local var_71_4 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(938032017).content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 21 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 21)

				if (21 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 21)) > 0 and var_71_3 < var_71_6 then
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
	Play938032018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938032018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938032019(arg_72_1)
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

				arg_72_1:CheckSpriteTmpPos("106603", 2)

				for iter_75_4 = 0, var_75_2.childCount - 1 do
					local var_75_3 = var_75_2:GetChild(iter_75_4)

					if var_75_3.name == "" or not string.find(var_75_3.name, "split") then
						var_75_3.gameObject:SetActive(true)
					else
						var_75_3.gameObject:SetActive(false)
					end
				end
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_2.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_72_1.time_ - 0) / var_75_4)
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_2.localPosition = Vector3.New(-510.9, -399.1, -303.3)
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

				local var_75_7 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(938032018).content)

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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938032019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938032019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938032020(arg_76_1)
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

			local var_79_5 = arg_76_1.actors_["104902"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos104902 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("104902", 7)

				for iter_79_5 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_5)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos104902, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_8 = 0
			local var_79_9 = 1.525

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(938032019).content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 61 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 61)

				if (61 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 61)) > 0 and var_79_9 < var_79_12 then
					arg_76_1.talkMaxDuration = var_79_12

					if var_79_12 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_13 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_13 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_13

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_13 and arg_76_1.time_ < var_79_8 + var_79_13 + arg_79_0 then
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

		arg_76_1:InitPlayNodeList()
	end,
	Play938032020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938032020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938032021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_83_0 = 0.266666666666667

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				local var_83_1, var_83_2 = math.modf((arg_80_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_83_2 * 0.13, var_83_2 * 0.13, var_83_2 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				manager.ui.mainCamera.transform.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_3 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_80_1.time_ and arg_80_1.time_ <= 0.366666666666667 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = var_83_3.localPosition
			end

			local var_83_4 = 0.3

			if 0.366666666666667 <= arg_80_1.time_ and arg_80_1.time_ < 0.366666666666667 + var_83_4 then
				local var_83_5, var_83_6 = math.modf((arg_80_1.time_ - 0.366666666666667) / 0.066)

				var_83_3.localPosition = Vector3.New(var_83_6 * 0.13, var_83_6 * 0.13, var_83_6 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= 0.366666666666667 + var_83_4 and arg_80_1.time_ < 0.366666666666667 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_7 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_7 + 0.666666666666667 and arg_80_1.time_ < var_83_7 + 0.666666666666667 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_8 = 0
			local var_83_9 = 0.1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_10 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_10:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1561].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_11 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(938032020).content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 4 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 4)

				if (4 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 4)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13
					var_83_8 = var_83_8 + 0.3

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = var_83_8 + 0.3
			local var_83_15 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_15 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_15

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938032021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938032021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938032022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["106603"]) and arg_86_1.var_.actorSpriteComps106603 == nil then
				arg_86_1.var_.actorSpriteComps106603 = arg_86_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["106603"]) then
				if arg_86_1.var_.actorSpriteComps106603 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["106603"]) and arg_86_1.var_.actorSpriteComps106603 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps106603 = nil
			end

			local var_89_2 = arg_86_1.actors_["106603"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos106603 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("106603", 2)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_89_5 = 0
			local var_89_6 = 0.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(938032021).content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 3 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 3)

				if (3 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 3)) > 0 and var_89_6 < var_89_9 then
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
				actorName = "106603",
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
	Play938032022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938032022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938032023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["104902"]) and arg_90_1.var_.actorSpriteComps104902 == nil then
				arg_90_1.var_.actorSpriteComps104902 = arg_90_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["104902"]) then
				if arg_90_1.var_.actorSpriteComps104902 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["104902"]) and arg_90_1.var_.actorSpriteComps104902 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps104902 = nil
			end

			local var_93_2 = arg_90_1.actors_["106603"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.actorSpriteComps106603 == nil then
				arg_90_1.var_.actorSpriteComps106603 = var_93_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_3 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.actorSpriteComps106603 then
					for iter_93_4, iter_93_5 in pairs(arg_90_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_93_5 then
							if arg_90_1.isInRecall_ then
								iter_93_5.color = Color.New(Mathf.Lerp(iter_93_5.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_3), Mathf.Lerp(iter_93_5.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_3), (Mathf.Lerp(iter_93_5.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_3)))
							else
								local var_93_4 = Mathf.Lerp(iter_93_5.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_3)

								iter_93_5.color = Color.New(var_93_4, var_93_4, var_93_4)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.actorSpriteComps106603 then
				for iter_93_6, iter_93_7 in pairs(arg_90_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_93_7 then
						iter_93_7.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps106603 = nil
			end

			local var_93_5 = arg_90_1.actors_["104902"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos104902 = var_93_5.localPosition
				var_93_5.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("104902", 4)

				for iter_93_8 = 0, var_93_5.childCount - 1 do
					local var_93_6 = var_93_5:GetChild(iter_93_8)

					if var_93_6.name == "" or not string.find(var_93_6.name, "split") then
						var_93_6.gameObject:SetActive(true)
					else
						var_93_6.gameObject:SetActive(false)
					end
				end
			end

			local var_93_7 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_90_1.time_ - 0) / var_93_7)
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_93_8 = 0
			local var_93_9 = 0.2

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(938032022).content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_12 = 8 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_10) / 8)

				if (8 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_10) / 8)) > 0 and var_93_9 < var_93_12 then
					arg_90_1.talkMaxDuration = var_93_12

					if var_93_12 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_13 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_13 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_13

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_13 and arg_90_1.time_ < var_93_8 + var_93_13 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938032023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938032023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938032024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["108301"]) and arg_94_1.var_.actorSpriteComps108301 == nil then
				arg_94_1.var_.actorSpriteComps108301 = arg_94_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["108301"]) then
				if arg_94_1.var_.actorSpriteComps108301 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 1, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["108301"]) and arg_94_1.var_.actorSpriteComps108301 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps108301 = nil
			end

			local var_97_2 = arg_94_1.actors_["104902"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps104902 == nil then
				arg_94_1.var_.actorSpriteComps104902 = var_97_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_3 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.actorSpriteComps104902 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								iter_97_5.color = Color.New(Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_3), Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_3), (Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_3)))
							else
								local var_97_4 = Mathf.Lerp(iter_97_5.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_3)

								iter_97_5.color = Color.New(var_97_4, var_97_4, var_97_4)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.actorSpriteComps104902 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_97_7 then
						iter_97_7.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps104902 = nil
			end

			local var_97_5 = arg_94_1.actors_["108301"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos108301 = var_97_5.localPosition
				var_97_5.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("108301", 2)

				for iter_97_8 = 0, var_97_5.childCount - 1 do
					local var_97_6 = var_97_5:GetChild(iter_97_8)

					if var_97_6.name == "split_3" or not string.find(var_97_6.name, "split") then
						var_97_6.gameObject:SetActive(true)
					else
						var_97_6.gameObject:SetActive(false)
					end
				end
			end

			local var_97_7 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				var_97_5.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_94_1.time_ - 0) / var_97_7)
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				var_97_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_97_8 = arg_94_1.actors_["106603"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos106603 = var_97_8.localPosition
				var_97_8.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("106603", 7)

				for iter_97_9 = 0, var_97_8.childCount - 1 do
					local var_97_9 = var_97_8:GetChild(iter_97_9)

					if var_97_9.name == "" or not string.find(var_97_9.name, "split") then
						var_97_9.gameObject:SetActive(true)
					else
						var_97_9.gameObject:SetActive(false)
					end
				end
			end

			local var_97_10 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_10 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_94_1.time_ - 0) / var_97_10)
			end

			if arg_94_1.time_ >= 0 + var_97_10 and arg_94_1.time_ < 0 + var_97_10 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_97_11 = 0
			local var_97_12 = 0.3

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_13 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(938032023).content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 12 <= 0 and var_97_12 or var_97_12 * (utf8.len(var_97_13) / 12)

				if (12 <= 0 and var_97_12 or var_97_12 * (utf8.len(var_97_13) / 12)) > 0 and var_97_12 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_11
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_12, arg_94_1.talkMaxDuration)

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_11) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_11 + var_97_16 and arg_94_1.time_ < var_97_11 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
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

		arg_94_1:InitPlayNodeList()
	end,
	Play938032024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938032024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938032025(arg_98_1)
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
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor2.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor2.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor2.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 0.5, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["108301"]) and arg_98_1.var_.actorSpriteComps108301 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps108301 = nil
			end

			local var_101_2 = arg_98_1.actors_["108301"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos108301 = var_101_2.localPosition
				var_101_2.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("108301", 7)

				for iter_101_4 = 0, var_101_2.childCount - 1 do
					local var_101_3 = var_101_2:GetChild(iter_101_4)

					if var_101_3.name == "" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_98_1.time_ - 0) / var_101_4)
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_101_5 = arg_98_1.actors_["104902"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos104902 = var_101_5.localPosition
				var_101_5.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("104902", 7)

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
				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_98_1.time_ - 0) / var_101_7)
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(0, -2000, -360)
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story_152", "se_story_152_jump_down", "")
			end

			local var_101_9 = 0
			local var_101_10 = 1.575

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_11 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(938032024).content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 63 <= 0 and var_101_10 or var_101_10 * (utf8.len(var_101_11) / 63)

				if (63 <= 0 and var_101_10 or var_101_10 * (utf8.len(var_101_11) / 63)) > 0 and var_101_10 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_9 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_9
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_10, arg_98_1.talkMaxDuration)

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_9) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_9 + var_101_14 and arg_98_1.time_ < var_101_9 + var_101_14 + arg_101_0 then
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
				actorName = "104902",
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
	Play938032025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938032025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938032026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_105_0 = 1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				local var_105_1, var_105_2 = math.modf((arg_102_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_105_2 * 0.13, var_105_2 * 0.13, var_105_2 * 0.13) + arg_102_1.var_.shakeOldPos
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				manager.ui.mainCamera.transform.localPosition = arg_102_1.var_.shakeOldPos
			end

			local var_105_3 = 0

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.allBtn_.enabled = false
			end

			if arg_102_1.time_ >= var_105_3 + 1 and arg_102_1.time_ < var_105_3 + 1 + arg_105_0 then
				arg_102_1.allBtn_.enabled = true
			end

			local var_105_4 = 0
			local var_105_5 = 0.225

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1561].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_6 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(938032025).content)

				arg_102_1.text_.text = var_105_6

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_8 = 9 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_6) / 9)

				if (9 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_6) / 9)) > 0 and var_105_5 < var_105_8 then
					arg_102_1.talkMaxDuration = var_105_8

					if var_105_8 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_6
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_9 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_9 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_9

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_9 and arg_102_1.time_ < var_105_4 + var_105_9 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play938032026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938032026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938032027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.25

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(938032026).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 10 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 10)

				if (10 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 10)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play938032027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938032027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938032028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["128404"]) and arg_110_1.var_.actorSpriteComps128404 == nil then
				arg_110_1.var_.actorSpriteComps128404 = arg_110_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["128404"]) then
				if arg_110_1.var_.actorSpriteComps128404 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["128404"]) and arg_110_1.var_.actorSpriteComps128404 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps128404 = nil
			end

			local var_113_2 = arg_110_1.actors_["128404"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos128404 = var_113_2.localPosition
				var_113_2.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("128404", 3)

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
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_110_1.time_ - 0) / var_113_4)
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_113_5 = 0
			local var_113_6 = 0.125

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_7 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(938032027).content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 5 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 5)

				if (5 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 5)) > 0 and var_113_6 < var_113_9 then
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
				actorName = "128404",
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
	Play938032028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938032028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938032029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["128404"]) and arg_114_1.var_.actorSpriteComps128404 == nil then
				arg_114_1.var_.actorSpriteComps128404 = arg_114_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["128404"]) then
				if arg_114_1.var_.actorSpriteComps128404 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								iter_117_1.color = Color.New(Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, (arg_114_1.time_ - 0) / var_117_0), Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, (arg_114_1.time_ - 0) / var_117_0), (Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, (arg_114_1.time_ - 0) / var_117_0)))
							else
								local var_117_1 = Mathf.Lerp(iter_117_1.color.r, 0.5, (arg_114_1.time_ - 0) / var_117_0)

								iter_117_1.color = Color.New(var_117_1, var_117_1, var_117_1)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["128404"]) and arg_114_1.var_.actorSpriteComps128404 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps128404 = nil
			end

			local var_117_2 = arg_114_1.actors_["128404"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos128404 = var_117_2.localPosition
				var_117_2.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("128404", 7)

				for iter_117_4 = 0, var_117_2.childCount - 1 do
					local var_117_3 = var_117_2:GetChild(iter_117_4)

					if var_117_3.name == "" or not string.find(var_117_3.name, "split") then
						var_117_3.gameObject:SetActive(true)
					else
						var_117_3.gameObject:SetActive(false)
					end
				end
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_2.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_114_1.time_ - 0) / var_117_4)
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_5 = 0
			local var_117_6 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(938032028).content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 53 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_7) / 53)

				if (53 <= 0 and var_117_6 or var_117_6 * (utf8.len(var_117_7) / 53)) > 0 and var_117_6 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_10 and arg_114_1.time_ < var_117_5 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938032029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938032029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938032030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.925

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(938032029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 37 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 37)

				if (37 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 37)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play938032030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938032030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938032031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if arg_122_1.actors_["10183"] == nil then
				local var_125_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_125_0) then
					local var_125_1 = Object.Instantiate(var_125_0, arg_122_1.canvasGo_.transform)

					var_125_1.transform:SetSiblingIndex(1)

					var_125_1.name = "10183"
					var_125_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_122_1.actors_["10183"] = var_125_1

					if arg_122_1.isInRecall_ then
						for iter_125_0, iter_125_1 in ipairs((var_125_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_125_1.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_125_2 = arg_122_1.actors_["10183"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps10183 == nil then
				arg_122_1.var_.actorSpriteComps10183 = var_125_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.actorSpriteComps10183 then
					for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_125_3 then
							if arg_122_1.isInRecall_ then
								iter_125_3.color = Color.New(Mathf.Lerp(iter_125_3.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_3), Mathf.Lerp(iter_125_3.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_3), (Mathf.Lerp(iter_125_3.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_3)))
							else
								local var_125_4 = Mathf.Lerp(iter_125_3.color.r, 1, (arg_122_1.time_ - 0) / var_125_3)

								iter_125_3.color = Color.New(var_125_4, var_125_4, var_125_4)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps10183 then
				for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_125_5 then
						iter_125_5.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps10183 = nil
			end

			local var_125_5 = arg_122_1.actors_["10183"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10183 = var_125_5.localPosition
				var_125_5.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("10183", 2)

				for iter_125_6 = 0, var_125_5.childCount - 1 do
					local var_125_6 = var_125_5:GetChild(iter_125_6)

					if var_125_6.name == "" or not string.find(var_125_6.name, "split") then
						var_125_6.gameObject:SetActive(true)
					else
						var_125_6.gameObject:SetActive(false)
					end
				end
			end

			local var_125_7 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				var_125_5.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_122_1.time_ - 0) / var_125_7)
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				var_125_5.localPosition = Vector3.New(-300, -475, -325)
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				local var_125_8 = arg_122_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_125_8 then
					arg_122_1.var_.alphaOldValue10183 = var_125_8.alpha
					arg_122_1.var_.characterEffect10183 = var_125_8
				end

				arg_122_1.var_.alphaOldValue10183 = 0
			end

			local var_125_9 = 0.5

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_9 then
				if arg_122_1.var_.characterEffect10183 then
					arg_122_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_122_1.var_.alphaOldValue10183, 1, (arg_122_1.time_ - 0) / var_125_9)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_9 and arg_122_1.time_ < 0 + var_125_9 + arg_125_0 and arg_122_1.var_.characterEffect10183 then
				arg_122_1.var_.characterEffect10183.alpha = 1
			end

			local var_125_10 = 0
			local var_125_11 = 0.975

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_12 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(938032030).content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_14 = 39 <= 0 and var_125_11 or var_125_11 * (utf8.len(var_125_12) / 39)

				if (39 <= 0 and var_125_11 or var_125_11 * (utf8.len(var_125_12) / 39)) > 0 and var_125_11 < var_125_14 then
					arg_122_1.talkMaxDuration = var_125_14

					if var_125_14 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_10
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_15 = math.max(var_125_11, arg_122_1.talkMaxDuration)

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_15 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_10) / var_125_15

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_10 + var_125_15 and arg_122_1.time_ < var_125_10 + var_125_15 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play938032031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938032031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938032032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.actors_["10144"] == nil then
				local var_129_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_129_0) then
					local var_129_1 = Object.Instantiate(var_129_0, arg_126_1.canvasGo_.transform)

					var_129_1.transform:SetSiblingIndex(1)

					var_129_1.name = "10144"
					var_129_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_126_1.actors_["10144"] = var_129_1

					if arg_126_1.isInRecall_ then
						for iter_129_0, iter_129_1 in ipairs((var_129_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_129_1.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_129_2 = arg_126_1.actors_["10144"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10144 == nil then
				arg_126_1.var_.actorSpriteComps10144 = var_129_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_3 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.actorSpriteComps10144 then
					for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_129_3 then
							if arg_126_1.isInRecall_ then
								iter_129_3.color = Color.New(Mathf.Lerp(iter_129_3.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_3), Mathf.Lerp(iter_129_3.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_3), (Mathf.Lerp(iter_129_3.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_3)))
							else
								local var_129_4 = Mathf.Lerp(iter_129_3.color.r, 1, (arg_126_1.time_ - 0) / var_129_3)

								iter_129_3.color = Color.New(var_129_4, var_129_4, var_129_4)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps10144 then
				for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_129_5 then
						iter_129_5.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps10144 = nil
			end

			local var_129_5 = arg_126_1.actors_["10183"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.actorSpriteComps10183 == nil then
				arg_126_1.var_.actorSpriteComps10183 = var_129_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_6 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.actorSpriteComps10183 then
					for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_129_7 then
							if arg_126_1.isInRecall_ then
								iter_129_7.color = Color.New(Mathf.Lerp(iter_129_7.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_6), Mathf.Lerp(iter_129_7.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_6), (Mathf.Lerp(iter_129_7.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_6)))
							else
								local var_129_7 = Mathf.Lerp(iter_129_7.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_6)

								iter_129_7.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.actorSpriteComps10183 then
				for iter_129_8, iter_129_9 in pairs(arg_126_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_129_9 then
						iter_129_9.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps10183 = nil
			end

			local var_129_8 = arg_126_1.actors_["10144"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10144 = var_129_8.localPosition
				var_129_8.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("10144", 4)

				for iter_129_10 = 0, var_129_8.childCount - 1 do
					local var_129_9 = var_129_8:GetChild(iter_129_10)

					if var_129_9.name == "split_3" or not string.find(var_129_9.name, "split") then
						var_129_9.gameObject:SetActive(true)
					else
						var_129_9.gameObject:SetActive(false)
					end
				end
			end

			local var_129_10 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_10 then
				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_126_1.time_ - 0) / var_129_10)
			end

			if arg_126_1.time_ >= 0 + var_129_10 and arg_126_1.time_ < 0 + var_129_10 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				local var_129_11 = arg_126_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_129_11 then
					arg_126_1.var_.alphaOldValue10144 = var_129_11.alpha
					arg_126_1.var_.characterEffect10144 = var_129_11
				end

				arg_126_1.var_.alphaOldValue10144 = 0
			end

			local var_129_12 = 0.0166666666666667

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_12 then
				if arg_126_1.var_.characterEffect10144 then
					arg_126_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_126_1.var_.alphaOldValue10144, 1, (arg_126_1.time_ - 0) / var_129_12)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_12 and arg_126_1.time_ < 0 + var_129_12 + arg_129_0 and arg_126_1.var_.characterEffect10144 then
				arg_126_1.var_.characterEffect10144.alpha = 1
			end

			local var_129_13 = 0
			local var_129_14 = 0.25

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(938032031).content)

				arg_126_1.text_.text = var_129_15

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 10 <= 0 and var_129_14 or var_129_14 * (utf8.len(var_129_15) / 10)

				if (10 <= 0 and var_129_14 or var_129_14 * (utf8.len(var_129_15) / 10)) > 0 and var_129_14 < var_129_17 then
					arg_126_1.talkMaxDuration = var_129_17

					if var_129_17 + var_129_13 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_17 + var_129_13
					end
				end

				arg_126_1.text_.text = var_129_15
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_18 = math.max(var_129_14, arg_126_1.talkMaxDuration)

			if var_129_13 <= arg_126_1.time_ and arg_126_1.time_ < var_129_13 + var_129_18 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_13) / var_129_18

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_13 + var_129_18 and arg_126_1.time_ < var_129_13 + var_129_18 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938032032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938032032
		arg_130_1.duration_ = 5.91

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938032033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_9000

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["10144"]) and arg_130_1.var_.actorSpriteComps10144 == nil then
				arg_130_1.var_.actorSpriteComps10144 = arg_130_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["10144"]) then
				if arg_130_1.var_.actorSpriteComps10144 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 0.5, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["10144"]) and arg_130_1.var_.actorSpriteComps10144 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps10144 = nil
			end

			local var_133_2 = arg_130_1.actors_["10144"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10144 = var_133_2.localPosition
				var_133_2.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10144", 7)

				for iter_133_4 = 0, var_133_2.childCount - 1 do
					local var_133_3 = var_133_2:GetChild(iter_133_4)

					if var_133_3.name == "" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 0) / var_133_4)
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_5 = arg_130_1.actors_["10183"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10183 = var_133_5.localPosition
				var_133_5.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10183", 7)

				for iter_133_5 = 0, var_133_5.childCount - 1 do
					local var_133_6 = var_133_5:GetChild(iter_133_5)

					if var_133_6.name == "" or not string.find(var_133_6.name, "split") then
						var_133_6.gameObject:SetActive(true)
					else
						var_133_6.gameObject:SetActive(false)
					end
				end
			end

			local var_133_7 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				var_133_5.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 0) / var_133_7)
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				var_133_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_8 = manager.ui.mainCamera.transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.shakeOldPos = var_133_8.localPosition
			end

			local var_133_9 = 0.6

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_9 then
				local var_133_10, var_133_11 = math.modf((arg_130_1.time_ - 0) / 0.066)

				var_133_8.localPosition = Vector3.New(var_133_11 * 0.13, var_133_11 * 0.13, var_133_11 * 0.13) + arg_130_1.var_.shakeOldPos
			end

			if arg_130_1.time_ >= 0 + var_133_9 and arg_130_1.time_ < 0 + var_133_9 + arg_133_0 then
				var_133_8.localPosition = arg_130_1.var_.shakeOldPos
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				local var_133_12 = arg_130_1.var_.effectfeizoule1

				if not arg_130_1.var_.effectfeizoule1 then
					var_133_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_133_12.name = "feizoule1"
					arg_130_1.var_.effectfeizoule1 = var_133_12
				else
					var_133_12.transform:SetParent(var_133_9000)
				end

				var_133_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_133_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_133_12.transform.localScale = Vector3.New(var_133_12.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_133_12.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_133_12.transform.localScale.z)
			end

			local var_133_14 = 0

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_14 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			if arg_130_1.time_ >= var_133_14 + 1.93774389754981 and arg_130_1.time_ < var_133_14 + 1.93774389754981 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_15 = 0.912743897549
			local var_133_16 = 1.025

			if 0.912743897549 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_17 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_17:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_18 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(938032032).content)

				arg_130_1.text_.text = var_133_18

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_20 = 41 <= 0 and var_133_16 or var_133_16 * (utf8.len(var_133_18) / 41)

				if (41 <= 0 and var_133_16 or var_133_16 * (utf8.len(var_133_18) / 41)) > 0 and var_133_16 < var_133_20 then
					arg_130_1.talkMaxDuration = var_133_20
					var_133_15 = var_133_15 + 0.3

					if var_133_20 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_18
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = var_133_15 + 0.3
			local var_133_22 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 + 0.3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_21 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_21) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_21 + var_133_22 and arg_130_1.time_ < var_133_21 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "10183",
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
	Play938032033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938032033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938032034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.625

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

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(938032033).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 25 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 25)

				if (25 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 25)) > 0 and var_139_0 < var_139_3 then
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
	Play938032034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938032034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938032035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10183"]) and arg_140_1.var_.actorSpriteComps10183 == nil then
				arg_140_1.var_.actorSpriteComps10183 = arg_140_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10183"]) then
				if arg_140_1.var_.actorSpriteComps10183 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10183"]) and arg_140_1.var_.actorSpriteComps10183 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps10183 = nil
			end

			local var_143_2 = arg_140_1.actors_["10183"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10183 = var_143_2.localPosition
				var_143_2.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10183", 2)

				for iter_143_4 = 0, var_143_2.childCount - 1 do
					local var_143_3 = var_143_2:GetChild(iter_143_4)

					if var_143_3.name == "split_6" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_140_1.time_ - 0) / var_143_4)
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_143_5 = 0
			local var_143_6 = 0.7

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(938032034).content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 28 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 28)

				if (28 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 28)) > 0 and var_143_6 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_10 and arg_140_1.time_ < var_143_5 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938032035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938032035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938032036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10144"]) and arg_144_1.var_.actorSpriteComps10144 == nil then
				arg_144_1.var_.actorSpriteComps10144 = arg_144_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10144"]) then
				if arg_144_1.var_.actorSpriteComps10144 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10144"]) and arg_144_1.var_.actorSpriteComps10144 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps10144 = nil
			end

			local var_147_2 = arg_144_1.actors_["10183"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps10183 == nil then
				arg_144_1.var_.actorSpriteComps10183 = var_147_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_3 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.actorSpriteComps10183 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.actorSpriteComps10183 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_147_7 then
						iter_147_7.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps10183 = nil
			end

			local var_147_5 = arg_144_1.actors_["10144"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10144 = var_147_5.localPosition
				var_147_5.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10144", 4)

				for iter_147_8 = 0, var_147_5.childCount - 1 do
					local var_147_6 = var_147_5:GetChild(iter_147_8)

					if var_147_6.name == "split_6" or not string.find(var_147_6.name, "split") then
						var_147_6.gameObject:SetActive(true)
					else
						var_147_6.gameObject:SetActive(false)
					end
				end
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_144_1.time_ - 0) / var_147_7)
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_147_8 = 0
			local var_147_9 = 0.325

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(938032035).content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_12 = 13 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 13)

				if (13 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 13)) > 0 and var_147_9 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_13 and arg_144_1.time_ < var_147_8 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play938032036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 938032036
		arg_148_1.duration_ = 5.6

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play938032037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_9000

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10144"]) and arg_148_1.var_.actorSpriteComps10144 == nil then
				arg_148_1.var_.actorSpriteComps10144 = arg_148_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10144"]) then
				if arg_148_1.var_.actorSpriteComps10144 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 0.5, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10144"]) and arg_148_1.var_.actorSpriteComps10144 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_148_1.var_.actorSpriteComps10144 = nil
			end

			local var_151_2 = arg_148_1.actors_["10144"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10144 = var_151_2.localPosition
				var_151_2.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10144", 7)

				for iter_151_4 = 0, var_151_2.childCount - 1 do
					local var_151_3 = var_151_2:GetChild(iter_151_4)

					if var_151_3.name == "" or not string.find(var_151_3.name, "split") then
						var_151_3.gameObject:SetActive(true)
					else
						var_151_3.gameObject:SetActive(false)
					end
				end
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_148_1.time_ - 0) / var_151_4)
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_151_5 = arg_148_1.actors_["10183"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10183 = var_151_5.localPosition
				var_151_5.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10183", 7)

				for iter_151_5 = 0, var_151_5.childCount - 1 do
					local var_151_6 = var_151_5:GetChild(iter_151_5)

					if var_151_6.name == "" or not string.find(var_151_6.name, "split") then
						var_151_6.gameObject:SetActive(true)
					else
						var_151_6.gameObject:SetActive(false)
					end
				end
			end

			local var_151_7 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				var_151_5.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_148_1.time_ - 0) / var_151_7)
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				var_151_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				local var_151_8 = arg_148_1.var_.effectdaleyiquan1

				if not arg_148_1.var_.effectdaleyiquan1 then
					var_151_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_151_8.name = "daleyiquan1"
					arg_148_1.var_.effectdaleyiquan1 = var_151_8
				else
					var_151_8.transform:SetParent(var_151_9000)
				end

				var_151_8.transform.localPosition = Vector3.New(0, -0.52, 0)
				var_151_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_151_8.transform.localScale = Vector3.New(var_151_8.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_151_8.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_151_8.transform.localScale.z)
			end

			if 1.5 < arg_148_1.time_ and arg_148_1.time_ <= 1.5 + arg_151_0 then
				if arg_148_1.var_.effectdaleyiquan1 then
					Object.Destroy(arg_148_1.var_.effectdaleyiquan1)

					arg_148_1.var_.effectdaleyiquan1 = nil
				end
			end

			local var_151_11 = manager.ui.mainCamera.transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.shakeOldPos = var_151_11.localPosition
			end

			local var_151_12 = 0.6

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_12 then
				local var_151_13, var_151_14 = math.modf((arg_148_1.time_ - 0) / 0.066)

				var_151_11.localPosition = Vector3.New(var_151_14 * 0.13, var_151_14 * 0.13, var_151_14 * 0.13) + arg_148_1.var_.shakeOldPos
			end

			if arg_148_1.time_ >= 0 + var_151_12 and arg_148_1.time_ < 0 + var_151_12 + arg_151_0 then
				var_151_11.localPosition = arg_148_1.var_.shakeOldPos
			end

			local var_151_15 = 0

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			if arg_148_1.time_ >= var_151_15 + 1.5 and arg_148_1.time_ < var_151_15 + 1.5 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_16 = 0.6
			local var_151_17 = 0.9

			if 0.6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_18 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_18:setOnUpdate(LuaHelper.FloatAction(function(arg_152_0)
					arg_148_1.dialogCg_.alpha = arg_152_0
				end))
				var_151_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(938032036).content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 36 <= 0 and var_151_17 or var_151_17 * (utf8.len(var_151_19) / 36)

				if (36 <= 0 and var_151_17 or var_151_17 * (utf8.len(var_151_19) / 36)) > 0 and var_151_17 < var_151_21 then
					arg_148_1.talkMaxDuration = var_151_21
					var_151_16 = var_151_16 + 0.3

					if var_151_21 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_21 + var_151_16
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_22 = var_151_16 + 0.3
			local var_151_23 = math.max(var_151_17, arg_148_1.talkMaxDuration)

			if var_151_16 + 0.3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_22 + var_151_23 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_22) / var_151_23

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_22 + var_151_23 and arg_148_1.time_ < var_151_22 + var_151_23 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play938032037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938032037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938032038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1.05

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(938032037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 42 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 42)

				if (42 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 42)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play938032038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938032038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938032039(arg_158_1)
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

					if var_161_3.name == "split_2" or not string.find(var_161_3.name, "split") then
						var_161_3.gameObject:SetActive(true)
					else
						var_161_3.gameObject:SetActive(false)
					end
				end
			end

			local var_161_4 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				var_161_2.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_158_1.time_ - 0) / var_161_4)
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_161_5 = 0
			local var_161_6 = 0.2

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

				local var_161_7 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(938032038).content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 8 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 8)

				if (8 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 8)) > 0 and var_161_6 < var_161_9 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play938032039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938032039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938032040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10144"]) and arg_162_1.var_.actorSpriteComps10144 == nil then
				arg_162_1.var_.actorSpriteComps10144 = arg_162_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10144"]) then
				if arg_162_1.var_.actorSpriteComps10144 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 0.5, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10144"]) and arg_162_1.var_.actorSpriteComps10144 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_162_1.var_.actorSpriteComps10144 = nil
			end

			local var_165_2 = 0
			local var_165_3 = 0.225

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_4 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(938032039).content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 9 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 9)

				if (9 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_4) / 9)) > 0 and var_165_3 < var_165_6 then
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

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938032040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938032040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938032041(arg_166_1)
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

					if var_169_3.name == "" then
						var_169_3:SetAsLastSibling()
						var_169_3.gameObject:SetActive(true)

						arg_166_1.var_.actorSpriteSplit10144 = var_169_3.gameObject:GetComponent(typeof(Image))

						arg_166_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_169_4 = 0.5

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_166_1.time_ - 0) / var_169_4)

				if arg_166_1.var_.actorSpriteSplit10144 ~= nil then
					arg_166_1.var_.actorSpriteSplit10144:SetAlpha((arg_166_1.time_ - 0) / var_169_4)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_166_1.var_.actorSpriteSplit10144 ~= nil then
					arg_166_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_169_5 = 0
			local var_169_6 = 0.675

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

				local var_169_7 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(938032040).content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 27 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 27)

				if (27 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 27)) > 0 and var_169_6 < var_169_9 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play938032041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938032041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938032042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10144 = arg_170_1.actors_["10144"].transform.localPosition
				arg_170_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10144", 3)

				for iter_173_0 = 0, arg_170_1.actors_["10144"].transform.childCount - 1 do
					local var_173_0 = arg_170_1.actors_["10144"].transform:GetChild(iter_173_0)

					if var_173_0.name == "" or not string.find(var_173_0.name, "split") then
						var_173_0.gameObject:SetActive(true)
					else
						var_173_0.gameObject:SetActive(false)
					end
				end
			end

			local var_173_1 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_1 then
				arg_170_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_170_1.time_ - 0) / var_173_1)
			end

			if arg_170_1.time_ >= 0 + var_173_1 and arg_170_1.time_ < 0 + var_173_1 + arg_173_0 then
				arg_170_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_173_2 = 0
			local var_173_3 = 0.95

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(938032041).content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_6 = 38 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_4) / 38)

				if (38 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_4) / 38)) > 0 and var_173_3 < var_173_6 then
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

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play938032042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938032042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938032043(arg_174_1)
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
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10144"]) and arg_174_1.var_.actorSpriteComps10144 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_2 = 0
			local var_177_3 = 0.45

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_4 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(938032042).content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_6 = 18 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_4) / 18)

				if (18 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_4) / 18)) > 0 and var_177_3 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_7 and arg_174_1.time_ < var_177_2 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play938032043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938032043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938032044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10144"]) and arg_178_1.var_.actorSpriteComps10144 == nil then
				arg_178_1.var_.actorSpriteComps10144 = arg_178_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10144"]) then
				if arg_178_1.var_.actorSpriteComps10144 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10144"]) and arg_178_1.var_.actorSpriteComps10144 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps10144 = nil
			end

			local var_181_2 = arg_178_1.actors_["10144"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = var_181_2.localPosition
				var_181_2.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 3)

				for iter_181_4 = 0, var_181_2.childCount - 1 do
					local var_181_3 = var_181_2:GetChild(iter_181_4)

					if var_181_3.name == "split_7" then
						var_181_3:SetAsLastSibling()
						var_181_3.gameObject:SetActive(true)

						arg_178_1.var_.actorSpriteSplit10144 = var_181_3.gameObject:GetComponent(typeof(Image))

						arg_178_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_181_4 = 0.5

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_2.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_178_1.time_ - 0) / var_181_4)

				if arg_178_1.var_.actorSpriteSplit10144 ~= nil then
					arg_178_1.var_.actorSpriteSplit10144:SetAlpha((arg_178_1.time_ - 0) / var_181_4)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_178_1.var_.actorSpriteSplit10144 ~= nil then
					arg_178_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_181_5 = 0
			local var_181_6 = 0.175

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_5 + arg_181_0 then
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

				local var_181_7 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(938032043).content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 7 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_7) / 7)

				if (7 <= 0 and var_181_6 or var_181_6 * (utf8.len(var_181_7) / 7)) > 0 and var_181_6 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_5 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_5
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_6, arg_178_1.talkMaxDuration)

			if var_181_5 <= arg_178_1.time_ and arg_178_1.time_ < var_181_5 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_5) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_5 + var_181_10 and arg_178_1.time_ < var_181_5 + var_181_10 + arg_181_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play938032044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 938032044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play938032045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10144 = arg_182_1.actors_["10144"].transform.localPosition
				arg_182_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10144", 3)

				for iter_185_0 = 0, arg_182_1.actors_["10144"].transform.childCount - 1 do
					local var_185_0 = arg_182_1.actors_["10144"].transform:GetChild(iter_185_0)

					if var_185_0.name == "" then
						var_185_0:SetAsLastSibling()
						var_185_0.gameObject:SetActive(true)

						arg_182_1.var_.actorSpriteSplit10144 = var_185_0.gameObject:GetComponent(typeof(Image))

						arg_182_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_185_1 = 0.5

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_1 then
				arg_182_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_182_1.time_ - 0) / var_185_1)

				if arg_182_1.var_.actorSpriteSplit10144 ~= nil then
					arg_182_1.var_.actorSpriteSplit10144:SetAlpha((arg_182_1.time_ - 0) / var_185_1)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_1 and arg_182_1.time_ < 0 + var_185_1 + arg_185_0 then
				arg_182_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_182_1.var_.actorSpriteSplit10144 ~= nil then
					arg_182_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_185_2 = 0
			local var_185_3 = 0.775

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(938032044).content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 31 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 31)

				if (31 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 31)) > 0 and var_185_3 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_7 and arg_182_1.time_ < var_185_2 + var_185_7 + arg_185_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play938032045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 938032045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play938032046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10144"]) and arg_186_1.var_.actorSpriteComps10144 == nil then
				arg_186_1.var_.actorSpriteComps10144 = arg_186_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10144"]) then
				if arg_186_1.var_.actorSpriteComps10144 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10144"]) and arg_186_1.var_.actorSpriteComps10144 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps10144 = nil
			end

			local var_189_2 = arg_186_1.actors_["10144"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10144 = var_189_2.localPosition
				var_189_2.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("10144", 7)

				for iter_189_4 = 0, var_189_2.childCount - 1 do
					local var_189_3 = var_189_2:GetChild(iter_189_4)

					if var_189_3.name == "" or not string.find(var_189_3.name, "split") then
						var_189_3.gameObject:SetActive(true)
					else
						var_189_3.gameObject:SetActive(false)
					end
				end
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_2.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_186_1.time_ - 0) / var_189_4)
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_189_5 = 0
			local var_189_6 = 1.275

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(938032045).content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 51 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_7) / 51)

				if (51 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_7) / 51)) > 0 and var_189_6 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_10 and arg_186_1.time_ < var_189_5 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play938032046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 938032046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play938032047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.475

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(938032046).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 19 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 19)

				if (19 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 19)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play938032047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 938032047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play938032048(arg_194_1)
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
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 1, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10144"]) and arg_194_1.var_.actorSpriteComps10144 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps10144 = nil
			end

			local var_197_2 = arg_194_1.actors_["10144"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10144 = var_197_2.localPosition
				var_197_2.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("10144", 3)

				for iter_197_4 = 0, var_197_2.childCount - 1 do
					local var_197_3 = var_197_2:GetChild(iter_197_4)

					if var_197_3.name == "split_1" or not string.find(var_197_3.name, "split") then
						var_197_3.gameObject:SetActive(true)
					else
						var_197_3.gameObject:SetActive(false)
					end
				end
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_2.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_194_1.time_ - 0) / var_197_4)
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_197_5 = 0
			local var_197_6 = 0.7

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(938032047).content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 28 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_7) / 28)

				if (28 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_7) / 28)) > 0 and var_197_6 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_10 and arg_194_1.time_ < var_197_5 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play938032048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 938032048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play938032049(arg_198_1)
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
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10144"]) and arg_198_1.var_.actorSpriteComps10144 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps10144 = nil
			end

			local var_201_2 = 0
			local var_201_3 = 0.175

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_4 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(938032048).content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_6 = 7 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 7)

				if (7 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_4) / 7)) > 0 and var_201_3 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_7 and arg_198_1.time_ < var_201_2 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play938032049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 938032049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play938032050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.2

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1561].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(938032049).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 8 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 8)

				if (8 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 8)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play938032050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938032050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938032051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10144 = arg_206_1.actors_["10144"].transform.localPosition
				arg_206_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10144", 7)

				for iter_209_0 = 0, arg_206_1.actors_["10144"].transform.childCount - 1 do
					local var_209_0 = arg_206_1.actors_["10144"].transform:GetChild(iter_209_0)

					if var_209_0.name == "" or not string.find(var_209_0.name, "split") then
						var_209_0.gameObject:SetActive(true)
					else
						var_209_0.gameObject:SetActive(false)
					end
				end
			end

			local var_209_1 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_1 then
				arg_206_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_206_1.time_ - 0) / var_209_1)
			end

			if arg_206_1.time_ >= 0 + var_209_1 and arg_206_1.time_ < 0 + var_209_1 + arg_209_0 then
				arg_206_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_2 = 0
			local var_209_3 = 0.925

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(938032050).content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 37 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 37)

				if (37 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 37)) > 0 and var_209_3 < var_209_6 then
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
	Play938032051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938032051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938032052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.175

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(938032051).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 47 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 47)

				if (47 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 47)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play938032052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938032052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938032053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.175

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
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

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(938032052).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 7 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 7)

				if (7 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 7)) > 0 and var_217_0 < var_217_3 then
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
	Play938032053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938032053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938032054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10144"]) and arg_218_1.var_.actorSpriteComps10144 == nil then
				arg_218_1.var_.actorSpriteComps10144 = arg_218_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10144"]) then
				if arg_218_1.var_.actorSpriteComps10144 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10144"]) and arg_218_1.var_.actorSpriteComps10144 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps10144 = nil
			end

			local var_221_2 = arg_218_1.actors_["10144"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10144 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10144", 2)

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
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_221_5 = 0
			local var_221_6 = 1.275

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
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

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(938032053).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 51 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 51)

				if (51 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 51)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938032054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938032054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938032055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["128404"]) and arg_222_1.var_.actorSpriteComps128404 == nil then
				arg_222_1.var_.actorSpriteComps128404 = arg_222_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["128404"]) then
				if arg_222_1.var_.actorSpriteComps128404 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["128404"]) and arg_222_1.var_.actorSpriteComps128404 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps128404 = nil
			end

			local var_225_2 = arg_222_1.actors_["10144"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10144 == nil then
				arg_222_1.var_.actorSpriteComps10144 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps10144 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								iter_225_5.color = Color.New(Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_5.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_5.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10144 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_225_7 then
						iter_225_7.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10144 = nil
			end

			local var_225_5 = arg_222_1.actors_["128404"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos128404 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("128404", 4)

				for iter_225_8 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_8)

					if var_225_6.name == "split_3" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				local var_225_8 = arg_222_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_225_8 then
					arg_222_1.var_.alphaOldValue128404 = var_225_8.alpha
					arg_222_1.var_.characterEffect128404 = var_225_8
				end

				arg_222_1.var_.alphaOldValue128404 = 0
			end

			local var_225_9 = 0.034

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_9 then
				if arg_222_1.var_.characterEffect128404 then
					arg_222_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_222_1.var_.alphaOldValue128404, 1, (arg_222_1.time_ - 0) / var_225_9)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_9 and arg_222_1.time_ < 0 + var_225_9 + arg_225_0 and arg_222_1.var_.characterEffect128404 then
				arg_222_1.var_.characterEffect128404.alpha = 1
			end

			local var_225_10 = 0
			local var_225_11 = 0.175

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_12 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(938032054).content)

				arg_222_1.text_.text = var_225_12

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_14 = 7 <= 0 and var_225_11 or var_225_11 * (utf8.len(var_225_12) / 7)

				if (7 <= 0 and var_225_11 or var_225_11 * (utf8.len(var_225_12) / 7)) > 0 and var_225_11 < var_225_14 then
					arg_222_1.talkMaxDuration = var_225_14

					if var_225_14 + var_225_10 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_10
					end
				end

				arg_222_1.text_.text = var_225_12
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_15 = math.max(var_225_11, arg_222_1.talkMaxDuration)

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_15 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_10) / var_225_15

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_10 + var_225_15 and arg_222_1.time_ < var_225_10 + var_225_15 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play938032055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938032055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play938032056(arg_226_1)
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

			local var_229_2 = arg_226_1.actors_["128404"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps128404 == nil then
				arg_226_1.var_.actorSpriteComps128404 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps128404 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps128404 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps128404 = nil
			end

			local var_229_5 = arg_226_1.actors_["10144"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10144 = var_229_5.localPosition
				var_229_5.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10144", 2)

				for iter_229_8 = 0, var_229_5.childCount - 1 do
					local var_229_6 = var_229_5:GetChild(iter_229_8)

					if var_229_6.name == "" or not string.find(var_229_6.name, "split") then
						var_229_6.gameObject:SetActive(true)
					else
						var_229_6.gameObject:SetActive(false)
					end
				end
			end

			local var_229_7 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				var_229_5.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_226_1.time_ - 0) / var_229_7)
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				var_229_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_229_8 = 0
			local var_229_9 = 0.425

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
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

				local var_229_10 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(938032055).content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_12 = 17 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_10) / 17)

				if (17 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_10) / 17)) > 0 and var_229_9 < var_229_12 then
					arg_226_1.talkMaxDuration = var_229_12

					if var_229_12 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_13 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_13 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_13

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_13 and arg_226_1.time_ < var_229_8 + var_229_13 + arg_229_0 then
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
	Play938032056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 938032056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play938032057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["128404"]) and arg_230_1.var_.actorSpriteComps128404 == nil then
				arg_230_1.var_.actorSpriteComps128404 = arg_230_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["128404"]) then
				if arg_230_1.var_.actorSpriteComps128404 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["128404"]) and arg_230_1.var_.actorSpriteComps128404 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps128404 = nil
			end

			local var_233_2 = arg_230_1.actors_["10144"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10144 == nil then
				arg_230_1.var_.actorSpriteComps10144 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps10144 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10144 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10144 = nil
			end

			local var_233_5 = arg_230_1.actors_["128404"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos128404 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("128404", 4)

				for iter_233_8 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_8)

					if var_233_6.name == "split_4" then
						var_233_6:SetAsLastSibling()
						var_233_6.gameObject:SetActive(true)

						arg_230_1.var_.actorSpriteSplit128404 = var_233_6.gameObject:GetComponent(typeof(Image))

						arg_230_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_233_7 = 0.5

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_230_1.time_ - 0) / var_233_7)

				if arg_230_1.var_.actorSpriteSplit128404 ~= nil then
					arg_230_1.var_.actorSpriteSplit128404:SetAlpha((arg_230_1.time_ - 0) / var_233_7)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_230_1.var_.actorSpriteSplit128404 ~= nil then
					arg_230_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_233_8 = 0
			local var_233_9 = 0.775

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(938032056).content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_12 = 31 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_10) / 31)

				if (31 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_10) / 31)) > 0 and var_233_9 < var_233_12 then
					arg_230_1.talkMaxDuration = var_233_12

					if var_233_12 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_13 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_13

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_13 and arg_230_1.time_ < var_233_8 + var_233_13 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play938032057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 938032057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play938032058(arg_234_1)
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

			local var_237_2 = arg_234_1.actors_["128404"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps128404 == nil then
				arg_234_1.var_.actorSpriteComps128404 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps128404 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps128404 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps128404 = nil
			end

			local var_237_5 = arg_234_1.actors_["10144"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10144 = var_237_5.localPosition
				var_237_5.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10144", 2)

				for iter_237_8 = 0, var_237_5.childCount - 1 do
					local var_237_6 = var_237_5:GetChild(iter_237_8)

					if var_237_6.name == "" or not string.find(var_237_6.name, "split") then
						var_237_6.gameObject:SetActive(true)
					else
						var_237_6.gameObject:SetActive(false)
					end
				end
			end

			local var_237_7 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				var_237_5.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_234_1.time_ - 0) / var_237_7)
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				var_237_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_237_8 = 0
			local var_237_9 = 1.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
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

				local var_237_10 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(938032057).content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_12 = 58 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_10) / 58)

				if (58 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_10) / 58)) > 0 and var_237_9 < var_237_12 then
					arg_234_1.talkMaxDuration = var_237_12

					if var_237_12 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_13 and arg_234_1.time_ < var_237_8 + var_237_13 + arg_237_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play938032058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 938032058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play938032059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10144 = arg_238_1.actors_["10144"].transform.localPosition
				arg_238_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10144", 2)

				for iter_241_0 = 0, arg_238_1.actors_["10144"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["10144"].transform:GetChild(iter_241_0)

					if var_241_0.name == "" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10144"].transform.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_241_2 = 0
			local var_241_3 = 0.825

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(938032058).content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 33 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 33)

				if (33 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 33)) > 0 and var_241_3 < var_241_6 then
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

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play938032059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 938032059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play938032060(arg_242_1)
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
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10144"]) and arg_242_1.var_.actorSpriteComps10144 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps10144 = nil
			end

			local var_245_2 = 0
			local var_245_3 = 0.1

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_4 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(938032059).content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_6 = 4 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 4)

				if (4 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_4) / 4)) > 0 and var_245_3 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_7 and arg_242_1.time_ < var_245_2 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play938032060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 938032060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play938032061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.05

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(938032060).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 42 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 42)

				if (42 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 42)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play938032061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938032061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938032062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10144"]) and arg_250_1.var_.actorSpriteComps10144 == nil then
				arg_250_1.var_.actorSpriteComps10144 = arg_250_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10144"]) then
				if arg_250_1.var_.actorSpriteComps10144 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10144"]) and arg_250_1.var_.actorSpriteComps10144 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps10144 = nil
			end

			local var_253_2 = arg_250_1.actors_["10144"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10144 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10144", 2)

				for iter_253_4 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_4)

					if var_253_3.name == "split_2" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_250_1.time_ - 0) / var_253_4)
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_253_5 = 0
			local var_253_6 = 0.475

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(938032061).content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 19 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 19)

				if (19 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_7) / 19)) > 0 and var_253_6 < var_253_9 then
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
	Play938032062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938032062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938032063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["10144"]) and arg_254_1.var_.actorSpriteComps10144 == nil then
				arg_254_1.var_.actorSpriteComps10144 = arg_254_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["10144"]) then
				if arg_254_1.var_.actorSpriteComps10144 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["10144"]) and arg_254_1.var_.actorSpriteComps10144 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps10144 = nil
			end

			local var_257_2 = arg_254_1.actors_["10144"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10144 = var_257_2.localPosition
				var_257_2.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10144", 7)

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
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_254_1.time_ - 0) / var_257_4)
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_257_5 = arg_254_1.actors_["128404"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos128404 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("128404", 7)

				for iter_257_5 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_5)

					if var_257_6.name == "" or not string.find(var_257_6.name, "split") then
						var_257_6.gameObject:SetActive(true)
					else
						var_257_6.gameObject:SetActive(false)
					end
				end
			end

			local var_257_7 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_254_1.time_ - 0) / var_257_7)
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_257_8 = 0
			local var_257_9 = 0.85

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_10 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(938032062).content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_12 = 34 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_10) / 34)

				if (34 <= 0 and var_257_9 or var_257_9 * (utf8.len(var_257_10) / 34)) > 0 and var_257_9 < var_257_12 then
					arg_254_1.talkMaxDuration = var_257_12

					if var_257_12 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_13 and arg_254_1.time_ < var_257_8 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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

		arg_254_1:InitPlayNodeList()
	end,
	Play938032063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938032063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938032064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["104902"]) and arg_258_1.var_.actorSpriteComps104902 == nil then
				arg_258_1.var_.actorSpriteComps104902 = arg_258_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["104902"]) then
				if arg_258_1.var_.actorSpriteComps104902 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["104902"]) and arg_258_1.var_.actorSpriteComps104902 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps104902 = nil
			end

			local var_261_2 = arg_258_1.actors_["104902"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos104902 = var_261_2.localPosition
				var_261_2.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("104902", 2)

				for iter_261_4 = 0, var_261_2.childCount - 1 do
					local var_261_3 = var_261_2:GetChild(iter_261_4)

					if var_261_3.name == "split_1" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_2.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_258_1.time_ - 0) / var_261_4)
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_2.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_261_5 = 0
			local var_261_6 = 0.85

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_7 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(938032063).content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 34 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_7) / 34)

				if (34 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_7) / 34)) > 0 and var_261_6 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_10 and arg_258_1.time_ < var_261_5 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play938032064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938032064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938032065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["128404"]) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = arg_262_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["128404"]) then
				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["128404"]) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_2 = arg_262_1.actors_["104902"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps104902 == nil then
				arg_262_1.var_.actorSpriteComps104902 = var_265_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_3 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.actorSpriteComps104902 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps104902 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_265_7 then
						iter_265_7.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_262_1.var_.actorSpriteComps104902 = nil
			end

			local var_265_5 = arg_262_1.actors_["128404"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = var_265_5.localPosition
				var_265_5.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 4)

				for iter_265_8 = 0, var_265_5.childCount - 1 do
					local var_265_6 = var_265_5:GetChild(iter_265_8)

					if var_265_6.name == "split_3" or not string.find(var_265_6.name, "split") then
						var_265_6.gameObject:SetActive(true)
					else
						var_265_6.gameObject:SetActive(false)
					end
				end
			end

			local var_265_7 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				var_265_5.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_262_1.time_ - 0) / var_265_7)
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				var_265_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_265_8 = 0
			local var_265_9 = 0.725

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_10 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(938032064).content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_12 = 29 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_10) / 29)

				if (29 <= 0 and var_265_9 or var_265_9 * (utf8.len(var_265_10) / 29)) > 0 and var_265_9 < var_265_12 then
					arg_262_1.talkMaxDuration = var_265_12

					if var_265_12 + var_265_8 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_8
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = math.max(var_265_9, arg_262_1.talkMaxDuration)

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_13 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_8) / var_265_13

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_8 + var_265_13 and arg_262_1.time_ < var_265_8 + var_265_13 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938032065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938032065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938032066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["106603"]) and arg_266_1.var_.actorSpriteComps106603 == nil then
				arg_266_1.var_.actorSpriteComps106603 = arg_266_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["106603"]) then
				if arg_266_1.var_.actorSpriteComps106603 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["106603"]) and arg_266_1.var_.actorSpriteComps106603 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps106603 = nil
			end

			local var_269_2 = arg_266_1.actors_["128404"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps128404 == nil then
				arg_266_1.var_.actorSpriteComps128404 = var_269_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_3 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.actorSpriteComps128404 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps128404 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_269_7 then
						iter_269_7.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps128404 = nil
			end

			local var_269_5 = arg_266_1.actors_["106603"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos106603 = var_269_5.localPosition
				var_269_5.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("106603", 2)

				for iter_269_8 = 0, var_269_5.childCount - 1 do
					local var_269_6 = var_269_5:GetChild(iter_269_8)

					if var_269_6.name == "" or not string.find(var_269_6.name, "split") then
						var_269_6.gameObject:SetActive(true)
					else
						var_269_6.gameObject:SetActive(false)
					end
				end
			end

			local var_269_7 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				var_269_5.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_266_1.time_ - 0) / var_269_7)
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				var_269_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_269_8 = arg_266_1.actors_["104902"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos104902 = var_269_8.localPosition
				var_269_8.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("104902", 7)

				for iter_269_9 = 0, var_269_8.childCount - 1 do
					local var_269_9 = var_269_8:GetChild(iter_269_9)

					if var_269_9.name == "" or not string.find(var_269_9.name, "split") then
						var_269_9.gameObject:SetActive(true)
					else
						var_269_9.gameObject:SetActive(false)
					end
				end
			end

			local var_269_10 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_10 then
				var_269_8.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_266_1.time_ - 0) / var_269_10)
			end

			if arg_266_1.time_ >= 0 + var_269_10 and arg_266_1.time_ < 0 + var_269_10 + arg_269_0 then
				var_269_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_269_11 = 0
			local var_269_12 = 0.75

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_11 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_13 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(938032065).content)

				arg_266_1.text_.text = var_269_13

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_15 = 30 <= 0 and var_269_12 or var_269_12 * (utf8.len(var_269_13) / 30)

				if (30 <= 0 and var_269_12 or var_269_12 * (utf8.len(var_269_13) / 30)) > 0 and var_269_12 < var_269_15 then
					arg_266_1.talkMaxDuration = var_269_15

					if var_269_15 + var_269_11 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_15 + var_269_11
					end
				end

				arg_266_1.text_.text = var_269_13
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_12, arg_266_1.talkMaxDuration)

			if var_269_11 <= arg_266_1.time_ and arg_266_1.time_ < var_269_11 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_11) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_11 + var_269_16 and arg_266_1.time_ < var_269_11 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play938032066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938032066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938032067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["108301"]) and arg_270_1.var_.actorSpriteComps108301 == nil then
				arg_270_1.var_.actorSpriteComps108301 = arg_270_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["108301"]) then
				if arg_270_1.var_.actorSpriteComps108301 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["108301"]) and arg_270_1.var_.actorSpriteComps108301 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps108301 = nil
			end

			local var_273_2 = arg_270_1.actors_["106603"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps106603 == nil then
				arg_270_1.var_.actorSpriteComps106603 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps106603 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps106603 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_273_7 then
						iter_273_7.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps106603 = nil
			end

			local var_273_5 = arg_270_1.actors_["108301"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos108301 = var_273_5.localPosition
				var_273_5.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("108301", 4)

				for iter_273_8 = 0, var_273_5.childCount - 1 do
					local var_273_6 = var_273_5:GetChild(iter_273_8)

					if var_273_6.name == "split_1" or not string.find(var_273_6.name, "split") then
						var_273_6.gameObject:SetActive(true)
					else
						var_273_6.gameObject:SetActive(false)
					end
				end
			end

			local var_273_7 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_270_1.time_ - 0) / var_273_7)
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_273_8 = arg_270_1.actors_["128404"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos128404 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("128404", 7)

				for iter_273_9 = 0, var_273_8.childCount - 1 do
					local var_273_9 = var_273_8:GetChild(iter_273_9)

					if var_273_9.name == "" or not string.find(var_273_9.name, "split") then
						var_273_9.gameObject:SetActive(true)
					else
						var_273_9.gameObject:SetActive(false)
					end
				end
			end

			local var_273_10 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_10 then
				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_270_1.time_ - 0) / var_273_10)
			end

			if arg_270_1.time_ >= 0 + var_273_10 and arg_270_1.time_ < 0 + var_273_10 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_11 = 0
			local var_273_12 = 0.4

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(938032066).content)

				arg_270_1.text_.text = var_273_13

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 16 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 16)

				if (16 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_13) / 16)) > 0 and var_273_12 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_11 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_11
					end
				end

				arg_270_1.text_.text = var_273_13
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_12, arg_270_1.talkMaxDuration)

			if var_273_11 <= arg_270_1.time_ and arg_270_1.time_ < var_273_11 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_11) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_11 + var_273_16 and arg_270_1.time_ < var_273_11 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play938032067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938032067
		arg_274_1.duration_ = 1

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"

			SetActive(arg_274_1.choicesGo_, true)

			for iter_275_0, iter_275_1 in ipairs(arg_274_1.choices_) do
				SetActive(iter_275_1.go, iter_275_0 <= 1)
			end

			arg_274_1.choices_[1].txt.text = arg_274_1:FormatText(StoryChoiceCfg[1782].name)
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938032068(arg_274_1)
			end

			arg_274_1:RecordChoiceLog(938032067, 1782)
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["108301"]) and arg_274_1.var_.actorSpriteComps108301 == nil then
				arg_274_1.var_.actorSpriteComps108301 = arg_274_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["108301"]) then
				if arg_274_1.var_.actorSpriteComps108301 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["108301"]) and arg_274_1.var_.actorSpriteComps108301 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps108301 = nil
			end

			local var_277_2 = 0

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			if arg_274_1.time_ >= var_277_2 + 0.999999999999 and arg_274_1.time_ < var_277_2 + 0.999999999999 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938032068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938032068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938032069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_0 = arg_278_1.bgs_.ST0119

				arg_278_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_1 = var_281_0:GetComponent("SpriteRenderer")

				if var_281_1 and var_281_1.sprite then
					local var_281_2 = 2 * (var_281_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_0.transform.localScale = Vector3.New(var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "ST0119" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_3 = 4

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_3 + 0.3 and arg_278_1.time_ < var_281_3 + 0.3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_4 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_5 = 2

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_5 then
				local var_281_6 = Color.New(0, 0, 0)

				var_281_6.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_4) / var_281_5)
				arg_278_1.mask_.color = var_281_6
			end

			if arg_278_1.time_ >= var_281_4 + var_281_5 and arg_278_1.time_ < var_281_4 + var_281_5 + arg_281_0 then
				local var_281_7 = Color.New(0, 0, 0)

				var_281_7.a = 1
				arg_278_1.mask_.color = var_281_7
			end

			local var_281_8 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_9 = 2

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_9 then
				local var_281_10 = Color.New(0, 0, 0)

				var_281_10.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_8) / var_281_9)
				arg_278_1.mask_.color = var_281_10
			end

			if arg_278_1.time_ >= var_281_8 + var_281_9 and arg_278_1.time_ < var_281_8 + var_281_9 + arg_281_0 then
				local var_281_11 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_11.a = 0
				arg_278_1.mask_.color = var_281_11
			end

			local var_281_12 = arg_278_1.actors_["108301"]

			if 3.799999999999 < arg_278_1.time_ and arg_278_1.time_ <= 3.799999999999 + arg_281_0 and not isNil(var_281_12) and arg_278_1.var_.actorSpriteComps108301 == nil then
				arg_278_1.var_.actorSpriteComps108301 = var_281_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_13 = 0.2

			if 3.799999999999 <= arg_278_1.time_ and arg_278_1.time_ < 3.799999999999 + var_281_13 and not isNil(var_281_12) then
				if arg_278_1.var_.actorSpriteComps108301 then
					for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_281_3 then
							if arg_278_1.isInRecall_ then
								iter_281_3.color = Color.New(Mathf.Lerp(iter_281_3.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 3.799999999999) / var_281_13), Mathf.Lerp(iter_281_3.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 3.799999999999) / var_281_13), (Mathf.Lerp(iter_281_3.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 3.799999999999) / var_281_13)))
							else
								local var_281_14 = Mathf.Lerp(iter_281_3.color.r, 1, (arg_278_1.time_ - 3.799999999999) / var_281_13)

								iter_281_3.color = Color.New(var_281_14, var_281_14, var_281_14)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 3.799999999999 + var_281_13 and arg_278_1.time_ < 3.799999999999 + var_281_13 + arg_281_0 and not isNil(var_281_12) and arg_278_1.var_.actorSpriteComps108301 then
				for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_281_5 then
						iter_281_5.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps108301 = nil
			end

			local var_281_15 = arg_278_1.actors_["108301"].transform

			if 3.8 < arg_278_1.time_ and arg_278_1.time_ <= 3.8 + arg_281_0 then
				arg_278_1.var_.moveOldPos108301 = var_281_15.localPosition
				var_281_15.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("108301", 3)

				for iter_281_6 = 0, var_281_15.childCount - 1 do
					local var_281_16 = var_281_15:GetChild(iter_281_6)

					if var_281_16.name == "" or not string.find(var_281_16.name, "split") then
						var_281_16.gameObject:SetActive(true)
					else
						var_281_16.gameObject:SetActive(false)
					end
				end
			end

			local var_281_17 = 0.001

			if 3.8 <= arg_278_1.time_ and arg_278_1.time_ < 3.8 + var_281_17 then
				var_281_15.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_278_1.time_ - 3.8) / var_281_17)
			end

			if arg_278_1.time_ >= 3.8 + var_281_17 and arg_278_1.time_ < 3.8 + var_281_17 + arg_281_0 then
				var_281_15.localPosition = Vector3.New(0, -360, -195)
			end

			local var_281_18 = arg_278_1.actors_["108301"].transform

			if 1.966 < arg_278_1.time_ and arg_278_1.time_ <= 1.966 + arg_281_0 then
				arg_278_1.var_.moveOldPos108301 = var_281_18.localPosition
				var_281_18.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("108301", 7)

				for iter_281_7 = 0, var_281_18.childCount - 1 do
					local var_281_19 = var_281_18:GetChild(iter_281_7)

					if var_281_19.name == "" or not string.find(var_281_19.name, "split") then
						var_281_19.gameObject:SetActive(true)
					else
						var_281_19.gameObject:SetActive(false)
					end
				end
			end

			local var_281_20 = 0.001

			if 1.966 <= arg_278_1.time_ and arg_278_1.time_ < 1.966 + var_281_20 then
				var_281_18.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_278_1.time_ - 1.966) / var_281_20)
			end

			if arg_278_1.time_ >= 1.966 + var_281_20 and arg_278_1.time_ < 1.966 + var_281_20 + arg_281_0 then
				var_281_18.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_21 = arg_278_1.actors_["106603"].transform

			if 1.966 < arg_278_1.time_ and arg_278_1.time_ <= 1.966 + arg_281_0 then
				arg_278_1.var_.moveOldPos106603 = var_281_21.localPosition
				var_281_21.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("106603", 7)

				for iter_281_8 = 0, var_281_21.childCount - 1 do
					local var_281_22 = var_281_21:GetChild(iter_281_8)

					if var_281_22.name == "" or not string.find(var_281_22.name, "split") then
						var_281_22.gameObject:SetActive(true)
					else
						var_281_22.gameObject:SetActive(false)
					end
				end
			end

			local var_281_23 = 0.001

			if 1.966 <= arg_278_1.time_ and arg_278_1.time_ < 1.966 + var_281_23 then
				var_281_21.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_278_1.time_ - 1.966) / var_281_23)
			end

			if arg_278_1.time_ >= 1.966 + var_281_23 and arg_278_1.time_ < 1.966 + var_281_23 + arg_281_0 then
				var_281_21.localPosition = Vector3.New(0, -2000, 0)
			end

			if 3.799999999999 < arg_278_1.time_ and arg_278_1.time_ <= 3.799999999999 + arg_281_0 then
				local var_281_24 = arg_278_1.actors_["108301"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_281_24 then
					arg_278_1.var_.alphaOldValue108301 = var_281_24.alpha
					arg_278_1.var_.characterEffect108301 = var_281_24
				end

				arg_278_1.var_.alphaOldValue108301 = 0
			end

			local var_281_25 = 0.5

			if 3.799999999999 <= arg_278_1.time_ and arg_278_1.time_ < 3.799999999999 + var_281_25 then
				if arg_278_1.var_.characterEffect108301 then
					arg_278_1.var_.characterEffect108301.alpha = Mathf.Lerp(arg_278_1.var_.alphaOldValue108301, 1, (arg_278_1.time_ - 3.799999999999) / var_281_25)
				end
			end

			if arg_278_1.time_ >= 3.799999999999 + var_281_25 and arg_278_1.time_ < 3.799999999999 + var_281_25 + arg_281_0 and arg_278_1.var_.characterEffect108301 then
				arg_278_1.var_.characterEffect108301.alpha = 1
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_26 = 3.999999999999
			local var_281_27 = 0.525

			if 3.999999999999 < arg_278_1.time_ and arg_278_1.time_ <= var_281_26 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_28 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_28:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_29 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(938032068).content)

				arg_278_1.text_.text = var_281_29

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_31 = 21 <= 0 and var_281_27 or var_281_27 * (utf8.len(var_281_29) / 21)

				if (21 <= 0 and var_281_27 or var_281_27 * (utf8.len(var_281_29) / 21)) > 0 and var_281_27 < var_281_31 then
					arg_278_1.talkMaxDuration = var_281_31
					var_281_26 = var_281_26 + 0.3

					if var_281_31 + var_281_26 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_31 + var_281_26
					end
				end

				arg_278_1.text_.text = var_281_29
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_32 = var_281_26 + 0.3
			local var_281_33 = math.max(var_281_27, arg_278_1.talkMaxDuration)

			if var_281_26 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_32 + var_281_33 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_32) / var_281_33

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_32 + var_281_33 and arg_278_1.time_ < var_281_32 + var_281_33 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play938032069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 938032069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play938032070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["108301"]) and arg_284_1.var_.actorSpriteComps108301 == nil then
				arg_284_1.var_.actorSpriteComps108301 = arg_284_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_0 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["108301"]) then
				if arg_284_1.var_.actorSpriteComps108301 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								iter_287_1.color = Color.New(Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor2.r, (arg_284_1.time_ - 0) / var_287_0), Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor2.g, (arg_284_1.time_ - 0) / var_287_0), (Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor2.b, (arg_284_1.time_ - 0) / var_287_0)))
							else
								local var_287_1 = Mathf.Lerp(iter_287_1.color.r, 0.5, (arg_284_1.time_ - 0) / var_287_0)

								iter_287_1.color = Color.New(var_287_1, var_287_1, var_287_1)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["108301"]) and arg_284_1.var_.actorSpriteComps108301 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_287_3 then
						iter_287_3.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_284_1.var_.actorSpriteComps108301 = nil
			end

			local var_287_2 = 0
			local var_287_3 = 0.5

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_4 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(938032069).content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_6 = 20 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_4) / 20)

				if (20 <= 0 and var_287_3 or var_287_3 * (utf8.len(var_287_4) / 20)) > 0 and var_287_3 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_2 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_2
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_3, arg_284_1.talkMaxDuration)

			if var_287_2 <= arg_284_1.time_ and arg_284_1.time_ < var_287_2 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_2) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_2 + var_287_7 and arg_284_1.time_ < var_287_2 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play938032070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 938032070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play938032071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["108301"]) and arg_288_1.var_.actorSpriteComps108301 == nil then
				arg_288_1.var_.actorSpriteComps108301 = arg_288_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_0 = 0.2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["108301"]) then
				if arg_288_1.var_.actorSpriteComps108301 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								iter_291_1.color = Color.New(Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor1.r, (arg_288_1.time_ - 0) / var_291_0), Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor1.g, (arg_288_1.time_ - 0) / var_291_0), (Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor1.b, (arg_288_1.time_ - 0) / var_291_0)))
							else
								local var_291_1 = Mathf.Lerp(iter_291_1.color.r, 1, (arg_288_1.time_ - 0) / var_291_0)

								iter_291_1.color = Color.New(var_291_1, var_291_1, var_291_1)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["108301"]) and arg_288_1.var_.actorSpriteComps108301 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_291_3 then
						iter_291_3.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps108301 = nil
			end

			local var_291_2 = arg_288_1.actors_["108301"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos108301 = var_291_2.localPosition
				var_291_2.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("108301", 3)

				for iter_291_4 = 0, var_291_2.childCount - 1 do
					local var_291_3 = var_291_2:GetChild(iter_291_4)

					if var_291_3.name == "split_2" or not string.find(var_291_3.name, "split") then
						var_291_3.gameObject:SetActive(true)
					else
						var_291_3.gameObject:SetActive(false)
					end
				end
			end

			local var_291_4 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				var_291_2.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_288_1.time_ - 0) / var_291_4)
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				var_291_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_291_5 = 0
			local var_291_6 = 0.4

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_7 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(938032070).content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 16 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_7) / 16)

				if (16 <= 0 and var_291_6 or var_291_6 * (utf8.len(var_291_7) / 16)) > 0 and var_291_6 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_5 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_5
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_6, arg_288_1.talkMaxDuration)

			if var_291_5 <= arg_288_1.time_ and arg_288_1.time_ < var_291_5 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_5) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_5 + var_291_10 and arg_288_1.time_ < var_291_5 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play938032071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 938032071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play938032072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["108301"]) and arg_292_1.var_.actorSpriteComps108301 == nil then
				arg_292_1.var_.actorSpriteComps108301 = arg_292_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["108301"]) then
				if arg_292_1.var_.actorSpriteComps108301 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								iter_295_1.color = Color.New(Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor2.r, (arg_292_1.time_ - 0) / var_295_0), Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor2.g, (arg_292_1.time_ - 0) / var_295_0), (Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor2.b, (arg_292_1.time_ - 0) / var_295_0)))
							else
								local var_295_1 = Mathf.Lerp(iter_295_1.color.r, 0.5, (arg_292_1.time_ - 0) / var_295_0)

								iter_295_1.color = Color.New(var_295_1, var_295_1, var_295_1)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["108301"]) and arg_292_1.var_.actorSpriteComps108301 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_292_1.var_.actorSpriteComps108301 = nil
			end

			local var_295_2 = 0
			local var_295_3 = 0.475

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_4 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(938032071).content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_6 = 19 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_4) / 19)

				if (19 <= 0 and var_295_3 or var_295_3 * (utf8.len(var_295_4) / 19)) > 0 and var_295_3 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_2 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_2
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_3, arg_292_1.talkMaxDuration)

			if var_295_2 <= arg_292_1.time_ and arg_292_1.time_ < var_295_2 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_2) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_2 + var_295_7 and arg_292_1.time_ < var_295_2 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play938032072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 938032072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play938032073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["108301"]) and arg_296_1.var_.actorSpriteComps108301 == nil then
				arg_296_1.var_.actorSpriteComps108301 = arg_296_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["108301"]) then
				if arg_296_1.var_.actorSpriteComps108301 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 1, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["108301"]) and arg_296_1.var_.actorSpriteComps108301 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps108301 = nil
			end

			local var_299_2 = arg_296_1.actors_["108301"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos108301 = var_299_2.localPosition
				var_299_2.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("108301", 3)

				for iter_299_4 = 0, var_299_2.childCount - 1 do
					local var_299_3 = var_299_2:GetChild(iter_299_4)

					if var_299_3.name == "split_1" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_2.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_296_1.time_ - 0) / var_299_4)
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_299_5 = 0
			local var_299_6 = 0.3

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_7 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(938032072).content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 12 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_7) / 12)

				if (12 <= 0 and var_299_6 or var_299_6 * (utf8.len(var_299_7) / 12)) > 0 and var_299_6 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_5 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_5
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_6, arg_296_1.talkMaxDuration)

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_5) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_5 + var_299_10 and arg_296_1.time_ < var_299_5 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play938032073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 938032073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play938032074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["108301"]) and arg_300_1.var_.actorSpriteComps108301 == nil then
				arg_300_1.var_.actorSpriteComps108301 = arg_300_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["108301"]) then
				if arg_300_1.var_.actorSpriteComps108301 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["108301"]) and arg_300_1.var_.actorSpriteComps108301 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps108301 = nil
			end

			local var_303_2 = 0
			local var_303_3 = 0.6

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_2 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_4 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(938032073).content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 24 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_4) / 24)

				if (24 <= 0 and var_303_3 or var_303_3 * (utf8.len(var_303_4) / 24)) > 0 and var_303_3 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_2
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_3, arg_300_1.talkMaxDuration)

			if var_303_2 <= arg_300_1.time_ and arg_300_1.time_ < var_303_2 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_2) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_2 + var_303_7 and arg_300_1.time_ < var_303_2 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play938032074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 938032074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play938032075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["108301"]) and arg_304_1.var_.actorSpriteComps108301 == nil then
				arg_304_1.var_.actorSpriteComps108301 = arg_304_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_0 = 0.2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["108301"]) then
				if arg_304_1.var_.actorSpriteComps108301 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								iter_307_1.color = Color.New(Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_0), Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_0), (Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_0)))
							else
								local var_307_1 = Mathf.Lerp(iter_307_1.color.r, 1, (arg_304_1.time_ - 0) / var_307_0)

								iter_307_1.color = Color.New(var_307_1, var_307_1, var_307_1)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["108301"]) and arg_304_1.var_.actorSpriteComps108301 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_307_3 then
						iter_307_3.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps108301 = nil
			end

			local var_307_2 = arg_304_1.actors_["108301"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos108301 = var_307_2.localPosition
				var_307_2.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("108301", 3)

				for iter_307_4 = 0, var_307_2.childCount - 1 do
					local var_307_3 = var_307_2:GetChild(iter_307_4)

					if var_307_3.name == "split_2" then
						var_307_3:SetAsLastSibling()
						var_307_3.gameObject:SetActive(true)

						arg_304_1.var_.actorSpriteSplit108301 = var_307_3.gameObject:GetComponent(typeof(Image))

						arg_304_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_307_4 = 0.5

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				var_307_2.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_304_1.time_ - 0) / var_307_4)

				if arg_304_1.var_.actorSpriteSplit108301 ~= nil then
					arg_304_1.var_.actorSpriteSplit108301:SetAlpha((arg_304_1.time_ - 0) / var_307_4)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				var_307_2.localPosition = Vector3.New(0, -360, -195)

				if arg_304_1.var_.actorSpriteSplit108301 ~= nil then
					arg_304_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_307_5 = 0
			local var_307_6 = 0.675

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_7 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(938032074).content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 27 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_7) / 27)

				if (27 <= 0 and var_307_6 or var_307_6 * (utf8.len(var_307_7) / 27)) > 0 and var_307_6 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_5 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_5
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_6, arg_304_1.talkMaxDuration)

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_5) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_5 + var_307_10 and arg_304_1.time_ < var_307_5 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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

		arg_304_1:InitPlayNodeList()
	end,
	Play938032075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 938032075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play938032076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["108301"]) and arg_308_1.var_.actorSpriteComps108301 == nil then
				arg_308_1.var_.actorSpriteComps108301 = arg_308_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["108301"]) then
				if arg_308_1.var_.actorSpriteComps108301 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								iter_311_1.color = Color.New(Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_0), Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_0), (Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_0)))
							else
								local var_311_1 = Mathf.Lerp(iter_311_1.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_0)

								iter_311_1.color = Color.New(var_311_1, var_311_1, var_311_1)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["108301"]) and arg_308_1.var_.actorSpriteComps108301 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps108301 = nil
			end

			local var_311_2 = 0
			local var_311_3 = 0.725

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_4 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(938032075).content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_6 = 29 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_4) / 29)

				if (29 <= 0 and var_311_3 or var_311_3 * (utf8.len(var_311_4) / 29)) > 0 and var_311_3 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_2 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_2
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_3, arg_308_1.talkMaxDuration)

			if var_311_2 <= arg_308_1.time_ and arg_308_1.time_ < var_311_2 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_2) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_2 + var_311_7 and arg_308_1.time_ < var_311_2 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play938032076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 938032076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play938032077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["108301"]) and arg_312_1.var_.actorSpriteComps108301 == nil then
				arg_312_1.var_.actorSpriteComps108301 = arg_312_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["108301"]) then
				if arg_312_1.var_.actorSpriteComps108301 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 1, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["108301"]) and arg_312_1.var_.actorSpriteComps108301 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps108301 = nil
			end

			local var_315_2 = arg_312_1.actors_["108301"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos108301 = var_315_2.localPosition
				var_315_2.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("108301", 3)

				for iter_315_4 = 0, var_315_2.childCount - 1 do
					local var_315_3 = var_315_2:GetChild(iter_315_4)

					if var_315_3.name == "split_5" then
						var_315_3:SetAsLastSibling()
						var_315_3.gameObject:SetActive(true)

						arg_312_1.var_.actorSpriteSplit108301 = var_315_3.gameObject:GetComponent(typeof(Image))

						arg_312_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_315_4 = 0.5

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				var_315_2.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_312_1.time_ - 0) / var_315_4)

				if arg_312_1.var_.actorSpriteSplit108301 ~= nil then
					arg_312_1.var_.actorSpriteSplit108301:SetAlpha((arg_312_1.time_ - 0) / var_315_4)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				var_315_2.localPosition = Vector3.New(0, -360, -195)

				if arg_312_1.var_.actorSpriteSplit108301 ~= nil then
					arg_312_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_315_5 = 0
			local var_315_6 = 0.5

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_7 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(938032076).content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 20 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_7) / 20)

				if (20 <= 0 and var_315_6 or var_315_6 * (utf8.len(var_315_7) / 20)) > 0 and var_315_6 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_5 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_5
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_6, arg_312_1.talkMaxDuration)

			if var_315_5 <= arg_312_1.time_ and arg_312_1.time_ < var_315_5 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_5) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_5 + var_315_10 and arg_312_1.time_ < var_315_5 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play938032077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 938032077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play938032078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["108301"]) and arg_316_1.var_.actorSpriteComps108301 == nil then
				arg_316_1.var_.actorSpriteComps108301 = arg_316_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["108301"]) then
				if arg_316_1.var_.actorSpriteComps108301 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["108301"]) and arg_316_1.var_.actorSpriteComps108301 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps108301 = nil
			end

			local var_319_2 = 0
			local var_319_3 = 0.925

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_4 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(938032077).content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_6 = 37 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_4) / 37)

				if (37 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_4) / 37)) > 0 and var_319_3 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_2
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_3, arg_316_1.talkMaxDuration)

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_2) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_2 + var_319_7 and arg_316_1.time_ < var_319_2 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play938032078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 938032078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play938032079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["10144"]) and arg_320_1.var_.actorSpriteComps10144 == nil then
				arg_320_1.var_.actorSpriteComps10144 = arg_320_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_0 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["10144"]) then
				if arg_320_1.var_.actorSpriteComps10144 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								iter_323_1.color = Color.New(Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor1.r, (arg_320_1.time_ - 0) / var_323_0), Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor1.g, (arg_320_1.time_ - 0) / var_323_0), (Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor1.b, (arg_320_1.time_ - 0) / var_323_0)))
							else
								local var_323_1 = Mathf.Lerp(iter_323_1.color.r, 1, (arg_320_1.time_ - 0) / var_323_0)

								iter_323_1.color = Color.New(var_323_1, var_323_1, var_323_1)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["10144"]) and arg_320_1.var_.actorSpriteComps10144 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_323_3 then
						iter_323_3.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_320_1.var_.actorSpriteComps10144 = nil
			end

			local var_323_2 = arg_320_1.actors_["10144"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10144 = var_323_2.localPosition
				var_323_2.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10144", 4)

				for iter_323_4 = 0, var_323_2.childCount - 1 do
					local var_323_3 = var_323_2:GetChild(iter_323_4)

					if var_323_3.name == "split_2" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				var_323_2.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_320_1.time_ - 0) / var_323_4)
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				var_323_2.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_323_5 = arg_320_1.actors_["108301"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos108301 = var_323_5.localPosition
				var_323_5.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("108301", 2)

				for iter_323_5 = 0, var_323_5.childCount - 1 do
					local var_323_6 = var_323_5:GetChild(iter_323_5)

					if var_323_6.name == "" or not string.find(var_323_6.name, "split") then
						var_323_6.gameObject:SetActive(true)
					else
						var_323_6.gameObject:SetActive(false)
					end
				end
			end

			local var_323_7 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				var_323_5.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_320_1.time_ - 0) / var_323_7)
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				var_323_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_323_8 = 0
			local var_323_9 = 1.05

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_8 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_10 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(938032078).content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_12 = 42 <= 0 and var_323_9 or var_323_9 * (utf8.len(var_323_10) / 42)

				if (42 <= 0 and var_323_9 or var_323_9 * (utf8.len(var_323_10) / 42)) > 0 and var_323_9 < var_323_12 then
					arg_320_1.talkMaxDuration = var_323_12

					if var_323_12 + var_323_8 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_8
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = math.max(var_323_9, arg_320_1.talkMaxDuration)

			if var_323_8 <= arg_320_1.time_ and arg_320_1.time_ < var_323_8 + var_323_13 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_8) / var_323_13

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_8 + var_323_13 and arg_320_1.time_ < var_323_8 + var_323_13 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
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

		arg_320_1:InitPlayNodeList()
	end,
	Play938032079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 938032079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play938032080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["108301"]) and arg_324_1.var_.actorSpriteComps108301 == nil then
				arg_324_1.var_.actorSpriteComps108301 = arg_324_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_0 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["108301"]) then
				if arg_324_1.var_.actorSpriteComps108301 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								iter_327_1.color = Color.New(Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor1.r, (arg_324_1.time_ - 0) / var_327_0), Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor1.g, (arg_324_1.time_ - 0) / var_327_0), (Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor1.b, (arg_324_1.time_ - 0) / var_327_0)))
							else
								local var_327_1 = Mathf.Lerp(iter_327_1.color.r, 1, (arg_324_1.time_ - 0) / var_327_0)

								iter_327_1.color = Color.New(var_327_1, var_327_1, var_327_1)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["108301"]) and arg_324_1.var_.actorSpriteComps108301 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_327_3 then
						iter_327_3.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_324_1.var_.actorSpriteComps108301 = nil
			end

			local var_327_2 = arg_324_1.actors_["10144"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.actorSpriteComps10144 == nil then
				arg_324_1.var_.actorSpriteComps10144 = var_327_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_3 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_3 and not isNil(var_327_2) then
				if arg_324_1.var_.actorSpriteComps10144 then
					for iter_327_4, iter_327_5 in pairs(arg_324_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_327_5 then
							if arg_324_1.isInRecall_ then
								iter_327_5.color = Color.New(Mathf.Lerp(iter_327_5.color.r, arg_324_1.hightColor2.r, (arg_324_1.time_ - 0) / var_327_3), Mathf.Lerp(iter_327_5.color.g, arg_324_1.hightColor2.g, (arg_324_1.time_ - 0) / var_327_3), (Mathf.Lerp(iter_327_5.color.b, arg_324_1.hightColor2.b, (arg_324_1.time_ - 0) / var_327_3)))
							else
								local var_327_4 = Mathf.Lerp(iter_327_5.color.r, 0.5, (arg_324_1.time_ - 0) / var_327_3)

								iter_327_5.color = Color.New(var_327_4, var_327_4, var_327_4)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_3 and arg_324_1.time_ < 0 + var_327_3 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.actorSpriteComps10144 then
				for iter_327_6, iter_327_7 in pairs(arg_324_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_327_7 then
						iter_327_7.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_324_1.var_.actorSpriteComps10144 = nil
			end

			local var_327_5 = arg_324_1.actors_["108301"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos108301 = var_327_5.localPosition
				var_327_5.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("108301", 2)

				for iter_327_8 = 0, var_327_5.childCount - 1 do
					local var_327_6 = var_327_5:GetChild(iter_327_8)

					if var_327_6.name == "" or not string.find(var_327_6.name, "split") then
						var_327_6.gameObject:SetActive(true)
					else
						var_327_6.gameObject:SetActive(false)
					end
				end
			end

			local var_327_7 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				var_327_5.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_324_1.time_ - 0) / var_327_7)
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				var_327_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_327_8 = 0
			local var_327_9 = 0.4

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_10 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(938032079).content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_12 = 16 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_10) / 16)

				if (16 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_10) / 16)) > 0 and var_327_9 < var_327_12 then
					arg_324_1.talkMaxDuration = var_327_12

					if var_327_12 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_8
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_13 = math.max(var_327_9, arg_324_1.talkMaxDuration)

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_13 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_8) / var_327_13

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_8 + var_327_13 and arg_324_1.time_ < var_327_8 + var_327_13 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
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

		arg_324_1:InitPlayNodeList()
	end,
	Play938032080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 938032080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play938032081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["108301"]) and arg_328_1.var_.actorSpriteComps108301 == nil then
				arg_328_1.var_.actorSpriteComps108301 = arg_328_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["108301"]) then
				if arg_328_1.var_.actorSpriteComps108301 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["108301"]) and arg_328_1.var_.actorSpriteComps108301 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps108301 = nil
			end

			local var_331_2 = 0
			local var_331_3 = 0.175

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_4 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(938032080).content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_6 = 7 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_4) / 7)

				if (7 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_4) / 7)) > 0 and var_331_3 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_7 and arg_328_1.time_ < var_331_2 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play938032081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 938032081
		arg_332_1.duration_ = 9

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play938032082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 2 < arg_332_1.time_ and arg_332_1.time_ <= 2 + arg_335_0 then
				local var_335_0 = arg_332_1.bgs_.ST0119

				arg_332_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_335_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_1 = var_335_0:GetComponent("SpriteRenderer")

				if var_335_1 and var_335_1.sprite then
					local var_335_2 = 2 * (var_335_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_335_0.transform.localScale = Vector3.New(var_335_2 / var_335_1.sprite.bounds.size.y < var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x and var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x or var_335_2 / var_335_1.sprite.bounds.size.y, var_335_2 / var_335_1.sprite.bounds.size.y < var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x and var_335_2 * manager.ui.mainCameraCom_.aspect / var_335_1.sprite.bounds.size.x or var_335_2 / var_335_1.sprite.bounds.size.y, 0)
				end

				for iter_335_0, iter_335_1 in pairs(arg_332_1.bgs_) do
					if iter_335_0 ~= "ST0119" then
						iter_335_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_3 = 4

			if 4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_3 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			if arg_332_1.time_ >= var_335_3 + 0.3 and arg_332_1.time_ < var_335_3 + 0.3 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_4 = 0

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_5 = 2

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_5 then
				local var_335_6 = Color.New(0, 0, 0)

				var_335_6.a = Mathf.Lerp(0, 1, (arg_332_1.time_ - var_335_4) / var_335_5)
				arg_332_1.mask_.color = var_335_6
			end

			if arg_332_1.time_ >= var_335_4 + var_335_5 and arg_332_1.time_ < var_335_4 + var_335_5 + arg_335_0 then
				local var_335_7 = Color.New(0, 0, 0)

				var_335_7.a = 1
				arg_332_1.mask_.color = var_335_7
			end

			local var_335_8 = 2

			if 2 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_9 = 2

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_9 then
				local var_335_10 = Color.New(0, 0, 0)

				var_335_10.a = Mathf.Lerp(1, 0, (arg_332_1.time_ - var_335_8) / var_335_9)
				arg_332_1.mask_.color = var_335_10
			end

			if arg_332_1.time_ >= var_335_8 + var_335_9 and arg_332_1.time_ < var_335_8 + var_335_9 + arg_335_0 then
				local var_335_11 = Color.New(0, 0, 0)

				arg_332_1.mask_.enabled = false
				var_335_11.a = 0
				arg_332_1.mask_.color = var_335_11
			end

			local var_335_12 = arg_332_1.actors_["10144"]

			if 4 < arg_332_1.time_ and arg_332_1.time_ <= 4 + arg_335_0 and not isNil(var_335_12) and arg_332_1.var_.actorSpriteComps10144 == nil then
				arg_332_1.var_.actorSpriteComps10144 = var_335_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_13 = 0.2

			if 4 <= arg_332_1.time_ and arg_332_1.time_ < 4 + var_335_13 and not isNil(var_335_12) then
				if arg_332_1.var_.actorSpriteComps10144 then
					for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_335_3 then
							if arg_332_1.isInRecall_ then
								iter_335_3.color = Color.New(Mathf.Lerp(iter_335_3.color.r, arg_332_1.hightColor1.r, (arg_332_1.time_ - 4) / var_335_13), Mathf.Lerp(iter_335_3.color.g, arg_332_1.hightColor1.g, (arg_332_1.time_ - 4) / var_335_13), (Mathf.Lerp(iter_335_3.color.b, arg_332_1.hightColor1.b, (arg_332_1.time_ - 4) / var_335_13)))
							else
								local var_335_14 = Mathf.Lerp(iter_335_3.color.r, 1, (arg_332_1.time_ - 4) / var_335_13)

								iter_335_3.color = Color.New(var_335_14, var_335_14, var_335_14)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 4 + var_335_13 and arg_332_1.time_ < 4 + var_335_13 + arg_335_0 and not isNil(var_335_12) and arg_332_1.var_.actorSpriteComps10144 then
				for iter_335_4, iter_335_5 in pairs(arg_332_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_335_5 then
						iter_335_5.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_332_1.var_.actorSpriteComps10144 = nil
			end

			local var_335_15 = arg_332_1.actors_["108301"].transform

			if 1.966 < arg_332_1.time_ and arg_332_1.time_ <= 1.966 + arg_335_0 then
				arg_332_1.var_.moveOldPos108301 = var_335_15.localPosition
				var_335_15.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("108301", 7)

				for iter_335_6 = 0, var_335_15.childCount - 1 do
					local var_335_16 = var_335_15:GetChild(iter_335_6)

					if var_335_16.name == "" or not string.find(var_335_16.name, "split") then
						var_335_16.gameObject:SetActive(true)
					else
						var_335_16.gameObject:SetActive(false)
					end
				end
			end

			local var_335_17 = 0.001

			if 1.966 <= arg_332_1.time_ and arg_332_1.time_ < 1.966 + var_335_17 then
				var_335_15.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_332_1.time_ - 1.966) / var_335_17)
			end

			if arg_332_1.time_ >= 1.966 + var_335_17 and arg_332_1.time_ < 1.966 + var_335_17 + arg_335_0 then
				var_335_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_335_18 = arg_332_1.actors_["10144"].transform

			if 4 < arg_332_1.time_ and arg_332_1.time_ <= 4 + arg_335_0 then
				arg_332_1.var_.moveOldPos10144 = var_335_18.localPosition
				var_335_18.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10144", 3)

				for iter_335_7 = 0, var_335_18.childCount - 1 do
					local var_335_19 = var_335_18:GetChild(iter_335_7)

					if var_335_19.name == "" or not string.find(var_335_19.name, "split") then
						var_335_19.gameObject:SetActive(true)
					else
						var_335_19.gameObject:SetActive(false)
					end
				end
			end

			local var_335_20 = 0.001

			if 4 <= arg_332_1.time_ and arg_332_1.time_ < 4 + var_335_20 then
				var_335_18.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_332_1.time_ - 4) / var_335_20)
			end

			if arg_332_1.time_ >= 4 + var_335_20 and arg_332_1.time_ < 4 + var_335_20 + arg_335_0 then
				var_335_18.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_335_21 = arg_332_1.actors_["10144"].transform

			if 1.966 < arg_332_1.time_ and arg_332_1.time_ <= 1.966 + arg_335_0 then
				arg_332_1.var_.moveOldPos10144 = var_335_21.localPosition
				var_335_21.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10144", 7)

				for iter_335_8 = 0, var_335_21.childCount - 1 do
					local var_335_22 = var_335_21:GetChild(iter_335_8)

					if var_335_22.name == "" or not string.find(var_335_22.name, "split") then
						var_335_22.gameObject:SetActive(true)
					else
						var_335_22.gameObject:SetActive(false)
					end
				end
			end

			local var_335_23 = 0.001

			if 1.966 <= arg_332_1.time_ and arg_332_1.time_ < 1.966 + var_335_23 then
				var_335_21.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_332_1.time_ - 1.966) / var_335_23)
			end

			if arg_332_1.time_ >= 1.966 + var_335_23 and arg_332_1.time_ < 1.966 + var_335_23 + arg_335_0 then
				var_335_21.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_24 = 4
			local var_335_25 = 0.725

			if 4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_24 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_26 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_26:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_27 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(938032081).content)

				arg_332_1.text_.text = var_335_27

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_29 = 29 <= 0 and var_335_25 or var_335_25 * (utf8.len(var_335_27) / 29)

				if (29 <= 0 and var_335_25 or var_335_25 * (utf8.len(var_335_27) / 29)) > 0 and var_335_25 < var_335_29 then
					arg_332_1.talkMaxDuration = var_335_29
					var_335_24 = var_335_24 + 0.3

					if var_335_29 + var_335_24 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_29 + var_335_24
					end
				end

				arg_332_1.text_.text = var_335_27
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_30 = var_335_24 + 0.3
			local var_335_31 = math.max(var_335_25, arg_332_1.talkMaxDuration)

			if var_335_24 + 0.3 <= arg_332_1.time_ and arg_332_1.time_ < var_335_30 + var_335_31 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_30) / var_335_31

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_30 + var_335_31 and arg_332_1.time_ < var_335_30 + var_335_31 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_332_1:InitPlayNodeList()
	end,
	Play938032082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938032082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938032083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10144"]) and arg_338_1.var_.actorSpriteComps10144 == nil then
				arg_338_1.var_.actorSpriteComps10144 = arg_338_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10144"]) then
				if arg_338_1.var_.actorSpriteComps10144 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10144"]) and arg_338_1.var_.actorSpriteComps10144 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_338_1.var_.actorSpriteComps10144 = nil
			end

			local var_341_2 = arg_338_1.actors_["10144"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10144 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10144", 7)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_338_1.time_ and arg_338_1.time_ <= 0.3 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_341_6 = 0
			local var_341_7 = 1.025

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_8 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(938032082).content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_10 = 41 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_8) / 41)

				if (41 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_8) / 41)) > 0 and var_341_7 < var_341_10 then
					arg_338_1.talkMaxDuration = var_341_10

					if var_341_10 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_11 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_11 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_11

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_11 and arg_338_1.time_ < var_341_6 + var_341_11 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
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

		arg_338_1:InitPlayNodeList()
	end,
	Play938032083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938032083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play938032084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10144"]) and arg_342_1.var_.actorSpriteComps10144 == nil then
				arg_342_1.var_.actorSpriteComps10144 = arg_342_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10144"]) then
				if arg_342_1.var_.actorSpriteComps10144 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 1, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10144"]) and arg_342_1.var_.actorSpriteComps10144 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_342_1.var_.actorSpriteComps10144 = nil
			end

			local var_345_2 = arg_342_1.actors_["10144"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10144 = var_345_2.localPosition
				var_345_2.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10144", 3)

				for iter_345_4 = 0, var_345_2.childCount - 1 do
					local var_345_3 = var_345_2:GetChild(iter_345_4)

					if var_345_3.name == "split_7" or not string.find(var_345_3.name, "split") then
						var_345_3.gameObject:SetActive(true)
					else
						var_345_3.gameObject:SetActive(false)
					end
				end
			end

			local var_345_4 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				var_345_2.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_342_1.time_ - 0) / var_345_4)
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				var_345_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_345_5 = 0
			local var_345_6 = 1.1

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_7 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(938032083).content)

				arg_342_1.text_.text = var_345_7

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 44 <= 0 and var_345_6 or var_345_6 * (utf8.len(var_345_7) / 44)

				if (44 <= 0 and var_345_6 or var_345_6 * (utf8.len(var_345_7) / 44)) > 0 and var_345_6 < var_345_9 then
					arg_342_1.talkMaxDuration = var_345_9

					if var_345_9 + var_345_5 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_5
					end
				end

				arg_342_1.text_.text = var_345_7
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_6, arg_342_1.talkMaxDuration)

			if var_345_5 <= arg_342_1.time_ and arg_342_1.time_ < var_345_5 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_5) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_5 + var_345_10 and arg_342_1.time_ < var_345_5 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play938032084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 938032084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play938032085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10144 = arg_346_1.actors_["10144"].transform.localPosition
				arg_346_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10144", 3)

				for iter_349_0 = 0, arg_346_1.actors_["10144"].transform.childCount - 1 do
					local var_349_0 = arg_346_1.actors_["10144"].transform:GetChild(iter_349_0)

					if var_349_0.name == "" then
						var_349_0:SetAsLastSibling()
						var_349_0.gameObject:SetActive(true)

						arg_346_1.var_.actorSpriteSplit10144 = var_349_0.gameObject:GetComponent(typeof(Image))

						arg_346_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_349_1 = 0.5

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_1 then
				arg_346_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_346_1.time_ - 0) / var_349_1)

				if arg_346_1.var_.actorSpriteSplit10144 ~= nil then
					arg_346_1.var_.actorSpriteSplit10144:SetAlpha((arg_346_1.time_ - 0) / var_349_1)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_1 and arg_346_1.time_ < 0 + var_349_1 + arg_349_0 then
				arg_346_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_346_1.var_.actorSpriteSplit10144 ~= nil then
					arg_346_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_349_2 = 0
			local var_349_3 = 0.5

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_4 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(938032084).content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_6 = 20 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_4) / 20)

				if (20 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_4) / 20)) > 0 and var_349_3 < var_349_6 then
					arg_346_1.talkMaxDuration = var_349_6

					if var_349_6 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_6 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_7 and arg_346_1.time_ < var_349_2 + var_349_7 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
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

		arg_346_1:InitPlayNodeList()
	end,
	Play938032085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 938032085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play938032086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["104902"]) and arg_350_1.var_.actorSpriteComps104902 == nil then
				arg_350_1.var_.actorSpriteComps104902 = arg_350_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["104902"]) then
				if arg_350_1.var_.actorSpriteComps104902 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["104902"]) and arg_350_1.var_.actorSpriteComps104902 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps104902 = nil
			end

			local var_353_2 = arg_350_1.actors_["10144"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps10144 == nil then
				arg_350_1.var_.actorSpriteComps10144 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps10144 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								iter_353_5.color = Color.New(Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_5.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_5.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps10144 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_353_7 then
						iter_353_7.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps10144 = nil
			end

			local var_353_5 = arg_350_1.actors_["104902"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos104902 = var_353_5.localPosition
				var_353_5.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("104902", 4)

				for iter_353_8 = 0, var_353_5.childCount - 1 do
					local var_353_6 = var_353_5:GetChild(iter_353_8)

					if var_353_6.name == "split_2" or not string.find(var_353_6.name, "split") then
						var_353_6.gameObject:SetActive(true)
					else
						var_353_6.gameObject:SetActive(false)
					end
				end
			end

			local var_353_7 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				var_353_5.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_350_1.time_ - 0) / var_353_7)
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				var_353_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_353_8 = arg_350_1.actors_["10144"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10144 = var_353_8.localPosition
				var_353_8.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10144", 2)

				for iter_353_9 = 0, var_353_8.childCount - 1 do
					local var_353_9 = var_353_8:GetChild(iter_353_9)

					if var_353_9.name == "" or not string.find(var_353_9.name, "split") then
						var_353_9.gameObject:SetActive(true)
					else
						var_353_9.gameObject:SetActive(false)
					end
				end
			end

			local var_353_10 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_10 then
				var_353_8.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_350_1.time_ - 0) / var_353_10)
			end

			if arg_350_1.time_ >= 0 + var_353_10 and arg_350_1.time_ < 0 + var_353_10 + arg_353_0 then
				var_353_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_353_11 = 0
			local var_353_12 = 0.325

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_11 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_13 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(938032085).content)

				arg_350_1.text_.text = var_353_13

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_15 = 13 <= 0 and var_353_12 or var_353_12 * (utf8.len(var_353_13) / 13)

				if (13 <= 0 and var_353_12 or var_353_12 * (utf8.len(var_353_13) / 13)) > 0 and var_353_12 < var_353_15 then
					arg_350_1.talkMaxDuration = var_353_15

					if var_353_15 + var_353_11 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_15 + var_353_11
					end
				end

				arg_350_1.text_.text = var_353_13
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_12, arg_350_1.talkMaxDuration)

			if var_353_11 <= arg_350_1.time_ and arg_350_1.time_ < var_353_11 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_11) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_11 + var_353_16 and arg_350_1.time_ < var_353_11 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
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
				actorName = "10144",
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
	Play938032086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 938032086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play938032087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["104902"]) and arg_354_1.var_.actorSpriteComps104902 == nil then
				arg_354_1.var_.actorSpriteComps104902 = arg_354_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["104902"]) then
				if arg_354_1.var_.actorSpriteComps104902 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								iter_357_1.color = Color.New(Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, (arg_354_1.time_ - 0) / var_357_0), Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, (arg_354_1.time_ - 0) / var_357_0), (Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, (arg_354_1.time_ - 0) / var_357_0)))
							else
								local var_357_1 = Mathf.Lerp(iter_357_1.color.r, 0.5, (arg_354_1.time_ - 0) / var_357_0)

								iter_357_1.color = Color.New(var_357_1, var_357_1, var_357_1)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["104902"]) and arg_354_1.var_.actorSpriteComps104902 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_354_1.var_.actorSpriteComps104902 = nil
			end

			local var_357_2 = arg_354_1.actors_["104902"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos104902 = var_357_2.localPosition
				var_357_2.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("104902", 7)

				for iter_357_4 = 0, var_357_2.childCount - 1 do
					local var_357_3 = var_357_2:GetChild(iter_357_4)

					if var_357_3.name == "" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_354_1.time_ - 0) / var_357_4)
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_357_5 = arg_354_1.actors_["10144"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10144 = var_357_5.localPosition
				var_357_5.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10144", 7)

				for iter_357_5 = 0, var_357_5.childCount - 1 do
					local var_357_6 = var_357_5:GetChild(iter_357_5)

					if var_357_6.name == "" or not string.find(var_357_6.name, "split") then
						var_357_6.gameObject:SetActive(true)
					else
						var_357_6.gameObject:SetActive(false)
					end
				end
			end

			local var_357_7 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				var_357_5.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_354_1.time_ - 0) / var_357_7)
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				var_357_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_357_8 = 0
			local var_357_9 = 0.525

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_10 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(938032086).content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_12 = 21 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_10) / 21)

				if (21 <= 0 and var_357_9 or var_357_9 * (utf8.len(var_357_10) / 21)) > 0 and var_357_9 < var_357_12 then
					arg_354_1.talkMaxDuration = var_357_12

					if var_357_12 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_13 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_13 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_13

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_13 and arg_354_1.time_ < var_357_8 + var_357_13 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play938032087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 938032087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play938032088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["108301"]) and arg_358_1.var_.actorSpriteComps108301 == nil then
				arg_358_1.var_.actorSpriteComps108301 = arg_358_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["108301"]) then
				if arg_358_1.var_.actorSpriteComps108301 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["108301"]) and arg_358_1.var_.actorSpriteComps108301 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps108301 = nil
			end

			local var_361_2 = arg_358_1.actors_["108301"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos108301 = var_361_2.localPosition
				var_361_2.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("108301", 2)

				for iter_361_4 = 0, var_361_2.childCount - 1 do
					local var_361_3 = var_361_2:GetChild(iter_361_4)

					if var_361_3.name == "split_5" or not string.find(var_361_3.name, "split") then
						var_361_3.gameObject:SetActive(true)
					else
						var_361_3.gameObject:SetActive(false)
					end
				end
			end

			local var_361_4 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				var_361_2.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_358_1.time_ - 0) / var_361_4)
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				var_361_2.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_361_5 = 0
			local var_361_6 = 1.225

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(938032087).content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 49 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 49)

				if (49 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 49)) > 0 and var_361_6 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_10 and arg_358_1.time_ < var_361_5 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
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

		arg_358_1:InitPlayNodeList()
	end,
	Play938032088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 938032088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play938032089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["128404"]) and arg_362_1.var_.actorSpriteComps128404 == nil then
				arg_362_1.var_.actorSpriteComps128404 = arg_362_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["128404"]) then
				if arg_362_1.var_.actorSpriteComps128404 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["128404"]) and arg_362_1.var_.actorSpriteComps128404 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps128404 = nil
			end

			local var_365_2 = arg_362_1.actors_["108301"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps108301 == nil then
				arg_362_1.var_.actorSpriteComps108301 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps108301 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps108301 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps108301 = nil
			end

			local var_365_5 = arg_362_1.actors_["128404"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos128404 = var_365_5.localPosition
				var_365_5.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("128404", 4)

				for iter_365_8 = 0, var_365_5.childCount - 1 do
					local var_365_6 = var_365_5:GetChild(iter_365_8)

					if var_365_6.name == "split_5" or not string.find(var_365_6.name, "split") then
						var_365_6.gameObject:SetActive(true)
					else
						var_365_6.gameObject:SetActive(false)
					end
				end
			end

			local var_365_7 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				var_365_5.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_362_1.time_ - 0) / var_365_7)
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				var_365_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_365_8 = 0
			local var_365_9 = 1.15

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(938032088).content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_12 = 46 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_10) / 46)

				if (46 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_10) / 46)) > 0 and var_365_9 < var_365_12 then
					arg_362_1.talkMaxDuration = var_365_12

					if var_365_12 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_12 + var_365_8
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_9, arg_362_1.talkMaxDuration)

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_8) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_8 + var_365_13 and arg_362_1.time_ < var_365_8 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play938032089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 938032089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play938032090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["106603"]) and arg_366_1.var_.actorSpriteComps106603 == nil then
				arg_366_1.var_.actorSpriteComps106603 = arg_366_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["106603"]) then
				if arg_366_1.var_.actorSpriteComps106603 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["106603"]) and arg_366_1.var_.actorSpriteComps106603 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps106603 = nil
			end

			local var_369_2 = arg_366_1.actors_["128404"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps128404 == nil then
				arg_366_1.var_.actorSpriteComps128404 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps128404 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps128404 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_369_7 then
						iter_369_7.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps128404 = nil
			end

			local var_369_5 = arg_366_1.actors_["106603"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos106603 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("106603", 2)

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
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_369_8 = arg_366_1.actors_["108301"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos108301 = var_369_8.localPosition
				var_369_8.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("108301", 7)

				for iter_369_9 = 0, var_369_8.childCount - 1 do
					local var_369_9 = var_369_8:GetChild(iter_369_9)

					if var_369_9.name == "" or not string.find(var_369_9.name, "split") then
						var_369_9.gameObject:SetActive(true)
					else
						var_369_9.gameObject:SetActive(false)
					end
				end
			end

			local var_369_10 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_10 then
				var_369_8.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_366_1.time_ - 0) / var_369_10)
			end

			if arg_366_1.time_ >= 0 + var_369_10 and arg_366_1.time_ < 0 + var_369_10 + arg_369_0 then
				var_369_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_11 = 0
			local var_369_12 = 0.15

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_11 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_13 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(938032089).content)

				arg_366_1.text_.text = var_369_13

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_15 = 6 <= 0 and var_369_12 or var_369_12 * (utf8.len(var_369_13) / 6)

				if (6 <= 0 and var_369_12 or var_369_12 * (utf8.len(var_369_13) / 6)) > 0 and var_369_12 < var_369_15 then
					arg_366_1.talkMaxDuration = var_369_15

					if var_369_15 + var_369_11 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_15 + var_369_11
					end
				end

				arg_366_1.text_.text = var_369_13
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_12, arg_366_1.talkMaxDuration)

			if var_369_11 <= arg_366_1.time_ and arg_366_1.time_ < var_369_11 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_11) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_11 + var_369_16 and arg_366_1.time_ < var_369_11 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
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

		arg_366_1:InitPlayNodeList()
	end,
	Play938032090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 938032090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play938032091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["128404"]) and arg_370_1.var_.actorSpriteComps128404 == nil then
				arg_370_1.var_.actorSpriteComps128404 = arg_370_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["128404"]) then
				if arg_370_1.var_.actorSpriteComps128404 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["128404"]) and arg_370_1.var_.actorSpriteComps128404 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps128404 = nil
			end

			local var_373_2 = arg_370_1.actors_["106603"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps106603 == nil then
				arg_370_1.var_.actorSpriteComps106603 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps106603 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps106603 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps106603 = nil
			end

			local var_373_5 = arg_370_1.actors_["128404"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos128404 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("128404", 4)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "split_1" then
						var_373_6:SetAsLastSibling()
						var_373_6.gameObject:SetActive(true)

						arg_370_1.var_.actorSpriteSplit128404 = var_373_6.gameObject:GetComponent(typeof(Image))

						arg_370_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_373_7 = 0.5

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_370_1.time_ - 0) / var_373_7)

				if arg_370_1.var_.actorSpriteSplit128404 ~= nil then
					arg_370_1.var_.actorSpriteSplit128404:SetAlpha((arg_370_1.time_ - 0) / var_373_7)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_370_1.var_.actorSpriteSplit128404 ~= nil then
					arg_370_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_373_8 = 0
			local var_373_9 = 0.6

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_8 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_10 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(938032090).content)

				arg_370_1.text_.text = var_373_10

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_12 = 24 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_10) / 24)

				if (24 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_10) / 24)) > 0 and var_373_9 < var_373_12 then
					arg_370_1.talkMaxDuration = var_373_12

					if var_373_12 + var_373_8 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_12 + var_373_8
					end
				end

				arg_370_1.text_.text = var_373_10
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_13 = math.max(var_373_9, arg_370_1.talkMaxDuration)

			if var_373_8 <= arg_370_1.time_ and arg_370_1.time_ < var_373_8 + var_373_13 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_8) / var_373_13

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_8 + var_373_13 and arg_370_1.time_ < var_373_8 + var_373_13 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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

		arg_370_1:InitPlayNodeList()
	end,
	Play938032091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 938032091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play938032092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["104902"]) and arg_374_1.var_.actorSpriteComps104902 == nil then
				arg_374_1.var_.actorSpriteComps104902 = arg_374_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["104902"]) then
				if arg_374_1.var_.actorSpriteComps104902 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["104902"]) and arg_374_1.var_.actorSpriteComps104902 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps104902 = nil
			end

			local var_377_2 = arg_374_1.actors_["128404"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps128404 == nil then
				arg_374_1.var_.actorSpriteComps128404 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps128404 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps128404 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps128404 = nil
			end

			local var_377_5 = arg_374_1.actors_["104902"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos104902 = var_377_5.localPosition
				var_377_5.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("104902", 2)

				for iter_377_8 = 0, var_377_5.childCount - 1 do
					local var_377_6 = var_377_5:GetChild(iter_377_8)

					if var_377_6.name == "split_2" or not string.find(var_377_6.name, "split") then
						var_377_6.gameObject:SetActive(true)
					else
						var_377_6.gameObject:SetActive(false)
					end
				end
			end

			local var_377_7 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				var_377_5.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_374_1.time_ - 0) / var_377_7)
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				var_377_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_377_8 = arg_374_1.actors_["106603"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos106603 = var_377_8.localPosition
				var_377_8.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("106603", 7)

				for iter_377_9 = 0, var_377_8.childCount - 1 do
					local var_377_9 = var_377_8:GetChild(iter_377_9)

					if var_377_9.name == "split_1" or not string.find(var_377_9.name, "split") then
						var_377_9.gameObject:SetActive(true)
					else
						var_377_9.gameObject:SetActive(false)
					end
				end
			end

			local var_377_10 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_10 then
				var_377_8.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_374_1.time_ - 0) / var_377_10)
			end

			if arg_374_1.time_ >= 0 + var_377_10 and arg_374_1.time_ < 0 + var_377_10 + arg_377_0 then
				var_377_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_11 = 0
			local var_377_12 = 0.5

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_11 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_13 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(938032091).content)

				arg_374_1.text_.text = var_377_13

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_15 = 20 <= 0 and var_377_12 or var_377_12 * (utf8.len(var_377_13) / 20)

				if (20 <= 0 and var_377_12 or var_377_12 * (utf8.len(var_377_13) / 20)) > 0 and var_377_12 < var_377_15 then
					arg_374_1.talkMaxDuration = var_377_15

					if var_377_15 + var_377_11 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_15 + var_377_11
					end
				end

				arg_374_1.text_.text = var_377_13
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_12, arg_374_1.talkMaxDuration)

			if var_377_11 <= arg_374_1.time_ and arg_374_1.time_ < var_377_11 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_11) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_11 + var_377_16 and arg_374_1.time_ < var_377_11 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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

		arg_374_1:InitPlayNodeList()
	end,
	Play938032092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 938032092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play938032093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["104902"]) and arg_378_1.var_.actorSpriteComps104902 == nil then
				arg_378_1.var_.actorSpriteComps104902 = arg_378_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_0 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["104902"]) then
				if arg_378_1.var_.actorSpriteComps104902 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								iter_381_1.color = Color.New(Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor2.r, (arg_378_1.time_ - 0) / var_381_0), Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor2.g, (arg_378_1.time_ - 0) / var_381_0), (Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor2.b, (arg_378_1.time_ - 0) / var_381_0)))
							else
								local var_381_1 = Mathf.Lerp(iter_381_1.color.r, 0.5, (arg_378_1.time_ - 0) / var_381_0)

								iter_381_1.color = Color.New(var_381_1, var_381_1, var_381_1)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["104902"]) and arg_378_1.var_.actorSpriteComps104902 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_381_3 then
						iter_381_3.color = arg_378_1.isInRecall_ and (arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_378_1.var_.actorSpriteComps104902 = nil
			end

			local var_381_2 = 0
			local var_381_3 = 0.375

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_4 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(938032092).content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_6 = 15 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_4) / 15)

				if (15 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_4) / 15)) > 0 and var_381_3 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_7 and arg_378_1.time_ < var_381_2 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play938032093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 938032093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play938032094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["108301"]) and arg_382_1.var_.actorSpriteComps108301 == nil then
				arg_382_1.var_.actorSpriteComps108301 = arg_382_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["108301"]) then
				if arg_382_1.var_.actorSpriteComps108301 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["108301"]) and arg_382_1.var_.actorSpriteComps108301 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_385_3 then
						iter_385_3.color = arg_382_1.isInRecall_ and (arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_382_1.var_.actorSpriteComps108301 = nil
			end

			local var_385_2 = arg_382_1.actors_["108301"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos108301 = var_385_2.localPosition
				var_385_2.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("108301", 4)

				for iter_385_4 = 0, var_385_2.childCount - 1 do
					local var_385_3 = var_385_2:GetChild(iter_385_4)

					if var_385_3.name == "split_3" or not string.find(var_385_3.name, "split") then
						var_385_3.gameObject:SetActive(true)
					else
						var_385_3.gameObject:SetActive(false)
					end
				end
			end

			local var_385_4 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				var_385_2.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_382_1.time_ - 0) / var_385_4)
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				var_385_2.localPosition = Vector3.New(460, -360, -195)
			end

			local var_385_5 = arg_382_1.actors_["128404"].transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos128404 = var_385_5.localPosition
				var_385_5.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("128404", 7)

				for iter_385_5 = 0, var_385_5.childCount - 1 do
					local var_385_6 = var_385_5:GetChild(iter_385_5)

					if var_385_6.name == "" or not string.find(var_385_6.name, "split") then
						var_385_6.gameObject:SetActive(true)
					else
						var_385_6.gameObject:SetActive(false)
					end
				end
			end

			local var_385_7 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				var_385_5.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_382_1.time_ - 0) / var_385_7)
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				var_385_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_385_8 = 0
			local var_385_9 = 0.35

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

				local var_385_10 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(938032093).content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_12 = 14 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_10) / 14)

				if (14 <= 0 and var_385_9 or var_385_9 * (utf8.len(var_385_10) / 14)) > 0 and var_385_9 < var_385_12 then
					arg_382_1.talkMaxDuration = var_385_12

					if var_385_12 + var_385_8 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_12 + var_385_8
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_13 = math.max(var_385_9, arg_382_1.talkMaxDuration)

			if var_385_8 <= arg_382_1.time_ and arg_382_1.time_ < var_385_8 + var_385_13 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_8) / var_385_13

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_8 + var_385_13 and arg_382_1.time_ < var_385_8 + var_385_13 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
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
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play938032094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 938032094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play938032095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["10144"]) and arg_386_1.var_.actorSpriteComps10144 == nil then
				arg_386_1.var_.actorSpriteComps10144 = arg_386_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_0 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["10144"]) then
				if arg_386_1.var_.actorSpriteComps10144 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								iter_389_1.color = Color.New(Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor1.r, (arg_386_1.time_ - 0) / var_389_0), Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor1.g, (arg_386_1.time_ - 0) / var_389_0), (Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor1.b, (arg_386_1.time_ - 0) / var_389_0)))
							else
								local var_389_1 = Mathf.Lerp(iter_389_1.color.r, 1, (arg_386_1.time_ - 0) / var_389_0)

								iter_389_1.color = Color.New(var_389_1, var_389_1, var_389_1)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["10144"]) and arg_386_1.var_.actorSpriteComps10144 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_389_3 then
						iter_389_3.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_386_1.var_.actorSpriteComps10144 = nil
			end

			local var_389_2 = arg_386_1.actors_["108301"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps108301 == nil then
				arg_386_1.var_.actorSpriteComps108301 = var_389_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_3 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_3 and not isNil(var_389_2) then
				if arg_386_1.var_.actorSpriteComps108301 then
					for iter_389_4, iter_389_5 in pairs(arg_386_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_389_5 then
							if arg_386_1.isInRecall_ then
								iter_389_5.color = Color.New(Mathf.Lerp(iter_389_5.color.r, arg_386_1.hightColor2.r, (arg_386_1.time_ - 0) / var_389_3), Mathf.Lerp(iter_389_5.color.g, arg_386_1.hightColor2.g, (arg_386_1.time_ - 0) / var_389_3), (Mathf.Lerp(iter_389_5.color.b, arg_386_1.hightColor2.b, (arg_386_1.time_ - 0) / var_389_3)))
							else
								local var_389_4 = Mathf.Lerp(iter_389_5.color.r, 0.5, (arg_386_1.time_ - 0) / var_389_3)

								iter_389_5.color = Color.New(var_389_4, var_389_4, var_389_4)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= 0 + var_389_3 and arg_386_1.time_ < 0 + var_389_3 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.actorSpriteComps108301 then
				for iter_389_6, iter_389_7 in pairs(arg_386_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_389_7 then
						iter_389_7.color = arg_386_1.isInRecall_ and (arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_386_1.var_.actorSpriteComps108301 = nil
			end

			local var_389_5 = arg_386_1.actors_["10144"].transform

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos10144 = var_389_5.localPosition
				var_389_5.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("10144", 4)

				for iter_389_8 = 0, var_389_5.childCount - 1 do
					local var_389_6 = var_389_5:GetChild(iter_389_8)

					if var_389_6.name == "split_6" or not string.find(var_389_6.name, "split") then
						var_389_6.gameObject:SetActive(true)
					else
						var_389_6.gameObject:SetActive(false)
					end
				end
			end

			local var_389_7 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				var_389_5.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_386_1.time_ - 0) / var_389_7)
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				var_389_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_389_8 = arg_386_1.actors_["108301"].transform

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos108301 = var_389_8.localPosition
				var_389_8.localScale = Vector3.New(1, 1, 1)

				arg_386_1:CheckSpriteTmpPos("108301", 7)

				for iter_389_9 = 0, var_389_8.childCount - 1 do
					local var_389_9 = var_389_8:GetChild(iter_389_9)

					if var_389_9.name == "" or not string.find(var_389_9.name, "split") then
						var_389_9.gameObject:SetActive(true)
					else
						var_389_9.gameObject:SetActive(false)
					end
				end
			end

			local var_389_10 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_10 then
				var_389_8.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_386_1.time_ - 0) / var_389_10)
			end

			if arg_386_1.time_ >= 0 + var_389_10 and arg_386_1.time_ < 0 + var_389_10 + arg_389_0 then
				var_389_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_389_11 = 0
			local var_389_12 = 0.6

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_11 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_13 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(938032094).content)

				arg_386_1.text_.text = var_389_13

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_15 = 24 <= 0 and var_389_12 or var_389_12 * (utf8.len(var_389_13) / 24)

				if (24 <= 0 and var_389_12 or var_389_12 * (utf8.len(var_389_13) / 24)) > 0 and var_389_12 < var_389_15 then
					arg_386_1.talkMaxDuration = var_389_15

					if var_389_15 + var_389_11 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_15 + var_389_11
					end
				end

				arg_386_1.text_.text = var_389_13
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_16 = math.max(var_389_12, arg_386_1.talkMaxDuration)

			if var_389_11 <= arg_386_1.time_ and arg_386_1.time_ < var_389_11 + var_389_16 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_11) / var_389_16

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_11 + var_389_16 and arg_386_1.time_ < var_389_11 + var_389_16 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
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

		arg_386_1:InitPlayNodeList()
	end,
	Play938032095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 938032095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play938032096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["104902"]) and arg_390_1.var_.actorSpriteComps104902 == nil then
				arg_390_1.var_.actorSpriteComps104902 = arg_390_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_0 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["104902"]) then
				if arg_390_1.var_.actorSpriteComps104902 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["104902"]) and arg_390_1.var_.actorSpriteComps104902 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_393_3 then
						iter_393_3.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_390_1.var_.actorSpriteComps104902 = nil
			end

			local var_393_2 = arg_390_1.actors_["10144"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps10144 == nil then
				arg_390_1.var_.actorSpriteComps10144 = var_393_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_3 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.actorSpriteComps10144 then
					for iter_393_4, iter_393_5 in pairs(arg_390_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_393_5 then
							if arg_390_1.isInRecall_ then
								iter_393_5.color = Color.New(Mathf.Lerp(iter_393_5.color.r, arg_390_1.hightColor2.r, (arg_390_1.time_ - 0) / var_393_3), Mathf.Lerp(iter_393_5.color.g, arg_390_1.hightColor2.g, (arg_390_1.time_ - 0) / var_393_3), (Mathf.Lerp(iter_393_5.color.b, arg_390_1.hightColor2.b, (arg_390_1.time_ - 0) / var_393_3)))
							else
								local var_393_4 = Mathf.Lerp(iter_393_5.color.r, 0.5, (arg_390_1.time_ - 0) / var_393_3)

								iter_393_5.color = Color.New(var_393_4, var_393_4, var_393_4)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.actorSpriteComps10144 then
				for iter_393_6, iter_393_7 in pairs(arg_390_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_393_7 then
						iter_393_7.color = arg_390_1.isInRecall_ and (arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_390_1.var_.actorSpriteComps10144 = nil
			end

			local var_393_5 = arg_390_1.actors_["104902"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos104902 = var_393_5.localPosition
				var_393_5.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("104902", 2)

				for iter_393_8 = 0, var_393_5.childCount - 1 do
					local var_393_6 = var_393_5:GetChild(iter_393_8)

					if var_393_6.name == "split_2" or not string.find(var_393_6.name, "split") then
						var_393_6.gameObject:SetActive(true)
					else
						var_393_6.gameObject:SetActive(false)
					end
				end
			end

			local var_393_7 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				var_393_5.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_390_1.time_ - 0) / var_393_7)
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				var_393_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_393_8 = 0
			local var_393_9 = 0.8

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_10 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(938032095).content)

				arg_390_1.text_.text = var_393_10

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_12 = 32 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_10) / 32)

				if (32 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_10) / 32)) > 0 and var_393_9 < var_393_12 then
					arg_390_1.talkMaxDuration = var_393_12

					if var_393_12 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_12 + var_393_8
					end
				end

				arg_390_1.text_.text = var_393_10
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_13 = math.max(var_393_9, arg_390_1.talkMaxDuration)

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_13 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_8) / var_393_13

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_8 + var_393_13 and arg_390_1.time_ < var_393_8 + var_393_13 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
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

		arg_390_1:InitPlayNodeList()
	end,
	Play938032096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 938032096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play938032097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["10144"]) and arg_394_1.var_.actorSpriteComps10144 == nil then
				arg_394_1.var_.actorSpriteComps10144 = arg_394_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_0 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["10144"]) then
				if arg_394_1.var_.actorSpriteComps10144 then
					for iter_397_0, iter_397_1 in pairs(arg_394_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_397_1 then
							if arg_394_1.isInRecall_ then
								iter_397_1.color = Color.New(Mathf.Lerp(iter_397_1.color.r, arg_394_1.hightColor1.r, (arg_394_1.time_ - 0) / var_397_0), Mathf.Lerp(iter_397_1.color.g, arg_394_1.hightColor1.g, (arg_394_1.time_ - 0) / var_397_0), (Mathf.Lerp(iter_397_1.color.b, arg_394_1.hightColor1.b, (arg_394_1.time_ - 0) / var_397_0)))
							else
								local var_397_1 = Mathf.Lerp(iter_397_1.color.r, 1, (arg_394_1.time_ - 0) / var_397_0)

								iter_397_1.color = Color.New(var_397_1, var_397_1, var_397_1)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["10144"]) and arg_394_1.var_.actorSpriteComps10144 then
				for iter_397_2, iter_397_3 in pairs(arg_394_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_397_3 then
						iter_397_3.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_394_1.var_.actorSpriteComps10144 = nil
			end

			local var_397_2 = arg_394_1.actors_["104902"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps104902 == nil then
				arg_394_1.var_.actorSpriteComps104902 = var_397_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_397_3 = 0.2

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.actorSpriteComps104902 then
					for iter_397_4, iter_397_5 in pairs(arg_394_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_397_5 then
							if arg_394_1.isInRecall_ then
								iter_397_5.color = Color.New(Mathf.Lerp(iter_397_5.color.r, arg_394_1.hightColor2.r, (arg_394_1.time_ - 0) / var_397_3), Mathf.Lerp(iter_397_5.color.g, arg_394_1.hightColor2.g, (arg_394_1.time_ - 0) / var_397_3), (Mathf.Lerp(iter_397_5.color.b, arg_394_1.hightColor2.b, (arg_394_1.time_ - 0) / var_397_3)))
							else
								local var_397_4 = Mathf.Lerp(iter_397_5.color.r, 0.5, (arg_394_1.time_ - 0) / var_397_3)

								iter_397_5.color = Color.New(var_397_4, var_397_4, var_397_4)
							end
						end
					end
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.actorSpriteComps104902 then
				for iter_397_6, iter_397_7 in pairs(arg_394_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_397_7 then
						iter_397_7.color = arg_394_1.isInRecall_ and (arg_394_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_394_1.var_.actorSpriteComps104902 = nil
			end

			local var_397_5 = arg_394_1.actors_["10144"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10144 = var_397_5.localPosition
				var_397_5.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10144", 4)

				for iter_397_8 = 0, var_397_5.childCount - 1 do
					local var_397_6 = var_397_5:GetChild(iter_397_8)

					if var_397_6.name == "split_2" then
						var_397_6:SetAsLastSibling()
						var_397_6.gameObject:SetActive(true)

						arg_394_1.var_.actorSpriteSplit10144 = var_397_6.gameObject:GetComponent(typeof(Image))

						arg_394_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_397_7 = 0.5

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				var_397_5.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_394_1.time_ - 0) / var_397_7)

				if arg_394_1.var_.actorSpriteSplit10144 ~= nil then
					arg_394_1.var_.actorSpriteSplit10144:SetAlpha((arg_394_1.time_ - 0) / var_397_7)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				var_397_5.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_394_1.var_.actorSpriteSplit10144 ~= nil then
					arg_394_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_397_8 = 0
			local var_397_9 = 0.625

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_8 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_10 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(938032096).content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_12 = 25 <= 0 and var_397_9 or var_397_9 * (utf8.len(var_397_10) / 25)

				if (25 <= 0 and var_397_9 or var_397_9 * (utf8.len(var_397_10) / 25)) > 0 and var_397_9 < var_397_12 then
					arg_394_1.talkMaxDuration = var_397_12

					if var_397_12 + var_397_8 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_12 + var_397_8
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_13 = math.max(var_397_9, arg_394_1.talkMaxDuration)

			if var_397_8 <= arg_394_1.time_ and arg_394_1.time_ < var_397_8 + var_397_13 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_8) / var_397_13

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_8 + var_397_13 and arg_394_1.time_ < var_397_8 + var_397_13 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
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

		arg_394_1:InitPlayNodeList()
	end,
	Play938032097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 938032097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play938032098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.475

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(938032097).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 19 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 19)

				if (19 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 19)) > 0 and var_401_0 < var_401_3 then
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
	Play938032098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 938032098
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play938032099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos10144 = arg_402_1.actors_["10144"].transform.localPosition
				arg_402_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10144", 4)

				for iter_405_0 = 0, arg_402_1.actors_["10144"].transform.childCount - 1 do
					local var_405_0 = arg_402_1.actors_["10144"].transform:GetChild(iter_405_0)

					if var_405_0.name == "split_1" then
						var_405_0:SetAsLastSibling()
						var_405_0.gameObject:SetActive(true)

						arg_402_1.var_.actorSpriteSplit10144 = var_405_0.gameObject:GetComponent(typeof(Image))

						arg_402_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_405_1 = 0.5

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_1 then
				arg_402_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_402_1.time_ - 0) / var_405_1)

				if arg_402_1.var_.actorSpriteSplit10144 ~= nil then
					arg_402_1.var_.actorSpriteSplit10144:SetAlpha((arg_402_1.time_ - 0) / var_405_1)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_1 and arg_402_1.time_ < 0 + var_405_1 + arg_405_0 then
				arg_402_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_402_1.var_.actorSpriteSplit10144 ~= nil then
					arg_402_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_405_2 = 0
			local var_405_3 = 0.5

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_4 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(938032098).content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_6 = 20 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_4) / 20)

				if (20 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_4) / 20)) > 0 and var_405_3 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_7 and arg_402_1.time_ < var_405_2 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
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

		arg_402_1:InitPlayNodeList()
	end,
	Play938032099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 938032099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play938032100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["10144"]) and arg_406_1.var_.actorSpriteComps10144 == nil then
				arg_406_1.var_.actorSpriteComps10144 = arg_406_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_0 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["10144"]) then
				if arg_406_1.var_.actorSpriteComps10144 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								iter_409_1.color = Color.New(Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor2.r, (arg_406_1.time_ - 0) / var_409_0), Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor2.g, (arg_406_1.time_ - 0) / var_409_0), (Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor2.b, (arg_406_1.time_ - 0) / var_409_0)))
							else
								local var_409_1 = Mathf.Lerp(iter_409_1.color.r, 0.5, (arg_406_1.time_ - 0) / var_409_0)

								iter_409_1.color = Color.New(var_409_1, var_409_1, var_409_1)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["10144"]) and arg_406_1.var_.actorSpriteComps10144 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_409_3 then
						iter_409_3.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_406_1.var_.actorSpriteComps10144 = nil
			end

			local var_409_2 = arg_406_1.actors_["10144"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos10144 = var_409_2.localPosition
				var_409_2.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10144", 7)

				for iter_409_4 = 0, var_409_2.childCount - 1 do
					local var_409_3 = var_409_2:GetChild(iter_409_4)

					if var_409_3.name == "" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				var_409_2.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_406_1.time_ - 0) / var_409_4)
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				var_409_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_409_5 = arg_406_1.actors_["104902"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos104902 = var_409_5.localPosition
				var_409_5.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("104902", 7)

				for iter_409_5 = 0, var_409_5.childCount - 1 do
					local var_409_6 = var_409_5:GetChild(iter_409_5)

					if var_409_6.name == "" or not string.find(var_409_6.name, "split") then
						var_409_6.gameObject:SetActive(true)
					else
						var_409_6.gameObject:SetActive(false)
					end
				end
			end

			local var_409_7 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				var_409_5.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_406_1.time_ - 0) / var_409_7)
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				var_409_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_409_8 = 0
			local var_409_9 = 1.275

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_10 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(938032099).content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_12 = 51 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_10) / 51)

				if (51 <= 0 and var_409_9 or var_409_9 * (utf8.len(var_409_10) / 51)) > 0 and var_409_9 < var_409_12 then
					arg_406_1.talkMaxDuration = var_409_12

					if var_409_12 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_12 + var_409_8
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_13 = math.max(var_409_9, arg_406_1.talkMaxDuration)

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_13 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_8) / var_409_13

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_8 + var_409_13 and arg_406_1.time_ < var_409_8 + var_409_13 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
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

		arg_406_1:InitPlayNodeList()
	end,
	Play938032100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 938032100
		arg_410_1.duration_ = 5.52

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play938032101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_413_0 = 0.366666666666667

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				local var_413_1, var_413_2 = math.modf((arg_410_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_413_2 * 0.13, var_413_2 * 0.13, var_413_2 * 0.13) + arg_410_1.var_.shakeOldPos
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				manager.ui.mainCamera.transform.localPosition = arg_410_1.var_.shakeOldPos
			end

			local var_413_3 = 0

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_3 + arg_413_0 then
				arg_410_1.allBtn_.enabled = false
			end

			if arg_410_1.time_ >= var_413_3 + 1 and arg_410_1.time_ < var_413_3 + 1 + arg_413_0 then
				arg_410_1.allBtn_.enabled = true
			end

			if arg_410_1.frameCnt_ <= 1 then
				arg_410_1.dialog_:SetActive(false)
			end

			local var_413_4 = 0.525
			local var_413_5 = 0.475

			if 0.525 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0

				arg_410_1.dialog_:SetActive(true)

				arg_410_1.dialogCg_.alpha = 0

				local var_413_6 = LeanTween.value(arg_410_1.dialog_, 0, 1, 0.3)

				var_413_6:setOnUpdate(LuaHelper.FloatAction(function(arg_414_0)
					arg_410_1.dialogCg_.alpha = arg_414_0
				end))
				var_413_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_410_1.dialog_)
					var_413_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_410_1.duration_ = arg_410_1.duration_ + 0.3

				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_7 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(938032100).content)

				arg_410_1.text_.text = var_413_7

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_9 = 19 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 19)

				if (19 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 19)) > 0 and var_413_5 < var_413_9 then
					arg_410_1.talkMaxDuration = var_413_9
					var_413_4 = var_413_4 + 0.3

					if var_413_9 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_4
					end
				end

				arg_410_1.text_.text = var_413_7
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = var_413_4 + 0.3
			local var_413_11 = math.max(var_413_5, arg_410_1.talkMaxDuration)

			if var_413_4 + 0.3 <= arg_410_1.time_ and arg_410_1.time_ < var_413_10 + var_413_11 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_10) / var_413_11

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_10 + var_413_11 and arg_410_1.time_ < var_413_10 + var_413_11 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play938032101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 938032101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play938032102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["10144"]) and arg_416_1.var_.actorSpriteComps10144 == nil then
				arg_416_1.var_.actorSpriteComps10144 = arg_416_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["10144"]) then
				if arg_416_1.var_.actorSpriteComps10144 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								iter_419_1.color = Color.New(Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor1.r, (arg_416_1.time_ - 0) / var_419_0), Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor1.g, (arg_416_1.time_ - 0) / var_419_0), (Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor1.b, (arg_416_1.time_ - 0) / var_419_0)))
							else
								local var_419_1 = Mathf.Lerp(iter_419_1.color.r, 1, (arg_416_1.time_ - 0) / var_419_0)

								iter_419_1.color = Color.New(var_419_1, var_419_1, var_419_1)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["10144"]) and arg_416_1.var_.actorSpriteComps10144 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps10144 = nil
			end

			local var_419_2 = arg_416_1.actors_["10144"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos10144 = var_419_2.localPosition
				var_419_2.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10144", 3)

				for iter_419_4 = 0, var_419_2.childCount - 1 do
					local var_419_3 = var_419_2:GetChild(iter_419_4)

					if var_419_3.name == "split_2" or not string.find(var_419_3.name, "split") then
						var_419_3.gameObject:SetActive(true)
					else
						var_419_3.gameObject:SetActive(false)
					end
				end
			end

			local var_419_4 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				var_419_2.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_416_1.time_ - 0) / var_419_4)
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				var_419_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_419_5 = 0
			local var_419_6 = 0.425

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_5 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_7 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(938032101).content)

				arg_416_1.text_.text = var_419_7

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_9 = 17 <= 0 and var_419_6 or var_419_6 * (utf8.len(var_419_7) / 17)

				if (17 <= 0 and var_419_6 or var_419_6 * (utf8.len(var_419_7) / 17)) > 0 and var_419_6 < var_419_9 then
					arg_416_1.talkMaxDuration = var_419_9

					if var_419_9 + var_419_5 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_9 + var_419_5
					end
				end

				arg_416_1.text_.text = var_419_7
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_6, arg_416_1.talkMaxDuration)

			if var_419_5 <= arg_416_1.time_ and arg_416_1.time_ < var_419_5 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_5) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_5 + var_419_10 and arg_416_1.time_ < var_419_5 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play938032102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 938032102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play938032103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["10144"]) and arg_420_1.var_.actorSpriteComps10144 == nil then
				arg_420_1.var_.actorSpriteComps10144 = arg_420_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_0 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["10144"]) then
				if arg_420_1.var_.actorSpriteComps10144 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								iter_423_1.color = Color.New(Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor2.r, (arg_420_1.time_ - 0) / var_423_0), Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor2.g, (arg_420_1.time_ - 0) / var_423_0), (Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor2.b, (arg_420_1.time_ - 0) / var_423_0)))
							else
								local var_423_1 = Mathf.Lerp(iter_423_1.color.r, 0.5, (arg_420_1.time_ - 0) / var_423_0)

								iter_423_1.color = Color.New(var_423_1, var_423_1, var_423_1)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["10144"]) and arg_420_1.var_.actorSpriteComps10144 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_423_3 then
						iter_423_3.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_420_1.var_.actorSpriteComps10144 = nil
			end

			local var_423_2 = 0
			local var_423_3 = 0.525

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_4 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(938032102).content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_6 = 21 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_4) / 21)

				if (21 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_4) / 21)) > 0 and var_423_3 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_2
					end
				end

				arg_420_1.text_.text = var_423_4
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_3, arg_420_1.talkMaxDuration)

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_2) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_2 + var_423_7 and arg_420_1.time_ < var_423_2 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play938032103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 938032103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play938032104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["106603"]) and arg_424_1.var_.actorSpriteComps106603 == nil then
				arg_424_1.var_.actorSpriteComps106603 = arg_424_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_0 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["106603"]) then
				if arg_424_1.var_.actorSpriteComps106603 then
					for iter_427_0, iter_427_1 in pairs(arg_424_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_427_1 then
							if arg_424_1.isInRecall_ then
								iter_427_1.color = Color.New(Mathf.Lerp(iter_427_1.color.r, arg_424_1.hightColor1.r, (arg_424_1.time_ - 0) / var_427_0), Mathf.Lerp(iter_427_1.color.g, arg_424_1.hightColor1.g, (arg_424_1.time_ - 0) / var_427_0), (Mathf.Lerp(iter_427_1.color.b, arg_424_1.hightColor1.b, (arg_424_1.time_ - 0) / var_427_0)))
							else
								local var_427_1 = Mathf.Lerp(iter_427_1.color.r, 1, (arg_424_1.time_ - 0) / var_427_0)

								iter_427_1.color = Color.New(var_427_1, var_427_1, var_427_1)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["106603"]) and arg_424_1.var_.actorSpriteComps106603 then
				for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_427_3 then
						iter_427_3.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_424_1.var_.actorSpriteComps106603 = nil
			end

			local var_427_2 = arg_424_1.actors_["106603"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos106603 = var_427_2.localPosition
				var_427_2.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("106603", 2)

				for iter_427_4 = 0, var_427_2.childCount - 1 do
					local var_427_3 = var_427_2:GetChild(iter_427_4)

					if var_427_3.name == "" or not string.find(var_427_3.name, "split") then
						var_427_3.gameObject:SetActive(true)
					else
						var_427_3.gameObject:SetActive(false)
					end
				end
			end

			local var_427_4 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				var_427_2.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_424_1.time_ - 0) / var_427_4)
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				var_427_2.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_427_5 = arg_424_1.actors_["10144"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10144 = var_427_5.localPosition
				var_427_5.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10144", 7)

				for iter_427_5 = 0, var_427_5.childCount - 1 do
					local var_427_6 = var_427_5:GetChild(iter_427_5)

					if var_427_6.name == "" or not string.find(var_427_6.name, "split") then
						var_427_6.gameObject:SetActive(true)
					else
						var_427_6.gameObject:SetActive(false)
					end
				end
			end

			local var_427_7 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				var_427_5.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_424_1.time_ - 0) / var_427_7)
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				var_427_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_427_8 = 0
			local var_427_9 = 0.5

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(938032103).content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_12 = 20 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_10) / 20)

				if (20 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_10) / 20)) > 0 and var_427_9 < var_427_12 then
					arg_424_1.talkMaxDuration = var_427_12

					if var_427_12 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_13 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_13 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_13

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_13 and arg_424_1.time_ < var_427_8 + var_427_13 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play938032104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 938032104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play938032105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["108301"]) and arg_428_1.var_.actorSpriteComps108301 == nil then
				arg_428_1.var_.actorSpriteComps108301 = arg_428_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_0 = 0.2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["108301"]) then
				if arg_428_1.var_.actorSpriteComps108301 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								iter_431_1.color = Color.New(Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor1.r, (arg_428_1.time_ - 0) / var_431_0), Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor1.g, (arg_428_1.time_ - 0) / var_431_0), (Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor1.b, (arg_428_1.time_ - 0) / var_431_0)))
							else
								local var_431_1 = Mathf.Lerp(iter_431_1.color.r, 1, (arg_428_1.time_ - 0) / var_431_0)

								iter_431_1.color = Color.New(var_431_1, var_431_1, var_431_1)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["108301"]) and arg_428_1.var_.actorSpriteComps108301 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_431_3 then
						iter_431_3.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_428_1.var_.actorSpriteComps108301 = nil
			end

			local var_431_2 = arg_428_1.actors_["106603"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps106603 == nil then
				arg_428_1.var_.actorSpriteComps106603 = var_431_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_3 = 0.2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_3 and not isNil(var_431_2) then
				if arg_428_1.var_.actorSpriteComps106603 then
					for iter_431_4, iter_431_5 in pairs(arg_428_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_431_5 then
							if arg_428_1.isInRecall_ then
								iter_431_5.color = Color.New(Mathf.Lerp(iter_431_5.color.r, arg_428_1.hightColor2.r, (arg_428_1.time_ - 0) / var_431_3), Mathf.Lerp(iter_431_5.color.g, arg_428_1.hightColor2.g, (arg_428_1.time_ - 0) / var_431_3), (Mathf.Lerp(iter_431_5.color.b, arg_428_1.hightColor2.b, (arg_428_1.time_ - 0) / var_431_3)))
							else
								local var_431_4 = Mathf.Lerp(iter_431_5.color.r, 0.5, (arg_428_1.time_ - 0) / var_431_3)

								iter_431_5.color = Color.New(var_431_4, var_431_4, var_431_4)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= 0 + var_431_3 and arg_428_1.time_ < 0 + var_431_3 + arg_431_0 and not isNil(var_431_2) and arg_428_1.var_.actorSpriteComps106603 then
				for iter_431_6, iter_431_7 in pairs(arg_428_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_431_7 then
						iter_431_7.color = arg_428_1.isInRecall_ and (arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_428_1.var_.actorSpriteComps106603 = nil
			end

			local var_431_5 = arg_428_1.actors_["108301"].transform

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos108301 = var_431_5.localPosition
				var_431_5.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("108301", 4)

				for iter_431_8 = 0, var_431_5.childCount - 1 do
					local var_431_6 = var_431_5:GetChild(iter_431_8)

					if var_431_6.name == "split_5" or not string.find(var_431_6.name, "split") then
						var_431_6.gameObject:SetActive(true)
					else
						var_431_6.gameObject:SetActive(false)
					end
				end
			end

			local var_431_7 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 then
				var_431_5.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_428_1.time_ - 0) / var_431_7)
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 then
				var_431_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_431_8 = 0
			local var_431_9 = 0.375

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_10 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(938032104).content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_12 = 15 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_10) / 15)

				if (15 <= 0 and var_431_9 or var_431_9 * (utf8.len(var_431_10) / 15)) > 0 and var_431_9 < var_431_12 then
					arg_428_1.talkMaxDuration = var_431_12

					if var_431_12 + var_431_8 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_12 + var_431_8
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_13 = math.max(var_431_9, arg_428_1.talkMaxDuration)

			if var_431_8 <= arg_428_1.time_ and arg_428_1.time_ < var_431_8 + var_431_13 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_8) / var_431_13

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_8 + var_431_13 and arg_428_1.time_ < var_431_8 + var_431_13 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play938032105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 938032105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play938032106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["128404"]) and arg_432_1.var_.actorSpriteComps128404 == nil then
				arg_432_1.var_.actorSpriteComps128404 = arg_432_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_0 = 0.2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["128404"]) then
				if arg_432_1.var_.actorSpriteComps128404 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								iter_435_1.color = Color.New(Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_0), Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_0), (Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_0)))
							else
								local var_435_1 = Mathf.Lerp(iter_435_1.color.r, 1, (arg_432_1.time_ - 0) / var_435_0)

								iter_435_1.color = Color.New(var_435_1, var_435_1, var_435_1)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["128404"]) and arg_432_1.var_.actorSpriteComps128404 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_435_3 then
						iter_435_3.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps128404 = nil
			end

			local var_435_2 = arg_432_1.actors_["108301"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps108301 == nil then
				arg_432_1.var_.actorSpriteComps108301 = var_435_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_3 = 0.2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_3 and not isNil(var_435_2) then
				if arg_432_1.var_.actorSpriteComps108301 then
					for iter_435_4, iter_435_5 in pairs(arg_432_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_435_5 then
							if arg_432_1.isInRecall_ then
								iter_435_5.color = Color.New(Mathf.Lerp(iter_435_5.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_3), Mathf.Lerp(iter_435_5.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_3), (Mathf.Lerp(iter_435_5.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_3)))
							else
								local var_435_4 = Mathf.Lerp(iter_435_5.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_3)

								iter_435_5.color = Color.New(var_435_4, var_435_4, var_435_4)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_3 and arg_432_1.time_ < 0 + var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps108301 then
				for iter_435_6, iter_435_7 in pairs(arg_432_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_435_7 then
						iter_435_7.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps108301 = nil
			end

			local var_435_5 = arg_432_1.actors_["128404"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos128404 = var_435_5.localPosition
				var_435_5.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("128404", 2)

				for iter_435_8 = 0, var_435_5.childCount - 1 do
					local var_435_6 = var_435_5:GetChild(iter_435_8)

					if var_435_6.name == "" or not string.find(var_435_6.name, "split") then
						var_435_6.gameObject:SetActive(true)
					else
						var_435_6.gameObject:SetActive(false)
					end
				end
			end

			local var_435_7 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				var_435_5.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_432_1.time_ - 0) / var_435_7)
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				var_435_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_435_8 = arg_432_1.actors_["106603"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos106603 = var_435_8.localPosition
				var_435_8.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("106603", 7)

				for iter_435_9 = 0, var_435_8.childCount - 1 do
					local var_435_9 = var_435_8:GetChild(iter_435_9)

					if var_435_9.name == "" or not string.find(var_435_9.name, "split") then
						var_435_9.gameObject:SetActive(true)
					else
						var_435_9.gameObject:SetActive(false)
					end
				end
			end

			local var_435_10 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_10 then
				var_435_8.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_432_1.time_ - 0) / var_435_10)
			end

			if arg_432_1.time_ >= 0 + var_435_10 and arg_432_1.time_ < 0 + var_435_10 + arg_435_0 then
				var_435_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_435_11 = 0
			local var_435_12 = 0.125

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_11 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_13 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(938032105).content)

				arg_432_1.text_.text = var_435_13

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_15 = 5 <= 0 and var_435_12 or var_435_12 * (utf8.len(var_435_13) / 5)

				if (5 <= 0 and var_435_12 or var_435_12 * (utf8.len(var_435_13) / 5)) > 0 and var_435_12 < var_435_15 then
					arg_432_1.talkMaxDuration = var_435_15

					if var_435_15 + var_435_11 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_15 + var_435_11
					end
				end

				arg_432_1.text_.text = var_435_13
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_12, arg_432_1.talkMaxDuration)

			if var_435_11 <= arg_432_1.time_ and arg_432_1.time_ < var_435_11 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_11) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_11 + var_435_16 and arg_432_1.time_ < var_435_11 + var_435_16 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play938032106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 938032106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play938032107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["108301"]) and arg_436_1.var_.actorSpriteComps108301 == nil then
				arg_436_1.var_.actorSpriteComps108301 = arg_436_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_0 = 0.2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["108301"]) then
				if arg_436_1.var_.actorSpriteComps108301 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								iter_439_1.color = Color.New(Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, (arg_436_1.time_ - 0) / var_439_0), Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, (arg_436_1.time_ - 0) / var_439_0), (Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, (arg_436_1.time_ - 0) / var_439_0)))
							else
								local var_439_1 = Mathf.Lerp(iter_439_1.color.r, 1, (arg_436_1.time_ - 0) / var_439_0)

								iter_439_1.color = Color.New(var_439_1, var_439_1, var_439_1)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["108301"]) and arg_436_1.var_.actorSpriteComps108301 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_439_3 then
						iter_439_3.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_436_1.var_.actorSpriteComps108301 = nil
			end

			local var_439_2 = arg_436_1.actors_["128404"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.actorSpriteComps128404 == nil then
				arg_436_1.var_.actorSpriteComps128404 = var_439_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_3 = 0.2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_3 and not isNil(var_439_2) then
				if arg_436_1.var_.actorSpriteComps128404 then
					for iter_439_4, iter_439_5 in pairs(arg_436_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_439_5 then
							if arg_436_1.isInRecall_ then
								iter_439_5.color = Color.New(Mathf.Lerp(iter_439_5.color.r, arg_436_1.hightColor2.r, (arg_436_1.time_ - 0) / var_439_3), Mathf.Lerp(iter_439_5.color.g, arg_436_1.hightColor2.g, (arg_436_1.time_ - 0) / var_439_3), (Mathf.Lerp(iter_439_5.color.b, arg_436_1.hightColor2.b, (arg_436_1.time_ - 0) / var_439_3)))
							else
								local var_439_4 = Mathf.Lerp(iter_439_5.color.r, 0.5, (arg_436_1.time_ - 0) / var_439_3)

								iter_439_5.color = Color.New(var_439_4, var_439_4, var_439_4)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= 0 + var_439_3 and arg_436_1.time_ < 0 + var_439_3 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.actorSpriteComps128404 then
				for iter_439_6, iter_439_7 in pairs(arg_436_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_439_7 then
						iter_439_7.color = arg_436_1.isInRecall_ and (arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_436_1.var_.actorSpriteComps128404 = nil
			end

			local var_439_5 = arg_436_1.actors_["108301"].transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos108301 = var_439_5.localPosition
				var_439_5.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("108301", 4)

				for iter_439_8 = 0, var_439_5.childCount - 1 do
					local var_439_6 = var_439_5:GetChild(iter_439_8)

					if var_439_6.name == "split_3" or not string.find(var_439_6.name, "split") then
						var_439_6.gameObject:SetActive(true)
					else
						var_439_6.gameObject:SetActive(false)
					end
				end
			end

			local var_439_7 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				var_439_5.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_436_1.time_ - 0) / var_439_7)
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				var_439_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_439_8 = 0
			local var_439_9 = 0.2

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_8 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_10 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(938032106).content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_12 = 8 <= 0 and var_439_9 or var_439_9 * (utf8.len(var_439_10) / 8)

				if (8 <= 0 and var_439_9 or var_439_9 * (utf8.len(var_439_10) / 8)) > 0 and var_439_9 < var_439_12 then
					arg_436_1.talkMaxDuration = var_439_12

					if var_439_12 + var_439_8 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_8
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_13 = math.max(var_439_9, arg_436_1.talkMaxDuration)

			if var_439_8 <= arg_436_1.time_ and arg_436_1.time_ < var_439_8 + var_439_13 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_8) / var_439_13

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_8 + var_439_13 and arg_436_1.time_ < var_439_8 + var_439_13 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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

		arg_436_1:InitPlayNodeList()
	end,
	Play938032107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 938032107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play938032108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["128404"]) and arg_440_1.var_.actorSpriteComps128404 == nil then
				arg_440_1.var_.actorSpriteComps128404 = arg_440_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_0 = 0.2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["128404"]) then
				if arg_440_1.var_.actorSpriteComps128404 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								iter_443_1.color = Color.New(Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor1.r, (arg_440_1.time_ - 0) / var_443_0), Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor1.g, (arg_440_1.time_ - 0) / var_443_0), (Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor1.b, (arg_440_1.time_ - 0) / var_443_0)))
							else
								local var_443_1 = Mathf.Lerp(iter_443_1.color.r, 1, (arg_440_1.time_ - 0) / var_443_0)

								iter_443_1.color = Color.New(var_443_1, var_443_1, var_443_1)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["128404"]) and arg_440_1.var_.actorSpriteComps128404 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_443_3 then
						iter_443_3.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_440_1.var_.actorSpriteComps128404 = nil
			end

			local var_443_2 = arg_440_1.actors_["108301"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_2) and arg_440_1.var_.actorSpriteComps108301 == nil then
				arg_440_1.var_.actorSpriteComps108301 = var_443_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_3 = 0.2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_3 and not isNil(var_443_2) then
				if arg_440_1.var_.actorSpriteComps108301 then
					for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_443_5 then
							if arg_440_1.isInRecall_ then
								iter_443_5.color = Color.New(Mathf.Lerp(iter_443_5.color.r, arg_440_1.hightColor2.r, (arg_440_1.time_ - 0) / var_443_3), Mathf.Lerp(iter_443_5.color.g, arg_440_1.hightColor2.g, (arg_440_1.time_ - 0) / var_443_3), (Mathf.Lerp(iter_443_5.color.b, arg_440_1.hightColor2.b, (arg_440_1.time_ - 0) / var_443_3)))
							else
								local var_443_4 = Mathf.Lerp(iter_443_5.color.r, 0.5, (arg_440_1.time_ - 0) / var_443_3)

								iter_443_5.color = Color.New(var_443_4, var_443_4, var_443_4)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_3 and arg_440_1.time_ < 0 + var_443_3 + arg_443_0 and not isNil(var_443_2) and arg_440_1.var_.actorSpriteComps108301 then
				for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_443_7 then
						iter_443_7.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_440_1.var_.actorSpriteComps108301 = nil
			end

			local var_443_5 = arg_440_1.actors_["128404"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos128404 = var_443_5.localPosition
				var_443_5.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("128404", 2)

				for iter_443_8 = 0, var_443_5.childCount - 1 do
					local var_443_6 = var_443_5:GetChild(iter_443_8)

					if var_443_6.name == "split_4" or not string.find(var_443_6.name, "split") then
						var_443_6.gameObject:SetActive(true)
					else
						var_443_6.gameObject:SetActive(false)
					end
				end
			end

			local var_443_7 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				var_443_5.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_440_1.time_ - 0) / var_443_7)
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				var_443_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_443_8 = 0
			local var_443_9 = 0.875

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_8 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_10 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(938032107).content)

				arg_440_1.text_.text = var_443_10

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_12 = 35 <= 0 and var_443_9 or var_443_9 * (utf8.len(var_443_10) / 35)

				if (35 <= 0 and var_443_9 or var_443_9 * (utf8.len(var_443_10) / 35)) > 0 and var_443_9 < var_443_12 then
					arg_440_1.talkMaxDuration = var_443_12

					if var_443_12 + var_443_8 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_8
					end
				end

				arg_440_1.text_.text = var_443_10
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_13 = math.max(var_443_9, arg_440_1.talkMaxDuration)

			if var_443_8 <= arg_440_1.time_ and arg_440_1.time_ < var_443_8 + var_443_13 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_8) / var_443_13

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_8 + var_443_13 and arg_440_1.time_ < var_443_8 + var_443_13 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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

		arg_440_1:InitPlayNodeList()
	end,
	Play938032108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 938032108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play938032109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["128404"]) and arg_444_1.var_.actorSpriteComps128404 == nil then
				arg_444_1.var_.actorSpriteComps128404 = arg_444_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_0 = 0.2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["128404"]) then
				if arg_444_1.var_.actorSpriteComps128404 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								iter_447_1.color = Color.New(Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor2.r, (arg_444_1.time_ - 0) / var_447_0), Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor2.g, (arg_444_1.time_ - 0) / var_447_0), (Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor2.b, (arg_444_1.time_ - 0) / var_447_0)))
							else
								local var_447_1 = Mathf.Lerp(iter_447_1.color.r, 0.5, (arg_444_1.time_ - 0) / var_447_0)

								iter_447_1.color = Color.New(var_447_1, var_447_1, var_447_1)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["128404"]) and arg_444_1.var_.actorSpriteComps128404 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_447_3 then
						iter_447_3.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_444_1.var_.actorSpriteComps128404 = nil
			end

			local var_447_2 = 0
			local var_447_3 = 0.125

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_2 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_4 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(938032108).content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 5 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_4) / 5)

				if (5 <= 0 and var_447_3 or var_447_3 * (utf8.len(var_447_4) / 5)) > 0 and var_447_3 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_2 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_2
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_3, arg_444_1.talkMaxDuration)

			if var_447_2 <= arg_444_1.time_ and arg_444_1.time_ < var_447_2 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_2) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_2 + var_447_7 and arg_444_1.time_ < var_447_2 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play938032109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 938032109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play938032110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["106603"]) and arg_448_1.var_.actorSpriteComps106603 == nil then
				arg_448_1.var_.actorSpriteComps106603 = arg_448_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_0 = 0.2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["106603"]) then
				if arg_448_1.var_.actorSpriteComps106603 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								iter_451_1.color = Color.New(Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 0) / var_451_0), Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 0) / var_451_0), (Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 0) / var_451_0)))
							else
								local var_451_1 = Mathf.Lerp(iter_451_1.color.r, 1, (arg_448_1.time_ - 0) / var_451_0)

								iter_451_1.color = Color.New(var_451_1, var_451_1, var_451_1)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["106603"]) and arg_448_1.var_.actorSpriteComps106603 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_451_3 then
						iter_451_3.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps106603 = nil
			end

			local var_451_2 = arg_448_1.actors_["106603"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos106603 = var_451_2.localPosition
				var_451_2.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("106603", 4)

				for iter_451_4 = 0, var_451_2.childCount - 1 do
					local var_451_3 = var_451_2:GetChild(iter_451_4)

					if var_451_3.name == "" or not string.find(var_451_3.name, "split") then
						var_451_3.gameObject:SetActive(true)
					else
						var_451_3.gameObject:SetActive(false)
					end
				end
			end

			local var_451_4 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 then
				var_451_2.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_448_1.time_ - 0) / var_451_4)
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 then
				var_451_2.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_451_5 = arg_448_1.actors_["108301"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos108301 = var_451_5.localPosition
				var_451_5.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("108301", 7)

				for iter_451_5 = 0, var_451_5.childCount - 1 do
					local var_451_6 = var_451_5:GetChild(iter_451_5)

					if var_451_6.name == "" or not string.find(var_451_6.name, "split") then
						var_451_6.gameObject:SetActive(true)
					else
						var_451_6.gameObject:SetActive(false)
					end
				end
			end

			local var_451_7 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				var_451_5.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_448_1.time_ - 0) / var_451_7)
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				var_451_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_8 = 0
			local var_451_9 = 0.675

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_10 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(938032109).content)

				arg_448_1.text_.text = var_451_10

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_12 = 27 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_10) / 27)

				if (27 <= 0 and var_451_9 or var_451_9 * (utf8.len(var_451_10) / 27)) > 0 and var_451_9 < var_451_12 then
					arg_448_1.talkMaxDuration = var_451_12

					if var_451_12 + var_451_8 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_12 + var_451_8
					end
				end

				arg_448_1.text_.text = var_451_10
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_13 = math.max(var_451_9, arg_448_1.talkMaxDuration)

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_13 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_8) / var_451_13

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_8 + var_451_13 and arg_448_1.time_ < var_451_8 + var_451_13 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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

		arg_448_1:InitPlayNodeList()
	end,
	Play938032110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 938032110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play938032111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["128404"]) and arg_452_1.var_.actorSpriteComps128404 == nil then
				arg_452_1.var_.actorSpriteComps128404 = arg_452_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_0 = 0.2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["128404"]) then
				if arg_452_1.var_.actorSpriteComps128404 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								iter_455_1.color = Color.New(Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor1.r, (arg_452_1.time_ - 0) / var_455_0), Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor1.g, (arg_452_1.time_ - 0) / var_455_0), (Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor1.b, (arg_452_1.time_ - 0) / var_455_0)))
							else
								local var_455_1 = Mathf.Lerp(iter_455_1.color.r, 1, (arg_452_1.time_ - 0) / var_455_0)

								iter_455_1.color = Color.New(var_455_1, var_455_1, var_455_1)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["128404"]) and arg_452_1.var_.actorSpriteComps128404 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_455_3 then
						iter_455_3.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_452_1.var_.actorSpriteComps128404 = nil
			end

			local var_455_2 = arg_452_1.actors_["106603"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_2) and arg_452_1.var_.actorSpriteComps106603 == nil then
				arg_452_1.var_.actorSpriteComps106603 = var_455_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_3 = 0.2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_3 and not isNil(var_455_2) then
				if arg_452_1.var_.actorSpriteComps106603 then
					for iter_455_4, iter_455_5 in pairs(arg_452_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_455_5 then
							if arg_452_1.isInRecall_ then
								iter_455_5.color = Color.New(Mathf.Lerp(iter_455_5.color.r, arg_452_1.hightColor2.r, (arg_452_1.time_ - 0) / var_455_3), Mathf.Lerp(iter_455_5.color.g, arg_452_1.hightColor2.g, (arg_452_1.time_ - 0) / var_455_3), (Mathf.Lerp(iter_455_5.color.b, arg_452_1.hightColor2.b, (arg_452_1.time_ - 0) / var_455_3)))
							else
								local var_455_4 = Mathf.Lerp(iter_455_5.color.r, 0.5, (arg_452_1.time_ - 0) / var_455_3)

								iter_455_5.color = Color.New(var_455_4, var_455_4, var_455_4)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_3 and arg_452_1.time_ < 0 + var_455_3 + arg_455_0 and not isNil(var_455_2) and arg_452_1.var_.actorSpriteComps106603 then
				for iter_455_6, iter_455_7 in pairs(arg_452_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_455_7 then
						iter_455_7.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_452_1.var_.actorSpriteComps106603 = nil
			end

			local var_455_5 = arg_452_1.actors_["128404"].transform

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos128404 = var_455_5.localPosition
				var_455_5.localScale = Vector3.New(1, 1, 1)

				arg_452_1:CheckSpriteTmpPos("128404", 2)

				for iter_455_8 = 0, var_455_5.childCount - 1 do
					local var_455_6 = var_455_5:GetChild(iter_455_8)

					if var_455_6.name == "" or not string.find(var_455_6.name, "split") then
						var_455_6.gameObject:SetActive(true)
					else
						var_455_6.gameObject:SetActive(false)
					end
				end
			end

			local var_455_7 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_7 then
				var_455_5.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_452_1.time_ - 0) / var_455_7)
			end

			if arg_452_1.time_ >= 0 + var_455_7 and arg_452_1.time_ < 0 + var_455_7 + arg_455_0 then
				var_455_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_455_8 = 0
			local var_455_9 = 1.25

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_8 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_10 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(938032110).content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_12 = 50 <= 0 and var_455_9 or var_455_9 * (utf8.len(var_455_10) / 50)

				if (50 <= 0 and var_455_9 or var_455_9 * (utf8.len(var_455_10) / 50)) > 0 and var_455_9 < var_455_12 then
					arg_452_1.talkMaxDuration = var_455_12

					if var_455_12 + var_455_8 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_12 + var_455_8
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_13 = math.max(var_455_9, arg_452_1.talkMaxDuration)

			if var_455_8 <= arg_452_1.time_ and arg_452_1.time_ < var_455_8 + var_455_13 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_8) / var_455_13

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_8 + var_455_13 and arg_452_1.time_ < var_455_8 + var_455_13 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
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

		arg_452_1:InitPlayNodeList()
	end,
	Play938032111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 938032111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play938032112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["104902"]) and arg_456_1.var_.actorSpriteComps104902 == nil then
				arg_456_1.var_.actorSpriteComps104902 = arg_456_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_0 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["104902"]) then
				if arg_456_1.var_.actorSpriteComps104902 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								iter_459_1.color = Color.New(Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, (arg_456_1.time_ - 0) / var_459_0), Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, (arg_456_1.time_ - 0) / var_459_0), (Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, (arg_456_1.time_ - 0) / var_459_0)))
							else
								local var_459_1 = Mathf.Lerp(iter_459_1.color.r, 1, (arg_456_1.time_ - 0) / var_459_0)

								iter_459_1.color = Color.New(var_459_1, var_459_1, var_459_1)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["104902"]) and arg_456_1.var_.actorSpriteComps104902 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_459_3 then
						iter_459_3.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps104902 = nil
			end

			local var_459_2 = arg_456_1.actors_["128404"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_2) and arg_456_1.var_.actorSpriteComps128404 == nil then
				arg_456_1.var_.actorSpriteComps128404 = var_459_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_3 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_3 and not isNil(var_459_2) then
				if arg_456_1.var_.actorSpriteComps128404 then
					for iter_459_4, iter_459_5 in pairs(arg_456_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_459_5 then
							if arg_456_1.isInRecall_ then
								iter_459_5.color = Color.New(Mathf.Lerp(iter_459_5.color.r, arg_456_1.hightColor2.r, (arg_456_1.time_ - 0) / var_459_3), Mathf.Lerp(iter_459_5.color.g, arg_456_1.hightColor2.g, (arg_456_1.time_ - 0) / var_459_3), (Mathf.Lerp(iter_459_5.color.b, arg_456_1.hightColor2.b, (arg_456_1.time_ - 0) / var_459_3)))
							else
								local var_459_4 = Mathf.Lerp(iter_459_5.color.r, 0.5, (arg_456_1.time_ - 0) / var_459_3)

								iter_459_5.color = Color.New(var_459_4, var_459_4, var_459_4)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_3 and arg_456_1.time_ < 0 + var_459_3 + arg_459_0 and not isNil(var_459_2) and arg_456_1.var_.actorSpriteComps128404 then
				for iter_459_6, iter_459_7 in pairs(arg_456_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_459_7 then
						iter_459_7.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_456_1.var_.actorSpriteComps128404 = nil
			end

			local var_459_5 = arg_456_1.actors_["104902"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos104902 = var_459_5.localPosition
				var_459_5.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("104902", 2)

				for iter_459_8 = 0, var_459_5.childCount - 1 do
					local var_459_6 = var_459_5:GetChild(iter_459_8)

					if var_459_6.name == "split_2" or not string.find(var_459_6.name, "split") then
						var_459_6.gameObject:SetActive(true)
					else
						var_459_6.gameObject:SetActive(false)
					end
				end
			end

			local var_459_7 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				var_459_5.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_456_1.time_ - 0) / var_459_7)
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				var_459_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_459_8 = arg_456_1.actors_["128404"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos128404 = var_459_8.localPosition
				var_459_8.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("128404", 7)

				for iter_459_9 = 0, var_459_8.childCount - 1 do
					local var_459_9 = var_459_8:GetChild(iter_459_9)

					if var_459_9.name == "" or not string.find(var_459_9.name, "split") then
						var_459_9.gameObject:SetActive(true)
					else
						var_459_9.gameObject:SetActive(false)
					end
				end
			end

			local var_459_10 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_10 then
				var_459_8.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_456_1.time_ - 0) / var_459_10)
			end

			if arg_456_1.time_ >= 0 + var_459_10 and arg_456_1.time_ < 0 + var_459_10 + arg_459_0 then
				var_459_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_459_11 = 0
			local var_459_12 = 0.325

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_11 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_13 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(938032111).content)

				arg_456_1.text_.text = var_459_13

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_15 = 13 <= 0 and var_459_12 or var_459_12 * (utf8.len(var_459_13) / 13)

				if (13 <= 0 and var_459_12 or var_459_12 * (utf8.len(var_459_13) / 13)) > 0 and var_459_12 < var_459_15 then
					arg_456_1.talkMaxDuration = var_459_15

					if var_459_15 + var_459_11 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_15 + var_459_11
					end
				end

				arg_456_1.text_.text = var_459_13
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_16 = math.max(var_459_12, arg_456_1.talkMaxDuration)

			if var_459_11 <= arg_456_1.time_ and arg_456_1.time_ < var_459_11 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_11) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_11 + var_459_16 and arg_456_1.time_ < var_459_11 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
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

		arg_456_1:InitPlayNodeList()
	end,
	Play938032112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 938032112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play938032113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["106603"]) and arg_460_1.var_.actorSpriteComps106603 == nil then
				arg_460_1.var_.actorSpriteComps106603 = arg_460_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_0 = 0.2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["106603"]) then
				if arg_460_1.var_.actorSpriteComps106603 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								iter_463_1.color = Color.New(Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, (arg_460_1.time_ - 0) / var_463_0), Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, (arg_460_1.time_ - 0) / var_463_0), (Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, (arg_460_1.time_ - 0) / var_463_0)))
							else
								local var_463_1 = Mathf.Lerp(iter_463_1.color.r, 1, (arg_460_1.time_ - 0) / var_463_0)

								iter_463_1.color = Color.New(var_463_1, var_463_1, var_463_1)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["106603"]) and arg_460_1.var_.actorSpriteComps106603 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_463_3 then
						iter_463_3.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_460_1.var_.actorSpriteComps106603 = nil
			end

			local var_463_2 = arg_460_1.actors_["104902"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps104902 == nil then
				arg_460_1.var_.actorSpriteComps104902 = var_463_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_3 = 0.2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_3 and not isNil(var_463_2) then
				if arg_460_1.var_.actorSpriteComps104902 then
					for iter_463_4, iter_463_5 in pairs(arg_460_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_463_5 then
							if arg_460_1.isInRecall_ then
								iter_463_5.color = Color.New(Mathf.Lerp(iter_463_5.color.r, arg_460_1.hightColor2.r, (arg_460_1.time_ - 0) / var_463_3), Mathf.Lerp(iter_463_5.color.g, arg_460_1.hightColor2.g, (arg_460_1.time_ - 0) / var_463_3), (Mathf.Lerp(iter_463_5.color.b, arg_460_1.hightColor2.b, (arg_460_1.time_ - 0) / var_463_3)))
							else
								local var_463_4 = Mathf.Lerp(iter_463_5.color.r, 0.5, (arg_460_1.time_ - 0) / var_463_3)

								iter_463_5.color = Color.New(var_463_4, var_463_4, var_463_4)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_3 and arg_460_1.time_ < 0 + var_463_3 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps104902 then
				for iter_463_6, iter_463_7 in pairs(arg_460_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_463_7 then
						iter_463_7.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_460_1.var_.actorSpriteComps104902 = nil
			end

			local var_463_5 = arg_460_1.actors_["106603"].transform

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos106603 = var_463_5.localPosition
				var_463_5.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("106603", 4)

				for iter_463_8 = 0, var_463_5.childCount - 1 do
					local var_463_6 = var_463_5:GetChild(iter_463_8)

					if var_463_6.name == "split_4" or not string.find(var_463_6.name, "split") then
						var_463_6.gameObject:SetActive(true)
					else
						var_463_6.gameObject:SetActive(false)
					end
				end
			end

			local var_463_7 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				var_463_5.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_460_1.time_ - 0) / var_463_7)
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				var_463_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_463_8 = 0
			local var_463_9 = 0.5

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_8 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_10 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(938032112).content)

				arg_460_1.text_.text = var_463_10

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_12 = 20 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_10) / 20)

				if (20 <= 0 and var_463_9 or var_463_9 * (utf8.len(var_463_10) / 20)) > 0 and var_463_9 < var_463_12 then
					arg_460_1.talkMaxDuration = var_463_12

					if var_463_12 + var_463_8 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_12 + var_463_8
					end
				end

				arg_460_1.text_.text = var_463_10
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_13 = math.max(var_463_9, arg_460_1.talkMaxDuration)

			if var_463_8 <= arg_460_1.time_ and arg_460_1.time_ < var_463_8 + var_463_13 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_8) / var_463_13

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_8 + var_463_13 and arg_460_1.time_ < var_463_8 + var_463_13 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play938032113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 938032113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play938032114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["108301"]) and arg_464_1.var_.actorSpriteComps108301 == nil then
				arg_464_1.var_.actorSpriteComps108301 = arg_464_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_0 = 0.2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["108301"]) then
				if arg_464_1.var_.actorSpriteComps108301 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								iter_467_1.color = Color.New(Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor1.r, (arg_464_1.time_ - 0) / var_467_0), Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor1.g, (arg_464_1.time_ - 0) / var_467_0), (Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor1.b, (arg_464_1.time_ - 0) / var_467_0)))
							else
								local var_467_1 = Mathf.Lerp(iter_467_1.color.r, 1, (arg_464_1.time_ - 0) / var_467_0)

								iter_467_1.color = Color.New(var_467_1, var_467_1, var_467_1)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["108301"]) and arg_464_1.var_.actorSpriteComps108301 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_467_3 then
						iter_467_3.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_464_1.var_.actorSpriteComps108301 = nil
			end

			local var_467_2 = arg_464_1.actors_["106603"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.actorSpriteComps106603 == nil then
				arg_464_1.var_.actorSpriteComps106603 = var_467_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_3 = 0.2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_3 and not isNil(var_467_2) then
				if arg_464_1.var_.actorSpriteComps106603 then
					for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_467_5 then
							if arg_464_1.isInRecall_ then
								iter_467_5.color = Color.New(Mathf.Lerp(iter_467_5.color.r, arg_464_1.hightColor2.r, (arg_464_1.time_ - 0) / var_467_3), Mathf.Lerp(iter_467_5.color.g, arg_464_1.hightColor2.g, (arg_464_1.time_ - 0) / var_467_3), (Mathf.Lerp(iter_467_5.color.b, arg_464_1.hightColor2.b, (arg_464_1.time_ - 0) / var_467_3)))
							else
								local var_467_4 = Mathf.Lerp(iter_467_5.color.r, 0.5, (arg_464_1.time_ - 0) / var_467_3)

								iter_467_5.color = Color.New(var_467_4, var_467_4, var_467_4)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_3 and arg_464_1.time_ < 0 + var_467_3 + arg_467_0 and not isNil(var_467_2) and arg_464_1.var_.actorSpriteComps106603 then
				for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_467_7 then
						iter_467_7.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_464_1.var_.actorSpriteComps106603 = nil
			end

			local var_467_5 = arg_464_1.actors_["108301"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos108301 = var_467_5.localPosition
				var_467_5.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("108301", 4)

				for iter_467_8 = 0, var_467_5.childCount - 1 do
					local var_467_6 = var_467_5:GetChild(iter_467_8)

					if var_467_6.name == "split_2" or not string.find(var_467_6.name, "split") then
						var_467_6.gameObject:SetActive(true)
					else
						var_467_6.gameObject:SetActive(false)
					end
				end
			end

			local var_467_7 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_7 then
				var_467_5.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_464_1.time_ - 0) / var_467_7)
			end

			if arg_464_1.time_ >= 0 + var_467_7 and arg_464_1.time_ < 0 + var_467_7 + arg_467_0 then
				var_467_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_467_8 = arg_464_1.actors_["106603"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos106603 = var_467_8.localPosition
				var_467_8.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("106603", 7)

				for iter_467_9 = 0, var_467_8.childCount - 1 do
					local var_467_9 = var_467_8:GetChild(iter_467_9)

					if var_467_9.name == "" or not string.find(var_467_9.name, "split") then
						var_467_9.gameObject:SetActive(true)
					else
						var_467_9.gameObject:SetActive(false)
					end
				end
			end

			local var_467_10 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_10 then
				var_467_8.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_464_1.time_ - 0) / var_467_10)
			end

			if arg_464_1.time_ >= 0 + var_467_10 and arg_464_1.time_ < 0 + var_467_10 + arg_467_0 then
				var_467_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_467_11 = 0
			local var_467_12 = 0.6

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_11 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_13 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(938032113).content)

				arg_464_1.text_.text = var_467_13

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_15 = 24 <= 0 and var_467_12 or var_467_12 * (utf8.len(var_467_13) / 24)

				if (24 <= 0 and var_467_12 or var_467_12 * (utf8.len(var_467_13) / 24)) > 0 and var_467_12 < var_467_15 then
					arg_464_1.talkMaxDuration = var_467_15

					if var_467_15 + var_467_11 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_15 + var_467_11
					end
				end

				arg_464_1.text_.text = var_467_13
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_16 = math.max(var_467_12, arg_464_1.talkMaxDuration)

			if var_467_11 <= arg_464_1.time_ and arg_464_1.time_ < var_467_11 + var_467_16 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_11) / var_467_16

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_11 + var_467_16 and arg_464_1.time_ < var_467_11 + var_467_16 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play938032114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 938032114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play938032115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos108301 = arg_468_1.actors_["108301"].transform.localPosition
				arg_468_1.actors_["108301"].transform.localScale = Vector3.New(1, 1, 1)

				arg_468_1:CheckSpriteTmpPos("108301", 4)

				for iter_471_0 = 0, arg_468_1.actors_["108301"].transform.childCount - 1 do
					local var_471_0 = arg_468_1.actors_["108301"].transform:GetChild(iter_471_0)

					if var_471_0.name == "" then
						var_471_0:SetAsLastSibling()
						var_471_0.gameObject:SetActive(true)

						arg_468_1.var_.actorSpriteSplit108301 = var_471_0.gameObject:GetComponent(typeof(Image))

						arg_468_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_471_1 = 0.5

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_1 then
				arg_468_1.actors_["108301"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_468_1.time_ - 0) / var_471_1)

				if arg_468_1.var_.actorSpriteSplit108301 ~= nil then
					arg_468_1.var_.actorSpriteSplit108301:SetAlpha((arg_468_1.time_ - 0) / var_471_1)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_1 and arg_468_1.time_ < 0 + var_471_1 + arg_471_0 then
				arg_468_1.actors_["108301"].transform.localPosition = Vector3.New(460, -360, -195)

				if arg_468_1.var_.actorSpriteSplit108301 ~= nil then
					arg_468_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_471_2 = 0
			local var_471_3 = 0.85

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_2 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_4 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(938032114).content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_6 = 34 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_4) / 34)

				if (34 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_4) / 34)) > 0 and var_471_3 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_2
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_3, arg_468_1.talkMaxDuration)

			if var_471_2 <= arg_468_1.time_ and arg_468_1.time_ < var_471_2 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_2) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_2 + var_471_7 and arg_468_1.time_ < var_471_2 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
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

		arg_468_1:InitPlayNodeList()
	end,
	Play938032115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 938032115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play938032116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["10183"]) and arg_472_1.var_.actorSpriteComps10183 == nil then
				arg_472_1.var_.actorSpriteComps10183 = arg_472_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_0 = 0.2

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["10183"]) then
				if arg_472_1.var_.actorSpriteComps10183 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								iter_475_1.color = Color.New(Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, (arg_472_1.time_ - 0) / var_475_0), Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, (arg_472_1.time_ - 0) / var_475_0), (Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, (arg_472_1.time_ - 0) / var_475_0)))
							else
								local var_475_1 = Mathf.Lerp(iter_475_1.color.r, 1, (arg_472_1.time_ - 0) / var_475_0)

								iter_475_1.color = Color.New(var_475_1, var_475_1, var_475_1)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["10183"]) and arg_472_1.var_.actorSpriteComps10183 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_475_3 then
						iter_475_3.color = arg_472_1.isInRecall_ and (arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_472_1.var_.actorSpriteComps10183 = nil
			end

			local var_475_2 = arg_472_1.actors_["108301"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_2) and arg_472_1.var_.actorSpriteComps108301 == nil then
				arg_472_1.var_.actorSpriteComps108301 = var_475_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_3 = 0.2

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_3 and not isNil(var_475_2) then
				if arg_472_1.var_.actorSpriteComps108301 then
					for iter_475_4, iter_475_5 in pairs(arg_472_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_475_5 then
							if arg_472_1.isInRecall_ then
								iter_475_5.color = Color.New(Mathf.Lerp(iter_475_5.color.r, arg_472_1.hightColor2.r, (arg_472_1.time_ - 0) / var_475_3), Mathf.Lerp(iter_475_5.color.g, arg_472_1.hightColor2.g, (arg_472_1.time_ - 0) / var_475_3), (Mathf.Lerp(iter_475_5.color.b, arg_472_1.hightColor2.b, (arg_472_1.time_ - 0) / var_475_3)))
							else
								local var_475_4 = Mathf.Lerp(iter_475_5.color.r, 0.5, (arg_472_1.time_ - 0) / var_475_3)

								iter_475_5.color = Color.New(var_475_4, var_475_4, var_475_4)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= 0 + var_475_3 and arg_472_1.time_ < 0 + var_475_3 + arg_475_0 and not isNil(var_475_2) and arg_472_1.var_.actorSpriteComps108301 then
				for iter_475_6, iter_475_7 in pairs(arg_472_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_475_7 then
						iter_475_7.color = arg_472_1.isInRecall_ and (arg_472_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_472_1.var_.actorSpriteComps108301 = nil
			end

			local var_475_5 = arg_472_1.actors_["10183"].transform

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos10183 = var_475_5.localPosition
				var_475_5.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("10183", 2)

				for iter_475_8 = 0, var_475_5.childCount - 1 do
					local var_475_6 = var_475_5:GetChild(iter_475_8)

					if var_475_6.name == "split_3" or not string.find(var_475_6.name, "split") then
						var_475_6.gameObject:SetActive(true)
					else
						var_475_6.gameObject:SetActive(false)
					end
				end
			end

			local var_475_7 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_7 then
				var_475_5.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_472_1.time_ - 0) / var_475_7)
			end

			if arg_472_1.time_ >= 0 + var_475_7 and arg_472_1.time_ < 0 + var_475_7 + arg_475_0 then
				var_475_5.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_475_8 = arg_472_1.actors_["104902"].transform

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos104902 = var_475_8.localPosition
				var_475_8.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("104902", 7)

				for iter_475_9 = 0, var_475_8.childCount - 1 do
					local var_475_9 = var_475_8:GetChild(iter_475_9)

					if var_475_9.name == "" or not string.find(var_475_9.name, "split") then
						var_475_9.gameObject:SetActive(true)
					else
						var_475_9.gameObject:SetActive(false)
					end
				end
			end

			local var_475_10 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_10 then
				var_475_8.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_472_1.time_ - 0) / var_475_10)
			end

			if arg_472_1.time_ >= 0 + var_475_10 and arg_472_1.time_ < 0 + var_475_10 + arg_475_0 then
				var_475_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_475_11 = 0
			local var_475_12 = 0.65

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_11 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_13 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(938032115).content)

				arg_472_1.text_.text = var_475_13

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_15 = 26 <= 0 and var_475_12 or var_475_12 * (utf8.len(var_475_13) / 26)

				if (26 <= 0 and var_475_12 or var_475_12 * (utf8.len(var_475_13) / 26)) > 0 and var_475_12 < var_475_15 then
					arg_472_1.talkMaxDuration = var_475_15

					if var_475_15 + var_475_11 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_15 + var_475_11
					end
				end

				arg_472_1.text_.text = var_475_13
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_16 = math.max(var_475_12, arg_472_1.talkMaxDuration)

			if var_475_11 <= arg_472_1.time_ and arg_472_1.time_ < var_475_11 + var_475_16 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_11) / var_475_16

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_11 + var_475_16 and arg_472_1.time_ < var_475_11 + var_475_16 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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

		arg_472_1:InitPlayNodeList()
	end,
	Play938032116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 938032116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play938032117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos10183 = arg_476_1.actors_["10183"].transform.localPosition
				arg_476_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10183", 2)

				for iter_479_0 = 0, arg_476_1.actors_["10183"].transform.childCount - 1 do
					local var_479_0 = arg_476_1.actors_["10183"].transform:GetChild(iter_479_0)

					if var_479_0.name == "split_1" then
						var_479_0:SetAsLastSibling()
						var_479_0.gameObject:SetActive(true)

						arg_476_1.var_.actorSpriteSplit10183 = var_479_0.gameObject:GetComponent(typeof(Image))

						arg_476_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_479_1 = 0.5

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_1 then
				arg_476_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_476_1.time_ - 0) / var_479_1)

				if arg_476_1.var_.actorSpriteSplit10183 ~= nil then
					arg_476_1.var_.actorSpriteSplit10183:SetAlpha((arg_476_1.time_ - 0) / var_479_1)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_1 and arg_476_1.time_ < 0 + var_479_1 + arg_479_0 then
				arg_476_1.actors_["10183"].transform.localPosition = Vector3.New(-300, -475, -325)

				if arg_476_1.var_.actorSpriteSplit10183 ~= nil then
					arg_476_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_479_2 = 0
			local var_479_3 = 0.6

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_2 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_4 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(938032116).content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_6 = 24 <= 0 and var_479_3 or var_479_3 * (utf8.len(var_479_4) / 24)

				if (24 <= 0 and var_479_3 or var_479_3 * (utf8.len(var_479_4) / 24)) > 0 and var_479_3 < var_479_6 then
					arg_476_1.talkMaxDuration = var_479_6

					if var_479_6 + var_479_2 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_2
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_3, arg_476_1.talkMaxDuration)

			if var_479_2 <= arg_476_1.time_ and arg_476_1.time_ < var_479_2 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_2) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_2 + var_479_7 and arg_476_1.time_ < var_479_2 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play938032117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 938032117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play938032118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["10183"]) and arg_480_1.var_.actorSpriteComps10183 == nil then
				arg_480_1.var_.actorSpriteComps10183 = arg_480_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_0 = 0.2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["10183"]) then
				if arg_480_1.var_.actorSpriteComps10183 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								iter_483_1.color = Color.New(Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor2.r, (arg_480_1.time_ - 0) / var_483_0), Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor2.g, (arg_480_1.time_ - 0) / var_483_0), (Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor2.b, (arg_480_1.time_ - 0) / var_483_0)))
							else
								local var_483_1 = Mathf.Lerp(iter_483_1.color.r, 0.5, (arg_480_1.time_ - 0) / var_483_0)

								iter_483_1.color = Color.New(var_483_1, var_483_1, var_483_1)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["10183"]) and arg_480_1.var_.actorSpriteComps10183 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_483_3 then
						iter_483_3.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_480_1.var_.actorSpriteComps10183 = nil
			end

			local var_483_2 = arg_480_1.actors_["10183"].transform

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos10183 = var_483_2.localPosition
				var_483_2.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10183", 7)

				for iter_483_4 = 0, var_483_2.childCount - 1 do
					local var_483_3 = var_483_2:GetChild(iter_483_4)

					if var_483_3.name == "" or not string.find(var_483_3.name, "split") then
						var_483_3.gameObject:SetActive(true)
					else
						var_483_3.gameObject:SetActive(false)
					end
				end
			end

			local var_483_4 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				var_483_2.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_480_1.time_ - 0) / var_483_4)
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				var_483_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_483_5 = arg_480_1.actors_["108301"].transform

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos108301 = var_483_5.localPosition
				var_483_5.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("108301", 7)

				for iter_483_5 = 0, var_483_5.childCount - 1 do
					local var_483_6 = var_483_5:GetChild(iter_483_5)

					if var_483_6.name == "" or not string.find(var_483_6.name, "split") then
						var_483_6.gameObject:SetActive(true)
					else
						var_483_6.gameObject:SetActive(false)
					end
				end
			end

			local var_483_7 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_7 then
				var_483_5.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_480_1.time_ - 0) / var_483_7)
			end

			if arg_480_1.time_ >= 0 + var_483_7 and arg_480_1.time_ < 0 + var_483_7 + arg_483_0 then
				var_483_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_483_8 = 0
			local var_483_9 = 1.425

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_10 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(938032117).content)

				arg_480_1.text_.text = var_483_10

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_12 = 57 <= 0 and var_483_9 or var_483_9 * (utf8.len(var_483_10) / 57)

				if (57 <= 0 and var_483_9 or var_483_9 * (utf8.len(var_483_10) / 57)) > 0 and var_483_9 < var_483_12 then
					arg_480_1.talkMaxDuration = var_483_12

					if var_483_12 + var_483_8 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_12 + var_483_8
					end
				end

				arg_480_1.text_.text = var_483_10
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_13 = math.max(var_483_9, arg_480_1.talkMaxDuration)

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_13 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_8) / var_483_13

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_8 + var_483_13 and arg_480_1.time_ < var_483_8 + var_483_13 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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

		arg_480_1:InitPlayNodeList()
	end,
	Play938032118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 938032118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play938032119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 1.175

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(938032118).content)

				arg_484_1.text_.text = var_487_1

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_3 = 47 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 47)

				if (47 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 47)) > 0 and var_487_0 < var_487_3 then
					arg_484_1.talkMaxDuration = var_487_3

					if var_487_3 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_3 + 0
					end
				end

				arg_484_1.text_.text = var_487_1
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_4 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_4

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play938032119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 938032119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play938032120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["10183"]) and arg_488_1.var_.actorSpriteComps10183 == nil then
				arg_488_1.var_.actorSpriteComps10183 = arg_488_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_0 = 0.2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["10183"]) then
				if arg_488_1.var_.actorSpriteComps10183 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								iter_491_1.color = Color.New(Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor1.r, (arg_488_1.time_ - 0) / var_491_0), Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor1.g, (arg_488_1.time_ - 0) / var_491_0), (Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor1.b, (arg_488_1.time_ - 0) / var_491_0)))
							else
								local var_491_1 = Mathf.Lerp(iter_491_1.color.r, 1, (arg_488_1.time_ - 0) / var_491_0)

								iter_491_1.color = Color.New(var_491_1, var_491_1, var_491_1)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["10183"]) and arg_488_1.var_.actorSpriteComps10183 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_491_3 then
						iter_491_3.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_488_1.var_.actorSpriteComps10183 = nil
			end

			local var_491_2 = arg_488_1.actors_["10183"].transform

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos10183 = var_491_2.localPosition
				var_491_2.localScale = Vector3.New(1, 1, 1)

				arg_488_1:CheckSpriteTmpPos("10183", 3)

				for iter_491_4 = 0, var_491_2.childCount - 1 do
					local var_491_3 = var_491_2:GetChild(iter_491_4)

					if var_491_3.name == "split_5" or not string.find(var_491_3.name, "split") then
						var_491_3.gameObject:SetActive(true)
					else
						var_491_3.gameObject:SetActive(false)
					end
				end
			end

			local var_491_4 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_4 then
				var_491_2.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_488_1.time_ - 0) / var_491_4)
			end

			if arg_488_1.time_ >= 0 + var_491_4 and arg_488_1.time_ < 0 + var_491_4 + arg_491_0 then
				var_491_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_491_5 = 0
			local var_491_6 = 1.05

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_5 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_7 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(938032119).content)

				arg_488_1.text_.text = var_491_7

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_9 = 42 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_7) / 42)

				if (42 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_7) / 42)) > 0 and var_491_6 < var_491_9 then
					arg_488_1.talkMaxDuration = var_491_9

					if var_491_9 + var_491_5 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_9 + var_491_5
					end
				end

				arg_488_1.text_.text = var_491_7
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_6, arg_488_1.talkMaxDuration)

			if var_491_5 <= arg_488_1.time_ and arg_488_1.time_ < var_491_5 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_5) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_5 + var_491_10 and arg_488_1.time_ < var_491_5 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play938032120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 938032120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play938032121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["10183"]) and arg_492_1.var_.actorSpriteComps10183 == nil then
				arg_492_1.var_.actorSpriteComps10183 = arg_492_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_0 = 0.2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["10183"]) then
				if arg_492_1.var_.actorSpriteComps10183 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								iter_495_1.color = Color.New(Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor2.r, (arg_492_1.time_ - 0) / var_495_0), Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor2.g, (arg_492_1.time_ - 0) / var_495_0), (Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor2.b, (arg_492_1.time_ - 0) / var_495_0)))
							else
								local var_495_1 = Mathf.Lerp(iter_495_1.color.r, 0.5, (arg_492_1.time_ - 0) / var_495_0)

								iter_495_1.color = Color.New(var_495_1, var_495_1, var_495_1)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["10183"]) and arg_492_1.var_.actorSpriteComps10183 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_495_3 then
						iter_495_3.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_492_1.var_.actorSpriteComps10183 = nil
			end

			local var_495_2 = 0
			local var_495_3 = 0.3

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_2 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_4 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(938032120).content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_6 = 12 <= 0 and var_495_3 or var_495_3 * (utf8.len(var_495_4) / 12)

				if (12 <= 0 and var_495_3 or var_495_3 * (utf8.len(var_495_4) / 12)) > 0 and var_495_3 < var_495_6 then
					arg_492_1.talkMaxDuration = var_495_6

					if var_495_6 + var_495_2 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_6 + var_495_2
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_7 = math.max(var_495_3, arg_492_1.talkMaxDuration)

			if var_495_2 <= arg_492_1.time_ and arg_492_1.time_ < var_495_2 + var_495_7 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_2) / var_495_7

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_2 + var_495_7 and arg_492_1.time_ < var_495_2 + var_495_7 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play938032121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 938032121
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play938032122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos10183 = arg_496_1.actors_["10183"].transform.localPosition
				arg_496_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10183", 7)

				for iter_499_0 = 0, arg_496_1.actors_["10183"].transform.childCount - 1 do
					local var_499_0 = arg_496_1.actors_["10183"].transform:GetChild(iter_499_0)

					if var_499_0.name == "" or not string.find(var_499_0.name, "split") then
						var_499_0.gameObject:SetActive(true)
					else
						var_499_0.gameObject:SetActive(false)
					end
				end
			end

			local var_499_1 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_1 then
				arg_496_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_496_1.time_ - 0) / var_499_1)
			end

			if arg_496_1.time_ >= 0 + var_499_1 and arg_496_1.time_ < 0 + var_499_1 + arg_499_0 then
				arg_496_1.actors_["10183"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_499_2 = 0
			local var_499_3 = 1.3

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_2 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_4 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(938032121).content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_6 = 52 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_4) / 52)

				if (52 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_4) / 52)) > 0 and var_499_3 < var_499_6 then
					arg_496_1.talkMaxDuration = var_499_6

					if var_499_6 + var_499_2 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_6 + var_499_2
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_3, arg_496_1.talkMaxDuration)

			if var_499_2 <= arg_496_1.time_ and arg_496_1.time_ < var_499_2 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_2) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_2 + var_499_7 and arg_496_1.time_ < var_499_2 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play938032122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 938032122
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play938032123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["10183"]) and arg_500_1.var_.actorSpriteComps10183 == nil then
				arg_500_1.var_.actorSpriteComps10183 = arg_500_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_0 = 0.2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["10183"]) then
				if arg_500_1.var_.actorSpriteComps10183 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								iter_503_1.color = Color.New(Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, (arg_500_1.time_ - 0) / var_503_0), Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, (arg_500_1.time_ - 0) / var_503_0), (Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, (arg_500_1.time_ - 0) / var_503_0)))
							else
								local var_503_1 = Mathf.Lerp(iter_503_1.color.r, 1, (arg_500_1.time_ - 0) / var_503_0)

								iter_503_1.color = Color.New(var_503_1, var_503_1, var_503_1)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["10183"]) and arg_500_1.var_.actorSpriteComps10183 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_503_3 then
						iter_503_3.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_500_1.var_.actorSpriteComps10183 = nil
			end

			local var_503_2 = arg_500_1.actors_["10183"].transform

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.var_.moveOldPos10183 = var_503_2.localPosition
				var_503_2.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10183", 3)

				for iter_503_4 = 0, var_503_2.childCount - 1 do
					local var_503_3 = var_503_2:GetChild(iter_503_4)

					if var_503_3.name == "" or not string.find(var_503_3.name, "split") then
						var_503_3.gameObject:SetActive(true)
					else
						var_503_3.gameObject:SetActive(false)
					end
				end
			end

			local var_503_4 = 0.001

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				var_503_2.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_500_1.time_ - 0) / var_503_4)
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				var_503_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_503_5 = arg_500_1.actors_["10183"].transform

			if 0.2 < arg_500_1.time_ and arg_500_1.time_ <= 0.2 + arg_503_0 then
				arg_500_1.var_.moveOldPos10183 = var_503_5.localPosition
				var_503_5.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10183", 3)

				for iter_503_5 = 0, var_503_5.childCount - 1 do
					local var_503_6 = var_503_5:GetChild(iter_503_5)

					if var_503_6.name == "split_3" then
						var_503_6:SetAsLastSibling()
						var_503_6.gameObject:SetActive(true)

						arg_500_1.var_.actorSpriteSplit10183 = var_503_6.gameObject:GetComponent(typeof(Image))

						arg_500_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_503_7 = 0.5

			if 0.2 <= arg_500_1.time_ and arg_500_1.time_ < 0.2 + var_503_7 then
				var_503_5.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_500_1.time_ - 0.2) / var_503_7)

				if arg_500_1.var_.actorSpriteSplit10183 ~= nil then
					arg_500_1.var_.actorSpriteSplit10183:SetAlpha((arg_500_1.time_ - 0.2) / var_503_7)
				end
			end

			if arg_500_1.time_ >= 0.2 + var_503_7 and arg_500_1.time_ < 0.2 + var_503_7 + arg_503_0 then
				var_503_5.localPosition = Vector3.New(0, -475, -325)

				if arg_500_1.var_.actorSpriteSplit10183 ~= nil then
					arg_500_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_503_8 = 0

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_8 + arg_503_0 then
				arg_500_1.allBtn_.enabled = false
			end

			if arg_500_1.time_ >= var_503_8 + 0.7 and arg_500_1.time_ < var_503_8 + 0.7 + arg_503_0 then
				arg_500_1.allBtn_.enabled = true
			end

			local var_503_9 = 0
			local var_503_10 = 1.5

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_9 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_11 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(938032122).content)

				arg_500_1.text_.text = var_503_11

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_13 = 60 <= 0 and var_503_10 or var_503_10 * (utf8.len(var_503_11) / 60)

				if (60 <= 0 and var_503_10 or var_503_10 * (utf8.len(var_503_11) / 60)) > 0 and var_503_10 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_9 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_9
					end
				end

				arg_500_1.text_.text = var_503_11
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_14 = math.max(var_503_10, arg_500_1.talkMaxDuration)

			if var_503_9 <= arg_500_1.time_ and arg_500_1.time_ < var_503_9 + var_503_14 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_9) / var_503_14

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_9 + var_503_14 and arg_500_1.time_ < var_503_9 + var_503_14 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play938032123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 938032123
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play938032124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["10183"]) and arg_504_1.var_.actorSpriteComps10183 == nil then
				arg_504_1.var_.actorSpriteComps10183 = arg_504_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_507_0 = 0.2

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["10183"]) then
				if arg_504_1.var_.actorSpriteComps10183 then
					for iter_507_0, iter_507_1 in pairs(arg_504_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_507_1 then
							if arg_504_1.isInRecall_ then
								iter_507_1.color = Color.New(Mathf.Lerp(iter_507_1.color.r, arg_504_1.hightColor2.r, (arg_504_1.time_ - 0) / var_507_0), Mathf.Lerp(iter_507_1.color.g, arg_504_1.hightColor2.g, (arg_504_1.time_ - 0) / var_507_0), (Mathf.Lerp(iter_507_1.color.b, arg_504_1.hightColor2.b, (arg_504_1.time_ - 0) / var_507_0)))
							else
								local var_507_1 = Mathf.Lerp(iter_507_1.color.r, 0.5, (arg_504_1.time_ - 0) / var_507_0)

								iter_507_1.color = Color.New(var_507_1, var_507_1, var_507_1)
							end
						end
					end
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["10183"]) and arg_504_1.var_.actorSpriteComps10183 then
				for iter_507_2, iter_507_3 in pairs(arg_504_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_507_3 then
						iter_507_3.color = arg_504_1.isInRecall_ and (arg_504_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_504_1.var_.actorSpriteComps10183 = nil
			end

			local var_507_2 = arg_504_1.actors_["10183"].transform

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.var_.moveOldPos10183 = var_507_2.localPosition
				var_507_2.localScale = Vector3.New(1, 1, 1)

				arg_504_1:CheckSpriteTmpPos("10183", 7)

				for iter_507_4 = 0, var_507_2.childCount - 1 do
					local var_507_3 = var_507_2:GetChild(iter_507_4)

					if var_507_3.name == "" or not string.find(var_507_3.name, "split") then
						var_507_3.gameObject:SetActive(true)
					else
						var_507_3.gameObject:SetActive(false)
					end
				end
			end

			local var_507_4 = 0.001

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				var_507_2.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_504_1.time_ - 0) / var_507_4)
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				var_507_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_507_5 = 0
			local var_507_6 = 1.25

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_5 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_7 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(938032123).content)

				arg_504_1.text_.text = var_507_7

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_9 = 50 <= 0 and var_507_6 or var_507_6 * (utf8.len(var_507_7) / 50)

				if (50 <= 0 and var_507_6 or var_507_6 * (utf8.len(var_507_7) / 50)) > 0 and var_507_6 < var_507_9 then
					arg_504_1.talkMaxDuration = var_507_9

					if var_507_9 + var_507_5 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_9 + var_507_5
					end
				end

				arg_504_1.text_.text = var_507_7
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_6, arg_504_1.talkMaxDuration)

			if var_507_5 <= arg_504_1.time_ and arg_504_1.time_ < var_507_5 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_5) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_5 + var_507_10 and arg_504_1.time_ < var_507_5 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play938032124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 938032124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play938032125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["108301"]) and arg_508_1.var_.actorSpriteComps108301 == nil then
				arg_508_1.var_.actorSpriteComps108301 = arg_508_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_0 = 0.2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["108301"]) then
				if arg_508_1.var_.actorSpriteComps108301 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								iter_511_1.color = Color.New(Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, (arg_508_1.time_ - 0) / var_511_0), Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, (arg_508_1.time_ - 0) / var_511_0), (Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, (arg_508_1.time_ - 0) / var_511_0)))
							else
								local var_511_1 = Mathf.Lerp(iter_511_1.color.r, 1, (arg_508_1.time_ - 0) / var_511_0)

								iter_511_1.color = Color.New(var_511_1, var_511_1, var_511_1)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["108301"]) and arg_508_1.var_.actorSpriteComps108301 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_511_3 then
						iter_511_3.color = arg_508_1.isInRecall_ and (arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_508_1.var_.actorSpriteComps108301 = nil
			end

			local var_511_2 = arg_508_1.actors_["108301"].transform

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos108301 = var_511_2.localPosition
				var_511_2.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("108301", 2)

				for iter_511_4 = 0, var_511_2.childCount - 1 do
					local var_511_3 = var_511_2:GetChild(iter_511_4)

					if var_511_3.name == "split_3" or not string.find(var_511_3.name, "split") then
						var_511_3.gameObject:SetActive(true)
					else
						var_511_3.gameObject:SetActive(false)
					end
				end
			end

			local var_511_4 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 then
				var_511_2.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos108301, Vector3.New(-300, -475, -325), (arg_508_1.time_ - 0) / var_511_4)
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 then
				var_511_2.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_511_5 = 0
			local var_511_6 = 0.125

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_5 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_7 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(938032124).content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 5 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_7) / 5)

				if (5 <= 0 and var_511_6 or var_511_6 * (utf8.len(var_511_7) / 5)) > 0 and var_511_6 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_5 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_5
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_6, arg_508_1.talkMaxDuration)

			if var_511_5 <= arg_508_1.time_ and arg_508_1.time_ < var_511_5 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_5) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_5 + var_511_10 and arg_508_1.time_ < var_511_5 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
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

		arg_508_1:InitPlayNodeList()
	end,
	Play938032125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 938032125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play938032126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["128404"]) and arg_512_1.var_.actorSpriteComps128404 == nil then
				arg_512_1.var_.actorSpriteComps128404 = arg_512_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_0 = 0.2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["128404"]) then
				if arg_512_1.var_.actorSpriteComps128404 then
					for iter_515_0, iter_515_1 in pairs(arg_512_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_515_1 then
							if arg_512_1.isInRecall_ then
								iter_515_1.color = Color.New(Mathf.Lerp(iter_515_1.color.r, arg_512_1.hightColor1.r, (arg_512_1.time_ - 0) / var_515_0), Mathf.Lerp(iter_515_1.color.g, arg_512_1.hightColor1.g, (arg_512_1.time_ - 0) / var_515_0), (Mathf.Lerp(iter_515_1.color.b, arg_512_1.hightColor1.b, (arg_512_1.time_ - 0) / var_515_0)))
							else
								local var_515_1 = Mathf.Lerp(iter_515_1.color.r, 1, (arg_512_1.time_ - 0) / var_515_0)

								iter_515_1.color = Color.New(var_515_1, var_515_1, var_515_1)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["128404"]) and arg_512_1.var_.actorSpriteComps128404 then
				for iter_515_2, iter_515_3 in pairs(arg_512_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_515_3 then
						iter_515_3.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_512_1.var_.actorSpriteComps128404 = nil
			end

			local var_515_2 = arg_512_1.actors_["108301"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps108301 == nil then
				arg_512_1.var_.actorSpriteComps108301 = var_515_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_3 = 0.2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_3 and not isNil(var_515_2) then
				if arg_512_1.var_.actorSpriteComps108301 then
					for iter_515_4, iter_515_5 in pairs(arg_512_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_515_5 then
							if arg_512_1.isInRecall_ then
								iter_515_5.color = Color.New(Mathf.Lerp(iter_515_5.color.r, arg_512_1.hightColor2.r, (arg_512_1.time_ - 0) / var_515_3), Mathf.Lerp(iter_515_5.color.g, arg_512_1.hightColor2.g, (arg_512_1.time_ - 0) / var_515_3), (Mathf.Lerp(iter_515_5.color.b, arg_512_1.hightColor2.b, (arg_512_1.time_ - 0) / var_515_3)))
							else
								local var_515_4 = Mathf.Lerp(iter_515_5.color.r, 0.5, (arg_512_1.time_ - 0) / var_515_3)

								iter_515_5.color = Color.New(var_515_4, var_515_4, var_515_4)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_3 and arg_512_1.time_ < 0 + var_515_3 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps108301 then
				for iter_515_6, iter_515_7 in pairs(arg_512_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_515_7 then
						iter_515_7.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_512_1.var_.actorSpriteComps108301 = nil
			end

			local var_515_5 = arg_512_1.actors_["128404"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos128404 = var_515_5.localPosition
				var_515_5.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("128404", 4)

				for iter_515_8 = 0, var_515_5.childCount - 1 do
					local var_515_6 = var_515_5:GetChild(iter_515_8)

					if var_515_6.name == "split_5" or not string.find(var_515_6.name, "split") then
						var_515_6.gameObject:SetActive(true)
					else
						var_515_6.gameObject:SetActive(false)
					end
				end
			end

			local var_515_7 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_7 then
				var_515_5.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_512_1.time_ - 0) / var_515_7)
			end

			if arg_512_1.time_ >= 0 + var_515_7 and arg_512_1.time_ < 0 + var_515_7 + arg_515_0 then
				var_515_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_515_8 = 0
			local var_515_9 = 0.35

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_8 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_10 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(938032125).content)

				arg_512_1.text_.text = var_515_10

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_12 = 14 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_10) / 14)

				if (14 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_10) / 14)) > 0 and var_515_9 < var_515_12 then
					arg_512_1.talkMaxDuration = var_515_12

					if var_515_12 + var_515_8 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_12 + var_515_8
					end
				end

				arg_512_1.text_.text = var_515_10
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_13 = math.max(var_515_9, arg_512_1.talkMaxDuration)

			if var_515_8 <= arg_512_1.time_ and arg_512_1.time_ < var_515_8 + var_515_13 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_8) / var_515_13

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_8 + var_515_13 and arg_512_1.time_ < var_515_8 + var_515_13 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
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

		arg_512_1:InitPlayNodeList()
	end,
	Play938032126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 938032126
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play938032127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["128404"]) and arg_516_1.var_.actorSpriteComps128404 == nil then
				arg_516_1.var_.actorSpriteComps128404 = arg_516_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_519_0 = 0.2

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["128404"]) then
				if arg_516_1.var_.actorSpriteComps128404 then
					for iter_519_0, iter_519_1 in pairs(arg_516_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_519_1 then
							if arg_516_1.isInRecall_ then
								iter_519_1.color = Color.New(Mathf.Lerp(iter_519_1.color.r, arg_516_1.hightColor2.r, (arg_516_1.time_ - 0) / var_519_0), Mathf.Lerp(iter_519_1.color.g, arg_516_1.hightColor2.g, (arg_516_1.time_ - 0) / var_519_0), (Mathf.Lerp(iter_519_1.color.b, arg_516_1.hightColor2.b, (arg_516_1.time_ - 0) / var_519_0)))
							else
								local var_519_1 = Mathf.Lerp(iter_519_1.color.r, 0.5, (arg_516_1.time_ - 0) / var_519_0)

								iter_519_1.color = Color.New(var_519_1, var_519_1, var_519_1)
							end
						end
					end
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["128404"]) and arg_516_1.var_.actorSpriteComps128404 then
				for iter_519_2, iter_519_3 in pairs(arg_516_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_519_3 then
						iter_519_3.color = arg_516_1.isInRecall_ and (arg_516_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_516_1.var_.actorSpriteComps128404 = nil
			end

			local var_519_2 = arg_516_1.actors_["128404"].transform

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos128404 = var_519_2.localPosition
				var_519_2.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("128404", 7)

				for iter_519_4 = 0, var_519_2.childCount - 1 do
					local var_519_3 = var_519_2:GetChild(iter_519_4)

					if var_519_3.name == "" or not string.find(var_519_3.name, "split") then
						var_519_3.gameObject:SetActive(true)
					else
						var_519_3.gameObject:SetActive(false)
					end
				end
			end

			local var_519_4 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_4 then
				var_519_2.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_516_1.time_ - 0) / var_519_4)
			end

			if arg_516_1.time_ >= 0 + var_519_4 and arg_516_1.time_ < 0 + var_519_4 + arg_519_0 then
				var_519_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_519_5 = arg_516_1.actors_["108301"].transform

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos108301 = var_519_5.localPosition
				var_519_5.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("108301", 7)

				for iter_519_5 = 0, var_519_5.childCount - 1 do
					local var_519_6 = var_519_5:GetChild(iter_519_5)

					if var_519_6.name == "" or not string.find(var_519_6.name, "split") then
						var_519_6.gameObject:SetActive(true)
					else
						var_519_6.gameObject:SetActive(false)
					end
				end
			end

			local var_519_7 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_7 then
				var_519_5.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_516_1.time_ - 0) / var_519_7)
			end

			if arg_516_1.time_ >= 0 + var_519_7 and arg_516_1.time_ < 0 + var_519_7 + arg_519_0 then
				var_519_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_519_8 = 0
			local var_519_9 = 0.375

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_10 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(938032126).content)

				arg_516_1.text_.text = var_519_10

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_12 = 15 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_10) / 15)

				if (15 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_10) / 15)) > 0 and var_519_9 < var_519_12 then
					arg_516_1.talkMaxDuration = var_519_12

					if var_519_12 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_12 + var_519_8
					end
				end

				arg_516_1.text_.text = var_519_10
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_13 = math.max(var_519_9, arg_516_1.talkMaxDuration)

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_13 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_8) / var_519_13

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_8 + var_519_13 and arg_516_1.time_ < var_519_8 + var_519_13 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
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

		arg_516_1:InitPlayNodeList()
	end,
	Play938032127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 938032127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play938032128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["106603"]) and arg_520_1.var_.actorSpriteComps106603 == nil then
				arg_520_1.var_.actorSpriteComps106603 = arg_520_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_0 = 0.2

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["106603"]) then
				if arg_520_1.var_.actorSpriteComps106603 then
					for iter_523_0, iter_523_1 in pairs(arg_520_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_523_1 then
							if arg_520_1.isInRecall_ then
								iter_523_1.color = Color.New(Mathf.Lerp(iter_523_1.color.r, arg_520_1.hightColor1.r, (arg_520_1.time_ - 0) / var_523_0), Mathf.Lerp(iter_523_1.color.g, arg_520_1.hightColor1.g, (arg_520_1.time_ - 0) / var_523_0), (Mathf.Lerp(iter_523_1.color.b, arg_520_1.hightColor1.b, (arg_520_1.time_ - 0) / var_523_0)))
							else
								local var_523_1 = Mathf.Lerp(iter_523_1.color.r, 1, (arg_520_1.time_ - 0) / var_523_0)

								iter_523_1.color = Color.New(var_523_1, var_523_1, var_523_1)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["106603"]) and arg_520_1.var_.actorSpriteComps106603 then
				for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_523_3 then
						iter_523_3.color = arg_520_1.isInRecall_ and (arg_520_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_520_1.var_.actorSpriteComps106603 = nil
			end

			local var_523_2 = arg_520_1.actors_["106603"].transform

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos106603 = var_523_2.localPosition
				var_523_2.localScale = Vector3.New(1, 1, 1)

				arg_520_1:CheckSpriteTmpPos("106603", 2)

				for iter_523_4 = 0, var_523_2.childCount - 1 do
					local var_523_3 = var_523_2:GetChild(iter_523_4)

					if var_523_3.name == "" or not string.find(var_523_3.name, "split") then
						var_523_3.gameObject:SetActive(true)
					else
						var_523_3.gameObject:SetActive(false)
					end
				end
			end

			local var_523_4 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_4 then
				var_523_2.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_520_1.time_ - 0) / var_523_4)
			end

			if arg_520_1.time_ >= 0 + var_523_4 and arg_520_1.time_ < 0 + var_523_4 + arg_523_0 then
				var_523_2.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_523_5 = 0
			local var_523_6 = 0.575

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_5 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_7 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(938032127).content)

				arg_520_1.text_.text = var_523_7

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_9 = 23 <= 0 and var_523_6 or var_523_6 * (utf8.len(var_523_7) / 23)

				if (23 <= 0 and var_523_6 or var_523_6 * (utf8.len(var_523_7) / 23)) > 0 and var_523_6 < var_523_9 then
					arg_520_1.talkMaxDuration = var_523_9

					if var_523_9 + var_523_5 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_9 + var_523_5
					end
				end

				arg_520_1.text_.text = var_523_7
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_6, arg_520_1.talkMaxDuration)

			if var_523_5 <= arg_520_1.time_ and arg_520_1.time_ < var_523_5 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_5) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_5 + var_523_10 and arg_520_1.time_ < var_523_5 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
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

		arg_520_1:InitPlayNodeList()
	end,
	Play938032128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 938032128
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play938032129(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["106603"]) and arg_524_1.var_.actorSpriteComps106603 == nil then
				arg_524_1.var_.actorSpriteComps106603 = arg_524_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_527_0 = 0.2

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["106603"]) then
				if arg_524_1.var_.actorSpriteComps106603 then
					for iter_527_0, iter_527_1 in pairs(arg_524_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_527_1 then
							if arg_524_1.isInRecall_ then
								iter_527_1.color = Color.New(Mathf.Lerp(iter_527_1.color.r, arg_524_1.hightColor2.r, (arg_524_1.time_ - 0) / var_527_0), Mathf.Lerp(iter_527_1.color.g, arg_524_1.hightColor2.g, (arg_524_1.time_ - 0) / var_527_0), (Mathf.Lerp(iter_527_1.color.b, arg_524_1.hightColor2.b, (arg_524_1.time_ - 0) / var_527_0)))
							else
								local var_527_1 = Mathf.Lerp(iter_527_1.color.r, 0.5, (arg_524_1.time_ - 0) / var_527_0)

								iter_527_1.color = Color.New(var_527_1, var_527_1, var_527_1)
							end
						end
					end
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["106603"]) and arg_524_1.var_.actorSpriteComps106603 then
				for iter_527_2, iter_527_3 in pairs(arg_524_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_527_3 then
						iter_527_3.color = arg_524_1.isInRecall_ and (arg_524_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_524_1.var_.actorSpriteComps106603 = nil
			end

			local var_527_2 = arg_524_1.actors_["104902"].transform

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos104902 = var_527_2.localPosition
				var_527_2.localScale = Vector3.New(1, 1, 1)

				arg_524_1:CheckSpriteTmpPos("104902", 4)

				for iter_527_4 = 0, var_527_2.childCount - 1 do
					local var_527_3 = var_527_2:GetChild(iter_527_4)

					if var_527_3.name == "" or not string.find(var_527_3.name, "split") then
						var_527_3.gameObject:SetActive(true)
					else
						var_527_3.gameObject:SetActive(false)
					end
				end
			end

			local var_527_4 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				var_527_2.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_524_1.time_ - 0) / var_527_4)
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				var_527_2.localPosition = Vector3.New(390, -335, -360)
			end

			local var_527_5 = 0
			local var_527_6 = 0.55

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_5 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_7 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(938032128).content)

				arg_524_1.text_.text = var_527_7

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_9 = 22 <= 0 and var_527_6 or var_527_6 * (utf8.len(var_527_7) / 22)

				if (22 <= 0 and var_527_6 or var_527_6 * (utf8.len(var_527_7) / 22)) > 0 and var_527_6 < var_527_9 then
					arg_524_1.talkMaxDuration = var_527_9

					if var_527_9 + var_527_5 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_9 + var_527_5
					end
				end

				arg_524_1.text_.text = var_527_7
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_10 = math.max(var_527_6, arg_524_1.talkMaxDuration)

			if var_527_5 <= arg_524_1.time_ and arg_524_1.time_ < var_527_5 + var_527_10 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_5) / var_527_10

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_5 + var_527_10 and arg_524_1.time_ < var_527_5 + var_527_10 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
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

		arg_524_1:InitPlayNodeList()
	end,
	Play938032129 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 938032129
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play938032130(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(arg_528_1.actors_["104902"]) and arg_528_1.var_.actorSpriteComps104902 == nil then
				arg_528_1.var_.actorSpriteComps104902 = arg_528_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_531_0 = 0.2

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 and not isNil(arg_528_1.actors_["104902"]) then
				if arg_528_1.var_.actorSpriteComps104902 then
					for iter_531_0, iter_531_1 in pairs(arg_528_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_531_1 then
							if arg_528_1.isInRecall_ then
								iter_531_1.color = Color.New(Mathf.Lerp(iter_531_1.color.r, arg_528_1.hightColor1.r, (arg_528_1.time_ - 0) / var_531_0), Mathf.Lerp(iter_531_1.color.g, arg_528_1.hightColor1.g, (arg_528_1.time_ - 0) / var_531_0), (Mathf.Lerp(iter_531_1.color.b, arg_528_1.hightColor1.b, (arg_528_1.time_ - 0) / var_531_0)))
							else
								local var_531_1 = Mathf.Lerp(iter_531_1.color.r, 1, (arg_528_1.time_ - 0) / var_531_0)

								iter_531_1.color = Color.New(var_531_1, var_531_1, var_531_1)
							end
						end
					end
				end
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 and not isNil(arg_528_1.actors_["104902"]) and arg_528_1.var_.actorSpriteComps104902 then
				for iter_531_2, iter_531_3 in pairs(arg_528_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_531_3 then
						iter_531_3.color = arg_528_1.isInRecall_ and (arg_528_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_528_1.var_.actorSpriteComps104902 = nil
			end

			local var_531_2 = 0
			local var_531_3 = 0.575

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_2 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_4 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(938032129).content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_6 = 23 <= 0 and var_531_3 or var_531_3 * (utf8.len(var_531_4) / 23)

				if (23 <= 0 and var_531_3 or var_531_3 * (utf8.len(var_531_4) / 23)) > 0 and var_531_3 < var_531_6 then
					arg_528_1.talkMaxDuration = var_531_6

					if var_531_6 + var_531_2 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_6 + var_531_2
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_3, arg_528_1.talkMaxDuration)

			if var_531_2 <= arg_528_1.time_ and arg_528_1.time_ < var_531_2 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_2) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_2 + var_531_7 and arg_528_1.time_ < var_531_2 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play938032130 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 938032130
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play938032131(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(arg_532_1.actors_["104902"]) and arg_532_1.var_.actorSpriteComps104902 == nil then
				arg_532_1.var_.actorSpriteComps104902 = arg_532_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_535_0 = 0.2

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 and not isNil(arg_532_1.actors_["104902"]) then
				if arg_532_1.var_.actorSpriteComps104902 then
					for iter_535_0, iter_535_1 in pairs(arg_532_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_535_1 then
							if arg_532_1.isInRecall_ then
								iter_535_1.color = Color.New(Mathf.Lerp(iter_535_1.color.r, arg_532_1.hightColor2.r, (arg_532_1.time_ - 0) / var_535_0), Mathf.Lerp(iter_535_1.color.g, arg_532_1.hightColor2.g, (arg_532_1.time_ - 0) / var_535_0), (Mathf.Lerp(iter_535_1.color.b, arg_532_1.hightColor2.b, (arg_532_1.time_ - 0) / var_535_0)))
							else
								local var_535_1 = Mathf.Lerp(iter_535_1.color.r, 0.5, (arg_532_1.time_ - 0) / var_535_0)

								iter_535_1.color = Color.New(var_535_1, var_535_1, var_535_1)
							end
						end
					end
				end
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 and not isNil(arg_532_1.actors_["104902"]) and arg_532_1.var_.actorSpriteComps104902 then
				for iter_535_2, iter_535_3 in pairs(arg_532_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_535_3 then
						iter_535_3.color = arg_532_1.isInRecall_ and (arg_532_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_532_1.var_.actorSpriteComps104902 = nil
			end

			local var_535_2 = 0
			local var_535_3 = 1.025

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_2 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_4 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(938032130).content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_6 = 41 <= 0 and var_535_3 or var_535_3 * (utf8.len(var_535_4) / 41)

				if (41 <= 0 and var_535_3 or var_535_3 * (utf8.len(var_535_4) / 41)) > 0 and var_535_3 < var_535_6 then
					arg_532_1.talkMaxDuration = var_535_6

					if var_535_6 + var_535_2 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_2
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_3, arg_532_1.talkMaxDuration)

			if var_535_2 <= arg_532_1.time_ and arg_532_1.time_ < var_535_2 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_2) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_2 + var_535_7 and arg_532_1.time_ < var_535_2 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play938032131 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 938032131
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play938032132(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.75

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_1 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(938032131).content)

				arg_536_1.text_.text = var_539_1

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_3 = 30 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 30)

				if (30 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 30)) > 0 and var_539_0 < var_539_3 then
					arg_536_1.talkMaxDuration = var_539_3

					if var_539_3 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_3 + 0
					end
				end

				arg_536_1.text_.text = var_539_1
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_4 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_4

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play938032132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 938032132
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play938032133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos104902 = arg_540_1.actors_["104902"].transform.localPosition
				arg_540_1.actors_["104902"].transform.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("104902", 7)

				for iter_543_0 = 0, arg_540_1.actors_["104902"].transform.childCount - 1 do
					local var_543_0 = arg_540_1.actors_["104902"].transform:GetChild(iter_543_0)

					if var_543_0.name == "" or not string.find(var_543_0.name, "split") then
						var_543_0.gameObject:SetActive(true)
					else
						var_543_0.gameObject:SetActive(false)
					end
				end
			end

			local var_543_1 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_1 then
				arg_540_1.actors_["104902"].transform.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_540_1.time_ - 0) / var_543_1)
			end

			if arg_540_1.time_ >= 0 + var_543_1 and arg_540_1.time_ < 0 + var_543_1 + arg_543_0 then
				arg_540_1.actors_["104902"].transform.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_543_2 = arg_540_1.actors_["106603"].transform

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos106603 = var_543_2.localPosition
				var_543_2.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("106603", 7)

				for iter_543_1 = 0, var_543_2.childCount - 1 do
					local var_543_3 = var_543_2:GetChild(iter_543_1)

					if var_543_3.name == "" or not string.find(var_543_3.name, "split") then
						var_543_3.gameObject:SetActive(true)
					else
						var_543_3.gameObject:SetActive(false)
					end
				end
			end

			local var_543_4 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_4 then
				var_543_2.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_540_1.time_ - 0) / var_543_4)
			end

			if arg_540_1.time_ >= 0 + var_543_4 and arg_540_1.time_ < 0 + var_543_4 + arg_543_0 then
				var_543_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_543_5 = 0
			local var_543_6 = 0.975

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_5 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_7 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(938032132).content)

				arg_540_1.text_.text = var_543_7

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_9 = 39 <= 0 and var_543_6 or var_543_6 * (utf8.len(var_543_7) / 39)

				if (39 <= 0 and var_543_6 or var_543_6 * (utf8.len(var_543_7) / 39)) > 0 and var_543_6 < var_543_9 then
					arg_540_1.talkMaxDuration = var_543_9

					if var_543_9 + var_543_5 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_9 + var_543_5
					end
				end

				arg_540_1.text_.text = var_543_7
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_10 = math.max(var_543_6, arg_540_1.talkMaxDuration)

			if var_543_5 <= arg_540_1.time_ and arg_540_1.time_ < var_543_5 + var_543_10 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_5) / var_543_10

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_5 + var_543_10 and arg_540_1.time_ < var_543_5 + var_543_10 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play938032133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 938032133
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play938032134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(arg_544_1.actors_["10144"]) and arg_544_1.var_.actorSpriteComps10144 == nil then
				arg_544_1.var_.actorSpriteComps10144 = arg_544_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_547_0 = 0.2

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 and not isNil(arg_544_1.actors_["10144"]) then
				if arg_544_1.var_.actorSpriteComps10144 then
					for iter_547_0, iter_547_1 in pairs(arg_544_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_547_1 then
							if arg_544_1.isInRecall_ then
								iter_547_1.color = Color.New(Mathf.Lerp(iter_547_1.color.r, arg_544_1.hightColor1.r, (arg_544_1.time_ - 0) / var_547_0), Mathf.Lerp(iter_547_1.color.g, arg_544_1.hightColor1.g, (arg_544_1.time_ - 0) / var_547_0), (Mathf.Lerp(iter_547_1.color.b, arg_544_1.hightColor1.b, (arg_544_1.time_ - 0) / var_547_0)))
							else
								local var_547_1 = Mathf.Lerp(iter_547_1.color.r, 1, (arg_544_1.time_ - 0) / var_547_0)

								iter_547_1.color = Color.New(var_547_1, var_547_1, var_547_1)
							end
						end
					end
				end
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 and not isNil(arg_544_1.actors_["10144"]) and arg_544_1.var_.actorSpriteComps10144 then
				for iter_547_2, iter_547_3 in pairs(arg_544_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_547_3 then
						iter_547_3.color = arg_544_1.isInRecall_ and (arg_544_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_544_1.var_.actorSpriteComps10144 = nil
			end

			local var_547_2 = arg_544_1.actors_["10144"].transform

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos10144 = var_547_2.localPosition
				var_547_2.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("10144", 3)

				for iter_547_4 = 0, var_547_2.childCount - 1 do
					local var_547_3 = var_547_2:GetChild(iter_547_4)

					if var_547_3.name == "split_1" or not string.find(var_547_3.name, "split") then
						var_547_3.gameObject:SetActive(true)
					else
						var_547_3.gameObject:SetActive(false)
					end
				end
			end

			local var_547_4 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_4 then
				var_547_2.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_544_1.time_ - 0) / var_547_4)
			end

			if arg_544_1.time_ >= 0 + var_547_4 and arg_544_1.time_ < 0 + var_547_4 + arg_547_0 then
				var_547_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_547_5 = 0
			local var_547_6 = 1.1

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_5 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_7 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(938032133).content)

				arg_544_1.text_.text = var_547_7

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_9 = 44 <= 0 and var_547_6 or var_547_6 * (utf8.len(var_547_7) / 44)

				if (44 <= 0 and var_547_6 or var_547_6 * (utf8.len(var_547_7) / 44)) > 0 and var_547_6 < var_547_9 then
					arg_544_1.talkMaxDuration = var_547_9

					if var_547_9 + var_547_5 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_9 + var_547_5
					end
				end

				arg_544_1.text_.text = var_547_7
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_6, arg_544_1.talkMaxDuration)

			if var_547_5 <= arg_544_1.time_ and arg_544_1.time_ < var_547_5 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_5) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_5 + var_547_10 and arg_544_1.time_ < var_547_5 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
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

		arg_544_1:InitPlayNodeList()
	end,
	Play938032134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 938032134
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play938032135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["10144"]) and arg_548_1.var_.actorSpriteComps10144 == nil then
				arg_548_1.var_.actorSpriteComps10144 = arg_548_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_0 = 0.2

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["10144"]) then
				if arg_548_1.var_.actorSpriteComps10144 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								iter_551_1.color = Color.New(Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor2.r, (arg_548_1.time_ - 0) / var_551_0), Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor2.g, (arg_548_1.time_ - 0) / var_551_0), (Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor2.b, (arg_548_1.time_ - 0) / var_551_0)))
							else
								local var_551_1 = Mathf.Lerp(iter_551_1.color.r, 0.5, (arg_548_1.time_ - 0) / var_551_0)

								iter_551_1.color = Color.New(var_551_1, var_551_1, var_551_1)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["10144"]) and arg_548_1.var_.actorSpriteComps10144 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_551_3 then
						iter_551_3.color = arg_548_1.isInRecall_ and (arg_548_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_548_1.var_.actorSpriteComps10144 = nil
			end

			local var_551_2 = 0
			local var_551_3 = 0.8

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_2 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_4 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(938032134).content)

				arg_548_1.text_.text = var_551_4

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_6 = 32 <= 0 and var_551_3 or var_551_3 * (utf8.len(var_551_4) / 32)

				if (32 <= 0 and var_551_3 or var_551_3 * (utf8.len(var_551_4) / 32)) > 0 and var_551_3 < var_551_6 then
					arg_548_1.talkMaxDuration = var_551_6

					if var_551_6 + var_551_2 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_2
					end
				end

				arg_548_1.text_.text = var_551_4
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_3, arg_548_1.talkMaxDuration)

			if var_551_2 <= arg_548_1.time_ and arg_548_1.time_ < var_551_2 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_2) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_2 + var_551_7 and arg_548_1.time_ < var_551_2 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play938032135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 938032135
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play938032136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(arg_552_1.actors_["10144"]) and arg_552_1.var_.actorSpriteComps10144 == nil then
				arg_552_1.var_.actorSpriteComps10144 = arg_552_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_555_0 = 0.2

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_0 and not isNil(arg_552_1.actors_["10144"]) then
				if arg_552_1.var_.actorSpriteComps10144 then
					for iter_555_0, iter_555_1 in pairs(arg_552_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_555_1 then
							if arg_552_1.isInRecall_ then
								iter_555_1.color = Color.New(Mathf.Lerp(iter_555_1.color.r, arg_552_1.hightColor1.r, (arg_552_1.time_ - 0) / var_555_0), Mathf.Lerp(iter_555_1.color.g, arg_552_1.hightColor1.g, (arg_552_1.time_ - 0) / var_555_0), (Mathf.Lerp(iter_555_1.color.b, arg_552_1.hightColor1.b, (arg_552_1.time_ - 0) / var_555_0)))
							else
								local var_555_1 = Mathf.Lerp(iter_555_1.color.r, 1, (arg_552_1.time_ - 0) / var_555_0)

								iter_555_1.color = Color.New(var_555_1, var_555_1, var_555_1)
							end
						end
					end
				end
			end

			if arg_552_1.time_ >= 0 + var_555_0 and arg_552_1.time_ < 0 + var_555_0 + arg_555_0 and not isNil(arg_552_1.actors_["10144"]) and arg_552_1.var_.actorSpriteComps10144 then
				for iter_555_2, iter_555_3 in pairs(arg_552_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_555_3 then
						iter_555_3.color = arg_552_1.isInRecall_ and (arg_552_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_552_1.var_.actorSpriteComps10144 = nil
			end

			local var_555_2 = arg_552_1.actors_["10144"].transform

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.var_.moveOldPos10144 = var_555_2.localPosition
				var_555_2.localScale = Vector3.New(1, 1, 1)

				arg_552_1:CheckSpriteTmpPos("10144", 3)

				for iter_555_4 = 0, var_555_2.childCount - 1 do
					local var_555_3 = var_555_2:GetChild(iter_555_4)

					if var_555_3.name == "split_2" or not string.find(var_555_3.name, "split") then
						var_555_3.gameObject:SetActive(true)
					else
						var_555_3.gameObject:SetActive(false)
					end
				end
			end

			local var_555_4 = 0.001

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				var_555_2.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_552_1.time_ - 0) / var_555_4)
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				var_555_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_555_5 = 0
			local var_555_6 = 1.1

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_5 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_7 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(938032135).content)

				arg_552_1.text_.text = var_555_7

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_9 = 44 <= 0 and var_555_6 or var_555_6 * (utf8.len(var_555_7) / 44)

				if (44 <= 0 and var_555_6 or var_555_6 * (utf8.len(var_555_7) / 44)) > 0 and var_555_6 < var_555_9 then
					arg_552_1.talkMaxDuration = var_555_9

					if var_555_9 + var_555_5 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_9 + var_555_5
					end
				end

				arg_552_1.text_.text = var_555_7
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_10 = math.max(var_555_6, arg_552_1.talkMaxDuration)

			if var_555_5 <= arg_552_1.time_ and arg_552_1.time_ < var_555_5 + var_555_10 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_5) / var_555_10

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_5 + var_555_10 and arg_552_1.time_ < var_555_5 + var_555_10 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
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

		arg_552_1:InitPlayNodeList()
	end,
	Play938032136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 938032136
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play938032137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["104902"]) and arg_556_1.var_.actorSpriteComps104902 == nil then
				arg_556_1.var_.actorSpriteComps104902 = arg_556_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_0 = 0.2

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["104902"]) then
				if arg_556_1.var_.actorSpriteComps104902 then
					for iter_559_0, iter_559_1 in pairs(arg_556_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_559_1 then
							if arg_556_1.isInRecall_ then
								iter_559_1.color = Color.New(Mathf.Lerp(iter_559_1.color.r, arg_556_1.hightColor1.r, (arg_556_1.time_ - 0) / var_559_0), Mathf.Lerp(iter_559_1.color.g, arg_556_1.hightColor1.g, (arg_556_1.time_ - 0) / var_559_0), (Mathf.Lerp(iter_559_1.color.b, arg_556_1.hightColor1.b, (arg_556_1.time_ - 0) / var_559_0)))
							else
								local var_559_1 = Mathf.Lerp(iter_559_1.color.r, 1, (arg_556_1.time_ - 0) / var_559_0)

								iter_559_1.color = Color.New(var_559_1, var_559_1, var_559_1)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["104902"]) and arg_556_1.var_.actorSpriteComps104902 then
				for iter_559_2, iter_559_3 in pairs(arg_556_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_559_3 then
						iter_559_3.color = arg_556_1.isInRecall_ and (arg_556_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_556_1.var_.actorSpriteComps104902 = nil
			end

			local var_559_2 = arg_556_1.actors_["10144"]

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.actorSpriteComps10144 == nil then
				arg_556_1.var_.actorSpriteComps10144 = var_559_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_559_3 = 0.2

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_3 and not isNil(var_559_2) then
				if arg_556_1.var_.actorSpriteComps10144 then
					for iter_559_4, iter_559_5 in pairs(arg_556_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_559_5 then
							if arg_556_1.isInRecall_ then
								iter_559_5.color = Color.New(Mathf.Lerp(iter_559_5.color.r, arg_556_1.hightColor2.r, (arg_556_1.time_ - 0) / var_559_3), Mathf.Lerp(iter_559_5.color.g, arg_556_1.hightColor2.g, (arg_556_1.time_ - 0) / var_559_3), (Mathf.Lerp(iter_559_5.color.b, arg_556_1.hightColor2.b, (arg_556_1.time_ - 0) / var_559_3)))
							else
								local var_559_4 = Mathf.Lerp(iter_559_5.color.r, 0.5, (arg_556_1.time_ - 0) / var_559_3)

								iter_559_5.color = Color.New(var_559_4, var_559_4, var_559_4)
							end
						end
					end
				end
			end

			if arg_556_1.time_ >= 0 + var_559_3 and arg_556_1.time_ < 0 + var_559_3 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.actorSpriteComps10144 then
				for iter_559_6, iter_559_7 in pairs(arg_556_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_559_7 then
						iter_559_7.color = arg_556_1.isInRecall_ and (arg_556_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_556_1.var_.actorSpriteComps10144 = nil
			end

			local var_559_5 = arg_556_1.actors_["104902"].transform

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos104902 = var_559_5.localPosition
				var_559_5.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("104902", 2)

				for iter_559_8 = 0, var_559_5.childCount - 1 do
					local var_559_6 = var_559_5:GetChild(iter_559_8)

					if var_559_6.name == "" or not string.find(var_559_6.name, "split") then
						var_559_6.gameObject:SetActive(true)
					else
						var_559_6.gameObject:SetActive(false)
					end
				end
			end

			local var_559_7 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				var_559_5.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_556_1.time_ - 0) / var_559_7)
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				var_559_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_559_8 = arg_556_1.actors_["10144"].transform

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos10144 = var_559_8.localPosition
				var_559_8.localScale = Vector3.New(1, 1, 1)

				arg_556_1:CheckSpriteTmpPos("10144", 7)

				for iter_559_9 = 0, var_559_8.childCount - 1 do
					local var_559_9 = var_559_8:GetChild(iter_559_9)

					if var_559_9.name == "" or not string.find(var_559_9.name, "split") then
						var_559_9.gameObject:SetActive(true)
					else
						var_559_9.gameObject:SetActive(false)
					end
				end
			end

			local var_559_10 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_10 then
				var_559_8.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_556_1.time_ - 0) / var_559_10)
			end

			if arg_556_1.time_ >= 0 + var_559_10 and arg_556_1.time_ < 0 + var_559_10 + arg_559_0 then
				var_559_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_559_11 = 0
			local var_559_12 = 0.4

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_11 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_13 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(938032136).content)

				arg_556_1.text_.text = var_559_13

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_15 = 16 <= 0 and var_559_12 or var_559_12 * (utf8.len(var_559_13) / 16)

				if (16 <= 0 and var_559_12 or var_559_12 * (utf8.len(var_559_13) / 16)) > 0 and var_559_12 < var_559_15 then
					arg_556_1.talkMaxDuration = var_559_15

					if var_559_15 + var_559_11 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_15 + var_559_11
					end
				end

				arg_556_1.text_.text = var_559_13
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_16 = math.max(var_559_12, arg_556_1.talkMaxDuration)

			if var_559_11 <= arg_556_1.time_ and arg_556_1.time_ < var_559_11 + var_559_16 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_11) / var_559_16

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_11 + var_559_16 and arg_556_1.time_ < var_559_11 + var_559_16 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play938032137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 938032137
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play938032138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["128404"]) and arg_560_1.var_.actorSpriteComps128404 == nil then
				arg_560_1.var_.actorSpriteComps128404 = arg_560_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_0 = 0.2

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["128404"]) then
				if arg_560_1.var_.actorSpriteComps128404 then
					for iter_563_0, iter_563_1 in pairs(arg_560_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_563_1 then
							if arg_560_1.isInRecall_ then
								iter_563_1.color = Color.New(Mathf.Lerp(iter_563_1.color.r, arg_560_1.hightColor1.r, (arg_560_1.time_ - 0) / var_563_0), Mathf.Lerp(iter_563_1.color.g, arg_560_1.hightColor1.g, (arg_560_1.time_ - 0) / var_563_0), (Mathf.Lerp(iter_563_1.color.b, arg_560_1.hightColor1.b, (arg_560_1.time_ - 0) / var_563_0)))
							else
								local var_563_1 = Mathf.Lerp(iter_563_1.color.r, 1, (arg_560_1.time_ - 0) / var_563_0)

								iter_563_1.color = Color.New(var_563_1, var_563_1, var_563_1)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["128404"]) and arg_560_1.var_.actorSpriteComps128404 then
				for iter_563_2, iter_563_3 in pairs(arg_560_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_563_3 then
						iter_563_3.color = arg_560_1.isInRecall_ and (arg_560_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_560_1.var_.actorSpriteComps128404 = nil
			end

			local var_563_2 = arg_560_1.actors_["104902"]

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(var_563_2) and arg_560_1.var_.actorSpriteComps104902 == nil then
				arg_560_1.var_.actorSpriteComps104902 = var_563_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_3 = 0.2

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_3 and not isNil(var_563_2) then
				if arg_560_1.var_.actorSpriteComps104902 then
					for iter_563_4, iter_563_5 in pairs(arg_560_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_563_5 then
							if arg_560_1.isInRecall_ then
								iter_563_5.color = Color.New(Mathf.Lerp(iter_563_5.color.r, arg_560_1.hightColor2.r, (arg_560_1.time_ - 0) / var_563_3), Mathf.Lerp(iter_563_5.color.g, arg_560_1.hightColor2.g, (arg_560_1.time_ - 0) / var_563_3), (Mathf.Lerp(iter_563_5.color.b, arg_560_1.hightColor2.b, (arg_560_1.time_ - 0) / var_563_3)))
							else
								local var_563_4 = Mathf.Lerp(iter_563_5.color.r, 0.5, (arg_560_1.time_ - 0) / var_563_3)

								iter_563_5.color = Color.New(var_563_4, var_563_4, var_563_4)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= 0 + var_563_3 and arg_560_1.time_ < 0 + var_563_3 + arg_563_0 and not isNil(var_563_2) and arg_560_1.var_.actorSpriteComps104902 then
				for iter_563_6, iter_563_7 in pairs(arg_560_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_563_7 then
						iter_563_7.color = arg_560_1.isInRecall_ and (arg_560_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_560_1.var_.actorSpriteComps104902 = nil
			end

			local var_563_5 = arg_560_1.actors_["128404"].transform

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.var_.moveOldPos128404 = var_563_5.localPosition
				var_563_5.localScale = Vector3.New(1, 1, 1)

				arg_560_1:CheckSpriteTmpPos("128404", 4)

				for iter_563_8 = 0, var_563_5.childCount - 1 do
					local var_563_6 = var_563_5:GetChild(iter_563_8)

					if var_563_6.name == "split_6" or not string.find(var_563_6.name, "split") then
						var_563_6.gameObject:SetActive(true)
					else
						var_563_6.gameObject:SetActive(false)
					end
				end
			end

			local var_563_7 = 0.001

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				var_563_5.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_560_1.time_ - 0) / var_563_7)
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				var_563_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_563_8 = 0
			local var_563_9 = 0.65

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_8 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_10 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(938032137).content)

				arg_560_1.text_.text = var_563_10

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_12 = 26 <= 0 and var_563_9 or var_563_9 * (utf8.len(var_563_10) / 26)

				if (26 <= 0 and var_563_9 or var_563_9 * (utf8.len(var_563_10) / 26)) > 0 and var_563_9 < var_563_12 then
					arg_560_1.talkMaxDuration = var_563_12

					if var_563_12 + var_563_8 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_12 + var_563_8
					end
				end

				arg_560_1.text_.text = var_563_10
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_13 = math.max(var_563_9, arg_560_1.talkMaxDuration)

			if var_563_8 <= arg_560_1.time_ and arg_560_1.time_ < var_563_8 + var_563_13 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_8) / var_563_13

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_8 + var_563_13 and arg_560_1.time_ < var_563_8 + var_563_13 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
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

		arg_560_1:InitPlayNodeList()
	end,
	Play938032138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 938032138
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play938032139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["10144"]) and arg_564_1.var_.actorSpriteComps10144 == nil then
				arg_564_1.var_.actorSpriteComps10144 = arg_564_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_0 = 0.2

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["10144"]) then
				if arg_564_1.var_.actorSpriteComps10144 then
					for iter_567_0, iter_567_1 in pairs(arg_564_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_567_1 then
							if arg_564_1.isInRecall_ then
								iter_567_1.color = Color.New(Mathf.Lerp(iter_567_1.color.r, arg_564_1.hightColor1.r, (arg_564_1.time_ - 0) / var_567_0), Mathf.Lerp(iter_567_1.color.g, arg_564_1.hightColor1.g, (arg_564_1.time_ - 0) / var_567_0), (Mathf.Lerp(iter_567_1.color.b, arg_564_1.hightColor1.b, (arg_564_1.time_ - 0) / var_567_0)))
							else
								local var_567_1 = Mathf.Lerp(iter_567_1.color.r, 1, (arg_564_1.time_ - 0) / var_567_0)

								iter_567_1.color = Color.New(var_567_1, var_567_1, var_567_1)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["10144"]) and arg_564_1.var_.actorSpriteComps10144 then
				for iter_567_2, iter_567_3 in pairs(arg_564_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_567_3 then
						iter_567_3.color = arg_564_1.isInRecall_ and (arg_564_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_564_1.var_.actorSpriteComps10144 = nil
			end

			local var_567_2 = arg_564_1.actors_["128404"]

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(var_567_2) and arg_564_1.var_.actorSpriteComps128404 == nil then
				arg_564_1.var_.actorSpriteComps128404 = var_567_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_3 = 0.2

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_3 and not isNil(var_567_2) then
				if arg_564_1.var_.actorSpriteComps128404 then
					for iter_567_4, iter_567_5 in pairs(arg_564_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_567_5 then
							if arg_564_1.isInRecall_ then
								iter_567_5.color = Color.New(Mathf.Lerp(iter_567_5.color.r, arg_564_1.hightColor2.r, (arg_564_1.time_ - 0) / var_567_3), Mathf.Lerp(iter_567_5.color.g, arg_564_1.hightColor2.g, (arg_564_1.time_ - 0) / var_567_3), (Mathf.Lerp(iter_567_5.color.b, arg_564_1.hightColor2.b, (arg_564_1.time_ - 0) / var_567_3)))
							else
								local var_567_4 = Mathf.Lerp(iter_567_5.color.r, 0.5, (arg_564_1.time_ - 0) / var_567_3)

								iter_567_5.color = Color.New(var_567_4, var_567_4, var_567_4)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= 0 + var_567_3 and arg_564_1.time_ < 0 + var_567_3 + arg_567_0 and not isNil(var_567_2) and arg_564_1.var_.actorSpriteComps128404 then
				for iter_567_6, iter_567_7 in pairs(arg_564_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_567_7 then
						iter_567_7.color = arg_564_1.isInRecall_ and (arg_564_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_564_1.var_.actorSpriteComps128404 = nil
			end

			local var_567_5 = arg_564_1.actors_["128404"].transform

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos128404 = var_567_5.localPosition
				var_567_5.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("128404", 7)

				for iter_567_8 = 0, var_567_5.childCount - 1 do
					local var_567_6 = var_567_5:GetChild(iter_567_8)

					if var_567_6.name == "" or not string.find(var_567_6.name, "split") then
						var_567_6.gameObject:SetActive(true)
					else
						var_567_6.gameObject:SetActive(false)
					end
				end
			end

			local var_567_7 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_7 then
				var_567_5.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_564_1.time_ - 0) / var_567_7)
			end

			if arg_564_1.time_ >= 0 + var_567_7 and arg_564_1.time_ < 0 + var_567_7 + arg_567_0 then
				var_567_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_567_8 = arg_564_1.actors_["10144"].transform

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos10144 = var_567_8.localPosition
				var_567_8.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("10144", 3)

				for iter_567_9 = 0, var_567_8.childCount - 1 do
					local var_567_9 = var_567_8:GetChild(iter_567_9)

					if var_567_9.name == "" or not string.find(var_567_9.name, "split") then
						var_567_9.gameObject:SetActive(true)
					else
						var_567_9.gameObject:SetActive(false)
					end
				end
			end

			local var_567_10 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_10 then
				var_567_8.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_564_1.time_ - 0) / var_567_10)
			end

			if arg_564_1.time_ >= 0 + var_567_10 and arg_564_1.time_ < 0 + var_567_10 + arg_567_0 then
				var_567_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_567_11 = arg_564_1.actors_["104902"].transform

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos104902 = var_567_11.localPosition
				var_567_11.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("104902", 7)

				for iter_567_10 = 0, var_567_11.childCount - 1 do
					local var_567_12 = var_567_11:GetChild(iter_567_10)

					if var_567_12.name == "" or not string.find(var_567_12.name, "split") then
						var_567_12.gameObject:SetActive(true)
					else
						var_567_12.gameObject:SetActive(false)
					end
				end
			end

			local var_567_13 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_13 then
				var_567_11.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_564_1.time_ - 0) / var_567_13)
			end

			if arg_564_1.time_ >= 0 + var_567_13 and arg_564_1.time_ < 0 + var_567_13 + arg_567_0 then
				var_567_11.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_567_14 = 0
			local var_567_15 = 0.5

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_14 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_16 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(938032138).content)

				arg_564_1.text_.text = var_567_16

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_18 = 20 <= 0 and var_567_15 or var_567_15 * (utf8.len(var_567_16) / 20)

				if (20 <= 0 and var_567_15 or var_567_15 * (utf8.len(var_567_16) / 20)) > 0 and var_567_15 < var_567_18 then
					arg_564_1.talkMaxDuration = var_567_18

					if var_567_18 + var_567_14 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_18 + var_567_14
					end
				end

				arg_564_1.text_.text = var_567_16
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_19 = math.max(var_567_15, arg_564_1.talkMaxDuration)

			if var_567_14 <= arg_564_1.time_ and arg_564_1.time_ < var_567_14 + var_567_19 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_14) / var_567_19

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_14 + var_567_19 and arg_564_1.time_ < var_567_14 + var_567_19 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
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

		arg_564_1:InitPlayNodeList()
	end,
	Play938032139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 938032139
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play938032140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.var_.moveOldPos10144 = arg_568_1.actors_["10144"].transform.localPosition
				arg_568_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_568_1:CheckSpriteTmpPos("10144", 3)

				for iter_571_0 = 0, arg_568_1.actors_["10144"].transform.childCount - 1 do
					local var_571_0 = arg_568_1.actors_["10144"].transform:GetChild(iter_571_0)

					if var_571_0.name == "" or not string.find(var_571_0.name, "split") then
						var_571_0.gameObject:SetActive(true)
					else
						var_571_0.gameObject:SetActive(false)
					end
				end
			end

			local var_571_1 = 0.001

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_1 then
				arg_568_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_568_1.time_ - 0) / var_571_1)
			end

			if arg_568_1.time_ >= 0 + var_571_1 and arg_568_1.time_ < 0 + var_571_1 + arg_571_0 then
				arg_568_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_571_2 = 0
			local var_571_3 = 1.1

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_2 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_4 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(938032139).content)

				arg_568_1.text_.text = var_571_4

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_6 = 44 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_4) / 44)

				if (44 <= 0 and var_571_3 or var_571_3 * (utf8.len(var_571_4) / 44)) > 0 and var_571_3 < var_571_6 then
					arg_568_1.talkMaxDuration = var_571_6

					if var_571_6 + var_571_2 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_6 + var_571_2
					end
				end

				arg_568_1.text_.text = var_571_4
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_7 = math.max(var_571_3, arg_568_1.talkMaxDuration)

			if var_571_2 <= arg_568_1.time_ and arg_568_1.time_ < var_571_2 + var_571_7 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_2) / var_571_7

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_2 + var_571_7 and arg_568_1.time_ < var_571_2 + var_571_7 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
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

		arg_568_1:InitPlayNodeList()
	end,
	Play938032140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 938032140
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play938032141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(arg_572_1.actors_["10144"]) and arg_572_1.var_.actorSpriteComps10144 == nil then
				arg_572_1.var_.actorSpriteComps10144 = arg_572_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_0 = 0.2

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 and not isNil(arg_572_1.actors_["10144"]) then
				if arg_572_1.var_.actorSpriteComps10144 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								iter_575_1.color = Color.New(Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor2.r, (arg_572_1.time_ - 0) / var_575_0), Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor2.g, (arg_572_1.time_ - 0) / var_575_0), (Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor2.b, (arg_572_1.time_ - 0) / var_575_0)))
							else
								local var_575_1 = Mathf.Lerp(iter_575_1.color.r, 0.5, (arg_572_1.time_ - 0) / var_575_0)

								iter_575_1.color = Color.New(var_575_1, var_575_1, var_575_1)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 and not isNil(arg_572_1.actors_["10144"]) and arg_572_1.var_.actorSpriteComps10144 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_575_3 then
						iter_575_3.color = arg_572_1.isInRecall_ and (arg_572_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_572_1.var_.actorSpriteComps10144 = nil
			end

			local var_575_2 = 0
			local var_575_3 = 0.275

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_2 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_4 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(938032140).content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_6 = 11 <= 0 and var_575_3 or var_575_3 * (utf8.len(var_575_4) / 11)

				if (11 <= 0 and var_575_3 or var_575_3 * (utf8.len(var_575_4) / 11)) > 0 and var_575_3 < var_575_6 then
					arg_572_1.talkMaxDuration = var_575_6

					if var_575_6 + var_575_2 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_6 + var_575_2
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_7 = math.max(var_575_3, arg_572_1.talkMaxDuration)

			if var_575_2 <= arg_572_1.time_ and arg_572_1.time_ < var_575_2 + var_575_7 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_2) / var_575_7

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_2 + var_575_7 and arg_572_1.time_ < var_575_2 + var_575_7 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play938032141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 938032141
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play938032142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(arg_576_1.actors_["10144"]) and arg_576_1.var_.actorSpriteComps10144 == nil then
				arg_576_1.var_.actorSpriteComps10144 = arg_576_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_0 = 0.2

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 and not isNil(arg_576_1.actors_["10144"]) then
				if arg_576_1.var_.actorSpriteComps10144 then
					for iter_579_0, iter_579_1 in pairs(arg_576_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_579_1 then
							if arg_576_1.isInRecall_ then
								iter_579_1.color = Color.New(Mathf.Lerp(iter_579_1.color.r, arg_576_1.hightColor1.r, (arg_576_1.time_ - 0) / var_579_0), Mathf.Lerp(iter_579_1.color.g, arg_576_1.hightColor1.g, (arg_576_1.time_ - 0) / var_579_0), (Mathf.Lerp(iter_579_1.color.b, arg_576_1.hightColor1.b, (arg_576_1.time_ - 0) / var_579_0)))
							else
								local var_579_1 = Mathf.Lerp(iter_579_1.color.r, 1, (arg_576_1.time_ - 0) / var_579_0)

								iter_579_1.color = Color.New(var_579_1, var_579_1, var_579_1)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 and not isNil(arg_576_1.actors_["10144"]) and arg_576_1.var_.actorSpriteComps10144 then
				for iter_579_2, iter_579_3 in pairs(arg_576_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_579_3 then
						iter_579_3.color = arg_576_1.isInRecall_ and (arg_576_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_576_1.var_.actorSpriteComps10144 = nil
			end

			local var_579_2 = arg_576_1.actors_["10144"].transform

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1.var_.moveOldPos10144 = var_579_2.localPosition
				var_579_2.localScale = Vector3.New(1, 1, 1)

				arg_576_1:CheckSpriteTmpPos("10144", 3)

				for iter_579_4 = 0, var_579_2.childCount - 1 do
					local var_579_3 = var_579_2:GetChild(iter_579_4)

					if var_579_3.name == "split_7" or not string.find(var_579_3.name, "split") then
						var_579_3.gameObject:SetActive(true)
					else
						var_579_3.gameObject:SetActive(false)
					end
				end
			end

			local var_579_4 = 0.001

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_4 then
				var_579_2.localPosition = Vector3.Lerp(arg_576_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_576_1.time_ - 0) / var_579_4)
			end

			if arg_576_1.time_ >= 0 + var_579_4 and arg_576_1.time_ < 0 + var_579_4 + arg_579_0 then
				var_579_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_579_5 = 0
			local var_579_6 = 0.725

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_5 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_7 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(938032141).content)

				arg_576_1.text_.text = var_579_7

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_9 = 29 <= 0 and var_579_6 or var_579_6 * (utf8.len(var_579_7) / 29)

				if (29 <= 0 and var_579_6 or var_579_6 * (utf8.len(var_579_7) / 29)) > 0 and var_579_6 < var_579_9 then
					arg_576_1.talkMaxDuration = var_579_9

					if var_579_9 + var_579_5 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_9 + var_579_5
					end
				end

				arg_576_1.text_.text = var_579_7
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_10 = math.max(var_579_6, arg_576_1.talkMaxDuration)

			if var_579_5 <= arg_576_1.time_ and arg_576_1.time_ < var_579_5 + var_579_10 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_5) / var_579_10

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_5 + var_579_10 and arg_576_1.time_ < var_579_5 + var_579_10 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {
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

		arg_576_1:InitPlayNodeList()
	end,
	Play938032142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 938032142
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play938032143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.var_.moveOldPos10144 = arg_580_1.actors_["10144"].transform.localPosition
				arg_580_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_580_1:CheckSpriteTmpPos("10144", 3)

				for iter_583_0 = 0, arg_580_1.actors_["10144"].transform.childCount - 1 do
					local var_583_0 = arg_580_1.actors_["10144"].transform:GetChild(iter_583_0)

					if var_583_0.name == "" then
						var_583_0:SetAsLastSibling()
						var_583_0.gameObject:SetActive(true)

						arg_580_1.var_.actorSpriteSplit10144 = var_583_0.gameObject:GetComponent(typeof(Image))

						arg_580_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_583_1 = 0.5

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_1 then
				arg_580_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_580_1.time_ - 0) / var_583_1)

				if arg_580_1.var_.actorSpriteSplit10144 ~= nil then
					arg_580_1.var_.actorSpriteSplit10144:SetAlpha((arg_580_1.time_ - 0) / var_583_1)
				end
			end

			if arg_580_1.time_ >= 0 + var_583_1 and arg_580_1.time_ < 0 + var_583_1 + arg_583_0 then
				arg_580_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_580_1.var_.actorSpriteSplit10144 ~= nil then
					arg_580_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_583_2 = 0
			local var_583_3 = 0.325

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_2 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_4 = arg_580_1:FormatText(arg_580_1:GetWordFromCfg(938032142).content)

				arg_580_1.text_.text = var_583_4

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_6 = 13 <= 0 and var_583_3 or var_583_3 * (utf8.len(var_583_4) / 13)

				if (13 <= 0 and var_583_3 or var_583_3 * (utf8.len(var_583_4) / 13)) > 0 and var_583_3 < var_583_6 then
					arg_580_1.talkMaxDuration = var_583_6

					if var_583_6 + var_583_2 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_6 + var_583_2
					end
				end

				arg_580_1.text_.text = var_583_4
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_7 = math.max(var_583_3, arg_580_1.talkMaxDuration)

			if var_583_2 <= arg_580_1.time_ and arg_580_1.time_ < var_583_2 + var_583_7 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_2) / var_583_7

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_2 + var_583_7 and arg_580_1.time_ < var_583_2 + var_583_7 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
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

		arg_580_1:InitPlayNodeList()
	end,
	Play938032143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 938032143
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play938032144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(arg_584_1.actors_["10144"]) and arg_584_1.var_.actorSpriteComps10144 == nil then
				arg_584_1.var_.actorSpriteComps10144 = arg_584_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_587_0 = 0.2

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 and not isNil(arg_584_1.actors_["10144"]) then
				if arg_584_1.var_.actorSpriteComps10144 then
					for iter_587_0, iter_587_1 in pairs(arg_584_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_587_1 then
							if arg_584_1.isInRecall_ then
								iter_587_1.color = Color.New(Mathf.Lerp(iter_587_1.color.r, arg_584_1.hightColor2.r, (arg_584_1.time_ - 0) / var_587_0), Mathf.Lerp(iter_587_1.color.g, arg_584_1.hightColor2.g, (arg_584_1.time_ - 0) / var_587_0), (Mathf.Lerp(iter_587_1.color.b, arg_584_1.hightColor2.b, (arg_584_1.time_ - 0) / var_587_0)))
							else
								local var_587_1 = Mathf.Lerp(iter_587_1.color.r, 0.5, (arg_584_1.time_ - 0) / var_587_0)

								iter_587_1.color = Color.New(var_587_1, var_587_1, var_587_1)
							end
						end
					end
				end
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 and not isNil(arg_584_1.actors_["10144"]) and arg_584_1.var_.actorSpriteComps10144 then
				for iter_587_2, iter_587_3 in pairs(arg_584_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_587_3 then
						iter_587_3.color = arg_584_1.isInRecall_ and (arg_584_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_584_1.var_.actorSpriteComps10144 = nil
			end

			local var_587_2 = arg_584_1.actors_["10144"].transform

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.var_.moveOldPos10144 = var_587_2.localPosition
				var_587_2.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("10144", 7)

				for iter_587_4 = 0, var_587_2.childCount - 1 do
					local var_587_3 = var_587_2:GetChild(iter_587_4)

					if var_587_3.name == "" or not string.find(var_587_3.name, "split") then
						var_587_3.gameObject:SetActive(true)
					else
						var_587_3.gameObject:SetActive(false)
					end
				end
			end

			local var_587_4 = 0.001

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_4 then
				var_587_2.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_584_1.time_ - 0) / var_587_4)
			end

			if arg_584_1.time_ >= 0 + var_587_4 and arg_584_1.time_ < 0 + var_587_4 + arg_587_0 then
				var_587_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_587_5 = 0
			local var_587_6 = 1.25

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_5 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_7 = arg_584_1:FormatText(arg_584_1:GetWordFromCfg(938032143).content)

				arg_584_1.text_.text = var_587_7

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_9 = 50 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_7) / 50)

				if (50 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_7) / 50)) > 0 and var_587_6 < var_587_9 then
					arg_584_1.talkMaxDuration = var_587_9

					if var_587_9 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_9 + var_587_5
					end
				end

				arg_584_1.text_.text = var_587_7
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_10 = math.max(var_587_6, arg_584_1.talkMaxDuration)

			if var_587_5 <= arg_584_1.time_ and arg_584_1.time_ < var_587_5 + var_587_10 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_5) / var_587_10

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_5 + var_587_10 and arg_584_1.time_ < var_587_5 + var_587_10 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play938032144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 938032144
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
			arg_588_1.auto_ = false
		end

		function arg_588_1.playNext_(arg_590_0)
			arg_588_1.onStoryFinished_()
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 and not isNil(arg_588_1.actors_["104902"]) and arg_588_1.var_.actorSpriteComps104902 == nil then
				arg_588_1.var_.actorSpriteComps104902 = arg_588_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_0 = 0.2

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_0 and not isNil(arg_588_1.actors_["104902"]) then
				if arg_588_1.var_.actorSpriteComps104902 then
					for iter_591_0, iter_591_1 in pairs(arg_588_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_591_1 then
							if arg_588_1.isInRecall_ then
								iter_591_1.color = Color.New(Mathf.Lerp(iter_591_1.color.r, arg_588_1.hightColor1.r, (arg_588_1.time_ - 0) / var_591_0), Mathf.Lerp(iter_591_1.color.g, arg_588_1.hightColor1.g, (arg_588_1.time_ - 0) / var_591_0), (Mathf.Lerp(iter_591_1.color.b, arg_588_1.hightColor1.b, (arg_588_1.time_ - 0) / var_591_0)))
							else
								local var_591_1 = Mathf.Lerp(iter_591_1.color.r, 1, (arg_588_1.time_ - 0) / var_591_0)

								iter_591_1.color = Color.New(var_591_1, var_591_1, var_591_1)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= 0 + var_591_0 and arg_588_1.time_ < 0 + var_591_0 + arg_591_0 and not isNil(arg_588_1.actors_["104902"]) and arg_588_1.var_.actorSpriteComps104902 then
				for iter_591_2, iter_591_3 in pairs(arg_588_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_591_3 then
						iter_591_3.color = arg_588_1.isInRecall_ and (arg_588_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_588_1.var_.actorSpriteComps104902 = nil
			end

			local var_591_2 = arg_588_1.actors_["104902"].transform

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.var_.moveOldPos104902 = var_591_2.localPosition
				var_591_2.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("104902", 3)

				for iter_591_4 = 0, var_591_2.childCount - 1 do
					local var_591_3 = var_591_2:GetChild(iter_591_4)

					if var_591_3.name == "split_2" or not string.find(var_591_3.name, "split") then
						var_591_3.gameObject:SetActive(true)
					else
						var_591_3.gameObject:SetActive(false)
					end
				end
			end

			local var_591_4 = 0.001

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_4 then
				var_591_2.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos104902, Vector3.New(0, -335, -360), (arg_588_1.time_ - 0) / var_591_4)
			end

			if arg_588_1.time_ >= 0 + var_591_4 and arg_588_1.time_ < 0 + var_591_4 + arg_591_0 then
				var_591_2.localPosition = Vector3.New(0, -335, -360)
			end

			local var_591_5 = 0
			local var_591_6 = 0.725

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_5 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_7 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(938032144).content)

				arg_588_1.text_.text = var_591_7

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_9 = 29 <= 0 and var_591_6 or var_591_6 * (utf8.len(var_591_7) / 29)

				if (29 <= 0 and var_591_6 or var_591_6 * (utf8.len(var_591_7) / 29)) > 0 and var_591_6 < var_591_9 then
					arg_588_1.talkMaxDuration = var_591_9

					if var_591_9 + var_591_5 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_9 + var_591_5
					end
				end

				arg_588_1.text_.text = var_591_7
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_10 = math.max(var_591_6, arg_588_1.talkMaxDuration)

			if var_591_5 <= arg_588_1.time_ and arg_588_1.time_ < var_591_5 + var_591_10 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_5) / var_591_10

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_5 + var_591_10 and arg_588_1.time_ < var_591_5 + var_591_10 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
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

		arg_588_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
