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
			local var_4_0 = "A02a"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = arg_1_1.bgs_.A02a
			local var_4_3 = 0

			if var_4_3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				local var_4_4 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueA02a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueA02a = var_4_4
				end

				arg_1_1.var_.alphaOldValueA02a = 0
			end

			local var_4_5 = 0.034

			if var_4_3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_3 + var_4_5 then
				local var_4_6 = (arg_1_1.time_ - var_4_3) / var_4_5
				local var_4_7 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA02a, 1, var_4_6)

				if arg_1_1.var_.alphaMatValueA02a then
					local var_4_8 = arg_1_1.var_.alphaMatValueA02a.color

					var_4_8.a = var_4_7
					arg_1_1.var_.alphaMatValueA02a.color = var_4_8
				end
			end

			if arg_1_1.time_ >= var_4_3 + var_4_5 and arg_1_1.time_ < var_4_3 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueA02a then
				local var_4_9 = arg_1_1.var_.alphaMatValueA02a
				local var_4_10 = var_4_9.color

				var_4_10.a = 1
				var_4_9.color = var_4_10
			end

			local var_4_11 = arg_1_1.bgs_.A02a.transform
			local var_4_12 = 0.0333333333333333

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.var_.moveOldPosA02a = var_4_11.localPosition
			end

			local var_4_13 = 0.001

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13
				local var_4_15 = Vector3.New(0, 0, 0)

				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosA02a, var_4_15, var_4_14)
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 0, 0)
			end

			local var_4_16 = "A03"

			if arg_1_1.bgs_[var_4_16] == nil then
				local var_4_17 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_16)
				var_4_17.name = var_4_16
				var_4_17.transform.parent = arg_1_1.stage_.transform
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_16] = var_4_17
			end

			local var_4_18 = arg_1_1.bgs_.A03
			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				local var_4_20 = var_4_18:GetComponent("SpriteRenderer")

				if var_4_20 then
					arg_1_1.var_.alphaOldValueA03 = var_4_20.color.a
					arg_1_1.var_.alphaMatValueA03 = var_4_20
				end

				arg_1_1.var_.alphaOldValueA03 = 1
			end

			local var_4_21 = 0.034

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_21 then
				local var_4_22 = (arg_1_1.time_ - var_4_19) / var_4_21
				local var_4_23 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA03, 0, var_4_22)

				if arg_1_1.var_.alphaMatValueA03 then
					local var_4_24 = arg_1_1.var_.alphaMatValueA03.color

					var_4_24.a = var_4_23
					arg_1_1.var_.alphaMatValueA03.color = var_4_24
				end
			end

			if arg_1_1.time_ >= var_4_19 + var_4_21 and arg_1_1.time_ < var_4_19 + var_4_21 + arg_4_0 and arg_1_1.var_.alphaMatValueA03 then
				local var_4_25 = arg_1_1.var_.alphaMatValueA03
				local var_4_26 = var_4_25.color

				var_4_26.a = 0
				var_4_25.color = var_4_26
			end

			local var_4_27 = arg_1_1.bgs_.A03.transform
			local var_4_28 = 0.0333333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPosA03 = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, 0, 0)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosA03, var_4_31, var_4_30)
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, 0, 0)
			end

			local var_4_32 = arg_1_1.bgs_.A02a
			local var_4_33 = 0.133333333333333

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = var_4_32:GetComponent("SpriteRenderer")

				if var_4_34 then
					arg_1_1.var_.alphaOldValueA02a = var_4_34.color.a
					arg_1_1.var_.alphaMatValueA02a = var_4_34
				end

				arg_1_1.var_.alphaOldValueA02a = 1
			end

			local var_4_35 = 1.86666666666667

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_33) / var_4_35
				local var_4_37 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA02a, 0, var_4_36)

				if arg_1_1.var_.alphaMatValueA02a then
					local var_4_38 = arg_1_1.var_.alphaMatValueA02a.color

					var_4_38.a = var_4_37
					arg_1_1.var_.alphaMatValueA02a.color = var_4_38
				end
			end

			if arg_1_1.time_ >= var_4_33 + var_4_35 and arg_1_1.time_ < var_4_33 + var_4_35 + arg_4_0 and arg_1_1.var_.alphaMatValueA02a then
				local var_4_39 = arg_1_1.var_.alphaMatValueA02a
				local var_4_40 = var_4_39.color

				var_4_40.a = 0
				var_4_39.color = var_4_40
			end

			local var_4_41 = arg_1_1.bgs_.A03
			local var_4_42 = 0.133333333333333

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponent("SpriteRenderer")

				if var_4_43 then
					arg_1_1.var_.alphaOldValueA03 = var_4_43.color.a
					arg_1_1.var_.alphaMatValueA03 = var_4_43
				end

				arg_1_1.var_.alphaOldValueA03 = 0
			end

			local var_4_44 = 1.86666666666667

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA03, 1, var_4_45)

				if arg_1_1.var_.alphaMatValueA03 then
					local var_4_47 = arg_1_1.var_.alphaMatValueA03.color

					var_4_47.a = var_4_46
					arg_1_1.var_.alphaMatValueA03.color = var_4_47
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.alphaMatValueA03 then
				local var_4_48 = arg_1_1.var_.alphaMatValueA03
				local var_4_49 = var_4_48.color

				var_4_49.a = 1
				var_4_48.color = var_4_49
			end

			local var_4_50 = 0
			local var_4_51 = 2.13333333333333

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_52 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_52:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_53 = arg_1_1:GetWordFromCfg(100011001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 28
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_51 or var_4_51 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_51 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_50 = var_4_50 + 0.3

					if var_4_57 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_50
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") / 1000

					if var_4_58 + var_4_50 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_50
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_100011", "100011001", "story_v_out_100011.awb")

						arg_1_1:RecordAudio("100011001", var_4_59)
						arg_1_1:RecordAudio("100011001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_100011", "100011001", "story_v_out_100011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_100011", "100011001", "story_v_out_100011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_50 + 0.3
			local var_4_61 = math.max(var_4_51, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
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
			local var_10_0 = arg_7_1.story_ui_effectTrs_.transform
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				local var_10_2 = arg_7_1.var_.effecttest
				local var_10_3
				local var_10_4 = var_10_0

				if not var_10_2 then
					var_10_2 = Object.Instantiate(Asset.Load("Widget/System/Story/story_ui_flash"), var_10_4)
					var_10_2.name = "test"
					arg_7_1.var_.effecttest = var_10_2
				else
					var_10_2.transform:SetParent(var_10_4)
				end

				var_10_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_10_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_10_5 = arg_7_1.bgs_.A03
			local var_10_6 = 0

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				local var_10_7 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_7 then
					arg_7_1.var_.alphaOldValueA03 = var_10_7.color.a
					arg_7_1.var_.alphaMatValueA03 = var_10_7
				end

				arg_7_1.var_.alphaOldValueA03 = 1
			end

			local var_10_8 = 0.733333333333333

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_8 then
				local var_10_9 = (arg_7_1.time_ - var_10_6) / var_10_8
				local var_10_10 = Mathf.Lerp(arg_7_1.var_.alphaOldValueA03, 0, var_10_9)

				if arg_7_1.var_.alphaMatValueA03 then
					local var_10_11 = arg_7_1.var_.alphaMatValueA03.color

					var_10_11.a = var_10_10
					arg_7_1.var_.alphaMatValueA03.color = var_10_11
				end
			end

			if arg_7_1.time_ >= var_10_6 + var_10_8 and arg_7_1.time_ < var_10_6 + var_10_8 + arg_10_0 and arg_7_1.var_.alphaMatValueA03 then
				local var_10_12 = arg_7_1.var_.alphaMatValueA03
				local var_10_13 = var_10_12.color

				var_10_13.a = 0
				var_10_12.color = var_10_13
			end

			local var_10_14 = "ML0204"

			if arg_7_1.bgs_[var_10_14] == nil then
				local var_10_15 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_14)
				var_10_15.name = var_10_14
				var_10_15.transform.parent = arg_7_1.stage_.transform
				var_10_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_14] = var_10_15
			end

			local var_10_16 = arg_7_1.bgs_.ML0204.transform
			local var_10_17 = 0

			if var_10_17 < arg_7_1.time_ and arg_7_1.time_ <= var_10_17 + arg_10_0 then
				arg_7_1.var_.moveOldPosML0204 = var_10_16.localPosition
			end

			local var_10_18 = 0.733333333333333

			if var_10_17 <= arg_7_1.time_ and arg_7_1.time_ < var_10_17 + var_10_18 then
				local var_10_19 = (arg_7_1.time_ - var_10_17) / var_10_18
				local var_10_20 = Vector3.New(0, 0, 0)

				var_10_16.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPosML0204, var_10_20, var_10_19)
			end

			if arg_7_1.time_ >= var_10_17 + var_10_18 and arg_7_1.time_ < var_10_17 + var_10_18 + arg_10_0 then
				var_10_16.localPosition = Vector3.New(0, 0, 0)
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
			local var_14_0 = 0
			local var_14_1 = 5

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "1"

				if not arg_11_1.actionList["1"] then
					arg_11_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_11_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				else
					arg_11_1.actionList["1"] = StoryInteractionRogueCardForumGame.NewWithGameObject(arg_11_1, arg_11_1.actionList["1"].gameObject_)
				end

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

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
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

				local var_18_5 = 8
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7
					var_18_0 = var_18_0 + 0.3

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_100012", "100012001", "story_v_out_100012.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_100012", "100012001", "story_v_out_100012.awb")

						arg_15_1:RecordAudio("100012001", var_18_9)
						arg_15_1:RecordAudio("100012001", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_100012", "100012001", "story_v_out_100012.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_100012", "100012001", "story_v_out_100012.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = var_18_0 + 0.3
			local var_18_11 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_10) / var_18_11

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 then
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
			local var_24_0 = 0
			local var_24_1 = 5

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "2"

				arg_21_1.marker = "111"

				if not arg_21_1.actionList["2"] then
					arg_21_1.actionList["2"] = StoryInteractionRogueCardForumGame.New(arg_21_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				else
					arg_21_1.actionList["2"] = StoryInteractionRogueCardForumGame.NewWithGameObject(arg_21_1, arg_21_1.actionList["2"].gameObject_)
				end

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

			local var_24_3 = 0
			local var_24_4 = 1

			if var_24_3 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_5 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_5:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(100012007)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 11
				local var_24_9 = utf8.len(var_24_7)
				local var_24_10 = var_24_8 <= 0 and var_24_4 or var_24_4 * (var_24_9 / var_24_8)

				if var_24_10 > 0 and var_24_4 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10
					var_24_3 = var_24_3 + 0.3

					if var_24_10 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_100012", "100012007", "story_v_out_100012.awb") / 1000

					if var_24_11 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_3
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_100012", "100012007", "story_v_out_100012.awb")

						arg_21_1:RecordAudio("100012007", var_24_12)
						arg_21_1:RecordAudio("100012007", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_100012", "100012007", "story_v_out_100012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_100012", "100012007", "story_v_out_100012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = var_24_3 + 0.3
			local var_24_14 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_13) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_13 + var_24_14 and arg_21_1.time_ < var_24_13 + var_24_14 + arg_24_0 then
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

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
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

				local var_30_5 = 22
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7
					var_30_0 = var_30_0 + 0.3

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_100012", "100012002", "story_v_out_100012.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_100012", "100012002", "story_v_out_100012.awb")

						arg_27_1:RecordAudio("100012002", var_30_9)
						arg_27_1:RecordAudio("100012002", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_100012", "100012002", "story_v_out_100012.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_100012", "100012002", "story_v_out_100012.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = var_30_0 + 0.3
			local var_30_11 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 then
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
			local var_36_0 = 0
			local var_36_1 = 1

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(101)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 4
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
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
	},
	skipMarkers = {
		104
	}
}
