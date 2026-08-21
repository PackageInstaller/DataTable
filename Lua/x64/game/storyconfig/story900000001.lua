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
			local var_4_0 = "F01a"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.F01a

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 2.77555756156289e-17
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 2
			local var_4_29 = 0.675

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2
			local var_4_35 = 0.675

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(900000001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 27
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
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
			local var_12_0 = "1033"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["1033"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 2)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_1" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(-390, -420, 0)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_12_11 = arg_9_1.actors_["1033"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				local var_12_13 = var_12_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_13 then
					arg_9_1.var_.alphaOldValue1033 = var_12_13.alpha
					arg_9_1.var_.characterEffect1033 = var_12_13
				end

				arg_9_1.var_.alphaOldValue1033 = 0
			end

			local var_12_14 = 0.5

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_14 then
				local var_12_15 = (arg_9_1.time_ - var_12_12) / var_12_14
				local var_12_16 = Mathf.Lerp(arg_9_1.var_.alphaOldValue1033, 1, var_12_15)

				if arg_9_1.var_.characterEffect1033 then
					arg_9_1.var_.characterEffect1033.alpha = var_12_16
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_14 and arg_9_1.time_ < var_12_12 + var_12_14 + arg_12_0 and arg_9_1.var_.characterEffect1033 then
				arg_9_1.var_.characterEffect1033.alpha = 1
			end

			local var_12_17 = 0
			local var_12_18 = 0.625

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_19 = arg_9_1:FormatText(StoryNameCfg[236].name)

				arg_9_1.leftNameTxt_.text = var_12_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_20 = arg_9_1:GetWordFromCfg(900000002)
				local var_12_21 = arg_9_1:FormatText(var_12_20.content)

				arg_9_1.text_.text = var_12_21

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_22 = 25
				local var_12_23 = utf8.len(var_12_21)
				local var_12_24 = var_12_22 <= 0 and var_12_18 or var_12_18 * (var_12_23 / var_12_22)

				if var_12_24 > 0 and var_12_18 < var_12_24 then
					arg_9_1.talkMaxDuration = var_12_24

					if var_12_24 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_24 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_21
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_25 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_25 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_17) / var_12_25

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_17 + var_12_25 and arg_9_1.time_ < var_12_17 + var_12_25 + arg_12_0 then
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
			local var_16_0 = "1038"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["1038"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos1038 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1038", 4)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_1" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(390, -400, 0)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1038, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(390, -400, 0)
			end

			local var_16_11 = arg_13_1.actors_["1038"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				local var_16_13 = var_16_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_13 then
					arg_13_1.var_.alphaOldValue1038 = var_16_13.alpha
					arg_13_1.var_.characterEffect1038 = var_16_13
				end

				arg_13_1.var_.alphaOldValue1038 = 0
			end

			local var_16_14 = 0.5

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_14 then
				local var_16_15 = (arg_13_1.time_ - var_16_12) / var_16_14
				local var_16_16 = Mathf.Lerp(arg_13_1.var_.alphaOldValue1038, 1, var_16_15)

				if arg_13_1.var_.characterEffect1038 then
					arg_13_1.var_.characterEffect1038.alpha = var_16_16
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_14 and arg_13_1.time_ < var_16_12 + var_16_14 + arg_16_0 and arg_13_1.var_.characterEffect1038 then
				arg_13_1.var_.characterEffect1038.alpha = 1
			end

			local var_16_17 = arg_13_1.actors_["1038"]
			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps1038 == nil then
				arg_13_1.var_.actorSpriteComps1038 = var_16_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_19 = 0.2

			if var_16_18 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 and not isNil(var_16_17) then
				local var_16_20 = (arg_13_1.time_ - var_16_18) / var_16_19

				if arg_13_1.var_.actorSpriteComps1038 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_21 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_20)
								local var_16_22 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_20)
								local var_16_23 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_20)

								iter_16_4.color = Color.New(var_16_21, var_16_22, var_16_23)
							else
								local var_16_24 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_20)

								iter_16_4.color = Color.New(var_16_24, var_16_24, var_16_24)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps1038 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1038 = nil
			end

			local var_16_25 = arg_13_1.actors_["1033"]
			local var_16_26 = 0

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 and not isNil(var_16_25) and arg_13_1.var_.actorSpriteComps1033 == nil then
				arg_13_1.var_.actorSpriteComps1033 = var_16_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_27 = 0.2

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_27 and not isNil(var_16_25) then
				local var_16_28 = (arg_13_1.time_ - var_16_26) / var_16_27

				if arg_13_1.var_.actorSpriteComps1033 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								local var_16_29 = Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor2.r, var_16_28)
								local var_16_30 = Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor2.g, var_16_28)
								local var_16_31 = Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor2.b, var_16_28)

								iter_16_8.color = Color.New(var_16_29, var_16_30, var_16_31)
							else
								local var_16_32 = Mathf.Lerp(iter_16_8.color.r, 0.5, var_16_28)

								iter_16_8.color = Color.New(var_16_32, var_16_32, var_16_32)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_26 + var_16_27 and arg_13_1.time_ < var_16_26 + var_16_27 + arg_16_0 and not isNil(var_16_25) and arg_13_1.var_.actorSpriteComps1033 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_16_10 then
						if arg_13_1.isInRecall_ then
							iter_16_10.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1033 = nil
			end

			local var_16_33 = 0.5
			local var_16_34 = 0.55

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_35 = arg_13_1:FormatText(StoryNameCfg[94].name)

				arg_13_1.leftNameTxt_.text = var_16_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_36 = arg_13_1:GetWordFromCfg(900000003)
				local var_16_37 = arg_13_1:FormatText(var_16_36.content)

				arg_13_1.text_.text = var_16_37

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_38 = 22
				local var_16_39 = utf8.len(var_16_37)
				local var_16_40 = var_16_38 <= 0 and var_16_34 or var_16_34 * (var_16_39 / var_16_38)

				if var_16_40 > 0 and var_16_34 < var_16_40 then
					arg_13_1.talkMaxDuration = var_16_40

					if var_16_40 + var_16_33 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_40 + var_16_33
					end
				end

				arg_13_1.text_.text = var_16_37
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_41 = math.max(var_16_34, arg_13_1.talkMaxDuration)

			if var_16_33 <= arg_13_1.time_ and arg_13_1.time_ < var_16_33 + var_16_41 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_33) / var_16_41

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_33 + var_16_41 and arg_13_1.time_ < var_16_33 + var_16_41 + arg_16_0 then
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
			local var_20_0 = arg_17_1.actors_["1033"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1033 == nil then
				arg_17_1.var_.actorSpriteComps1033 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1033 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1033 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1033 = nil
			end

			local var_20_8 = arg_17_1.actors_["1038"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1038 == nil then
				arg_17_1.var_.actorSpriteComps1038 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1038 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1038 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1038 = nil
			end

			local var_20_16 = 0
			local var_20_17 = 0.9

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_18 = arg_17_1:FormatText(StoryNameCfg[236].name)

				arg_17_1.leftNameTxt_.text = var_20_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(900000004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 36
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_17 or var_20_17 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_17 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_24 and arg_17_1.time_ < var_20_16 + var_20_24 + arg_20_0 then
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
			local var_24_0 = 0
			local var_24_1 = 0.925

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[236].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(900000005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 37
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
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
			local var_28_0 = arg_25_1.actors_["1033"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1033 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1033", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_6" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-390, -420, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1033, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_28_7 = arg_25_1.actors_["1033"].transform
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.var_.moveOldPos1033 = var_28_7.localPosition
				var_28_7.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1033", 7)

				local var_28_9 = var_28_7.childCount

				for iter_28_1 = 0, var_28_9 - 1 do
					local var_28_10 = var_28_7:GetChild(iter_28_1)

					if var_28_10.name == "split_1" or not string.find(var_28_10.name, "split") then
						var_28_10.gameObject:SetActive(true)
					else
						var_28_10.gameObject:SetActive(false)
					end
				end
			end

			local var_28_11 = 0.001

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_8) / var_28_11
				local var_28_13 = Vector3.New(0, -2000, 0)

				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1033, var_28_13, var_28_12)
			end

			if arg_25_1.time_ >= var_28_8 + var_28_11 and arg_25_1.time_ < var_28_8 + var_28_11 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_14 = 0
			local var_28_15 = 0.425

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_16 = arg_25_1:FormatText(StoryNameCfg[236].name)

				arg_25_1.leftNameTxt_.text = var_28_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(900000006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 17
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_15 or var_28_15 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_15 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_14
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_15, arg_25_1.talkMaxDuration)

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_22 and arg_25_1.time_ < var_28_14 + var_28_22 + arg_28_0 then
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
			local var_32_0 = arg_29_1.actors_["1038"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1038 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1038", 4)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_2" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(390, -400, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1038, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_32_7 = arg_29_1.actors_["1033"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1033 == nil then
				arg_29_1.var_.actorSpriteComps1033 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.2

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps1033 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor2.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor2.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor2.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 0.5, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1033 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1033 = nil
			end

			local var_32_15 = arg_29_1.actors_["1038"]
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps1038 == nil then
				arg_29_1.var_.actorSpriteComps1038 = var_32_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_17 = 0.2

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 and not isNil(var_32_15) then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17

				if arg_29_1.var_.actorSpriteComps1038 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								local var_32_19 = Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor1.r, var_32_18)
								local var_32_20 = Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor1.g, var_32_18)
								local var_32_21 = Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor1.b, var_32_18)

								iter_32_6.color = Color.New(var_32_19, var_32_20, var_32_21)
							else
								local var_32_22 = Mathf.Lerp(iter_32_6.color.r, 1, var_32_18)

								iter_32_6.color = Color.New(var_32_22, var_32_22, var_32_22)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps1038 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_32_8 then
						if arg_29_1.isInRecall_ then
							iter_32_8.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1038 = nil
			end

			local var_32_23 = arg_29_1.actors_["1038"].transform
			local var_32_24 = 0

			if var_32_24 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 then
				arg_29_1.var_.moveOldPos1038 = var_32_23.localPosition
				var_32_23.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1038", 7)

				local var_32_25 = var_32_23.childCount

				for iter_32_9 = 0, var_32_25 - 1 do
					local var_32_26 = var_32_23:GetChild(iter_32_9)

					if var_32_26.name == "split_1" or not string.find(var_32_26.name, "split") then
						var_32_26.gameObject:SetActive(true)
					else
						var_32_26.gameObject:SetActive(false)
					end
				end
			end

			local var_32_27 = 0.001

			if var_32_24 <= arg_29_1.time_ and arg_29_1.time_ < var_32_24 + var_32_27 then
				local var_32_28 = (arg_29_1.time_ - var_32_24) / var_32_27
				local var_32_29 = Vector3.New(0, -2000, 0)

				var_32_23.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1038, var_32_29, var_32_28)
			end

			if arg_29_1.time_ >= var_32_24 + var_32_27 and arg_29_1.time_ < var_32_24 + var_32_27 + arg_32_0 then
				var_32_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_30 = 0
			local var_32_31 = 0.75

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_32 = arg_29_1:FormatText(StoryNameCfg[94].name)

				arg_29_1.leftNameTxt_.text = var_32_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_33 = arg_29_1:GetWordFromCfg(900000007)
				local var_32_34 = arg_29_1:FormatText(var_32_33.content)

				arg_29_1.text_.text = var_32_34

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_35 = 30
				local var_32_36 = utf8.len(var_32_34)
				local var_32_37 = var_32_35 <= 0 and var_32_31 or var_32_31 * (var_32_36 / var_32_35)

				if var_32_37 > 0 and var_32_31 < var_32_37 then
					arg_29_1.talkMaxDuration = var_32_37

					if var_32_37 + var_32_30 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_37 + var_32_30
					end
				end

				arg_29_1.text_.text = var_32_34
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_38 = math.max(var_32_31, arg_29_1.talkMaxDuration)

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_38 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_30) / var_32_38

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_30 + var_32_38 and arg_29_1.time_ < var_32_30 + var_32_38 + arg_32_0 then
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
			local var_36_0 = "1019"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(var_36_1, arg_33_1.canvasGo_.transform)

					var_36_2.transform:SetSiblingIndex(1)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_33_1.isInRecall_ then
						for iter_36_0, iter_36_1 in ipairs(var_36_3) do
							iter_36_1.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_36_4 = arg_33_1.actors_["1019"].transform
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.var_.moveOldPos1019 = var_36_4.localPosition
				var_36_4.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1019", 3)

				local var_36_6 = var_36_4.childCount

				for iter_36_2 = 0, var_36_6 - 1 do
					local var_36_7 = var_36_4:GetChild(iter_36_2)

					if var_36_7.name == "split_1" or not string.find(var_36_7.name, "split") then
						var_36_7.gameObject:SetActive(true)
					else
						var_36_7.gameObject:SetActive(false)
					end
				end
			end

			local var_36_8 = 0.001

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_5) / var_36_8
				local var_36_10 = Vector3.New(-210, -340, 200)

				var_36_4.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1019, var_36_10, var_36_9)
			end

			if arg_33_1.time_ >= var_36_5 + var_36_8 and arg_33_1.time_ < var_36_5 + var_36_8 + arg_36_0 then
				var_36_4.localPosition = Vector3.New(-210, -340, 200)
			end

			local var_36_11 = arg_33_1.actors_["1019"]
			local var_36_12 = 0

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1019 == nil then
				arg_33_1.var_.actorSpriteComps1019 = var_36_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_13 = 0.2

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_13 and not isNil(var_36_11) then
				local var_36_14 = (arg_33_1.time_ - var_36_12) / var_36_13

				if arg_33_1.var_.actorSpriteComps1019 then
					for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_36_4 then
							if arg_33_1.isInRecall_ then
								local var_36_15 = Mathf.Lerp(iter_36_4.color.r, arg_33_1.hightColor1.r, var_36_14)
								local var_36_16 = Mathf.Lerp(iter_36_4.color.g, arg_33_1.hightColor1.g, var_36_14)
								local var_36_17 = Mathf.Lerp(iter_36_4.color.b, arg_33_1.hightColor1.b, var_36_14)

								iter_36_4.color = Color.New(var_36_15, var_36_16, var_36_17)
							else
								local var_36_18 = Mathf.Lerp(iter_36_4.color.r, 1, var_36_14)

								iter_36_4.color = Color.New(var_36_18, var_36_18, var_36_18)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_12 + var_36_13 and arg_33_1.time_ < var_36_12 + var_36_13 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1019 then
				for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_36_6 then
						if arg_33_1.isInRecall_ then
							iter_36_6.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1019 = nil
			end

			local var_36_19 = arg_33_1.actors_["1019"]
			local var_36_20 = 0

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				local var_36_21 = var_36_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_21 then
					arg_33_1.var_.alphaOldValue1019 = var_36_21.alpha
					arg_33_1.var_.characterEffect1019 = var_36_21
				end

				arg_33_1.var_.alphaOldValue1019 = 0
			end

			local var_36_22 = 0.2

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_22 then
				local var_36_23 = (arg_33_1.time_ - var_36_20) / var_36_22
				local var_36_24 = Mathf.Lerp(arg_33_1.var_.alphaOldValue1019, 1, var_36_23)

				if arg_33_1.var_.characterEffect1019 then
					arg_33_1.var_.characterEffect1019.alpha = var_36_24
				end
			end

			if arg_33_1.time_ >= var_36_20 + var_36_22 and arg_33_1.time_ < var_36_20 + var_36_22 + arg_36_0 and arg_33_1.var_.characterEffect1019 then
				arg_33_1.var_.characterEffect1019.alpha = 1
			end

			local var_36_25 = arg_33_1.actors_["1033"].transform
			local var_36_26 = 0

			if var_36_26 < arg_33_1.time_ and arg_33_1.time_ <= var_36_26 + arg_36_0 then
				arg_33_1.var_.moveOldPos1033 = var_36_25.localPosition
				var_36_25.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1033", 7)

				local var_36_27 = var_36_25.childCount

				for iter_36_7 = 0, var_36_27 - 1 do
					local var_36_28 = var_36_25:GetChild(iter_36_7)

					if var_36_28.name == "split_6" or not string.find(var_36_28.name, "split") then
						var_36_28.gameObject:SetActive(true)
					else
						var_36_28.gameObject:SetActive(false)
					end
				end
			end

			local var_36_29 = 0.001

			if var_36_26 <= arg_33_1.time_ and arg_33_1.time_ < var_36_26 + var_36_29 then
				local var_36_30 = (arg_33_1.time_ - var_36_26) / var_36_29
				local var_36_31 = Vector3.New(0, -2000, 0)

				var_36_25.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1033, var_36_31, var_36_30)
			end

			if arg_33_1.time_ >= var_36_26 + var_36_29 and arg_33_1.time_ < var_36_26 + var_36_29 + arg_36_0 then
				var_36_25.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_32 = arg_33_1.actors_["1038"].transform
			local var_36_33 = 0

			if var_36_33 < arg_33_1.time_ and arg_33_1.time_ <= var_36_33 + arg_36_0 then
				arg_33_1.var_.moveOldPos1038 = var_36_32.localPosition
				var_36_32.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1038", 7)

				local var_36_34 = var_36_32.childCount

				for iter_36_8 = 0, var_36_34 - 1 do
					local var_36_35 = var_36_32:GetChild(iter_36_8)

					if var_36_35.name == "split_2" or not string.find(var_36_35.name, "split") then
						var_36_35.gameObject:SetActive(true)
					else
						var_36_35.gameObject:SetActive(false)
					end
				end
			end

			local var_36_36 = 0.001

			if var_36_33 <= arg_33_1.time_ and arg_33_1.time_ < var_36_33 + var_36_36 then
				local var_36_37 = (arg_33_1.time_ - var_36_33) / var_36_36
				local var_36_38 = Vector3.New(0, -2000, 0)

				var_36_32.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1038, var_36_38, var_36_37)
			end

			if arg_33_1.time_ >= var_36_33 + var_36_36 and arg_33_1.time_ < var_36_33 + var_36_36 + arg_36_0 then
				var_36_32.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_39 = 0
			local var_36_40 = 0.825

			if var_36_39 < arg_33_1.time_ and arg_33_1.time_ <= var_36_39 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_41 = arg_33_1:FormatText(StoryNameCfg[13].name)

				arg_33_1.leftNameTxt_.text = var_36_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_42 = arg_33_1:GetWordFromCfg(900000008)
				local var_36_43 = arg_33_1:FormatText(var_36_42.content)

				arg_33_1.text_.text = var_36_43

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_44 = 33
				local var_36_45 = utf8.len(var_36_43)
				local var_36_46 = var_36_44 <= 0 and var_36_40 or var_36_40 * (var_36_45 / var_36_44)

				if var_36_46 > 0 and var_36_40 < var_36_46 then
					arg_33_1.talkMaxDuration = var_36_46

					if var_36_46 + var_36_39 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_46 + var_36_39
					end
				end

				arg_33_1.text_.text = var_36_43
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_47 = math.max(var_36_40, arg_33_1.talkMaxDuration)

			if var_36_39 <= arg_33_1.time_ and arg_33_1.time_ < var_36_39 + var_36_47 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_39) / var_36_47

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_39 + var_36_47 and arg_33_1.time_ < var_36_39 + var_36_47 + arg_36_0 then
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
			local var_40_0 = arg_37_1.actors_["1033"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1033 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1033", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_2" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -420, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1033, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -420, 0)
			end

			local var_40_7 = arg_37_1.actors_["1033"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.1

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_15 = arg_37_1.actors_["1033"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				local var_40_17 = var_40_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_17 then
					arg_37_1.var_.alphaOldValue1033 = var_40_17.alpha
					arg_37_1.var_.characterEffect1033 = var_40_17
				end

				arg_37_1.var_.alphaOldValue1033 = 0
			end

			local var_40_18 = 0.1

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_18 then
				local var_40_19 = (arg_37_1.time_ - var_40_16) / var_40_18
				local var_40_20 = Mathf.Lerp(arg_37_1.var_.alphaOldValue1033, 1, var_40_19)

				if arg_37_1.var_.characterEffect1033 then
					arg_37_1.var_.characterEffect1033.alpha = var_40_20
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_18 and arg_37_1.time_ < var_40_16 + var_40_18 + arg_40_0 and arg_37_1.var_.characterEffect1033 then
				arg_37_1.var_.characterEffect1033.alpha = 1
			end

			local var_40_21 = arg_37_1.actors_["1019"].transform
			local var_40_22 = 0

			if var_40_22 < arg_37_1.time_ and arg_37_1.time_ <= var_40_22 + arg_40_0 then
				arg_37_1.var_.moveOldPos1019 = var_40_21.localPosition
				var_40_21.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1019", 7)

				local var_40_23 = var_40_21.childCount

				for iter_40_5 = 0, var_40_23 - 1 do
					local var_40_24 = var_40_21:GetChild(iter_40_5)

					if var_40_24.name == "split_1" or not string.find(var_40_24.name, "split") then
						var_40_24.gameObject:SetActive(true)
					else
						var_40_24.gameObject:SetActive(false)
					end
				end
			end

			local var_40_25 = 0.001

			if var_40_22 <= arg_37_1.time_ and arg_37_1.time_ < var_40_22 + var_40_25 then
				local var_40_26 = (arg_37_1.time_ - var_40_22) / var_40_25
				local var_40_27 = Vector3.New(0, -2000, 200)

				var_40_21.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1019, var_40_27, var_40_26)
			end

			if arg_37_1.time_ >= var_40_22 + var_40_25 and arg_37_1.time_ < var_40_22 + var_40_25 + arg_40_0 then
				var_40_21.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_40_28 = 0
			local var_40_29 = 0.6

			if var_40_28 < arg_37_1.time_ and arg_37_1.time_ <= var_40_28 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_30 = arg_37_1:FormatText(StoryNameCfg[236].name)

				arg_37_1.leftNameTxt_.text = var_40_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_31 = arg_37_1:GetWordFromCfg(900000009)
				local var_40_32 = arg_37_1:FormatText(var_40_31.content)

				arg_37_1.text_.text = var_40_32

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_33 = 24
				local var_40_34 = utf8.len(var_40_32)
				local var_40_35 = var_40_33 <= 0 and var_40_29 or var_40_29 * (var_40_34 / var_40_33)

				if var_40_35 > 0 and var_40_29 < var_40_35 then
					arg_37_1.talkMaxDuration = var_40_35

					if var_40_35 + var_40_28 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_35 + var_40_28
					end
				end

				arg_37_1.text_.text = var_40_32
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_36 = math.max(var_40_29, arg_37_1.talkMaxDuration)

			if var_40_28 <= arg_37_1.time_ and arg_37_1.time_ < var_40_28 + var_40_36 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_28) / var_40_36

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_28 + var_40_36 and arg_37_1.time_ < var_40_28 + var_40_36 + arg_40_0 then
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
			local var_44_0 = arg_41_1.actors_["1038"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1038 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1038", 2)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_2" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(-390, -400, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1038, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_44_7 = arg_41_1.actors_["1038"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1038 == nil then
				arg_41_1.var_.actorSpriteComps1038 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.1

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps1038 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1038 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1038 = nil
			end

			local var_44_15 = arg_41_1.actors_["1038"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				local var_44_17 = var_44_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_17 then
					arg_41_1.var_.alphaOldValue1038 = var_44_17.alpha
					arg_41_1.var_.characterEffect1038 = var_44_17
				end

				arg_41_1.var_.alphaOldValue1038 = 0
			end

			local var_44_18 = 0.1

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_18 then
				local var_44_19 = (arg_41_1.time_ - var_44_16) / var_44_18
				local var_44_20 = Mathf.Lerp(arg_41_1.var_.alphaOldValue1038, 1, var_44_19)

				if arg_41_1.var_.characterEffect1038 then
					arg_41_1.var_.characterEffect1038.alpha = var_44_20
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_18 and arg_41_1.time_ < var_44_16 + var_44_18 + arg_44_0 and arg_41_1.var_.characterEffect1038 then
				arg_41_1.var_.characterEffect1038.alpha = 1
			end

			local var_44_21 = arg_41_1.actors_["1033"].transform
			local var_44_22 = 0

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1.var_.moveOldPos1033 = var_44_21.localPosition
				var_44_21.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1033", 7)

				local var_44_23 = var_44_21.childCount

				for iter_44_5 = 0, var_44_23 - 1 do
					local var_44_24 = var_44_21:GetChild(iter_44_5)

					if var_44_24.name == "split_2" or not string.find(var_44_24.name, "split") then
						var_44_24.gameObject:SetActive(true)
					else
						var_44_24.gameObject:SetActive(false)
					end
				end
			end

			local var_44_25 = 0.001

			if var_44_22 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_25 then
				local var_44_26 = (arg_41_1.time_ - var_44_22) / var_44_25
				local var_44_27 = Vector3.New(0, -2000, 0)

				var_44_21.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1033, var_44_27, var_44_26)
			end

			if arg_41_1.time_ >= var_44_22 + var_44_25 and arg_41_1.time_ < var_44_22 + var_44_25 + arg_44_0 then
				var_44_21.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_28 = 0
			local var_44_29 = 0.75

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_30 = arg_41_1:FormatText(StoryNameCfg[94].name)

				arg_41_1.leftNameTxt_.text = var_44_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_31 = arg_41_1:GetWordFromCfg(900000010)
				local var_44_32 = arg_41_1:FormatText(var_44_31.content)

				arg_41_1.text_.text = var_44_32

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_33 = 30
				local var_44_34 = utf8.len(var_44_32)
				local var_44_35 = var_44_33 <= 0 and var_44_29 or var_44_29 * (var_44_34 / var_44_33)

				if var_44_35 > 0 and var_44_29 < var_44_35 then
					arg_41_1.talkMaxDuration = var_44_35

					if var_44_35 + var_44_28 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_35 + var_44_28
					end
				end

				arg_41_1.text_.text = var_44_32
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_36 = math.max(var_44_29, arg_41_1.talkMaxDuration)

			if var_44_28 <= arg_41_1.time_ and arg_41_1.time_ < var_44_28 + var_44_36 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_28) / var_44_36

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_28 + var_44_36 and arg_41_1.time_ < var_44_28 + var_44_36 + arg_44_0 then
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
			local var_48_0 = arg_45_1.actors_["1019"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1019 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1019", 4)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_1" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(180, -340, 200)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1019, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(180, -340, 200)
			end

			local var_48_7 = arg_45_1.actors_["1019"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				local var_48_9 = var_48_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_9 then
					arg_45_1.var_.alphaOldValue1019 = var_48_9.alpha
					arg_45_1.var_.characterEffect1019 = var_48_9
				end

				arg_45_1.var_.alphaOldValue1019 = 0
			end

			local var_48_10 = 0.1

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_10 then
				local var_48_11 = (arg_45_1.time_ - var_48_8) / var_48_10
				local var_48_12 = Mathf.Lerp(arg_45_1.var_.alphaOldValue1019, 1, var_48_11)

				if arg_45_1.var_.characterEffect1019 then
					arg_45_1.var_.characterEffect1019.alpha = var_48_12
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_10 and arg_45_1.time_ < var_48_8 + var_48_10 + arg_48_0 and arg_45_1.var_.characterEffect1019 then
				arg_45_1.var_.characterEffect1019.alpha = 1
			end

			local var_48_13 = arg_45_1.actors_["1019"]
			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.actorSpriteComps1019 == nil then
				arg_45_1.var_.actorSpriteComps1019 = var_48_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_15 = 0.1

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_15 and not isNil(var_48_13) then
				local var_48_16 = (arg_45_1.time_ - var_48_14) / var_48_15

				if arg_45_1.var_.actorSpriteComps1019 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_17 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_16)
								local var_48_18 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_16)
								local var_48_19 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_16)

								iter_48_2.color = Color.New(var_48_17, var_48_18, var_48_19)
							else
								local var_48_20 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_16)

								iter_48_2.color = Color.New(var_48_20, var_48_20, var_48_20)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.actorSpriteComps1019 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1019 = nil
			end

			local var_48_21 = arg_45_1.actors_["1038"]
			local var_48_22 = 0

			if var_48_22 < arg_45_1.time_ and arg_45_1.time_ <= var_48_22 + arg_48_0 and not isNil(var_48_21) and arg_45_1.var_.actorSpriteComps1038 == nil then
				arg_45_1.var_.actorSpriteComps1038 = var_48_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_23 = 0.1

			if var_48_22 <= arg_45_1.time_ and arg_45_1.time_ < var_48_22 + var_48_23 and not isNil(var_48_21) then
				local var_48_24 = (arg_45_1.time_ - var_48_22) / var_48_23

				if arg_45_1.var_.actorSpriteComps1038 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_25 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, var_48_24)
								local var_48_26 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, var_48_24)
								local var_48_27 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, var_48_24)

								iter_48_6.color = Color.New(var_48_25, var_48_26, var_48_27)
							else
								local var_48_28 = Mathf.Lerp(iter_48_6.color.r, 0.5, var_48_24)

								iter_48_6.color = Color.New(var_48_28, var_48_28, var_48_28)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_22 + var_48_23 and arg_45_1.time_ < var_48_22 + var_48_23 + arg_48_0 and not isNil(var_48_21) and arg_45_1.var_.actorSpriteComps1038 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1038 = nil
			end

			local var_48_29 = 0
			local var_48_30 = 0.175

			if var_48_29 < arg_45_1.time_ and arg_45_1.time_ <= var_48_29 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_31 = arg_45_1:FormatText(StoryNameCfg[13].name)

				arg_45_1.leftNameTxt_.text = var_48_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_32 = arg_45_1:GetWordFromCfg(900000011)
				local var_48_33 = arg_45_1:FormatText(var_48_32.content)

				arg_45_1.text_.text = var_48_33

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_34 = 7
				local var_48_35 = utf8.len(var_48_33)
				local var_48_36 = var_48_34 <= 0 and var_48_30 or var_48_30 * (var_48_35 / var_48_34)

				if var_48_36 > 0 and var_48_30 < var_48_36 then
					arg_45_1.talkMaxDuration = var_48_36

					if var_48_36 + var_48_29 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_36 + var_48_29
					end
				end

				arg_45_1.text_.text = var_48_33
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_37 = math.max(var_48_30, arg_45_1.talkMaxDuration)

			if var_48_29 <= arg_45_1.time_ and arg_45_1.time_ < var_48_29 + var_48_37 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_29) / var_48_37

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_29 + var_48_37 and arg_45_1.time_ < var_48_29 + var_48_37 + arg_48_0 then
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
			local var_52_0 = arg_49_1.actors_["1038"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1038 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1038", 2)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_1" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(-390, -400, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1038, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_52_7 = arg_49_1.actors_["1019"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1019 == nil then
				arg_49_1.var_.actorSpriteComps1019 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.1

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1019 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 0.5, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1019 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1019 = nil
			end

			local var_52_15 = arg_49_1.actors_["1038"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1038 == nil then
				arg_49_1.var_.actorSpriteComps1038 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 0.1

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps1038 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								local var_52_19 = Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor1.r, var_52_18)
								local var_52_20 = Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor1.g, var_52_18)
								local var_52_21 = Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor1.b, var_52_18)

								iter_52_6.color = Color.New(var_52_19, var_52_20, var_52_21)
							else
								local var_52_22 = Mathf.Lerp(iter_52_6.color.r, 1, var_52_18)

								iter_52_6.color = Color.New(var_52_22, var_52_22, var_52_22)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1038 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1038 = nil
			end

			local var_52_23 = arg_49_1.actors_["1038"].transform
			local var_52_24 = 0

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.var_.moveOldPos1038 = var_52_23.localPosition
				var_52_23.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1038", 7)

				local var_52_25 = var_52_23.childCount

				for iter_52_9 = 0, var_52_25 - 1 do
					local var_52_26 = var_52_23:GetChild(iter_52_9)

					if var_52_26.name == "split_2" or not string.find(var_52_26.name, "split") then
						var_52_26.gameObject:SetActive(true)
					else
						var_52_26.gameObject:SetActive(false)
					end
				end
			end

			local var_52_27 = 0.001

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_27 then
				local var_52_28 = (arg_49_1.time_ - var_52_24) / var_52_27
				local var_52_29 = Vector3.New(0, -2000, 0)

				var_52_23.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1038, var_52_29, var_52_28)
			end

			if arg_49_1.time_ >= var_52_24 + var_52_27 and arg_49_1.time_ < var_52_24 + var_52_27 + arg_52_0 then
				var_52_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_30 = 0
			local var_52_31 = 0.225

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[94].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(900000012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 9
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_38 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_38 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_38

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_38 and arg_49_1.time_ < var_52_30 + var_52_38 + arg_52_0 then
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
			local var_56_0 = arg_53_1.actors_["1019"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1019 == nil then
				arg_53_1.var_.actorSpriteComps1019 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.1

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1019 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1019 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1019 = nil
			end

			local var_56_8 = arg_53_1.actors_["1038"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1038 == nil then
				arg_53_1.var_.actorSpriteComps1038 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 0.1

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps1038 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 0.5, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps1038 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1038 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 0.775

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_18 = arg_53_1:FormatText(StoryNameCfg[13].name)

				arg_53_1.leftNameTxt_.text = var_56_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(900000013)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 31
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_24 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_24 and arg_53_1.time_ < var_56_16 + var_56_24 + arg_56_0 then
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
			local var_60_0 = arg_57_1.actors_["1033"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1033 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1033", 2)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_4" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(-390, -420, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1033, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_60_7 = arg_57_1.actors_["1033"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.1

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								local var_60_11 = Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, var_60_10)
								local var_60_12 = Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, var_60_10)
								local var_60_13 = Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, var_60_10)

								iter_60_2.color = Color.New(var_60_11, var_60_12, var_60_13)
							else
								local var_60_14 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_10)

								iter_60_2.color = Color.New(var_60_14, var_60_14, var_60_14)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			local var_60_15 = arg_57_1.actors_["1033"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				local var_60_17 = var_60_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_17 then
					arg_57_1.var_.alphaOldValue1033 = var_60_17.alpha
					arg_57_1.var_.characterEffect1033 = var_60_17
				end

				arg_57_1.var_.alphaOldValue1033 = 0
			end

			local var_60_18 = 0.1

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_18 then
				local var_60_19 = (arg_57_1.time_ - var_60_16) / var_60_18
				local var_60_20 = Mathf.Lerp(arg_57_1.var_.alphaOldValue1033, 1, var_60_19)

				if arg_57_1.var_.characterEffect1033 then
					arg_57_1.var_.characterEffect1033.alpha = var_60_20
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_18 and arg_57_1.time_ < var_60_16 + var_60_18 + arg_60_0 and arg_57_1.var_.characterEffect1033 then
				arg_57_1.var_.characterEffect1033.alpha = 1
			end

			local var_60_21 = arg_57_1.actors_["1019"]
			local var_60_22 = 0

			if var_60_22 < arg_57_1.time_ and arg_57_1.time_ <= var_60_22 + arg_60_0 and not isNil(var_60_21) and arg_57_1.var_.actorSpriteComps1019 == nil then
				arg_57_1.var_.actorSpriteComps1019 = var_60_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_23 = 0.1

			if var_60_22 <= arg_57_1.time_ and arg_57_1.time_ < var_60_22 + var_60_23 and not isNil(var_60_21) then
				local var_60_24 = (arg_57_1.time_ - var_60_22) / var_60_23

				if arg_57_1.var_.actorSpriteComps1019 then
					for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_60_6 then
							if arg_57_1.isInRecall_ then
								local var_60_25 = Mathf.Lerp(iter_60_6.color.r, arg_57_1.hightColor2.r, var_60_24)
								local var_60_26 = Mathf.Lerp(iter_60_6.color.g, arg_57_1.hightColor2.g, var_60_24)
								local var_60_27 = Mathf.Lerp(iter_60_6.color.b, arg_57_1.hightColor2.b, var_60_24)

								iter_60_6.color = Color.New(var_60_25, var_60_26, var_60_27)
							else
								local var_60_28 = Mathf.Lerp(iter_60_6.color.r, 0.5, var_60_24)

								iter_60_6.color = Color.New(var_60_28, var_60_28, var_60_28)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_22 + var_60_23 and arg_57_1.time_ < var_60_22 + var_60_23 + arg_60_0 and not isNil(var_60_21) and arg_57_1.var_.actorSpriteComps1019 then
				for iter_60_7, iter_60_8 in pairs(arg_57_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_60_8 then
						if arg_57_1.isInRecall_ then
							iter_60_8.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1019 = nil
			end

			local var_60_29 = arg_57_1.actors_["1038"].transform
			local var_60_30 = 0

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.var_.moveOldPos1038 = var_60_29.localPosition
				var_60_29.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1038", 7)

				local var_60_31 = var_60_29.childCount

				for iter_60_9 = 0, var_60_31 - 1 do
					local var_60_32 = var_60_29:GetChild(iter_60_9)

					if var_60_32.name == "split_1" or not string.find(var_60_32.name, "split") then
						var_60_32.gameObject:SetActive(true)
					else
						var_60_32.gameObject:SetActive(false)
					end
				end
			end

			local var_60_33 = 0.001

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_33 then
				local var_60_34 = (arg_57_1.time_ - var_60_30) / var_60_33
				local var_60_35 = Vector3.New(0, -2000, 0)

				var_60_29.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1038, var_60_35, var_60_34)
			end

			if arg_57_1.time_ >= var_60_30 + var_60_33 and arg_57_1.time_ < var_60_30 + var_60_33 + arg_60_0 then
				var_60_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_36 = 0
			local var_60_37 = 0.4

			if var_60_36 < arg_57_1.time_ and arg_57_1.time_ <= var_60_36 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_38 = arg_57_1:FormatText(StoryNameCfg[236].name)

				arg_57_1.leftNameTxt_.text = var_60_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_39 = arg_57_1:GetWordFromCfg(900000014)
				local var_60_40 = arg_57_1:FormatText(var_60_39.content)

				arg_57_1.text_.text = var_60_40

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_41 = 16
				local var_60_42 = utf8.len(var_60_40)
				local var_60_43 = var_60_41 <= 0 and var_60_37 or var_60_37 * (var_60_42 / var_60_41)

				if var_60_43 > 0 and var_60_37 < var_60_43 then
					arg_57_1.talkMaxDuration = var_60_43

					if var_60_43 + var_60_36 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_43 + var_60_36
					end
				end

				arg_57_1.text_.text = var_60_40
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_44 = math.max(var_60_37, arg_57_1.talkMaxDuration)

			if var_60_36 <= arg_57_1.time_ and arg_57_1.time_ < var_60_36 + var_60_44 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_36) / var_60_44

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_36 + var_60_44 and arg_57_1.time_ < var_60_36 + var_60_44 + arg_60_0 then
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
			local var_64_0 = arg_61_1.actors_["1019"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1019 == nil then
				arg_61_1.var_.actorSpriteComps1019 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.1

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1019 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1019 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1019 = nil
			end

			local var_64_8 = arg_61_1.actors_["1033"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.1

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_16 = arg_61_1.actors_["1033"].transform
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033 = var_64_16.localPosition
				var_64_16.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1033", 7)

				local var_64_18 = var_64_16.childCount

				for iter_64_8 = 0, var_64_18 - 1 do
					local var_64_19 = var_64_16:GetChild(iter_64_8)

					if var_64_19.name == "split_4" or not string.find(var_64_19.name, "split") then
						var_64_19.gameObject:SetActive(true)
					else
						var_64_19.gameObject:SetActive(false)
					end
				end
			end

			local var_64_20 = 0.001

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_20 then
				local var_64_21 = (arg_61_1.time_ - var_64_17) / var_64_20
				local var_64_22 = Vector3.New(0, -2000, 0)

				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033, var_64_22, var_64_21)
			end

			if arg_61_1.time_ >= var_64_17 + var_64_20 and arg_61_1.time_ < var_64_17 + var_64_20 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_23 = arg_61_1.actors_["1033"].transform
			local var_64_24 = 0

			if var_64_24 < arg_61_1.time_ and arg_61_1.time_ <= var_64_24 + arg_64_0 then
				arg_61_1.var_.moveOldPos1033 = var_64_23.localPosition
				var_64_23.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1033", 2)

				local var_64_25 = var_64_23.childCount

				for iter_64_9 = 0, var_64_25 - 1 do
					local var_64_26 = var_64_23:GetChild(iter_64_9)

					if var_64_26.name == "split_5" or not string.find(var_64_26.name, "split") then
						var_64_26.gameObject:SetActive(true)
					else
						var_64_26.gameObject:SetActive(false)
					end
				end
			end

			local var_64_27 = 0.001

			if var_64_24 <= arg_61_1.time_ and arg_61_1.time_ < var_64_24 + var_64_27 then
				local var_64_28 = (arg_61_1.time_ - var_64_24) / var_64_27
				local var_64_29 = Vector3.New(-390, -420, 0)

				var_64_23.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1033, var_64_29, var_64_28)
			end

			if arg_61_1.time_ >= var_64_24 + var_64_27 and arg_61_1.time_ < var_64_24 + var_64_27 + arg_64_0 then
				var_64_23.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_64_30 = 0
			local var_64_31 = 0.85

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[13].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(900000015)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 34
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_38 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_38 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_38

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_38 and arg_61_1.time_ < var_64_30 + var_64_38 + arg_64_0 then
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
			local var_68_0 = arg_65_1.actors_["1019"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1019 == nil then
				arg_65_1.var_.actorSpriteComps1019 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.1

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1019 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1019 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1019 = nil
			end

			local var_68_8 = arg_65_1.actors_["1033"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1033 == nil then
				arg_65_1.var_.actorSpriteComps1033 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.1

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps1033 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 1, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1033 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1033 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.6

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[236].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(900000016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 24
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_24 and arg_65_1.time_ < var_68_16 + var_68_24 + arg_68_0 then
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
			local var_72_0 = arg_69_1.actors_["1038"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1038 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1038", 3)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_1" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(0, -400, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1038, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_72_7 = arg_69_1.actors_["1038"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				local var_72_9 = var_72_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_9 then
					arg_69_1.var_.alphaOldValue1038 = var_72_9.alpha
					arg_69_1.var_.characterEffect1038 = var_72_9
				end

				arg_69_1.var_.alphaOldValue1038 = 0
			end

			local var_72_10 = 0.1

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_10 then
				local var_72_11 = (arg_69_1.time_ - var_72_8) / var_72_10
				local var_72_12 = Mathf.Lerp(arg_69_1.var_.alphaOldValue1038, 1, var_72_11)

				if arg_69_1.var_.characterEffect1038 then
					arg_69_1.var_.characterEffect1038.alpha = var_72_12
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_10 and arg_69_1.time_ < var_72_8 + var_72_10 + arg_72_0 and arg_69_1.var_.characterEffect1038 then
				arg_69_1.var_.characterEffect1038.alpha = 1
			end

			local var_72_13 = arg_69_1.actors_["1038"]
			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.actorSpriteComps1038 == nil then
				arg_69_1.var_.actorSpriteComps1038 = var_72_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_15 = 0.1

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 and not isNil(var_72_13) then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15

				if arg_69_1.var_.actorSpriteComps1038 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_17 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_16)
								local var_72_18 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_16)
								local var_72_19 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_16)

								iter_72_2.color = Color.New(var_72_17, var_72_18, var_72_19)
							else
								local var_72_20 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_16)

								iter_72_2.color = Color.New(var_72_20, var_72_20, var_72_20)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.actorSpriteComps1038 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1038 = nil
			end

			local var_72_21 = arg_69_1.actors_["1033"].transform
			local var_72_22 = 0

			if var_72_22 < arg_69_1.time_ and arg_69_1.time_ <= var_72_22 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_21.localPosition
				var_72_21.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 7)

				local var_72_23 = var_72_21.childCount

				for iter_72_5 = 0, var_72_23 - 1 do
					local var_72_24 = var_72_21:GetChild(iter_72_5)

					if var_72_24.name == "split_5" or not string.find(var_72_24.name, "split") then
						var_72_24.gameObject:SetActive(true)
					else
						var_72_24.gameObject:SetActive(false)
					end
				end
			end

			local var_72_25 = 0.001

			if var_72_22 <= arg_69_1.time_ and arg_69_1.time_ < var_72_22 + var_72_25 then
				local var_72_26 = (arg_69_1.time_ - var_72_22) / var_72_25
				local var_72_27 = Vector3.New(0, -2000, 0)

				var_72_21.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, var_72_27, var_72_26)
			end

			if arg_69_1.time_ >= var_72_22 + var_72_25 and arg_69_1.time_ < var_72_22 + var_72_25 + arg_72_0 then
				var_72_21.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_28 = arg_69_1.actors_["1019"].transform
			local var_72_29 = 0

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				arg_69_1.var_.moveOldPos1019 = var_72_28.localPosition
				var_72_28.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1019", 7)

				local var_72_30 = var_72_28.childCount

				for iter_72_6 = 0, var_72_30 - 1 do
					local var_72_31 = var_72_28:GetChild(iter_72_6)

					if var_72_31.name == "split_1" or not string.find(var_72_31.name, "split") then
						var_72_31.gameObject:SetActive(true)
					else
						var_72_31.gameObject:SetActive(false)
					end
				end
			end

			local var_72_32 = 0.001

			if var_72_29 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_32 then
				local var_72_33 = (arg_69_1.time_ - var_72_29) / var_72_32
				local var_72_34 = Vector3.New(0, -2000, 200)

				var_72_28.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1019, var_72_34, var_72_33)
			end

			if arg_69_1.time_ >= var_72_29 + var_72_32 and arg_69_1.time_ < var_72_29 + var_72_32 + arg_72_0 then
				var_72_28.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_72_35 = 0
			local var_72_36 = 0.4

			if var_72_35 < arg_69_1.time_ and arg_69_1.time_ <= var_72_35 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_37 = arg_69_1:FormatText(StoryNameCfg[94].name)

				arg_69_1.leftNameTxt_.text = var_72_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_38 = arg_69_1:GetWordFromCfg(900000017)
				local var_72_39 = arg_69_1:FormatText(var_72_38.content)

				arg_69_1.text_.text = var_72_39

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_40 = 16
				local var_72_41 = utf8.len(var_72_39)
				local var_72_42 = var_72_40 <= 0 and var_72_36 or var_72_36 * (var_72_41 / var_72_40)

				if var_72_42 > 0 and var_72_36 < var_72_42 then
					arg_69_1.talkMaxDuration = var_72_42

					if var_72_42 + var_72_35 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_42 + var_72_35
					end
				end

				arg_69_1.text_.text = var_72_39
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_43 = math.max(var_72_36, arg_69_1.talkMaxDuration)

			if var_72_35 <= arg_69_1.time_ and arg_69_1.time_ < var_72_35 + var_72_43 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_35) / var_72_43

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_35 + var_72_43 and arg_69_1.time_ < var_72_35 + var_72_43 + arg_72_0 then
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
			local var_76_0 = arg_73_1.actors_["1038"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1038 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1038", 7)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(0, -2000, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1038, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_7 = arg_73_1.actors_["1019"].transform
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.var_.moveOldPos1019 = var_76_7.localPosition
				var_76_7.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1019", 3)

				local var_76_9 = var_76_7.childCount

				for iter_76_1 = 0, var_76_9 - 1 do
					local var_76_10 = var_76_7:GetChild(iter_76_1)

					if var_76_10.name == "split_1" or not string.find(var_76_10.name, "split") then
						var_76_10.gameObject:SetActive(true)
					else
						var_76_10.gameObject:SetActive(false)
					end
				end
			end

			local var_76_11 = 0.001

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_8) / var_76_11
				local var_76_13 = Vector3.New(-210, -340, 200)

				var_76_7.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1019, var_76_13, var_76_12)
			end

			if arg_73_1.time_ >= var_76_8 + var_76_11 and arg_73_1.time_ < var_76_8 + var_76_11 + arg_76_0 then
				var_76_7.localPosition = Vector3.New(-210, -340, 200)
			end

			local var_76_14 = arg_73_1.actors_["1019"]
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps1019 == nil then
				arg_73_1.var_.actorSpriteComps1019 = var_76_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_16 = 0.1

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_16 and not isNil(var_76_14) then
				local var_76_17 = (arg_73_1.time_ - var_76_15) / var_76_16

				if arg_73_1.var_.actorSpriteComps1019 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								local var_76_18 = Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor1.r, var_76_17)
								local var_76_19 = Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor1.g, var_76_17)
								local var_76_20 = Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor1.b, var_76_17)

								iter_76_3.color = Color.New(var_76_18, var_76_19, var_76_20)
							else
								local var_76_21 = Mathf.Lerp(iter_76_3.color.r, 1, var_76_17)

								iter_76_3.color = Color.New(var_76_21, var_76_21, var_76_21)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_15 + var_76_16 and arg_73_1.time_ < var_76_15 + var_76_16 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps1019 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_76_5 then
						if arg_73_1.isInRecall_ then
							iter_76_5.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1019 = nil
			end

			local var_76_22 = arg_73_1.actors_["1019"]
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				local var_76_24 = var_76_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_24 then
					arg_73_1.var_.alphaOldValue1019 = var_76_24.alpha
					arg_73_1.var_.characterEffect1019 = var_76_24
				end

				arg_73_1.var_.alphaOldValue1019 = 0
			end

			local var_76_25 = 0.1

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_25 then
				local var_76_26 = (arg_73_1.time_ - var_76_23) / var_76_25
				local var_76_27 = Mathf.Lerp(arg_73_1.var_.alphaOldValue1019, 1, var_76_26)

				if arg_73_1.var_.characterEffect1019 then
					arg_73_1.var_.characterEffect1019.alpha = var_76_27
				end
			end

			if arg_73_1.time_ >= var_76_23 + var_76_25 and arg_73_1.time_ < var_76_23 + var_76_25 + arg_76_0 and arg_73_1.var_.characterEffect1019 then
				arg_73_1.var_.characterEffect1019.alpha = 1
			end

			local var_76_28 = 0
			local var_76_29 = 0.2

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_30 = arg_73_1:FormatText(StoryNameCfg[13].name)

				arg_73_1.leftNameTxt_.text = var_76_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_31 = arg_73_1:GetWordFromCfg(900000018)
				local var_76_32 = arg_73_1:FormatText(var_76_31.content)

				arg_73_1.text_.text = var_76_32

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_33 = 8
				local var_76_34 = utf8.len(var_76_32)
				local var_76_35 = var_76_33 <= 0 and var_76_29 or var_76_29 * (var_76_34 / var_76_33)

				if var_76_35 > 0 and var_76_29 < var_76_35 then
					arg_73_1.talkMaxDuration = var_76_35

					if var_76_35 + var_76_28 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_35 + var_76_28
					end
				end

				arg_73_1.text_.text = var_76_32
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_36 = math.max(var_76_29, arg_73_1.talkMaxDuration)

			if var_76_28 <= arg_73_1.time_ and arg_73_1.time_ < var_76_28 + var_76_36 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_28) / var_76_36

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_28 + var_76_36 and arg_73_1.time_ < var_76_28 + var_76_36 + arg_76_0 then
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
			local var_80_0 = arg_77_1.actors_["1033"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 3)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_4" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(0, -420, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -420, 0)
			end

			local var_80_7 = arg_77_1.actors_["1019"].transform
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.var_.moveOldPos1019 = var_80_7.localPosition
				var_80_7.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1019", 7)

				local var_80_9 = var_80_7.childCount

				for iter_80_1 = 0, var_80_9 - 1 do
					local var_80_10 = var_80_7:GetChild(iter_80_1)

					if var_80_10.name == "split_1" or not string.find(var_80_10.name, "split") then
						var_80_10.gameObject:SetActive(true)
					else
						var_80_10.gameObject:SetActive(false)
					end
				end
			end

			local var_80_11 = 0.001

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_8) / var_80_11
				local var_80_13 = Vector3.New(0, -2000, 200)

				var_80_7.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1019, var_80_13, var_80_12)
			end

			if arg_77_1.time_ >= var_80_8 + var_80_11 and arg_77_1.time_ < var_80_8 + var_80_11 + arg_80_0 then
				var_80_7.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_80_14 = arg_77_1.actors_["1033"]
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.actorSpriteComps1033 == nil then
				arg_77_1.var_.actorSpriteComps1033 = var_80_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_16 = 0.1

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.actorSpriteComps1033 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								local var_80_18 = Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, var_80_17)
								local var_80_19 = Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, var_80_17)
								local var_80_20 = Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, var_80_17)

								iter_80_3.color = Color.New(var_80_18, var_80_19, var_80_20)
							else
								local var_80_21 = Mathf.Lerp(iter_80_3.color.r, 1, var_80_17)

								iter_80_3.color = Color.New(var_80_21, var_80_21, var_80_21)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.actorSpriteComps1033 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_80_5 then
						if arg_77_1.isInRecall_ then
							iter_80_5.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1033 = nil
			end

			local var_80_22 = arg_77_1.actors_["1033"]
			local var_80_23 = 0

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				local var_80_24 = var_80_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_24 then
					arg_77_1.var_.alphaOldValue1033 = var_80_24.alpha
					arg_77_1.var_.characterEffect1033 = var_80_24
				end

				arg_77_1.var_.alphaOldValue1033 = 0
			end

			local var_80_25 = 0.1

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_25 then
				local var_80_26 = (arg_77_1.time_ - var_80_23) / var_80_25
				local var_80_27 = Mathf.Lerp(arg_77_1.var_.alphaOldValue1033, 1, var_80_26)

				if arg_77_1.var_.characterEffect1033 then
					arg_77_1.var_.characterEffect1033.alpha = var_80_27
				end
			end

			if arg_77_1.time_ >= var_80_23 + var_80_25 and arg_77_1.time_ < var_80_23 + var_80_25 + arg_80_0 and arg_77_1.var_.characterEffect1033 then
				arg_77_1.var_.characterEffect1033.alpha = 1
			end

			local var_80_28 = 0
			local var_80_29 = 0.05

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_30 = arg_77_1:FormatText(StoryNameCfg[236].name)

				arg_77_1.leftNameTxt_.text = var_80_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_31 = arg_77_1:GetWordFromCfg(900000019)
				local var_80_32 = arg_77_1:FormatText(var_80_31.content)

				arg_77_1.text_.text = var_80_32

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_33 = 2
				local var_80_34 = utf8.len(var_80_32)
				local var_80_35 = var_80_33 <= 0 and var_80_29 or var_80_29 * (var_80_34 / var_80_33)

				if var_80_35 > 0 and var_80_29 < var_80_35 then
					arg_77_1.talkMaxDuration = var_80_35

					if var_80_35 + var_80_28 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_35 + var_80_28
					end
				end

				arg_77_1.text_.text = var_80_32
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_36 = math.max(var_80_29, arg_77_1.talkMaxDuration)

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_36 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_28) / var_80_36

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_28 + var_80_36 and arg_77_1.time_ < var_80_28 + var_80_36 + arg_80_0 then
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
