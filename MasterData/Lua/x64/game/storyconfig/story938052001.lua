return {
	Play938052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938052002(arg_1_1)
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

			local var_4_9 = "10144"

			if arg_1_1.actors_["10144"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_4_12 = arg_1_1.actors_["10144"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			local var_4_15 = arg_1_1.actors_["10144"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

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
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 1.999999999999
			local var_4_23 = 1

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938052001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 40 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 40)

				if (40 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 40)) > 0 and var_4_23 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_22 = var_4_22 + 0.3

					if var_4_27 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_22 + 0.3
			local var_4_29 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938052002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["10144"]) and arg_8_1.var_.actorSpriteComps10144 == nil then
				arg_8_1.var_.actorSpriteComps10144 = arg_8_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["10144"]) then
				if arg_8_1.var_.actorSpriteComps10144 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["10144"]) and arg_8_1.var_.actorSpriteComps10144 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_11_3 then
						iter_11_3.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps10144 = nil
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

				local var_11_4 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938052002).content)

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
	Play938052003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938052003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938052004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["10144"]) and arg_12_1.var_.actorSpriteComps10144 == nil then
				arg_12_1.var_.actorSpriteComps10144 = arg_12_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["10144"]) then
				if arg_12_1.var_.actorSpriteComps10144 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["10144"]) and arg_12_1.var_.actorSpriteComps10144 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps10144 = nil
			end

			local var_15_2 = arg_12_1.actors_["10144"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10144 = var_15_2.localPosition
				var_15_2.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10144", 3)

				for iter_15_4 = 0, var_15_2.childCount - 1 do
					local var_15_3 = var_15_2:GetChild(iter_15_4)

					if var_15_3.name == "split_2" then
						var_15_3:SetAsLastSibling()
						var_15_3.gameObject:SetActive(true)

						arg_12_1.var_.actorSpriteSplit10144 = var_15_3.gameObject:GetComponent(typeof(Image))

						arg_12_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_15_4 = 0.5

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_2.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_12_1.time_ - 0) / var_15_4)

				if arg_12_1.var_.actorSpriteSplit10144 ~= nil then
					arg_12_1.var_.actorSpriteSplit10144:SetAlpha((arg_12_1.time_ - 0) / var_15_4)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_12_1.var_.actorSpriteSplit10144 ~= nil then
					arg_12_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_15_5 = 0
			local var_15_6 = 0.6

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_7 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938052003).content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 24 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 24)

				if (24 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 24)) > 0 and var_15_6 < var_15_9 then
					arg_12_1.talkMaxDuration = var_15_9

					if var_15_9 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_5
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_6, arg_12_1.talkMaxDuration)

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_5) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_5 + var_15_10 and arg_12_1.time_ < var_15_5 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play938052004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938052004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938052005(arg_16_1)
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
								iter_19_1.color = Color.New(Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, (arg_16_1.time_ - 0) / var_19_0), Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, (arg_16_1.time_ - 0) / var_19_0), (Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, (arg_16_1.time_ - 0) / var_19_0)))
							else
								local var_19_1 = Mathf.Lerp(iter_19_1.color.r, 0.5, (arg_16_1.time_ - 0) / var_19_0)

								iter_19_1.color = Color.New(var_19_1, var_19_1, var_19_1)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["10144"]) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_2 = arg_16_1.actors_["10144"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10144 = var_19_2.localPosition
				var_19_2.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10144", 7)

				for iter_19_4 = 0, var_19_2.childCount - 1 do
					local var_19_3 = var_19_2:GetChild(iter_19_4)

					if var_19_3.name == "" or not string.find(var_19_3.name, "split") then
						var_19_3.gameObject:SetActive(true)
					else
						var_19_3.gameObject:SetActive(false)
					end
				end
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_2.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_16_1.time_ - 0) / var_19_4)
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_19_5 = 0
			local var_19_6 = 0.475

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_7 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938052004).content)

				arg_16_1.text_.text = var_19_7

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 19 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 19)

				if (19 <= 0 and var_19_6 or var_19_6 * (utf8.len(var_19_7) / 19)) > 0 and var_19_6 < var_19_9 then
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
	Play938052005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938052005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938052006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["106603"] == nil then
				local var_23_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_23_0) then
					local var_23_1 = Object.Instantiate(var_23_0, arg_20_1.canvasGo_.transform)

					var_23_1.transform:SetSiblingIndex(1)

					var_23_1.name = "106603"
					var_23_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_["106603"] = var_23_1

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs((var_23_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_2 = arg_20_1.actors_["106603"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps106603 == nil then
				arg_20_1.var_.actorSpriteComps106603 = var_23_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_3 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.actorSpriteComps106603 then
					for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.actorSpriteComps106603 then
				for iter_23_4, iter_23_5 in pairs(arg_20_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_23_5 then
						iter_23_5.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps106603 = nil
			end

			local var_23_5 = arg_20_1.actors_["106603"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos106603 = var_23_5.localPosition
				var_23_5.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("106603", 3)

				for iter_23_6 = 0, var_23_5.childCount - 1 do
					local var_23_6 = var_23_5:GetChild(iter_23_6)

					if var_23_6.name == "split_6" or not string.find(var_23_6.name, "split") then
						var_23_6.gameObject:SetActive(true)
					else
						var_23_6.gameObject:SetActive(false)
					end
				end
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_20_1.time_ - 0) / var_23_7)
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_23_8 = 0
			local var_23_9 = 0.975

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938052005).content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_12 = 39 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_10) / 39)

				if (39 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_10) / 39)) > 0 and var_23_9 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_13 and arg_20_1.time_ < var_23_8 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play938052006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938052006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938052007(arg_24_1)
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
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["106603"]) and arg_24_1.var_.actorSpriteComps106603 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps106603 = nil
			end

			local var_27_2 = 0
			local var_27_3 = 0.325

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

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938052006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 13 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 13)

				if (13 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 13)) > 0 and var_27_3 < var_27_6 then
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
	Play938052007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938052007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938052008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["106603"]) and arg_28_1.var_.actorSpriteComps106603 == nil then
				arg_28_1.var_.actorSpriteComps106603 = arg_28_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["106603"]) then
				if arg_28_1.var_.actorSpriteComps106603 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["106603"]) and arg_28_1.var_.actorSpriteComps106603 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps106603 = nil
			end

			local var_31_2 = arg_28_1.actors_["106603"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos106603 = var_31_2.localPosition
				var_31_2.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("106603", 3)

				for iter_31_4 = 0, var_31_2.childCount - 1 do
					local var_31_3 = var_31_2:GetChild(iter_31_4)

					if var_31_3.name == "split_1" then
						var_31_3:SetAsLastSibling()
						var_31_3.gameObject:SetActive(true)

						arg_28_1.var_.actorSpriteSplit106603 = var_31_3.gameObject:GetComponent(typeof(Image))

						arg_28_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_31_4 = 0.5

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_2.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_28_1.time_ - 0) / var_31_4)

				if arg_28_1.var_.actorSpriteSplit106603 ~= nil then
					arg_28_1.var_.actorSpriteSplit106603:SetAlpha((arg_28_1.time_ - 0) / var_31_4)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_28_1.var_.actorSpriteSplit106603 ~= nil then
					arg_28_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_31_5 = 0
			local var_31_6 = 0.75

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938052007).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 30 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 30)

				if (30 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 30)) > 0 and var_31_6 < var_31_9 then
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
				actorName = "106603",
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
	Play938052008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938052008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938052009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10144"]) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = arg_32_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10144"]) then
				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10144"]) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_2 = arg_32_1.actors_["106603"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps106603 == nil then
				arg_32_1.var_.actorSpriteComps106603 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps106603 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps106603 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_35_7 then
						iter_35_7.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps106603 = nil
			end

			local var_35_5 = arg_32_1.actors_["10144"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10144 = var_35_5.localPosition
				var_35_5.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10144", 4)

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
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_32_1.time_ - 0) / var_35_7)
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_35_8 = arg_32_1.actors_["106603"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos106603 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("106603", 2)

				for iter_35_9 = 0, var_35_8.childCount - 1 do
					local var_35_9 = var_35_8:GetChild(iter_35_9)

					if var_35_9.name == "" or not string.find(var_35_9.name, "split") then
						var_35_9.gameObject:SetActive(true)
					else
						var_35_9.gameObject:SetActive(false)
					end
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_32_1.time_ - 0) / var_35_10)
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_35_11 = 0
			local var_35_12 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938052008).content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 20 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_13) / 20)

				if (20 <= 0 and var_35_12 or var_35_12 * (utf8.len(var_35_13) / 20)) > 0 and var_35_12 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_16 and arg_32_1.time_ < var_35_11 + var_35_16 + arg_35_0 then
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
				actorName = "106603",
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
	Play938052009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938052009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938052010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["106603"]) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = arg_36_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["106603"]) then
				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["106603"]) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_2 = arg_36_1.actors_["10144"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10144 == nil then
				arg_36_1.var_.actorSpriteComps10144 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps10144 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10144 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps10144 = nil
			end

			local var_39_5 = arg_36_1.actors_["106603"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_5.localPosition
				var_39_5.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 2)

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
				var_39_5.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_36_1.time_ - 0) / var_39_7)
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_39_8 = 0
			local var_39_9 = 1.3

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
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

				local var_39_10 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938052009).content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 52 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 52)

				if (52 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_10) / 52)) > 0 and var_39_9 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_13 and arg_36_1.time_ < var_39_8 + var_39_13 + arg_39_0 then
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
	Play938052010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938052010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938052011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos106603 = arg_40_1.actors_["106603"].transform.localPosition
				arg_40_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("106603", 2)

				for iter_43_0 = 0, arg_40_1.actors_["106603"].transform.childCount - 1 do
					local var_43_0 = arg_40_1.actors_["106603"].transform:GetChild(iter_43_0)

					if var_43_0.name == "split_5" then
						var_43_0:SetAsLastSibling()
						var_43_0.gameObject:SetActive(true)

						arg_40_1.var_.actorSpriteSplit106603 = var_43_0.gameObject:GetComponent(typeof(Image))

						arg_40_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_43_1 = 0.5

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_40_1.time_ - 0) / var_43_1)

				if arg_40_1.var_.actorSpriteSplit106603 ~= nil then
					arg_40_1.var_.actorSpriteSplit106603:SetAlpha((arg_40_1.time_ - 0) / var_43_1)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["106603"].transform.localPosition = Vector3.New(-510.9, -399.1, -303.3)

				if arg_40_1.var_.actorSpriteSplit106603 ~= nil then
					arg_40_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_43_2 = 0
			local var_43_3 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(938052010).content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 9 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_4) / 9)

				if (9 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_4) / 9)) > 0 and var_43_3 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_7 and arg_40_1.time_ < var_43_2 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play938052011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938052011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938052012(arg_44_1)
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
								iter_47_1.color = Color.New(Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_0), Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_0), (Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_0)))
							else
								local var_47_1 = Mathf.Lerp(iter_47_1.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_0)

								iter_47_1.color = Color.New(var_47_1, var_47_1, var_47_1)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["106603"]) and arg_44_1.var_.actorSpriteComps106603 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps106603 = nil
			end

			local var_47_2 = arg_44_1.actors_["106603"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos106603 = var_47_2.localPosition
				var_47_2.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("106603", 7)

				for iter_47_4 = 0, var_47_2.childCount - 1 do
					local var_47_3 = var_47_2:GetChild(iter_47_4)

					if var_47_3.name == "" or not string.find(var_47_3.name, "split") then
						var_47_3.gameObject:SetActive(true)
					else
						var_47_3.gameObject:SetActive(false)
					end
				end
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_2.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_44_1.time_ - 0) / var_47_4)
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_47_5 = arg_44_1.actors_["10144"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10144 = var_47_5.localPosition
				var_47_5.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("10144", 7)

				for iter_47_5 = 0, var_47_5.childCount - 1 do
					local var_47_6 = var_47_5:GetChild(iter_47_5)

					if var_47_6.name == "" or not string.find(var_47_6.name, "split") then
						var_47_6.gameObject:SetActive(true)
					else
						var_47_6.gameObject:SetActive(false)
					end
				end
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_44_1.time_ - 0) / var_47_7)
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_47_8 = 0
			local var_47_9 = 1.075

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(938052011).content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_12 = 43 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_10) / 43)

				if (43 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_10) / 43)) > 0 and var_47_9 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_13 and arg_44_1.time_ < var_47_8 + var_47_13 + arg_47_0 then
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

		arg_44_1:InitPlayNodeList()
	end,
	Play938052012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938052012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938052013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10144"]) and arg_48_1.var_.actorSpriteComps10144 == nil then
				arg_48_1.var_.actorSpriteComps10144 = arg_48_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10144"]) then
				if arg_48_1.var_.actorSpriteComps10144 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10144"]) and arg_48_1.var_.actorSpriteComps10144 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps10144 = nil
			end

			local var_51_2 = arg_48_1.actors_["10144"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10144 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10144", 2)

				for iter_51_4 = 0, var_51_2.childCount - 1 do
					local var_51_3 = var_51_2:GetChild(iter_51_4)

					if var_51_3.name == "split_7" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_51_5 = 0
			local var_51_6 = 0.25

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(938052012).content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 10 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 10)

				if (10 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 10)) > 0 and var_51_6 < var_51_9 then
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
				actorName = "10144",
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
	Play938052013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938052013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938052014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["106603"]) and arg_52_1.var_.actorSpriteComps106603 == nil then
				arg_52_1.var_.actorSpriteComps106603 = arg_52_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["106603"]) then
				if arg_52_1.var_.actorSpriteComps106603 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["106603"]) and arg_52_1.var_.actorSpriteComps106603 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps106603 = nil
			end

			local var_55_2 = arg_52_1.actors_["10144"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps10144 == nil then
				arg_52_1.var_.actorSpriteComps10144 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps10144 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps10144 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps10144 = nil
			end

			local var_55_5 = arg_52_1.actors_["106603"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos106603 = var_55_5.localPosition
				var_55_5.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("106603", 4)

				for iter_55_8 = 0, var_55_5.childCount - 1 do
					local var_55_6 = var_55_5:GetChild(iter_55_8)

					if var_55_6.name == "split_4" or not string.find(var_55_6.name, "split") then
						var_55_6.gameObject:SetActive(true)
					else
						var_55_6.gameObject:SetActive(false)
					end
				end
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_52_1.time_ - 0) / var_55_7)
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_55_8 = 0
			local var_55_9 = 0.25

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

				local var_55_10 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(938052013).content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 10 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_10) / 10)

				if (10 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_10) / 10)) > 0 and var_55_9 < var_55_12 then
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
	Play938052014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938052014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938052015(arg_56_1)
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

			local var_59_2 = arg_56_1.actors_["106603"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos106603 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("106603", 7)

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
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_5 = arg_56_1.actors_["10144"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10144 = var_59_5.localPosition
				var_59_5.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10144", 7)

				for iter_59_5 = 0, var_59_5.childCount - 1 do
					local var_59_6 = var_59_5:GetChild(iter_59_5)

					if var_59_6.name == "" or not string.find(var_59_6.name, "split") then
						var_59_6.gameObject:SetActive(true)
					else
						var_59_6.gameObject:SetActive(false)
					end
				end
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_56_1.time_ - 0) / var_59_7)
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_8 = 0
			local var_59_9 = 1.325

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(938052014).content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 53 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_10) / 53)

				if (53 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_10) / 53)) > 0 and var_59_9 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12

					if var_59_12 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_13 and arg_56_1.time_ < var_59_8 + var_59_13 + arg_59_0 then
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

		arg_56_1:InitPlayNodeList()
	end,
	Play938052015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938052015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938052016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.2

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
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

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(938052015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 8 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 8)

				if (8 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 8)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play938052016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938052016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938052017(arg_64_1)
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

					if var_67_3.name == "split_6" or not string.find(var_67_3.name, "split") then
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
			local var_67_6 = 0.075

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

				local var_67_7 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(938052016).content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 3 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 3)

				if (3 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 3)) > 0 and var_67_6 < var_67_9 then
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
	Play938052017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938052017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938052018(arg_68_1)
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
			local var_71_3 = 0.25

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

				local var_71_4 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(938052017).content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 10 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 10)

				if (10 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 10)) > 0 and var_71_3 < var_71_6 then
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
	Play938052018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938052018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938052019(arg_72_1)
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

					if var_75_3.name == "split_4" then
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
			local var_75_6 = 0.175

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

				local var_75_7 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(938052018).content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 7 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 7)

				if (7 <= 0 and var_75_6 or var_75_6 * (utf8.len(var_75_7) / 7)) > 0 and var_75_6 < var_75_9 then
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
	Play938052019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938052019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938052020(arg_76_1)
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
			local var_79_6 = 0.65

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

				local var_79_7 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(938052019).content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 26 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_7) / 26)

				if (26 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_7) / 26)) > 0 and var_79_6 < var_79_9 then
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
	Play938052020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938052020
		arg_80_1.duration_ = 5.2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938052021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_83_0 = 0.5

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				local var_83_1, var_83_2 = math.modf((arg_80_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_83_2 * 0.13, var_83_2 * 0.13, var_83_2 * 0.13) + arg_80_1.var_.shakeOldPos
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				manager.ui.mainCamera.transform.localPosition = arg_80_1.var_.shakeOldPos
			end

			local var_83_3 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_3 + 0.5 and arg_80_1.time_ < var_83_3 + 0.5 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_4 = 0.2
			local var_83_5 = 0.3

			if 0.2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_6 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_6:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_7 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(938052020).content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 12 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 12)

				if (12 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 12)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9
					var_83_4 = var_83_4 + 0.3

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = var_83_4 + 0.3
			local var_83_11 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play938052021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938052021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938052022(arg_86_1)
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
			local var_89_6 = 0.5

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

				local var_89_7 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(938052021).content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 20 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 20)

				if (20 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 20)) > 0 and var_89_6 < var_89_9 then
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
	Play938052022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938052022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938052023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10144"]) and arg_90_1.var_.actorSpriteComps10144 == nil then
				arg_90_1.var_.actorSpriteComps10144 = arg_90_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10144"]) then
				if arg_90_1.var_.actorSpriteComps10144 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10144"]) and arg_90_1.var_.actorSpriteComps10144 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps10144 = nil
			end

			local var_93_2 = arg_90_1.actors_["10144"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10144 = var_93_2.localPosition
				var_93_2.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10144", 7)

				for iter_93_4 = 0, var_93_2.childCount - 1 do
					local var_93_3 = var_93_2:GetChild(iter_93_4)

					if var_93_3.name == "" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_90_1.time_ - 0) / var_93_4)
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_93_5 = 0
			local var_93_6 = 0.5

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_7 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(938052022).content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 20 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 20)

				if (20 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 20)) > 0 and var_93_6 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_10 and arg_90_1.time_ < var_93_5 + var_93_10 + arg_93_0 then
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
	Play938052023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938052023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938052024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["106603"]) and arg_94_1.var_.actorSpriteComps106603 == nil then
				arg_94_1.var_.actorSpriteComps106603 = arg_94_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["106603"]) then
				if arg_94_1.var_.actorSpriteComps106603 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["106603"]) and arg_94_1.var_.actorSpriteComps106603 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps106603 = nil
			end

			local var_97_2 = arg_94_1.actors_["106603"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos106603 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("106603", 3)

				for iter_97_4 = 0, var_97_2.childCount - 1 do
					local var_97_3 = var_97_2:GetChild(iter_97_4)

					if var_97_3.name == "" or not string.find(var_97_3.name, "split") then
						var_97_3.gameObject:SetActive(true)
					else
						var_97_3.gameObject:SetActive(false)
					end
				end
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_94_1.time_ - 0) / var_97_4)
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_97_5 = 0
			local var_97_6 = 0.775

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(938052023).content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 31 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 31)

				if (31 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 31)) > 0 and var_97_6 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_10 and arg_94_1.time_ < var_97_5 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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
	Play938052024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938052024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938052025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos106603 = arg_98_1.actors_["106603"].transform.localPosition
				arg_98_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("106603", 3)

				for iter_101_0 = 0, arg_98_1.actors_["106603"].transform.childCount - 1 do
					local var_101_0 = arg_98_1.actors_["106603"].transform:GetChild(iter_101_0)

					if var_101_0.name == "split_6" or not string.find(var_101_0.name, "split") then
						var_101_0.gameObject:SetActive(true)
					else
						var_101_0.gameObject:SetActive(false)
					end
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_98_1.time_ - 0) / var_101_1)
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["106603"].transform.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_101_2 = 0
			local var_101_3 = 0.55

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(938052024).content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 22 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 22)

				if (22 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 22)) > 0 and var_101_3 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_7 and arg_98_1.time_ < var_101_2 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play938052025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938052025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938052026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["106603"]) and arg_102_1.var_.actorSpriteComps106603 == nil then
				arg_102_1.var_.actorSpriteComps106603 = arg_102_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["106603"]) then
				if arg_102_1.var_.actorSpriteComps106603 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["106603"]) and arg_102_1.var_.actorSpriteComps106603 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps106603 = nil
			end

			local var_105_2 = arg_102_1.actors_["106603"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos106603 = var_105_2.localPosition
				var_105_2.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("106603", 7)

				for iter_105_4 = 0, var_105_2.childCount - 1 do
					local var_105_3 = var_105_2:GetChild(iter_105_4)

					if var_105_3.name == "" or not string.find(var_105_3.name, "split") then
						var_105_3.gameObject:SetActive(true)
					else
						var_105_3.gameObject:SetActive(false)
					end
				end
			end

			local var_105_4 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				var_105_2.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_102_1.time_ - 0) / var_105_4)
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				var_105_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_105_5 = 0
			local var_105_6 = 0.9

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(938052025).content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 36 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 36)

				if (36 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 36)) > 0 and var_105_6 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_10 and arg_102_1.time_ < var_105_5 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938052026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938052026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938052027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if arg_106_1.actors_["108301"] == nil then
				local var_109_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_109_0) then
					local var_109_1 = Object.Instantiate(var_109_0, arg_106_1.canvasGo_.transform)

					var_109_1.transform:SetSiblingIndex(1)

					var_109_1.name = "108301"
					var_109_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_106_1.actors_["108301"] = var_109_1

					if arg_106_1.isInRecall_ then
						for iter_109_0, iter_109_1 in ipairs((var_109_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_109_1.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_109_2 = arg_106_1.actors_["108301"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps108301 == nil then
				arg_106_1.var_.actorSpriteComps108301 = var_109_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.actorSpriteComps108301 then
					for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_109_3 then
							if arg_106_1.isInRecall_ then
								iter_109_3.color = Color.New(Mathf.Lerp(iter_109_3.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_3), Mathf.Lerp(iter_109_3.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_3), (Mathf.Lerp(iter_109_3.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_3)))
							else
								local var_109_4 = Mathf.Lerp(iter_109_3.color.r, 1, (arg_106_1.time_ - 0) / var_109_3)

								iter_109_3.color = Color.New(var_109_4, var_109_4, var_109_4)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps108301 then
				for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_109_5 then
						iter_109_5.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps108301 = nil
			end

			local var_109_5 = arg_106_1.actors_["108301"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_5.localPosition
				var_109_5.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 2)

				for iter_109_6 = 0, var_109_5.childCount - 1 do
					local var_109_6 = var_109_5:GetChild(iter_109_6)

					if var_109_6.name == "split_6" or not string.find(var_109_6.name, "split") then
						var_109_6.gameObject:SetActive(true)
					else
						var_109_6.gameObject:SetActive(false)
					end
				end
			end

			local var_109_7 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, Vector3.New(-420, -360, -195), (arg_106_1.time_ - 0) / var_109_7)
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_109_8 = 0
			local var_109_9 = 0.45

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(938052026).content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_12 = 18 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 18)

				if (18 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 18)) > 0 and var_109_9 < var_109_12 then
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
	Play938052027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938052027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938052028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.actors_["128404"] == nil then
				local var_113_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_113_0) then
					local var_113_1 = Object.Instantiate(var_113_0, arg_110_1.canvasGo_.transform)

					var_113_1.transform:SetSiblingIndex(1)

					var_113_1.name = "128404"
					var_113_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_110_1.actors_["128404"] = var_113_1

					if arg_110_1.isInRecall_ then
						for iter_113_0, iter_113_1 in ipairs((var_113_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_113_1.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_113_2 = arg_110_1.actors_["128404"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps128404 == nil then
				arg_110_1.var_.actorSpriteComps128404 = var_113_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_3 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.actorSpriteComps128404 then
					for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_113_3 then
							if arg_110_1.isInRecall_ then
								iter_113_3.color = Color.New(Mathf.Lerp(iter_113_3.color.r, arg_110_1.hightColor1.r, (arg_110_1.time_ - 0) / var_113_3), Mathf.Lerp(iter_113_3.color.g, arg_110_1.hightColor1.g, (arg_110_1.time_ - 0) / var_113_3), (Mathf.Lerp(iter_113_3.color.b, arg_110_1.hightColor1.b, (arg_110_1.time_ - 0) / var_113_3)))
							else
								local var_113_4 = Mathf.Lerp(iter_113_3.color.r, 1, (arg_110_1.time_ - 0) / var_113_3)

								iter_113_3.color = Color.New(var_113_4, var_113_4, var_113_4)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.actorSpriteComps128404 then
				for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_113_5 then
						iter_113_5.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_110_1.var_.actorSpriteComps128404 = nil
			end

			local var_113_5 = arg_110_1.actors_["108301"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = var_113_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_6 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_6 and not isNil(var_113_5) then
				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_7 then
							if arg_110_1.isInRecall_ then
								iter_113_7.color = Color.New(Mathf.Lerp(iter_113_7.color.r, arg_110_1.hightColor2.r, (arg_110_1.time_ - 0) / var_113_6), Mathf.Lerp(iter_113_7.color.g, arg_110_1.hightColor2.g, (arg_110_1.time_ - 0) / var_113_6), (Mathf.Lerp(iter_113_7.color.b, arg_110_1.hightColor2.b, (arg_110_1.time_ - 0) / var_113_6)))
							else
								local var_113_7 = Mathf.Lerp(iter_113_7.color.r, 0.5, (arg_110_1.time_ - 0) / var_113_6)

								iter_113_7.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_6 and arg_110_1.time_ < 0 + var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_8, iter_113_9 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_9 then
						iter_113_9.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_8 = arg_110_1.actors_["128404"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos128404 = var_113_8.localPosition
				var_113_8.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("128404", 4)

				for iter_113_10 = 0, var_113_8.childCount - 1 do
					local var_113_9 = var_113_8:GetChild(iter_113_10)

					if var_113_9.name == "split_8" or not string.find(var_113_9.name, "split") then
						var_113_9.gameObject:SetActive(true)
					else
						var_113_9.gameObject:SetActive(false)
					end
				end
			end

			local var_113_10 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_10 then
				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_110_1.time_ - 0) / var_113_10)
			end

			if arg_110_1.time_ >= 0 + var_113_10 and arg_110_1.time_ < 0 + var_113_10 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_113_11 = 0
			local var_113_12 = 0.55

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
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

				local var_113_13 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(938052027).content)

				arg_110_1.text_.text = var_113_13

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 22 <= 0 and var_113_12 or var_113_12 * (utf8.len(var_113_13) / 22)

				if (22 <= 0 and var_113_12 or var_113_12 * (utf8.len(var_113_13) / 22)) > 0 and var_113_12 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_11
					end
				end

				arg_110_1.text_.text = var_113_13
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_12, arg_110_1.talkMaxDuration)

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_11) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_11 + var_113_16 and arg_110_1.time_ < var_113_11 + var_113_16 + arg_113_0 then
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
	Play938052028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938052028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938052029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.actors_["104902"] == nil then
				local var_117_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_117_0) then
					local var_117_1 = Object.Instantiate(var_117_0, arg_114_1.canvasGo_.transform)

					var_117_1.transform:SetSiblingIndex(1)

					var_117_1.name = "104902"
					var_117_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_114_1.actors_["104902"] = var_117_1

					if arg_114_1.isInRecall_ then
						for iter_117_0, iter_117_1 in ipairs((var_117_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_117_1.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_117_2 = arg_114_1.actors_["104902"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps104902 == nil then
				arg_114_1.var_.actorSpriteComps104902 = var_117_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_3 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.actorSpriteComps104902 then
					for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_117_3 then
							if arg_114_1.isInRecall_ then
								iter_117_3.color = Color.New(Mathf.Lerp(iter_117_3.color.r, arg_114_1.hightColor1.r, (arg_114_1.time_ - 0) / var_117_3), Mathf.Lerp(iter_117_3.color.g, arg_114_1.hightColor1.g, (arg_114_1.time_ - 0) / var_117_3), (Mathf.Lerp(iter_117_3.color.b, arg_114_1.hightColor1.b, (arg_114_1.time_ - 0) / var_117_3)))
							else
								local var_117_4 = Mathf.Lerp(iter_117_3.color.r, 1, (arg_114_1.time_ - 0) / var_117_3)

								iter_117_3.color = Color.New(var_117_4, var_117_4, var_117_4)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.actorSpriteComps104902 then
				for iter_117_4, iter_117_5 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_117_5 then
						iter_117_5.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_114_1.var_.actorSpriteComps104902 = nil
			end

			local var_117_5 = arg_114_1.actors_["128404"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.actorSpriteComps128404 == nil then
				arg_114_1.var_.actorSpriteComps128404 = var_117_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_6 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 and not isNil(var_117_5) then
				if arg_114_1.var_.actorSpriteComps128404 then
					for iter_117_6, iter_117_7 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_117_7 then
							if arg_114_1.isInRecall_ then
								iter_117_7.color = Color.New(Mathf.Lerp(iter_117_7.color.r, arg_114_1.hightColor2.r, (arg_114_1.time_ - 0) / var_117_6), Mathf.Lerp(iter_117_7.color.g, arg_114_1.hightColor2.g, (arg_114_1.time_ - 0) / var_117_6), (Mathf.Lerp(iter_117_7.color.b, arg_114_1.hightColor2.b, (arg_114_1.time_ - 0) / var_117_6)))
							else
								local var_117_7 = Mathf.Lerp(iter_117_7.color.r, 0.5, (arg_114_1.time_ - 0) / var_117_6)

								iter_117_7.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.actorSpriteComps128404 then
				for iter_117_8, iter_117_9 in pairs(arg_114_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_117_9 then
						iter_117_9.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_114_1.var_.actorSpriteComps128404 = nil
			end

			local var_117_8 = arg_114_1.actors_["104902"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos104902 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("104902", 2)

				for iter_117_10 = 0, var_117_8.childCount - 1 do
					local var_117_9 = var_117_8:GetChild(iter_117_10)

					if var_117_9.name == "split_6" or not string.find(var_117_9.name, "split") then
						var_117_9.gameObject:SetActive(true)
					else
						var_117_9.gameObject:SetActive(false)
					end
				end
			end

			local var_117_10 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_10 then
				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_114_1.time_ - 0) / var_117_10)
			end

			if arg_114_1.time_ >= 0 + var_117_10 and arg_114_1.time_ < 0 + var_117_10 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_117_11 = arg_114_1.actors_["108301"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_11.localPosition
				var_117_11.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 7)

				for iter_117_11 = 0, var_117_11.childCount - 1 do
					local var_117_12 = var_117_11:GetChild(iter_117_11)

					if var_117_12.name == "" or not string.find(var_117_12.name, "split") then
						var_117_12.gameObject:SetActive(true)
					else
						var_117_12.gameObject:SetActive(false)
					end
				end
			end

			local var_117_13 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_13 then
				var_117_11.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_114_1.time_ - 0) / var_117_13)
			end

			if arg_114_1.time_ >= 0 + var_117_13 and arg_114_1.time_ < 0 + var_117_13 + arg_117_0 then
				var_117_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_14 = 0
			local var_117_15 = 0.05

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_16 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(938052028).content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_18 = 2 <= 0 and var_117_15 or var_117_15 * (utf8.len(var_117_16) / 2)

				if (2 <= 0 and var_117_15 or var_117_15 * (utf8.len(var_117_16) / 2)) > 0 and var_117_15 < var_117_18 then
					arg_114_1.talkMaxDuration = var_117_18

					if var_117_18 + var_117_14 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_14
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_19 = math.max(var_117_15, arg_114_1.talkMaxDuration)

			if var_117_14 <= arg_114_1.time_ and arg_114_1.time_ < var_117_14 + var_117_19 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_14) / var_117_19

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_14 + var_117_19 and arg_114_1.time_ < var_117_14 + var_117_19 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938052029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938052029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938052030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["128404"]) and arg_118_1.var_.actorSpriteComps128404 == nil then
				arg_118_1.var_.actorSpriteComps128404 = arg_118_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["128404"]) then
				if arg_118_1.var_.actorSpriteComps128404 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 1, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["128404"]) and arg_118_1.var_.actorSpriteComps128404 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_118_1.var_.actorSpriteComps128404 = nil
			end

			local var_121_2 = arg_118_1.actors_["104902"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.actorSpriteComps104902 == nil then
				arg_118_1.var_.actorSpriteComps104902 = var_121_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_3 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.actorSpriteComps104902 then
					for iter_121_4, iter_121_5 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_121_5 then
							if arg_118_1.isInRecall_ then
								iter_121_5.color = Color.New(Mathf.Lerp(iter_121_5.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_3), Mathf.Lerp(iter_121_5.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_3), (Mathf.Lerp(iter_121_5.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_3)))
							else
								local var_121_4 = Mathf.Lerp(iter_121_5.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_3)

								iter_121_5.color = Color.New(var_121_4, var_121_4, var_121_4)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.actorSpriteComps104902 then
				for iter_121_6, iter_121_7 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_121_7 then
						iter_121_7.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps104902 = nil
			end

			local var_121_5 = arg_118_1.actors_["128404"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos128404 = var_121_5.localPosition
				var_121_5.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("128404", 4)

				for iter_121_8 = 0, var_121_5.childCount - 1 do
					local var_121_6 = var_121_5:GetChild(iter_121_8)

					if var_121_6.name == "split_7" then
						var_121_6:SetAsLastSibling()
						var_121_6.gameObject:SetActive(true)

						arg_118_1.var_.actorSpriteSplit128404 = var_121_6.gameObject:GetComponent(typeof(Image))

						arg_118_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_121_7 = 0.5

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				var_121_5.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_118_1.time_ - 0) / var_121_7)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha((arg_118_1.time_ - 0) / var_121_7)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				var_121_5.localPosition = Vector3.New(390.2, -356, -362.3)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_121_8 = 0
			local var_121_9 = 0.725

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(938052029).content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_12 = 29 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_10) / 29)

				if (29 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_10) / 29)) > 0 and var_121_9 < var_121_12 then
					arg_118_1.talkMaxDuration = var_121_12

					if var_121_12 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_13 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_13 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_13

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_13 and arg_118_1.time_ < var_121_8 + var_121_13 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play938052030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938052030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938052031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["104902"]) and arg_122_1.var_.actorSpriteComps104902 == nil then
				arg_122_1.var_.actorSpriteComps104902 = arg_122_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["104902"]) then
				if arg_122_1.var_.actorSpriteComps104902 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps104902:ToTable()) do
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

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["104902"]) and arg_122_1.var_.actorSpriteComps104902 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps104902 = nil
			end

			local var_125_2 = arg_122_1.actors_["128404"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = var_125_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_4, iter_125_5 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_5 then
							if arg_122_1.isInRecall_ then
								iter_125_5.color = Color.New(Mathf.Lerp(iter_125_5.color.r, arg_122_1.hightColor2.r, (arg_122_1.time_ - 0) / var_125_3), Mathf.Lerp(iter_125_5.color.g, arg_122_1.hightColor2.g, (arg_122_1.time_ - 0) / var_125_3), (Mathf.Lerp(iter_125_5.color.b, arg_122_1.hightColor2.b, (arg_122_1.time_ - 0) / var_125_3)))
							else
								local var_125_4 = Mathf.Lerp(iter_125_5.color.r, 0.5, (arg_122_1.time_ - 0) / var_125_3)

								iter_125_5.color = Color.New(var_125_4, var_125_4, var_125_4)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_6, iter_125_7 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_7 then
						iter_125_7.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_5 = arg_122_1.actors_["104902"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos104902 = var_125_5.localPosition
				var_125_5.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("104902", 2)

				for iter_125_8 = 0, var_125_5.childCount - 1 do
					local var_125_6 = var_125_5:GetChild(iter_125_8)

					if var_125_6.name == "split_7" then
						var_125_6:SetAsLastSibling()
						var_125_6.gameObject:SetActive(true)

						arg_122_1.var_.actorSpriteSplit104902 = var_125_6.gameObject:GetComponent(typeof(Image))

						arg_122_1.var_.actorSpriteSplit104902:SetAlpha(0)
					end
				end
			end

			local var_125_7 = 0.5

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				var_125_5.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_122_1.time_ - 0) / var_125_7)

				if arg_122_1.var_.actorSpriteSplit104902 ~= nil then
					arg_122_1.var_.actorSpriteSplit104902:SetAlpha((arg_122_1.time_ - 0) / var_125_7)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				var_125_5.localPosition = Vector3.New(-390, -335, -360)

				if arg_122_1.var_.actorSpriteSplit104902 ~= nil then
					arg_122_1.var_.actorSpriteSplit104902:SetAlpha(1)
				end
			end

			local var_125_8 = 0
			local var_125_9 = 0.175

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(938052030).content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_12 = 7 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_10) / 7)

				if (7 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_10) / 7)) > 0 and var_125_9 < var_125_12 then
					arg_122_1.talkMaxDuration = var_125_12

					if var_125_12 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_13 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_13

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_13 and arg_122_1.time_ < var_125_8 + var_125_13 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
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
	Play938052031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938052031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938052032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["106603"]) and arg_126_1.var_.actorSpriteComps106603 == nil then
				arg_126_1.var_.actorSpriteComps106603 = arg_126_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["106603"]) then
				if arg_126_1.var_.actorSpriteComps106603 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 1, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["106603"]) and arg_126_1.var_.actorSpriteComps106603 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps106603 = nil
			end

			local var_129_2 = arg_126_1.actors_["104902"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps104902 == nil then
				arg_126_1.var_.actorSpriteComps104902 = var_129_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_3 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.actorSpriteComps104902 then
					for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_129_5 then
							if arg_126_1.isInRecall_ then
								iter_129_5.color = Color.New(Mathf.Lerp(iter_129_5.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_3), Mathf.Lerp(iter_129_5.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_3), (Mathf.Lerp(iter_129_5.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_3)))
							else
								local var_129_4 = Mathf.Lerp(iter_129_5.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_3)

								iter_129_5.color = Color.New(var_129_4, var_129_4, var_129_4)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.actorSpriteComps104902 then
				for iter_129_6, iter_129_7 in pairs(arg_126_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_129_7 then
						iter_129_7.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps104902 = nil
			end

			local var_129_5 = arg_126_1.actors_["106603"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos106603 = var_129_5.localPosition
				var_129_5.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("106603", 3)

				for iter_129_8 = 0, var_129_5.childCount - 1 do
					local var_129_6 = var_129_5:GetChild(iter_129_8)

					if var_129_6.name == "split_8" or not string.find(var_129_6.name, "split") then
						var_129_6.gameObject:SetActive(true)
					else
						var_129_6.gameObject:SetActive(false)
					end
				end
			end

			local var_129_7 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				var_129_5.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_126_1.time_ - 0) / var_129_7)
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				var_129_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_129_8 = arg_126_1.actors_["104902"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos104902 = var_129_8.localPosition
				var_129_8.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("104902", 7)

				for iter_129_9 = 0, var_129_8.childCount - 1 do
					local var_129_9 = var_129_8:GetChild(iter_129_9)

					if var_129_9.name == "" or not string.find(var_129_9.name, "split") then
						var_129_9.gameObject:SetActive(true)
					else
						var_129_9.gameObject:SetActive(false)
					end
				end
			end

			local var_129_10 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_10 then
				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_126_1.time_ - 0) / var_129_10)
			end

			if arg_126_1.time_ >= 0 + var_129_10 and arg_126_1.time_ < 0 + var_129_10 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_129_11 = arg_126_1.actors_["128404"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos128404 = var_129_11.localPosition
				var_129_11.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("128404", 7)

				for iter_129_10 = 0, var_129_11.childCount - 1 do
					local var_129_12 = var_129_11:GetChild(iter_129_10)

					if var_129_12.name == "" or not string.find(var_129_12.name, "split") then
						var_129_12.gameObject:SetActive(true)
					else
						var_129_12.gameObject:SetActive(false)
					end
				end
			end

			local var_129_13 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_13 then
				var_129_11.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_126_1.time_ - 0) / var_129_13)
			end

			if arg_126_1.time_ >= 0 + var_129_13 and arg_126_1.time_ < 0 + var_129_13 + arg_129_0 then
				var_129_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_129_14 = 0
			local var_129_15 = 0.575

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_16 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(938052031).content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_18 = 23 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_16) / 23)

				if (23 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_16) / 23)) > 0 and var_129_15 < var_129_18 then
					arg_126_1.talkMaxDuration = var_129_18

					if var_129_18 + var_129_14 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_18 + var_129_14
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_19 = math.max(var_129_15, arg_126_1.talkMaxDuration)

			if var_129_14 <= arg_126_1.time_ and arg_126_1.time_ < var_129_14 + var_129_19 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_14) / var_129_19

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_14 + var_129_19 and arg_126_1.time_ < var_129_14 + var_129_19 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938052032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938052032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938052033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos106603 = arg_130_1.actors_["106603"].transform.localPosition
				arg_130_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("106603", 3)

				for iter_133_0 = 0, arg_130_1.actors_["106603"].transform.childCount - 1 do
					local var_133_0 = arg_130_1.actors_["106603"].transform:GetChild(iter_133_0)

					if var_133_0.name == "split_7" then
						var_133_0:SetAsLastSibling()
						var_133_0.gameObject:SetActive(true)

						arg_130_1.var_.actorSpriteSplit106603 = var_133_0.gameObject:GetComponent(typeof(Image))

						arg_130_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_133_1 = 0.5

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_130_1.time_ - 0) / var_133_1)

				if arg_130_1.var_.actorSpriteSplit106603 ~= nil then
					arg_130_1.var_.actorSpriteSplit106603:SetAlpha((arg_130_1.time_ - 0) / var_133_1)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["106603"].transform.localPosition = Vector3.New(-77.5, -399.1, -303.3)

				if arg_130_1.var_.actorSpriteSplit106603 ~= nil then
					arg_130_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_133_2 = 0
			local var_133_3 = 0.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(938052032).content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 10 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 10)

				if (10 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 10)) > 0 and var_133_3 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_7 and arg_130_1.time_ < var_133_2 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play938052033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 938052033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play938052034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10144"]) and arg_134_1.var_.actorSpriteComps10144 == nil then
				arg_134_1.var_.actorSpriteComps10144 = arg_134_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10144"]) then
				if arg_134_1.var_.actorSpriteComps10144 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 1, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10144"]) and arg_134_1.var_.actorSpriteComps10144 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_134_1.var_.actorSpriteComps10144 = nil
			end

			local var_137_2 = arg_134_1.actors_["106603"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps106603 == nil then
				arg_134_1.var_.actorSpriteComps106603 = var_137_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_3 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.actorSpriteComps106603 then
					for iter_137_4, iter_137_5 in pairs(arg_134_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_137_5 then
							if arg_134_1.isInRecall_ then
								iter_137_5.color = Color.New(Mathf.Lerp(iter_137_5.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_3), Mathf.Lerp(iter_137_5.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_3), (Mathf.Lerp(iter_137_5.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_3)))
							else
								local var_137_4 = Mathf.Lerp(iter_137_5.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_3)

								iter_137_5.color = Color.New(var_137_4, var_137_4, var_137_4)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps106603 then
				for iter_137_6, iter_137_7 in pairs(arg_134_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_137_7 then
						iter_137_7.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps106603 = nil
			end

			local var_137_5 = arg_134_1.actors_["10144"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10144 = var_137_5.localPosition
				var_137_5.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("10144", 4)

				for iter_137_8 = 0, var_137_5.childCount - 1 do
					local var_137_6 = var_137_5:GetChild(iter_137_8)

					if var_137_6.name == "split_12" or not string.find(var_137_6.name, "split") then
						var_137_6.gameObject:SetActive(true)
					else
						var_137_6.gameObject:SetActive(false)
					end
				end
			end

			local var_137_7 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				var_137_5.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_134_1.time_ - 0) / var_137_7)
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				var_137_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_137_8 = arg_134_1.actors_["106603"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos106603 = var_137_8.localPosition
				var_137_8.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("106603", 2)

				for iter_137_9 = 0, var_137_8.childCount - 1 do
					local var_137_9 = var_137_8:GetChild(iter_137_9)

					if var_137_9.name == "" or not string.find(var_137_9.name, "split") then
						var_137_9.gameObject:SetActive(true)
					else
						var_137_9.gameObject:SetActive(false)
					end
				end
			end

			local var_137_10 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_10 then
				var_137_8.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_134_1.time_ - 0) / var_137_10)
			end

			if arg_134_1.time_ >= 0 + var_137_10 and arg_134_1.time_ < 0 + var_137_10 + arg_137_0 then
				var_137_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_137_11 = 0
			local var_137_12 = 0.6

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_13 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(938052033).content)

				arg_134_1.text_.text = var_137_13

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_15 = 24 <= 0 and var_137_12 or var_137_12 * (utf8.len(var_137_13) / 24)

				if (24 <= 0 and var_137_12 or var_137_12 * (utf8.len(var_137_13) / 24)) > 0 and var_137_12 < var_137_15 then
					arg_134_1.talkMaxDuration = var_137_15

					if var_137_15 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_11
					end
				end

				arg_134_1.text_.text = var_137_13
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_12, arg_134_1.talkMaxDuration)

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_11) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_11 + var_137_16 and arg_134_1.time_ < var_137_11 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play938052034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 938052034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play938052035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["106603"]) and arg_138_1.var_.actorSpriteComps106603 == nil then
				arg_138_1.var_.actorSpriteComps106603 = arg_138_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["106603"]) then
				if arg_138_1.var_.actorSpriteComps106603 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["106603"]) and arg_138_1.var_.actorSpriteComps106603 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps106603 = nil
			end

			local var_141_2 = arg_138_1.actors_["10144"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps10144 == nil then
				arg_138_1.var_.actorSpriteComps10144 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps10144 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								iter_141_5.color = Color.New(Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_5.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_5.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps10144 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_141_7 then
						iter_141_7.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps10144 = nil
			end

			local var_141_5 = arg_138_1.actors_["106603"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos106603 = var_141_5.localPosition
				var_141_5.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("106603", 2)

				for iter_141_8 = 0, var_141_5.childCount - 1 do
					local var_141_6 = var_141_5:GetChild(iter_141_8)

					if var_141_6.name == "split_11" then
						var_141_6:SetAsLastSibling()
						var_141_6.gameObject:SetActive(true)

						arg_138_1.var_.actorSpriteSplit106603 = var_141_6.gameObject:GetComponent(typeof(Image))

						arg_138_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_141_7 = 0.5

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_138_1.time_ - 0) / var_141_7)

				if arg_138_1.var_.actorSpriteSplit106603 ~= nil then
					arg_138_1.var_.actorSpriteSplit106603:SetAlpha((arg_138_1.time_ - 0) / var_141_7)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)

				if arg_138_1.var_.actorSpriteSplit106603 ~= nil then
					arg_138_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_141_8 = 0
			local var_141_9 = 0.225

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_10 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(938052034).content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_12 = 9 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_10) / 9)

				if (9 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_10) / 9)) > 0 and var_141_9 < var_141_12 then
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play938052035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 938052035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play938052036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10144"]) and arg_142_1.var_.actorSpriteComps10144 == nil then
				arg_142_1.var_.actorSpriteComps10144 = arg_142_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10144"]) then
				if arg_142_1.var_.actorSpriteComps10144 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 1, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10144"]) and arg_142_1.var_.actorSpriteComps10144 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps10144 = nil
			end

			local var_145_2 = arg_142_1.actors_["106603"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps106603 == nil then
				arg_142_1.var_.actorSpriteComps106603 = var_145_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.actorSpriteComps106603 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_3), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_3), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_3)))
							else
								local var_145_4 = Mathf.Lerp(iter_145_5.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_3)

								iter_145_5.color = Color.New(var_145_4, var_145_4, var_145_4)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps106603 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps106603 = nil
			end

			local var_145_5 = arg_142_1.actors_["10144"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10144 = var_145_5.localPosition
				var_145_5.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10144", 4)

				for iter_145_8 = 0, var_145_5.childCount - 1 do
					local var_145_6 = var_145_5:GetChild(iter_145_8)

					if var_145_6.name == "split_11" then
						var_145_6:SetAsLastSibling()
						var_145_6.gameObject:SetActive(true)

						arg_142_1.var_.actorSpriteSplit10144 = var_145_6.gameObject:GetComponent(typeof(Image))

						arg_142_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_145_7 = 0.5

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				var_145_5.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_142_1.time_ - 0) / var_145_7)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha((arg_142_1.time_ - 0) / var_145_7)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				var_145_5.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_145_8 = 0
			local var_145_9 = 0.75

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
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

				local var_145_10 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(938052035).content)

				arg_142_1.text_.text = var_145_10

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_12 = 30 <= 0 and var_145_9 or var_145_9 * (utf8.len(var_145_10) / 30)

				if (30 <= 0 and var_145_9 or var_145_9 * (utf8.len(var_145_10) / 30)) > 0 and var_145_9 < var_145_12 then
					arg_142_1.talkMaxDuration = var_145_12

					if var_145_12 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_8
					end
				end

				arg_142_1.text_.text = var_145_10
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_9, arg_142_1.talkMaxDuration)

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_8) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_8 + var_145_13 and arg_142_1.time_ < var_145_8 + var_145_13 + arg_145_0 then
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
	Play938052036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 938052036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
			arg_146_1.auto_ = false
		end

		function arg_146_1.playNext_(arg_148_0)
			arg_146_1.onStoryFinished_()
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
			local var_149_3 = 0.4

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

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_4 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(938052036).content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_6 = 16 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 16)

				if (16 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_4) / 16)) > 0 and var_149_3 < var_149_6 then
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
	assets = {
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
