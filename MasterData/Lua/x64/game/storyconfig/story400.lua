return {
	Play100 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100
		arg_1_1.duration_ = 9.3

		local var_1_0 = {
			ja = 9.3,
			ko = 5.533,
			zh = 5.3,
			en = 6.233
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
				arg_1_0:Play101(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A02a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A02a")
				var_4_0.name = "A02a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A02a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A02a:GetComponent("SpriteRenderer")

				if var_4_1 then
					arg_1_1.var_.alphaOldValueA02a = var_4_1.color.a
					arg_1_1.var_.alphaMatValueA02a = var_4_1
				end

				arg_1_1.var_.alphaOldValueA02a = 0
			end

			local var_4_2 = 0.034

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_2 then
				if arg_1_1.var_.alphaMatValueA02a then
					arg_1_1.var_.alphaMatValueA02a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA02a, 1, (arg_1_1.time_ - 0) / var_4_2)
					arg_1_1.var_.alphaMatValueA02a.color = arg_1_1.var_.alphaMatValueA02a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_2 and arg_1_1.time_ < 0 + var_4_2 + arg_4_0 and arg_1_1.var_.alphaMatValueA02a then
				arg_1_1.var_.alphaMatValueA02a.color.a = 1
				arg_1_1.var_.alphaMatValueA02a.color = arg_1_1.var_.alphaMatValueA02a.color
			end

			local var_4_3 = arg_1_1.bgs_.A02a.transform

			if 0.0333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.0333333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPosA02a = var_4_3.localPosition
			end

			local var_4_4 = 0.001

			if 0.0333333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.0333333333333333 + var_4_4 then
				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosA02a, Vector3.New(0, 0, 0), (arg_1_1.time_ - 0.0333333333333333) / var_4_4)
			end

			if arg_1_1.time_ >= 0.0333333333333333 + var_4_4 and arg_1_1.time_ < 0.0333333333333333 + var_4_4 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(0, 0, 0)
			end

			local var_4_5 = "A03"

			if arg_1_1.bgs_.A03 == nil then
				local var_4_6 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_5)
				var_4_6.name = var_4_5
				var_4_6.transform.parent = arg_1_1.stage_.transform
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_5] = var_4_6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_7 = arg_1_1.bgs_.A03:GetComponent("SpriteRenderer")

				if var_4_7 then
					arg_1_1.var_.alphaOldValueA03 = var_4_7.color.a
					arg_1_1.var_.alphaMatValueA03 = var_4_7
				end

				arg_1_1.var_.alphaOldValueA03 = 1
			end

			local var_4_8 = 0.034

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_8 then
				if arg_1_1.var_.alphaMatValueA03 then
					arg_1_1.var_.alphaMatValueA03.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA03, 0, (arg_1_1.time_ - 0) / var_4_8)
					arg_1_1.var_.alphaMatValueA03.color = arg_1_1.var_.alphaMatValueA03.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_8 and arg_1_1.time_ < 0 + var_4_8 + arg_4_0 and arg_1_1.var_.alphaMatValueA03 then
				arg_1_1.var_.alphaMatValueA03.color.a = 0
				arg_1_1.var_.alphaMatValueA03.color = arg_1_1.var_.alphaMatValueA03.color
			end

			local var_4_9 = arg_1_1.bgs_.A03.transform

			if 0.0333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.0333333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPosA03 = var_4_9.localPosition
			end

			local var_4_10 = 0.001

			if 0.0333333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.0333333333333333 + var_4_10 then
				var_4_9.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosA03, Vector3.New(0, 0, 0), (arg_1_1.time_ - 0.0333333333333333) / var_4_10)
			end

			if arg_1_1.time_ >= 0.0333333333333333 + var_4_10 and arg_1_1.time_ < 0.0333333333333333 + var_4_10 + arg_4_0 then
				var_4_9.localPosition = Vector3.New(0, 0, 0)
			end

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.A02a:GetComponent("SpriteRenderer")

				if var_4_11 then
					arg_1_1.var_.alphaOldValueA02a = var_4_11.color.a
					arg_1_1.var_.alphaMatValueA02a = var_4_11
				end

				arg_1_1.var_.alphaOldValueA02a = 1
			end

			local var_4_12 = 1.86666666666667

			if 0.133333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.133333333333333 + var_4_12 then
				if arg_1_1.var_.alphaMatValueA02a then
					arg_1_1.var_.alphaMatValueA02a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA02a, 0, (arg_1_1.time_ - 0.133333333333333) / var_4_12)
					arg_1_1.var_.alphaMatValueA02a.color = arg_1_1.var_.alphaMatValueA02a.color
				end
			end

			if arg_1_1.time_ >= 0.133333333333333 + var_4_12 and arg_1_1.time_ < 0.133333333333333 + var_4_12 + arg_4_0 and arg_1_1.var_.alphaMatValueA02a then
				arg_1_1.var_.alphaMatValueA02a.color.a = 0
				arg_1_1.var_.alphaMatValueA02a.color = arg_1_1.var_.alphaMatValueA02a.color
			end

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.A03:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueA03 = var_4_13.color.a
					arg_1_1.var_.alphaMatValueA03 = var_4_13
				end

				arg_1_1.var_.alphaOldValueA03 = 0
			end

			local var_4_14 = 1.86666666666667

			if 0.133333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.133333333333333 + var_4_14 then
				if arg_1_1.var_.alphaMatValueA03 then
					arg_1_1.var_.alphaMatValueA03.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA03, 1, (arg_1_1.time_ - 0.133333333333333) / var_4_14)
					arg_1_1.var_.alphaMatValueA03.color = arg_1_1.var_.alphaMatValueA03.color
				end
			end

			if arg_1_1.time_ >= 0.133333333333333 + var_4_14 and arg_1_1.time_ < 0.133333333333333 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueA03 then
				arg_1_1.var_.alphaMatValueA03.color.a = 1
				arg_1_1.var_.alphaMatValueA03.color = arg_1_1.var_.alphaMatValueA03.color
			end

			local var_4_15 = 0
			local var_4_16 = 2.13333333333333

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:GetWordFromCfg(100011001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 28 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 28)

				if (28 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 28)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_100011", "100011001", "story_v_out_100011.awb")

						arg_1_1:RecordAudio("100011001", var_4_23)
						arg_1_1:RecordAudio("100011001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_100011", "100011001", "story_v_out_100011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_100011", "100011001", "story_v_out_100011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A02a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "A03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 101
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play102(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_0 = arg_7_1.var_.effecttest

				if not arg_7_1.var_.effecttest then
					var_10_0 = Object.Instantiate(Asset.Load("Widget/System/Story/story_ui_flash"), arg_7_1.story_ui_effectTrs_.transform)
					var_10_0.name = "test"
					arg_7_1.var_.effecttest = var_10_0
				else
					var_10_0.transform:SetParent(arg_7_1.story_ui_effectTrs_.transform)
				end

				var_10_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_10_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_2 = arg_7_1.bgs_.A03:GetComponent("SpriteRenderer")

				if var_10_2 then
					arg_7_1.var_.alphaOldValueA03 = var_10_2.color.a
					arg_7_1.var_.alphaMatValueA03 = var_10_2
				end

				arg_7_1.var_.alphaOldValueA03 = 1
			end

			local var_10_3 = 0.733333333333333

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 then
				if arg_7_1.var_.alphaMatValueA03 then
					arg_7_1.var_.alphaMatValueA03.color.a = Mathf.Lerp(arg_7_1.var_.alphaOldValueA03, 0, (arg_7_1.time_ - 0) / var_10_3)
					arg_7_1.var_.alphaMatValueA03.color = arg_7_1.var_.alphaMatValueA03.color
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 and arg_7_1.var_.alphaMatValueA03 then
				arg_7_1.var_.alphaMatValueA03.color.a = 0
				arg_7_1.var_.alphaMatValueA03.color = arg_7_1.var_.alphaMatValueA03.color
			end

			local var_10_4 = "ML0204"

			if arg_7_1.bgs_.ML0204 == nil then
				local var_10_5 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_4)
				var_10_5.name = var_10_4
				var_10_5.transform.parent = arg_7_1.stage_.transform
				var_10_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_4] = var_10_5
			end

			local var_10_6 = arg_7_1.bgs_.ML0204.transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPosML0204 = var_10_6.localPosition
			end

			local var_10_7 = 0.733333333333333

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_7 then
				var_10_6.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPosML0204, Vector3.New(0, 0, 0), (arg_7_1.time_ - 0) / var_10_7)
			end

			if arg_7_1.time_ >= 0 + var_10_7 and arg_7_1.time_ < 0 + var_10_7 + arg_10_0 then
				var_10_6.localPosition = Vector3.New(0, 0, 0)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.733333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play102 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 102
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play103(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.actionList["1"] = not arg_11_1.actionList["1"] and StoryInteractionRogueCardForumGame.New(arg_11_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI") or StoryInteractionRogueCardForumGame.NewWithGameObject(arg_11_1, arg_11_1.actionList["1"].gameObject_)

				arg_11_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 2,
					postId = 101,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "postBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play103 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 103
		arg_15_1.duration_ = 2.1

		local var_15_0 = {
			ja = 2.1,
			ko = 1.466,
			zh = 1.666,
			en = 2
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play104(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 1

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_2 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_2:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(100012001)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 8 <= 0 and var_18_1 or var_18_1 * (utf8.len(var_18_4) / 8)

				if (8 <= 0 and var_18_1 or var_18_1 * (utf8.len(var_18_4) / 8)) > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6
					var_18_0 = var_18_0 + 0.3

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") ~= 0 then
					local var_18_7 = manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") / 1000

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_100012", "100012001", "story_v_out_100012.awb")

						arg_15_1:RecordAudio("100012001", var_18_8)
						arg_15_1:RecordAudio("100012001", var_18_8)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_100012", "100012001", "story_v_out_100012.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_100012", "100012001", "story_v_out_100012.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_9 = var_18_0 + 0.3
			local var_18_10 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 + 0.3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_9 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_9) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_9 + var_18_10 and arg_15_1.time_ < var_18_9 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play104 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 104
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play105(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.actionList["2"] = not arg_21_1.actionList["2"] and StoryInteractionRogueCardForumGame.New(arg_21_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI") or StoryInteractionRogueCardForumGame.NewWithGameObject(arg_21_1, arg_21_1.actionList["2"].gameObject_)

				arg_21_1.actionList["2"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 101,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "bgBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end

			local var_24_2 = 0
			local var_24_3 = 1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_4 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_4:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:GetWordFromCfg(100012007)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 11 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_6) / 11)

				if (11 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_6) / 11)) > 0 and var_24_3 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8
					var_24_2 = var_24_2 + 0.3

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") / 1000

					if var_24_9 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_2
					end

					if var_24_5.prefab_name ~= "" and arg_21_1.actors_[var_24_5.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_5.prefab_name].transform, "story_v_out_100012", "100012007", "story_v_out_100012.awb")

						arg_21_1:RecordAudio("100012007", var_24_10)
						arg_21_1:RecordAudio("100012007", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_100012", "100012007", "story_v_out_100012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_100012", "100012007", "story_v_out_100012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = var_24_2 + 0.3
			local var_24_12 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_12 and arg_21_1.time_ < var_24_11 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play105 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 105
		arg_27_1.duration_ = 5.77

		local var_27_0 = {
			ja = 5.766,
			ko = 5.666,
			zh = 4.333,
			en = 5.433
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play106(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_2 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_2:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(100012002)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 22 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_4) / 22)

				if (22 <= 0 and var_30_1 or var_30_1 * (utf8.len(var_30_4) / 22)) > 0 and var_30_1 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6
					var_30_0 = var_30_0 + 0.3

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") ~= 0 then
					local var_30_7 = manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") / 1000

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_100012", "100012002", "story_v_out_100012.awb")

						arg_27_1:RecordAudio("100012002", var_30_8)
						arg_27_1:RecordAudio("100012002", var_30_8)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_100012", "100012002", "story_v_out_100012.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_100012", "100012002", "story_v_out_100012.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_9 = var_30_0 + 0.3
			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_9) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_9 + var_30_10 and arg_27_1.time_ < var_30_9 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play106 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 106
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play107(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(101).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 4 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 4)

				if (4 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 4)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play107 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 107
		arg_37_1.duration_ = 1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play108(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			return
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play108 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 108
		arg_41_1.duration_ = 1

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play109(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			return
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play109 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 109
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play110(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			return
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play110 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 110
		arg_49_1.duration_ = 1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play111(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			return
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play111 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 111
		arg_53_1.duration_ = 1

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play112(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			return
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play112 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 112
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
			arg_57_1.auto_ = false
		end

		function arg_57_1.playNext_(arg_59_0)
			arg_57_1.onStoryFinished_()
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			return
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_100011.awb",
		"story_v_out_100012.awb"
	}
}
