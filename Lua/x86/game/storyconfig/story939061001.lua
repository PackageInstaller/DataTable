return {
	Play939061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939061002(arg_1_1)
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

			local var_4_24 = 0
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 2
			local var_4_31 = 5

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "1"

				arg_1_1.marker = "21321112121"

				if not arg_1_1.actionList["1"] then
					arg_1_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 106,
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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939061002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939061002
		arg_6_1.duration_ = 9

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939061003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "ST12"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 2.00000000298023

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.ST12

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
					if iter_9_0 ~= "ST12" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 4.00000000298023

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

				var_9_21.a = Mathf.Lerp(0, 1, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)

				var_9_22.a = 1
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_23 = 2

			if var_9_23 < arg_6_1.time_ and arg_6_1.time_ <= var_9_23 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_24 = 2

			if var_9_23 <= arg_6_1.time_ and arg_6_1.time_ < var_9_23 + var_9_24 then
				local var_9_25 = (arg_6_1.time_ - var_9_23) / var_9_24
				local var_9_26 = Color.New(0, 0, 0)

				var_9_26.a = Mathf.Lerp(1, 0, var_9_25)
				arg_6_1.mask_.color = var_9_26
			end

			if arg_6_1.time_ >= var_9_23 + var_9_24 and arg_6_1.time_ < var_9_23 + var_9_24 + arg_9_0 then
				local var_9_27 = Color.New(0, 0, 0)
				local var_9_28 = 0

				arg_6_1.mask_.enabled = false
				var_9_27.a = var_9_28
				arg_6_1.mask_.color = var_9_27
			end

			local var_9_29 = "1248ui_story"

			if arg_6_1.actors_[var_9_29] == nil then
				local var_9_30 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_9_30) then
					local var_9_31 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_6_1.stage_.transform)

					var_9_31.name = var_9_29
					var_9_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_6_1.actors_[var_9_29] = var_9_31

					local var_9_32 = var_9_31:GetComponentInChildren(typeof(CharacterEffect))

					var_9_32.enabled = true

					local var_9_33 = GameObjectTools.GetOrAddComponent(var_9_31, typeof(DynamicBoneHelper))

					if var_9_33 then
						var_9_33:EnableDynamicBone(false)
					end

					arg_6_1:ShowWeapon(var_9_32.transform, false)

					arg_6_1.var_[var_9_29 .. "Animator"] = var_9_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_6_1.var_[var_9_29 .. "Animator"].applyRootMotion = true
					arg_6_1.var_[var_9_29 .. "LipSync"] = var_9_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_9_34 = arg_6_1.actors_["1248ui_story"].transform
			local var_9_35 = 3.8

			if var_9_35 < arg_6_1.time_ and arg_6_1.time_ <= var_9_35 + arg_9_0 then
				arg_6_1.var_.moveOldPos1248ui_story = var_9_34.localPosition
			end

			local var_9_36 = 0.001

			if var_9_35 <= arg_6_1.time_ and arg_6_1.time_ < var_9_35 + var_9_36 then
				local var_9_37 = (arg_6_1.time_ - var_9_35) / var_9_36
				local var_9_38 = Vector3.New(0, -0.775, -6.18)

				var_9_34.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1248ui_story, var_9_38, var_9_37)

				local var_9_39 = manager.ui.mainCamera.transform.position - var_9_34.position

				var_9_34.forward = Vector3.New(var_9_39.x, var_9_39.y, var_9_39.z)

				local var_9_40 = var_9_34.localEulerAngles

				var_9_40.z = 0
				var_9_40.x = 0
				var_9_34.localEulerAngles = var_9_40
			end

			if arg_6_1.time_ >= var_9_35 + var_9_36 and arg_6_1.time_ < var_9_35 + var_9_36 + arg_9_0 then
				var_9_34.localPosition = Vector3.New(0, -0.775, -6.18)

				local var_9_41 = manager.ui.mainCamera.transform.position - var_9_34.position

				var_9_34.forward = Vector3.New(var_9_41.x, var_9_41.y, var_9_41.z)

				local var_9_42 = var_9_34.localEulerAngles

				var_9_42.z = 0
				var_9_42.x = 0
				var_9_34.localEulerAngles = var_9_42
			end

			local var_9_43 = arg_6_1.actors_["1248ui_story"]
			local var_9_44 = 3.8

			if var_9_44 < arg_6_1.time_ and arg_6_1.time_ <= var_9_44 + arg_9_0 and not isNil(var_9_43) and arg_6_1.var_.characterEffect1248ui_story == nil then
				arg_6_1.var_.characterEffect1248ui_story = var_9_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_45 = 0.200000002980232

			if var_9_44 <= arg_6_1.time_ and arg_6_1.time_ < var_9_44 + var_9_45 and not isNil(var_9_43) then
				local var_9_46 = (arg_6_1.time_ - var_9_44) / var_9_45

				if arg_6_1.var_.characterEffect1248ui_story and not isNil(var_9_43) then
					arg_6_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= var_9_44 + var_9_45 and arg_6_1.time_ < var_9_44 + var_9_45 + arg_9_0 and not isNil(var_9_43) and arg_6_1.var_.characterEffect1248ui_story then
				arg_6_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_9_47 = 3.8

			if var_9_47 < arg_6_1.time_ and arg_6_1.time_ <= var_9_47 + arg_9_0 then
				arg_6_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action1_1")
			end

			local var_9_48 = 3.8

			if var_9_48 < arg_6_1.time_ and arg_6_1.time_ <= var_9_48 + arg_9_0 then
				arg_6_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_49 = 4.00000000298023
			local var_9_50 = 0.35

			if var_9_49 < arg_6_1.time_ and arg_6_1.time_ <= var_9_49 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_51 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_51:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_52 = arg_6_1:FormatText(StoryNameCfg[8].name)

				arg_6_1.leftNameTxt_.text = var_9_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_53 = arg_6_1:GetWordFromCfg(939061002)
				local var_9_54 = arg_6_1:FormatText(var_9_53.content)

				arg_6_1.text_.text = var_9_54

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_55 = 14
				local var_9_56 = utf8.len(var_9_54)
				local var_9_57 = var_9_55 <= 0 and var_9_50 or var_9_50 * (var_9_56 / var_9_55)

				if var_9_57 > 0 and var_9_50 < var_9_57 then
					arg_6_1.talkMaxDuration = var_9_57
					var_9_49 = var_9_49 + 0.3

					if var_9_57 + var_9_49 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_57 + var_9_49
					end
				end

				arg_6_1.text_.text = var_9_54
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_58 = var_9_49 + 0.3
			local var_9_59 = math.max(var_9_50, arg_6_1.talkMaxDuration)

			if var_9_58 <= arg_6_1.time_ and arg_6_1.time_ < var_9_58 + var_9_59 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_58) / var_9_59

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_58 + var_9_59 and arg_6_1.time_ < var_9_58 + var_9_59 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play939061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939061003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1248ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1248ui_story == nil then
				arg_12_1.var_.characterEffect1248ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1248ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1248ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1248ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1248ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.475

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

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

				local var_15_9 = arg_12_1:GetWordFromCfg(939061003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 19
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play939061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1248ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1248ui_story == nil then
				arg_16_1.var_.characterEffect1248ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1248ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1248ui_story then
				arg_16_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_1")
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.575

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[8].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(939061004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 23
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play939061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939061005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1248ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1248ui_story == nil then
				arg_20_1.var_.characterEffect1248ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1248ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1248ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1248ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1248ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.85

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(939061005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 34
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_7 or var_23_7 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_7 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_13 and arg_20_1.time_ < var_23_6 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play939061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1248ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1248ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, -0.775, -6.18)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1248ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, -0.775, -6.18)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1248ui_story"]
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1248ui_story == nil then
				arg_24_1.var_.characterEffect1248ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_11 = 0.200000002980232

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 and not isNil(var_27_9) then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11

				if arg_24_1.var_.characterEffect1248ui_story and not isNil(var_27_9) then
					arg_24_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1248ui_story then
				arg_24_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_27_13 = 0

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 then
				arg_24_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_2")
			end

			local var_27_14 = 0

			if var_27_14 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_15 = 0
			local var_27_16 = 1.1

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_17 = arg_24_1:FormatText(StoryNameCfg[8].name)

				arg_24_1.leftNameTxt_.text = var_27_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_18 = arg_24_1:GetWordFromCfg(939061006)
				local var_27_19 = arg_24_1:FormatText(var_27_18.content)

				arg_24_1.text_.text = var_27_19

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_20 = 44
				local var_27_21 = utf8.len(var_27_19)
				local var_27_22 = var_27_20 <= 0 and var_27_16 or var_27_16 * (var_27_21 / var_27_20)

				if var_27_22 > 0 and var_27_16 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22

					if var_27_22 + var_27_15 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_15
					end
				end

				arg_24_1.text_.text = var_27_19
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_23 = math.max(var_27_16, arg_24_1.talkMaxDuration)

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_23 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_23

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_23 and arg_24_1.time_ < var_27_15 + var_27_23 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
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
	Play939061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1248ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1248ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0, -0.775, -6.18)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1248ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -0.775, -6.18)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_1")
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_31_11 = 0
			local var_31_12 = 1.2

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[8].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(939061007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 48
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_19 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_19 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_19

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_19 and arg_28_1.time_ < var_31_11 + var_31_19 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play939061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939061008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1284ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1284ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1284ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0.7, -0.985, -6.22)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1284ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["1248ui_story"].transform
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.var_.moveOldPos1248ui_story = var_35_14.localPosition
			end

			local var_35_16 = 0.001

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16
				local var_35_18 = Vector3.New(-0.7, -0.775, -6.18)

				var_35_14.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1248ui_story, var_35_18, var_35_17)

				local var_35_19 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_19.x, var_35_19.y, var_35_19.z)

				local var_35_20 = var_35_14.localEulerAngles

				var_35_20.z = 0
				var_35_20.x = 0
				var_35_14.localEulerAngles = var_35_20
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 then
				var_35_14.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_35_21 = manager.ui.mainCamera.transform.position - var_35_14.position

				var_35_14.forward = Vector3.New(var_35_21.x, var_35_21.y, var_35_21.z)

				local var_35_22 = var_35_14.localEulerAngles

				var_35_22.z = 0
				var_35_22.x = 0
				var_35_14.localEulerAngles = var_35_22
			end

			local var_35_23 = arg_32_1.actors_["1284ui_story"]
			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 and not isNil(var_35_23) and arg_32_1.var_.characterEffect1284ui_story == nil then
				arg_32_1.var_.characterEffect1284ui_story = var_35_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_25 = 0.200000002980232

			if var_35_24 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_25 and not isNil(var_35_23) then
				local var_35_26 = (arg_32_1.time_ - var_35_24) / var_35_25

				if arg_32_1.var_.characterEffect1284ui_story and not isNil(var_35_23) then
					arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_24 + var_35_25 and arg_32_1.time_ < var_35_24 + var_35_25 + arg_35_0 and not isNil(var_35_23) and arg_32_1.var_.characterEffect1284ui_story then
				arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_35_27 = arg_32_1.actors_["1248ui_story"]
			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 and not isNil(var_35_27) and arg_32_1.var_.characterEffect1248ui_story == nil then
				arg_32_1.var_.characterEffect1248ui_story = var_35_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_29 = 0.200000002980232

			if var_35_28 <= arg_32_1.time_ and arg_32_1.time_ < var_35_28 + var_35_29 and not isNil(var_35_27) then
				local var_35_30 = (arg_32_1.time_ - var_35_28) / var_35_29

				if arg_32_1.var_.characterEffect1248ui_story and not isNil(var_35_27) then
					local var_35_31 = Mathf.Lerp(0, 0.5, var_35_30)

					arg_32_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1248ui_story.fillRatio = var_35_31
				end
			end

			if arg_32_1.time_ >= var_35_28 + var_35_29 and arg_32_1.time_ < var_35_28 + var_35_29 + arg_35_0 and not isNil(var_35_27) and arg_32_1.var_.characterEffect1248ui_story then
				local var_35_32 = 0.5

				arg_32_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1248ui_story.fillRatio = var_35_32
			end

			local var_35_33 = 0

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_35_34 = 0

			if var_35_34 < arg_32_1.time_ and arg_32_1.time_ <= var_35_34 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_35 = 0
			local var_35_36 = 0.575

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_37 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_38 = arg_32_1:GetWordFromCfg(939061008)
				local var_35_39 = arg_32_1:FormatText(var_35_38.content)

				arg_32_1.text_.text = var_35_39

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_40 = 23
				local var_35_41 = utf8.len(var_35_39)
				local var_35_42 = var_35_40 <= 0 and var_35_36 or var_35_36 * (var_35_41 / var_35_40)

				if var_35_42 > 0 and var_35_36 < var_35_42 then
					arg_32_1.talkMaxDuration = var_35_42

					if var_35_42 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_42 + var_35_35
					end
				end

				arg_32_1.text_.text = var_35_39
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_43 = math.max(var_35_36, arg_32_1.talkMaxDuration)

			if var_35_35 <= arg_32_1.time_ and arg_32_1.time_ < var_35_35 + var_35_43 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_35) / var_35_43

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_35 + var_35_43 and arg_32_1.time_ < var_35_35 + var_35_43 + arg_35_0 then
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
				actorName = "1248ui_story",
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
	Play939061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 939061009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play939061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1284ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1284ui_story == nil then
				arg_36_1.var_.characterEffect1284ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1284ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1284ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1284ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1284ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_2")
			end

			local var_39_7 = 0
			local var_39_8 = 0.7

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_9 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_9

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

				local var_39_10 = arg_36_1:GetWordFromCfg(939061009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_12 = 28
				local var_39_13 = utf8.len(var_39_11)
				local var_39_14 = var_39_12 <= 0 and var_39_8 or var_39_8 * (var_39_13 / var_39_12)

				if var_39_14 > 0 and var_39_8 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14

					if var_39_14 + var_39_7 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_7
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_7) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_7 + var_39_15 and arg_36_1.time_ < var_39_7 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play939061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 939061010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play939061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1284ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1284ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0.7, -0.985, -6.22)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1284ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["1284ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1284ui_story == nil then
				arg_40_1.var_.characterEffect1284ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1284ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1284ui_story then
				arg_40_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_15 = 0
			local var_43_16 = 1

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(939061010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 40
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_23 and arg_40_1.time_ < var_43_15 + var_43_23 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play939061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 939061011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play939061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1054ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1054ui_story"].transform
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = var_47_5.localPosition

				local var_47_7 = GameObjectTools.GetOrAddComponent(var_47_5.gameObject, typeof(DynamicBoneHelper))

				if var_47_7 then
					var_47_7:EnableDynamicBone(false)
				end
			end

			local var_47_8 = 0.001

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_8 then
				local var_47_9 = (arg_44_1.time_ - var_47_6) / var_47_8
				local var_47_10 = Vector3.New(-0.7, -0.985, -6)

				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, var_47_10, var_47_9)

				local var_47_11 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_11.x, var_47_11.y, var_47_11.z)

				local var_47_12 = var_47_5.localEulerAngles

				var_47_12.z = 0
				var_47_12.x = 0
				var_47_5.localEulerAngles = var_47_12
			end

			if arg_44_1.time_ >= var_47_6 + var_47_8 and arg_44_1.time_ < var_47_6 + var_47_8 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_47_13 = manager.ui.mainCamera.transform.position - var_47_5.position

				var_47_5.forward = Vector3.New(var_47_13.x, var_47_13.y, var_47_13.z)

				local var_47_14 = var_47_5.localEulerAngles

				var_47_14.z = 0
				var_47_14.x = 0
				var_47_5.localEulerAngles = var_47_14

				local var_47_15 = GameObjectTools.GetOrAddComponent(var_47_5.gameObject, typeof(DynamicBoneHelper))

				if var_47_15 then
					var_47_15:EnableDynamicBone(true)
				end
			end

			local var_47_16 = arg_44_1.actors_["1248ui_story"].transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.moveOldPos1248ui_story = var_47_16.localPosition
			end

			local var_47_18 = 0.001

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_18 then
				local var_47_19 = (arg_44_1.time_ - var_47_17) / var_47_18
				local var_47_20 = Vector3.New(0, 100, 0)

				var_47_16.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1248ui_story, var_47_20, var_47_19)

				local var_47_21 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_21.x, var_47_21.y, var_47_21.z)

				local var_47_22 = var_47_16.localEulerAngles

				var_47_22.z = 0
				var_47_22.x = 0
				var_47_16.localEulerAngles = var_47_22
			end

			if arg_44_1.time_ >= var_47_17 + var_47_18 and arg_44_1.time_ < var_47_17 + var_47_18 + arg_47_0 then
				var_47_16.localPosition = Vector3.New(0, 100, 0)

				local var_47_23 = manager.ui.mainCamera.transform.position - var_47_16.position

				var_47_16.forward = Vector3.New(var_47_23.x, var_47_23.y, var_47_23.z)

				local var_47_24 = var_47_16.localEulerAngles

				var_47_24.z = 0
				var_47_24.x = 0
				var_47_16.localEulerAngles = var_47_24
			end

			local var_47_25 = arg_44_1.actors_["1054ui_story"]
			local var_47_26 = 0

			if var_47_26 < arg_44_1.time_ and arg_44_1.time_ <= var_47_26 + arg_47_0 and not isNil(var_47_25) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_27 = 0.200000002980232

			if var_47_26 <= arg_44_1.time_ and arg_44_1.time_ < var_47_26 + var_47_27 and not isNil(var_47_25) then
				local var_47_28 = (arg_44_1.time_ - var_47_26) / var_47_27

				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_25) then
					arg_44_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_26 + var_47_27 and arg_44_1.time_ < var_47_26 + var_47_27 + arg_47_0 and not isNil(var_47_25) and arg_44_1.var_.characterEffect1054ui_story then
				arg_44_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_47_29 = arg_44_1.actors_["1284ui_story"]
			local var_47_30 = 0

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 and not isNil(var_47_29) and arg_44_1.var_.characterEffect1284ui_story == nil then
				arg_44_1.var_.characterEffect1284ui_story = var_47_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_31 = 0.200000002980232

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_31 and not isNil(var_47_29) then
				local var_47_32 = (arg_44_1.time_ - var_47_30) / var_47_31

				if arg_44_1.var_.characterEffect1284ui_story and not isNil(var_47_29) then
					local var_47_33 = Mathf.Lerp(0, 0.5, var_47_32)

					arg_44_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1284ui_story.fillRatio = var_47_33
				end
			end

			if arg_44_1.time_ >= var_47_30 + var_47_31 and arg_44_1.time_ < var_47_30 + var_47_31 + arg_47_0 and not isNil(var_47_29) and arg_44_1.var_.characterEffect1284ui_story then
				local var_47_34 = 0.5

				arg_44_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1284ui_story.fillRatio = var_47_34
			end

			local var_47_35 = 0

			if var_47_35 < arg_44_1.time_ and arg_44_1.time_ <= var_47_35 + arg_47_0 then
				arg_44_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_47_36 = 0

			if var_47_36 < arg_44_1.time_ and arg_44_1.time_ <= var_47_36 + arg_47_0 then
				arg_44_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_47_37 = 0
			local var_47_38 = 1

			if var_47_37 < arg_44_1.time_ and arg_44_1.time_ <= var_47_37 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_39 = arg_44_1:FormatText(StoryNameCfg[1487].name)

				arg_44_1.leftNameTxt_.text = var_47_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_40 = arg_44_1:GetWordFromCfg(939061011)
				local var_47_41 = arg_44_1:FormatText(var_47_40.content)

				arg_44_1.text_.text = var_47_41

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_42 = 40
				local var_47_43 = utf8.len(var_47_41)
				local var_47_44 = var_47_42 <= 0 and var_47_38 or var_47_38 * (var_47_43 / var_47_42)

				if var_47_44 > 0 and var_47_38 < var_47_44 then
					arg_44_1.talkMaxDuration = var_47_44

					if var_47_44 + var_47_37 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_44 + var_47_37
					end
				end

				arg_44_1.text_.text = var_47_41
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_45 = math.max(var_47_38, arg_44_1.talkMaxDuration)

			if var_47_37 <= arg_44_1.time_ and arg_44_1.time_ < var_47_37 + var_47_45 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_37) / var_47_45

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_37 + var_47_45 and arg_44_1.time_ < var_47_37 + var_47_45 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
				actorName = "1248ui_story",
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
	Play939061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 939061012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play939061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "6148ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["6148ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = var_51_5.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_6) / var_51_8
				local var_51_10 = Vector3.New(0.7, -0.985, -6)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_5.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_5.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_6 + var_51_8 and arg_48_1.time_ < var_51_6 + var_51_8 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_5.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_5.localEulerAngles = var_51_14

				local var_51_15 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_15 then
					var_51_15:EnableDynamicBone(true)
				end
			end

			local var_51_16 = arg_48_1.actors_["6148ui_story"]
			local var_51_17 = 0

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect6148ui_story == nil then
				arg_48_1.var_.characterEffect6148ui_story = var_51_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_18 = 0.200000002980232

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_18 and not isNil(var_51_16) then
				local var_51_19 = (arg_48_1.time_ - var_51_17) / var_51_18

				if arg_48_1.var_.characterEffect6148ui_story and not isNil(var_51_16) then
					arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_17 + var_51_18 and arg_48_1.time_ < var_51_17 + var_51_18 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect6148ui_story then
				arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_51_20 = arg_48_1.actors_["1054ui_story"]
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 and not isNil(var_51_20) and arg_48_1.var_.characterEffect1054ui_story == nil then
				arg_48_1.var_.characterEffect1054ui_story = var_51_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_22 = 0.200000002980232

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 and not isNil(var_51_20) then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22

				if arg_48_1.var_.characterEffect1054ui_story and not isNil(var_51_20) then
					local var_51_24 = Mathf.Lerp(0, 0.5, var_51_23)

					arg_48_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1054ui_story.fillRatio = var_51_24
				end
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 and not isNil(var_51_20) and arg_48_1.var_.characterEffect1054ui_story then
				local var_51_25 = 0.5

				arg_48_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1054ui_story.fillRatio = var_51_25
			end

			local var_51_26 = 0

			if var_51_26 < arg_48_1.time_ and arg_48_1.time_ <= var_51_26 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_51_27 = 0

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_28 = arg_48_1.actors_["1284ui_story"].transform
			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1.var_.moveOldPos1284ui_story = var_51_28.localPosition
			end

			local var_51_30 = 0.001

			if var_51_29 <= arg_48_1.time_ and arg_48_1.time_ < var_51_29 + var_51_30 then
				local var_51_31 = (arg_48_1.time_ - var_51_29) / var_51_30
				local var_51_32 = Vector3.New(0, 100, 0)

				var_51_28.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1284ui_story, var_51_32, var_51_31)

				local var_51_33 = manager.ui.mainCamera.transform.position - var_51_28.position

				var_51_28.forward = Vector3.New(var_51_33.x, var_51_33.y, var_51_33.z)

				local var_51_34 = var_51_28.localEulerAngles

				var_51_34.z = 0
				var_51_34.x = 0
				var_51_28.localEulerAngles = var_51_34
			end

			if arg_48_1.time_ >= var_51_29 + var_51_30 and arg_48_1.time_ < var_51_29 + var_51_30 + arg_51_0 then
				var_51_28.localPosition = Vector3.New(0, 100, 0)

				local var_51_35 = manager.ui.mainCamera.transform.position - var_51_28.position

				var_51_28.forward = Vector3.New(var_51_35.x, var_51_35.y, var_51_35.z)

				local var_51_36 = var_51_28.localEulerAngles

				var_51_36.z = 0
				var_51_36.x = 0
				var_51_28.localEulerAngles = var_51_36
			end

			local var_51_37 = 0
			local var_51_38 = 1.175

			if var_51_37 < arg_48_1.time_ and arg_48_1.time_ <= var_51_37 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_39 = arg_48_1:FormatText(StoryNameCfg[1488].name)

				arg_48_1.leftNameTxt_.text = var_51_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_40 = arg_48_1:GetWordFromCfg(939061012)
				local var_51_41 = arg_48_1:FormatText(var_51_40.content)

				arg_48_1.text_.text = var_51_41

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_42 = 47
				local var_51_43 = utf8.len(var_51_41)
				local var_51_44 = var_51_42 <= 0 and var_51_38 or var_51_38 * (var_51_43 / var_51_42)

				if var_51_44 > 0 and var_51_38 < var_51_44 then
					arg_48_1.talkMaxDuration = var_51_44

					if var_51_44 + var_51_37 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_44 + var_51_37
					end
				end

				arg_48_1.text_.text = var_51_41
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_45 = math.max(var_51_38, arg_48_1.talkMaxDuration)

			if var_51_37 <= arg_48_1.time_ and arg_48_1.time_ < var_51_37 + var_51_45 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_37) / var_51_45

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_37 + var_51_45 and arg_48_1.time_ < var_51_37 + var_51_45 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play939061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 939061013
		arg_52_1.duration_ = 1

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"

			SetActive(arg_52_1.choicesGo_, true)

			for iter_53_0, iter_53_1 in ipairs(arg_52_1.choices_) do
				local var_53_0 = iter_53_0 <= 1

				SetActive(iter_53_1.go, var_53_0)
			end

			arg_52_1.choices_[1].txt.text = arg_52_1:FormatText(StoryChoiceCfg[1680].name)
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play939061014(arg_52_1)
			end

			arg_52_1:RecordChoiceLog(939061013, 1680)
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["6148ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect6148ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_7 = 1

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play939061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 939061014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play939061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.55

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

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

				local var_59_3 = arg_56_1:GetWordFromCfg(939061014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 22
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play939061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 939061015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play939061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1054ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(-0.7, -0.985, -6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1054ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_63_8 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_8.x, var_63_8.y, var_63_8.z)

				local var_63_9 = var_63_0.localEulerAngles

				var_63_9.z = 0
				var_63_9.x = 0
				var_63_0.localEulerAngles = var_63_9

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = arg_60_1.actors_["1054ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.200000002980232

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_63_17 = 0
			local var_63_18 = 0.15

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_19 = arg_60_1:FormatText(StoryNameCfg[1487].name)

				arg_60_1.leftNameTxt_.text = var_63_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_20 = arg_60_1:GetWordFromCfg(939061015)
				local var_63_21 = arg_60_1:FormatText(var_63_20.content)

				arg_60_1.text_.text = var_63_21

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_22 = 6
				local var_63_23 = utf8.len(var_63_21)
				local var_63_24 = var_63_22 <= 0 and var_63_18 or var_63_18 * (var_63_23 / var_63_22)

				if var_63_24 > 0 and var_63_18 < var_63_24 then
					arg_60_1.talkMaxDuration = var_63_24

					if var_63_24 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_17
					end
				end

				arg_60_1.text_.text = var_63_21
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_17) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_17 + var_63_25 and arg_60_1.time_ < var_63_17 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play939061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 939061016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play939061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1054ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1054ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 1.225

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(939061016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 49
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play939061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 939061017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play939061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.325

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_2

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

				local var_71_3 = arg_68_1:GetWordFromCfg(939061017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 53
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play939061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 939061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play939061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1284ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1284ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0.7, -0.985, -6.22)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1284ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["6148ui_story"].transform
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = var_75_9.localPosition

				local var_75_11 = GameObjectTools.GetOrAddComponent(var_75_9.gameObject, typeof(DynamicBoneHelper))

				if var_75_11 then
					var_75_11:EnableDynamicBone(false)
				end
			end

			local var_75_12 = 0.001

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_10) / var_75_12
				local var_75_14 = Vector3.New(0, 100, 0)

				var_75_9.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, var_75_14, var_75_13)

				local var_75_15 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_15.x, var_75_15.y, var_75_15.z)

				local var_75_16 = var_75_9.localEulerAngles

				var_75_16.z = 0
				var_75_16.x = 0
				var_75_9.localEulerAngles = var_75_16
			end

			if arg_72_1.time_ >= var_75_10 + var_75_12 and arg_72_1.time_ < var_75_10 + var_75_12 + arg_75_0 then
				var_75_9.localPosition = Vector3.New(0, 100, 0)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_9.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_9.localEulerAngles = var_75_18

				local var_75_19 = GameObjectTools.GetOrAddComponent(var_75_9.gameObject, typeof(DynamicBoneHelper))

				if var_75_19 then
					var_75_19:EnableDynamicBone(true)
				end
			end

			local var_75_20 = arg_72_1.actors_["1284ui_story"]
			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1284ui_story == nil then
				arg_72_1.var_.characterEffect1284ui_story = var_75_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_22 = 0.200000002980232

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 and not isNil(var_75_20) then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22

				if arg_72_1.var_.characterEffect1284ui_story and not isNil(var_75_20) then
					arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1284ui_story then
				arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_75_24 = 0

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_75_25 = 0

			if var_75_25 < arg_72_1.time_ and arg_72_1.time_ <= var_75_25 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_26 = 0
			local var_75_27 = 0.8

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_28 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_29 = arg_72_1:GetWordFromCfg(939061018)
				local var_75_30 = arg_72_1:FormatText(var_75_29.content)

				arg_72_1.text_.text = var_75_30

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_31 = 32
				local var_75_32 = utf8.len(var_75_30)
				local var_75_33 = var_75_31 <= 0 and var_75_27 or var_75_27 * (var_75_32 / var_75_31)

				if var_75_33 > 0 and var_75_27 < var_75_33 then
					arg_72_1.talkMaxDuration = var_75_33

					if var_75_33 + var_75_26 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_33 + var_75_26
					end
				end

				arg_72_1.text_.text = var_75_30
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_34 = math.max(var_75_27, arg_72_1.talkMaxDuration)

			if var_75_26 <= arg_72_1.time_ and arg_72_1.time_ < var_75_26 + var_75_34 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_26) / var_75_34

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_26 + var_75_34 and arg_72_1.time_ < var_75_26 + var_75_34 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play939061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939061019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "1211ui_story"

			if arg_76_1.actors_[var_79_0] == nil then
				local var_79_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_79_1) then
					local var_79_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_76_1.stage_.transform)

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

			local var_79_5 = arg_76_1.actors_["1211ui_story"].transform
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.var_.moveOldPos1211ui_story = var_79_5.localPosition
			end

			local var_79_7 = 0.001

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_7 then
				local var_79_8 = (arg_76_1.time_ - var_79_6) / var_79_7
				local var_79_9 = Vector3.New(-0.7, -0.67, -6.07)

				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1211ui_story, var_79_9, var_79_8)

				local var_79_10 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_10.x, var_79_10.y, var_79_10.z)

				local var_79_11 = var_79_5.localEulerAngles

				var_79_11.z = 0
				var_79_11.x = 0
				var_79_5.localEulerAngles = var_79_11
			end

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_79_12 = manager.ui.mainCamera.transform.position - var_79_5.position

				var_79_5.forward = Vector3.New(var_79_12.x, var_79_12.y, var_79_12.z)

				local var_79_13 = var_79_5.localEulerAngles

				var_79_13.z = 0
				var_79_13.x = 0
				var_79_5.localEulerAngles = var_79_13
			end

			local var_79_14 = arg_76_1.actors_["1054ui_story"].transform
			local var_79_15 = 0

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.var_.moveOldPos1054ui_story = var_79_14.localPosition

				local var_79_16 = GameObjectTools.GetOrAddComponent(var_79_14.gameObject, typeof(DynamicBoneHelper))

				if var_79_16 then
					var_79_16:EnableDynamicBone(false)
				end
			end

			local var_79_17 = 0.001

			if var_79_15 <= arg_76_1.time_ and arg_76_1.time_ < var_79_15 + var_79_17 then
				local var_79_18 = (arg_76_1.time_ - var_79_15) / var_79_17
				local var_79_19 = Vector3.New(0, 100, 0)

				var_79_14.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1054ui_story, var_79_19, var_79_18)

				local var_79_20 = manager.ui.mainCamera.transform.position - var_79_14.position

				var_79_14.forward = Vector3.New(var_79_20.x, var_79_20.y, var_79_20.z)

				local var_79_21 = var_79_14.localEulerAngles

				var_79_21.z = 0
				var_79_21.x = 0
				var_79_14.localEulerAngles = var_79_21
			end

			if arg_76_1.time_ >= var_79_15 + var_79_17 and arg_76_1.time_ < var_79_15 + var_79_17 + arg_79_0 then
				var_79_14.localPosition = Vector3.New(0, 100, 0)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_14.position

				var_79_14.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_14.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_14.localEulerAngles = var_79_23

				local var_79_24 = GameObjectTools.GetOrAddComponent(var_79_14.gameObject, typeof(DynamicBoneHelper))

				if var_79_24 then
					var_79_24:EnableDynamicBone(true)
				end
			end

			local var_79_25 = arg_76_1.actors_["1211ui_story"]
			local var_79_26 = 0

			if var_79_26 < arg_76_1.time_ and arg_76_1.time_ <= var_79_26 + arg_79_0 and not isNil(var_79_25) and arg_76_1.var_.characterEffect1211ui_story == nil then
				arg_76_1.var_.characterEffect1211ui_story = var_79_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_27 = 0.200000002980232

			if var_79_26 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_27 and not isNil(var_79_25) then
				local var_79_28 = (arg_76_1.time_ - var_79_26) / var_79_27

				if arg_76_1.var_.characterEffect1211ui_story and not isNil(var_79_25) then
					arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_26 + var_79_27 and arg_76_1.time_ < var_79_26 + var_79_27 + arg_79_0 and not isNil(var_79_25) and arg_76_1.var_.characterEffect1211ui_story then
				arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_79_29 = arg_76_1.actors_["1284ui_story"]
			local var_79_30 = 0

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 and not isNil(var_79_29) and arg_76_1.var_.characterEffect1284ui_story == nil then
				arg_76_1.var_.characterEffect1284ui_story = var_79_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_31 = 0.200000002980232

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_31 and not isNil(var_79_29) then
				local var_79_32 = (arg_76_1.time_ - var_79_30) / var_79_31

				if arg_76_1.var_.characterEffect1284ui_story and not isNil(var_79_29) then
					local var_79_33 = Mathf.Lerp(0, 0.5, var_79_32)

					arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1284ui_story.fillRatio = var_79_33
				end
			end

			if arg_76_1.time_ >= var_79_30 + var_79_31 and arg_76_1.time_ < var_79_30 + var_79_31 + arg_79_0 and not isNil(var_79_29) and arg_76_1.var_.characterEffect1284ui_story then
				local var_79_34 = 0.5

				arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1284ui_story.fillRatio = var_79_34
			end

			local var_79_35 = 0

			if var_79_35 < arg_76_1.time_ and arg_76_1.time_ <= var_79_35 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_79_36 = 0

			if var_79_36 < arg_76_1.time_ and arg_76_1.time_ <= var_79_36 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_37 = 0
			local var_79_38 = 0.975

			if var_79_37 < arg_76_1.time_ and arg_76_1.time_ <= var_79_37 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_39 = arg_76_1:FormatText(StoryNameCfg[37].name)

				arg_76_1.leftNameTxt_.text = var_79_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_40 = arg_76_1:GetWordFromCfg(939061019)
				local var_79_41 = arg_76_1:FormatText(var_79_40.content)

				arg_76_1.text_.text = var_79_41

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_42 = 39
				local var_79_43 = utf8.len(var_79_41)
				local var_79_44 = var_79_42 <= 0 and var_79_38 or var_79_38 * (var_79_43 / var_79_42)

				if var_79_44 > 0 and var_79_38 < var_79_44 then
					arg_76_1.talkMaxDuration = var_79_44

					if var_79_44 + var_79_37 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_44 + var_79_37
					end
				end

				arg_76_1.text_.text = var_79_41
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_45 = math.max(var_79_38, arg_76_1.talkMaxDuration)

			if var_79_37 <= arg_76_1.time_ and arg_76_1.time_ < var_79_37 + var_79_45 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_37) / var_79_45

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_37 + var_79_45 and arg_76_1.time_ < var_79_37 + var_79_45 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play939061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939061020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1248ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1248ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0.7, -0.775, -6.18)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1248ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0.7, -0.775, -6.18)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1284ui_story"].transform
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos1284ui_story = var_83_9.localPosition
			end

			local var_83_11 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11
				local var_83_13 = Vector3.New(0, 100, 0)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1284ui_story, var_83_13, var_83_12)

				local var_83_14 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_14.x, var_83_14.y, var_83_14.z)

				local var_83_15 = var_83_9.localEulerAngles

				var_83_15.z = 0
				var_83_15.x = 0
				var_83_9.localEulerAngles = var_83_15
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 then
				var_83_9.localPosition = Vector3.New(0, 100, 0)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_9.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_9.localEulerAngles = var_83_17
			end

			local var_83_18 = arg_80_1.actors_["1248ui_story"]
			local var_83_19 = 0

			if var_83_19 < arg_80_1.time_ and arg_80_1.time_ <= var_83_19 + arg_83_0 and not isNil(var_83_18) and arg_80_1.var_.characterEffect1248ui_story == nil then
				arg_80_1.var_.characterEffect1248ui_story = var_83_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_20 = 0.200000002980232

			if var_83_19 <= arg_80_1.time_ and arg_80_1.time_ < var_83_19 + var_83_20 and not isNil(var_83_18) then
				local var_83_21 = (arg_80_1.time_ - var_83_19) / var_83_20

				if arg_80_1.var_.characterEffect1248ui_story and not isNil(var_83_18) then
					arg_80_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_19 + var_83_20 and arg_80_1.time_ < var_83_19 + var_83_20 + arg_83_0 and not isNil(var_83_18) and arg_80_1.var_.characterEffect1248ui_story then
				arg_80_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_83_22 = arg_80_1.actors_["1211ui_story"]
			local var_83_23 = 0

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect1211ui_story == nil then
				arg_80_1.var_.characterEffect1211ui_story = var_83_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_24 = 0.200000002980232

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 and not isNil(var_83_22) then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24

				if arg_80_1.var_.characterEffect1211ui_story and not isNil(var_83_22) then
					local var_83_26 = Mathf.Lerp(0, 0.5, var_83_25)

					arg_80_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1211ui_story.fillRatio = var_83_26
				end
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect1211ui_story then
				local var_83_27 = 0.5

				arg_80_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1211ui_story.fillRatio = var_83_27
			end

			local var_83_28 = 0

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action3_1")
			end

			local var_83_29 = 0

			if var_83_29 < arg_80_1.time_ and arg_80_1.time_ <= var_83_29 + arg_83_0 then
				arg_80_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_83_30 = 0
			local var_83_31 = 0.675

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_32 = arg_80_1:FormatText(StoryNameCfg[8].name)

				arg_80_1.leftNameTxt_.text = var_83_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_33 = arg_80_1:GetWordFromCfg(939061020)
				local var_83_34 = arg_80_1:FormatText(var_83_33.content)

				arg_80_1.text_.text = var_83_34

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_35 = 27
				local var_83_36 = utf8.len(var_83_34)
				local var_83_37 = var_83_35 <= 0 and var_83_31 or var_83_31 * (var_83_36 / var_83_35)

				if var_83_37 > 0 and var_83_31 < var_83_37 then
					arg_80_1.talkMaxDuration = var_83_37

					if var_83_37 + var_83_30 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_30
					end
				end

				arg_80_1.text_.text = var_83_34
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_38 = math.max(var_83_31, arg_80_1.talkMaxDuration)

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_38 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_30) / var_83_38

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_30 + var_83_38 and arg_80_1.time_ < var_83_30 + var_83_38 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
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
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play939061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939061021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["6148ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos6148ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(-0.7, -0.985, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos6148ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["1211ui_story"].transform
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				arg_84_1.var_.moveOldPos1211ui_story = var_87_11.localPosition
			end

			local var_87_13 = 0.001

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13
				local var_87_15 = Vector3.New(0, 100, 0)

				var_87_11.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1211ui_story, var_87_15, var_87_14)

				local var_87_16 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_16.x, var_87_16.y, var_87_16.z)

				local var_87_17 = var_87_11.localEulerAngles

				var_87_17.z = 0
				var_87_17.x = 0
				var_87_11.localEulerAngles = var_87_17
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 then
				var_87_11.localPosition = Vector3.New(0, 100, 0)

				local var_87_18 = manager.ui.mainCamera.transform.position - var_87_11.position

				var_87_11.forward = Vector3.New(var_87_18.x, var_87_18.y, var_87_18.z)

				local var_87_19 = var_87_11.localEulerAngles

				var_87_19.z = 0
				var_87_19.x = 0
				var_87_11.localEulerAngles = var_87_19
			end

			local var_87_20 = arg_84_1.actors_["6148ui_story"]
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect6148ui_story == nil then
				arg_84_1.var_.characterEffect6148ui_story = var_87_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_22 = 0.200000002980232

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 and not isNil(var_87_20) then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22

				if arg_84_1.var_.characterEffect6148ui_story and not isNil(var_87_20) then
					arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect6148ui_story then
				arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_87_24 = arg_84_1.actors_["1248ui_story"]
			local var_87_25 = 0

			if var_87_25 < arg_84_1.time_ and arg_84_1.time_ <= var_87_25 + arg_87_0 and not isNil(var_87_24) and arg_84_1.var_.characterEffect1248ui_story == nil then
				arg_84_1.var_.characterEffect1248ui_story = var_87_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_26 = 0.200000002980232

			if var_87_25 <= arg_84_1.time_ and arg_84_1.time_ < var_87_25 + var_87_26 and not isNil(var_87_24) then
				local var_87_27 = (arg_84_1.time_ - var_87_25) / var_87_26

				if arg_84_1.var_.characterEffect1248ui_story and not isNil(var_87_24) then
					local var_87_28 = Mathf.Lerp(0, 0.5, var_87_27)

					arg_84_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1248ui_story.fillRatio = var_87_28
				end
			end

			if arg_84_1.time_ >= var_87_25 + var_87_26 and arg_84_1.time_ < var_87_25 + var_87_26 + arg_87_0 and not isNil(var_87_24) and arg_84_1.var_.characterEffect1248ui_story then
				local var_87_29 = 0.5

				arg_84_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1248ui_story.fillRatio = var_87_29
			end

			local var_87_30 = 0

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_87_31 = 0

			if var_87_31 < arg_84_1.time_ and arg_84_1.time_ <= var_87_31 + arg_87_0 then
				arg_84_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_32 = 0
			local var_87_33 = 0.15

			if var_87_32 < arg_84_1.time_ and arg_84_1.time_ <= var_87_32 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_34 = arg_84_1:FormatText(StoryNameCfg[1488].name)

				arg_84_1.leftNameTxt_.text = var_87_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_35 = arg_84_1:GetWordFromCfg(939061021)
				local var_87_36 = arg_84_1:FormatText(var_87_35.content)

				arg_84_1.text_.text = var_87_36

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_37 = 6
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
				actorName = "1211ui_story",
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
	Play939061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939061022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1054ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1054ui_story = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(0.7, -0.985, -6)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1054ui_story, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["1248ui_story"].transform
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.var_.moveOldPos1248ui_story = var_91_11.localPosition
			end

			local var_91_13 = 0.001

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13
				local var_91_15 = Vector3.New(0, 100, 0)

				var_91_11.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1248ui_story, var_91_15, var_91_14)

				local var_91_16 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_16.x, var_91_16.y, var_91_16.z)

				local var_91_17 = var_91_11.localEulerAngles

				var_91_17.z = 0
				var_91_17.x = 0
				var_91_11.localEulerAngles = var_91_17
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 then
				var_91_11.localPosition = Vector3.New(0, 100, 0)

				local var_91_18 = manager.ui.mainCamera.transform.position - var_91_11.position

				var_91_11.forward = Vector3.New(var_91_18.x, var_91_18.y, var_91_18.z)

				local var_91_19 = var_91_11.localEulerAngles

				var_91_19.z = 0
				var_91_19.x = 0
				var_91_11.localEulerAngles = var_91_19
			end

			local var_91_20 = arg_88_1.actors_["1054ui_story"]
			local var_91_21 = 0

			if var_91_21 < arg_88_1.time_ and arg_88_1.time_ <= var_91_21 + arg_91_0 and not isNil(var_91_20) and arg_88_1.var_.characterEffect1054ui_story == nil then
				arg_88_1.var_.characterEffect1054ui_story = var_91_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_22 = 0.200000002980232

			if var_91_21 <= arg_88_1.time_ and arg_88_1.time_ < var_91_21 + var_91_22 and not isNil(var_91_20) then
				local var_91_23 = (arg_88_1.time_ - var_91_21) / var_91_22

				if arg_88_1.var_.characterEffect1054ui_story and not isNil(var_91_20) then
					arg_88_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_21 + var_91_22 and arg_88_1.time_ < var_91_21 + var_91_22 + arg_91_0 and not isNil(var_91_20) and arg_88_1.var_.characterEffect1054ui_story then
				arg_88_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_91_24 = arg_88_1.actors_["6148ui_story"]
			local var_91_25 = 0

			if var_91_25 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 and not isNil(var_91_24) and arg_88_1.var_.characterEffect6148ui_story == nil then
				arg_88_1.var_.characterEffect6148ui_story = var_91_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_26 = 0.200000002980232

			if var_91_25 <= arg_88_1.time_ and arg_88_1.time_ < var_91_25 + var_91_26 and not isNil(var_91_24) then
				local var_91_27 = (arg_88_1.time_ - var_91_25) / var_91_26

				if arg_88_1.var_.characterEffect6148ui_story and not isNil(var_91_24) then
					local var_91_28 = Mathf.Lerp(0, 0.5, var_91_27)

					arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_88_1.var_.characterEffect6148ui_story.fillRatio = var_91_28
				end
			end

			if arg_88_1.time_ >= var_91_25 + var_91_26 and arg_88_1.time_ < var_91_25 + var_91_26 + arg_91_0 and not isNil(var_91_24) and arg_88_1.var_.characterEffect6148ui_story then
				local var_91_29 = 0.5

				arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_88_1.var_.characterEffect6148ui_story.fillRatio = var_91_29
			end

			local var_91_30 = 0

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_91_31 = 0

			if var_91_31 < arg_88_1.time_ and arg_88_1.time_ <= var_91_31 + arg_91_0 then
				arg_88_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_91_32 = 0
			local var_91_33 = 0.15

			if var_91_32 < arg_88_1.time_ and arg_88_1.time_ <= var_91_32 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_34 = arg_88_1:FormatText(StoryNameCfg[1487].name)

				arg_88_1.leftNameTxt_.text = var_91_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_35 = arg_88_1:GetWordFromCfg(939061022)
				local var_91_36 = arg_88_1:FormatText(var_91_35.content)

				arg_88_1.text_.text = var_91_36

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_37 = 6
				local var_91_38 = utf8.len(var_91_36)
				local var_91_39 = var_91_37 <= 0 and var_91_33 or var_91_33 * (var_91_38 / var_91_37)

				if var_91_39 > 0 and var_91_33 < var_91_39 then
					arg_88_1.talkMaxDuration = var_91_39

					if var_91_39 + var_91_32 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_39 + var_91_32
					end
				end

				arg_88_1.text_.text = var_91_36
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_40 = math.max(var_91_33, arg_88_1.talkMaxDuration)

			if var_91_32 <= arg_88_1.time_ and arg_88_1.time_ < var_91_32 + var_91_40 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_32) / var_91_40

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_32 + var_91_40 and arg_88_1.time_ < var_91_32 + var_91_40 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "1248ui_story",
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
	Play939061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939061023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
			arg_92_1.auto_ = false
		end

		function arg_92_1.playNext_(arg_94_0)
			arg_92_1.onStoryFinished_()
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1054ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1054ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1054ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1054ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1054ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.425

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(939061023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 17
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12"
	},
	voices = {},
	skipMarkers = {
		939061001
	}
}
