return {
	Play939021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 2
			local var_4_25 = 5

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "1"

				arg_1_1.marker = "luntantiezi3"

				if not arg_1_1.actionList["1"] then
					arg_1_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 102,
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

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939021002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939021002
		arg_6_1.duration_ = 7

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939021003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "ST15a"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.ST15a

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST15a" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 2

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_17 = 0.3

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_19 = 2

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				local var_9_20 = (arg_6_1.time_ - var_9_18) / var_9_19
				local var_9_21 = Color.New(0, 0, 0)

				var_9_21.a = Mathf.Lerp(1, 0, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)
				local var_9_23 = 0

				arg_6_1.mask_.enabled = false
				var_9_22.a = var_9_23
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_24 = "1284ui_story"

			if arg_6_1.actors_[var_9_24] == nil then
				local var_9_25 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_9_25) then
					local var_9_26 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_6_1.stage_.transform)

					var_9_26.name = var_9_24
					var_9_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_6_1.actors_[var_9_24] = var_9_26

					local var_9_27 = var_9_26:GetComponentInChildren(typeof(CharacterEffect))

					var_9_27.enabled = true

					local var_9_28 = GameObjectTools.GetOrAddComponent(var_9_26, typeof(DynamicBoneHelper))

					if var_9_28 then
						var_9_28:EnableDynamicBone(false)
					end

					arg_6_1:ShowWeapon(var_9_27.transform, false)

					arg_6_1.var_[var_9_24 .. "Animator"] = var_9_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_6_1.var_[var_9_24 .. "Animator"].applyRootMotion = true
					arg_6_1.var_[var_9_24 .. "LipSync"] = var_9_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_9_29 = arg_6_1.actors_["1284ui_story"].transform
			local var_9_30 = 1.83333333333333

			if var_9_30 < arg_6_1.time_ and arg_6_1.time_ <= var_9_30 + arg_9_0 then
				arg_6_1.var_.moveOldPos1284ui_story = var_9_29.localPosition
			end

			local var_9_31 = 0.001

			if var_9_30 <= arg_6_1.time_ and arg_6_1.time_ < var_9_30 + var_9_31 then
				local var_9_32 = (arg_6_1.time_ - var_9_30) / var_9_31
				local var_9_33 = Vector3.New(0, -0.985, -6.22)

				var_9_29.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1284ui_story, var_9_33, var_9_32)

				local var_9_34 = manager.ui.mainCamera.transform.position - var_9_29.position

				var_9_29.forward = Vector3.New(var_9_34.x, var_9_34.y, var_9_34.z)

				local var_9_35 = var_9_29.localEulerAngles

				var_9_35.z = 0
				var_9_35.x = 0
				var_9_29.localEulerAngles = var_9_35
			end

			if arg_6_1.time_ >= var_9_30 + var_9_31 and arg_6_1.time_ < var_9_30 + var_9_31 + arg_9_0 then
				var_9_29.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_9_36 = manager.ui.mainCamera.transform.position - var_9_29.position

				var_9_29.forward = Vector3.New(var_9_36.x, var_9_36.y, var_9_36.z)

				local var_9_37 = var_9_29.localEulerAngles

				var_9_37.z = 0
				var_9_37.x = 0
				var_9_29.localEulerAngles = var_9_37
			end

			local var_9_38 = arg_6_1.actors_["1284ui_story"]
			local var_9_39 = 1.83333333333333

			if var_9_39 < arg_6_1.time_ and arg_6_1.time_ <= var_9_39 + arg_9_0 and not isNil(var_9_38) and arg_6_1.var_.characterEffect1284ui_story == nil then
				arg_6_1.var_.characterEffect1284ui_story = var_9_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_40 = 0.200000002980232

			if var_9_39 <= arg_6_1.time_ and arg_6_1.time_ < var_9_39 + var_9_40 and not isNil(var_9_38) then
				local var_9_41 = (arg_6_1.time_ - var_9_39) / var_9_40

				if arg_6_1.var_.characterEffect1284ui_story and not isNil(var_9_38) then
					arg_6_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= var_9_39 + var_9_40 and arg_6_1.time_ < var_9_39 + var_9_40 + arg_9_0 and not isNil(var_9_38) and arg_6_1.var_.characterEffect1284ui_story then
				arg_6_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_9_42 = 1.83333333333333

			if var_9_42 < arg_6_1.time_ and arg_6_1.time_ <= var_9_42 + arg_9_0 then
				arg_6_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_9_43 = 1.83333333333333

			if var_9_43 < arg_6_1.time_ and arg_6_1.time_ <= var_9_43 + arg_9_0 then
				arg_6_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_44 = 2
			local var_9_45 = 0.75

			if var_9_44 < arg_6_1.time_ and arg_6_1.time_ <= var_9_44 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_46 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_46:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_47 = arg_6_1:FormatText(StoryNameCfg[6].name)

				arg_6_1.leftNameTxt_.text = var_9_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_48 = arg_6_1:GetWordFromCfg(939021002)
				local var_9_49 = arg_6_1:FormatText(var_9_48.content)

				arg_6_1.text_.text = var_9_49

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_50 = 30
				local var_9_51 = utf8.len(var_9_49)
				local var_9_52 = var_9_50 <= 0 and var_9_45 or var_9_45 * (var_9_51 / var_9_50)

				if var_9_52 > 0 and var_9_45 < var_9_52 then
					arg_6_1.talkMaxDuration = var_9_52
					var_9_44 = var_9_44 + 0.3

					if var_9_52 + var_9_44 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_52 + var_9_44
					end
				end

				arg_6_1.text_.text = var_9_49
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_53 = var_9_44 + 0.3
			local var_9_54 = math.max(var_9_45, arg_6_1.talkMaxDuration)

			if var_9_53 <= arg_6_1.time_ and arg_6_1.time_ < var_9_53 + var_9_54 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_53) / var_9_54

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_53 + var_9_54 and arg_6_1.time_ < var_9_53 + var_9_54 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play939021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1284ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1284ui_story == nil then
				arg_12_1.var_.characterEffect1284ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1284ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1284ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1284ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1284ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 1.175

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(939021003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 47
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play939021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.45

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(939021004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 18
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play939021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1284ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1284ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1284ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = 0
			local var_23_10 = 1.55

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_11 = arg_20_1:GetWordFromCfg(939021005)
				local var_23_12 = arg_20_1:FormatText(var_23_11.content)

				arg_20_1.text_.text = var_23_12

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 62
				local var_23_14 = utf8.len(var_23_12)
				local var_23_15 = var_23_13 <= 0 and var_23_10 or var_23_10 * (var_23_14 / var_23_13)

				if var_23_15 > 0 and var_23_10 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_9 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_9
					end
				end

				arg_20_1.text_.text = var_23_12
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_10, arg_20_1.talkMaxDuration)

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_9) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_9 + var_23_16 and arg_20_1.time_ < var_23_9 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play939021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "1054ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["1054ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_5.localPosition

				local var_27_7 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_7 then
					var_27_7:EnableDynamicBone(false)
				end
			end

			local var_27_8 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_6) / var_27_8
				local var_27_10 = Vector3.New(0, -0.985, -6)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, var_27_10, var_27_9)

				local var_27_11 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_11.x, var_27_11.y, var_27_11.z)

				local var_27_12 = var_27_5.localEulerAngles

				var_27_12.z = 0
				var_27_12.x = 0
				var_27_5.localEulerAngles = var_27_12
			end

			if arg_24_1.time_ >= var_27_6 + var_27_8 and arg_24_1.time_ < var_27_6 + var_27_8 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_27_13 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_13.x, var_27_13.y, var_27_13.z)

				local var_27_14 = var_27_5.localEulerAngles

				var_27_14.z = 0
				var_27_14.x = 0
				var_27_5.localEulerAngles = var_27_14

				local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_15 then
					var_27_15:EnableDynamicBone(true)
				end
			end

			local var_27_16 = arg_24_1.actors_["1054ui_story"]
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_18 = 0.200000002980232

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 and not isNil(var_27_16) then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18

				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_16) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_27_22 = 0
			local var_27_23 = 0.275

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_24 = arg_24_1:FormatText(StoryNameCfg[1487].name)

				arg_24_1.leftNameTxt_.text = var_27_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_25 = arg_24_1:GetWordFromCfg(939021006)
				local var_27_26 = arg_24_1:FormatText(var_27_25.content)

				arg_24_1.text_.text = var_27_26

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 11
				local var_27_28 = utf8.len(var_27_26)
				local var_27_29 = var_27_27 <= 0 and var_27_23 or var_27_23 * (var_27_28 / var_27_27)

				if var_27_29 > 0 and var_27_23 < var_27_29 then
					arg_24_1.talkMaxDuration = var_27_29

					if var_27_29 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_26
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_30 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_30 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_22) / var_27_30

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_22 + var_27_30 and arg_24_1.time_ < var_27_22 + var_27_30 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play939021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1054ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1054ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1054ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.2

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(939021007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 8
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play939021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939021008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1284ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1284ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0.7, -0.985, -6.22)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1284ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["1054ui_story"].transform
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_9.localPosition

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_9.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(false)
				end
			end

			local var_35_12 = 0.001

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_10) / var_35_12
				local var_35_14 = Vector3.New(-0.7, -0.985, -6)

				var_35_9.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_9.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_9.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_10 + var_35_12 and arg_32_1.time_ < var_35_10 + var_35_12 + arg_35_0 then
				var_35_9.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_9.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_9.localEulerAngles = var_35_18

				local var_35_19 = GameObjectTools.GetOrAddComponent(var_35_9.gameObject, typeof(DynamicBoneHelper))

				if var_35_19 then
					var_35_19:EnableDynamicBone(true)
				end
			end

			local var_35_20 = arg_32_1.actors_["1284ui_story"]
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect1284ui_story == nil then
				arg_32_1.var_.characterEffect1284ui_story = var_35_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_22 = 0.200000002980232

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 and not isNil(var_35_20) then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22

				if arg_32_1.var_.characterEffect1284ui_story and not isNil(var_35_20) then
					arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect1284ui_story then
				arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_35_26 = 0
			local var_35_27 = 0.475

			if var_35_26 < arg_32_1.time_ and arg_32_1.time_ <= var_35_26 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_28 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_29 = arg_32_1:GetWordFromCfg(939021008)
				local var_35_30 = arg_32_1:FormatText(var_35_29.content)

				arg_32_1.text_.text = var_35_30

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_31 = 19
				local var_35_32 = utf8.len(var_35_30)
				local var_35_33 = var_35_31 <= 0 and var_35_27 or var_35_27 * (var_35_32 / var_35_31)

				if var_35_33 > 0 and var_35_27 < var_35_33 then
					arg_32_1.talkMaxDuration = var_35_33

					if var_35_33 + var_35_26 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_26
					end
				end

				arg_32_1.text_.text = var_35_30
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_34 = math.max(var_35_27, arg_32_1.talkMaxDuration)

			if var_35_26 <= arg_32_1.time_ and arg_32_1.time_ < var_35_26 + var_35_34 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_26) / var_35_34

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_26 + var_35_34 and arg_32_1.time_ < var_35_26 + var_35_34 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play939021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 939021009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play939021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1284ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1284ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1284ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1054ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_9.localPosition

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(false)
				end
			end

			local var_39_12 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_10) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_9.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_9.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_10 + var_39_12 and arg_36_1.time_ < var_39_10 + var_39_12 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_9.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_9.localEulerAngles = var_39_18

				local var_39_19 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_19 then
					var_39_19:EnableDynamicBone(true)
				end
			end

			local var_39_20 = arg_36_1.actors_["1284ui_story"]
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1284ui_story == nil then
				arg_36_1.var_.characterEffect1284ui_story = var_39_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_22 = 0.200000002980232

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_22 and not isNil(var_39_20) then
				local var_39_23 = (arg_36_1.time_ - var_39_21) / var_39_22

				if arg_36_1.var_.characterEffect1284ui_story and not isNil(var_39_20) then
					local var_39_24 = Mathf.Lerp(0, 0.5, var_39_23)

					arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1284ui_story.fillRatio = var_39_24
				end
			end

			if arg_36_1.time_ >= var_39_21 + var_39_22 and arg_36_1.time_ < var_39_21 + var_39_22 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1284ui_story then
				local var_39_25 = 0.5

				arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1284ui_story.fillRatio = var_39_25
			end

			local var_39_26 = 0
			local var_39_27 = 0.725

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_28 = arg_36_1:GetWordFromCfg(939021009)
				local var_39_29 = arg_36_1:FormatText(var_39_28.content)

				arg_36_1.text_.text = var_39_29

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_30 = 29
				local var_39_31 = utf8.len(var_39_29)
				local var_39_32 = var_39_30 <= 0 and var_39_27 or var_39_27 * (var_39_31 / var_39_30)

				if var_39_32 > 0 and var_39_27 < var_39_32 then
					arg_36_1.talkMaxDuration = var_39_32

					if var_39_32 + var_39_26 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_32 + var_39_26
					end
				end

				arg_36_1.text_.text = var_39_29
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_33 = math.max(var_39_27, arg_36_1.talkMaxDuration)

			if var_39_26 <= arg_36_1.time_ and arg_36_1.time_ < var_39_26 + var_39_33 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_26) / var_39_33

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_26 + var_39_33 and arg_36_1.time_ < var_39_26 + var_39_33 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play939021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 939021010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play939021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.725

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(939021010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 29
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play939021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 939021011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play939021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1284ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1284ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -0.985, -6.22)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1284ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1284ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1284ui_story == nil then
				arg_44_1.var_.characterEffect1284ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1284ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1284ui_story then
				arg_44_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_47_15 = 0
			local var_47_16 = 1.25

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(939021011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 50
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_23 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_23 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_23

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_23 and arg_44_1.time_ < var_47_15 + var_47_23 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play939021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 939021012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play939021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1284ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1284ui_story == nil then
				arg_48_1.var_.characterEffect1284ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1284ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1284ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1284ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1284ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.45

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_9 = arg_48_1:GetWordFromCfg(939021012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 18
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play939021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 939021013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play939021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1284ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1284ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1284ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = 0
			local var_55_10 = 0.875

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_11 = arg_52_1:GetWordFromCfg(939021013)
				local var_55_12 = arg_52_1:FormatText(var_55_11.content)

				arg_52_1.text_.text = var_55_12

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 35
				local var_55_14 = utf8.len(var_55_12)
				local var_55_15 = var_55_13 <= 0 and var_55_10 or var_55_10 * (var_55_14 / var_55_13)

				if var_55_15 > 0 and var_55_10 < var_55_15 then
					arg_52_1.talkMaxDuration = var_55_15

					if var_55_15 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_15 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_12
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_16 and arg_52_1.time_ < var_55_9 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play939021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 939021014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play939021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1054ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = var_59_0.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_3 then
				local var_59_4 = (arg_56_1.time_ - var_59_1) / var_59_3
				local var_59_5 = Vector3.New(0, -0.985, -6)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, var_59_5, var_59_4)

				local var_59_6 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_6.x, var_59_6.y, var_59_6.z)

				local var_59_7 = var_59_0.localEulerAngles

				var_59_7.z = 0
				var_59_7.x = 0
				var_59_0.localEulerAngles = var_59_7
			end

			if arg_56_1.time_ >= var_59_1 + var_59_3 and arg_56_1.time_ < var_59_1 + var_59_3 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_59_8 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_8.x, var_59_8.y, var_59_8.z)

				local var_59_9 = var_59_0.localEulerAngles

				var_59_9.z = 0
				var_59_9.x = 0
				var_59_0.localEulerAngles = var_59_9

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_0.gameObject, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(true)
				end
			end

			local var_59_11 = arg_56_1.actors_["1054ui_story"]
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = var_59_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_13 = 0.200000002980232

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 and not isNil(var_59_11) then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13

				if arg_56_1.var_.characterEffect1054ui_story and not isNil(var_59_11) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_59_15 = 0

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action456")
			end

			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_59_17 = 0
			local var_59_18 = 1.125

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_19 = arg_56_1:FormatText(StoryNameCfg[1487].name)

				arg_56_1.leftNameTxt_.text = var_59_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_20 = arg_56_1:GetWordFromCfg(939021014)
				local var_59_21 = arg_56_1:FormatText(var_59_20.content)

				arg_56_1.text_.text = var_59_21

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_22 = 45
				local var_59_23 = utf8.len(var_59_21)
				local var_59_24 = var_59_22 <= 0 and var_59_18 or var_59_18 * (var_59_23 / var_59_22)

				if var_59_24 > 0 and var_59_18 < var_59_24 then
					arg_56_1.talkMaxDuration = var_59_24

					if var_59_24 + var_59_17 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_24 + var_59_17
					end
				end

				arg_56_1.text_.text = var_59_21
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_18, arg_56_1.talkMaxDuration)

			if var_59_17 <= arg_56_1.time_ and arg_56_1.time_ < var_59_17 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_17) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_17 + var_59_25 and arg_56_1.time_ < var_59_17 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play939021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 939021015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play939021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.6

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:GetWordFromCfg(939021015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 24
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play939021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 939021016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play939021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1054ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = 0
			local var_67_12 = 0.6

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(939021016)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 24
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_12 or var_67_12 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_12 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_18 and arg_64_1.time_ < var_67_11 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play939021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 939021017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play939021018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1054ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1054ui_story = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(-0.7, -0.985, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1054ui_story, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["1054ui_story"]
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1054ui_story == nil then
				arg_68_1.var_.characterEffect1054ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_13 = 0.200000002980232

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_13 and not isNil(var_71_11) then
				local var_71_14 = (arg_68_1.time_ - var_71_12) / var_71_13

				if arg_68_1.var_.characterEffect1054ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_12 + var_71_13 and arg_68_1.time_ < var_71_12 + var_71_13 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1054ui_story then
				arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_71_15 = 0

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_71_17 = 0
			local var_71_18 = 0.575

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_19 = arg_68_1:FormatText(StoryNameCfg[1487].name)

				arg_68_1.leftNameTxt_.text = var_71_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_20 = arg_68_1:GetWordFromCfg(939021017)
				local var_71_21 = arg_68_1:FormatText(var_71_20.content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_22 = 23
				local var_71_23 = utf8.len(var_71_21)
				local var_71_24 = var_71_22 <= 0 and var_71_18 or var_71_18 * (var_71_23 / var_71_22)

				if var_71_24 > 0 and var_71_18 < var_71_24 then
					arg_68_1.talkMaxDuration = var_71_24

					if var_71_24 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_17
					end
				end

				arg_68_1.text_.text = var_71_21
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_18, arg_68_1.talkMaxDuration)

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_17) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_17 + var_71_25 and arg_68_1.time_ < var_71_17 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play939021018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 939021018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play939021019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1054ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1054ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.9

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_9 = arg_72_1:GetWordFromCfg(939021018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 36
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play939021019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939021019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939021020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "6148ui_story"

			if arg_76_1.actors_[var_79_0] == nil then
				local var_79_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_79_1) then
					local var_79_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_76_1.stage_.transform)

					var_79_2.name = var_79_0
					var_79_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_76_1.actors_[var_79_0] = var_79_2

					local var_79_3 = var_79_2:GetComponentInChildren(typeof(CharacterEffect))

					var_79_3.enabled = true

					local var_79_4 = GameObjectTools.GetOrAddComponent(var_79_2, typeof(DynamicBoneHelper))

					if var_79_4 then
						var_79_4:EnableDynamicBone(false)
					end

					arg_76_1:ShowWeapon(var_79_3.transform, false)

					arg_76_1.var_[var_79_0 .. "Animator"] = var_79_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_76_1.var_[var_79_0 .. "Animator"].applyRootMotion = true
					arg_76_1.var_[var_79_0 .. "LipSync"] = var_79_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_79_5 = arg_76_1.actors_["6148ui_story"].transform
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.var_.moveOldPos6148ui_story = var_79_5.localPosition

				local var_79_7 = GameObjectTools.GetOrAddComponent(var_79_5.gameObject, typeof(DynamicBoneHelper))

				if var_79_7 then
					var_79_7:EnableDynamicBone(false)
				end
			end

			local var_79_8 = 0.001

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_8 then
				local var_79_9 = (arg_76_1.time_ - var_79_6) / var_79_8
				local var_79_10 = Vector3.New(0.7, -0.985, -6)

				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos6148ui_story, var_79_10, var_79_9)

				local var_79_11 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_11.x, var_79_11.y, var_79_11.z)

				local var_79_12 = var_79_5.localEulerAngles

				var_79_12.z = 0
				var_79_12.x = 0
				var_79_5.localEulerAngles = var_79_12
			end

			if arg_76_1.time_ >= var_79_6 + var_79_8 and arg_76_1.time_ < var_79_6 + var_79_8 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_79_13 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_13.x, var_79_13.y, var_79_13.z)

				local var_79_14 = var_79_5.localEulerAngles

				var_79_14.z = 0
				var_79_14.x = 0
				var_79_5.localEulerAngles = var_79_14

				local var_79_15 = GameObjectTools.GetOrAddComponent(var_79_5.gameObject, typeof(DynamicBoneHelper))

				if var_79_15 then
					var_79_15:EnableDynamicBone(true)
				end
			end

			local var_79_16 = arg_76_1.actors_["6148ui_story"]
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 and not isNil(var_79_16) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_18 = 0.200000002980232

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_18 and not isNil(var_79_16) then
				local var_79_19 = (arg_76_1.time_ - var_79_17) / var_79_18

				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_16) then
					arg_76_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_17 + var_79_18 and arg_76_1.time_ < var_79_17 + var_79_18 + arg_79_0 and not isNil(var_79_16) and arg_76_1.var_.characterEffect6148ui_story then
				arg_76_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_79_20 = 0

			if var_79_20 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_79_21 = 0

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_22 = 0
			local var_79_23 = 1.4

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_24 = arg_76_1:FormatText(StoryNameCfg[1488].name)

				arg_76_1.leftNameTxt_.text = var_79_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_25 = arg_76_1:GetWordFromCfg(939021019)
				local var_79_26 = arg_76_1:FormatText(var_79_25.content)

				arg_76_1.text_.text = var_79_26

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_27 = 56
				local var_79_28 = utf8.len(var_79_26)
				local var_79_29 = var_79_27 <= 0 and var_79_23 or var_79_23 * (var_79_28 / var_79_27)

				if var_79_29 > 0 and var_79_23 < var_79_29 then
					arg_76_1.talkMaxDuration = var_79_29

					if var_79_29 + var_79_22 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_29 + var_79_22
					end
				end

				arg_76_1.text_.text = var_79_26
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_30 = math.max(var_79_23, arg_76_1.talkMaxDuration)

			if var_79_22 <= arg_76_1.time_ and arg_76_1.time_ < var_79_22 + var_79_30 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_22) / var_79_30

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_22 + var_79_30 and arg_76_1.time_ < var_79_22 + var_79_30 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play939021020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939021020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939021021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "1211ui_story"

			if arg_80_1.actors_[var_83_0] == nil then
				local var_83_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_83_1) then
					local var_83_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_80_1.stage_.transform)

					var_83_2.name = var_83_0
					var_83_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_80_1.actors_[var_83_0] = var_83_2

					local var_83_3 = var_83_2:GetComponentInChildren(typeof(CharacterEffect))

					var_83_3.enabled = true

					local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_2, typeof(DynamicBoneHelper))

					if var_83_4 then
						var_83_4:EnableDynamicBone(false)
					end

					arg_80_1:ShowWeapon(var_83_3.transform, false)

					arg_80_1.var_[var_83_0 .. "Animator"] = var_83_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_80_1.var_[var_83_0 .. "Animator"].applyRootMotion = true
					arg_80_1.var_[var_83_0 .. "LipSync"] = var_83_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_83_5 = arg_80_1.actors_["1211ui_story"].transform
			local var_83_6 = 0

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.var_.moveOldPos1211ui_story = var_83_5.localPosition
			end

			local var_83_7 = 0.001

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_7 then
				local var_83_8 = (arg_80_1.time_ - var_83_6) / var_83_7
				local var_83_9 = Vector3.New(-0.7, -0.67, -6.07)

				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1211ui_story, var_83_9, var_83_8)

				local var_83_10 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_10.x, var_83_10.y, var_83_10.z)

				local var_83_11 = var_83_5.localEulerAngles

				var_83_11.z = 0
				var_83_11.x = 0
				var_83_5.localEulerAngles = var_83_11
			end

			if arg_80_1.time_ >= var_83_6 + var_83_7 and arg_80_1.time_ < var_83_6 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_83_12 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_12.x, var_83_12.y, var_83_12.z)

				local var_83_13 = var_83_5.localEulerAngles

				var_83_13.z = 0
				var_83_13.x = 0
				var_83_5.localEulerAngles = var_83_13
			end

			local var_83_14 = arg_80_1.actors_["1054ui_story"].transform
			local var_83_15 = 0

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.var_.moveOldPos1054ui_story = var_83_14.localPosition

				local var_83_16 = GameObjectTools.GetOrAddComponent(var_83_14.gameObject, typeof(DynamicBoneHelper))

				if var_83_16 then
					var_83_16:EnableDynamicBone(false)
				end
			end

			local var_83_17 = 0.001

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_15) / var_83_17
				local var_83_19 = Vector3.New(0, 100, 0)

				var_83_14.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1054ui_story, var_83_19, var_83_18)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_14.position

				var_83_14.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_14.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_14.localEulerAngles = var_83_21
			end

			if arg_80_1.time_ >= var_83_15 + var_83_17 and arg_80_1.time_ < var_83_15 + var_83_17 + arg_83_0 then
				var_83_14.localPosition = Vector3.New(0, 100, 0)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_14.position

				var_83_14.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_14.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_14.localEulerAngles = var_83_23

				local var_83_24 = GameObjectTools.GetOrAddComponent(var_83_14.gameObject, typeof(DynamicBoneHelper))

				if var_83_24 then
					var_83_24:EnableDynamicBone(true)
				end
			end

			local var_83_25 = arg_80_1.actors_["1211ui_story"]
			local var_83_26 = 0

			if var_83_26 < arg_80_1.time_ and arg_80_1.time_ <= var_83_26 + arg_83_0 and not isNil(var_83_25) and arg_80_1.var_.characterEffect1211ui_story == nil then
				arg_80_1.var_.characterEffect1211ui_story = var_83_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_27 = 0.200000002980232

			if var_83_26 <= arg_80_1.time_ and arg_80_1.time_ < var_83_26 + var_83_27 and not isNil(var_83_25) then
				local var_83_28 = (arg_80_1.time_ - var_83_26) / var_83_27

				if arg_80_1.var_.characterEffect1211ui_story and not isNil(var_83_25) then
					arg_80_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_26 + var_83_27 and arg_80_1.time_ < var_83_26 + var_83_27 + arg_83_0 and not isNil(var_83_25) and arg_80_1.var_.characterEffect1211ui_story then
				arg_80_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_83_29 = arg_80_1.actors_["6148ui_story"]
			local var_83_30 = 0

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 and not isNil(var_83_29) and arg_80_1.var_.characterEffect6148ui_story == nil then
				arg_80_1.var_.characterEffect6148ui_story = var_83_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_31 = 0.200000002980232

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_31 and not isNil(var_83_29) then
				local var_83_32 = (arg_80_1.time_ - var_83_30) / var_83_31

				if arg_80_1.var_.characterEffect6148ui_story and not isNil(var_83_29) then
					local var_83_33 = Mathf.Lerp(0, 0.5, var_83_32)

					arg_80_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_80_1.var_.characterEffect6148ui_story.fillRatio = var_83_33
				end
			end

			if arg_80_1.time_ >= var_83_30 + var_83_31 and arg_80_1.time_ < var_83_30 + var_83_31 + arg_83_0 and not isNil(var_83_29) and arg_80_1.var_.characterEffect6148ui_story then
				local var_83_34 = 0.5

				arg_80_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_80_1.var_.characterEffect6148ui_story.fillRatio = var_83_34
			end

			local var_83_35 = 0

			if var_83_35 < arg_80_1.time_ and arg_80_1.time_ <= var_83_35 + arg_83_0 then
				arg_80_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_83_36 = 0

			if var_83_36 < arg_80_1.time_ and arg_80_1.time_ <= var_83_36 + arg_83_0 then
				arg_80_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_83_37 = 0
			local var_83_38 = 0.475

			if var_83_37 < arg_80_1.time_ and arg_80_1.time_ <= var_83_37 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_39 = arg_80_1:FormatText(StoryNameCfg[37].name)

				arg_80_1.leftNameTxt_.text = var_83_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_40 = arg_80_1:GetWordFromCfg(939021020)
				local var_83_41 = arg_80_1:FormatText(var_83_40.content)

				arg_80_1.text_.text = var_83_41

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_42 = 19
				local var_83_43 = utf8.len(var_83_41)
				local var_83_44 = var_83_42 <= 0 and var_83_38 or var_83_38 * (var_83_43 / var_83_42)

				if var_83_44 > 0 and var_83_38 < var_83_44 then
					arg_80_1.talkMaxDuration = var_83_44

					if var_83_44 + var_83_37 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_44 + var_83_37
					end
				end

				arg_80_1.text_.text = var_83_41
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_45 = math.max(var_83_38, arg_80_1.talkMaxDuration)

			if var_83_37 <= arg_80_1.time_ and arg_80_1.time_ < var_83_37 + var_83_45 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_37) / var_83_45

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_37 + var_83_45 and arg_80_1.time_ < var_83_37 + var_83_45 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play939021021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939021021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939021022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1284ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1284ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0.7, -0.985, -6.22)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1284ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["6148ui_story"].transform
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.var_.moveOldPos6148ui_story = var_87_9.localPosition

				local var_87_11 = GameObjectTools.GetOrAddComponent(var_87_9.gameObject, typeof(DynamicBoneHelper))

				if var_87_11 then
					var_87_11:EnableDynamicBone(false)
				end
			end

			local var_87_12 = 0.001

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_10) / var_87_12
				local var_87_14 = Vector3.New(0, 100, 0)

				var_87_9.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos6148ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_9.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_9.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_10 + var_87_12 and arg_84_1.time_ < var_87_10 + var_87_12 + arg_87_0 then
				var_87_9.localPosition = Vector3.New(0, 100, 0)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_9.position

				var_87_9.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_9.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_9.localEulerAngles = var_87_18

				local var_87_19 = GameObjectTools.GetOrAddComponent(var_87_9.gameObject, typeof(DynamicBoneHelper))

				if var_87_19 then
					var_87_19:EnableDynamicBone(true)
				end
			end

			local var_87_20 = arg_84_1.actors_["1284ui_story"]
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect1284ui_story == nil then
				arg_84_1.var_.characterEffect1284ui_story = var_87_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_22 = 0.200000002980232

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 and not isNil(var_87_20) then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22

				if arg_84_1.var_.characterEffect1284ui_story and not isNil(var_87_20) then
					arg_84_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect1284ui_story then
				arg_84_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_87_24 = arg_84_1.actors_["1211ui_story"]
			local var_87_25 = 0

			if var_87_25 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 and not isNil(var_87_24) and arg_84_1.var_.characterEffect1211ui_story == nil then
				arg_84_1.var_.characterEffect1211ui_story = var_87_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_26 = 0.200000002980232

			if var_87_25 <= arg_84_1.time_ and arg_84_1.time_ < var_87_25 + var_87_26 and not isNil(var_87_24) then
				local var_87_27 = (arg_84_1.time_ - var_87_25) / var_87_26

				if arg_84_1.var_.characterEffect1211ui_story and not isNil(var_87_24) then
					local var_87_28 = Mathf.Lerp(0, 0.5, var_87_27)

					arg_84_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1211ui_story.fillRatio = var_87_28
				end
			end

			if arg_84_1.time_ >= var_87_25 + var_87_26 and arg_84_1.time_ < var_87_25 + var_87_26 + arg_87_0 and not isNil(var_87_24) and arg_84_1.var_.characterEffect1211ui_story then
				local var_87_29 = 0.5

				arg_84_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1211ui_story.fillRatio = var_87_29
			end

			local var_87_30 = 0

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_87_31 = 0

			if var_87_31 < arg_84_1.time_ and arg_84_1.time_ <= var_87_31 + arg_87_0 then
				arg_84_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_87_32 = 0
			local var_87_33 = 0.25

			if var_87_32 < arg_84_1.time_ and arg_84_1.time_ <= var_87_32 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_34 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_35 = arg_84_1:GetWordFromCfg(939021021)
				local var_87_36 = arg_84_1:FormatText(var_87_35.content)

				arg_84_1.text_.text = var_87_36

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_37 = 10
				local var_87_38 = utf8.len(var_87_36)
				local var_87_39 = var_87_37 <= 0 and var_87_33 or var_87_33 * (var_87_38 / var_87_37)

				if var_87_39 > 0 and var_87_33 < var_87_39 then
					arg_84_1.talkMaxDuration = var_87_39

					if var_87_39 + var_87_32 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_39 + var_87_32
					end
				end

				arg_84_1.text_.text = var_87_36
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_40 = math.max(var_87_33, arg_84_1.talkMaxDuration)

			if var_87_32 <= arg_84_1.time_ and arg_84_1.time_ < var_87_32 + var_87_40 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_32) / var_87_40

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_32 + var_87_40 and arg_84_1.time_ < var_87_32 + var_87_40 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play939021022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939021022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939021023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1284ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1284ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1284ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1211ui_story"].transform
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.var_.moveOldPos1211ui_story = var_91_9.localPosition
			end

			local var_91_11 = 0.001

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11
				local var_91_13 = Vector3.New(0, 100, 0)

				var_91_9.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1211ui_story, var_91_13, var_91_12)

				local var_91_14 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_14.x, var_91_14.y, var_91_14.z)

				local var_91_15 = var_91_9.localEulerAngles

				var_91_15.z = 0
				var_91_15.x = 0
				var_91_9.localEulerAngles = var_91_15
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				var_91_9.localPosition = Vector3.New(0, 100, 0)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_9.position

				var_91_9.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_9.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_9.localEulerAngles = var_91_17
			end

			local var_91_18 = arg_88_1.actors_["1284ui_story"]
			local var_91_19 = 0

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 and not isNil(var_91_18) and arg_88_1.var_.characterEffect1284ui_story == nil then
				arg_88_1.var_.characterEffect1284ui_story = var_91_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_20 = 0.200000002980232

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 and not isNil(var_91_18) then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / var_91_20

				if arg_88_1.var_.characterEffect1284ui_story and not isNil(var_91_18) then
					local var_91_22 = Mathf.Lerp(0, 0.5, var_91_21)

					arg_88_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1284ui_story.fillRatio = var_91_22
				end
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 and not isNil(var_91_18) and arg_88_1.var_.characterEffect1284ui_story then
				local var_91_23 = 0.5

				arg_88_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1284ui_story.fillRatio = var_91_23
			end

			local var_91_24 = 0
			local var_91_25 = 0.8

			if var_91_24 < arg_88_1.time_ and arg_88_1.time_ <= var_91_24 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_26 = arg_88_1:GetWordFromCfg(939021022)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.text_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_28 = 32
				local var_91_29 = utf8.len(var_91_27)
				local var_91_30 = var_91_28 <= 0 and var_91_25 or var_91_25 * (var_91_29 / var_91_28)

				if var_91_30 > 0 and var_91_25 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30

					if var_91_30 + var_91_24 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_24
					end
				end

				arg_88_1.text_.text = var_91_27
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_31 = math.max(var_91_25, arg_88_1.talkMaxDuration)

			if var_91_24 <= arg_88_1.time_ and arg_88_1.time_ < var_91_24 + var_91_31 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_24) / var_91_31

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_24 + var_91_31 and arg_88_1.time_ < var_91_24 + var_91_31 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play939021023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939021023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play939021024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1054ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(-0.7, -0.985, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1054ui_story"]
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = var_95_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_13 = 0.200000002980232

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 and not isNil(var_95_11) then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13

				if arg_92_1.var_.characterEffect1054ui_story and not isNil(var_95_11) then
					arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 and not isNil(var_95_11) and arg_92_1.var_.characterEffect1054ui_story then
				arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_95_16 = 0

			if var_95_16 < arg_92_1.time_ and arg_92_1.time_ <= var_95_16 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_95_17 = 0
			local var_95_18 = 0.65

			if var_95_17 < arg_92_1.time_ and arg_92_1.time_ <= var_95_17 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_19 = arg_92_1:FormatText(StoryNameCfg[1487].name)

				arg_92_1.leftNameTxt_.text = var_95_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_20 = arg_92_1:GetWordFromCfg(939021023)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 26
				local var_95_23 = utf8.len(var_95_21)
				local var_95_24 = var_95_22 <= 0 and var_95_18 or var_95_18 * (var_95_23 / var_95_22)

				if var_95_24 > 0 and var_95_18 < var_95_24 then
					arg_92_1.talkMaxDuration = var_95_24

					if var_95_24 + var_95_17 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_24 + var_95_17
					end
				end

				arg_92_1.text_.text = var_95_21
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_25 = math.max(var_95_18, arg_92_1.talkMaxDuration)

			if var_95_17 <= arg_92_1.time_ and arg_92_1.time_ < var_95_17 + var_95_25 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_17) / var_95_25

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_17 + var_95_25 and arg_92_1.time_ < var_95_17 + var_95_25 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play939021024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 939021024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play939021025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["6148ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos6148ui_story = var_99_0.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Vector3.New(0.7, -0.985, -6)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos6148ui_story, var_99_5, var_99_4)

				local var_99_6 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_6.x, var_99_6.y, var_99_6.z)

				local var_99_7 = var_99_0.localEulerAngles

				var_99_7.z = 0
				var_99_7.x = 0
				var_99_0.localEulerAngles = var_99_7
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_99_8 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_8.x, var_99_8.y, var_99_8.z)

				local var_99_9 = var_99_0.localEulerAngles

				var_99_9.z = 0
				var_99_9.x = 0
				var_99_0.localEulerAngles = var_99_9

				local var_99_10 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_10 then
					var_99_10:EnableDynamicBone(true)
				end
			end

			local var_99_11 = arg_96_1.actors_["6148ui_story"]
			local var_99_12 = 0

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect6148ui_story == nil then
				arg_96_1.var_.characterEffect6148ui_story = var_99_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_13 = 0.200000002980232

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 and not isNil(var_99_11) then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13

				if arg_96_1.var_.characterEffect6148ui_story and not isNil(var_99_11) then
					arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect6148ui_story then
				arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_99_15 = arg_96_1.actors_["1054ui_story"]
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 and not isNil(var_99_15) and arg_96_1.var_.characterEffect1054ui_story == nil then
				arg_96_1.var_.characterEffect1054ui_story = var_99_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_17 = 0.200000002980232

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_17 and not isNil(var_99_15) then
				local var_99_18 = (arg_96_1.time_ - var_99_16) / var_99_17

				if arg_96_1.var_.characterEffect1054ui_story and not isNil(var_99_15) then
					local var_99_19 = Mathf.Lerp(0, 0.5, var_99_18)

					arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1054ui_story.fillRatio = var_99_19
				end
			end

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 and not isNil(var_99_15) and arg_96_1.var_.characterEffect1054ui_story then
				local var_99_20 = 0.5

				arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1054ui_story.fillRatio = var_99_20
			end

			local var_99_21 = 0

			if var_99_21 < arg_96_1.time_ and arg_96_1.time_ <= var_99_21 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_99_22 = 0

			if var_99_22 < arg_96_1.time_ and arg_96_1.time_ <= var_99_22 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_23 = 0
			local var_99_24 = 0.6

			if var_99_23 < arg_96_1.time_ and arg_96_1.time_ <= var_99_23 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_25 = arg_96_1:FormatText(StoryNameCfg[1488].name)

				arg_96_1.leftNameTxt_.text = var_99_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_26 = arg_96_1:GetWordFromCfg(939021024)
				local var_99_27 = arg_96_1:FormatText(var_99_26.content)

				arg_96_1.text_.text = var_99_27

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_28 = 24
				local var_99_29 = utf8.len(var_99_27)
				local var_99_30 = var_99_28 <= 0 and var_99_24 or var_99_24 * (var_99_29 / var_99_28)

				if var_99_30 > 0 and var_99_24 < var_99_30 then
					arg_96_1.talkMaxDuration = var_99_30

					if var_99_30 + var_99_23 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_30 + var_99_23
					end
				end

				arg_96_1.text_.text = var_99_27
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_31 = math.max(var_99_24, arg_96_1.talkMaxDuration)

			if var_99_23 <= arg_96_1.time_ and arg_96_1.time_ < var_99_23 + var_99_31 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_23) / var_99_31

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_23 + var_99_31 and arg_96_1.time_ < var_99_23 + var_99_31 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play939021025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939021025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939021026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["6148ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos6148ui_story = var_103_0.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_3 then
				local var_103_4 = (arg_100_1.time_ - var_103_1) / var_103_3
				local var_103_5 = Vector3.New(0.7, -0.985, -6)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos6148ui_story, var_103_5, var_103_4)

				local var_103_6 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_6.x, var_103_6.y, var_103_6.z)

				local var_103_7 = var_103_0.localEulerAngles

				var_103_7.z = 0
				var_103_7.x = 0
				var_103_0.localEulerAngles = var_103_7
			end

			if arg_100_1.time_ >= var_103_1 + var_103_3 and arg_100_1.time_ < var_103_1 + var_103_3 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_103_8 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_8.x, var_103_8.y, var_103_8.z)

				local var_103_9 = var_103_0.localEulerAngles

				var_103_9.z = 0
				var_103_9.x = 0
				var_103_0.localEulerAngles = var_103_9

				local var_103_10 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_10 then
					var_103_10:EnableDynamicBone(true)
				end
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action458")
			end

			local var_103_12 = 0

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_103_13 = 0
			local var_103_14 = 0.275

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_15 = arg_100_1:FormatText(StoryNameCfg[1488].name)

				arg_100_1.leftNameTxt_.text = var_103_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_16 = arg_100_1:GetWordFromCfg(939021025)
				local var_103_17 = arg_100_1:FormatText(var_103_16.content)

				arg_100_1.text_.text = var_103_17

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_18 = 11
				local var_103_19 = utf8.len(var_103_17)
				local var_103_20 = var_103_18 <= 0 and var_103_14 or var_103_14 * (var_103_19 / var_103_18)

				if var_103_20 > 0 and var_103_14 < var_103_20 then
					arg_100_1.talkMaxDuration = var_103_20

					if var_103_20 + var_103_13 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_13
					end
				end

				arg_100_1.text_.text = var_103_17
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_21 = math.max(var_103_14, arg_100_1.talkMaxDuration)

			if var_103_13 <= arg_100_1.time_ and arg_100_1.time_ < var_103_13 + var_103_21 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_13) / var_103_21

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_13 + var_103_21 and arg_100_1.time_ < var_103_13 + var_103_21 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play939021026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939021026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play939021027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["6148ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos6148ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos6148ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["1054ui_story"].transform
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.var_.moveOldPos1054ui_story = var_107_11.localPosition

				local var_107_13 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_13 then
					var_107_13:EnableDynamicBone(false)
				end
			end

			local var_107_14 = 0.001

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_14 then
				local var_107_15 = (arg_104_1.time_ - var_107_12) / var_107_14
				local var_107_16 = Vector3.New(0, 100, 0)

				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1054ui_story, var_107_16, var_107_15)

				local var_107_17 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_17.x, var_107_17.y, var_107_17.z)

				local var_107_18 = var_107_11.localEulerAngles

				var_107_18.z = 0
				var_107_18.x = 0
				var_107_11.localEulerAngles = var_107_18
			end

			if arg_104_1.time_ >= var_107_12 + var_107_14 and arg_104_1.time_ < var_107_12 + var_107_14 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(0, 100, 0)

				local var_107_19 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_19.x, var_107_19.y, var_107_19.z)

				local var_107_20 = var_107_11.localEulerAngles

				var_107_20.z = 0
				var_107_20.x = 0
				var_107_11.localEulerAngles = var_107_20

				local var_107_21 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_21 then
					var_107_21:EnableDynamicBone(true)
				end
			end

			local var_107_22 = arg_104_1.actors_["6148ui_story"]
			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect6148ui_story == nil then
				arg_104_1.var_.characterEffect6148ui_story = var_107_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_24 = 0.200000002980232

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 and not isNil(var_107_22) then
				local var_107_25 = (arg_104_1.time_ - var_107_23) / var_107_24

				if arg_104_1.var_.characterEffect6148ui_story and not isNil(var_107_22) then
					local var_107_26 = Mathf.Lerp(0, 0.5, var_107_25)

					arg_104_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect6148ui_story.fillRatio = var_107_26
				end
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect6148ui_story then
				local var_107_27 = 0.5

				arg_104_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect6148ui_story.fillRatio = var_107_27
			end

			local var_107_28 = manager.ui.mainCamera.transform
			local var_107_29 = 0

			if var_107_29 < arg_104_1.time_ and arg_104_1.time_ <= var_107_29 + arg_107_0 then
				local var_107_30 = arg_104_1.var_.effectguaheiban1
				local var_107_31
				local var_107_32 = var_107_28

				if not var_107_30 then
					var_107_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_107_32)
					var_107_30.name = "guaheiban1"
					arg_104_1.var_.effectguaheiban1 = var_107_30
				else
					var_107_30.transform:SetParent(var_107_32)
				end

				var_107_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_107_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_107_33 = 0
			local var_107_34 = 1

			if var_107_33 < arg_104_1.time_ and arg_104_1.time_ <= var_107_33 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_35 = arg_104_1:GetWordFromCfg(939021026)
				local var_107_36 = arg_104_1:FormatText(var_107_35.content)

				arg_104_1.text_.text = var_107_36

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_37 = 40
				local var_107_38 = utf8.len(var_107_36)
				local var_107_39 = var_107_37 <= 0 and var_107_34 or var_107_34 * (var_107_38 / var_107_37)

				if var_107_39 > 0 and var_107_34 < var_107_39 then
					arg_104_1.talkMaxDuration = var_107_39

					if var_107_39 + var_107_33 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_39 + var_107_33
					end
				end

				arg_104_1.text_.text = var_107_36
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_34, arg_104_1.talkMaxDuration)

			if var_107_33 <= arg_104_1.time_ and arg_104_1.time_ < var_107_33 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_33) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_33 + var_107_40 and arg_104_1.time_ < var_107_33 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play939021027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 939021027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play939021028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1284ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1284ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1284ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1284ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1284ui_story == nil then
				arg_108_1.var_.characterEffect1284ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1284ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1284ui_story then
				arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action10_2")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_15 = 0
			local var_111_16 = 0.325

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(939021027)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 13
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_23 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_23 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_23

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_23 and arg_108_1.time_ < var_111_15 + var_111_23 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play939021028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 939021028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play939021029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1211ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1211ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0.7, -0.67, -6.07)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1211ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1211ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1211ui_story == nil then
				arg_112_1.var_.characterEffect1211ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1211ui_story and not isNil(var_115_9) then
					arg_112_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1211ui_story then
				arg_112_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_115_13 = arg_112_1.actors_["1284ui_story"]
			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1284ui_story == nil then
				arg_112_1.var_.characterEffect1284ui_story = var_115_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_15 = 0.200000002980232

			if var_115_14 <= arg_112_1.time_ and arg_112_1.time_ < var_115_14 + var_115_15 and not isNil(var_115_13) then
				local var_115_16 = (arg_112_1.time_ - var_115_14) / var_115_15

				if arg_112_1.var_.characterEffect1284ui_story and not isNil(var_115_13) then
					local var_115_17 = Mathf.Lerp(0, 0.5, var_115_16)

					arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1284ui_story.fillRatio = var_115_17
				end
			end

			if arg_112_1.time_ >= var_115_14 + var_115_15 and arg_112_1.time_ < var_115_14 + var_115_15 + arg_115_0 and not isNil(var_115_13) and arg_112_1.var_.characterEffect1284ui_story then
				local var_115_18 = 0.5

				arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1284ui_story.fillRatio = var_115_18
			end

			local var_115_19 = 0

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			local var_115_20 = 0

			if var_115_20 < arg_112_1.time_ and arg_112_1.time_ <= var_115_20 + arg_115_0 then
				arg_112_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_115_21 = 0
			local var_115_22 = 0.35

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_23 = arg_112_1:FormatText(StoryNameCfg[37].name)

				arg_112_1.leftNameTxt_.text = var_115_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_24 = arg_112_1:GetWordFromCfg(939021028)
				local var_115_25 = arg_112_1:FormatText(var_115_24.content)

				arg_112_1.text_.text = var_115_25

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_26 = 14
				local var_115_27 = utf8.len(var_115_25)
				local var_115_28 = var_115_26 <= 0 and var_115_22 or var_115_22 * (var_115_27 / var_115_26)

				if var_115_28 > 0 and var_115_22 < var_115_28 then
					arg_112_1.talkMaxDuration = var_115_28

					if var_115_28 + var_115_21 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_28 + var_115_21
					end
				end

				arg_112_1.text_.text = var_115_25
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_29 = math.max(var_115_22, arg_112_1.talkMaxDuration)

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_29 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_21) / var_115_29

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_21 + var_115_29 and arg_112_1.time_ < var_115_21 + var_115_29 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play939021029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 939021029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play939021030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1211ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1211ui_story == nil then
				arg_116_1.var_.characterEffect1211ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1211ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1211ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1211ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1211ui_story.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.75

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(939021029)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 30
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_14 and arg_116_1.time_ < var_119_6 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play939021030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 939021030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play939021031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1211ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1211ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1211ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1284ui_story"].transform
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.var_.moveOldPos1284ui_story = var_123_9.localPosition
			end

			local var_123_11 = 0.001

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11
				local var_123_13 = Vector3.New(0, 100, 0)

				var_123_9.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1284ui_story, var_123_13, var_123_12)

				local var_123_14 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_14.x, var_123_14.y, var_123_14.z)

				local var_123_15 = var_123_9.localEulerAngles

				var_123_15.z = 0
				var_123_15.x = 0
				var_123_9.localEulerAngles = var_123_15
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				var_123_9.localPosition = Vector3.New(0, 100, 0)

				local var_123_16 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_16.x, var_123_16.y, var_123_16.z)

				local var_123_17 = var_123_9.localEulerAngles

				var_123_17.z = 0
				var_123_17.x = 0
				var_123_9.localEulerAngles = var_123_17
			end

			local var_123_18 = arg_120_1.actors_["6148ui_story"].transform
			local var_123_19 = 0

			if var_123_19 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 then
				arg_120_1.var_.moveOldPos6148ui_story = var_123_18.localPosition

				local var_123_20 = GameObjectTools.GetOrAddComponent(var_123_18.gameObject, typeof(DynamicBoneHelper))

				if var_123_20 then
					var_123_20:EnableDynamicBone(false)
				end
			end

			local var_123_21 = 0.001

			if var_123_19 <= arg_120_1.time_ and arg_120_1.time_ < var_123_19 + var_123_21 then
				local var_123_22 = (arg_120_1.time_ - var_123_19) / var_123_21
				local var_123_23 = Vector3.New(0, -0.985, -6)

				var_123_18.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos6148ui_story, var_123_23, var_123_22)

				local var_123_24 = manager.ui.mainCamera.transform.position - var_123_18.position

				var_123_18.forward = Vector3.New(var_123_24.x, var_123_24.y, var_123_24.z)

				local var_123_25 = var_123_18.localEulerAngles

				var_123_25.z = 0
				var_123_25.x = 0
				var_123_18.localEulerAngles = var_123_25
			end

			if arg_120_1.time_ >= var_123_19 + var_123_21 and arg_120_1.time_ < var_123_19 + var_123_21 + arg_123_0 then
				var_123_18.localPosition = Vector3.New(0, -0.985, -6)

				local var_123_26 = manager.ui.mainCamera.transform.position - var_123_18.position

				var_123_18.forward = Vector3.New(var_123_26.x, var_123_26.y, var_123_26.z)

				local var_123_27 = var_123_18.localEulerAngles

				var_123_27.z = 0
				var_123_27.x = 0
				var_123_18.localEulerAngles = var_123_27

				local var_123_28 = GameObjectTools.GetOrAddComponent(var_123_18.gameObject, typeof(DynamicBoneHelper))

				if var_123_28 then
					var_123_28:EnableDynamicBone(true)
				end
			end

			local var_123_29 = arg_120_1.actors_["6148ui_story"]
			local var_123_30 = 0

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 and not isNil(var_123_29) and arg_120_1.var_.characterEffect6148ui_story == nil then
				arg_120_1.var_.characterEffect6148ui_story = var_123_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_31 = 0.200000002980232

			if var_123_30 <= arg_120_1.time_ and arg_120_1.time_ < var_123_30 + var_123_31 and not isNil(var_123_29) then
				local var_123_32 = (arg_120_1.time_ - var_123_30) / var_123_31

				if arg_120_1.var_.characterEffect6148ui_story and not isNil(var_123_29) then
					arg_120_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_30 + var_123_31 and arg_120_1.time_ < var_123_30 + var_123_31 + arg_123_0 and not isNil(var_123_29) and arg_120_1.var_.characterEffect6148ui_story then
				arg_120_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_123_33 = 0

			if var_123_33 < arg_120_1.time_ and arg_120_1.time_ <= var_123_33 + arg_123_0 then
				arg_120_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			local var_123_34 = 0

			if var_123_34 < arg_120_1.time_ and arg_120_1.time_ <= var_123_34 + arg_123_0 then
				arg_120_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_123_35 = 0
			local var_123_36 = 0.475

			if var_123_35 < arg_120_1.time_ and arg_120_1.time_ <= var_123_35 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_37 = arg_120_1:FormatText(StoryNameCfg[1488].name)

				arg_120_1.leftNameTxt_.text = var_123_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_38 = arg_120_1:GetWordFromCfg(939021030)
				local var_123_39 = arg_120_1:FormatText(var_123_38.content)

				arg_120_1.text_.text = var_123_39

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_40 = 19
				local var_123_41 = utf8.len(var_123_39)
				local var_123_42 = var_123_40 <= 0 and var_123_36 or var_123_36 * (var_123_41 / var_123_40)

				if var_123_42 > 0 and var_123_36 < var_123_42 then
					arg_120_1.talkMaxDuration = var_123_42

					if var_123_42 + var_123_35 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_42 + var_123_35
					end
				end

				arg_120_1.text_.text = var_123_39
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_43 = math.max(var_123_36, arg_120_1.talkMaxDuration)

			if var_123_35 <= arg_120_1.time_ and arg_120_1.time_ < var_123_35 + var_123_43 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_35) / var_123_43

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_35 + var_123_43 and arg_120_1.time_ < var_123_35 + var_123_43 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play939021031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 939021031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play939021032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["6148ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos6148ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0, -0.985, -6)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos6148ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = 0

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 then
				arg_124_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_13 = 0
			local var_127_14 = 0.575

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_15 = arg_124_1:FormatText(StoryNameCfg[1488].name)

				arg_124_1.leftNameTxt_.text = var_127_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_16 = arg_124_1:GetWordFromCfg(939021031)
				local var_127_17 = arg_124_1:FormatText(var_127_16.content)

				arg_124_1.text_.text = var_127_17

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_18 = 23
				local var_127_19 = utf8.len(var_127_17)
				local var_127_20 = var_127_18 <= 0 and var_127_14 or var_127_14 * (var_127_19 / var_127_18)

				if var_127_20 > 0 and var_127_14 < var_127_20 then
					arg_124_1.talkMaxDuration = var_127_20

					if var_127_20 + var_127_13 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_20 + var_127_13
					end
				end

				arg_124_1.text_.text = var_127_17
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_21 = math.max(var_127_14, arg_124_1.talkMaxDuration)

			if var_127_13 <= arg_124_1.time_ and arg_124_1.time_ < var_127_13 + var_127_21 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_13) / var_127_21

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_13 + var_127_21 and arg_124_1.time_ < var_127_13 + var_127_21 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play939021032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 939021032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play939021033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1054ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1054ui_story = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0.7, -0.985, -6)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1054ui_story, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = arg_128_1.actors_["6148ui_story"].transform
			local var_131_12 = 0

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.var_.moveOldPos6148ui_story = var_131_11.localPosition

				local var_131_13 = GameObjectTools.GetOrAddComponent(var_131_11.gameObject, typeof(DynamicBoneHelper))

				if var_131_13 then
					var_131_13:EnableDynamicBone(false)
				end
			end

			local var_131_14 = 0.001

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_14 then
				local var_131_15 = (arg_128_1.time_ - var_131_12) / var_131_14
				local var_131_16 = Vector3.New(-0.7, -0.985, -6)

				var_131_11.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos6148ui_story, var_131_16, var_131_15)

				local var_131_17 = manager.ui.mainCamera.transform.position - var_131_11.position

				var_131_11.forward = Vector3.New(var_131_17.x, var_131_17.y, var_131_17.z)

				local var_131_18 = var_131_11.localEulerAngles

				var_131_18.z = 0
				var_131_18.x = 0
				var_131_11.localEulerAngles = var_131_18
			end

			if arg_128_1.time_ >= var_131_12 + var_131_14 and arg_128_1.time_ < var_131_12 + var_131_14 + arg_131_0 then
				var_131_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_131_19 = manager.ui.mainCamera.transform.position - var_131_11.position

				var_131_11.forward = Vector3.New(var_131_19.x, var_131_19.y, var_131_19.z)

				local var_131_20 = var_131_11.localEulerAngles

				var_131_20.z = 0
				var_131_20.x = 0
				var_131_11.localEulerAngles = var_131_20

				local var_131_21 = GameObjectTools.GetOrAddComponent(var_131_11.gameObject, typeof(DynamicBoneHelper))

				if var_131_21 then
					var_131_21:EnableDynamicBone(true)
				end
			end

			local var_131_22 = arg_128_1.actors_["1054ui_story"]
			local var_131_23 = 0

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 and not isNil(var_131_22) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_24 = 0.200000002980232

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_24 and not isNil(var_131_22) then
				local var_131_25 = (arg_128_1.time_ - var_131_23) / var_131_24

				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_22) then
					arg_128_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_23 + var_131_24 and arg_128_1.time_ < var_131_23 + var_131_24 + arg_131_0 and not isNil(var_131_22) and arg_128_1.var_.characterEffect1054ui_story then
				arg_128_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_131_26 = arg_128_1.actors_["6148ui_story"]
			local var_131_27 = 0

			if var_131_27 < arg_128_1.time_ and arg_128_1.time_ <= var_131_27 + arg_131_0 and not isNil(var_131_26) and arg_128_1.var_.characterEffect6148ui_story == nil then
				arg_128_1.var_.characterEffect6148ui_story = var_131_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_28 = 0.200000002980232

			if var_131_27 <= arg_128_1.time_ and arg_128_1.time_ < var_131_27 + var_131_28 and not isNil(var_131_26) then
				local var_131_29 = (arg_128_1.time_ - var_131_27) / var_131_28

				if arg_128_1.var_.characterEffect6148ui_story and not isNil(var_131_26) then
					local var_131_30 = Mathf.Lerp(0, 0.5, var_131_29)

					arg_128_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_128_1.var_.characterEffect6148ui_story.fillRatio = var_131_30
				end
			end

			if arg_128_1.time_ >= var_131_27 + var_131_28 and arg_128_1.time_ < var_131_27 + var_131_28 + arg_131_0 and not isNil(var_131_26) and arg_128_1.var_.characterEffect6148ui_story then
				local var_131_31 = 0.5

				arg_128_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_128_1.var_.characterEffect6148ui_story.fillRatio = var_131_31
			end

			local var_131_32 = 0

			if var_131_32 < arg_128_1.time_ and arg_128_1.time_ <= var_131_32 + arg_131_0 then
				arg_128_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_131_33 = 0

			if var_131_33 < arg_128_1.time_ and arg_128_1.time_ <= var_131_33 + arg_131_0 then
				arg_128_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_131_34 = 0
			local var_131_35 = 0.525

			if var_131_34 < arg_128_1.time_ and arg_128_1.time_ <= var_131_34 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_36 = arg_128_1:FormatText(StoryNameCfg[1487].name)

				arg_128_1.leftNameTxt_.text = var_131_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_37 = arg_128_1:GetWordFromCfg(939021032)
				local var_131_38 = arg_128_1:FormatText(var_131_37.content)

				arg_128_1.text_.text = var_131_38

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_39 = 21
				local var_131_40 = utf8.len(var_131_38)
				local var_131_41 = var_131_39 <= 0 and var_131_35 or var_131_35 * (var_131_40 / var_131_39)

				if var_131_41 > 0 and var_131_35 < var_131_41 then
					arg_128_1.talkMaxDuration = var_131_41

					if var_131_41 + var_131_34 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_41 + var_131_34
					end
				end

				arg_128_1.text_.text = var_131_38
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_42 = math.max(var_131_35, arg_128_1.talkMaxDuration)

			if var_131_34 <= arg_128_1.time_ and arg_128_1.time_ < var_131_34 + var_131_42 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_34) / var_131_42

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_34 + var_131_42 and arg_128_1.time_ < var_131_34 + var_131_42 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play939021033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 939021033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play939021034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1054ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1054ui_story = var_135_0.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_3 then
				local var_135_4 = (arg_132_1.time_ - var_135_1) / var_135_3
				local var_135_5 = Vector3.New(0, 100, 0)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1054ui_story, var_135_5, var_135_4)

				local var_135_6 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_6.x, var_135_6.y, var_135_6.z)

				local var_135_7 = var_135_0.localEulerAngles

				var_135_7.z = 0
				var_135_7.x = 0
				var_135_0.localEulerAngles = var_135_7
			end

			if arg_132_1.time_ >= var_135_1 + var_135_3 and arg_132_1.time_ < var_135_1 + var_135_3 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, 100, 0)

				local var_135_8 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_8.x, var_135_8.y, var_135_8.z)

				local var_135_9 = var_135_0.localEulerAngles

				var_135_9.z = 0
				var_135_9.x = 0
				var_135_0.localEulerAngles = var_135_9

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = arg_132_1.actors_["6148ui_story"].transform
			local var_135_12 = 0

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.var_.moveOldPos6148ui_story = var_135_11.localPosition

				local var_135_13 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_13 then
					var_135_13:EnableDynamicBone(false)
				end
			end

			local var_135_14 = 0.001

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_14 then
				local var_135_15 = (arg_132_1.time_ - var_135_12) / var_135_14
				local var_135_16 = Vector3.New(0, 100, 0)

				var_135_11.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos6148ui_story, var_135_16, var_135_15)

				local var_135_17 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_17.x, var_135_17.y, var_135_17.z)

				local var_135_18 = var_135_11.localEulerAngles

				var_135_18.z = 0
				var_135_18.x = 0
				var_135_11.localEulerAngles = var_135_18
			end

			if arg_132_1.time_ >= var_135_12 + var_135_14 and arg_132_1.time_ < var_135_12 + var_135_14 + arg_135_0 then
				var_135_11.localPosition = Vector3.New(0, 100, 0)

				local var_135_19 = manager.ui.mainCamera.transform.position - var_135_11.position

				var_135_11.forward = Vector3.New(var_135_19.x, var_135_19.y, var_135_19.z)

				local var_135_20 = var_135_11.localEulerAngles

				var_135_20.z = 0
				var_135_20.x = 0
				var_135_11.localEulerAngles = var_135_20

				local var_135_21 = GameObjectTools.GetOrAddComponent(var_135_11.gameObject, typeof(DynamicBoneHelper))

				if var_135_21 then
					var_135_21:EnableDynamicBone(true)
				end
			end

			local var_135_22 = arg_132_1.actors_["1054ui_story"]
			local var_135_23 = 0

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1054ui_story == nil then
				arg_132_1.var_.characterEffect1054ui_story = var_135_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_24 = 0.200000002980232

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_24 and not isNil(var_135_22) then
				local var_135_25 = (arg_132_1.time_ - var_135_23) / var_135_24

				if arg_132_1.var_.characterEffect1054ui_story and not isNil(var_135_22) then
					local var_135_26 = Mathf.Lerp(0, 0.5, var_135_25)

					arg_132_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1054ui_story.fillRatio = var_135_26
				end
			end

			if arg_132_1.time_ >= var_135_23 + var_135_24 and arg_132_1.time_ < var_135_23 + var_135_24 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1054ui_story then
				local var_135_27 = 0.5

				arg_132_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1054ui_story.fillRatio = var_135_27
			end

			local var_135_28 = 0
			local var_135_29 = 0.775

			if var_135_28 < arg_132_1.time_ and arg_132_1.time_ <= var_135_28 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_30 = arg_132_1:GetWordFromCfg(939021033)
				local var_135_31 = arg_132_1:FormatText(var_135_30.content)

				arg_132_1.text_.text = var_135_31

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_32 = 31
				local var_135_33 = utf8.len(var_135_31)
				local var_135_34 = var_135_32 <= 0 and var_135_29 or var_135_29 * (var_135_33 / var_135_32)

				if var_135_34 > 0 and var_135_29 < var_135_34 then
					arg_132_1.talkMaxDuration = var_135_34

					if var_135_34 + var_135_28 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_34 + var_135_28
					end
				end

				arg_132_1.text_.text = var_135_31
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_35 = math.max(var_135_29, arg_132_1.talkMaxDuration)

			if var_135_28 <= arg_132_1.time_ and arg_132_1.time_ < var_135_28 + var_135_35 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_28) / var_135_35

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_28 + var_135_35 and arg_132_1.time_ < var_135_28 + var_135_35 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play939021034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 939021034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play939021035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["6148ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos6148ui_story = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(-0.7, -0.985, -6)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos6148ui_story, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["6148ui_story"]
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect6148ui_story == nil then
				arg_136_1.var_.characterEffect6148ui_story = var_139_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_13 = 0.200000002980232

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_13 and not isNil(var_139_11) then
				local var_139_14 = (arg_136_1.time_ - var_139_12) / var_139_13

				if arg_136_1.var_.characterEffect6148ui_story and not isNil(var_139_11) then
					arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_12 + var_139_13 and arg_136_1.time_ < var_139_12 + var_139_13 + arg_139_0 and not isNil(var_139_11) and arg_136_1.var_.characterEffect6148ui_story then
				arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_139_17 = 0
			local var_139_18 = 1.2

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_19 = arg_136_1:FormatText(StoryNameCfg[1488].name)

				arg_136_1.leftNameTxt_.text = var_139_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_20 = arg_136_1:GetWordFromCfg(939021034)
				local var_139_21 = arg_136_1:FormatText(var_139_20.content)

				arg_136_1.text_.text = var_139_21

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_22 = 48
				local var_139_23 = utf8.len(var_139_21)
				local var_139_24 = var_139_22 <= 0 and var_139_18 or var_139_18 * (var_139_23 / var_139_22)

				if var_139_24 > 0 and var_139_18 < var_139_24 then
					arg_136_1.talkMaxDuration = var_139_24

					if var_139_24 + var_139_17 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_17
					end
				end

				arg_136_1.text_.text = var_139_21
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_25 = math.max(var_139_18, arg_136_1.talkMaxDuration)

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_17) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_17 + var_139_25 and arg_136_1.time_ < var_139_17 + var_139_25 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play939021035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 939021035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play939021036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1054ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1054ui_story = var_143_0.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_3 then
				local var_143_4 = (arg_140_1.time_ - var_143_1) / var_143_3
				local var_143_5 = Vector3.New(0.7, -0.985, -6)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1054ui_story, var_143_5, var_143_4)

				local var_143_6 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_6.x, var_143_6.y, var_143_6.z)

				local var_143_7 = var_143_0.localEulerAngles

				var_143_7.z = 0
				var_143_7.x = 0
				var_143_0.localEulerAngles = var_143_7
			end

			if arg_140_1.time_ >= var_143_1 + var_143_3 and arg_140_1.time_ < var_143_1 + var_143_3 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_143_8 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_8.x, var_143_8.y, var_143_8.z)

				local var_143_9 = var_143_0.localEulerAngles

				var_143_9.z = 0
				var_143_9.x = 0
				var_143_0.localEulerAngles = var_143_9

				local var_143_10 = GameObjectTools.GetOrAddComponent(var_143_0.gameObject, typeof(DynamicBoneHelper))

				if var_143_10 then
					var_143_10:EnableDynamicBone(true)
				end
			end

			local var_143_11 = arg_140_1.actors_["1054ui_story"]
			local var_143_12 = 0

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1054ui_story == nil then
				arg_140_1.var_.characterEffect1054ui_story = var_143_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_13 = 0.200000002980232

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_13 and not isNil(var_143_11) then
				local var_143_14 = (arg_140_1.time_ - var_143_12) / var_143_13

				if arg_140_1.var_.characterEffect1054ui_story and not isNil(var_143_11) then
					arg_140_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_12 + var_143_13 and arg_140_1.time_ < var_143_12 + var_143_13 + arg_143_0 and not isNil(var_143_11) and arg_140_1.var_.characterEffect1054ui_story then
				arg_140_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_143_15 = arg_140_1.actors_["6148ui_story"]
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect6148ui_story == nil then
				arg_140_1.var_.characterEffect6148ui_story = var_143_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_17 = 0.200000002980232

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 and not isNil(var_143_15) then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17

				if arg_140_1.var_.characterEffect6148ui_story and not isNil(var_143_15) then
					local var_143_19 = Mathf.Lerp(0, 0.5, var_143_18)

					arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_140_1.var_.characterEffect6148ui_story.fillRatio = var_143_19
				end
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.characterEffect6148ui_story then
				local var_143_20 = 0.5

				arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_140_1.var_.characterEffect6148ui_story.fillRatio = var_143_20
			end

			local var_143_21 = 0

			if var_143_21 < arg_140_1.time_ and arg_140_1.time_ <= var_143_21 + arg_143_0 then
				arg_140_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_143_22 = 0

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 then
				arg_140_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_143_23 = 0
			local var_143_24 = 0.4

			if var_143_23 < arg_140_1.time_ and arg_140_1.time_ <= var_143_23 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_25 = arg_140_1:FormatText(StoryNameCfg[1487].name)

				arg_140_1.leftNameTxt_.text = var_143_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_26 = arg_140_1:GetWordFromCfg(939021035)
				local var_143_27 = arg_140_1:FormatText(var_143_26.content)

				arg_140_1.text_.text = var_143_27

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_28 = 16
				local var_143_29 = utf8.len(var_143_27)
				local var_143_30 = var_143_28 <= 0 and var_143_24 or var_143_24 * (var_143_29 / var_143_28)

				if var_143_30 > 0 and var_143_24 < var_143_30 then
					arg_140_1.talkMaxDuration = var_143_30

					if var_143_30 + var_143_23 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_30 + var_143_23
					end
				end

				arg_140_1.text_.text = var_143_27
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_31 = math.max(var_143_24, arg_140_1.talkMaxDuration)

			if var_143_23 <= arg_140_1.time_ and arg_140_1.time_ < var_143_23 + var_143_31 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_23) / var_143_31

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_23 + var_143_31 and arg_140_1.time_ < var_143_23 + var_143_31 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play939021036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 939021036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play939021037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1054ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1054ui_story == nil then
				arg_144_1.var_.characterEffect1054ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1054ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1054ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1054ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1054ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 1.025

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(939021036)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_10 = 41
				local var_147_11 = utf8.len(var_147_9)
				local var_147_12 = var_147_10 <= 0 and var_147_7 or var_147_7 * (var_147_11 / var_147_10)

				if var_147_12 > 0 and var_147_7 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_13 and arg_144_1.time_ < var_147_6 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play939021037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 939021037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play939021038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.65

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(939021037)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 26
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play939021038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 939021038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play939021039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["6148ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos6148ui_story = var_155_0.localPosition

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(-0.7, -0.985, -6)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos6148ui_story, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9

				local var_155_10 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_10 then
					var_155_10:EnableDynamicBone(true)
				end
			end

			local var_155_11 = arg_152_1.actors_["6148ui_story"]
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect6148ui_story == nil then
				arg_152_1.var_.characterEffect6148ui_story = var_155_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_13 = 0.200000002980232

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_13 and not isNil(var_155_11) then
				local var_155_14 = (arg_152_1.time_ - var_155_12) / var_155_13

				if arg_152_1.var_.characterEffect6148ui_story and not isNil(var_155_11) then
					arg_152_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_12 + var_155_13 and arg_152_1.time_ < var_155_12 + var_155_13 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect6148ui_story then
				arg_152_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_155_17 = 0
			local var_155_18 = 0.775

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_19 = arg_152_1:FormatText(StoryNameCfg[1488].name)

				arg_152_1.leftNameTxt_.text = var_155_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_20 = arg_152_1:GetWordFromCfg(939021038)
				local var_155_21 = arg_152_1:FormatText(var_155_20.content)

				arg_152_1.text_.text = var_155_21

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_22 = 31
				local var_155_23 = utf8.len(var_155_21)
				local var_155_24 = var_155_22 <= 0 and var_155_18 or var_155_18 * (var_155_23 / var_155_22)

				if var_155_24 > 0 and var_155_18 < var_155_24 then
					arg_152_1.talkMaxDuration = var_155_24

					if var_155_24 + var_155_17 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_24 + var_155_17
					end
				end

				arg_152_1.text_.text = var_155_21
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_18, arg_152_1.talkMaxDuration)

			if var_155_17 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_17) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_17 + var_155_25 and arg_152_1.time_ < var_155_17 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play939021039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 939021039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play939021040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["6148ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos6148ui_story = var_159_0.localPosition

				local var_159_2 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(false)
				end
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(-0.7, -0.985, -6)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos6148ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9

				local var_159_10 = GameObjectTools.GetOrAddComponent(var_159_0.gameObject, typeof(DynamicBoneHelper))

				if var_159_10 then
					var_159_10:EnableDynamicBone(true)
				end
			end

			local var_159_11 = 0

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_159_12 = 0

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_159_13 = 0
			local var_159_14 = 0.575

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_15 = arg_156_1:FormatText(StoryNameCfg[1488].name)

				arg_156_1.leftNameTxt_.text = var_159_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_16 = arg_156_1:GetWordFromCfg(939021039)
				local var_159_17 = arg_156_1:FormatText(var_159_16.content)

				arg_156_1.text_.text = var_159_17

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_18 = 23
				local var_159_19 = utf8.len(var_159_17)
				local var_159_20 = var_159_18 <= 0 and var_159_14 or var_159_14 * (var_159_19 / var_159_18)

				if var_159_20 > 0 and var_159_14 < var_159_20 then
					arg_156_1.talkMaxDuration = var_159_20

					if var_159_20 + var_159_13 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_13
					end
				end

				arg_156_1.text_.text = var_159_17
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_21 = math.max(var_159_14, arg_156_1.talkMaxDuration)

			if var_159_13 <= arg_156_1.time_ and arg_156_1.time_ < var_159_13 + var_159_21 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_13) / var_159_21

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_13 + var_159_21 and arg_156_1.time_ < var_159_13 + var_159_21 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play939021040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 939021040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1054ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1054ui_story = var_163_0.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Vector3.New(0.7, -0.985, -6)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1054ui_story, var_163_5, var_163_4)

				local var_163_6 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_6.x, var_163_6.y, var_163_6.z)

				local var_163_7 = var_163_0.localEulerAngles

				var_163_7.z = 0
				var_163_7.x = 0
				var_163_0.localEulerAngles = var_163_7
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_163_8 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_8.x, var_163_8.y, var_163_8.z)

				local var_163_9 = var_163_0.localEulerAngles

				var_163_9.z = 0
				var_163_9.x = 0
				var_163_0.localEulerAngles = var_163_9

				local var_163_10 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_10 then
					var_163_10:EnableDynamicBone(true)
				end
			end

			local var_163_11 = arg_160_1.actors_["1054ui_story"]
			local var_163_12 = 0

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect1054ui_story == nil then
				arg_160_1.var_.characterEffect1054ui_story = var_163_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_13 = 0.200000002980232

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_13 and not isNil(var_163_11) then
				local var_163_14 = (arg_160_1.time_ - var_163_12) / var_163_13

				if arg_160_1.var_.characterEffect1054ui_story and not isNil(var_163_11) then
					arg_160_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_12 + var_163_13 and arg_160_1.time_ < var_163_12 + var_163_13 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect1054ui_story then
				arg_160_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_163_15 = arg_160_1.actors_["6148ui_story"]
			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect6148ui_story == nil then
				arg_160_1.var_.characterEffect6148ui_story = var_163_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_17 = 0.200000002980232

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 and not isNil(var_163_15) then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17

				if arg_160_1.var_.characterEffect6148ui_story and not isNil(var_163_15) then
					local var_163_19 = Mathf.Lerp(0, 0.5, var_163_18)

					arg_160_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_160_1.var_.characterEffect6148ui_story.fillRatio = var_163_19
				end
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect6148ui_story then
				local var_163_20 = 0.5

				arg_160_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_160_1.var_.characterEffect6148ui_story.fillRatio = var_163_20
			end

			local var_163_21 = 0

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action454")
			end

			local var_163_22 = 0

			if var_163_22 < arg_160_1.time_ and arg_160_1.time_ <= var_163_22 + arg_163_0 then
				arg_160_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_163_23 = 0
			local var_163_24 = 0.375

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_25 = arg_160_1:FormatText(StoryNameCfg[1487].name)

				arg_160_1.leftNameTxt_.text = var_163_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_26 = arg_160_1:GetWordFromCfg(939021040)
				local var_163_27 = arg_160_1:FormatText(var_163_26.content)

				arg_160_1.text_.text = var_163_27

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_28 = 15
				local var_163_29 = utf8.len(var_163_27)
				local var_163_30 = var_163_28 <= 0 and var_163_24 or var_163_24 * (var_163_29 / var_163_28)

				if var_163_30 > 0 and var_163_24 < var_163_30 then
					arg_160_1.talkMaxDuration = var_163_30

					if var_163_30 + var_163_23 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_30 + var_163_23
					end
				end

				arg_160_1.text_.text = var_163_27
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_31 = math.max(var_163_24, arg_160_1.talkMaxDuration)

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_31 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_23) / var_163_31

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_23 + var_163_31 and arg_160_1.time_ < var_163_23 + var_163_31 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST15a"
	},
	voices = {},
	skipMarkers = {
		939021001
	}
}
