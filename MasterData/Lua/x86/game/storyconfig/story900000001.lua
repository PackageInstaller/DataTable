return {
	Play900000001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900000001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900000002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_4_0.name = "F01a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01a

				arg_1_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01a" then
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

			if 2.77555756156289e-17 < arg_1_1.time_ and arg_1_1.time_ <= 2.77555756156289e-17 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(900000001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 27 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 27)

				if (27 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 27)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play900000002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 900000002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play900000003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1033"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1033"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1033"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["1033"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 2)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_1" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(-390, -420, 0)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_5 = arg_9_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_5 then
					arg_9_1.var_.alphaOldValue1033 = var_12_5.alpha
					arg_9_1.var_.characterEffect1033 = var_12_5
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_6 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 then
				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, (arg_9_1.time_ - 0) / var_12_6)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_7 = 0
			local var_12_8 = 0.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_9 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(900000002).content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 25 <= 0 and var_12_8 or var_12_8 * (utf8.len(var_12_9) / 25)

				if (25 <= 0 and var_12_8 or var_12_8 * (utf8.len(var_12_9) / 25)) > 0 and var_12_8 < var_12_11 then
					arg_9_1.talkMaxDuration = var_12_11

					if var_12_11 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_11 + var_12_7
					end
				end

				arg_9_1.text_.text = var_12_9
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_12 = math.max(var_12_8, arg_9_1.talkMaxDuration)

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_12 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_7) / var_12_12

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_7 + var_12_12 and arg_9_1.time_ < var_12_7 + var_12_12 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play900000003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 900000003
		arg_13_1.duration_ = 5.5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play900000004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1038"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "1038"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["1038"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["1038"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1038 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1038", 4)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_1" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(390, -400, 0)
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_5 = arg_13_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_5 then
					arg_13_1.var_.alphaOldValue1038 = var_16_5.alpha
					arg_13_1.var_.characterEffect1038 = var_16_5
				end

				arg_13_1.var_.alphaOldValue1038 = 0
			end

			local var_16_6 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				if arg_13_1.var_.characterEffect1038 then
					arg_13_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue1038, 1, (arg_13_1.time_ - 0) / var_16_6)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and arg_13_1.var_.characterEffect1038 then
				arg_13_1.var_.characterEffect1038.alpha = 1
			end

			local var_16_7 = arg_13_1.actors_["1038"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1038 == nil then
				arg_13_1.var_.actorSpriteComps1038 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.actorSpriteComps1038 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_8), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_8), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_8)))
							else
								local var_16_9 = Mathf.Lerp(iter_16_4.color.r, 1, (arg_13_1.time_ - 0) / var_16_8)

								iter_16_4.color = Color.New(var_16_9, var_16_9, var_16_9)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1038 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1038 = nil
			end

			local var_16_10 = arg_13_1.actors_["1033"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.actorSpriteComps1033 == nil then
				arg_13_1.var_.actorSpriteComps1033 = var_16_10:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_11 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.actorSpriteComps1033 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								iter_16_8.color = Color.New(Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_11), Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_11), (Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_11)))
							else
								local var_16_12 = Mathf.Lerp(iter_16_8.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_11)

								iter_16_8.color = Color.New(var_16_12, var_16_12, var_16_12)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.actorSpriteComps1033 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_16_10 then
						iter_16_10.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1033 = nil
			end

			local var_16_13 = 0.5
			local var_16_14 = 0.55

			if 0.5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(900000003).content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 22 <= 0 and var_16_14 or var_16_14 * (utf8.len(var_16_15) / 22)

				if (22 <= 0 and var_16_14 or var_16_14 * (utf8.len(var_16_15) / 22)) > 0 and var_16_14 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_13 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_13
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_14, arg_13_1.talkMaxDuration)

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_13) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_13 + var_16_18 and arg_13_1.time_ < var_16_13 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
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
	Play900000004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 900000004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play900000005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1033"]) and arg_17_1.var_.actorSpriteComps1033 == nil then
				arg_17_1.var_.actorSpriteComps1033 = arg_17_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1033"]) then
				if arg_17_1.var_.actorSpriteComps1033 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 1, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1033"]) and arg_17_1.var_.actorSpriteComps1033 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1033 = nil
			end

			local var_20_2 = arg_17_1.actors_["1038"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1038 == nil then
				arg_17_1.var_.actorSpriteComps1038 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1038 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								iter_20_5.color = Color.New(Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_5.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_5.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1038 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_20_7 then
						iter_20_7.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1038 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(900000004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 36 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 36)

				if (36 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 36)) > 0 and var_20_6 < var_20_9 then
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

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play900000005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 900000005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play900000006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(900000005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 37)

				if (37 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 37)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play900000006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 900000006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play900000007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1033 = arg_25_1.actors_["1033"].transform.localPosition
				arg_25_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1033", 2)

				for iter_28_0 = 0, arg_25_1.actors_["1033"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1033"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_6" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_28_2 = arg_25_1.actors_["1033"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1033 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1033", 7)

				for iter_28_1 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_1)

					if var_28_3.name == "split_1" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_5 = 0
			local var_28_6 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(900000006).content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 17 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 17)

				if (17 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 17)) > 0 and var_28_6 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_10 and arg_25_1.time_ < var_28_5 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play900000007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 900000007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play900000008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1038 = arg_29_1.actors_["1038"].transform.localPosition
				arg_29_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1038", 4)

				for iter_32_0 = 0, arg_29_1.actors_["1038"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1038"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_2" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1038, Vector3.New(390, -400, 0), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1038"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_32_2 = arg_29_1.actors_["1033"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1033 == nil then
				arg_29_1.var_.actorSpriteComps1033 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1033 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1033 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1033 = nil
			end

			local var_32_5 = arg_29_1.actors_["1038"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1038 == nil then
				arg_29_1.var_.actorSpriteComps1038 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps1038 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps1038:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps1038 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_32_8 then
						iter_32_8.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1038 = nil
			end

			local var_32_8 = arg_29_1.actors_["1038"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1038 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1038", 7)

				for iter_32_9 = 0, var_32_8.childCount - 1 do
					local var_32_9 = var_32_8:GetChild(iter_32_9)

					if var_32_9.name == "split_1" or not string.find(var_32_9.name, "split") then
						var_32_9.gameObject:SetActive(true)
					else
						var_32_9.gameObject:SetActive(false)
					end
				end
			end

			local var_32_10 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_10 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_10)
			end

			if arg_29_1.time_ >= 0 + var_32_10 and arg_29_1.time_ < 0 + var_32_10 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_11 = 0
			local var_32_12 = 0.75

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(900000007).content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 30 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_13) / 30)

				if (30 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_13) / 30)) > 0 and var_32_12 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_16 and arg_29_1.time_ < var_32_11 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900000008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 900000008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play900000009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1019"] == nil then
				local var_36_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_36_0) then
					local var_36_1 = Object.Instantiate(var_36_0, arg_33_1.canvasGo_.transform)

					var_36_1.transform:SetSiblingIndex(1)

					var_36_1.name = "1019"
					var_36_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_33_1.actors_["1019"] = var_36_1

					if arg_33_1.isInRecall_ then
						for iter_36_0, iter_36_1 in ipairs((var_36_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_36_1.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_36_2 = arg_33_1.actors_["1019"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1019 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1019", 3)

				for iter_36_2 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_2)

					if var_36_3.name == "split_1" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1019, Vector3.New(-210, -340, 200), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(-210, -340, 200)
			end

			local var_36_5 = arg_33_1.actors_["1019"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps1019 == nil then
				arg_33_1.var_.actorSpriteComps1019 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps1019 then
					for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_36_4 then
							if arg_33_1.isInRecall_ then
								iter_36_4.color = Color.New(Mathf.Lerp(iter_36_4.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_4.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_4.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_4.color.r, 1, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_4.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps1019 then
				for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_36_6 then
						iter_36_6.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1019 = nil
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_8 = arg_33_1.actors_["1019"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_8 then
					arg_33_1.var_.alphaOldValue1019 = var_36_8.alpha
					arg_33_1.var_.characterEffect1019 = var_36_8
				end

				arg_33_1.var_.alphaOldValue1019 = 0
			end

			local var_36_9 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				if arg_33_1.var_.characterEffect1019 then
					arg_33_1.var_.characterEffect1019.alpha = Mathf.Lerp(arg_33_1.var_.alphaOldValue1019, 1, (arg_33_1.time_ - 0) / var_36_9)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and arg_33_1.var_.characterEffect1019 then
				arg_33_1.var_.characterEffect1019.alpha = 1
			end

			local var_36_10 = arg_33_1.actors_["1033"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1033 = var_36_10.localPosition
				var_36_10.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1033", 7)

				for iter_36_7 = 0, var_36_10.childCount - 1 do
					local var_36_11 = var_36_10:GetChild(iter_36_7)

					if var_36_11.name == "split_6" or not string.find(var_36_11.name, "split") then
						var_36_11.gameObject:SetActive(true)
					else
						var_36_11.gameObject:SetActive(false)
					end
				end
			end

			local var_36_12 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_12 then
				var_36_10.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_12)
			end

			if arg_33_1.time_ >= 0 + var_36_12 and arg_33_1.time_ < 0 + var_36_12 + arg_36_0 then
				var_36_10.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_13 = arg_33_1.actors_["1038"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1038 = var_36_13.localPosition
				var_36_13.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1038", 7)

				for iter_36_8 = 0, var_36_13.childCount - 1 do
					local var_36_14 = var_36_13:GetChild(iter_36_8)

					if var_36_14.name == "split_2" or not string.find(var_36_14.name, "split") then
						var_36_14.gameObject:SetActive(true)
					else
						var_36_14.gameObject:SetActive(false)
					end
				end
			end

			local var_36_15 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_15 then
				var_36_13.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_15)
			end

			if arg_33_1.time_ >= 0 + var_36_15 and arg_33_1.time_ < 0 + var_36_15 + arg_36_0 then
				var_36_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_16 = 0
			local var_36_17 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(900000008).content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 33 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_18) / 33)

				if (33 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_18) / 33)) > 0 and var_36_17 < var_36_20 then
					arg_33_1.talkMaxDuration = var_36_20

					if var_36_20 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_21 and arg_33_1.time_ < var_36_16 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900000009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 900000009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play900000010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1033 = arg_37_1.actors_["1033"].transform.localPosition
				arg_37_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1033", 3)

				for iter_40_0 = 0, arg_37_1.actors_["1033"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1033"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_2" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_40_2 = arg_37_1.actors_["1033"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.1

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_5 = arg_37_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_5 then
					arg_37_1.var_.alphaOldValue1033 = var_40_5.alpha
					arg_37_1.var_.characterEffect1033 = var_40_5
				end

				arg_37_1.var_.alphaOldValue1033 = 0
			end

			local var_40_6 = 0.1

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 then
				if arg_37_1.var_.characterEffect1033 then
					arg_37_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue1033, 1, (arg_37_1.time_ - 0) / var_40_6)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and arg_37_1.var_.characterEffect1033 then
				arg_37_1.var_.characterEffect1033.alpha = 1
			end

			local var_40_7 = arg_37_1.actors_["1019"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1019 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1019", 7)

				for iter_40_5 = 0, var_40_7.childCount - 1 do
					local var_40_8 = var_40_7:GetChild(iter_40_5)

					if var_40_8.name == "split_1" or not string.find(var_40_8.name, "split") then
						var_40_8.gameObject:SetActive(true)
					else
						var_40_8.gameObject:SetActive(false)
					end
				end
			end

			local var_40_9 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 then
				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_37_1.time_ - 0) / var_40_9)
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_40_10 = 0
			local var_40_11 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_12 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(900000009).content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_14 = 24 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_12) / 24)

				if (24 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_12) / 24)) > 0 and var_40_11 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_15 and arg_37_1.time_ < var_40_10 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play900000010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 900000010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play900000011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1038 = arg_41_1.actors_["1038"].transform.localPosition
				arg_41_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1038", 2)

				for iter_44_0 = 0, arg_41_1.actors_["1038"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1038"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_2" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_44_2 = arg_41_1.actors_["1038"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1038 == nil then
				arg_41_1.var_.actorSpriteComps1038 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1038 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1038 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1038 = nil
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_5 = arg_41_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_5 then
					arg_41_1.var_.alphaOldValue1038 = var_44_5.alpha
					arg_41_1.var_.characterEffect1038 = var_44_5
				end

				arg_41_1.var_.alphaOldValue1038 = 0
			end

			local var_44_6 = 0.1

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 then
				if arg_41_1.var_.characterEffect1038 then
					arg_41_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_41_1.var_.alphaOldValue1038, 1, (arg_41_1.time_ - 0) / var_44_6)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and arg_41_1.var_.characterEffect1038 then
				arg_41_1.var_.characterEffect1038.alpha = 1
			end

			local var_44_7 = arg_41_1.actors_["1033"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1033 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1033", 7)

				for iter_44_5 = 0, var_44_7.childCount - 1 do
					local var_44_8 = var_44_7:GetChild(iter_44_5)

					if var_44_8.name == "split_2" or not string.find(var_44_8.name, "split") then
						var_44_8.gameObject:SetActive(true)
					else
						var_44_8.gameObject:SetActive(false)
					end
				end
			end

			local var_44_9 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 then
				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_9)
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_10 = 0
			local var_44_11 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_12 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(900000010).content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_14 = 30 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_12) / 30)

				if (30 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_12) / 30)) > 0 and var_44_11 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_15 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_15 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_15

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_15 and arg_41_1.time_ < var_44_10 + var_44_15 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play900000011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 900000011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play900000012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1019 = arg_45_1.actors_["1019"].transform.localPosition
				arg_45_1.actors_["1019"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1019", 4)

				for iter_48_0 = 0, arg_45_1.actors_["1019"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1019"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_1" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1019"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1019, Vector3.New(180, -340, 200), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1019"].transform.localPosition = Vector3.New(180, -340, 200)
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_2 = arg_45_1.actors_["1019"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_2 then
					arg_45_1.var_.alphaOldValue1019 = var_48_2.alpha
					arg_45_1.var_.characterEffect1019 = var_48_2
				end

				arg_45_1.var_.alphaOldValue1019 = 0
			end

			local var_48_3 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 then
				if arg_45_1.var_.characterEffect1019 then
					arg_45_1.var_.characterEffect1019.alpha = Mathf.Lerp(arg_45_1.var_.alphaOldValue1019, 1, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and arg_45_1.var_.characterEffect1019 then
				arg_45_1.var_.characterEffect1019.alpha = 1
			end

			local var_48_4 = arg_45_1.actors_["1019"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1019 == nil then
				arg_45_1.var_.actorSpriteComps1019 = var_48_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_5 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.actorSpriteComps1019 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_5), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_5), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_5)))
							else
								local var_48_6 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_5)

								iter_48_2.color = Color.New(var_48_6, var_48_6, var_48_6)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1019 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1019 = nil
			end

			local var_48_7 = arg_45_1.actors_["1038"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1038 == nil then
				arg_45_1.var_.actorSpriteComps1038 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_8 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_8 and not isNil(var_48_7) then
				if arg_45_1.var_.actorSpriteComps1038 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_8), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_8), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_8)))
							else
								local var_48_9 = Mathf.Lerp(iter_48_6.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_8)

								iter_48_6.color = Color.New(var_48_9, var_48_9, var_48_9)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_8 and arg_45_1.time_ < 0 + var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1038 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1038 = nil
			end

			local var_48_10 = 0
			local var_48_11 = 0.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_12 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(900000011).content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_14 = 7 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_12) / 7)

				if (7 <= 0 and var_48_11 or var_48_11 * (utf8.len(var_48_12) / 7)) > 0 and var_48_11 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_15 and arg_45_1.time_ < var_48_10 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
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
	Play900000012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 900000012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play900000013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1038 = arg_49_1.actors_["1038"].transform.localPosition
				arg_49_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1038", 2)

				for iter_52_0 = 0, arg_49_1.actors_["1038"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1038"].transform:GetChild(iter_52_0)

					if var_52_0.name == "split_1" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1038, Vector3.New(-390, -400, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1038"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_52_2 = arg_49_1.actors_["1019"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1019 == nil then
				arg_49_1.var_.actorSpriteComps1019 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.1

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1019 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1019 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps1019 = nil
			end

			local var_52_5 = arg_49_1.actors_["1038"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1038 == nil then
				arg_49_1.var_.actorSpriteComps1038 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.1

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps1038 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								iter_52_6.color = Color.New(Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_6.color.r, 1, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_6.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps1038 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_52_8 then
						iter_52_8.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1038 = nil
			end

			local var_52_8 = arg_49_1.actors_["1038"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1038 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1038", 7)

				for iter_52_9 = 0, var_52_8.childCount - 1 do
					local var_52_9 = var_52_8:GetChild(iter_52_9)

					if var_52_9.name == "split_2" or not string.find(var_52_9.name, "split") then
						var_52_9.gameObject:SetActive(true)
					else
						var_52_9.gameObject:SetActive(false)
					end
				end
			end

			local var_52_10 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_10 then
				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_10)
			end

			if arg_49_1.time_ >= 0 + var_52_10 and arg_49_1.time_ < 0 + var_52_10 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_11 = 0
			local var_52_12 = 0.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(900000012).content)

				arg_49_1.text_.text = var_52_13

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 9 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_13) / 9)

				if (9 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_13) / 9)) > 0 and var_52_12 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_13
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_16 and arg_49_1.time_ < var_52_11 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900000013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 900000013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play900000014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1019"]) and arg_53_1.var_.actorSpriteComps1019 == nil then
				arg_53_1.var_.actorSpriteComps1019 = arg_53_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1019"]) then
				if arg_53_1.var_.actorSpriteComps1019 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1019"]) and arg_53_1.var_.actorSpriteComps1019 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1019 = nil
			end

			local var_56_2 = arg_53_1.actors_["1038"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1038 == nil then
				arg_53_1.var_.actorSpriteComps1038 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps1038 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								iter_56_5.color = Color.New(Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_5.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_5.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps1038 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_56_7 then
						iter_56_7.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1038 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.775

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(900000013).content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 31 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_7) / 31)

				if (31 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_7) / 31)) > 0 and var_56_6 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_10 and arg_53_1.time_ < var_56_5 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play900000014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 900000014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play900000015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1033 = arg_57_1.actors_["1033"].transform.localPosition
				arg_57_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1033", 2)

				for iter_60_0 = 0, arg_57_1.actors_["1033"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1033"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_4" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_60_2 = arg_57_1.actors_["1033"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_5 = arg_57_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_5 then
					arg_57_1.var_.alphaOldValue1033 = var_60_5.alpha
					arg_57_1.var_.characterEffect1033 = var_60_5
				end

				arg_57_1.var_.alphaOldValue1033 = 0
			end

			local var_60_6 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 then
				if arg_57_1.var_.characterEffect1033 then
					arg_57_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_57_1.var_.alphaOldValue1033, 1, (arg_57_1.time_ - 0) / var_60_6)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and arg_57_1.var_.characterEffect1033 then
				arg_57_1.var_.characterEffect1033.alpha = 1
			end

			local var_60_7 = arg_57_1.actors_["1019"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1019 == nil then
				arg_57_1.var_.actorSpriteComps1019 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_8 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_8 and not isNil(var_60_7) then
				if arg_57_1.var_.actorSpriteComps1019 then
					for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_60_6 then
							if arg_57_1.isInRecall_ then
								iter_60_6.color = Color.New(Mathf.Lerp(iter_60_6.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_8), Mathf.Lerp(iter_60_6.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_8), (Mathf.Lerp(iter_60_6.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_8)))
							else
								local var_60_9 = Mathf.Lerp(iter_60_6.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_8)

								iter_60_6.color = Color.New(var_60_9, var_60_9, var_60_9)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_8 and arg_57_1.time_ < 0 + var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1019 then
				for iter_60_7, iter_60_8 in pairs(arg_57_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_60_8 then
						iter_60_8.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1019 = nil
			end

			local var_60_10 = arg_57_1.actors_["1038"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1038 = var_60_10.localPosition
				var_60_10.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1038", 7)

				for iter_60_9 = 0, var_60_10.childCount - 1 do
					local var_60_11 = var_60_10:GetChild(iter_60_9)

					if var_60_11.name == "split_1" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_12 then
				var_60_10.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_12)
			end

			if arg_57_1.time_ >= 0 + var_60_12 and arg_57_1.time_ < 0 + var_60_12 + arg_60_0 then
				var_60_10.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_13 = 0
			local var_60_14 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(900000014).content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 16 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_15) / 16)

				if (16 <= 0 and var_60_14 or var_60_14 * (utf8.len(var_60_15) / 16)) > 0 and var_60_14 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17

					if var_60_17 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_13) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_13 + var_60_18 and arg_57_1.time_ < var_60_13 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900000015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 900000015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play900000016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1019"]) and arg_61_1.var_.actorSpriteComps1019 == nil then
				arg_61_1.var_.actorSpriteComps1019 = arg_61_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1019"]) then
				if arg_61_1.var_.actorSpriteComps1019 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1019"]) and arg_61_1.var_.actorSpriteComps1019 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1019 = nil
			end

			local var_64_2 = arg_61_1.actors_["1033"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.1

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_5 = arg_61_1.actors_["1033"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033 = var_64_5.localPosition
				var_64_5.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1033", 7)

				for iter_64_8 = 0, var_64_5.childCount - 1 do
					local var_64_6 = var_64_5:GetChild(iter_64_8)

					if var_64_6.name == "split_4" or not string.find(var_64_6.name, "split") then
						var_64_6.gameObject:SetActive(true)
					else
						var_64_6.gameObject:SetActive(false)
					end
				end
			end

			local var_64_7 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_7)
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_8 = arg_61_1.actors_["1033"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1033", 2)

				for iter_64_9 = 0, var_64_8.childCount - 1 do
					local var_64_9 = var_64_8:GetChild(iter_64_9)

					if var_64_9.name == "split_5" or not string.find(var_64_9.name, "split") then
						var_64_9.gameObject:SetActive(true)
					else
						var_64_9.gameObject:SetActive(false)
					end
				end
			end

			local var_64_10 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_10 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_61_1.time_ - 0) / var_64_10)
			end

			if arg_61_1.time_ >= 0 + var_64_10 and arg_61_1.time_ < 0 + var_64_10 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_64_11 = 0
			local var_64_12 = 0.85

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(900000015).content)

				arg_61_1.text_.text = var_64_13

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 34 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_13) / 34)

				if (34 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_13) / 34)) > 0 and var_64_12 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_13
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_16 and arg_61_1.time_ < var_64_11 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play900000016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 900000016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play900000017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1019"]) and arg_65_1.var_.actorSpriteComps1019 == nil then
				arg_65_1.var_.actorSpriteComps1019 = arg_65_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1019"]) then
				if arg_65_1.var_.actorSpriteComps1019 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1019"]) and arg_65_1.var_.actorSpriteComps1019 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1019 = nil
			end

			local var_68_2 = arg_65_1.actors_["1033"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 == nil then
				arg_65_1.var_.actorSpriteComps1033 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.1

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1033 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1033 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(900000016).content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 24 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 24)

				if (24 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 24)) > 0 and var_68_6 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_10 and arg_65_1.time_ < var_68_5 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play900000017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 900000017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play900000018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1038 = arg_69_1.actors_["1038"].transform.localPosition
				arg_69_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1038", 3)

				for iter_72_0 = 0, arg_69_1.actors_["1038"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["1038"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_1" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1038, Vector3.New(0, -400, 0), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1038"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_2 = arg_69_1.actors_["1038"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_2 then
					arg_69_1.var_.alphaOldValue1038 = var_72_2.alpha
					arg_69_1.var_.characterEffect1038 = var_72_2
				end

				arg_69_1.var_.alphaOldValue1038 = 0
			end

			local var_72_3 = 0.1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 then
				if arg_69_1.var_.characterEffect1038 then
					arg_69_1.var_.characterEffect1038.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue1038, 1, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and arg_69_1.var_.characterEffect1038 then
				arg_69_1.var_.characterEffect1038.alpha = 1
			end

			local var_72_4 = arg_69_1.actors_["1038"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.actorSpriteComps1038 == nil then
				arg_69_1.var_.actorSpriteComps1038 = var_72_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_5 = 0.1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.actorSpriteComps1038 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_5), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_5), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_5)))
							else
								local var_72_6 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_5)

								iter_72_2.color = Color.New(var_72_6, var_72_6, var_72_6)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.actorSpriteComps1038 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1038 = nil
			end

			local var_72_7 = arg_69_1.actors_["1033"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_7.localPosition
				var_72_7.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 7)

				for iter_72_5 = 0, var_72_7.childCount - 1 do
					local var_72_8 = var_72_7:GetChild(iter_72_5)

					if var_72_8.name == "split_5" or not string.find(var_72_8.name, "split") then
						var_72_8.gameObject:SetActive(true)
					else
						var_72_8.gameObject:SetActive(false)
					end
				end
			end

			local var_72_9 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_9)
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_10 = arg_69_1.actors_["1019"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1019 = var_72_10.localPosition
				var_72_10.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1019", 7)

				for iter_72_6 = 0, var_72_10.childCount - 1 do
					local var_72_11 = var_72_10:GetChild(iter_72_6)

					if var_72_11.name == "split_1" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_12 then
				var_72_10.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_69_1.time_ - 0) / var_72_12)
			end

			if arg_69_1.time_ >= 0 + var_72_12 and arg_69_1.time_ < 0 + var_72_12 + arg_72_0 then
				var_72_10.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_72_13 = 0
			local var_72_14 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(900000017).content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 16 <= 0 and var_72_14 or var_72_14 * (utf8.len(var_72_15) / 16)

				if (16 <= 0 and var_72_14 or var_72_14 * (utf8.len(var_72_15) / 16)) > 0 and var_72_14 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_13
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = math.max(var_72_14, arg_69_1.talkMaxDuration)

			if var_72_13 <= arg_69_1.time_ and arg_69_1.time_ < var_72_13 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_13) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_13 + var_72_18 and arg_69_1.time_ < var_72_13 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play900000018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 900000018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play900000019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1038 = arg_73_1.actors_["1038"].transform.localPosition
				arg_73_1.actors_["1038"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1038", 7)

				for iter_76_0 = 0, arg_73_1.actors_["1038"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1038"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_1" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1038"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1038, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1038"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_2 = arg_73_1.actors_["1019"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1019 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1019", 3)

				for iter_76_1 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_1)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1019, Vector3.New(-210, -340, 200), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(-210, -340, 200)
			end

			local var_76_5 = arg_73_1.actors_["1019"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps1019 == nil then
				arg_73_1.var_.actorSpriteComps1019 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 0.1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps1019 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_3.color.r, 1, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_3.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps1019 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1019 = nil
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_8 = arg_73_1.actors_["1019"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_8 then
					arg_73_1.var_.alphaOldValue1019 = var_76_8.alpha
					arg_73_1.var_.characterEffect1019 = var_76_8
				end

				arg_73_1.var_.alphaOldValue1019 = 0
			end

			local var_76_9 = 0.1

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 then
				if arg_73_1.var_.characterEffect1019 then
					arg_73_1.var_.characterEffect1019.alpha = Mathf.Lerp(arg_73_1.var_.alphaOldValue1019, 1, (arg_73_1.time_ - 0) / var_76_9)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and arg_73_1.var_.characterEffect1019 then
				arg_73_1.var_.characterEffect1019.alpha = 1
			end

			local var_76_10 = 0
			local var_76_11 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_12 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(900000018).content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_14 = 8 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_12) / 8)

				if (8 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_12) / 8)) > 0 and var_76_11 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_15 and arg_73_1.time_ < var_76_10 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play900000019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 900000019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
			arg_77_1.auto_ = false
		end

		function arg_77_1.playNext_(arg_79_0)
			arg_77_1.onStoryFinished_()
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = arg_77_1.actors_["1033"].transform.localPosition
				arg_77_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 3)

				for iter_80_0 = 0, arg_77_1.actors_["1033"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["1033"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_4" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_80_2 = arg_77_1.actors_["1019"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1019 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1019", 7)

				for iter_80_1 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_1)

					if var_80_3.name == "split_1" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1019, Vector3.New(0, -2000, 200), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_80_5 = arg_77_1.actors_["1033"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1033 == nil then
				arg_77_1.var_.actorSpriteComps1033 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps1033 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_3.color.r, 1, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_3.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps1033 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_8 = arg_77_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_8 then
					arg_77_1.var_.alphaOldValue1033 = var_80_8.alpha
					arg_77_1.var_.characterEffect1033 = var_80_8
				end

				arg_77_1.var_.alphaOldValue1033 = 0
			end

			local var_80_9 = 0.1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 then
				if arg_77_1.var_.characterEffect1033 then
					arg_77_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_77_1.var_.alphaOldValue1033, 1, (arg_77_1.time_ - 0) / var_80_9)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and arg_77_1.var_.characterEffect1033 then
				arg_77_1.var_.characterEffect1033.alpha = 1
			end

			local var_80_10 = 0
			local var_80_11 = 0.05

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(900000019).content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_14 = 2 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_12) / 2)

				if (2 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_12) / 2)) > 0 and var_80_11 < var_80_14 then
					arg_77_1.talkMaxDuration = var_80_14

					if var_80_14 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_15 and arg_77_1.time_ < var_80_10 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01a"
	},
	voices = {}
}
