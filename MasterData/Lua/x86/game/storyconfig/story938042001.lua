return {
	Play938042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938042001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938042002(arg_1_1)
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

			local var_4_9 = "10183"

			if arg_1_1.actors_["10183"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

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

			local var_4_12 = arg_1_1.actors_["10183"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10183 == nil then
				arg_1_1.var_.actorSpriteComps10183 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10183 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10183 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10183 = nil
			end

			local var_4_15 = arg_1_1.actors_["10183"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10183 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10183", 3)

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
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -475, -325)
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 1.025

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938042001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 41 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 41)

				if (41 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 41)) > 0 and var_4_23 < var_4_27 then
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
				actorName = "10183",
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
	Play938042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938042002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10183 = arg_8_1.actors_["10183"].transform.localPosition
				arg_8_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10183", 3)

				for iter_11_0 = 0, arg_8_1.actors_["10183"].transform.childCount - 1 do
					local var_11_0 = arg_8_1.actors_["10183"].transform:GetChild(iter_11_0)

					if var_11_0.name == "split_2" then
						var_11_0:SetAsLastSibling()
						var_11_0.gameObject:SetActive(true)

						arg_8_1.var_.actorSpriteSplit10183 = var_11_0.gameObject:GetComponent(typeof(Image))

						arg_8_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_11_1 = 0.5

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_8_1.time_ - 0) / var_11_1)

				if arg_8_1.var_.actorSpriteSplit10183 ~= nil then
					arg_8_1.var_.actorSpriteSplit10183:SetAlpha((arg_8_1.time_ - 0) / var_11_1)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_8_1.var_.actorSpriteSplit10183 ~= nil then
					arg_8_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_11_2 = 0
			local var_11_3 = 0.7

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_4 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938042002).content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 28 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 28)

				if (28 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 28)) > 0 and var_11_3 < var_11_6 then
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

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play938042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938042003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0.5 < arg_12_1.time_ and arg_12_1.time_ <= 0.5 + arg_15_0 then
				arg_12_1.var_.moveOldPos10183 = arg_12_1.actors_["10183"].transform.localPosition
				arg_12_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10183", 7)

				for iter_15_0 = 0, arg_12_1.actors_["10183"].transform.childCount - 1 do
					local var_15_0 = arg_12_1.actors_["10183"].transform:GetChild(iter_15_0)

					if var_15_0.name == "" or not string.find(var_15_0.name, "split") then
						var_15_0.gameObject:SetActive(true)
					else
						var_15_0.gameObject:SetActive(false)
					end
				end
			end

			local var_15_1 = 0.001

			if 0.5 <= arg_12_1.time_ and arg_12_1.time_ < 0.5 + var_15_1 then
				arg_12_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_12_1.time_ - 0.5) / var_15_1)
			end

			if arg_12_1.time_ >= 0.5 + var_15_1 and arg_12_1.time_ < 0.5 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["10183"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_2 = arg_12_1.actors_["10183"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10183 = var_15_2.localPosition
				var_15_2.localScale = Vector3.New(1, 1, 1)

				for iter_15_1 = 0, var_15_2.childCount - 1 do
					local var_15_3 = var_15_2:GetChild(iter_15_1)

					if var_15_3.name == "split_2" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.5

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_2.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10183, Vector3.New(0, -8000, 0), (arg_12_1.time_ - 0) / var_15_4)
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_2.localPosition = Vector3.New(0, -8000, 0)
			end

			local var_15_5 = 0
			local var_15_6 = 1.125

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_7 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938042003).content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_9 = 45 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 45)

				if (45 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_7) / 45)) > 0 and var_15_6 < var_15_9 then
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(0, -475, -325),
					endPos = Vector3.New(0, -8000, 0),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play938042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938042004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["128404"] == nil then
				local var_19_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_19_0) then
					local var_19_1 = Object.Instantiate(var_19_0, arg_16_1.canvasGo_.transform)

					var_19_1.transform:SetSiblingIndex(1)

					var_19_1.name = "128404"
					var_19_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_16_1.actors_["128404"] = var_19_1

					if arg_16_1.isInRecall_ then
						for iter_19_0, iter_19_1 in ipairs((var_19_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_19_1.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_19_2 = arg_16_1.actors_["128404"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps128404 == nil then
				arg_16_1.var_.actorSpriteComps128404 = var_19_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_3 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.actorSpriteComps128404 then
					for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_19_3 then
							if arg_16_1.isInRecall_ then
								iter_19_3.color = Color.New(Mathf.Lerp(iter_19_3.color.r, arg_16_1.hightColor1.r, (arg_16_1.time_ - 0) / var_19_3), Mathf.Lerp(iter_19_3.color.g, arg_16_1.hightColor1.g, (arg_16_1.time_ - 0) / var_19_3), (Mathf.Lerp(iter_19_3.color.b, arg_16_1.hightColor1.b, (arg_16_1.time_ - 0) / var_19_3)))
							else
								local var_19_4 = Mathf.Lerp(iter_19_3.color.r, 1, (arg_16_1.time_ - 0) / var_19_3)

								iter_19_3.color = Color.New(var_19_4, var_19_4, var_19_4)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps128404 then
				for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_19_5 then
						iter_19_5.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps128404 = nil
			end

			local var_19_5 = arg_16_1.actors_["128404"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos128404 = var_19_5.localPosition
				var_19_5.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("128404", 3)

				for iter_19_6 = 0, var_19_5.childCount - 1 do
					local var_19_6 = var_19_5:GetChild(iter_19_6)

					if var_19_6.name == "split_3" or not string.find(var_19_6.name, "split") then
						var_19_6.gameObject:SetActive(true)
					else
						var_19_6.gameObject:SetActive(false)
					end
				end
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_16_1.time_ - 0) / var_19_7)
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_19_8 = 0
			local var_19_9 = 0.175

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938042004).content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_12 = 7 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 7)

				if (7 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 7)) > 0 and var_19_9 < var_19_12 then
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
				actorName = "128404",
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
	Play938042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938042005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938042006(arg_20_1)
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
								iter_23_1.color = Color.New(Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor2.r, (arg_20_1.time_ - 0) / var_23_0), Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor2.g, (arg_20_1.time_ - 0) / var_23_0), (Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor2.b, (arg_20_1.time_ - 0) / var_23_0)))
							else
								local var_23_1 = Mathf.Lerp(iter_23_1.color.r, 0.5, (arg_20_1.time_ - 0) / var_23_0)

								iter_23_1.color = Color.New(var_23_1, var_23_1, var_23_1)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["128404"]) and arg_20_1.var_.actorSpriteComps128404 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_20_1.var_.actorSpriteComps128404 = nil
			end

			local var_23_2 = 0
			local var_23_3 = 0.5

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_4 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938042005).content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 20 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 20)

				if (20 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 20)) > 0 and var_23_3 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_7 and arg_20_1.time_ < var_23_2 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938042006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["128404"]) and arg_24_1.var_.actorSpriteComps128404 == nil then
				arg_24_1.var_.actorSpriteComps128404 = arg_24_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["128404"]) then
				if arg_24_1.var_.actorSpriteComps128404 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["128404"]) and arg_24_1.var_.actorSpriteComps128404 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps128404 = nil
			end

			local var_27_2 = arg_24_1.actors_["128404"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos128404 = var_27_2.localPosition
				var_27_2.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("128404", 3)

				for iter_27_4 = 0, var_27_2.childCount - 1 do
					local var_27_3 = var_27_2:GetChild(iter_27_4)

					if var_27_3.name == "split_1" then
						var_27_3:SetAsLastSibling()
						var_27_3.gameObject:SetActive(true)

						arg_24_1.var_.actorSpriteSplit128404 = var_27_3.gameObject:GetComponent(typeof(Image))

						arg_24_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_27_4 = 0.5

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_2.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_24_1.time_ - 0) / var_27_4)

				if arg_24_1.var_.actorSpriteSplit128404 ~= nil then
					arg_24_1.var_.actorSpriteSplit128404:SetAlpha((arg_24_1.time_ - 0) / var_27_4)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_24_1.var_.actorSpriteSplit128404 ~= nil then
					arg_24_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_27_5 = 0
			local var_27_6 = 0.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938042006).content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 6 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_7) / 6)

				if (6 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_7) / 6)) > 0 and var_27_6 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_10 and arg_24_1.time_ < var_27_5 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play938042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938042007
		arg_28_1.duration_ = 9

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 2 < arg_28_1.time_ and arg_28_1.time_ <= 2 + arg_31_0 then
				local var_31_0 = arg_28_1.bgs_.ST0119

				arg_28_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_1 = var_31_0:GetComponent("SpriteRenderer")

				if var_31_1 and var_31_1.sprite then
					local var_31_2 = 2 * (var_31_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_0.transform.localScale = Vector3.New(var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, var_31_2 / var_31_1.sprite.bounds.size.y < var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x and var_31_2 * manager.ui.mainCameraCom_.aspect / var_31_1.sprite.bounds.size.x or var_31_2 / var_31_1.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "ST0119" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_3 = 3.999999999999

			if 3.999999999999 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_3 + 0.3 and arg_28_1.time_ < var_31_3 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_4 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_5 = 2

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_5 then
				local var_31_6 = Color.New(0, 0, 0)

				var_31_6.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_4) / var_31_5)
				arg_28_1.mask_.color = var_31_6
			end

			if arg_28_1.time_ >= var_31_4 + var_31_5 and arg_28_1.time_ < var_31_4 + var_31_5 + arg_31_0 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = 1
				arg_28_1.mask_.color = var_31_7
			end

			local var_31_8 = 2

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_9 = 2

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_9 then
				local var_31_10 = Color.New(0, 0, 0)

				var_31_10.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_8) / var_31_9)
				arg_28_1.mask_.color = var_31_10
			end

			if arg_28_1.time_ >= var_31_8 + var_31_9 and arg_28_1.time_ < var_31_8 + var_31_9 + arg_31_0 then
				local var_31_11 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_11.a = 0
				arg_28_1.mask_.color = var_31_11
			end

			local var_31_12 = arg_28_1.actors_["128404"].transform

			if 1.966 < arg_28_1.time_ and arg_28_1.time_ <= 1.966 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_12.localPosition
				var_31_12.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 7)

				for iter_31_2 = 0, var_31_12.childCount - 1 do
					local var_31_13 = var_31_12:GetChild(iter_31_2)

					if var_31_13.name == "" or not string.find(var_31_13.name, "split") then
						var_31_13.gameObject:SetActive(true)
					else
						var_31_13.gameObject:SetActive(false)
					end
				end
			end

			local var_31_14 = 0.001

			if 1.966 <= arg_28_1.time_ and arg_28_1.time_ < 1.966 + var_31_14 then
				var_31_12.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_28_1.time_ - 1.966) / var_31_14)
			end

			if arg_28_1.time_ >= 1.966 + var_31_14 and arg_28_1.time_ < 1.966 + var_31_14 + arg_31_0 then
				var_31_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_15 = arg_28_1.actors_["128404"].transform

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= 4 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_15.localPosition
				var_31_15.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 3)

				for iter_31_3 = 0, var_31_15.childCount - 1 do
					local var_31_16 = var_31_15:GetChild(iter_31_3)

					if var_31_16.name == "" or not string.find(var_31_16.name, "split") then
						var_31_16.gameObject:SetActive(true)
					else
						var_31_16.gameObject:SetActive(false)
					end
				end
			end

			local var_31_17 = 0.001

			if 4 <= arg_28_1.time_ and arg_28_1.time_ < 4 + var_31_17 then
				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_28_1.time_ - 4) / var_31_17)
			end

			if arg_28_1.time_ >= 4 + var_31_17 and arg_28_1.time_ < 4 + var_31_17 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_18 = 4
			local var_31_19 = 0.7

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_20 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_20:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_21 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938042007).content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_23 = 28 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_21) / 28)

				if (28 <= 0 and var_31_19 or var_31_19 * (utf8.len(var_31_21) / 28)) > 0 and var_31_19 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23
					var_31_18 = var_31_18 + 0.3

					if var_31_23 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_24 = var_31_18 + 0.3
			local var_31_25 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_18 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_24 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_24) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_24 + var_31_25 and arg_28_1.time_ < var_31_24 + var_31_25 + arg_31_0 then
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
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938042008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 938042008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play938042009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["128404"]) and arg_34_1.var_.actorSpriteComps128404 == nil then
				arg_34_1.var_.actorSpriteComps128404 = arg_34_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["128404"]) then
				if arg_34_1.var_.actorSpriteComps128404 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 0.5, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["128404"]) and arg_34_1.var_.actorSpriteComps128404 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps128404 = nil
			end

			local var_37_2 = 0
			local var_37_3 = 0.375

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_4 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(938042008).content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 15 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_4) / 15)

				if (15 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_4) / 15)) > 0 and var_37_3 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_7 and arg_34_1.time_ < var_37_2 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play938042009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 938042009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play938042010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["128404"]) and arg_38_1.var_.actorSpriteComps128404 == nil then
				arg_38_1.var_.actorSpriteComps128404 = arg_38_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["128404"]) then
				if arg_38_1.var_.actorSpriteComps128404 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 1, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["128404"]) and arg_38_1.var_.actorSpriteComps128404 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps128404 = nil
			end

			local var_41_2 = arg_38_1.actors_["128404"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos128404 = var_41_2.localPosition
				var_41_2.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("128404", 3)

				for iter_41_4 = 0, var_41_2.childCount - 1 do
					local var_41_3 = var_41_2:GetChild(iter_41_4)

					if var_41_3.name == "split_4" or not string.find(var_41_3.name, "split") then
						var_41_3.gameObject:SetActive(true)
					else
						var_41_3.gameObject:SetActive(false)
					end
				end
			end

			local var_41_4 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_38_1.time_ - 0) / var_41_4)
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_41_5 = 0
			local var_41_6 = 0.125

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(938042009).content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 5 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 5)

				if (5 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_7) / 5)) > 0 and var_41_6 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_10 and arg_38_1.time_ < var_41_5 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play938042010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 938042010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play938042011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["10144"] == nil then
				local var_45_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_45_0) then
					local var_45_1 = Object.Instantiate(var_45_0, arg_42_1.canvasGo_.transform)

					var_45_1.transform:SetSiblingIndex(1)

					var_45_1.name = "10144"
					var_45_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_["10144"] = var_45_1

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs((var_45_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_2 = arg_42_1.actors_["10144"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10144 == nil then
				arg_42_1.var_.actorSpriteComps10144 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps10144 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10144 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_45_5 then
						iter_45_5.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10144 = nil
			end

			local var_45_5 = arg_42_1.actors_["128404"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps128404 == nil then
				arg_42_1.var_.actorSpriteComps128404 = var_45_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 and not isNil(var_45_5) then
				if arg_42_1.var_.actorSpriteComps128404 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.actorSpriteComps128404 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_45_9 then
						iter_45_9.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps128404 = nil
			end

			local var_45_8 = arg_42_1.actors_["10144"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10144 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10144", 4)

				for iter_45_10 = 0, var_45_8.childCount - 1 do
					local var_45_9 = var_45_8:GetChild(iter_45_10)

					if var_45_9.name == "split_2" or not string.find(var_45_9.name, "split") then
						var_45_9.gameObject:SetActive(true)
					else
						var_45_9.gameObject:SetActive(false)
					end
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_42_1.time_ - 0) / var_45_10)
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_45_11 = arg_42_1.actors_["128404"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos128404 = var_45_11.localPosition
				var_45_11.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("128404", 2)

				for iter_45_11 = 0, var_45_11.childCount - 1 do
					local var_45_12 = var_45_11:GetChild(iter_45_11)

					if var_45_12.name == "" or not string.find(var_45_12.name, "split") then
						var_45_12.gameObject:SetActive(true)
					else
						var_45_12.gameObject:SetActive(false)
					end
				end
			end

			local var_45_13 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_13 then
				var_45_11.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_42_1.time_ - 0) / var_45_13)
			end

			if arg_42_1.time_ >= 0 + var_45_13 and arg_42_1.time_ < 0 + var_45_13 + arg_45_0 then
				var_45_11.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_45_14 = 0
			local var_45_15 = 0.4

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_16 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(938042010).content)

				arg_42_1.text_.text = var_45_16

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_18 = 16 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_16) / 16)

				if (16 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_16) / 16)) > 0 and var_45_15 < var_45_18 then
					arg_42_1.talkMaxDuration = var_45_18

					if var_45_18 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_16
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_19 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_14 <= arg_42_1.time_ and arg_42_1.time_ < var_45_14 + var_45_19 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_14) / var_45_19

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_14 + var_45_19 and arg_42_1.time_ < var_45_14 + var_45_19 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play938042011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 938042011
		arg_46_1.duration_ = 1

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"

			SetActive(arg_46_1.choicesGo_, true)

			for iter_47_0, iter_47_1 in ipairs(arg_46_1.choices_) do
				SetActive(iter_47_1.go, iter_47_0 <= 2)
			end

			arg_46_1.choices_[1].txt.text = arg_46_1:FormatText(StoryChoiceCfg[1785].name)
			arg_46_1.choices_[2].txt.text = arg_46_1:FormatText(StoryChoiceCfg[1786].name)
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play938042012(arg_46_1)
			end

			if arg_48_0 == 2 then
				arg_46_0:Play938042012(arg_46_1)
			end

			arg_46_1:RecordChoiceLog(938042011, 1785, 1786)
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10144"]) and arg_46_1.var_.actorSpriteComps10144 == nil then
				arg_46_1.var_.actorSpriteComps10144 = arg_46_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10144"]) then
				if arg_46_1.var_.actorSpriteComps10144 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10144"]) and arg_46_1.var_.actorSpriteComps10144 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10144 = nil
			end

			local var_49_2 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			if arg_46_1.time_ >= var_49_2 + 0.5 and arg_46_1.time_ < var_49_2 + 0.5 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play938042012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938042012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938042013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["128404"]) and arg_50_1.var_.actorSpriteComps128404 == nil then
				arg_50_1.var_.actorSpriteComps128404 = arg_50_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["128404"]) then
				if arg_50_1.var_.actorSpriteComps128404 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 1, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["128404"]) and arg_50_1.var_.actorSpriteComps128404 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps128404 = nil
			end

			local var_53_2 = arg_50_1.actors_["128404"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos128404 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("128404", 2)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "split_4" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_53_5 = 0
			local var_53_6 = 1.15

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(938042012).content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 46 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 46)

				if (46 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_7) / 46)) > 0 and var_53_6 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_10 and arg_50_1.time_ < var_53_5 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
	Play938042013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938042013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938042014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = arg_54_1.actors_["128404"].transform.localPosition
				arg_54_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				for iter_57_0 = 0, arg_54_1.actors_["128404"].transform.childCount - 1 do
					local var_57_0 = arg_54_1.actors_["128404"].transform:GetChild(iter_57_0)

					if var_57_0.name == "split_2" then
						var_57_0:SetAsLastSibling()
						var_57_0.gameObject:SetActive(true)

						arg_54_1.var_.actorSpriteSplit128404 = var_57_0.gameObject:GetComponent(typeof(Image))

						arg_54_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_57_1 = 0.5

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_1 then
				arg_54_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_54_1.time_ - 0) / var_57_1)

				if arg_54_1.var_.actorSpriteSplit128404 ~= nil then
					arg_54_1.var_.actorSpriteSplit128404:SetAlpha((arg_54_1.time_ - 0) / var_57_1)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_1 and arg_54_1.time_ < 0 + var_57_1 + arg_57_0 then
				arg_54_1.actors_["128404"].transform.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_54_1.var_.actorSpriteSplit128404 ~= nil then
					arg_54_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_57_2 = 0
			local var_57_3 = 0.875

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
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

				local var_57_4 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(938042013).content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_6 = 35 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_4) / 35)

				if (35 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_4) / 35)) > 0 and var_57_3 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_7 and arg_54_1.time_ < var_57_2 + var_57_7 + arg_57_0 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play938042014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938042014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938042015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["128404"]) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = arg_58_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["128404"]) then
				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["128404"]) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 0.25

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
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

				local var_61_4 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(938042014).content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_6 = 10 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 10)

				if (10 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_4) / 10)) > 0 and var_61_3 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_7 and arg_58_1.time_ < var_61_2 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play938042015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938042015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938042016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10144"]) and arg_62_1.var_.actorSpriteComps10144 == nil then
				arg_62_1.var_.actorSpriteComps10144 = arg_62_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10144"]) then
				if arg_62_1.var_.actorSpriteComps10144 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10144"]) and arg_62_1.var_.actorSpriteComps10144 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps10144 = nil
			end

			local var_65_2 = arg_62_1.actors_["10144"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10144 = var_65_2.localPosition
				var_65_2.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10144", 4)

				for iter_65_4 = 0, var_65_2.childCount - 1 do
					local var_65_3 = var_65_2:GetChild(iter_65_4)

					if var_65_3.name == "" then
						var_65_3:SetAsLastSibling()
						var_65_3.gameObject:SetActive(true)

						arg_62_1.var_.actorSpriteSplit10144 = var_65_3.gameObject:GetComponent(typeof(Image))

						arg_62_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_65_4 = 0.5

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_2.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_62_1.time_ - 0) / var_65_4)

				if arg_62_1.var_.actorSpriteSplit10144 ~= nil then
					arg_62_1.var_.actorSpriteSplit10144:SetAlpha((arg_62_1.time_ - 0) / var_65_4)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_2.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_62_1.var_.actorSpriteSplit10144 ~= nil then
					arg_62_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_65_5 = 0
			local var_65_6 = 0.4

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
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

				local var_65_7 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(938042015).content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 16 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 16)

				if (16 <= 0 and var_65_6 or var_65_6 * (utf8.len(var_65_7) / 16)) > 0 and var_65_6 < var_65_9 then
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play938042016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938042016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938042017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.475

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(938042016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 19 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 19)

				if (19 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 19)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play938042017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 938042017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play938042018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10144 = arg_70_1.actors_["10144"].transform.localPosition
				arg_70_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("10144", 4)

				for iter_73_0 = 0, arg_70_1.actors_["10144"].transform.childCount - 1 do
					local var_73_0 = arg_70_1.actors_["10144"].transform:GetChild(iter_73_0)

					if var_73_0.name == "split_7" then
						var_73_0:SetAsLastSibling()
						var_73_0.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit10144 = var_73_0.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_73_1 = 0.5

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_1 then
				arg_70_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_70_1.time_ - 0) / var_73_1)

				if arg_70_1.var_.actorSpriteSplit10144 ~= nil then
					arg_70_1.var_.actorSpriteSplit10144:SetAlpha((arg_70_1.time_ - 0) / var_73_1)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_1 and arg_70_1.time_ < 0 + var_73_1 + arg_73_0 then
				arg_70_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_70_1.var_.actorSpriteSplit10144 ~= nil then
					arg_70_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_73_2 = 0
			local var_73_3 = 0.775

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_4 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(938042017).content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_6 = 31 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_4) / 31)

				if (31 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_4) / 31)) > 0 and var_73_3 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_7 and arg_70_1.time_ < var_73_2 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play938042018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 938042018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play938042019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10144"]) and arg_74_1.var_.actorSpriteComps10144 == nil then
				arg_74_1.var_.actorSpriteComps10144 = arg_74_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10144"]) then
				if arg_74_1.var_.actorSpriteComps10144 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10144"]) and arg_74_1.var_.actorSpriteComps10144 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps10144 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 0.25

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

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(938042018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 10)

				if (10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 10)) > 0 and var_77_3 < var_77_6 then
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
	Play938042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938042019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10144"]) and arg_78_1.var_.actorSpriteComps10144 == nil then
				arg_78_1.var_.actorSpriteComps10144 = arg_78_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10144"]) then
				if arg_78_1.var_.actorSpriteComps10144 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10144"]) and arg_78_1.var_.actorSpriteComps10144 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_81_3 then
						iter_81_3.color = arg_78_1.isInRecall_ and (arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_78_1.var_.actorSpriteComps10144 = nil
			end

			local var_81_2 = arg_78_1.actors_["10144"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10144 = var_81_2.localPosition
				var_81_2.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10144", 4)

				for iter_81_4 = 0, var_81_2.childCount - 1 do
					local var_81_3 = var_81_2:GetChild(iter_81_4)

					if var_81_3.name == "split_1" then
						var_81_3:SetAsLastSibling()
						var_81_3.gameObject:SetActive(true)

						arg_78_1.var_.actorSpriteSplit10144 = var_81_3.gameObject:GetComponent(typeof(Image))

						arg_78_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_81_4 = 0.5

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_78_1.time_ - 0) / var_81_4)

				if arg_78_1.var_.actorSpriteSplit10144 ~= nil then
					arg_78_1.var_.actorSpriteSplit10144:SetAlpha((arg_78_1.time_ - 0) / var_81_4)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_78_1.var_.actorSpriteSplit10144 ~= nil then
					arg_78_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_81_5 = 0
			local var_81_6 = 0.9

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(938042019).content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 36 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 36)

				if (36 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 36)) > 0 and var_81_6 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_10 and arg_78_1.time_ < var_81_5 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play938042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938042020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10144 = arg_82_1.actors_["10144"].transform.localPosition
				arg_82_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10144", 4)

				for iter_85_0 = 0, arg_82_1.actors_["10144"].transform.childCount - 1 do
					local var_85_0 = arg_82_1.actors_["10144"].transform:GetChild(iter_85_0)

					if var_85_0.name == "" or not string.find(var_85_0.name, "split") then
						var_85_0.gameObject:SetActive(true)
					else
						var_85_0.gameObject:SetActive(false)
					end
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_82_1.time_ - 0) / var_85_1)
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_85_2 = 0
			local var_85_3 = 0.95

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(938042020).content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 38 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 38)

				if (38 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 38)) > 0 and var_85_3 < var_85_6 then
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

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play938042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938042022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["128404"]) and arg_86_1.var_.actorSpriteComps128404 == nil then
				arg_86_1.var_.actorSpriteComps128404 = arg_86_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["128404"]) then
				if arg_86_1.var_.actorSpriteComps128404 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["128404"]) and arg_86_1.var_.actorSpriteComps128404 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_86_1.var_.actorSpriteComps128404 = nil
			end

			local var_89_2 = arg_86_1.actors_["10144"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = var_89_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_3 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_4, iter_89_5 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_89_5 then
							if arg_86_1.isInRecall_ then
								iter_89_5.color = Color.New(Mathf.Lerp(iter_89_5.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_3), Mathf.Lerp(iter_89_5.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_3), (Mathf.Lerp(iter_89_5.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_3)))
							else
								local var_89_4 = Mathf.Lerp(iter_89_5.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_3)

								iter_89_5.color = Color.New(var_89_4, var_89_4, var_89_4)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_6, iter_89_7 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_7 then
						iter_89_7.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_5 = arg_86_1.actors_["128404"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos128404 = var_89_5.localPosition
				var_89_5.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("128404", 2)

				for iter_89_8 = 0, var_89_5.childCount - 1 do
					local var_89_6 = var_89_5:GetChild(iter_89_8)

					if var_89_6.name == "split_1" then
						var_89_6:SetAsLastSibling()
						var_89_6.gameObject:SetActive(true)

						arg_86_1.var_.actorSpriteSplit128404 = var_89_6.gameObject:GetComponent(typeof(Image))

						arg_86_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_89_7 = 0.5

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				var_89_5.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_86_1.time_ - 0) / var_89_7)

				if arg_86_1.var_.actorSpriteSplit128404 ~= nil then
					arg_86_1.var_.actorSpriteSplit128404:SetAlpha((arg_86_1.time_ - 0) / var_89_7)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				var_89_5.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_86_1.var_.actorSpriteSplit128404 ~= nil then
					arg_86_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_89_8 = 0
			local var_89_9 = 0.425

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(938042021).content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_12 = 17 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_10) / 17)

				if (17 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_10) / 17)) > 0 and var_89_9 < var_89_12 then
					arg_86_1.talkMaxDuration = var_89_12

					if var_89_12 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_13 and arg_86_1.time_ < var_89_8 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play938042022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938042022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938042023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["128404"]) and arg_90_1.var_.actorSpriteComps128404 == nil then
				arg_90_1.var_.actorSpriteComps128404 = arg_90_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["128404"]) then
				if arg_90_1.var_.actorSpriteComps128404 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["128404"]) and arg_90_1.var_.actorSpriteComps128404 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps128404 = nil
			end

			local var_93_2 = 0
			local var_93_3 = 0.4

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
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

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_4 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(938042022).content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 16 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 16)

				if (16 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_4) / 16)) > 0 and var_93_3 < var_93_6 then
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

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play938042023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938042023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938042024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["128404"]) and arg_94_1.var_.actorSpriteComps128404 == nil then
				arg_94_1.var_.actorSpriteComps128404 = arg_94_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["128404"]) then
				if arg_94_1.var_.actorSpriteComps128404 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["128404"]) and arg_94_1.var_.actorSpriteComps128404 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps128404 = nil
			end

			local var_97_2 = arg_94_1.actors_["128404"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos128404 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("128404", 2)

				for iter_97_4 = 0, var_97_2.childCount - 1 do
					local var_97_3 = var_97_2:GetChild(iter_97_4)

					if var_97_3.name == "split_4" then
						var_97_3:SetAsLastSibling()
						var_97_3.gameObject:SetActive(true)

						arg_94_1.var_.actorSpriteSplit128404 = var_97_3.gameObject:GetComponent(typeof(Image))

						arg_94_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_97_4 = 0.5

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_94_1.time_ - 0) / var_97_4)

				if arg_94_1.var_.actorSpriteSplit128404 ~= nil then
					arg_94_1.var_.actorSpriteSplit128404:SetAlpha((arg_94_1.time_ - 0) / var_97_4)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_94_1.var_.actorSpriteSplit128404 ~= nil then
					arg_94_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_97_5 = 0
			local var_97_6 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(938042023).content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 37 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 37)

				if (37 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_7) / 37)) > 0 and var_97_6 < var_97_9 then
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play938042024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938042024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938042025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["128404"]) and arg_98_1.var_.actorSpriteComps128404 == nil then
				arg_98_1.var_.actorSpriteComps128404 = arg_98_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["128404"]) then
				if arg_98_1.var_.actorSpriteComps128404 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["128404"]) and arg_98_1.var_.actorSpriteComps128404 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps128404 = nil
			end

			local var_101_2 = 0
			local var_101_3 = 0.35

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_4 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(938042024).content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 14 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 14)

				if (14 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_4) / 14)) > 0 and var_101_3 < var_101_6 then
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

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play938042025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938042025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938042026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["128404"]) and arg_102_1.var_.actorSpriteComps128404 == nil then
				arg_102_1.var_.actorSpriteComps128404 = arg_102_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["128404"]) then
				if arg_102_1.var_.actorSpriteComps128404 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["128404"]) and arg_102_1.var_.actorSpriteComps128404 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps128404 = nil
			end

			local var_105_2 = arg_102_1.actors_["128404"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos128404 = var_105_2.localPosition
				var_105_2.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("128404", 2)

				for iter_105_4 = 0, var_105_2.childCount - 1 do
					local var_105_3 = var_105_2:GetChild(iter_105_4)

					if var_105_3.name == "split_6" then
						var_105_3:SetAsLastSibling()
						var_105_3.gameObject:SetActive(true)

						arg_102_1.var_.actorSpriteSplit128404 = var_105_3.gameObject:GetComponent(typeof(Image))

						arg_102_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_105_4 = 0.5

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				var_105_2.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_102_1.time_ - 0) / var_105_4)

				if arg_102_1.var_.actorSpriteSplit128404 ~= nil then
					arg_102_1.var_.actorSpriteSplit128404:SetAlpha((arg_102_1.time_ - 0) / var_105_4)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				var_105_2.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_102_1.var_.actorSpriteSplit128404 ~= nil then
					arg_102_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_105_5 = 0
			local var_105_6 = 0.125

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(938042025).content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 5 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 5)

				if (5 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 5)) > 0 and var_105_6 < var_105_9 then
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play938042026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938042026
		arg_106_1.duration_ = 1

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"

			SetActive(arg_106_1.choicesGo_, true)

			for iter_107_0, iter_107_1 in ipairs(arg_106_1.choices_) do
				SetActive(iter_107_1.go, iter_107_0 <= 1)
			end

			arg_106_1.choices_[1].txt.text = arg_106_1:FormatText(StoryChoiceCfg[1787].name)
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938042027(arg_106_1)
			end

			arg_106_1:RecordChoiceLog(938042026, 1787)
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["128404"]) and arg_106_1.var_.actorSpriteComps128404 == nil then
				arg_106_1.var_.actorSpriteComps128404 = arg_106_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["128404"]) then
				if arg_106_1.var_.actorSpriteComps128404 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["128404"]) and arg_106_1.var_.actorSpriteComps128404 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps128404 = nil
			end

			local var_109_2 = 0

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.allBtn_.enabled = false
			end

			if arg_106_1.time_ >= var_109_2 + 0.5 and arg_106_1.time_ < var_109_2 + 0.5 + arg_109_0 then
				arg_106_1.allBtn_.enabled = true
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play938042027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938042027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938042028(arg_110_1)
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

				arg_110_1:CheckSpriteTmpPos("128404", 2)

				for iter_113_4 = 0, var_113_2.childCount - 1 do
					local var_113_3 = var_113_2:GetChild(iter_113_4)

					if var_113_3.name == "split_4" then
						var_113_3:SetAsLastSibling()
						var_113_3.gameObject:SetActive(true)

						arg_110_1.var_.actorSpriteSplit128404 = var_113_3.gameObject:GetComponent(typeof(Image))

						arg_110_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_113_4 = 0.5

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_110_1.time_ - 0) / var_113_4)

				if arg_110_1.var_.actorSpriteSplit128404 ~= nil then
					arg_110_1.var_.actorSpriteSplit128404:SetAlpha((arg_110_1.time_ - 0) / var_113_4)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_110_1.var_.actorSpriteSplit128404 ~= nil then
					arg_110_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_113_5 = 0
			local var_113_6 = 0.175

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

				local var_113_7 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(938042027).content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 7 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 7)

				if (7 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 7)) > 0 and var_113_6 < var_113_9 then
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
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play938042028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938042028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938042029(arg_114_1)
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

			local var_117_2 = 0
			local var_117_3 = 0.175

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_4 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(938042028).content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 7 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 7)

				if (7 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 7)) > 0 and var_117_3 < var_117_6 then
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

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play938042029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938042029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938042030(arg_118_1)
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

			local var_121_2 = arg_118_1.actors_["128404"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos128404 = var_121_2.localPosition
				var_121_2.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("128404", 2)

				for iter_121_4 = 0, var_121_2.childCount - 1 do
					local var_121_3 = var_121_2:GetChild(iter_121_4)

					if var_121_3.name == "split_2" then
						var_121_3:SetAsLastSibling()
						var_121_3.gameObject:SetActive(true)

						arg_118_1.var_.actorSpriteSplit128404 = var_121_3.gameObject:GetComponent(typeof(Image))

						arg_118_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_121_4 = 0.5

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_2.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_118_1.time_ - 0) / var_121_4)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha((arg_118_1.time_ - 0) / var_121_4)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_2.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_118_1.var_.actorSpriteSplit128404 ~= nil then
					arg_118_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_121_5 = 0
			local var_121_6 = 0.15

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
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

				local var_121_7 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(938042029).content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 6 <= 0 and var_121_6 or var_121_6 * (utf8.len(var_121_7) / 6)

				if (6 <= 0 and var_121_6 or var_121_6 * (utf8.len(var_121_7) / 6)) > 0 and var_121_6 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_5 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_5
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_6, arg_118_1.talkMaxDuration)

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_5) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_5 + var_121_10 and arg_118_1.time_ < var_121_5 + var_121_10 + arg_121_0 then
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
	Play938042030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938042030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938042031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["128404"]) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = arg_122_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["128404"]) then
				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 0.5, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["128404"]) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_2 = 0
			local var_125_3 = 0.275

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_4 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(938042030).content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 11 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_4) / 11)

				if (11 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_4) / 11)) > 0 and var_125_3 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_7 and arg_122_1.time_ < var_125_2 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play938042031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938042031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938042032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["128404"]) and arg_126_1.var_.actorSpriteComps128404 == nil then
				arg_126_1.var_.actorSpriteComps128404 = arg_126_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["128404"]) then
				if arg_126_1.var_.actorSpriteComps128404 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["128404"]) and arg_126_1.var_.actorSpriteComps128404 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_126_1.var_.actorSpriteComps128404 = nil
			end

			local var_129_2 = arg_126_1.actors_["128404"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos128404 = var_129_2.localPosition
				var_129_2.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("128404", 2)

				for iter_129_4 = 0, var_129_2.childCount - 1 do
					local var_129_3 = var_129_2:GetChild(iter_129_4)

					if var_129_3.name == "split_1" then
						var_129_3:SetAsLastSibling()
						var_129_3.gameObject:SetActive(true)

						arg_126_1.var_.actorSpriteSplit128404 = var_129_3.gameObject:GetComponent(typeof(Image))

						arg_126_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_129_4 = 0.5

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_2.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_126_1.time_ - 0) / var_129_4)

				if arg_126_1.var_.actorSpriteSplit128404 ~= nil then
					arg_126_1.var_.actorSpriteSplit128404:SetAlpha((arg_126_1.time_ - 0) / var_129_4)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_2.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_126_1.var_.actorSpriteSplit128404 ~= nil then
					arg_126_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_129_5 = 0
			local var_129_6 = 0.325

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(938042031).content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 13 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 13)

				if (13 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 13)) > 0 and var_129_6 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_10 and arg_126_1.time_ < var_129_5 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play938042032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938042032
		arg_130_1.duration_ = 9

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938042033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if arg_130_1.bgs_.ST84 == nil then
				local var_133_0 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST84")
				var_133_0.name = "ST84"
				var_133_0.transform.parent = arg_130_1.stage_.transform
				var_133_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_.ST84 = var_133_0
			end

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= 2 + arg_133_0 then
				local var_133_1 = arg_130_1.bgs_.ST84

				arg_130_1.bgs_.ST84.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_133_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_2 = var_133_1:GetComponent("SpriteRenderer")

				if var_133_2 and var_133_2.sprite then
					local var_133_3 = 2 * (var_133_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_133_1.transform.localScale = Vector3.New(var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, var_133_3 / var_133_2.sprite.bounds.size.y < var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x and var_133_3 * manager.ui.mainCameraCom_.aspect / var_133_2.sprite.bounds.size.x or var_133_3 / var_133_2.sprite.bounds.size.y, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST84" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_4 = 3.999999999999

			if 3.999999999999 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			if arg_130_1.time_ >= var_133_4 + 0.3 and arg_130_1.time_ < var_133_4 + 0.3 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_5 = 0

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_6 = 2

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 then
				local var_133_7 = Color.New(0, 0, 0)

				var_133_7.a = Mathf.Lerp(0, 1, (arg_130_1.time_ - var_133_5) / var_133_6)
				arg_130_1.mask_.color = var_133_7
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 then
				local var_133_8 = Color.New(0, 0, 0)

				var_133_8.a = 1
				arg_130_1.mask_.color = var_133_8
			end

			local var_133_9 = 2

			if 2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_10 = 2

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_10 then
				local var_133_11 = Color.New(0, 0, 0)

				var_133_11.a = Mathf.Lerp(1, 0, (arg_130_1.time_ - var_133_9) / var_133_10)
				arg_130_1.mask_.color = var_133_11
			end

			if arg_130_1.time_ >= var_133_9 + var_133_10 and arg_130_1.time_ < var_133_9 + var_133_10 + arg_133_0 then
				local var_133_12 = Color.New(0, 0, 0)

				arg_130_1.mask_.enabled = false
				var_133_12.a = 0
				arg_130_1.mask_.color = var_133_12
			end

			local var_133_13 = arg_130_1.actors_["128404"]

			if 1.966 < arg_130_1.time_ and arg_130_1.time_ <= 1.966 + arg_133_0 and not isNil(var_133_13) and arg_130_1.var_.actorSpriteComps128404 == nil then
				arg_130_1.var_.actorSpriteComps128404 = var_133_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_14 = 0.034

			if 1.966 <= arg_130_1.time_ and arg_130_1.time_ < 1.966 + var_133_14 and not isNil(var_133_13) then
				if arg_130_1.var_.actorSpriteComps128404 then
					for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_133_3 then
							if arg_130_1.isInRecall_ then
								iter_133_3.color = Color.New(Mathf.Lerp(iter_133_3.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 1.966) / var_133_14), Mathf.Lerp(iter_133_3.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 1.966) / var_133_14), (Mathf.Lerp(iter_133_3.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 1.966) / var_133_14)))
							else
								local var_133_15 = Mathf.Lerp(iter_133_3.color.r, 0.5, (arg_130_1.time_ - 1.966) / var_133_14)

								iter_133_3.color = Color.New(var_133_15, var_133_15, var_133_15)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 1.966 + var_133_14 and arg_130_1.time_ < 1.966 + var_133_14 + arg_133_0 and not isNil(var_133_13) and arg_130_1.var_.actorSpriteComps128404 then
				for iter_133_4, iter_133_5 in pairs(arg_130_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_133_5 then
						iter_133_5.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps128404 = nil
			end

			local var_133_16 = arg_130_1.actors_["128404"].transform

			if 1.966 < arg_130_1.time_ and arg_130_1.time_ <= 1.966 + arg_133_0 then
				arg_130_1.var_.moveOldPos128404 = var_133_16.localPosition
				var_133_16.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("128404", 7)

				for iter_133_6 = 0, var_133_16.childCount - 1 do
					local var_133_17 = var_133_16:GetChild(iter_133_6)

					if var_133_17.name == "" or not string.find(var_133_17.name, "split") then
						var_133_17.gameObject:SetActive(true)
					else
						var_133_17.gameObject:SetActive(false)
					end
				end
			end

			local var_133_18 = 0.001

			if 1.966 <= arg_130_1.time_ and arg_130_1.time_ < 1.966 + var_133_18 then
				var_133_16.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 1.966) / var_133_18)
			end

			if arg_130_1.time_ >= 1.966 + var_133_18 and arg_130_1.time_ < 1.966 + var_133_18 + arg_133_0 then
				var_133_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_19 = arg_130_1.actors_["10144"].transform

			if 1.966 < arg_130_1.time_ and arg_130_1.time_ <= 1.966 + arg_133_0 then
				arg_130_1.var_.moveOldPos10144 = var_133_19.localPosition
				var_133_19.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10144", 7)

				for iter_133_7 = 0, var_133_19.childCount - 1 do
					local var_133_20 = var_133_19:GetChild(iter_133_7)

					if var_133_20.name == "" or not string.find(var_133_20.name, "split") then
						var_133_20.gameObject:SetActive(true)
					else
						var_133_20.gameObject:SetActive(false)
					end
				end
			end

			local var_133_21 = 0.001

			if 1.966 <= arg_130_1.time_ and arg_130_1.time_ < 1.966 + var_133_21 then
				var_133_19.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 1.966) / var_133_21)
			end

			if arg_130_1.time_ >= 1.966 + var_133_21 and arg_130_1.time_ < 1.966 + var_133_21 + arg_133_0 then
				var_133_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.999999999999 < arg_130_1.time_ and arg_130_1.time_ <= 2.999999999999 + arg_133_0 then
				arg_130_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 2.299999999999 < arg_130_1.time_ and arg_130_1.time_ <= 2.299999999999 + arg_133_0 then
				arg_130_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 2.999999999999 < arg_130_1.time_ and arg_130_1.time_ <= 2.999999999999 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_133_26 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_26 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_26

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_26
						arg_130_1.bgmTxt2_.text = var_133_26
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_27 = 4
			local var_133_28 = 1.1

			if 4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_27 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_29 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_29:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_130_1.dialogCg_.alpha = arg_135_0
				end))
				var_133_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_30 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(938042032).content)

				arg_130_1.text_.text = var_133_30

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_32 = 44 <= 0 and var_133_28 or var_133_28 * (utf8.len(var_133_30) / 44)

				if (44 <= 0 and var_133_28 or var_133_28 * (utf8.len(var_133_30) / 44)) > 0 and var_133_28 < var_133_32 then
					arg_130_1.talkMaxDuration = var_133_32
					var_133_27 = var_133_27 + 0.3

					if var_133_32 + var_133_27 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_32 + var_133_27
					end
				end

				arg_130_1.text_.text = var_133_30
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_33 = var_133_27 + 0.3
			local var_133_34 = math.max(var_133_28, arg_130_1.talkMaxDuration)

			if var_133_27 + 0.3 <= arg_130_1.time_ and arg_130_1.time_ < var_133_33 + var_133_34 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_33) / var_133_34

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_33 + var_133_34 and arg_130_1.time_ < var_133_33 + var_133_34 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play938042033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 938042033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play938042034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["128404"]) and arg_137_1.var_.actorSpriteComps128404 == nil then
				arg_137_1.var_.actorSpriteComps128404 = arg_137_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["128404"]) then
				if arg_137_1.var_.actorSpriteComps128404 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 1, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["128404"]) and arg_137_1.var_.actorSpriteComps128404 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps128404 = nil
			end

			local var_140_2 = arg_137_1.actors_["128404"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos128404 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("128404", 3)

				for iter_140_4 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_4)

					if var_140_3.name == "split_2" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_140_5 = 0
			local var_140_6 = 0.6

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(938042033).content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 24 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 24)

				if (24 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_7) / 24)) > 0 and var_140_6 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_10 and arg_137_1.time_ < var_140_5 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play938042034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 938042034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play938042035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["128404"]) and arg_141_1.var_.actorSpriteComps128404 == nil then
				arg_141_1.var_.actorSpriteComps128404 = arg_141_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["128404"]) then
				if arg_141_1.var_.actorSpriteComps128404 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["128404"]) and arg_141_1.var_.actorSpriteComps128404 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps128404 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 0.675

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_4 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(938042034).content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 27 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 27)

				if (27 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 27)) > 0 and var_144_3 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_7 and arg_141_1.time_ < var_144_2 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play938042035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 938042035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play938042036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["128404"]) and arg_145_1.var_.actorSpriteComps128404 == nil then
				arg_145_1.var_.actorSpriteComps128404 = arg_145_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["128404"]) then
				if arg_145_1.var_.actorSpriteComps128404 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 1, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["128404"]) and arg_145_1.var_.actorSpriteComps128404 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps128404 = nil
			end

			local var_148_2 = arg_145_1.actors_["128404"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos128404 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("128404", 3)

				for iter_148_4 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_4)

					if var_148_3.name == "split_1" then
						var_148_3:SetAsLastSibling()
						var_148_3.gameObject:SetActive(true)

						arg_145_1.var_.actorSpriteSplit128404 = var_148_3.gameObject:GetComponent(typeof(Image))

						arg_145_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_148_4 = 0.5

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_145_1.time_ - 0) / var_148_4)

				if arg_145_1.var_.actorSpriteSplit128404 ~= nil then
					arg_145_1.var_.actorSpriteSplit128404:SetAlpha((arg_145_1.time_ - 0) / var_148_4)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_145_1.var_.actorSpriteSplit128404 ~= nil then
					arg_145_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_148_5 = 0
			local var_148_6 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(938042035).content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 17 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 17)

				if (17 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 17)) > 0 and var_148_6 < var_148_9 then
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play938042036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 938042036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play938042037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = arg_149_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["128404"]) then
				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.55

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(938042036).content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 22 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 22)

				if (22 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 22)) > 0 and var_152_3 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_7 and arg_149_1.time_ < var_152_2 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play938042037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 938042037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play938042038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["128404"]) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = arg_153_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["128404"]) then
				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["128404"]) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_2 = arg_153_1.actors_["128404"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos128404 = var_156_2.localPosition
				var_156_2.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("128404", 3)

				for iter_156_4 = 0, var_156_2.childCount - 1 do
					local var_156_3 = var_156_2:GetChild(iter_156_4)

					if var_156_3.name == "split_4" then
						var_156_3:SetAsLastSibling()
						var_156_3.gameObject:SetActive(true)

						arg_153_1.var_.actorSpriteSplit128404 = var_156_3.gameObject:GetComponent(typeof(Image))

						arg_153_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_156_4 = 0.5

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_153_1.time_ - 0) / var_156_4)

				if arg_153_1.var_.actorSpriteSplit128404 ~= nil then
					arg_153_1.var_.actorSpriteSplit128404:SetAlpha((arg_153_1.time_ - 0) / var_156_4)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_153_1.var_.actorSpriteSplit128404 ~= nil then
					arg_153_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_156_5 = 0
			local var_156_6 = 0.075

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(938042037).content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 3 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_7) / 3)

				if (3 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_7) / 3)) > 0 and var_156_6 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_10 and arg_153_1.time_ < var_156_5 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play938042038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 938042038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play938042039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["128404"]) and arg_157_1.var_.actorSpriteComps128404 == nil then
				arg_157_1.var_.actorSpriteComps128404 = arg_157_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["128404"]) then
				if arg_157_1.var_.actorSpriteComps128404 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["128404"]) and arg_157_1.var_.actorSpriteComps128404 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps128404 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 1.025

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(938042038).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 41 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 41)

				if (41 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 41)) > 0 and var_160_3 < var_160_6 then
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

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play938042039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 938042039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play938042040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["128404"]) and arg_161_1.var_.actorSpriteComps128404 == nil then
				arg_161_1.var_.actorSpriteComps128404 = arg_161_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["128404"]) then
				if arg_161_1.var_.actorSpriteComps128404 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 1, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["128404"]) and arg_161_1.var_.actorSpriteComps128404 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps128404 = nil
			end

			local var_164_2 = arg_161_1.actors_["128404"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos128404 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("128404", 3)

				for iter_164_4 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_4)

					if var_164_3.name == "split_5" then
						var_164_3:SetAsLastSibling()
						var_164_3.gameObject:SetActive(true)

						arg_161_1.var_.actorSpriteSplit128404 = var_164_3.gameObject:GetComponent(typeof(Image))

						arg_161_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_164_4 = 0.5

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_161_1.time_ - 0) / var_164_4)

				if arg_161_1.var_.actorSpriteSplit128404 ~= nil then
					arg_161_1.var_.actorSpriteSplit128404:SetAlpha((arg_161_1.time_ - 0) / var_164_4)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_161_1.var_.actorSpriteSplit128404 ~= nil then
					arg_161_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_164_5 = 0
			local var_164_6 = 0.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(938042039).content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 17 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_7) / 17)

				if (17 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_7) / 17)) > 0 and var_164_6 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_10 and arg_161_1.time_ < var_164_5 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play938042040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 938042040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play938042041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["128404"]) and arg_165_1.var_.actorSpriteComps128404 == nil then
				arg_165_1.var_.actorSpriteComps128404 = arg_165_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["128404"]) then
				if arg_165_1.var_.actorSpriteComps128404 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["128404"]) and arg_165_1.var_.actorSpriteComps128404 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps128404 = nil
			end

			local var_168_2 = 0
			local var_168_3 = 0.325

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_4 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(938042040).content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 13 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 13)

				if (13 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 13)) > 0 and var_168_3 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_7 and arg_165_1.time_ < var_168_2 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play938042041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 938042041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play938042042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["128404"]) and arg_169_1.var_.actorSpriteComps128404 == nil then
				arg_169_1.var_.actorSpriteComps128404 = arg_169_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["128404"]) then
				if arg_169_1.var_.actorSpriteComps128404 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["128404"]) and arg_169_1.var_.actorSpriteComps128404 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps128404 = nil
			end

			local var_172_2 = arg_169_1.actors_["128404"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos128404 = var_172_2.localPosition
				var_172_2.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("128404", 3)

				for iter_172_4 = 0, var_172_2.childCount - 1 do
					local var_172_3 = var_172_2:GetChild(iter_172_4)

					if var_172_3.name == "split_3" then
						var_172_3:SetAsLastSibling()
						var_172_3.gameObject:SetActive(true)

						arg_169_1.var_.actorSpriteSplit128404 = var_172_3.gameObject:GetComponent(typeof(Image))

						arg_169_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_172_4 = 0.5

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_2.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_169_1.time_ - 0) / var_172_4)

				if arg_169_1.var_.actorSpriteSplit128404 ~= nil then
					arg_169_1.var_.actorSpriteSplit128404:SetAlpha((arg_169_1.time_ - 0) / var_172_4)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_169_1.var_.actorSpriteSplit128404 ~= nil then
					arg_169_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_172_5 = 0
			local var_172_6 = 0.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(938042041).content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 20 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 20)

				if (20 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 20)) > 0 and var_172_6 < var_172_9 then
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play938042042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 938042042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play938042043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["128404"]) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = arg_173_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["128404"]) then
				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["128404"]) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_2 = 0
			local var_176_3 = 0.125

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_4 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(938042042).content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_6 = 5 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 5)

				if (5 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 5)) > 0 and var_176_3 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_7 and arg_173_1.time_ < var_176_2 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play938042043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 938042043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play938042044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["128404"]) and arg_177_1.var_.actorSpriteComps128404 == nil then
				arg_177_1.var_.actorSpriteComps128404 = arg_177_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["128404"]) then
				if arg_177_1.var_.actorSpriteComps128404 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["128404"]) and arg_177_1.var_.actorSpriteComps128404 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps128404 = nil
			end

			local var_180_2 = arg_177_1.actors_["128404"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 3)

				for iter_180_4 = 0, var_180_2.childCount - 1 do
					local var_180_3 = var_180_2:GetChild(iter_180_4)

					if var_180_3.name == "split_4" then
						var_180_3:SetAsLastSibling()
						var_180_3.gameObject:SetActive(true)

						arg_177_1.var_.actorSpriteSplit128404 = var_180_3.gameObject:GetComponent(typeof(Image))

						arg_177_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_180_4 = 0.5

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_177_1.time_ - 0) / var_180_4)

				if arg_177_1.var_.actorSpriteSplit128404 ~= nil then
					arg_177_1.var_.actorSpriteSplit128404:SetAlpha((arg_177_1.time_ - 0) / var_180_4)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_177_1.var_.actorSpriteSplit128404 ~= nil then
					arg_177_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_180_5 = 0
			local var_180_6 = 0.525

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(938042043).content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 21 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_7) / 21)

				if (21 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_7) / 21)) > 0 and var_180_6 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_10 and arg_177_1.time_ < var_180_5 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play938042044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 938042044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play938042045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["128404"]) and arg_181_1.var_.actorSpriteComps128404 == nil then
				arg_181_1.var_.actorSpriteComps128404 = arg_181_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["128404"]) then
				if arg_181_1.var_.actorSpriteComps128404 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["128404"]) and arg_181_1.var_.actorSpriteComps128404 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps128404 = nil
			end

			local var_184_2 = 0
			local var_184_3 = 0.325

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_4 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(938042044).content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_6 = 13 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 13)

				if (13 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_4) / 13)) > 0 and var_184_3 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_7 and arg_181_1.time_ < var_184_2 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play938042045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 938042045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play938042046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["128404"]) and arg_185_1.var_.actorSpriteComps128404 == nil then
				arg_185_1.var_.actorSpriteComps128404 = arg_185_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["128404"]) then
				if arg_185_1.var_.actorSpriteComps128404 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 1, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["128404"]) and arg_185_1.var_.actorSpriteComps128404 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps128404 = nil
			end

			local var_188_2 = arg_185_1.actors_["128404"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos128404 = var_188_2.localPosition
				var_188_2.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("128404", 3)

				for iter_188_4 = 0, var_188_2.childCount - 1 do
					local var_188_3 = var_188_2:GetChild(iter_188_4)

					if var_188_3.name == "split_6" then
						var_188_3:SetAsLastSibling()
						var_188_3.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit128404 = var_188_3.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_188_4 = 0.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				var_188_2.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_185_1.time_ - 0) / var_188_4)

				if arg_185_1.var_.actorSpriteSplit128404 ~= nil then
					arg_185_1.var_.actorSpriteSplit128404:SetAlpha((arg_185_1.time_ - 0) / var_188_4)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				var_188_2.localPosition = Vector3.New(-16.1, -362, -375)

				if arg_185_1.var_.actorSpriteSplit128404 ~= nil then
					arg_185_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_188_5 = 0
			local var_188_6 = 0.2

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(938042045).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 8 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 8)

				if (8 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 8)) > 0 and var_188_6 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_10 and arg_185_1.time_ < var_188_5 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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

		arg_185_1:InitPlayNodeList()
	end,
	Play938042046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 938042046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play938042047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["128404"]) and arg_189_1.var_.actorSpriteComps128404 == nil then
				arg_189_1.var_.actorSpriteComps128404 = arg_189_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["128404"]) then
				if arg_189_1.var_.actorSpriteComps128404 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["128404"]) and arg_189_1.var_.actorSpriteComps128404 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps128404 = nil
			end

			local var_192_2 = 0
			local var_192_3 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_4 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(938042046).content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 26 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 26)

				if (26 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 26)) > 0 and var_192_3 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_7 and arg_189_1.time_ < var_192_2 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play938042047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 938042047
		arg_193_1.duration_ = 7.53

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play938042048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_9000

			if arg_193_1.bgs_.H02b == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02b")
				var_196_0.name = "H02b"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.H02b = var_196_0
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.H02b

				arg_193_1.bgs_.H02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "H02b" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0.7

			if 0.7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_4 + 0.3 and arg_193_1.time_ < var_196_4 + 0.3 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_5 = arg_193_1.var_.effectquwanghaitan1

				if not arg_193_1.var_.effectquwanghaitan1 then
					var_196_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zflash"), manager.ui.mainCamera.transform)
					var_196_5.name = "quwanghaitan1"
					arg_193_1.var_.effectquwanghaitan1 = var_196_5
				else
					var_196_5.transform:SetParent(var_196_9000)
				end

				var_196_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_196_7 = arg_193_1.actors_["128404"].transform

			if 0.7 < arg_193_1.time_ and arg_193_1.time_ <= 0.7 + arg_196_0 then
				arg_193_1.var_.moveOldPos128404 = var_196_7.localPosition
				var_196_7.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("128404", 7)

				for iter_196_2 = 0, var_196_7.childCount - 1 do
					local var_196_8 = var_196_7:GetChild(iter_196_2)

					if var_196_8.name == "" or not string.find(var_196_8.name, "split") then
						var_196_8.gameObject:SetActive(true)
					else
						var_196_8.gameObject:SetActive(false)
					end
				end
			end

			local var_196_9 = 0.001

			if 0.7 <= arg_193_1.time_ and arg_193_1.time_ < 0.7 + var_196_9 then
				var_196_7.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0.7) / var_196_9)
			end

			if arg_193_1.time_ >= 0.7 + var_196_9 and arg_193_1.time_ < 0.7 + var_196_9 + arg_196_0 then
				var_196_7.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				arg_193_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0.3 < arg_193_1.time_ and arg_193_1.time_ <= 0.3 + arg_196_0 then
				arg_193_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_196_12 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			if arg_193_1.time_ >= var_196_12 + 2.53333333333333 and arg_193_1.time_ < var_196_12 + 2.53333333333333 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_13 = 2.53333333333333
			local var_196_14 = 1.125

			if 2.53333333333333 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_15 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_15:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_16 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(938042047).content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_18 = 45 <= 0 and var_196_14 or var_196_14 * (utf8.len(var_196_16) / 45)

				if (45 <= 0 and var_196_14 or var_196_14 * (utf8.len(var_196_16) / 45)) > 0 and var_196_14 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18
					var_196_13 = var_196_13 + 0.3

					if var_196_18 + var_196_13 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_13
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = var_196_13 + 0.3
			local var_196_20 = math.max(var_196_14, arg_193_1.talkMaxDuration)

			if var_196_13 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_19) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play938042048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 938042048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play938042049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.175

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(938042048).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 7)

				if (7 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 7)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play938042049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 938042049
		arg_203_1.duration_ = 5.28

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play938042050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10183"]) and arg_203_1.var_.actorSpriteComps10183 == nil then
				arg_203_1.var_.actorSpriteComps10183 = arg_203_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10183"]) then
				if arg_203_1.var_.actorSpriteComps10183 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10183"]) and arg_203_1.var_.actorSpriteComps10183 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps10183 = nil
			end

			local var_206_2 = arg_203_1.actors_["10183"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10183 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10183", 3)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_203_1.time_ - 0) / var_206_4)
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(0, -475, -325)
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_5 = arg_203_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_206_5 then
					arg_203_1.var_.alphaOldValue10183 = var_206_5.alpha
					arg_203_1.var_.characterEffect10183 = var_206_5
				end

				arg_203_1.var_.alphaOldValue10183 = 0
			end

			local var_206_6 = 0.5

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_6 then
				if arg_203_1.var_.characterEffect10183 then
					arg_203_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_203_1.var_.alphaOldValue10183, 1, (arg_203_1.time_ - 0) / var_206_6)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_6 and arg_203_1.time_ < 0 + var_206_6 + arg_206_0 and arg_203_1.var_.characterEffect10183 then
				arg_203_1.var_.characterEffect10183.alpha = 1
			end

			local var_206_7 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_7 + 0.5 and arg_203_1.time_ < var_206_7 + 0.5 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_8 = 0.275
			local var_206_9 = 0.225

			if 0.275 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_10 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_10:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_11 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(938042049).content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 9 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 9)

				if (9 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_11) / 9)) > 0 and var_206_9 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13
					var_206_8 = var_206_8 + 0.3

					if var_206_13 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = var_206_8 + 0.3
			local var_206_15 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_15 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_14) / var_206_15

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_14 + var_206_15 and arg_203_1.time_ < var_206_14 + var_206_15 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play938042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 938042050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play938042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10183"]) and arg_209_1.var_.actorSpriteComps10183 == nil then
				arg_209_1.var_.actorSpriteComps10183 = arg_209_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10183"]) then
				if arg_209_1.var_.actorSpriteComps10183 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10183"]) and arg_209_1.var_.actorSpriteComps10183 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10183 = nil
			end

			local var_212_2 = arg_209_1.actors_["10183"].transform

			if 0.5 < arg_209_1.time_ and arg_209_1.time_ <= 0.5 + arg_212_0 then
				arg_209_1.var_.moveOldPos10183 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10183", 7)

				for iter_212_4 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_4)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0.5 <= arg_209_1.time_ and arg_209_1.time_ < 0.5 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_209_1.time_ - 0.5) / var_212_4)
			end

			if arg_209_1.time_ >= 0.5 + var_212_4 and arg_209_1.time_ < 0.5 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				local var_212_5 = arg_209_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_5 then
					arg_209_1.var_.alphaOldValue10183 = var_212_5.alpha
					arg_209_1.var_.characterEffect10183 = var_212_5
				end

				arg_209_1.var_.alphaOldValue10183 = 1
			end

			local var_212_6 = 0.5

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 then
				if arg_209_1.var_.characterEffect10183 then
					arg_209_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_209_1.var_.alphaOldValue10183, 0, (arg_209_1.time_ - 0) / var_212_6)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and arg_209_1.var_.characterEffect10183 then
				arg_209_1.var_.characterEffect10183.alpha = 0
			end

			if 0.5 < arg_209_1.time_ and arg_209_1.time_ <= 0.5 + arg_212_0 then
				local var_212_7 = arg_209_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_7 then
					arg_209_1.var_.alphaOldValue10183 = var_212_7.alpha
					arg_209_1.var_.characterEffect10183 = var_212_7
				end

				arg_209_1.var_.alphaOldValue10183 = 0
			end

			local var_212_8 = 0.034

			if 0.5 <= arg_209_1.time_ and arg_209_1.time_ < 0.5 + var_212_8 then
				if arg_209_1.var_.characterEffect10183 then
					arg_209_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_209_1.var_.alphaOldValue10183, 1, (arg_209_1.time_ - 0.5) / var_212_8)
				end
			end

			if arg_209_1.time_ >= 0.5 + var_212_8 and arg_209_1.time_ < 0.5 + var_212_8 + arg_212_0 and arg_209_1.var_.characterEffect10183 then
				arg_209_1.var_.characterEffect10183.alpha = 1
			end

			local var_212_9 = 0
			local var_212_10 = 1.55

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(938042050).content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 62 <= 0 and var_212_10 or var_212_10 * (utf8.len(var_212_11) / 62)

				if (62 <= 0 and var_212_10 or var_212_10 * (utf8.len(var_212_11) / 62)) > 0 and var_212_10 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_9 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_9
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_10, arg_209_1.talkMaxDuration)

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_9) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_9 + var_212_14 and arg_209_1.time_ < var_212_9 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play938042051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 938042051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play938042052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10183"]) and arg_213_1.var_.actorSpriteComps10183 == nil then
				arg_213_1.var_.actorSpriteComps10183 = arg_213_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10183"]) then
				if arg_213_1.var_.actorSpriteComps10183 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10183"]) and arg_213_1.var_.actorSpriteComps10183 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10183 = nil
			end

			local var_216_2 = arg_213_1.actors_["10183"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10183 = var_216_2.localPosition
				var_216_2.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10183", 3)

				for iter_216_4 = 0, var_216_2.childCount - 1 do
					local var_216_3 = var_216_2:GetChild(iter_216_4)

					if var_216_3.name == "split_5" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				var_216_2.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_213_1.time_ - 0) / var_216_4)
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				var_216_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_216_5 = 0
			local var_216_6 = 0.625

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(938042051).content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 25 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 25)

				if (25 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 25)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_10 and arg_213_1.time_ < var_216_5 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play938042052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 938042052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play938042053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10183 = arg_217_1.actors_["10183"].transform.localPosition
				arg_217_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10183", 3)

				for iter_220_0 = 0, arg_217_1.actors_["10183"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10183"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_7" then
						var_220_0:SetAsLastSibling()
						var_220_0.gameObject:SetActive(true)

						arg_217_1.var_.actorSpriteSplit10183 = var_220_0.gameObject:GetComponent(typeof(Image))

						arg_217_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_220_1 = 0.5

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_217_1.time_ - 0) / var_220_1)

				if arg_217_1.var_.actorSpriteSplit10183 ~= nil then
					arg_217_1.var_.actorSpriteSplit10183:SetAlpha((arg_217_1.time_ - 0) / var_220_1)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_217_1.var_.actorSpriteSplit10183 ~= nil then
					arg_217_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_220_2 = 0
			local var_220_3 = 0.675

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(938042052).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 27)

				if (27 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 27)) > 0 and var_220_3 < var_220_6 then
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

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play938042053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 938042053
		arg_221_1.duration_ = 1

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"

			SetActive(arg_221_1.choicesGo_, true)

			for iter_222_0, iter_222_1 in ipairs(arg_221_1.choices_) do
				SetActive(iter_222_1.go, iter_222_0 <= 2)
			end

			arg_221_1.choices_[1].txt.text = arg_221_1:FormatText(StoryChoiceCfg[1788].name)
			arg_221_1.choices_[2].txt.text = arg_221_1:FormatText(StoryChoiceCfg[1789].name)
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play938042054(arg_221_1)
			end

			if arg_223_0 == 2 then
				arg_221_0:Play938042054(arg_221_1)
			end

			arg_221_1:RecordChoiceLog(938042053, 1788, 1789)
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10183"]) and arg_221_1.var_.actorSpriteComps10183 == nil then
				arg_221_1.var_.actorSpriteComps10183 = arg_221_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10183"]) then
				if arg_221_1.var_.actorSpriteComps10183 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10183"]) and arg_221_1.var_.actorSpriteComps10183 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10183 = nil
			end

			local var_224_2 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_2 + 1 and arg_221_1.time_ < var_224_2 + 1 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play938042054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 938042054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play938042055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10183"]) and arg_225_1.var_.actorSpriteComps10183 == nil then
				arg_225_1.var_.actorSpriteComps10183 = arg_225_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10183"]) then
				if arg_225_1.var_.actorSpriteComps10183 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 1, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10183"]) and arg_225_1.var_.actorSpriteComps10183 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10183 = nil
			end

			local var_228_2 = arg_225_1.actors_["10183"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10183 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10183", 3)

				for iter_228_4 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_4)

					if var_228_3.name == "split_3" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_228_5 = manager.ui.mainCamera.transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.shakeOldPos = var_228_5.localPosition
			end

			local var_228_6 = 0.4

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 then
				local var_228_7, var_228_8 = math.modf((arg_225_1.time_ - 0) / 0.066)

				var_228_5.localPosition = Vector3.New(var_228_8 * 0.13, var_228_8 * 0.13, var_228_8 * 0.13) + arg_225_1.var_.shakeOldPos
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 then
				var_228_5.localPosition = arg_225_1.var_.shakeOldPos
			end

			local var_228_9 = 0
			local var_228_10 = 0.65

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_11 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(938042054).content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 26 <= 0 and var_228_10 or var_228_10 * (utf8.len(var_228_11) / 26)

				if (26 <= 0 and var_228_10 or var_228_10 * (utf8.len(var_228_11) / 26)) > 0 and var_228_10 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_9 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_9
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_10, arg_225_1.talkMaxDuration)

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_9) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_9 + var_228_14 and arg_225_1.time_ < var_228_9 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play938042055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 938042055
		arg_229_1.duration_ = 9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play938042056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				local var_232_0 = arg_229_1.bgs_.H02b

				arg_229_1.bgs_.H02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_1 = var_232_0:GetComponent("SpriteRenderer")

				if var_232_1 and var_232_1.sprite then
					local var_232_2 = 2 * (var_232_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_0.transform.localScale = Vector3.New(var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "H02b" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_3 = 3.999999999999

			if 3.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_3 + 0.3 and arg_229_1.time_ < var_232_3 + 0.3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			local var_232_12 = arg_229_1.actors_["10183"]

			if 1.966 < arg_229_1.time_ and arg_229_1.time_ <= 1.966 + arg_232_0 and not isNil(var_232_12) and arg_229_1.var_.actorSpriteComps10183 == nil then
				arg_229_1.var_.actorSpriteComps10183 = var_232_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_13 = 0.034

			if 1.966 <= arg_229_1.time_ and arg_229_1.time_ < 1.966 + var_232_13 and not isNil(var_232_12) then
				if arg_229_1.var_.actorSpriteComps10183 then
					for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_232_3 then
							if arg_229_1.isInRecall_ then
								iter_232_3.color = Color.New(Mathf.Lerp(iter_232_3.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 1.966) / var_232_13), Mathf.Lerp(iter_232_3.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 1.966) / var_232_13), (Mathf.Lerp(iter_232_3.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 1.966) / var_232_13)))
							else
								local var_232_14 = Mathf.Lerp(iter_232_3.color.r, 0.5, (arg_229_1.time_ - 1.966) / var_232_13)

								iter_232_3.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 1.966 + var_232_13 and arg_229_1.time_ < 1.966 + var_232_13 + arg_232_0 and not isNil(var_232_12) and arg_229_1.var_.actorSpriteComps10183 then
				for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_232_5 then
						iter_232_5.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10183 = nil
			end

			local var_232_15 = arg_229_1.actors_["10183"].transform

			if 1.966 < arg_229_1.time_ and arg_229_1.time_ <= 1.966 + arg_232_0 then
				arg_229_1.var_.moveOldPos10183 = var_232_15.localPosition
				var_232_15.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10183", 7)

				for iter_232_6 = 0, var_232_15.childCount - 1 do
					local var_232_16 = var_232_15:GetChild(iter_232_6)

					if var_232_16.name == "" or not string.find(var_232_16.name, "split") then
						var_232_16.gameObject:SetActive(true)
					else
						var_232_16.gameObject:SetActive(false)
					end
				end
			end

			local var_232_17 = 0.001

			if 1.966 <= arg_229_1.time_ and arg_229_1.time_ < 1.966 + var_232_17 then
				var_232_15.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_229_1.time_ - 1.966) / var_232_17)
			end

			if arg_229_1.time_ >= 1.966 + var_232_17 and arg_229_1.time_ < 1.966 + var_232_17 + arg_232_0 then
				var_232_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_18 = 4
			local var_232_19 = 0.35

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_20 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_20:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_21 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(938042055).content)

				arg_229_1.text_.text = var_232_21

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_23 = 14 <= 0 and var_232_19 or var_232_19 * (utf8.len(var_232_21) / 14)

				if (14 <= 0 and var_232_19 or var_232_19 * (utf8.len(var_232_21) / 14)) > 0 and var_232_19 < var_232_23 then
					arg_229_1.talkMaxDuration = var_232_23
					var_232_18 = var_232_18 + 0.3

					if var_232_23 + var_232_18 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_18
					end
				end

				arg_229_1.text_.text = var_232_21
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_24 = var_232_18 + 0.3
			local var_232_25 = math.max(var_232_19, arg_229_1.talkMaxDuration)

			if var_232_18 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_24 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_24) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_24 + var_232_25 and arg_229_1.time_ < var_232_24 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play938042056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 938042056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play938042057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10183"]) and arg_235_1.var_.actorSpriteComps10183 == nil then
				arg_235_1.var_.actorSpriteComps10183 = arg_235_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10183"]) then
				if arg_235_1.var_.actorSpriteComps10183 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10183"]) and arg_235_1.var_.actorSpriteComps10183 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10183 = nil
			end

			local var_238_2 = arg_235_1.actors_["10183"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10183 = var_238_2.localPosition
				var_238_2.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10183", 3)

				for iter_238_4 = 0, var_238_2.childCount - 1 do
					local var_238_3 = var_238_2:GetChild(iter_238_4)

					if var_238_3.name == "" or not string.find(var_238_3.name, "split") then
						var_238_3.gameObject:SetActive(true)
					else
						var_238_3.gameObject:SetActive(false)
					end
				end
			end

			local var_238_4 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				var_238_2.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_235_1.time_ - 0) / var_238_4)
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				var_238_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_238_5 = 0
			local var_238_6 = 0.125

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(938042056).content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 5 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_7) / 5)

				if (5 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_7) / 5)) > 0 and var_238_6 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_10 and arg_235_1.time_ < var_238_5 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play938042057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 938042057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play938042058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10183"]) and arg_239_1.var_.actorSpriteComps10183 == nil then
				arg_239_1.var_.actorSpriteComps10183 = arg_239_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10183"]) then
				if arg_239_1.var_.actorSpriteComps10183 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10183"]) and arg_239_1.var_.actorSpriteComps10183 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10183 = nil
			end

			local var_242_2 = 0
			local var_242_3 = 0.725

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_4 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(938042057).content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 29 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 29)

				if (29 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 29)) > 0 and var_242_3 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_7 and arg_239_1.time_ < var_242_2 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play938042058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 938042058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play938042059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10183"]) and arg_243_1.var_.actorSpriteComps10183 == nil then
				arg_243_1.var_.actorSpriteComps10183 = arg_243_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10183"]) then
				if arg_243_1.var_.actorSpriteComps10183 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 1, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10183"]) and arg_243_1.var_.actorSpriteComps10183 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps10183 = nil
			end

			local var_246_2 = arg_243_1.actors_["10183"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10183 = var_246_2.localPosition
				var_246_2.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10183", 3)

				for iter_246_4 = 0, var_246_2.childCount - 1 do
					local var_246_3 = var_246_2:GetChild(iter_246_4)

					if var_246_3.name == "split_4" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_2.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_243_1.time_ - 0) / var_246_4)
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_246_5 = 0
			local var_246_6 = 0.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(938042058).content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 8 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_7) / 8)

				if (8 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_7) / 8)) > 0 and var_246_6 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_10 and arg_243_1.time_ < var_246_5 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play938042059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 938042059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play938042060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10183"]) and arg_247_1.var_.actorSpriteComps10183 == nil then
				arg_247_1.var_.actorSpriteComps10183 = arg_247_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10183"]) then
				if arg_247_1.var_.actorSpriteComps10183 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10183"]) and arg_247_1.var_.actorSpriteComps10183 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps10183 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_4 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(938042059).content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 4 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 4)

				if (4 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_4) / 4)) > 0 and var_250_3 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_7 and arg_247_1.time_ < var_250_2 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play938042060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 938042060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play938042061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10183"]) and arg_251_1.var_.actorSpriteComps10183 == nil then
				arg_251_1.var_.actorSpriteComps10183 = arg_251_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10183"]) then
				if arg_251_1.var_.actorSpriteComps10183 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 1, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10183"]) and arg_251_1.var_.actorSpriteComps10183 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10183 = nil
			end

			local var_254_2 = arg_251_1.actors_["10183"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10183 = var_254_2.localPosition
				var_254_2.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10183", 3)

				for iter_254_4 = 0, var_254_2.childCount - 1 do
					local var_254_3 = var_254_2:GetChild(iter_254_4)

					if var_254_3.name == "" then
						var_254_3:SetAsLastSibling()
						var_254_3.gameObject:SetActive(true)

						arg_251_1.var_.actorSpriteSplit10183 = var_254_3.gameObject:GetComponent(typeof(Image))

						arg_251_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_254_4 = 0.5

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_2.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_251_1.time_ - 0) / var_254_4)

				if arg_251_1.var_.actorSpriteSplit10183 ~= nil then
					arg_251_1.var_.actorSpriteSplit10183:SetAlpha((arg_251_1.time_ - 0) / var_254_4)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_2.localPosition = Vector3.New(0, -475, -325)

				if arg_251_1.var_.actorSpriteSplit10183 ~= nil then
					arg_251_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_254_5 = 0
			local var_254_6 = 0.225

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(938042060).content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 9 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_7) / 9)

				if (9 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_7) / 9)) > 0 and var_254_6 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_10 and arg_251_1.time_ < var_254_5 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play938042061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 938042061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play938042062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10183"]) and arg_255_1.var_.actorSpriteComps10183 == nil then
				arg_255_1.var_.actorSpriteComps10183 = arg_255_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10183"]) then
				if arg_255_1.var_.actorSpriteComps10183 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10183"]) and arg_255_1.var_.actorSpriteComps10183 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10183 = nil
			end

			local var_258_2 = 0
			local var_258_3 = 0.175

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_4 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(938042061).content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 7 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 7)

				if (7 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 7)) > 0 and var_258_3 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_7 and arg_255_1.time_ < var_258_2 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play938042062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 938042062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play938042063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10183"]) and arg_259_1.var_.actorSpriteComps10183 == nil then
				arg_259_1.var_.actorSpriteComps10183 = arg_259_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10183"]) then
				if arg_259_1.var_.actorSpriteComps10183 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 1, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10183"]) and arg_259_1.var_.actorSpriteComps10183 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10183 = nil
			end

			local var_262_2 = arg_259_1.actors_["10183"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10183 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10183", 3)

				for iter_262_4 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_4)

					if var_262_3.name == "split_3" then
						var_262_3:SetAsLastSibling()
						var_262_3.gameObject:SetActive(true)

						arg_259_1.var_.actorSpriteSplit10183 = var_262_3.gameObject:GetComponent(typeof(Image))

						arg_259_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_262_4 = 0.5

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_259_1.time_ - 0) / var_262_4)

				if arg_259_1.var_.actorSpriteSplit10183 ~= nil then
					arg_259_1.var_.actorSpriteSplit10183:SetAlpha((arg_259_1.time_ - 0) / var_262_4)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(0, -475, -325)

				if arg_259_1.var_.actorSpriteSplit10183 ~= nil then
					arg_259_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_262_5 = 0
			local var_262_6 = 1

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(938042062).content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 40 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_7) / 40)

				if (40 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_7) / 40)) > 0 and var_262_6 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_10 and arg_259_1.time_ < var_262_5 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play938042063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 938042063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play938042064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10183"]) and arg_263_1.var_.actorSpriteComps10183 == nil then
				arg_263_1.var_.actorSpriteComps10183 = arg_263_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10183"]) then
				if arg_263_1.var_.actorSpriteComps10183 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10183"]) and arg_263_1.var_.actorSpriteComps10183 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10183 = nil
			end

			local var_266_2 = 0
			local var_266_3 = 0.2

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_4 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(938042063).content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 8 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 8)

				if (8 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_4) / 8)) > 0 and var_266_3 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_7 and arg_263_1.time_ < var_266_2 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play938042064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 938042064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play938042065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10183"]) and arg_267_1.var_.actorSpriteComps10183 == nil then
				arg_267_1.var_.actorSpriteComps10183 = arg_267_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10183"]) then
				if arg_267_1.var_.actorSpriteComps10183 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10183"]) and arg_267_1.var_.actorSpriteComps10183 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps10183 = nil
			end

			local var_270_2 = arg_267_1.actors_["10183"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10183 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10183", 3)

				for iter_270_4 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_4)

					if var_270_3.name == "" then
						var_270_3:SetAsLastSibling()
						var_270_3.gameObject:SetActive(true)

						arg_267_1.var_.actorSpriteSplit10183 = var_270_3.gameObject:GetComponent(typeof(Image))

						arg_267_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_270_4 = 0.5

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_267_1.time_ - 0) / var_270_4)

				if arg_267_1.var_.actorSpriteSplit10183 ~= nil then
					arg_267_1.var_.actorSpriteSplit10183:SetAlpha((arg_267_1.time_ - 0) / var_270_4)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(0, -475, -325)

				if arg_267_1.var_.actorSpriteSplit10183 ~= nil then
					arg_267_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_270_5 = 0
			local var_270_6 = 0.4

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(938042064).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 16 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 16)

				if (16 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 16)) > 0 and var_270_6 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_10 and arg_267_1.time_ < var_270_5 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play938042065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 938042065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play938042066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10183"]) and arg_271_1.var_.actorSpriteComps10183 == nil then
				arg_271_1.var_.actorSpriteComps10183 = arg_271_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10183"]) then
				if arg_271_1.var_.actorSpriteComps10183 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10183"]) and arg_271_1.var_.actorSpriteComps10183 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps10183 = nil
			end

			local var_274_2 = 0
			local var_274_3 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_4 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(938042065).content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_6 = 10 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_4) / 10)

				if (10 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_4) / 10)) > 0 and var_274_3 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_7 and arg_271_1.time_ < var_274_2 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play938042066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 938042066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play938042067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10183 = arg_275_1.actors_["10183"].transform.localPosition
				arg_275_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10183", 7)

				for iter_278_0 = 0, arg_275_1.actors_["10183"].transform.childCount - 1 do
					local var_278_0 = arg_275_1.actors_["10183"].transform:GetChild(iter_278_0)

					if var_278_0.name == "" or not string.find(var_278_0.name, "split") then
						var_278_0.gameObject:SetActive(true)
					else
						var_278_0.gameObject:SetActive(false)
					end
				end
			end

			local var_278_1 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 then
				arg_275_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_275_1.time_ - 0) / var_278_1)
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 then
				arg_275_1.actors_["10183"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_278_2 = 0
			local var_278_3 = 1.025

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(938042066).content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 41 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 41)

				if (41 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 41)) > 0 and var_278_3 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_7 and arg_275_1.time_ < var_278_2 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play938042067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 938042067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play938042068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10183"]) and arg_279_1.var_.actorSpriteComps10183 == nil then
				arg_279_1.var_.actorSpriteComps10183 = arg_279_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10183"]) then
				if arg_279_1.var_.actorSpriteComps10183 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 1, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10183"]) and arg_279_1.var_.actorSpriteComps10183 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10183 = nil
			end

			local var_282_2 = arg_279_1.actors_["10183"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10183 = var_282_2.localPosition
				var_282_2.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10183", 3)

				for iter_282_4 = 0, var_282_2.childCount - 1 do
					local var_282_3 = var_282_2:GetChild(iter_282_4)

					if var_282_3.name == "split_4" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_2.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_279_1.time_ - 0) / var_282_4)
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_282_5 = 0
			local var_282_6 = 0.65

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(938042067).content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 26 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 26)

				if (26 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 26)) > 0 and var_282_6 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_10 and arg_279_1.time_ < var_282_5 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play938042068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 938042068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play938042069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10183"]) and arg_283_1.var_.actorSpriteComps10183 == nil then
				arg_283_1.var_.actorSpriteComps10183 = arg_283_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10183"]) then
				if arg_283_1.var_.actorSpriteComps10183 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10183"]) and arg_283_1.var_.actorSpriteComps10183 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps10183 = nil
			end

			local var_286_2 = 0
			local var_286_3 = 0.25

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(938042068).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 10 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 10)

				if (10 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 10)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play938042069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 938042069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play938042070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10183"]) and arg_287_1.var_.actorSpriteComps10183 == nil then
				arg_287_1.var_.actorSpriteComps10183 = arg_287_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10183"]) then
				if arg_287_1.var_.actorSpriteComps10183 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 1, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10183"]) and arg_287_1.var_.actorSpriteComps10183 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10183 = nil
			end

			local var_290_2 = arg_287_1.actors_["10183"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10183 = var_290_2.localPosition
				var_290_2.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10183", 3)

				for iter_290_4 = 0, var_290_2.childCount - 1 do
					local var_290_3 = var_290_2:GetChild(iter_290_4)

					if var_290_3.name == "split_7" then
						var_290_3:SetAsLastSibling()
						var_290_3.gameObject:SetActive(true)

						arg_287_1.var_.actorSpriteSplit10183 = var_290_3.gameObject:GetComponent(typeof(Image))

						arg_287_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_290_4 = 0.5

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				var_290_2.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_287_1.time_ - 0) / var_290_4)

				if arg_287_1.var_.actorSpriteSplit10183 ~= nil then
					arg_287_1.var_.actorSpriteSplit10183:SetAlpha((arg_287_1.time_ - 0) / var_290_4)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				var_290_2.localPosition = Vector3.New(0, -475, -325)

				if arg_287_1.var_.actorSpriteSplit10183 ~= nil then
					arg_287_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_290_5 = 0
			local var_290_6 = 0.625

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_7 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(938042069).content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 25 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 25)

				if (25 <= 0 and var_290_6 or var_290_6 * (utf8.len(var_290_7) / 25)) > 0 and var_290_6 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_5 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_5
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_6, arg_287_1.talkMaxDuration)

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_5) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_5 + var_290_10 and arg_287_1.time_ < var_290_5 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play938042070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 938042070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play938042071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10183"]) and arg_291_1.var_.actorSpriteComps10183 == nil then
				arg_291_1.var_.actorSpriteComps10183 = arg_291_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10183"]) then
				if arg_291_1.var_.actorSpriteComps10183 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10183"]) and arg_291_1.var_.actorSpriteComps10183 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10183 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 0.95

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_4 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(938042070).content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_6 = 38 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 38)

				if (38 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_4) / 38)) > 0 and var_294_3 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_7 and arg_291_1.time_ < var_294_2 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play938042071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 938042071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play938042072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10183"]) and arg_295_1.var_.actorSpriteComps10183 == nil then
				arg_295_1.var_.actorSpriteComps10183 = arg_295_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10183"]) then
				if arg_295_1.var_.actorSpriteComps10183 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10183"]) and arg_295_1.var_.actorSpriteComps10183 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10183 = nil
			end

			local var_298_2 = arg_295_1.actors_["10183"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10183 = var_298_2.localPosition
				var_298_2.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10183", 3)

				for iter_298_4 = 0, var_298_2.childCount - 1 do
					local var_298_3 = var_298_2:GetChild(iter_298_4)

					if var_298_3.name == "split_2" then
						var_298_3:SetAsLastSibling()
						var_298_3.gameObject:SetActive(true)

						arg_295_1.var_.actorSpriteSplit10183 = var_298_3.gameObject:GetComponent(typeof(Image))

						arg_295_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_298_4 = 0.5

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				var_298_2.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_295_1.time_ - 0) / var_298_4)

				if arg_295_1.var_.actorSpriteSplit10183 ~= nil then
					arg_295_1.var_.actorSpriteSplit10183:SetAlpha((arg_295_1.time_ - 0) / var_298_4)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				var_298_2.localPosition = Vector3.New(0, -475, -325)

				if arg_295_1.var_.actorSpriteSplit10183 ~= nil then
					arg_295_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_298_5 = 0
			local var_298_6 = 0.675

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(938042071).content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 27 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_7) / 27)

				if (27 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_7) / 27)) > 0 and var_298_6 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_6, arg_295_1.talkMaxDuration)

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_5) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_5 + var_298_10 and arg_295_1.time_ < var_298_5 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play938042072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 938042072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play938042073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10183 = arg_299_1.actors_["10183"].transform.localPosition
				arg_299_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10183", 3)

				for iter_302_0 = 0, arg_299_1.actors_["10183"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10183"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_1" then
						var_302_0:SetAsLastSibling()
						var_302_0.gameObject:SetActive(true)

						arg_299_1.var_.actorSpriteSplit10183 = var_302_0.gameObject:GetComponent(typeof(Image))

						arg_299_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_302_1 = 0.5

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_299_1.time_ - 0) / var_302_1)

				if arg_299_1.var_.actorSpriteSplit10183 ~= nil then
					arg_299_1.var_.actorSpriteSplit10183:SetAlpha((arg_299_1.time_ - 0) / var_302_1)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_299_1.var_.actorSpriteSplit10183 ~= nil then
					arg_299_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_302_2 = 0
			local var_302_3 = 0.75

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(938042072).content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_6 = 30 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 30)

				if (30 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_4) / 30)) > 0 and var_302_3 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_7 and arg_299_1.time_ < var_302_2 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play938042073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 938042073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play938042074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10183"]) and arg_303_1.var_.actorSpriteComps10183 == nil then
				arg_303_1.var_.actorSpriteComps10183 = arg_303_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10183"]) then
				if arg_303_1.var_.actorSpriteComps10183 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10183"]) and arg_303_1.var_.actorSpriteComps10183 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps10183 = nil
			end

			local var_306_2 = arg_303_1.actors_["10183"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10183 = var_306_2.localPosition
				var_306_2.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10183", 7)

				for iter_306_4 = 0, var_306_2.childCount - 1 do
					local var_306_3 = var_306_2:GetChild(iter_306_4)

					if var_306_3.name == "" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_2.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_4)
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_5 = 0
			local var_306_6 = 1.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_7 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(938042073).content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 42 <= 0 and var_306_6 or var_306_6 * (utf8.len(var_306_7) / 42)

				if (42 <= 0 and var_306_6 or var_306_6 * (utf8.len(var_306_7) / 42)) > 0 and var_306_6 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_5 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_5
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_6, arg_303_1.talkMaxDuration)

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_5) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_5 + var_306_10 and arg_303_1.time_ < var_306_5 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play938042074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 938042074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play938042075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.425

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(938042074).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 57 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 57)

				if (57 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 57)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play938042075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 938042075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play938042076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.35

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(938042075).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 14 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 14)

				if (14 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 14)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play938042076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 938042076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play938042077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10183"]) and arg_315_1.var_.actorSpriteComps10183 == nil then
				arg_315_1.var_.actorSpriteComps10183 = arg_315_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10183"]) then
				if arg_315_1.var_.actorSpriteComps10183 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10183"]) and arg_315_1.var_.actorSpriteComps10183 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10183 = nil
			end

			local var_318_2 = arg_315_1.actors_["10183"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10183 = var_318_2.localPosition
				var_318_2.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10183", 3)

				for iter_318_4 = 0, var_318_2.childCount - 1 do
					local var_318_3 = var_318_2:GetChild(iter_318_4)

					if var_318_3.name == "split_3" or not string.find(var_318_3.name, "split") then
						var_318_3.gameObject:SetActive(true)
					else
						var_318_3.gameObject:SetActive(false)
					end
				end
			end

			local var_318_4 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				var_318_2.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_315_1.time_ - 0) / var_318_4)
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				var_318_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_318_5 = 0
			local var_318_6 = 0.725

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_7 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(938042076).content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 29 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_7) / 29)

				if (29 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_7) / 29)) > 0 and var_318_6 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_10 and arg_315_1.time_ < var_318_5 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play938042077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 938042077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play938042078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10183"]) and arg_319_1.var_.actorSpriteComps10183 == nil then
				arg_319_1.var_.actorSpriteComps10183 = arg_319_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10183"]) then
				if arg_319_1.var_.actorSpriteComps10183 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10183"]) and arg_319_1.var_.actorSpriteComps10183 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10183 = nil
			end

			local var_322_2 = 0
			local var_322_3 = 0.175

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_4 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(938042077).content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_6 = 7 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_4) / 7)

				if (7 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_4) / 7)) > 0 and var_322_3 < var_322_6 then
					arg_319_1.talkMaxDuration = var_322_6

					if var_322_6 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_7 and arg_319_1.time_ < var_322_2 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play938042078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 938042078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play938042079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["10183"]) and arg_323_1.var_.actorSpriteComps10183 == nil then
				arg_323_1.var_.actorSpriteComps10183 = arg_323_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["10183"]) then
				if arg_323_1.var_.actorSpriteComps10183 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								iter_326_1.color = Color.New(Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_0), Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_0), (Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_0)))
							else
								local var_326_1 = Mathf.Lerp(iter_326_1.color.r, 1, (arg_323_1.time_ - 0) / var_326_0)

								iter_326_1.color = Color.New(var_326_1, var_326_1, var_326_1)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["10183"]) and arg_323_1.var_.actorSpriteComps10183 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10183 = nil
			end

			local var_326_2 = arg_323_1.actors_["10183"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10183 = var_326_2.localPosition
				var_326_2.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10183", 3)

				for iter_326_4 = 0, var_326_2.childCount - 1 do
					local var_326_3 = var_326_2:GetChild(iter_326_4)

					if var_326_3.name == "" then
						var_326_3:SetAsLastSibling()
						var_326_3.gameObject:SetActive(true)

						arg_323_1.var_.actorSpriteSplit10183 = var_326_3.gameObject:GetComponent(typeof(Image))

						arg_323_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_326_4 = 0.5

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_2.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_323_1.time_ - 0) / var_326_4)

				if arg_323_1.var_.actorSpriteSplit10183 ~= nil then
					arg_323_1.var_.actorSpriteSplit10183:SetAlpha((arg_323_1.time_ - 0) / var_326_4)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_2.localPosition = Vector3.New(0, -475, -325)

				if arg_323_1.var_.actorSpriteSplit10183 ~= nil then
					arg_323_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_326_5 = 0
			local var_326_6 = 1.275

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_7 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(938042078).content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 51 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_7) / 51)

				if (51 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_7) / 51)) > 0 and var_326_6 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_5) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_5 + var_326_10 and arg_323_1.time_ < var_326_5 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play938042079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 938042079
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play938042080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10183"]) and arg_327_1.var_.actorSpriteComps10183 == nil then
				arg_327_1.var_.actorSpriteComps10183 = arg_327_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10183"]) then
				if arg_327_1.var_.actorSpriteComps10183 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10183"]) and arg_327_1.var_.actorSpriteComps10183 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps10183 = nil
			end

			local var_330_2 = 0
			local var_330_3 = 0.375

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_4 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(938042079).content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 15 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 15)

				if (15 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 15)) > 0 and var_330_3 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_7 and arg_327_1.time_ < var_330_2 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play938042080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 938042080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play938042081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10183"]) and arg_331_1.var_.actorSpriteComps10183 == nil then
				arg_331_1.var_.actorSpriteComps10183 = arg_331_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10183"]) then
				if arg_331_1.var_.actorSpriteComps10183 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 1, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10183"]) and arg_331_1.var_.actorSpriteComps10183 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps10183 = nil
			end

			local var_334_2 = arg_331_1.actors_["10183"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10183 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10183", 3)

				for iter_334_4 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_4)

					if var_334_3.name == "split_6" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_331_1.time_ - 0) / var_334_4)
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_334_5 = 0
			local var_334_6 = 1.15

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_7 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(938042080).content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 46 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_7) / 46)

				if (46 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_7) / 46)) > 0 and var_334_6 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_5
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_6, arg_331_1.talkMaxDuration)

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_5) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_5 + var_334_10 and arg_331_1.time_ < var_334_5 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play938042081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 938042081
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play938042082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.95

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(938042081).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 38 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 38)

				if (38 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 38)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play938042082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 938042082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play938042083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10183"]) and arg_339_1.var_.actorSpriteComps10183 == nil then
				arg_339_1.var_.actorSpriteComps10183 = arg_339_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10183"]) then
				if arg_339_1.var_.actorSpriteComps10183 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10183"]) and arg_339_1.var_.actorSpriteComps10183 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10183 = nil
			end

			local var_342_2 = 0
			local var_342_3 = 0.2

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_4 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(938042082).content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_6 = 8 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 8)

				if (8 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 8)) > 0 and var_342_3 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_7 and arg_339_1.time_ < var_342_2 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play938042083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 938042083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play938042084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10183"]) and arg_343_1.var_.actorSpriteComps10183 == nil then
				arg_343_1.var_.actorSpriteComps10183 = arg_343_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10183"]) then
				if arg_343_1.var_.actorSpriteComps10183 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 1, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10183"]) and arg_343_1.var_.actorSpriteComps10183 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10183 = nil
			end

			local var_346_2 = arg_343_1.actors_["10183"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10183 = var_346_2.localPosition
				var_346_2.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10183", 3)

				for iter_346_4 = 0, var_346_2.childCount - 1 do
					local var_346_3 = var_346_2:GetChild(iter_346_4)

					if var_346_3.name == "split_5" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_2.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_343_1.time_ - 0) / var_346_4)
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_346_5 = 0
			local var_346_6 = 0.15

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(938042083).content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 6 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_7) / 6)

				if (6 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_7) / 6)) > 0 and var_346_6 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_10 and arg_343_1.time_ < var_346_5 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play938042084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 938042084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play938042085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10183"]) and arg_347_1.var_.actorSpriteComps10183 == nil then
				arg_347_1.var_.actorSpriteComps10183 = arg_347_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10183"]) then
				if arg_347_1.var_.actorSpriteComps10183 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10183"]) and arg_347_1.var_.actorSpriteComps10183 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps10183 = nil
			end

			local var_350_2 = arg_347_1.actors_["10183"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10183 = var_350_2.localPosition
				var_350_2.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10183", 7)

				for iter_350_4 = 0, var_350_2.childCount - 1 do
					local var_350_3 = var_350_2:GetChild(iter_350_4)

					if var_350_3.name == "" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				var_350_2.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_347_1.time_ - 0) / var_350_4)
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				var_350_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_350_5 = 0
			local var_350_6 = 1.075

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(938042084).content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 43 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_7) / 43)

				if (43 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_7) / 43)) > 0 and var_350_6 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_10 and arg_347_1.time_ < var_350_5 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play938042085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 938042085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play938042086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10183"]) and arg_351_1.var_.actorSpriteComps10183 == nil then
				arg_351_1.var_.actorSpriteComps10183 = arg_351_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10183"]) then
				if arg_351_1.var_.actorSpriteComps10183 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 1, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10183"]) and arg_351_1.var_.actorSpriteComps10183 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps10183 = nil
			end

			local var_354_2 = arg_351_1.actors_["10183"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10183 = var_354_2.localPosition
				var_354_2.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10183", 3)

				for iter_354_4 = 0, var_354_2.childCount - 1 do
					local var_354_3 = var_354_2:GetChild(iter_354_4)

					if var_354_3.name == "split_2" or not string.find(var_354_3.name, "split") then
						var_354_3.gameObject:SetActive(true)
					else
						var_354_3.gameObject:SetActive(false)
					end
				end
			end

			local var_354_4 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				var_354_2.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_351_1.time_ - 0) / var_354_4)
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				var_354_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_354_5 = 0
			local var_354_6 = 0.925

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(938042085).content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 37 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 37)

				if (37 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 37)) > 0 and var_354_6 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_10 and arg_351_1.time_ < var_354_5 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play938042086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 938042086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play938042087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["10183"]) and arg_355_1.var_.actorSpriteComps10183 == nil then
				arg_355_1.var_.actorSpriteComps10183 = arg_355_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["10183"]) then
				if arg_355_1.var_.actorSpriteComps10183 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								iter_358_1.color = Color.New(Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_0), Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_0), (Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_0)))
							else
								local var_358_1 = Mathf.Lerp(iter_358_1.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_0)

								iter_358_1.color = Color.New(var_358_1, var_358_1, var_358_1)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["10183"]) and arg_355_1.var_.actorSpriteComps10183 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_358_3 then
						iter_358_3.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10183 = nil
			end

			local var_358_2 = 0
			local var_358_3 = 0.3

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_4 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(938042086).content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 12 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_4) / 12)

				if (12 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_4) / 12)) > 0 and var_358_3 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_7 and arg_355_1.time_ < var_358_2 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play938042087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 938042087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play938042088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10183"]) and arg_359_1.var_.actorSpriteComps10183 == nil then
				arg_359_1.var_.actorSpriteComps10183 = arg_359_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10183"]) then
				if arg_359_1.var_.actorSpriteComps10183 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 1, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10183"]) and arg_359_1.var_.actorSpriteComps10183 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps10183 = nil
			end

			local var_362_2 = arg_359_1.actors_["10183"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10183 = var_362_2.localPosition
				var_362_2.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10183", 3)

				for iter_362_4 = 0, var_362_2.childCount - 1 do
					local var_362_3 = var_362_2:GetChild(iter_362_4)

					if var_362_3.name == "split_5" or not string.find(var_362_3.name, "split") then
						var_362_3.gameObject:SetActive(true)
					else
						var_362_3.gameObject:SetActive(false)
					end
				end
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_2.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_359_1.time_ - 0) / var_362_4)
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_362_5 = 0
			local var_362_6 = 1.35

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(938042087).content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 54 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_7) / 54)

				if (54 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_7) / 54)) > 0 and var_362_6 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_6, arg_359_1.talkMaxDuration)

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_5) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_5 + var_362_10 and arg_359_1.time_ < var_362_5 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play938042088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 938042088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play938042089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10183"]) and arg_363_1.var_.actorSpriteComps10183 == nil then
				arg_363_1.var_.actorSpriteComps10183 = arg_363_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["10183"]) then
				if arg_363_1.var_.actorSpriteComps10183 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								iter_366_1.color = Color.New(Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, (arg_363_1.time_ - 0) / var_366_0), Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, (arg_363_1.time_ - 0) / var_366_0), (Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, (arg_363_1.time_ - 0) / var_366_0)))
							else
								local var_366_1 = Mathf.Lerp(iter_366_1.color.r, 0.5, (arg_363_1.time_ - 0) / var_366_0)

								iter_366_1.color = Color.New(var_366_1, var_366_1, var_366_1)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["10183"]) and arg_363_1.var_.actorSpriteComps10183 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10183 = nil
			end

			local var_366_2 = 0
			local var_366_3 = 0.275

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_4 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(938042088).content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_6 = 11 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_4) / 11)

				if (11 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_4) / 11)) > 0 and var_366_3 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_7 and arg_363_1.time_ < var_366_2 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play938042089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 938042089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play938042090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["10183"]) and arg_367_1.var_.actorSpriteComps10183 == nil then
				arg_367_1.var_.actorSpriteComps10183 = arg_367_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["10183"]) then
				if arg_367_1.var_.actorSpriteComps10183 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								iter_370_1.color = Color.New(Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_0), Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_0), (Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_0)))
							else
								local var_370_1 = Mathf.Lerp(iter_370_1.color.r, 1, (arg_367_1.time_ - 0) / var_370_0)

								iter_370_1.color = Color.New(var_370_1, var_370_1, var_370_1)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["10183"]) and arg_367_1.var_.actorSpriteComps10183 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10183 = nil
			end

			local var_370_2 = arg_367_1.actors_["10183"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10183 = var_370_2.localPosition
				var_370_2.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10183", 3)

				for iter_370_4 = 0, var_370_2.childCount - 1 do
					local var_370_3 = var_370_2:GetChild(iter_370_4)

					if var_370_3.name == "split_2" then
						var_370_3:SetAsLastSibling()
						var_370_3.gameObject:SetActive(true)

						arg_367_1.var_.actorSpriteSplit10183 = var_370_3.gameObject:GetComponent(typeof(Image))

						arg_367_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_370_4 = 0.5

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_2.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_367_1.time_ - 0) / var_370_4)

				if arg_367_1.var_.actorSpriteSplit10183 ~= nil then
					arg_367_1.var_.actorSpriteSplit10183:SetAlpha((arg_367_1.time_ - 0) / var_370_4)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_2.localPosition = Vector3.New(0, -475, -325)

				if arg_367_1.var_.actorSpriteSplit10183 ~= nil then
					arg_367_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_370_5 = 0
			local var_370_6 = 0.975

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(938042089).content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 39 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_7) / 39)

				if (39 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_7) / 39)) > 0 and var_370_6 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_10 and arg_367_1.time_ < var_370_5 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play938042090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 938042090
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play938042091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["10183"]) and arg_371_1.var_.actorSpriteComps10183 == nil then
				arg_371_1.var_.actorSpriteComps10183 = arg_371_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_0 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["10183"]) then
				if arg_371_1.var_.actorSpriteComps10183 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								iter_374_1.color = Color.New(Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_0), Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_0), (Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_0)))
							else
								local var_374_1 = Mathf.Lerp(iter_374_1.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_0)

								iter_374_1.color = Color.New(var_374_1, var_374_1, var_374_1)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["10183"]) and arg_371_1.var_.actorSpriteComps10183 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_374_3 then
						iter_374_3.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps10183 = nil
			end

			local var_374_2 = 0
			local var_374_3 = 0.325

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_4 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(938042090).content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 13 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 13)

				if (13 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 13)) > 0 and var_374_3 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_2
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_3, arg_371_1.talkMaxDuration)

			if var_374_2 <= arg_371_1.time_ and arg_371_1.time_ < var_374_2 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_2) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_2 + var_374_7 and arg_371_1.time_ < var_374_2 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play938042091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 938042091
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play938042092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["10183"]) and arg_375_1.var_.actorSpriteComps10183 == nil then
				arg_375_1.var_.actorSpriteComps10183 = arg_375_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["10183"]) then
				if arg_375_1.var_.actorSpriteComps10183 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 1, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["10183"]) and arg_375_1.var_.actorSpriteComps10183 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps10183 = nil
			end

			local var_378_2 = arg_375_1.actors_["10183"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10183 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10183", 3)

				for iter_378_4 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_4)

					if var_378_3.name == "split_1" then
						var_378_3:SetAsLastSibling()
						var_378_3.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit10183 = var_378_3.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_378_4 = 0.5

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_375_1.time_ - 0) / var_378_4)

				if arg_375_1.var_.actorSpriteSplit10183 ~= nil then
					arg_375_1.var_.actorSpriteSplit10183:SetAlpha((arg_375_1.time_ - 0) / var_378_4)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(0, -475, -325)

				if arg_375_1.var_.actorSpriteSplit10183 ~= nil then
					arg_375_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_378_5 = 0
			local var_378_6 = 0.875

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(938042091).content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 35 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_7) / 35)

				if (35 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_7) / 35)) > 0 and var_378_6 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_10 and arg_375_1.time_ < var_378_5 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play938042092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 938042092
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play938042093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10183 = arg_379_1.actors_["10183"].transform.localPosition
				arg_379_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10183", 3)

				for iter_382_0 = 0, arg_379_1.actors_["10183"].transform.childCount - 1 do
					local var_382_0 = arg_379_1.actors_["10183"].transform:GetChild(iter_382_0)

					if var_382_0.name == "" or not string.find(var_382_0.name, "split") then
						var_382_0.gameObject:SetActive(true)
					else
						var_382_0.gameObject:SetActive(false)
					end
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_379_1.time_ - 0) / var_382_1)
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_382_2 = 0
			local var_382_3 = 1.25

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(938042092).content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 50 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_4) / 50)

				if (50 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_4) / 50)) > 0 and var_382_3 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_7 and arg_379_1.time_ < var_382_2 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play938042093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 938042093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play938042094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10183"]) and arg_383_1.var_.actorSpriteComps10183 == nil then
				arg_383_1.var_.actorSpriteComps10183 = arg_383_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10183"]) then
				if arg_383_1.var_.actorSpriteComps10183 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								iter_386_1.color = Color.New(Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor2.r, (arg_383_1.time_ - 0) / var_386_0), Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor2.g, (arg_383_1.time_ - 0) / var_386_0), (Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor2.b, (arg_383_1.time_ - 0) / var_386_0)))
							else
								local var_386_1 = Mathf.Lerp(iter_386_1.color.r, 0.5, (arg_383_1.time_ - 0) / var_386_0)

								iter_386_1.color = Color.New(var_386_1, var_386_1, var_386_1)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10183"]) and arg_383_1.var_.actorSpriteComps10183 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_386_3 then
						iter_386_3.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_383_1.var_.actorSpriteComps10183 = nil
			end

			local var_386_2 = manager.ui.mainCamera.transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.shakeOldPos = var_386_2.localPosition
			end

			local var_386_3 = 0.666666666666667

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 then
				local var_386_4, var_386_5 = math.modf((arg_383_1.time_ - 0) / 0.066)

				var_386_2.localPosition = Vector3.New(var_386_5 * 0.13, var_386_5 * 0.13, var_386_5 * 0.13) + arg_383_1.var_.shakeOldPos
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 then
				var_386_2.localPosition = arg_383_1.var_.shakeOldPos
			end

			local var_386_6 = 0
			local var_386_7 = 0.325

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_8 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_8:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_9 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(938042093).content)

				arg_383_1.text_.text = var_386_9

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 13 <= 0 and var_386_7 or var_386_7 * (utf8.len(var_386_9) / 13)

				if (13 <= 0 and var_386_7 or var_386_7 * (utf8.len(var_386_9) / 13)) > 0 and var_386_7 < var_386_11 then
					arg_383_1.talkMaxDuration = var_386_11
					var_386_6 = var_386_6 + 0.3

					if var_386_11 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_11 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_9
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = var_386_6 + 0.3
			local var_386_13 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_12 + var_386_13 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_12) / var_386_13

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_12 + var_386_13 and arg_383_1.time_ < var_386_12 + var_386_13 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play938042094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 938042094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play938042095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10183"]) and arg_389_1.var_.actorSpriteComps10183 == nil then
				arg_389_1.var_.actorSpriteComps10183 = arg_389_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10183"]) then
				if arg_389_1.var_.actorSpriteComps10183 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 1, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10183"]) and arg_389_1.var_.actorSpriteComps10183 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps10183 = nil
			end

			local var_392_2 = arg_389_1.actors_["10183"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos10183 = var_392_2.localPosition
				var_392_2.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10183", 3)

				for iter_392_4 = 0, var_392_2.childCount - 1 do
					local var_392_3 = var_392_2:GetChild(iter_392_4)

					if var_392_3.name == "" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				var_392_2.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_389_1.time_ - 0) / var_392_4)
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				var_392_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_392_5 = 0
			local var_392_6 = 1.3

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(938042094).content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 52 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 52)

				if (52 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 52)) > 0 and var_392_6 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_10 and arg_389_1.time_ < var_392_5 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play938042095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 938042095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play938042096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.45

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(938042095).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 58 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 58)

				if (58 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 58)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play938042096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 938042096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play938042097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10183 = arg_397_1.actors_["10183"].transform.localPosition
				arg_397_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10183", 3)

				for iter_400_0 = 0, arg_397_1.actors_["10183"].transform.childCount - 1 do
					local var_400_0 = arg_397_1.actors_["10183"].transform:GetChild(iter_400_0)

					if var_400_0.name == "split_2" then
						var_400_0:SetAsLastSibling()
						var_400_0.gameObject:SetActive(true)

						arg_397_1.var_.actorSpriteSplit10183 = var_400_0.gameObject:GetComponent(typeof(Image))

						arg_397_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_400_1 = 0.5

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_397_1.time_ - 0) / var_400_1)

				if arg_397_1.var_.actorSpriteSplit10183 ~= nil then
					arg_397_1.var_.actorSpriteSplit10183:SetAlpha((arg_397_1.time_ - 0) / var_400_1)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_397_1.var_.actorSpriteSplit10183 ~= nil then
					arg_397_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_400_2 = 0
			local var_400_3 = 1.15

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(938042096).content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 46 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 46)

				if (46 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 46)) > 0 and var_400_3 < var_400_6 then
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

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play938042097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 938042097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play938042098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10183"]) and arg_401_1.var_.actorSpriteComps10183 == nil then
				arg_401_1.var_.actorSpriteComps10183 = arg_401_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10183"]) then
				if arg_401_1.var_.actorSpriteComps10183 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10183"]) and arg_401_1.var_.actorSpriteComps10183 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps10183 = nil
			end

			local var_404_2 = 0
			local var_404_3 = 0.35

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_4 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(938042097).content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 14 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 14)

				if (14 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 14)) > 0 and var_404_3 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_7 and arg_401_1.time_ < var_404_2 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play938042098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 938042098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play938042099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["10183"]) and arg_405_1.var_.actorSpriteComps10183 == nil then
				arg_405_1.var_.actorSpriteComps10183 = arg_405_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_0 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["10183"]) then
				if arg_405_1.var_.actorSpriteComps10183 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								iter_408_1.color = Color.New(Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor1.r, (arg_405_1.time_ - 0) / var_408_0), Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor1.g, (arg_405_1.time_ - 0) / var_408_0), (Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor1.b, (arg_405_1.time_ - 0) / var_408_0)))
							else
								local var_408_1 = Mathf.Lerp(iter_408_1.color.r, 1, (arg_405_1.time_ - 0) / var_408_0)

								iter_408_1.color = Color.New(var_408_1, var_408_1, var_408_1)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["10183"]) and arg_405_1.var_.actorSpriteComps10183 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_408_3 then
						iter_408_3.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_405_1.var_.actorSpriteComps10183 = nil
			end

			local var_408_2 = arg_405_1.actors_["10183"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10183 = var_408_2.localPosition
				var_408_2.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10183", 3)

				for iter_408_4 = 0, var_408_2.childCount - 1 do
					local var_408_3 = var_408_2:GetChild(iter_408_4)

					if var_408_3.name == "" then
						var_408_3:SetAsLastSibling()
						var_408_3.gameObject:SetActive(true)

						arg_405_1.var_.actorSpriteSplit10183 = var_408_3.gameObject:GetComponent(typeof(Image))

						arg_405_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_408_4 = 0.5

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				var_408_2.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_405_1.time_ - 0) / var_408_4)

				if arg_405_1.var_.actorSpriteSplit10183 ~= nil then
					arg_405_1.var_.actorSpriteSplit10183:SetAlpha((arg_405_1.time_ - 0) / var_408_4)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				var_408_2.localPosition = Vector3.New(0, -475, -325)

				if arg_405_1.var_.actorSpriteSplit10183 ~= nil then
					arg_405_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_408_5 = 0
			local var_408_6 = 0.675

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_7 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(938042098).content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 27 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_7) / 27)

				if (27 <= 0 and var_408_6 or var_408_6 * (utf8.len(var_408_7) / 27)) > 0 and var_408_6 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_5 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_5
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_6, arg_405_1.talkMaxDuration)

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_5) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_5 + var_408_10 and arg_405_1.time_ < var_408_5 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play938042099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 938042099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play938042100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10183 = arg_409_1.actors_["10183"].transform.localPosition
				arg_409_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10183", 3)

				for iter_412_0 = 0, arg_409_1.actors_["10183"].transform.childCount - 1 do
					local var_412_0 = arg_409_1.actors_["10183"].transform:GetChild(iter_412_0)

					if var_412_0.name == "split_5" then
						var_412_0:SetAsLastSibling()
						var_412_0.gameObject:SetActive(true)

						arg_409_1.var_.actorSpriteSplit10183 = var_412_0.gameObject:GetComponent(typeof(Image))

						arg_409_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_412_1 = 0.5

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_1 then
				arg_409_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_409_1.time_ - 0) / var_412_1)

				if arg_409_1.var_.actorSpriteSplit10183 ~= nil then
					arg_409_1.var_.actorSpriteSplit10183:SetAlpha((arg_409_1.time_ - 0) / var_412_1)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_1 and arg_409_1.time_ < 0 + var_412_1 + arg_412_0 then
				arg_409_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_409_1.var_.actorSpriteSplit10183 ~= nil then
					arg_409_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_412_2 = 0
			local var_412_3 = 1.15

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(938042099).content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 46 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_4) / 46)

				if (46 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_4) / 46)) > 0 and var_412_3 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_7 and arg_409_1.time_ < var_412_2 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play938042100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 938042100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play938042101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10183"]) and arg_413_1.var_.actorSpriteComps10183 == nil then
				arg_413_1.var_.actorSpriteComps10183 = arg_413_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10183"]) then
				if arg_413_1.var_.actorSpriteComps10183 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10183"]) and arg_413_1.var_.actorSpriteComps10183 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps10183 = nil
			end

			local var_416_2 = 0
			local var_416_3 = 0.2

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_4 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(938042100).content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_6 = 8 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_4) / 8)

				if (8 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_4) / 8)) > 0 and var_416_3 < var_416_6 then
					arg_413_1.talkMaxDuration = var_416_6

					if var_416_6 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_6 + var_416_2
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_3, arg_413_1.talkMaxDuration)

			if var_416_2 <= arg_413_1.time_ and arg_413_1.time_ < var_416_2 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_2) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_2 + var_416_7 and arg_413_1.time_ < var_416_2 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play938042101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 938042101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play938042102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10183"]) and arg_417_1.var_.actorSpriteComps10183 == nil then
				arg_417_1.var_.actorSpriteComps10183 = arg_417_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10183"]) then
				if arg_417_1.var_.actorSpriteComps10183 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10183"]) and arg_417_1.var_.actorSpriteComps10183 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps10183 = nil
			end

			local var_420_2 = arg_417_1.actors_["10183"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10183 = var_420_2.localPosition
				var_420_2.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("10183", 3)

				for iter_420_4 = 0, var_420_2.childCount - 1 do
					local var_420_3 = var_420_2:GetChild(iter_420_4)

					if var_420_3.name == "" then
						var_420_3:SetAsLastSibling()
						var_420_3.gameObject:SetActive(true)

						arg_417_1.var_.actorSpriteSplit10183 = var_420_3.gameObject:GetComponent(typeof(Image))

						arg_417_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_420_4 = 0.5

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				var_420_2.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_417_1.time_ - 0) / var_420_4)

				if arg_417_1.var_.actorSpriteSplit10183 ~= nil then
					arg_417_1.var_.actorSpriteSplit10183:SetAlpha((arg_417_1.time_ - 0) / var_420_4)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				var_420_2.localPosition = Vector3.New(0, -475, -325)

				if arg_417_1.var_.actorSpriteSplit10183 ~= nil then
					arg_417_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_420_5 = 0
			local var_420_6 = 0.2

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_7 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(938042101).content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 8 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_7) / 8)

				if (8 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_7) / 8)) > 0 and var_420_6 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_10 and arg_417_1.time_ < var_420_5 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
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

		arg_417_1:InitPlayNodeList()
	end,
	Play938042102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 938042102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play938042103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["10183"]) and arg_421_1.var_.actorSpriteComps10183 == nil then
				arg_421_1.var_.actorSpriteComps10183 = arg_421_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["10183"]) then
				if arg_421_1.var_.actorSpriteComps10183 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["10183"]) and arg_421_1.var_.actorSpriteComps10183 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps10183 = nil
			end

			local var_424_2 = 0
			local var_424_3 = 0.65

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_4 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(938042102).content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_6 = 26 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 26)

				if (26 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_4) / 26)) > 0 and var_424_3 < var_424_6 then
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
	Play938042103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 938042103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play938042104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10183"]) and arg_425_1.var_.actorSpriteComps10183 == nil then
				arg_425_1.var_.actorSpriteComps10183 = arg_425_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["10183"]) then
				if arg_425_1.var_.actorSpriteComps10183 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 1, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["10183"]) and arg_425_1.var_.actorSpriteComps10183 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_425_1.var_.actorSpriteComps10183 = nil
			end

			local var_428_2 = arg_425_1.actors_["10183"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos10183 = var_428_2.localPosition
				var_428_2.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10183", 3)

				for iter_428_4 = 0, var_428_2.childCount - 1 do
					local var_428_3 = var_428_2:GetChild(iter_428_4)

					if var_428_3.name == "split_5" then
						var_428_3:SetAsLastSibling()
						var_428_3.gameObject:SetActive(true)

						arg_425_1.var_.actorSpriteSplit10183 = var_428_3.gameObject:GetComponent(typeof(Image))

						arg_425_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_428_4 = 0.5

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				var_428_2.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_425_1.time_ - 0) / var_428_4)

				if arg_425_1.var_.actorSpriteSplit10183 ~= nil then
					arg_425_1.var_.actorSpriteSplit10183:SetAlpha((arg_425_1.time_ - 0) / var_428_4)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				var_428_2.localPosition = Vector3.New(0, -475, -325)

				if arg_425_1.var_.actorSpriteSplit10183 ~= nil then
					arg_425_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_428_5 = 0
			local var_428_6 = 0.95

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_7 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(938042103).content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 38 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_7) / 38)

				if (38 <= 0 and var_428_6 or var_428_6 * (utf8.len(var_428_7) / 38)) > 0 and var_428_6 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_5 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_5
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_10 = math.max(var_428_6, arg_425_1.talkMaxDuration)

			if var_428_5 <= arg_425_1.time_ and arg_425_1.time_ < var_428_5 + var_428_10 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_5) / var_428_10

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_5 + var_428_10 and arg_425_1.time_ < var_428_5 + var_428_10 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play938042104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 938042104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play938042105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10183"]) and arg_429_1.var_.actorSpriteComps10183 == nil then
				arg_429_1.var_.actorSpriteComps10183 = arg_429_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["10183"]) then
				if arg_429_1.var_.actorSpriteComps10183 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["10183"]) and arg_429_1.var_.actorSpriteComps10183 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps10183 = nil
			end

			local var_432_2 = 0
			local var_432_3 = 0.2

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_4 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(938042104).content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_6 = 8 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_4) / 8)

				if (8 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_4) / 8)) > 0 and var_432_3 < var_432_6 then
					arg_429_1.talkMaxDuration = var_432_6

					if var_432_6 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_6 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_7 and arg_429_1.time_ < var_432_2 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play938042105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 938042105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play938042106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["10183"]) and arg_433_1.var_.actorSpriteComps10183 == nil then
				arg_433_1.var_.actorSpriteComps10183 = arg_433_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["10183"]) then
				if arg_433_1.var_.actorSpriteComps10183 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								iter_436_1.color = Color.New(Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_0), Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_0), (Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_0)))
							else
								local var_436_1 = Mathf.Lerp(iter_436_1.color.r, 1, (arg_433_1.time_ - 0) / var_436_0)

								iter_436_1.color = Color.New(var_436_1, var_436_1, var_436_1)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["10183"]) and arg_433_1.var_.actorSpriteComps10183 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_436_3 then
						iter_436_3.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps10183 = nil
			end

			local var_436_2 = arg_433_1.actors_["10183"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10183 = var_436_2.localPosition
				var_436_2.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10183", 3)

				for iter_436_4 = 0, var_436_2.childCount - 1 do
					local var_436_3 = var_436_2:GetChild(iter_436_4)

					if var_436_3.name == "split_3" then
						var_436_3:SetAsLastSibling()
						var_436_3.gameObject:SetActive(true)

						arg_433_1.var_.actorSpriteSplit10183 = var_436_3.gameObject:GetComponent(typeof(Image))

						arg_433_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_436_4 = 0.5

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				var_436_2.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_433_1.time_ - 0) / var_436_4)

				if arg_433_1.var_.actorSpriteSplit10183 ~= nil then
					arg_433_1.var_.actorSpriteSplit10183:SetAlpha((arg_433_1.time_ - 0) / var_436_4)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				var_436_2.localPosition = Vector3.New(0, -475, -325)

				if arg_433_1.var_.actorSpriteSplit10183 ~= nil then
					arg_433_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_436_5 = 0
			local var_436_6 = 0.875

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_7 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(938042105).content)

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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play938042106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 938042106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play938042107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10183"]) and arg_437_1.var_.actorSpriteComps10183 == nil then
				arg_437_1.var_.actorSpriteComps10183 = arg_437_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10183"]) then
				if arg_437_1.var_.actorSpriteComps10183 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								iter_440_1.color = Color.New(Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor2.r, (arg_437_1.time_ - 0) / var_440_0), Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor2.g, (arg_437_1.time_ - 0) / var_440_0), (Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor2.b, (arg_437_1.time_ - 0) / var_440_0)))
							else
								local var_440_1 = Mathf.Lerp(iter_440_1.color.r, 0.5, (arg_437_1.time_ - 0) / var_440_0)

								iter_440_1.color = Color.New(var_440_1, var_440_1, var_440_1)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10183"]) and arg_437_1.var_.actorSpriteComps10183 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_440_3 then
						iter_440_3.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_437_1.var_.actorSpriteComps10183 = nil
			end

			local var_440_2 = 0
			local var_440_3 = 1.075

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
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

				local var_440_4 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(938042106).content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_6 = 43 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_4) / 43)

				if (43 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_4) / 43)) > 0 and var_440_3 < var_440_6 then
					arg_437_1.talkMaxDuration = var_440_6

					if var_440_6 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_6 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_7 and arg_437_1.time_ < var_440_2 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play938042107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 938042107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play938042108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.75

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

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(938042107).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 30 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 30)

				if (30 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 30)) > 0 and var_444_0 < var_444_3 then
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
	Play938042108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 938042108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play938042109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10183"]) and arg_445_1.var_.actorSpriteComps10183 == nil then
				arg_445_1.var_.actorSpriteComps10183 = arg_445_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10183"]) then
				if arg_445_1.var_.actorSpriteComps10183 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10183"]) and arg_445_1.var_.actorSpriteComps10183 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_445_1.var_.actorSpriteComps10183 = nil
			end

			local var_448_2 = arg_445_1.actors_["10183"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10183 = var_448_2.localPosition
				var_448_2.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10183", 3)

				for iter_448_4 = 0, var_448_2.childCount - 1 do
					local var_448_3 = var_448_2:GetChild(iter_448_4)

					if var_448_3.name == "split_1" then
						var_448_3:SetAsLastSibling()
						var_448_3.gameObject:SetActive(true)

						arg_445_1.var_.actorSpriteSplit10183 = var_448_3.gameObject:GetComponent(typeof(Image))

						arg_445_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_448_4 = 0.5

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				var_448_2.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_445_1.time_ - 0) / var_448_4)

				if arg_445_1.var_.actorSpriteSplit10183 ~= nil then
					arg_445_1.var_.actorSpriteSplit10183:SetAlpha((arg_445_1.time_ - 0) / var_448_4)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				var_448_2.localPosition = Vector3.New(0, -475, -325)

				if arg_445_1.var_.actorSpriteSplit10183 ~= nil then
					arg_445_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_448_5 = 0
			local var_448_6 = 1.05

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(938042108).content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 42 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_7) / 42)

				if (42 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_7) / 42)) > 0 and var_448_6 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_6, arg_445_1.talkMaxDuration)

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_5) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_5 + var_448_10 and arg_445_1.time_ < var_448_5 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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

		arg_445_1:InitPlayNodeList()
	end,
	Play938042109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 938042109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play938042110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10183"]) and arg_449_1.var_.actorSpriteComps10183 == nil then
				arg_449_1.var_.actorSpriteComps10183 = arg_449_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10183"]) then
				if arg_449_1.var_.actorSpriteComps10183 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10183"]) and arg_449_1.var_.actorSpriteComps10183 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_449_1.var_.actorSpriteComps10183 = nil
			end

			local var_452_2 = 0
			local var_452_3 = 0.175

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

				local var_452_4 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(938042109).content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_6 = 7 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 7)

				if (7 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_4) / 7)) > 0 and var_452_3 < var_452_6 then
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
	Play938042110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 938042110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play938042111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10183"]) and arg_453_1.var_.actorSpriteComps10183 == nil then
				arg_453_1.var_.actorSpriteComps10183 = arg_453_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10183"]) then
				if arg_453_1.var_.actorSpriteComps10183 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10183"]) and arg_453_1.var_.actorSpriteComps10183 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_453_1.var_.actorSpriteComps10183 = nil
			end

			local var_456_2 = arg_453_1.actors_["10183"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos10183 = var_456_2.localPosition
				var_456_2.localScale = Vector3.New(1, 1, 1)

				arg_453_1:CheckSpriteTmpPos("10183", 3)

				for iter_456_4 = 0, var_456_2.childCount - 1 do
					local var_456_3 = var_456_2:GetChild(iter_456_4)

					if var_456_3.name == "" or not string.find(var_456_3.name, "split") then
						var_456_3.gameObject:SetActive(true)
					else
						var_456_3.gameObject:SetActive(false)
					end
				end
			end

			local var_456_4 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				var_456_2.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_453_1.time_ - 0) / var_456_4)
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				var_456_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_456_5 = 0
			local var_456_6 = 0.525

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_7 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(938042110).content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_9 = 21 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_7) / 21)

				if (21 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_7) / 21)) > 0 and var_456_6 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_5
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_6, arg_453_1.talkMaxDuration)

			if var_456_5 <= arg_453_1.time_ and arg_453_1.time_ < var_456_5 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_5) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_5 + var_456_10 and arg_453_1.time_ < var_456_5 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play938042111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 938042111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play938042112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["10183"]) and arg_457_1.var_.actorSpriteComps10183 == nil then
				arg_457_1.var_.actorSpriteComps10183 = arg_457_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_0 = 0.2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["10183"]) then
				if arg_457_1.var_.actorSpriteComps10183 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["10183"]) and arg_457_1.var_.actorSpriteComps10183 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_460_3 then
						iter_460_3.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_457_1.var_.actorSpriteComps10183 = nil
			end

			local var_460_2 = 0
			local var_460_3 = 0.275

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

				local var_460_4 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(938042111).content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_6 = 11 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 11)

				if (11 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_4) / 11)) > 0 and var_460_3 < var_460_6 then
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
	Play938042112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 938042112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play938042113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10183"]) and arg_461_1.var_.actorSpriteComps10183 == nil then
				arg_461_1.var_.actorSpriteComps10183 = arg_461_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10183"]) then
				if arg_461_1.var_.actorSpriteComps10183 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10183"]) and arg_461_1.var_.actorSpriteComps10183 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps10183 = nil
			end

			local var_464_2 = arg_461_1.actors_["10183"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10183 = var_464_2.localPosition
				var_464_2.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10183", 3)

				for iter_464_4 = 0, var_464_2.childCount - 1 do
					local var_464_3 = var_464_2:GetChild(iter_464_4)

					if var_464_3.name == "split_5" or not string.find(var_464_3.name, "split") then
						var_464_3.gameObject:SetActive(true)
					else
						var_464_3.gameObject:SetActive(false)
					end
				end
			end

			local var_464_4 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_461_1.time_ - 0) / var_464_4)
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_464_5 = 0
			local var_464_6 = 1.2

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(938042112).content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 48 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_7) / 48)

				if (48 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_7) / 48)) > 0 and var_464_6 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_6, arg_461_1.talkMaxDuration)

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_5) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_5 + var_464_10 and arg_461_1.time_ < var_464_5 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play938042113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 938042113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play938042114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10183"]) and arg_465_1.var_.actorSpriteComps10183 == nil then
				arg_465_1.var_.actorSpriteComps10183 = arg_465_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10183"]) then
				if arg_465_1.var_.actorSpriteComps10183 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10183:ToTable()) do
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

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10183"]) and arg_465_1.var_.actorSpriteComps10183 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps10183 = nil
			end

			local var_468_2 = 0
			local var_468_3 = 0.35

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

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(938042113).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 14 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 14)

				if (14 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 14)) > 0 and var_468_3 < var_468_6 then
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
	Play938042114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 938042114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play938042115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10183"]) and arg_469_1.var_.actorSpriteComps10183 == nil then
				arg_469_1.var_.actorSpriteComps10183 = arg_469_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10183"]) then
				if arg_469_1.var_.actorSpriteComps10183 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_472_1 then
							if arg_469_1.isInRecall_ then
								iter_472_1.color = Color.New(Mathf.Lerp(iter_472_1.color.r, arg_469_1.hightColor1.r, (arg_469_1.time_ - 0) / var_472_0), Mathf.Lerp(iter_472_1.color.g, arg_469_1.hightColor1.g, (arg_469_1.time_ - 0) / var_472_0), (Mathf.Lerp(iter_472_1.color.b, arg_469_1.hightColor1.b, (arg_469_1.time_ - 0) / var_472_0)))
							else
								local var_472_1 = Mathf.Lerp(iter_472_1.color.r, 1, (arg_469_1.time_ - 0) / var_472_0)

								iter_472_1.color = Color.New(var_472_1, var_472_1, var_472_1)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10183"]) and arg_469_1.var_.actorSpriteComps10183 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_472_3 then
						iter_472_3.color = arg_469_1.isInRecall_ and (arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_469_1.var_.actorSpriteComps10183 = nil
			end

			local var_472_2 = arg_469_1.actors_["10183"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos10183 = var_472_2.localPosition
				var_472_2.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10183", 3)

				for iter_472_4 = 0, var_472_2.childCount - 1 do
					local var_472_3 = var_472_2:GetChild(iter_472_4)

					if var_472_3.name == "split_1" then
						var_472_3:SetAsLastSibling()
						var_472_3.gameObject:SetActive(true)

						arg_469_1.var_.actorSpriteSplit10183 = var_472_3.gameObject:GetComponent(typeof(Image))

						arg_469_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_472_4 = 0.5

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				var_472_2.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_469_1.time_ - 0) / var_472_4)

				if arg_469_1.var_.actorSpriteSplit10183 ~= nil then
					arg_469_1.var_.actorSpriteSplit10183:SetAlpha((arg_469_1.time_ - 0) / var_472_4)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				var_472_2.localPosition = Vector3.New(0, -475, -325)

				if arg_469_1.var_.actorSpriteSplit10183 ~= nil then
					arg_469_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_472_5 = 0
			local var_472_6 = 1.35

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_7 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(938042114).content)

				arg_469_1.text_.text = var_472_7

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_9 = 54 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_7) / 54)

				if (54 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_7) / 54)) > 0 and var_472_6 < var_472_9 then
					arg_469_1.talkMaxDuration = var_472_9

					if var_472_9 + var_472_5 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_9 + var_472_5
					end
				end

				arg_469_1.text_.text = var_472_7
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_6, arg_469_1.talkMaxDuration)

			if var_472_5 <= arg_469_1.time_ and arg_469_1.time_ < var_472_5 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_5) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_5 + var_472_10 and arg_469_1.time_ < var_472_5 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
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

		arg_469_1:InitPlayNodeList()
	end,
	Play938042115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 938042115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play938042116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10183"]) and arg_473_1.var_.actorSpriteComps10183 == nil then
				arg_473_1.var_.actorSpriteComps10183 = arg_473_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_0 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10183"]) then
				if arg_473_1.var_.actorSpriteComps10183 then
					for iter_476_0, iter_476_1 in pairs(arg_473_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_476_1 then
							if arg_473_1.isInRecall_ then
								iter_476_1.color = Color.New(Mathf.Lerp(iter_476_1.color.r, arg_473_1.hightColor2.r, (arg_473_1.time_ - 0) / var_476_0), Mathf.Lerp(iter_476_1.color.g, arg_473_1.hightColor2.g, (arg_473_1.time_ - 0) / var_476_0), (Mathf.Lerp(iter_476_1.color.b, arg_473_1.hightColor2.b, (arg_473_1.time_ - 0) / var_476_0)))
							else
								local var_476_1 = Mathf.Lerp(iter_476_1.color.r, 0.5, (arg_473_1.time_ - 0) / var_476_0)

								iter_476_1.color = Color.New(var_476_1, var_476_1, var_476_1)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10183"]) and arg_473_1.var_.actorSpriteComps10183 then
				for iter_476_2, iter_476_3 in pairs(arg_473_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_476_3 then
						iter_476_3.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_473_1.var_.actorSpriteComps10183 = nil
			end

			local var_476_2 = 0
			local var_476_3 = 0.475

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_4 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(938042115).content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 19 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 19)

				if (19 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 19)) > 0 and var_476_3 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_7 and arg_473_1.time_ < var_476_2 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play938042116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 938042116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play938042117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10183"]) and arg_477_1.var_.actorSpriteComps10183 == nil then
				arg_477_1.var_.actorSpriteComps10183 = arg_477_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10183"]) then
				if arg_477_1.var_.actorSpriteComps10183 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_480_1 then
							if arg_477_1.isInRecall_ then
								iter_480_1.color = Color.New(Mathf.Lerp(iter_480_1.color.r, arg_477_1.hightColor1.r, (arg_477_1.time_ - 0) / var_480_0), Mathf.Lerp(iter_480_1.color.g, arg_477_1.hightColor1.g, (arg_477_1.time_ - 0) / var_480_0), (Mathf.Lerp(iter_480_1.color.b, arg_477_1.hightColor1.b, (arg_477_1.time_ - 0) / var_480_0)))
							else
								local var_480_1 = Mathf.Lerp(iter_480_1.color.r, 1, (arg_477_1.time_ - 0) / var_480_0)

								iter_480_1.color = Color.New(var_480_1, var_480_1, var_480_1)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10183"]) and arg_477_1.var_.actorSpriteComps10183 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_480_3 then
						iter_480_3.color = arg_477_1.isInRecall_ and (arg_477_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_477_1.var_.actorSpriteComps10183 = nil
			end

			local var_480_2 = arg_477_1.actors_["10183"].transform

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos10183 = var_480_2.localPosition
				var_480_2.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10183", 3)

				for iter_480_4 = 0, var_480_2.childCount - 1 do
					local var_480_3 = var_480_2:GetChild(iter_480_4)

					if var_480_3.name == "" or not string.find(var_480_3.name, "split") then
						var_480_3.gameObject:SetActive(true)
					else
						var_480_3.gameObject:SetActive(false)
					end
				end
			end

			local var_480_4 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				var_480_2.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_477_1.time_ - 0) / var_480_4)
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				var_480_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_480_5 = 0
			local var_480_6 = 0.575

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_7 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(938042116).content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 23 <= 0 and var_480_6 or var_480_6 * (utf8.len(var_480_7) / 23)

				if (23 <= 0 and var_480_6 or var_480_6 * (utf8.len(var_480_7) / 23)) > 0 and var_480_6 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_5 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_5
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_6, arg_477_1.talkMaxDuration)

			if var_480_5 <= arg_477_1.time_ and arg_477_1.time_ < var_480_5 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_5) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_5 + var_480_10 and arg_477_1.time_ < var_480_5 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play938042117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 938042117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play938042118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10183 = arg_481_1.actors_["10183"].transform.localPosition
				arg_481_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10183", 3)

				for iter_484_0 = 0, arg_481_1.actors_["10183"].transform.childCount - 1 do
					local var_484_0 = arg_481_1.actors_["10183"].transform:GetChild(iter_484_0)

					if var_484_0.name == "" or not string.find(var_484_0.name, "split") then
						var_484_0.gameObject:SetActive(true)
					else
						var_484_0.gameObject:SetActive(false)
					end
				end
			end

			local var_484_1 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_1 then
				arg_481_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_481_1.time_ - 0) / var_484_1)
			end

			if arg_481_1.time_ >= 0 + var_484_1 and arg_481_1.time_ < 0 + var_484_1 + arg_484_0 then
				arg_481_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_484_2 = 0
			local var_484_3 = 0.8

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(938042117).content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 32 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_4) / 32)

				if (32 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_4) / 32)) > 0 and var_484_3 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_7 and arg_481_1.time_ < var_484_2 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play938042118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 938042118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play938042119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["10183"]) and arg_485_1.var_.actorSpriteComps10183 == nil then
				arg_485_1.var_.actorSpriteComps10183 = arg_485_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_488_0 = 0.2

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["10183"]) then
				if arg_485_1.var_.actorSpriteComps10183 then
					for iter_488_0, iter_488_1 in pairs(arg_485_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_488_1 then
							if arg_485_1.isInRecall_ then
								iter_488_1.color = Color.New(Mathf.Lerp(iter_488_1.color.r, arg_485_1.hightColor2.r, (arg_485_1.time_ - 0) / var_488_0), Mathf.Lerp(iter_488_1.color.g, arg_485_1.hightColor2.g, (arg_485_1.time_ - 0) / var_488_0), (Mathf.Lerp(iter_488_1.color.b, arg_485_1.hightColor2.b, (arg_485_1.time_ - 0) / var_488_0)))
							else
								local var_488_1 = Mathf.Lerp(iter_488_1.color.r, 0.5, (arg_485_1.time_ - 0) / var_488_0)

								iter_488_1.color = Color.New(var_488_1, var_488_1, var_488_1)
							end
						end
					end
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["10183"]) and arg_485_1.var_.actorSpriteComps10183 then
				for iter_488_2, iter_488_3 in pairs(arg_485_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_488_3 then
						iter_488_3.color = arg_485_1.isInRecall_ and (arg_485_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_485_1.var_.actorSpriteComps10183 = nil
			end

			local var_488_2 = 0
			local var_488_3 = 0.3

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_4 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(938042118).content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_6 = 12 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 12)

				if (12 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 12)) > 0 and var_488_3 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_7 and arg_485_1.time_ < var_488_2 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play938042119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 938042119
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play938042120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["10183"]) and arg_489_1.var_.actorSpriteComps10183 == nil then
				arg_489_1.var_.actorSpriteComps10183 = arg_489_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_0 = 0.2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["10183"]) then
				if arg_489_1.var_.actorSpriteComps10183 then
					for iter_492_0, iter_492_1 in pairs(arg_489_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_492_1 then
							if arg_489_1.isInRecall_ then
								iter_492_1.color = Color.New(Mathf.Lerp(iter_492_1.color.r, arg_489_1.hightColor1.r, (arg_489_1.time_ - 0) / var_492_0), Mathf.Lerp(iter_492_1.color.g, arg_489_1.hightColor1.g, (arg_489_1.time_ - 0) / var_492_0), (Mathf.Lerp(iter_492_1.color.b, arg_489_1.hightColor1.b, (arg_489_1.time_ - 0) / var_492_0)))
							else
								local var_492_1 = Mathf.Lerp(iter_492_1.color.r, 1, (arg_489_1.time_ - 0) / var_492_0)

								iter_492_1.color = Color.New(var_492_1, var_492_1, var_492_1)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["10183"]) and arg_489_1.var_.actorSpriteComps10183 then
				for iter_492_2, iter_492_3 in pairs(arg_489_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_492_3 then
						iter_492_3.color = arg_489_1.isInRecall_ and (arg_489_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_489_1.var_.actorSpriteComps10183 = nil
			end

			local var_492_2 = arg_489_1.actors_["10183"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos10183 = var_492_2.localPosition
				var_492_2.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10183", 3)

				for iter_492_4 = 0, var_492_2.childCount - 1 do
					local var_492_3 = var_492_2:GetChild(iter_492_4)

					if var_492_3.name == "split_3" then
						var_492_3:SetAsLastSibling()
						var_492_3.gameObject:SetActive(true)

						arg_489_1.var_.actorSpriteSplit10183 = var_492_3.gameObject:GetComponent(typeof(Image))

						arg_489_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_492_4 = 0.5

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				var_492_2.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_489_1.time_ - 0) / var_492_4)

				if arg_489_1.var_.actorSpriteSplit10183 ~= nil then
					arg_489_1.var_.actorSpriteSplit10183:SetAlpha((arg_489_1.time_ - 0) / var_492_4)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				var_492_2.localPosition = Vector3.New(0, -475, -325)

				if arg_489_1.var_.actorSpriteSplit10183 ~= nil then
					arg_489_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_492_5 = 0
			local var_492_6 = 1.25

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_5 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_7 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(938042119).content)

				arg_489_1.text_.text = var_492_7

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_9 = 50 <= 0 and var_492_6 or var_492_6 * (utf8.len(var_492_7) / 50)

				if (50 <= 0 and var_492_6 or var_492_6 * (utf8.len(var_492_7) / 50)) > 0 and var_492_6 < var_492_9 then
					arg_489_1.talkMaxDuration = var_492_9

					if var_492_9 + var_492_5 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_9 + var_492_5
					end
				end

				arg_489_1.text_.text = var_492_7
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_6, arg_489_1.talkMaxDuration)

			if var_492_5 <= arg_489_1.time_ and arg_489_1.time_ < var_492_5 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_5) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_5 + var_492_10 and arg_489_1.time_ < var_492_5 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
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

		arg_489_1:InitPlayNodeList()
	end,
	Play938042120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 938042120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play938042121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["10183"]) and arg_493_1.var_.actorSpriteComps10183 == nil then
				arg_493_1.var_.actorSpriteComps10183 = arg_493_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_496_0 = 0.2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["10183"]) then
				if arg_493_1.var_.actorSpriteComps10183 then
					for iter_496_0, iter_496_1 in pairs(arg_493_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_496_1 then
							if arg_493_1.isInRecall_ then
								iter_496_1.color = Color.New(Mathf.Lerp(iter_496_1.color.r, arg_493_1.hightColor2.r, (arg_493_1.time_ - 0) / var_496_0), Mathf.Lerp(iter_496_1.color.g, arg_493_1.hightColor2.g, (arg_493_1.time_ - 0) / var_496_0), (Mathf.Lerp(iter_496_1.color.b, arg_493_1.hightColor2.b, (arg_493_1.time_ - 0) / var_496_0)))
							else
								local var_496_1 = Mathf.Lerp(iter_496_1.color.r, 0.5, (arg_493_1.time_ - 0) / var_496_0)

								iter_496_1.color = Color.New(var_496_1, var_496_1, var_496_1)
							end
						end
					end
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["10183"]) and arg_493_1.var_.actorSpriteComps10183 then
				for iter_496_2, iter_496_3 in pairs(arg_493_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_496_3 then
						iter_496_3.color = arg_493_1.isInRecall_ and (arg_493_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_493_1.var_.actorSpriteComps10183 = nil
			end

			local var_496_2 = 0
			local var_496_3 = 0.325

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_4 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(938042120).content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_6 = 13 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_4) / 13)

				if (13 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_4) / 13)) > 0 and var_496_3 < var_496_6 then
					arg_493_1.talkMaxDuration = var_496_6

					if var_496_6 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_6 + var_496_2
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_3, arg_493_1.talkMaxDuration)

			if var_496_2 <= arg_493_1.time_ and arg_493_1.time_ < var_496_2 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_2) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_2 + var_496_7 and arg_493_1.time_ < var_496_2 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play938042121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 938042121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play938042122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["10183"]) and arg_497_1.var_.actorSpriteComps10183 == nil then
				arg_497_1.var_.actorSpriteComps10183 = arg_497_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_500_0 = 0.2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["10183"]) then
				if arg_497_1.var_.actorSpriteComps10183 then
					for iter_500_0, iter_500_1 in pairs(arg_497_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_500_1 then
							if arg_497_1.isInRecall_ then
								iter_500_1.color = Color.New(Mathf.Lerp(iter_500_1.color.r, arg_497_1.hightColor1.r, (arg_497_1.time_ - 0) / var_500_0), Mathf.Lerp(iter_500_1.color.g, arg_497_1.hightColor1.g, (arg_497_1.time_ - 0) / var_500_0), (Mathf.Lerp(iter_500_1.color.b, arg_497_1.hightColor1.b, (arg_497_1.time_ - 0) / var_500_0)))
							else
								local var_500_1 = Mathf.Lerp(iter_500_1.color.r, 1, (arg_497_1.time_ - 0) / var_500_0)

								iter_500_1.color = Color.New(var_500_1, var_500_1, var_500_1)
							end
						end
					end
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["10183"]) and arg_497_1.var_.actorSpriteComps10183 then
				for iter_500_2, iter_500_3 in pairs(arg_497_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_500_3 then
						iter_500_3.color = arg_497_1.isInRecall_ and (arg_497_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_497_1.var_.actorSpriteComps10183 = nil
			end

			local var_500_2 = arg_497_1.actors_["10183"].transform

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos10183 = var_500_2.localPosition
				var_500_2.localScale = Vector3.New(1, 1, 1)

				arg_497_1:CheckSpriteTmpPos("10183", 3)

				for iter_500_4 = 0, var_500_2.childCount - 1 do
					local var_500_3 = var_500_2:GetChild(iter_500_4)

					if var_500_3.name == "split_4" or not string.find(var_500_3.name, "split") then
						var_500_3.gameObject:SetActive(true)
					else
						var_500_3.gameObject:SetActive(false)
					end
				end
			end

			local var_500_4 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_4 then
				var_500_2.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_497_1.time_ - 0) / var_500_4)
			end

			if arg_497_1.time_ >= 0 + var_500_4 and arg_497_1.time_ < 0 + var_500_4 + arg_500_0 then
				var_500_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_500_5 = 0
			local var_500_6 = 0.175

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_5 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_7 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(938042121).content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_9 = 7 <= 0 and var_500_6 or var_500_6 * (utf8.len(var_500_7) / 7)

				if (7 <= 0 and var_500_6 or var_500_6 * (utf8.len(var_500_7) / 7)) > 0 and var_500_6 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_5 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_5
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_6, arg_497_1.talkMaxDuration)

			if var_500_5 <= arg_497_1.time_ and arg_497_1.time_ < var_500_5 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_5) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_5 + var_500_10 and arg_497_1.time_ < var_500_5 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
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

		arg_497_1:InitPlayNodeList()
	end,
	Play938042122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 938042122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play938042123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["10183"]) and arg_501_1.var_.actorSpriteComps10183 == nil then
				arg_501_1.var_.actorSpriteComps10183 = arg_501_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_0 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["10183"]) then
				if arg_501_1.var_.actorSpriteComps10183 then
					for iter_504_0, iter_504_1 in pairs(arg_501_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_504_1 then
							if arg_501_1.isInRecall_ then
								iter_504_1.color = Color.New(Mathf.Lerp(iter_504_1.color.r, arg_501_1.hightColor2.r, (arg_501_1.time_ - 0) / var_504_0), Mathf.Lerp(iter_504_1.color.g, arg_501_1.hightColor2.g, (arg_501_1.time_ - 0) / var_504_0), (Mathf.Lerp(iter_504_1.color.b, arg_501_1.hightColor2.b, (arg_501_1.time_ - 0) / var_504_0)))
							else
								local var_504_1 = Mathf.Lerp(iter_504_1.color.r, 0.5, (arg_501_1.time_ - 0) / var_504_0)

								iter_504_1.color = Color.New(var_504_1, var_504_1, var_504_1)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["10183"]) and arg_501_1.var_.actorSpriteComps10183 then
				for iter_504_2, iter_504_3 in pairs(arg_501_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_504_3 then
						iter_504_3.color = arg_501_1.isInRecall_ and (arg_501_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_501_1.var_.actorSpriteComps10183 = nil
			end

			local var_504_2 = 0
			local var_504_3 = 0.525

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_4 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(938042122).content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_6 = 21 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_4) / 21)

				if (21 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_4) / 21)) > 0 and var_504_3 < var_504_6 then
					arg_501_1.talkMaxDuration = var_504_6

					if var_504_6 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_6 + var_504_2
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_3, arg_501_1.talkMaxDuration)

			if var_504_2 <= arg_501_1.time_ and arg_501_1.time_ < var_504_2 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_2) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_2 + var_504_7 and arg_501_1.time_ < var_504_2 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play938042123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 938042123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play938042124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["10183"]) and arg_505_1.var_.actorSpriteComps10183 == nil then
				arg_505_1.var_.actorSpriteComps10183 = arg_505_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_0 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["10183"]) then
				if arg_505_1.var_.actorSpriteComps10183 then
					for iter_508_0, iter_508_1 in pairs(arg_505_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_508_1 then
							if arg_505_1.isInRecall_ then
								iter_508_1.color = Color.New(Mathf.Lerp(iter_508_1.color.r, arg_505_1.hightColor1.r, (arg_505_1.time_ - 0) / var_508_0), Mathf.Lerp(iter_508_1.color.g, arg_505_1.hightColor1.g, (arg_505_1.time_ - 0) / var_508_0), (Mathf.Lerp(iter_508_1.color.b, arg_505_1.hightColor1.b, (arg_505_1.time_ - 0) / var_508_0)))
							else
								local var_508_1 = Mathf.Lerp(iter_508_1.color.r, 1, (arg_505_1.time_ - 0) / var_508_0)

								iter_508_1.color = Color.New(var_508_1, var_508_1, var_508_1)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["10183"]) and arg_505_1.var_.actorSpriteComps10183 then
				for iter_508_2, iter_508_3 in pairs(arg_505_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_508_3 then
						iter_508_3.color = arg_505_1.isInRecall_ and (arg_505_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_505_1.var_.actorSpriteComps10183 = nil
			end

			local var_508_2 = arg_505_1.actors_["10183"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos10183 = var_508_2.localPosition
				var_508_2.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("10183", 3)

				for iter_508_4 = 0, var_508_2.childCount - 1 do
					local var_508_3 = var_508_2:GetChild(iter_508_4)

					if var_508_3.name == "split_3" then
						var_508_3:SetAsLastSibling()
						var_508_3.gameObject:SetActive(true)

						arg_505_1.var_.actorSpriteSplit10183 = var_508_3.gameObject:GetComponent(typeof(Image))

						arg_505_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_508_4 = 0.5

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				var_508_2.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_505_1.time_ - 0) / var_508_4)

				if arg_505_1.var_.actorSpriteSplit10183 ~= nil then
					arg_505_1.var_.actorSpriteSplit10183:SetAlpha((arg_505_1.time_ - 0) / var_508_4)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				var_508_2.localPosition = Vector3.New(0, -475, -325)

				if arg_505_1.var_.actorSpriteSplit10183 ~= nil then
					arg_505_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_508_5 = 0
			local var_508_6 = 0.45

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_5 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_7 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(938042123).content)

				arg_505_1.text_.text = var_508_7

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 18 <= 0 and var_508_6 or var_508_6 * (utf8.len(var_508_7) / 18)

				if (18 <= 0 and var_508_6 or var_508_6 * (utf8.len(var_508_7) / 18)) > 0 and var_508_6 < var_508_9 then
					arg_505_1.talkMaxDuration = var_508_9

					if var_508_9 + var_508_5 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_9 + var_508_5
					end
				end

				arg_505_1.text_.text = var_508_7
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_10 = math.max(var_508_6, arg_505_1.talkMaxDuration)

			if var_508_5 <= arg_505_1.time_ and arg_505_1.time_ < var_508_5 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_5) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_5 + var_508_10 and arg_505_1.time_ < var_508_5 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
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

		arg_505_1:InitPlayNodeList()
	end,
	Play938042124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 938042124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play938042125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["10183"]) and arg_509_1.var_.actorSpriteComps10183 == nil then
				arg_509_1.var_.actorSpriteComps10183 = arg_509_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["10183"]) then
				if arg_509_1.var_.actorSpriteComps10183 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_512_1 then
							if arg_509_1.isInRecall_ then
								iter_512_1.color = Color.New(Mathf.Lerp(iter_512_1.color.r, arg_509_1.hightColor2.r, (arg_509_1.time_ - 0) / var_512_0), Mathf.Lerp(iter_512_1.color.g, arg_509_1.hightColor2.g, (arg_509_1.time_ - 0) / var_512_0), (Mathf.Lerp(iter_512_1.color.b, arg_509_1.hightColor2.b, (arg_509_1.time_ - 0) / var_512_0)))
							else
								local var_512_1 = Mathf.Lerp(iter_512_1.color.r, 0.5, (arg_509_1.time_ - 0) / var_512_0)

								iter_512_1.color = Color.New(var_512_1, var_512_1, var_512_1)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["10183"]) and arg_509_1.var_.actorSpriteComps10183 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_512_3 then
						iter_512_3.color = arg_509_1.isInRecall_ and (arg_509_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_509_1.var_.actorSpriteComps10183 = nil
			end

			local var_512_2 = 0
			local var_512_3 = 0.575

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_2 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_4 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(938042124).content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_6 = 23 <= 0 and var_512_3 or var_512_3 * (utf8.len(var_512_4) / 23)

				if (23 <= 0 and var_512_3 or var_512_3 * (utf8.len(var_512_4) / 23)) > 0 and var_512_3 < var_512_6 then
					arg_509_1.talkMaxDuration = var_512_6

					if var_512_6 + var_512_2 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_2
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_3, arg_509_1.talkMaxDuration)

			if var_512_2 <= arg_509_1.time_ and arg_509_1.time_ < var_512_2 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_2) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_2 + var_512_7 and arg_509_1.time_ < var_512_2 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play938042125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 938042125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play938042126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.425

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(938042125).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 17 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 17)

				if (17 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 17)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play938042126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 938042126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play938042127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["10183"]) and arg_517_1.var_.actorSpriteComps10183 == nil then
				arg_517_1.var_.actorSpriteComps10183 = arg_517_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_0 = 0.2

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["10183"]) then
				if arg_517_1.var_.actorSpriteComps10183 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								iter_520_1.color = Color.New(Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor1.r, (arg_517_1.time_ - 0) / var_520_0), Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor1.g, (arg_517_1.time_ - 0) / var_520_0), (Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor1.b, (arg_517_1.time_ - 0) / var_520_0)))
							else
								local var_520_1 = Mathf.Lerp(iter_520_1.color.r, 1, (arg_517_1.time_ - 0) / var_520_0)

								iter_520_1.color = Color.New(var_520_1, var_520_1, var_520_1)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["10183"]) and arg_517_1.var_.actorSpriteComps10183 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_520_3 then
						iter_520_3.color = arg_517_1.isInRecall_ and (arg_517_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_517_1.var_.actorSpriteComps10183 = nil
			end

			local var_520_2 = arg_517_1.actors_["10183"].transform

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos10183 = var_520_2.localPosition
				var_520_2.localScale = Vector3.New(1, 1, 1)

				arg_517_1:CheckSpriteTmpPos("10183", 3)

				for iter_520_4 = 0, var_520_2.childCount - 1 do
					local var_520_3 = var_520_2:GetChild(iter_520_4)

					if var_520_3.name == "split_8" then
						var_520_3:SetAsLastSibling()
						var_520_3.gameObject:SetActive(true)

						arg_517_1.var_.actorSpriteSplit10183 = var_520_3.gameObject:GetComponent(typeof(Image))

						arg_517_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_520_4 = 0.5

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				var_520_2.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_517_1.time_ - 0) / var_520_4)

				if arg_517_1.var_.actorSpriteSplit10183 ~= nil then
					arg_517_1.var_.actorSpriteSplit10183:SetAlpha((arg_517_1.time_ - 0) / var_520_4)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				var_520_2.localPosition = Vector3.New(0, -475, -325)

				if arg_517_1.var_.actorSpriteSplit10183 ~= nil then
					arg_517_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_520_5 = 0
			local var_520_6 = 0.775

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_5 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_7 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(938042126).content)

				arg_517_1.text_.text = var_520_7

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_9 = 31 <= 0 and var_520_6 or var_520_6 * (utf8.len(var_520_7) / 31)

				if (31 <= 0 and var_520_6 or var_520_6 * (utf8.len(var_520_7) / 31)) > 0 and var_520_6 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_5 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_5
					end
				end

				arg_517_1.text_.text = var_520_7
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_6, arg_517_1.talkMaxDuration)

			if var_520_5 <= arg_517_1.time_ and arg_517_1.time_ < var_520_5 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_5) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_5 + var_520_10 and arg_517_1.time_ < var_520_5 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
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

		arg_517_1:InitPlayNodeList()
	end,
	Play938042127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 938042127
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play938042128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["10183"]) and arg_521_1.var_.actorSpriteComps10183 == nil then
				arg_521_1.var_.actorSpriteComps10183 = arg_521_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["10183"]) then
				if arg_521_1.var_.actorSpriteComps10183 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								iter_524_1.color = Color.New(Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor2.r, (arg_521_1.time_ - 0) / var_524_0), Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor2.g, (arg_521_1.time_ - 0) / var_524_0), (Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor2.b, (arg_521_1.time_ - 0) / var_524_0)))
							else
								local var_524_1 = Mathf.Lerp(iter_524_1.color.r, 0.5, (arg_521_1.time_ - 0) / var_524_0)

								iter_524_1.color = Color.New(var_524_1, var_524_1, var_524_1)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["10183"]) and arg_521_1.var_.actorSpriteComps10183 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_524_3 then
						iter_524_3.color = arg_521_1.isInRecall_ and (arg_521_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_521_1.var_.actorSpriteComps10183 = nil
			end

			local var_524_2 = 0
			local var_524_3 = 0.2

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_2 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_4 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(938042127).content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_6 = 8 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_4) / 8)

				if (8 <= 0 and var_524_3 or var_524_3 * (utf8.len(var_524_4) / 8)) > 0 and var_524_3 < var_524_6 then
					arg_521_1.talkMaxDuration = var_524_6

					if var_524_6 + var_524_2 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_6 + var_524_2
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_3, arg_521_1.talkMaxDuration)

			if var_524_2 <= arg_521_1.time_ and arg_521_1.time_ < var_524_2 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_2) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_2 + var_524_7 and arg_521_1.time_ < var_524_2 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play938042128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 938042128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play938042129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["10183"]) and arg_525_1.var_.actorSpriteComps10183 == nil then
				arg_525_1.var_.actorSpriteComps10183 = arg_525_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_0 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["10183"]) then
				if arg_525_1.var_.actorSpriteComps10183 then
					for iter_528_0, iter_528_1 in pairs(arg_525_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_528_1 then
							if arg_525_1.isInRecall_ then
								iter_528_1.color = Color.New(Mathf.Lerp(iter_528_1.color.r, arg_525_1.hightColor1.r, (arg_525_1.time_ - 0) / var_528_0), Mathf.Lerp(iter_528_1.color.g, arg_525_1.hightColor1.g, (arg_525_1.time_ - 0) / var_528_0), (Mathf.Lerp(iter_528_1.color.b, arg_525_1.hightColor1.b, (arg_525_1.time_ - 0) / var_528_0)))
							else
								local var_528_1 = Mathf.Lerp(iter_528_1.color.r, 1, (arg_525_1.time_ - 0) / var_528_0)

								iter_528_1.color = Color.New(var_528_1, var_528_1, var_528_1)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["10183"]) and arg_525_1.var_.actorSpriteComps10183 then
				for iter_528_2, iter_528_3 in pairs(arg_525_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_528_3 then
						iter_528_3.color = arg_525_1.isInRecall_ and (arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_525_1.var_.actorSpriteComps10183 = nil
			end

			local var_528_2 = arg_525_1.actors_["10183"].transform

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos10183 = var_528_2.localPosition
				var_528_2.localScale = Vector3.New(1, 1, 1)

				arg_525_1:CheckSpriteTmpPos("10183", 3)

				for iter_528_4 = 0, var_528_2.childCount - 1 do
					local var_528_3 = var_528_2:GetChild(iter_528_4)

					if var_528_3.name == "split_1" then
						var_528_3:SetAsLastSibling()
						var_528_3.gameObject:SetActive(true)

						arg_525_1.var_.actorSpriteSplit10183 = var_528_3.gameObject:GetComponent(typeof(Image))

						arg_525_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_528_4 = 0.5

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				var_528_2.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_525_1.time_ - 0) / var_528_4)

				if arg_525_1.var_.actorSpriteSplit10183 ~= nil then
					arg_525_1.var_.actorSpriteSplit10183:SetAlpha((arg_525_1.time_ - 0) / var_528_4)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				var_528_2.localPosition = Vector3.New(0, -475, -325)

				if arg_525_1.var_.actorSpriteSplit10183 ~= nil then
					arg_525_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_528_5 = 0
			local var_528_6 = 0.7

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_7 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(938042128).content)

				arg_525_1.text_.text = var_528_7

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_9 = 28 <= 0 and var_528_6 or var_528_6 * (utf8.len(var_528_7) / 28)

				if (28 <= 0 and var_528_6 or var_528_6 * (utf8.len(var_528_7) / 28)) > 0 and var_528_6 < var_528_9 then
					arg_525_1.talkMaxDuration = var_528_9

					if var_528_9 + var_528_5 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_5
					end
				end

				arg_525_1.text_.text = var_528_7
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_10 = math.max(var_528_6, arg_525_1.talkMaxDuration)

			if var_528_5 <= arg_525_1.time_ and arg_525_1.time_ < var_528_5 + var_528_10 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_5) / var_528_10

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_5 + var_528_10 and arg_525_1.time_ < var_528_5 + var_528_10 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
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

		arg_525_1:InitPlayNodeList()
	end,
	Play938042129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 938042129
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play938042130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["10183"]) and arg_529_1.var_.actorSpriteComps10183 == nil then
				arg_529_1.var_.actorSpriteComps10183 = arg_529_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_0 = 0.2

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["10183"]) then
				if arg_529_1.var_.actorSpriteComps10183 then
					for iter_532_0, iter_532_1 in pairs(arg_529_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_532_1 then
							if arg_529_1.isInRecall_ then
								iter_532_1.color = Color.New(Mathf.Lerp(iter_532_1.color.r, arg_529_1.hightColor2.r, (arg_529_1.time_ - 0) / var_532_0), Mathf.Lerp(iter_532_1.color.g, arg_529_1.hightColor2.g, (arg_529_1.time_ - 0) / var_532_0), (Mathf.Lerp(iter_532_1.color.b, arg_529_1.hightColor2.b, (arg_529_1.time_ - 0) / var_532_0)))
							else
								local var_532_1 = Mathf.Lerp(iter_532_1.color.r, 0.5, (arg_529_1.time_ - 0) / var_532_0)

								iter_532_1.color = Color.New(var_532_1, var_532_1, var_532_1)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["10183"]) and arg_529_1.var_.actorSpriteComps10183 then
				for iter_532_2, iter_532_3 in pairs(arg_529_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_532_3 then
						iter_532_3.color = arg_529_1.isInRecall_ and (arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_529_1.var_.actorSpriteComps10183 = nil
			end

			local var_532_2 = 0
			local var_532_3 = 1.45

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_4 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(938042129).content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_6 = 58 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_4) / 58)

				if (58 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_4) / 58)) > 0 and var_532_3 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_7 and arg_529_1.time_ < var_532_2 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play938042130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 938042130
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play938042131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["10183"]) and arg_533_1.var_.actorSpriteComps10183 == nil then
				arg_533_1.var_.actorSpriteComps10183 = arg_533_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_536_0 = 0.2

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["10183"]) then
				if arg_533_1.var_.actorSpriteComps10183 then
					for iter_536_0, iter_536_1 in pairs(arg_533_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_536_1 then
							if arg_533_1.isInRecall_ then
								iter_536_1.color = Color.New(Mathf.Lerp(iter_536_1.color.r, arg_533_1.hightColor1.r, (arg_533_1.time_ - 0) / var_536_0), Mathf.Lerp(iter_536_1.color.g, arg_533_1.hightColor1.g, (arg_533_1.time_ - 0) / var_536_0), (Mathf.Lerp(iter_536_1.color.b, arg_533_1.hightColor1.b, (arg_533_1.time_ - 0) / var_536_0)))
							else
								local var_536_1 = Mathf.Lerp(iter_536_1.color.r, 1, (arg_533_1.time_ - 0) / var_536_0)

								iter_536_1.color = Color.New(var_536_1, var_536_1, var_536_1)
							end
						end
					end
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["10183"]) and arg_533_1.var_.actorSpriteComps10183 then
				for iter_536_2, iter_536_3 in pairs(arg_533_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_536_3 then
						iter_536_3.color = arg_533_1.isInRecall_ and (arg_533_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_533_1.var_.actorSpriteComps10183 = nil
			end

			local var_536_2 = arg_533_1.actors_["10183"].transform

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos10183 = var_536_2.localPosition
				var_536_2.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("10183", 3)

				for iter_536_4 = 0, var_536_2.childCount - 1 do
					local var_536_3 = var_536_2:GetChild(iter_536_4)

					if var_536_3.name == "split_1" or not string.find(var_536_3.name, "split") then
						var_536_3.gameObject:SetActive(true)
					else
						var_536_3.gameObject:SetActive(false)
					end
				end
			end

			local var_536_4 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				var_536_2.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_533_1.time_ - 0) / var_536_4)
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				var_536_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_536_5 = 0
			local var_536_6 = 1

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_5 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_7 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(938042130).content)

				arg_533_1.text_.text = var_536_7

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_9 = 40 <= 0 and var_536_6 or var_536_6 * (utf8.len(var_536_7) / 40)

				if (40 <= 0 and var_536_6 or var_536_6 * (utf8.len(var_536_7) / 40)) > 0 and var_536_6 < var_536_9 then
					arg_533_1.talkMaxDuration = var_536_9

					if var_536_9 + var_536_5 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_9 + var_536_5
					end
				end

				arg_533_1.text_.text = var_536_7
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_6, arg_533_1.talkMaxDuration)

			if var_536_5 <= arg_533_1.time_ and arg_533_1.time_ < var_536_5 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_5) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_5 + var_536_10 and arg_533_1.time_ < var_536_5 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
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

		arg_533_1:InitPlayNodeList()
	end,
	Play938042131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 938042131
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play938042132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos10183 = arg_537_1.actors_["10183"].transform.localPosition
				arg_537_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("10183", 3)

				for iter_540_0 = 0, arg_537_1.actors_["10183"].transform.childCount - 1 do
					local var_540_0 = arg_537_1.actors_["10183"].transform:GetChild(iter_540_0)

					if var_540_0.name == "" or not string.find(var_540_0.name, "split") then
						var_540_0.gameObject:SetActive(true)
					else
						var_540_0.gameObject:SetActive(false)
					end
				end
			end

			local var_540_1 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_1 then
				arg_537_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_537_1.time_ - 0) / var_540_1)
			end

			if arg_537_1.time_ >= 0 + var_540_1 and arg_537_1.time_ < 0 + var_540_1 + arg_540_0 then
				arg_537_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_540_2 = 0
			local var_540_3 = 0.95

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_4 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(938042131).content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_6 = 38 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_4) / 38)

				if (38 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_4) / 38)) > 0 and var_540_3 < var_540_6 then
					arg_537_1.talkMaxDuration = var_540_6

					if var_540_6 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_7 and arg_537_1.time_ < var_540_2 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play938042132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 938042132
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play938042133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["10183"]) and arg_541_1.var_.actorSpriteComps10183 == nil then
				arg_541_1.var_.actorSpriteComps10183 = arg_541_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_0 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["10183"]) then
				if arg_541_1.var_.actorSpriteComps10183 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								iter_544_1.color = Color.New(Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, (arg_541_1.time_ - 0) / var_544_0), Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, (arg_541_1.time_ - 0) / var_544_0), (Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, (arg_541_1.time_ - 0) / var_544_0)))
							else
								local var_544_1 = Mathf.Lerp(iter_544_1.color.r, 0.5, (arg_541_1.time_ - 0) / var_544_0)

								iter_544_1.color = Color.New(var_544_1, var_544_1, var_544_1)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["10183"]) and arg_541_1.var_.actorSpriteComps10183 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_544_3 then
						iter_544_3.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_541_1.var_.actorSpriteComps10183 = nil
			end

			local var_544_2 = arg_541_1.actors_["10183"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10183 = var_544_2.localPosition
				var_544_2.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10183", 7)

				for iter_544_4 = 0, var_544_2.childCount - 1 do
					local var_544_3 = var_544_2:GetChild(iter_544_4)

					if var_544_3.name == "" or not string.find(var_544_3.name, "split") then
						var_544_3.gameObject:SetActive(true)
					else
						var_544_3.gameObject:SetActive(false)
					end
				end
			end

			local var_544_4 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 then
				var_544_2.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_541_1.time_ - 0) / var_544_4)
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 then
				var_544_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_544_5 = 0
			local var_544_6 = 0.775

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_5 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_7 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(938042132).content)

				arg_541_1.text_.text = var_544_7

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_9 = 31 <= 0 and var_544_6 or var_544_6 * (utf8.len(var_544_7) / 31)

				if (31 <= 0 and var_544_6 or var_544_6 * (utf8.len(var_544_7) / 31)) > 0 and var_544_6 < var_544_9 then
					arg_541_1.talkMaxDuration = var_544_9

					if var_544_9 + var_544_5 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_9 + var_544_5
					end
				end

				arg_541_1.text_.text = var_544_7
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_6, arg_541_1.talkMaxDuration)

			if var_544_5 <= arg_541_1.time_ and arg_541_1.time_ < var_544_5 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_5) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_5 + var_544_10 and arg_541_1.time_ < var_544_5 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
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

		arg_541_1:InitPlayNodeList()
	end,
	Play938042133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 938042133
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play938042134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["10183"]) and arg_545_1.var_.actorSpriteComps10183 == nil then
				arg_545_1.var_.actorSpriteComps10183 = arg_545_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_0 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["10183"]) then
				if arg_545_1.var_.actorSpriteComps10183 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								iter_548_1.color = Color.New(Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor1.r, (arg_545_1.time_ - 0) / var_548_0), Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor1.g, (arg_545_1.time_ - 0) / var_548_0), (Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor1.b, (arg_545_1.time_ - 0) / var_548_0)))
							else
								local var_548_1 = Mathf.Lerp(iter_548_1.color.r, 1, (arg_545_1.time_ - 0) / var_548_0)

								iter_548_1.color = Color.New(var_548_1, var_548_1, var_548_1)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["10183"]) and arg_545_1.var_.actorSpriteComps10183 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_548_3 then
						iter_548_3.color = arg_545_1.isInRecall_ and (arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_545_1.var_.actorSpriteComps10183 = nil
			end

			local var_548_2 = arg_545_1.actors_["10183"].transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos10183 = var_548_2.localPosition
				var_548_2.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("10183", 3)

				for iter_548_4 = 0, var_548_2.childCount - 1 do
					local var_548_3 = var_548_2:GetChild(iter_548_4)

					if var_548_3.name == "split_3" or not string.find(var_548_3.name, "split") then
						var_548_3.gameObject:SetActive(true)
					else
						var_548_3.gameObject:SetActive(false)
					end
				end
			end

			local var_548_4 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				var_548_2.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_545_1.time_ - 0) / var_548_4)
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				var_548_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_548_5 = 0
			local var_548_6 = 0.775

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_5 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_7 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(938042133).content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 31 <= 0 and var_548_6 or var_548_6 * (utf8.len(var_548_7) / 31)

				if (31 <= 0 and var_548_6 or var_548_6 * (utf8.len(var_548_7) / 31)) > 0 and var_548_6 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_5 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_5
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_10 = math.max(var_548_6, arg_545_1.talkMaxDuration)

			if var_548_5 <= arg_545_1.time_ and arg_545_1.time_ < var_548_5 + var_548_10 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_5) / var_548_10

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_5 + var_548_10 and arg_545_1.time_ < var_548_5 + var_548_10 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play938042134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 938042134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play938042135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["10183"]) and arg_549_1.var_.actorSpriteComps10183 == nil then
				arg_549_1.var_.actorSpriteComps10183 = arg_549_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_552_0 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["10183"]) then
				if arg_549_1.var_.actorSpriteComps10183 then
					for iter_552_0, iter_552_1 in pairs(arg_549_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_552_1 then
							if arg_549_1.isInRecall_ then
								iter_552_1.color = Color.New(Mathf.Lerp(iter_552_1.color.r, arg_549_1.hightColor2.r, (arg_549_1.time_ - 0) / var_552_0), Mathf.Lerp(iter_552_1.color.g, arg_549_1.hightColor2.g, (arg_549_1.time_ - 0) / var_552_0), (Mathf.Lerp(iter_552_1.color.b, arg_549_1.hightColor2.b, (arg_549_1.time_ - 0) / var_552_0)))
							else
								local var_552_1 = Mathf.Lerp(iter_552_1.color.r, 0.5, (arg_549_1.time_ - 0) / var_552_0)

								iter_552_1.color = Color.New(var_552_1, var_552_1, var_552_1)
							end
						end
					end
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["10183"]) and arg_549_1.var_.actorSpriteComps10183 then
				for iter_552_2, iter_552_3 in pairs(arg_549_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_552_3 then
						iter_552_3.color = arg_549_1.isInRecall_ and (arg_549_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_549_1.var_.actorSpriteComps10183 = nil
			end

			local var_552_2 = 0
			local var_552_3 = 0.875

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_2 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_4 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(938042134).content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_6 = 35 <= 0 and var_552_3 or var_552_3 * (utf8.len(var_552_4) / 35)

				if (35 <= 0 and var_552_3 or var_552_3 * (utf8.len(var_552_4) / 35)) > 0 and var_552_3 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_2 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_2
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_3, arg_549_1.talkMaxDuration)

			if var_552_2 <= arg_549_1.time_ and arg_549_1.time_ < var_552_2 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_2) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_2 + var_552_7 and arg_549_1.time_ < var_552_2 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play938042135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 938042135
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play938042136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["10183"]) and arg_553_1.var_.actorSpriteComps10183 == nil then
				arg_553_1.var_.actorSpriteComps10183 = arg_553_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["10183"]) then
				if arg_553_1.var_.actorSpriteComps10183 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_0), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_0), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_0)))
							else
								local var_556_1 = Mathf.Lerp(iter_556_1.color.r, 1, (arg_553_1.time_ - 0) / var_556_0)

								iter_556_1.color = Color.New(var_556_1, var_556_1, var_556_1)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["10183"]) and arg_553_1.var_.actorSpriteComps10183 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps10183 = nil
			end

			local var_556_2 = arg_553_1.actors_["10183"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos10183 = var_556_2.localPosition
				var_556_2.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10183", 3)

				for iter_556_4 = 0, var_556_2.childCount - 1 do
					local var_556_3 = var_556_2:GetChild(iter_556_4)

					if var_556_3.name == "split_1" or not string.find(var_556_3.name, "split") then
						var_556_3.gameObject:SetActive(true)
					else
						var_556_3.gameObject:SetActive(false)
					end
				end
			end

			local var_556_4 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				var_556_2.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_553_1.time_ - 0) / var_556_4)
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				var_556_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_556_5 = 0
			local var_556_6 = 0.85

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_5 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_7 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(938042135).content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 34 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_7) / 34)

				if (34 <= 0 and var_556_6 or var_556_6 * (utf8.len(var_556_7) / 34)) > 0 and var_556_6 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_5 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_5
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_10 = math.max(var_556_6, arg_553_1.talkMaxDuration)

			if var_556_5 <= arg_553_1.time_ and arg_553_1.time_ < var_556_5 + var_556_10 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_5) / var_556_10

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_5 + var_556_10 and arg_553_1.time_ < var_556_5 + var_556_10 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play938042136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 938042136
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play938042137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["10183"]) and arg_557_1.var_.actorSpriteComps10183 == nil then
				arg_557_1.var_.actorSpriteComps10183 = arg_557_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["10183"]) then
				if arg_557_1.var_.actorSpriteComps10183 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 0.5, (arg_557_1.time_ - 0) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["10183"]) and arg_557_1.var_.actorSpriteComps10183 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps10183 = nil
			end

			local var_560_2 = arg_557_1.actors_["10183"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos10183 = var_560_2.localPosition
				var_560_2.localScale = Vector3.New(1, 1, 1)

				arg_557_1:CheckSpriteTmpPos("10183", 7)

				for iter_560_4 = 0, var_560_2.childCount - 1 do
					local var_560_3 = var_560_2:GetChild(iter_560_4)

					if var_560_3.name == "" or not string.find(var_560_3.name, "split") then
						var_560_3.gameObject:SetActive(true)
					else
						var_560_3.gameObject:SetActive(false)
					end
				end
			end

			local var_560_4 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				var_560_2.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_557_1.time_ - 0) / var_560_4)
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				var_560_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_560_5 = 0
			local var_560_6 = 0.875

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_7 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(938042136).content)

				arg_557_1.text_.text = var_560_7

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_9 = 35 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_7) / 35)

				if (35 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_7) / 35)) > 0 and var_560_6 < var_560_9 then
					arg_557_1.talkMaxDuration = var_560_9

					if var_560_9 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_9 + var_560_5
					end
				end

				arg_557_1.text_.text = var_560_7
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_6, arg_557_1.talkMaxDuration)

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_5) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_5 + var_560_10 and arg_557_1.time_ < var_560_5 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
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

		arg_557_1:InitPlayNodeList()
	end,
	Play938042137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 938042137
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play938042138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.2

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(938042137).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 8 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 8)

				if (8 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 8)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play938042138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 938042138
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play938042139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["10183"]) and arg_565_1.var_.actorSpriteComps10183 == nil then
				arg_565_1.var_.actorSpriteComps10183 = arg_565_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_568_0 = 0.2

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["10183"]) then
				if arg_565_1.var_.actorSpriteComps10183 then
					for iter_568_0, iter_568_1 in pairs(arg_565_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_568_1 then
							if arg_565_1.isInRecall_ then
								iter_568_1.color = Color.New(Mathf.Lerp(iter_568_1.color.r, arg_565_1.hightColor1.r, (arg_565_1.time_ - 0) / var_568_0), Mathf.Lerp(iter_568_1.color.g, arg_565_1.hightColor1.g, (arg_565_1.time_ - 0) / var_568_0), (Mathf.Lerp(iter_568_1.color.b, arg_565_1.hightColor1.b, (arg_565_1.time_ - 0) / var_568_0)))
							else
								local var_568_1 = Mathf.Lerp(iter_568_1.color.r, 1, (arg_565_1.time_ - 0) / var_568_0)

								iter_568_1.color = Color.New(var_568_1, var_568_1, var_568_1)
							end
						end
					end
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["10183"]) and arg_565_1.var_.actorSpriteComps10183 then
				for iter_568_2, iter_568_3 in pairs(arg_565_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_568_3 then
						iter_568_3.color = arg_565_1.isInRecall_ and (arg_565_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_565_1.var_.actorSpriteComps10183 = nil
			end

			local var_568_2 = arg_565_1.actors_["10183"].transform

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos10183 = var_568_2.localPosition
				var_568_2.localScale = Vector3.New(1, 1, 1)

				arg_565_1:CheckSpriteTmpPos("10183", 3)

				for iter_568_4 = 0, var_568_2.childCount - 1 do
					local var_568_3 = var_568_2:GetChild(iter_568_4)

					if var_568_3.name == "split_7" or not string.find(var_568_3.name, "split") then
						var_568_3.gameObject:SetActive(true)
					else
						var_568_3.gameObject:SetActive(false)
					end
				end
			end

			local var_568_4 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_4 then
				var_568_2.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_565_1.time_ - 0) / var_568_4)
			end

			if arg_565_1.time_ >= 0 + var_568_4 and arg_565_1.time_ < 0 + var_568_4 + arg_568_0 then
				var_568_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_568_5 = 0
			local var_568_6 = 1.075

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_7 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(938042138).content)

				arg_565_1.text_.text = var_568_7

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_9 = 43 <= 0 and var_568_6 or var_568_6 * (utf8.len(var_568_7) / 43)

				if (43 <= 0 and var_568_6 or var_568_6 * (utf8.len(var_568_7) / 43)) > 0 and var_568_6 < var_568_9 then
					arg_565_1.talkMaxDuration = var_568_9

					if var_568_9 + var_568_5 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_9 + var_568_5
					end
				end

				arg_565_1.text_.text = var_568_7
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_10 = math.max(var_568_6, arg_565_1.talkMaxDuration)

			if var_568_5 <= arg_565_1.time_ and arg_565_1.time_ < var_568_5 + var_568_10 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_5) / var_568_10

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_5 + var_568_10 and arg_565_1.time_ < var_568_5 + var_568_10 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
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

		arg_565_1:InitPlayNodeList()
	end,
	Play938042139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 938042139
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play938042140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["10183"]) and arg_569_1.var_.actorSpriteComps10183 == nil then
				arg_569_1.var_.actorSpriteComps10183 = arg_569_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_572_0 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["10183"]) then
				if arg_569_1.var_.actorSpriteComps10183 then
					for iter_572_0, iter_572_1 in pairs(arg_569_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_572_1 then
							if arg_569_1.isInRecall_ then
								iter_572_1.color = Color.New(Mathf.Lerp(iter_572_1.color.r, arg_569_1.hightColor2.r, (arg_569_1.time_ - 0) / var_572_0), Mathf.Lerp(iter_572_1.color.g, arg_569_1.hightColor2.g, (arg_569_1.time_ - 0) / var_572_0), (Mathf.Lerp(iter_572_1.color.b, arg_569_1.hightColor2.b, (arg_569_1.time_ - 0) / var_572_0)))
							else
								local var_572_1 = Mathf.Lerp(iter_572_1.color.r, 0.5, (arg_569_1.time_ - 0) / var_572_0)

								iter_572_1.color = Color.New(var_572_1, var_572_1, var_572_1)
							end
						end
					end
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["10183"]) and arg_569_1.var_.actorSpriteComps10183 then
				for iter_572_2, iter_572_3 in pairs(arg_569_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_572_3 then
						iter_572_3.color = arg_569_1.isInRecall_ and (arg_569_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_569_1.var_.actorSpriteComps10183 = nil
			end

			local var_572_2 = 0
			local var_572_3 = 0.225

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_2 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_4 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(938042139).content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_6 = 9 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_4) / 9)

				if (9 <= 0 and var_572_3 or var_572_3 * (utf8.len(var_572_4) / 9)) > 0 and var_572_3 < var_572_6 then
					arg_569_1.talkMaxDuration = var_572_6

					if var_572_6 + var_572_2 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_6 + var_572_2
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_3, arg_569_1.talkMaxDuration)

			if var_572_2 <= arg_569_1.time_ and arg_569_1.time_ < var_572_2 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_2) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_2 + var_572_7 and arg_569_1.time_ < var_572_2 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play938042140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 938042140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play938042141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["10183"]) and arg_573_1.var_.actorSpriteComps10183 == nil then
				arg_573_1.var_.actorSpriteComps10183 = arg_573_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_576_0 = 0.2

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["10183"]) then
				if arg_573_1.var_.actorSpriteComps10183 then
					for iter_576_0, iter_576_1 in pairs(arg_573_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_576_1 then
							if arg_573_1.isInRecall_ then
								iter_576_1.color = Color.New(Mathf.Lerp(iter_576_1.color.r, arg_573_1.hightColor1.r, (arg_573_1.time_ - 0) / var_576_0), Mathf.Lerp(iter_576_1.color.g, arg_573_1.hightColor1.g, (arg_573_1.time_ - 0) / var_576_0), (Mathf.Lerp(iter_576_1.color.b, arg_573_1.hightColor1.b, (arg_573_1.time_ - 0) / var_576_0)))
							else
								local var_576_1 = Mathf.Lerp(iter_576_1.color.r, 1, (arg_573_1.time_ - 0) / var_576_0)

								iter_576_1.color = Color.New(var_576_1, var_576_1, var_576_1)
							end
						end
					end
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["10183"]) and arg_573_1.var_.actorSpriteComps10183 then
				for iter_576_2, iter_576_3 in pairs(arg_573_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_576_3 then
						iter_576_3.color = arg_573_1.isInRecall_ and (arg_573_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_573_1.var_.actorSpriteComps10183 = nil
			end

			local var_576_2 = arg_573_1.actors_["10183"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos10183 = var_576_2.localPosition
				var_576_2.localScale = Vector3.New(1, 1, 1)

				arg_573_1:CheckSpriteTmpPos("10183", 3)

				for iter_576_4 = 0, var_576_2.childCount - 1 do
					local var_576_3 = var_576_2:GetChild(iter_576_4)

					if var_576_3.name == "split_4" then
						var_576_3:SetAsLastSibling()
						var_576_3.gameObject:SetActive(true)

						arg_573_1.var_.actorSpriteSplit10183 = var_576_3.gameObject:GetComponent(typeof(Image))

						arg_573_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_576_4 = 0.5

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_4 then
				var_576_2.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_573_1.time_ - 0) / var_576_4)

				if arg_573_1.var_.actorSpriteSplit10183 ~= nil then
					arg_573_1.var_.actorSpriteSplit10183:SetAlpha((arg_573_1.time_ - 0) / var_576_4)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_4 and arg_573_1.time_ < 0 + var_576_4 + arg_576_0 then
				var_576_2.localPosition = Vector3.New(0, -475, -325)

				if arg_573_1.var_.actorSpriteSplit10183 ~= nil then
					arg_573_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_576_5 = 0
			local var_576_6 = 0.125

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_7 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(938042140).content)

				arg_573_1.text_.text = var_576_7

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_9 = 5 <= 0 and var_576_6 or var_576_6 * (utf8.len(var_576_7) / 5)

				if (5 <= 0 and var_576_6 or var_576_6 * (utf8.len(var_576_7) / 5)) > 0 and var_576_6 < var_576_9 then
					arg_573_1.talkMaxDuration = var_576_9

					if var_576_9 + var_576_5 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_9 + var_576_5
					end
				end

				arg_573_1.text_.text = var_576_7
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_10 = math.max(var_576_6, arg_573_1.talkMaxDuration)

			if var_576_5 <= arg_573_1.time_ and arg_573_1.time_ < var_576_5 + var_576_10 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_5) / var_576_10

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_5 + var_576_10 and arg_573_1.time_ < var_576_5 + var_576_10 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
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

		arg_573_1:InitPlayNodeList()
	end,
	Play938042141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 938042141
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play938042142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["10183"]) and arg_577_1.var_.actorSpriteComps10183 == nil then
				arg_577_1.var_.actorSpriteComps10183 = arg_577_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_580_0 = 0.2

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["10183"]) then
				if arg_577_1.var_.actorSpriteComps10183 then
					for iter_580_0, iter_580_1 in pairs(arg_577_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_580_1 then
							if arg_577_1.isInRecall_ then
								iter_580_1.color = Color.New(Mathf.Lerp(iter_580_1.color.r, arg_577_1.hightColor2.r, (arg_577_1.time_ - 0) / var_580_0), Mathf.Lerp(iter_580_1.color.g, arg_577_1.hightColor2.g, (arg_577_1.time_ - 0) / var_580_0), (Mathf.Lerp(iter_580_1.color.b, arg_577_1.hightColor2.b, (arg_577_1.time_ - 0) / var_580_0)))
							else
								local var_580_1 = Mathf.Lerp(iter_580_1.color.r, 0.5, (arg_577_1.time_ - 0) / var_580_0)

								iter_580_1.color = Color.New(var_580_1, var_580_1, var_580_1)
							end
						end
					end
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["10183"]) and arg_577_1.var_.actorSpriteComps10183 then
				for iter_580_2, iter_580_3 in pairs(arg_577_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_580_3 then
						iter_580_3.color = arg_577_1.isInRecall_ and (arg_577_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_577_1.var_.actorSpriteComps10183 = nil
			end

			local var_580_2 = 0
			local var_580_3 = 0.225

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_2 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_4 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(938042141).content)

				arg_577_1.text_.text = var_580_4

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_6 = 9 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_4) / 9)

				if (9 <= 0 and var_580_3 or var_580_3 * (utf8.len(var_580_4) / 9)) > 0 and var_580_3 < var_580_6 then
					arg_577_1.talkMaxDuration = var_580_6

					if var_580_6 + var_580_2 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_6 + var_580_2
					end
				end

				arg_577_1.text_.text = var_580_4
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_7 = math.max(var_580_3, arg_577_1.talkMaxDuration)

			if var_580_2 <= arg_577_1.time_ and arg_577_1.time_ < var_580_2 + var_580_7 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_2) / var_580_7

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_2 + var_580_7 and arg_577_1.time_ < var_580_2 + var_580_7 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play938042142 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 938042142
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play938042143(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["10183"]) and arg_581_1.var_.actorSpriteComps10183 == nil then
				arg_581_1.var_.actorSpriteComps10183 = arg_581_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_584_0 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["10183"]) then
				if arg_581_1.var_.actorSpriteComps10183 then
					for iter_584_0, iter_584_1 in pairs(arg_581_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_584_1 then
							if arg_581_1.isInRecall_ then
								iter_584_1.color = Color.New(Mathf.Lerp(iter_584_1.color.r, arg_581_1.hightColor1.r, (arg_581_1.time_ - 0) / var_584_0), Mathf.Lerp(iter_584_1.color.g, arg_581_1.hightColor1.g, (arg_581_1.time_ - 0) / var_584_0), (Mathf.Lerp(iter_584_1.color.b, arg_581_1.hightColor1.b, (arg_581_1.time_ - 0) / var_584_0)))
							else
								local var_584_1 = Mathf.Lerp(iter_584_1.color.r, 1, (arg_581_1.time_ - 0) / var_584_0)

								iter_584_1.color = Color.New(var_584_1, var_584_1, var_584_1)
							end
						end
					end
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["10183"]) and arg_581_1.var_.actorSpriteComps10183 then
				for iter_584_2, iter_584_3 in pairs(arg_581_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_584_3 then
						iter_584_3.color = arg_581_1.isInRecall_ and (arg_581_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_581_1.var_.actorSpriteComps10183 = nil
			end

			local var_584_2 = arg_581_1.actors_["10183"].transform

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos10183 = var_584_2.localPosition
				var_584_2.localScale = Vector3.New(1, 1, 1)

				arg_581_1:CheckSpriteTmpPos("10183", 3)

				for iter_584_4 = 0, var_584_2.childCount - 1 do
					local var_584_3 = var_584_2:GetChild(iter_584_4)

					if var_584_3.name == "split_7" then
						var_584_3:SetAsLastSibling()
						var_584_3.gameObject:SetActive(true)

						arg_581_1.var_.actorSpriteSplit10183 = var_584_3.gameObject:GetComponent(typeof(Image))

						arg_581_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_584_4 = 0.5

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_4 then
				var_584_2.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_581_1.time_ - 0) / var_584_4)

				if arg_581_1.var_.actorSpriteSplit10183 ~= nil then
					arg_581_1.var_.actorSpriteSplit10183:SetAlpha((arg_581_1.time_ - 0) / var_584_4)
				end
			end

			if arg_581_1.time_ >= 0 + var_584_4 and arg_581_1.time_ < 0 + var_584_4 + arg_584_0 then
				var_584_2.localPosition = Vector3.New(0, -475, -325)

				if arg_581_1.var_.actorSpriteSplit10183 ~= nil then
					arg_581_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_584_5 = 0
			local var_584_6 = 1.1

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_5 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_7 = arg_581_1:FormatText(arg_581_1:GetWordFromCfg(938042142).content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 44 <= 0 and var_584_6 or var_584_6 * (utf8.len(var_584_7) / 44)

				if (44 <= 0 and var_584_6 or var_584_6 * (utf8.len(var_584_7) / 44)) > 0 and var_584_6 < var_584_9 then
					arg_581_1.talkMaxDuration = var_584_9

					if var_584_9 + var_584_5 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_9 + var_584_5
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_10 = math.max(var_584_6, arg_581_1.talkMaxDuration)

			if var_584_5 <= arg_581_1.time_ and arg_581_1.time_ < var_584_5 + var_584_10 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_5) / var_584_10

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_5 + var_584_10 and arg_581_1.time_ < var_584_5 + var_584_10 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play938042143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 938042143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play938042144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["10183"]) and arg_585_1.var_.actorSpriteComps10183 == nil then
				arg_585_1.var_.actorSpriteComps10183 = arg_585_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_588_0 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["10183"]) then
				if arg_585_1.var_.actorSpriteComps10183 then
					for iter_588_0, iter_588_1 in pairs(arg_585_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_588_1 then
							if arg_585_1.isInRecall_ then
								iter_588_1.color = Color.New(Mathf.Lerp(iter_588_1.color.r, arg_585_1.hightColor2.r, (arg_585_1.time_ - 0) / var_588_0), Mathf.Lerp(iter_588_1.color.g, arg_585_1.hightColor2.g, (arg_585_1.time_ - 0) / var_588_0), (Mathf.Lerp(iter_588_1.color.b, arg_585_1.hightColor2.b, (arg_585_1.time_ - 0) / var_588_0)))
							else
								local var_588_1 = Mathf.Lerp(iter_588_1.color.r, 0.5, (arg_585_1.time_ - 0) / var_588_0)

								iter_588_1.color = Color.New(var_588_1, var_588_1, var_588_1)
							end
						end
					end
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["10183"]) and arg_585_1.var_.actorSpriteComps10183 then
				for iter_588_2, iter_588_3 in pairs(arg_585_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_588_3 then
						iter_588_3.color = arg_585_1.isInRecall_ and (arg_585_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_585_1.var_.actorSpriteComps10183 = nil
			end

			local var_588_2 = 0
			local var_588_3 = 0.275

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_2 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_4 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(938042143).content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_6 = 11 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_4) / 11)

				if (11 <= 0 and var_588_3 or var_588_3 * (utf8.len(var_588_4) / 11)) > 0 and var_588_3 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_2 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_2
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_3, arg_585_1.talkMaxDuration)

			if var_588_2 <= arg_585_1.time_ and arg_585_1.time_ < var_588_2 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_2) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_2 + var_588_7 and arg_585_1.time_ < var_588_2 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play938042144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 938042144
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play938042145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["10183"]) and arg_589_1.var_.actorSpriteComps10183 == nil then
				arg_589_1.var_.actorSpriteComps10183 = arg_589_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_592_0 = 0.2

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["10183"]) then
				if arg_589_1.var_.actorSpriteComps10183 then
					for iter_592_0, iter_592_1 in pairs(arg_589_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_592_1 then
							if arg_589_1.isInRecall_ then
								iter_592_1.color = Color.New(Mathf.Lerp(iter_592_1.color.r, arg_589_1.hightColor1.r, (arg_589_1.time_ - 0) / var_592_0), Mathf.Lerp(iter_592_1.color.g, arg_589_1.hightColor1.g, (arg_589_1.time_ - 0) / var_592_0), (Mathf.Lerp(iter_592_1.color.b, arg_589_1.hightColor1.b, (arg_589_1.time_ - 0) / var_592_0)))
							else
								local var_592_1 = Mathf.Lerp(iter_592_1.color.r, 1, (arg_589_1.time_ - 0) / var_592_0)

								iter_592_1.color = Color.New(var_592_1, var_592_1, var_592_1)
							end
						end
					end
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["10183"]) and arg_589_1.var_.actorSpriteComps10183 then
				for iter_592_2, iter_592_3 in pairs(arg_589_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_592_3 then
						iter_592_3.color = arg_589_1.isInRecall_ and (arg_589_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_589_1.var_.actorSpriteComps10183 = nil
			end

			local var_592_2 = arg_589_1.actors_["10183"].transform

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos10183 = var_592_2.localPosition
				var_592_2.localScale = Vector3.New(1, 1, 1)

				arg_589_1:CheckSpriteTmpPos("10183", 3)

				for iter_592_4 = 0, var_592_2.childCount - 1 do
					local var_592_3 = var_592_2:GetChild(iter_592_4)

					if var_592_3.name == "split_1" then
						var_592_3:SetAsLastSibling()
						var_592_3.gameObject:SetActive(true)

						arg_589_1.var_.actorSpriteSplit10183 = var_592_3.gameObject:GetComponent(typeof(Image))

						arg_589_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_592_4 = 0.5

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				var_592_2.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_589_1.time_ - 0) / var_592_4)

				if arg_589_1.var_.actorSpriteSplit10183 ~= nil then
					arg_589_1.var_.actorSpriteSplit10183:SetAlpha((arg_589_1.time_ - 0) / var_592_4)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				var_592_2.localPosition = Vector3.New(0, -475, -325)

				if arg_589_1.var_.actorSpriteSplit10183 ~= nil then
					arg_589_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_592_5 = 0
			local var_592_6 = 0.25

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_5 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_7 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(938042144).content)

				arg_589_1.text_.text = var_592_7

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_9 = 10 <= 0 and var_592_6 or var_592_6 * (utf8.len(var_592_7) / 10)

				if (10 <= 0 and var_592_6 or var_592_6 * (utf8.len(var_592_7) / 10)) > 0 and var_592_6 < var_592_9 then
					arg_589_1.talkMaxDuration = var_592_9

					if var_592_9 + var_592_5 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_9 + var_592_5
					end
				end

				arg_589_1.text_.text = var_592_7
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_10 = math.max(var_592_6, arg_589_1.talkMaxDuration)

			if var_592_5 <= arg_589_1.time_ and arg_589_1.time_ < var_592_5 + var_592_10 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_5) / var_592_10

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_5 + var_592_10 and arg_589_1.time_ < var_592_5 + var_592_10 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
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

		arg_589_1:InitPlayNodeList()
	end,
	Play938042145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 938042145
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play938042146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(arg_593_1.actors_["10183"]) and arg_593_1.var_.actorSpriteComps10183 == nil then
				arg_593_1.var_.actorSpriteComps10183 = arg_593_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_596_0 = 0.2

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 and not isNil(arg_593_1.actors_["10183"]) then
				if arg_593_1.var_.actorSpriteComps10183 then
					for iter_596_0, iter_596_1 in pairs(arg_593_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_596_1 then
							if arg_593_1.isInRecall_ then
								iter_596_1.color = Color.New(Mathf.Lerp(iter_596_1.color.r, arg_593_1.hightColor2.r, (arg_593_1.time_ - 0) / var_596_0), Mathf.Lerp(iter_596_1.color.g, arg_593_1.hightColor2.g, (arg_593_1.time_ - 0) / var_596_0), (Mathf.Lerp(iter_596_1.color.b, arg_593_1.hightColor2.b, (arg_593_1.time_ - 0) / var_596_0)))
							else
								local var_596_1 = Mathf.Lerp(iter_596_1.color.r, 0.5, (arg_593_1.time_ - 0) / var_596_0)

								iter_596_1.color = Color.New(var_596_1, var_596_1, var_596_1)
							end
						end
					end
				end
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 and not isNil(arg_593_1.actors_["10183"]) and arg_593_1.var_.actorSpriteComps10183 then
				for iter_596_2, iter_596_3 in pairs(arg_593_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_596_3 then
						iter_596_3.color = arg_593_1.isInRecall_ and (arg_593_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_593_1.var_.actorSpriteComps10183 = nil
			end

			local var_596_2 = 0
			local var_596_3 = 0.3

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_2 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_4 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(938042145).content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_6 = 12 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_4) / 12)

				if (12 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_4) / 12)) > 0 and var_596_3 < var_596_6 then
					arg_593_1.talkMaxDuration = var_596_6

					if var_596_6 + var_596_2 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_6 + var_596_2
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_3, arg_593_1.talkMaxDuration)

			if var_596_2 <= arg_593_1.time_ and arg_593_1.time_ < var_596_2 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_2) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_2 + var_596_7 and arg_593_1.time_ < var_596_2 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play938042146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 938042146
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play938042147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["10183"]) and arg_597_1.var_.actorSpriteComps10183 == nil then
				arg_597_1.var_.actorSpriteComps10183 = arg_597_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_600_0 = 0.2

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["10183"]) then
				if arg_597_1.var_.actorSpriteComps10183 then
					for iter_600_0, iter_600_1 in pairs(arg_597_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_600_1 then
							if arg_597_1.isInRecall_ then
								iter_600_1.color = Color.New(Mathf.Lerp(iter_600_1.color.r, arg_597_1.hightColor1.r, (arg_597_1.time_ - 0) / var_600_0), Mathf.Lerp(iter_600_1.color.g, arg_597_1.hightColor1.g, (arg_597_1.time_ - 0) / var_600_0), (Mathf.Lerp(iter_600_1.color.b, arg_597_1.hightColor1.b, (arg_597_1.time_ - 0) / var_600_0)))
							else
								local var_600_1 = Mathf.Lerp(iter_600_1.color.r, 1, (arg_597_1.time_ - 0) / var_600_0)

								iter_600_1.color = Color.New(var_600_1, var_600_1, var_600_1)
							end
						end
					end
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["10183"]) and arg_597_1.var_.actorSpriteComps10183 then
				for iter_600_2, iter_600_3 in pairs(arg_597_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_600_3 then
						iter_600_3.color = arg_597_1.isInRecall_ and (arg_597_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_597_1.var_.actorSpriteComps10183 = nil
			end

			local var_600_2 = arg_597_1.actors_["10183"].transform

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.moveOldPos10183 = var_600_2.localPosition
				var_600_2.localScale = Vector3.New(1, 1, 1)

				arg_597_1:CheckSpriteTmpPos("10183", 3)

				for iter_600_4 = 0, var_600_2.childCount - 1 do
					local var_600_3 = var_600_2:GetChild(iter_600_4)

					if var_600_3.name == "split_2" then
						var_600_3:SetAsLastSibling()
						var_600_3.gameObject:SetActive(true)

						arg_597_1.var_.actorSpriteSplit10183 = var_600_3.gameObject:GetComponent(typeof(Image))

						arg_597_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_600_4 = 0.5

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				var_600_2.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_597_1.time_ - 0) / var_600_4)

				if arg_597_1.var_.actorSpriteSplit10183 ~= nil then
					arg_597_1.var_.actorSpriteSplit10183:SetAlpha((arg_597_1.time_ - 0) / var_600_4)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				var_600_2.localPosition = Vector3.New(0, -475, -325)

				if arg_597_1.var_.actorSpriteSplit10183 ~= nil then
					arg_597_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_600_5 = 0
			local var_600_6 = 1.15

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_5 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_7 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(938042146).content)

				arg_597_1.text_.text = var_600_7

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_9 = 46 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_7) / 46)

				if (46 <= 0 and var_600_6 or var_600_6 * (utf8.len(var_600_7) / 46)) > 0 and var_600_6 < var_600_9 then
					arg_597_1.talkMaxDuration = var_600_9

					if var_600_9 + var_600_5 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_9 + var_600_5
					end
				end

				arg_597_1.text_.text = var_600_7
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_10 = math.max(var_600_6, arg_597_1.talkMaxDuration)

			if var_600_5 <= arg_597_1.time_ and arg_597_1.time_ < var_600_5 + var_600_10 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_5) / var_600_10

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_5 + var_600_10 and arg_597_1.time_ < var_600_5 + var_600_10 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
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

		arg_597_1:InitPlayNodeList()
	end,
	Play938042147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 938042147
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play938042148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["10183"]) and arg_601_1.var_.actorSpriteComps10183 == nil then
				arg_601_1.var_.actorSpriteComps10183 = arg_601_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_604_0 = 0.2

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["10183"]) then
				if arg_601_1.var_.actorSpriteComps10183 then
					for iter_604_0, iter_604_1 in pairs(arg_601_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_604_1 then
							if arg_601_1.isInRecall_ then
								iter_604_1.color = Color.New(Mathf.Lerp(iter_604_1.color.r, arg_601_1.hightColor2.r, (arg_601_1.time_ - 0) / var_604_0), Mathf.Lerp(iter_604_1.color.g, arg_601_1.hightColor2.g, (arg_601_1.time_ - 0) / var_604_0), (Mathf.Lerp(iter_604_1.color.b, arg_601_1.hightColor2.b, (arg_601_1.time_ - 0) / var_604_0)))
							else
								local var_604_1 = Mathf.Lerp(iter_604_1.color.r, 0.5, (arg_601_1.time_ - 0) / var_604_0)

								iter_604_1.color = Color.New(var_604_1, var_604_1, var_604_1)
							end
						end
					end
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["10183"]) and arg_601_1.var_.actorSpriteComps10183 then
				for iter_604_2, iter_604_3 in pairs(arg_601_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_604_3 then
						iter_604_3.color = arg_601_1.isInRecall_ and (arg_601_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_601_1.var_.actorSpriteComps10183 = nil
			end

			local var_604_2 = 0
			local var_604_3 = 0.4

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_2 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_4 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(938042147).content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_6 = 16 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_4) / 16)

				if (16 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_4) / 16)) > 0 and var_604_3 < var_604_6 then
					arg_601_1.talkMaxDuration = var_604_6

					if var_604_6 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_6 + var_604_2
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_3, arg_601_1.talkMaxDuration)

			if var_604_2 <= arg_601_1.time_ and arg_601_1.time_ < var_604_2 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_2) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_2 + var_604_7 and arg_601_1.time_ < var_604_2 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play938042148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 938042148
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
			arg_605_1.auto_ = false
		end

		function arg_605_1.playNext_(arg_607_0)
			arg_605_1.onStoryFinished_()
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(arg_605_1.actors_["10183"]) and arg_605_1.var_.actorSpriteComps10183 == nil then
				arg_605_1.var_.actorSpriteComps10183 = arg_605_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_608_0 = 0.2

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 and not isNil(arg_605_1.actors_["10183"]) then
				if arg_605_1.var_.actorSpriteComps10183 then
					for iter_608_0, iter_608_1 in pairs(arg_605_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_608_1 then
							if arg_605_1.isInRecall_ then
								iter_608_1.color = Color.New(Mathf.Lerp(iter_608_1.color.r, arg_605_1.hightColor1.r, (arg_605_1.time_ - 0) / var_608_0), Mathf.Lerp(iter_608_1.color.g, arg_605_1.hightColor1.g, (arg_605_1.time_ - 0) / var_608_0), (Mathf.Lerp(iter_608_1.color.b, arg_605_1.hightColor1.b, (arg_605_1.time_ - 0) / var_608_0)))
							else
								local var_608_1 = Mathf.Lerp(iter_608_1.color.r, 1, (arg_605_1.time_ - 0) / var_608_0)

								iter_608_1.color = Color.New(var_608_1, var_608_1, var_608_1)
							end
						end
					end
				end
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 and not isNil(arg_605_1.actors_["10183"]) and arg_605_1.var_.actorSpriteComps10183 then
				for iter_608_2, iter_608_3 in pairs(arg_605_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_608_3 then
						iter_608_3.color = arg_605_1.isInRecall_ and (arg_605_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_605_1.var_.actorSpriteComps10183 = nil
			end

			local var_608_2 = arg_605_1.actors_["10183"].transform

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.var_.moveOldPos10183 = var_608_2.localPosition
				var_608_2.localScale = Vector3.New(1, 1, 1)

				arg_605_1:CheckSpriteTmpPos("10183", 3)

				for iter_608_4 = 0, var_608_2.childCount - 1 do
					local var_608_3 = var_608_2:GetChild(iter_608_4)

					if var_608_3.name == "split_7" or not string.find(var_608_3.name, "split") then
						var_608_3.gameObject:SetActive(true)
					else
						var_608_3.gameObject:SetActive(false)
					end
				end
			end

			local var_608_4 = 0.001

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				var_608_2.localPosition = Vector3.Lerp(arg_605_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_605_1.time_ - 0) / var_608_4)
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				var_608_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_608_5 = 0
			local var_608_6 = 1.2

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_5 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_7 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(938042148).content)

				arg_605_1.text_.text = var_608_7

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_9 = 48 <= 0 and var_608_6 or var_608_6 * (utf8.len(var_608_7) / 48)

				if (48 <= 0 and var_608_6 or var_608_6 * (utf8.len(var_608_7) / 48)) > 0 and var_608_6 < var_608_9 then
					arg_605_1.talkMaxDuration = var_608_9

					if var_608_9 + var_608_5 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_9 + var_608_5
					end
				end

				arg_605_1.text_.text = var_608_7
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_6, arg_605_1.talkMaxDuration)

			if var_608_5 <= arg_605_1.time_ and arg_605_1.time_ < var_608_5 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_5) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_5 + var_608_10 and arg_605_1.time_ < var_608_5 + var_608_10 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {
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

		arg_605_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/ST84",
		"TextureConfig/Background/H02b"
	},
	voices = {}
}
