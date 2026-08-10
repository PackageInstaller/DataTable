return {
	Play939062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I06"

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
				local var_4_5 = arg_1_1.bgs_.I06

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
					if iter_4_0 ~= "I06" then
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

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_30 = 0.5
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(939062001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 40
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939062002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1284ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1284ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1284ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.7, -0.985, -6.22)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1284ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1284ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1284ui_story == nil then
				arg_9_1.var_.characterEffect1284ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1284ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1284ui_story then
				arg_9_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_20 = 0
			local var_12_21 = 0.275

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(939062002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 11
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_28 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_28 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_28

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_28 and arg_9_1.time_ < var_12_20 + var_12_28 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play939062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939062003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1054ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1054ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1054ui_story = var_16_5.localPosition

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0.7, -0.985, -6)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1054ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14

				local var_16_15 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_15 then
					var_16_15:EnableDynamicBone(true)
				end
			end

			local var_16_16 = arg_13_1.actors_["1054ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1054ui_story == nil then
				arg_13_1.var_.characterEffect1054ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.200000002980232

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect1054ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1054ui_story then
				arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_16_20 = arg_13_1.actors_["1284ui_story"]
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 and not isNil(var_16_20) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_22 = 0.200000002980232

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 and not isNil(var_16_20) then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22

				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_20) then
					local var_16_24 = Mathf.Lerp(0, 0.5, var_16_23)

					arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1284ui_story.fillRatio = var_16_24
				end
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 and not isNil(var_16_20) and arg_13_1.var_.characterEffect1284ui_story then
				local var_16_25 = 0.5

				arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1284ui_story.fillRatio = var_16_25
			end

			local var_16_26 = 0

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_16_27 = 0

			if var_16_27 < arg_13_1.time_ and arg_13_1.time_ <= var_16_27 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_16_28 = 0
			local var_16_29 = 0.425

			if var_16_28 < arg_13_1.time_ and arg_13_1.time_ <= var_16_28 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_30 = arg_13_1:FormatText(StoryNameCfg[1487].name)

				arg_13_1.leftNameTxt_.text = var_16_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_31 = arg_13_1:GetWordFromCfg(939062003)
				local var_16_32 = arg_13_1:FormatText(var_16_31.content)

				arg_13_1.text_.text = var_16_32

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_33 = 17
				local var_16_34 = utf8.len(var_16_32)
				local var_16_35 = var_16_33 <= 0 and var_16_29 or var_16_29 * (var_16_34 / var_16_33)

				if var_16_35 > 0 and var_16_29 < var_16_35 then
					arg_13_1.talkMaxDuration = var_16_35

					if var_16_35 + var_16_28 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_35 + var_16_28
					end
				end

				arg_13_1.text_.text = var_16_32
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_36 = math.max(var_16_29, arg_13_1.talkMaxDuration)

			if var_16_28 <= arg_13_1.time_ and arg_13_1.time_ < var_16_28 + var_16_36 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_28) / var_16_36

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_28 + var_16_36 and arg_13_1.time_ < var_16_28 + var_16_36 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play939062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939062004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1054ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1054ui_story = var_20_0.localPosition

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1054ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9

				local var_20_10 = GameObjectTools.GetOrAddComponent(var_20_0.gameObject, typeof(DynamicBoneHelper))

				if var_20_10 then
					var_20_10:EnableDynamicBone(true)
				end
			end

			local var_20_11 = arg_17_1.actors_["1284ui_story"].transform
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_11.localPosition
			end

			local var_20_13 = 0.001

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13
				local var_20_15 = Vector3.New(0, 100, 0)

				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, var_20_15, var_20_14)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_11.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_11.localEulerAngles = var_20_17
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(0, 100, 0)

				local var_20_18 = manager.ui.mainCamera.transform.position - var_20_11.position

				var_20_11.forward = Vector3.New(var_20_18.x, var_20_18.y, var_20_18.z)

				local var_20_19 = var_20_11.localEulerAngles

				var_20_19.z = 0
				var_20_19.x = 0
				var_20_11.localEulerAngles = var_20_19
			end

			local var_20_20 = 0
			local var_20_21 = 1.375

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[8].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_17_1.callingController_:SetSelectedState("calling")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_23 = arg_17_1:GetWordFromCfg(939062004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 55
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_28 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_28 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_28

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_28 and arg_17_1.time_ < var_20_20 + var_20_28 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play939062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939062005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1248ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1248ui_story"]
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1248ui_story == nil then
				arg_21_1.var_.characterEffect1248ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.200000002980232

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 and not isNil(var_24_5) then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7

				if arg_21_1.var_.characterEffect1248ui_story and not isNil(var_24_5) then
					local var_24_9 = Mathf.Lerp(0, 0.5, var_24_8)

					arg_21_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1248ui_story.fillRatio = var_24_9
				end
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1248ui_story then
				local var_24_10 = 0.5

				arg_21_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1248ui_story.fillRatio = var_24_10
			end

			local var_24_11 = 0
			local var_24_12 = 0.95

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_13 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_14 = arg_21_1:GetWordFromCfg(939062005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 38
				local var_24_17 = utf8.len(var_24_15)
				local var_24_18 = var_24_16 <= 0 and var_24_12 or var_24_12 * (var_24_17 / var_24_16)

				if var_24_18 > 0 and var_24_12 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18

					if var_24_18 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_19 and arg_21_1.time_ < var_24_11 + var_24_19 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play939062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939062006
		arg_25_1.duration_ = 6.17

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = manager.ui.mainCamera.transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				local var_28_2 = arg_25_1.var_.effecthainengdaoguang1
				local var_28_3
				local var_28_4 = var_28_0

				if not var_28_2 then
					var_28_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_28_4)
					var_28_2.name = "hainengdaoguang1"
					arg_25_1.var_.effecthainengdaoguang1 = var_28_2
				else
					var_28_2.transform:SetParent(var_28_4)
				end

				var_28_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_28_5 = manager.ui.mainCamera.transform
			local var_28_6 = 2.23333333333333

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				local var_28_7 = arg_25_1.var_.effecthainengdaoguang1

				if var_28_7 then
					Object.Destroy(var_28_7)

					arg_25_1.var_.effecthainengdaoguang1 = nil
				end
			end

			local var_28_8 = manager.ui.mainCamera.transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_8.localPosition
			end

			local var_28_10 = 0.333333333333333

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / 0.066
				local var_28_12, var_28_13 = math.modf(var_28_11)

				var_28_8.localPosition = Vector3.New(var_28_13 * 0.13, var_28_13 * 0.13, var_28_13 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 then
				var_28_8.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			local var_28_15 = 0.766666666666667

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_16 = 1.16666666666667
			local var_28_17 = 0.775

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_18 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_18:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(939062006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 31
				local var_28_22 = utf8.len(var_28_20)
				local var_28_23 = var_28_21 <= 0 and var_28_17 or var_28_17 * (var_28_22 / var_28_21)

				if var_28_23 > 0 and var_28_17 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23
					var_28_16 = var_28_16 + 0.3

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_24 = var_28_16 + 0.3
			local var_28_25 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_24 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_24) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_24 + var_28_25 and arg_25_1.time_ < var_28_24 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play939062007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 939062007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play939062008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1284ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, -0.985, -6.22)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1284ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_34_15 = 0
			local var_34_16 = 0.35

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(939062007)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 14
				local var_34_21 = utf8.len(var_34_19)
				local var_34_22 = var_34_20 <= 0 and var_34_16 or var_34_16 * (var_34_21 / var_34_20)

				if var_34_22 > 0 and var_34_16 < var_34_22 then
					arg_31_1.talkMaxDuration = var_34_22

					if var_34_22 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_19
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_23 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_23 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_23

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_23 and arg_31_1.time_ < var_34_15 + var_34_23 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play939062008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 939062008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play939062009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1284ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1284ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, 100, 0)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1284ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, 100, 0)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1284ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1284ui_story == nil then
				arg_35_1.var_.characterEffect1284ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect1284ui_story and not isNil(var_38_9) then
					local var_38_13 = Mathf.Lerp(0, 0.5, var_38_12)

					arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1284ui_story.fillRatio = var_38_13
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1284ui_story then
				local var_38_14 = 0.5

				arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1284ui_story.fillRatio = var_38_14
			end

			local var_38_15 = 0
			local var_38_16 = 0.4

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[1544].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_18 = arg_35_1:GetWordFromCfg(939062008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 16
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_23 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_23 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_23

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_23 and arg_35_1.time_ < var_38_15 + var_38_23 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play939062009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 939062009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play939062010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.55

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[1544].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(939062009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 22
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play939062010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 939062010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play939062011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "6148ui_story"

			if arg_43_1.actors_[var_46_0] == nil then
				local var_46_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_46_1) then
					local var_46_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_43_1.stage_.transform)

					var_46_2.name = var_46_0
					var_46_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_43_1.actors_[var_46_0] = var_46_2

					local var_46_3 = var_46_2:GetComponentInChildren(typeof(CharacterEffect))

					var_46_3.enabled = true

					local var_46_4 = GameObjectTools.GetOrAddComponent(var_46_2, typeof(DynamicBoneHelper))

					if var_46_4 then
						var_46_4:EnableDynamicBone(false)
					end

					arg_43_1:ShowWeapon(var_46_3.transform, false)

					arg_43_1.var_[var_46_0 .. "Animator"] = var_46_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_43_1.var_[var_46_0 .. "Animator"].applyRootMotion = true
					arg_43_1.var_[var_46_0 .. "LipSync"] = var_46_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_46_5 = arg_43_1.actors_["6148ui_story"].transform
			local var_46_6 = 0

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.var_.moveOldPos6148ui_story = var_46_5.localPosition

				local var_46_7 = GameObjectTools.GetOrAddComponent(var_46_5.gameObject, typeof(DynamicBoneHelper))

				if var_46_7 then
					var_46_7:EnableDynamicBone(false)
				end
			end

			local var_46_8 = 0.001

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_8 then
				local var_46_9 = (arg_43_1.time_ - var_46_6) / var_46_8
				local var_46_10 = Vector3.New(0, -0.985, -6)

				var_46_5.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos6148ui_story, var_46_10, var_46_9)

				local var_46_11 = manager.ui.mainCamera.transform.position - var_46_5.position

				var_46_5.forward = Vector3.New(var_46_11.x, var_46_11.y, var_46_11.z)

				local var_46_12 = var_46_5.localEulerAngles

				var_46_12.z = 0
				var_46_12.x = 0
				var_46_5.localEulerAngles = var_46_12
			end

			if arg_43_1.time_ >= var_46_6 + var_46_8 and arg_43_1.time_ < var_46_6 + var_46_8 + arg_46_0 then
				var_46_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_46_13 = manager.ui.mainCamera.transform.position - var_46_5.position

				var_46_5.forward = Vector3.New(var_46_13.x, var_46_13.y, var_46_13.z)

				local var_46_14 = var_46_5.localEulerAngles

				var_46_14.z = 0
				var_46_14.x = 0
				var_46_5.localEulerAngles = var_46_14

				local var_46_15 = GameObjectTools.GetOrAddComponent(var_46_5.gameObject, typeof(DynamicBoneHelper))

				if var_46_15 then
					var_46_15:EnableDynamicBone(true)
				end
			end

			local var_46_16 = arg_43_1.actors_["6148ui_story"]
			local var_46_17 = 0

			if var_46_17 < arg_43_1.time_ and arg_43_1.time_ <= var_46_17 + arg_46_0 and not isNil(var_46_16) and arg_43_1.var_.characterEffect6148ui_story == nil then
				arg_43_1.var_.characterEffect6148ui_story = var_46_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_18 = 0.200000002980232

			if var_46_17 <= arg_43_1.time_ and arg_43_1.time_ < var_46_17 + var_46_18 and not isNil(var_46_16) then
				local var_46_19 = (arg_43_1.time_ - var_46_17) / var_46_18

				if arg_43_1.var_.characterEffect6148ui_story and not isNil(var_46_16) then
					arg_43_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_17 + var_46_18 and arg_43_1.time_ < var_46_17 + var_46_18 + arg_46_0 and not isNil(var_46_16) and arg_43_1.var_.characterEffect6148ui_story then
				arg_43_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				arg_43_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_46_21 = 0

			if var_46_21 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_46_22 = 0
			local var_46_23 = 0.675

			if var_46_22 < arg_43_1.time_ and arg_43_1.time_ <= var_46_22 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_24 = arg_43_1:FormatText(StoryNameCfg[1488].name)

				arg_43_1.leftNameTxt_.text = var_46_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_25 = arg_43_1:GetWordFromCfg(939062010)
				local var_46_26 = arg_43_1:FormatText(var_46_25.content)

				arg_43_1.text_.text = var_46_26

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_27 = 27
				local var_46_28 = utf8.len(var_46_26)
				local var_46_29 = var_46_27 <= 0 and var_46_23 or var_46_23 * (var_46_28 / var_46_27)

				if var_46_29 > 0 and var_46_23 < var_46_29 then
					arg_43_1.talkMaxDuration = var_46_29

					if var_46_29 + var_46_22 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_29 + var_46_22
					end
				end

				arg_43_1.text_.text = var_46_26
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_30 = math.max(var_46_23, arg_43_1.talkMaxDuration)

			if var_46_22 <= arg_43_1.time_ and arg_43_1.time_ < var_46_22 + var_46_30 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_22) / var_46_30

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_22 + var_46_30 and arg_43_1.time_ < var_46_22 + var_46_30 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play939062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 939062011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play939062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["6148ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect6148ui_story == nil then
				arg_47_1.var_.characterEffect6148ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect6148ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_47_1.var_.characterEffect6148ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect6148ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_47_1.var_.characterEffect6148ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 1.175

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_8 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_9 = arg_47_1:GetWordFromCfg(939062011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 47
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_7 or var_50_7 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_7 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play939062012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 939062012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play939062013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.1

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(939062012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 4
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play939062013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 939062013
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"

			SetActive(arg_55_1.choicesGo_, true)

			for iter_56_0, iter_56_1 in ipairs(arg_55_1.choices_) do
				local var_56_0 = iter_56_0 <= 2

				SetActive(iter_56_1.go, var_56_0)
			end

			arg_55_1.choices_[1].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1681].name)
			arg_55_1.choices_[2].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1682].name)
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play939062014(arg_55_1)
			end

			if arg_57_0 == 2 then
				arg_55_0:Play939062014(arg_55_1)
			end

			arg_55_1:RecordChoiceLog(939062013, 1681, 1682)
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["6148ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos6148ui_story = var_58_0.localPosition

				local var_58_2 = GameObjectTools.GetOrAddComponent(var_58_0.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(false)
				end
			end

			local var_58_3 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_3 then
				local var_58_4 = (arg_55_1.time_ - var_58_1) / var_58_3
				local var_58_5 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos6148ui_story, var_58_5, var_58_4)

				local var_58_6 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_6.x, var_58_6.y, var_58_6.z)

				local var_58_7 = var_58_0.localEulerAngles

				var_58_7.z = 0
				var_58_7.x = 0
				var_58_0.localEulerAngles = var_58_7
			end

			if arg_55_1.time_ >= var_58_1 + var_58_3 and arg_55_1.time_ < var_58_1 + var_58_3 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_8 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_8.x, var_58_8.y, var_58_8.z)

				local var_58_9 = var_58_0.localEulerAngles

				var_58_9.z = 0
				var_58_9.x = 0
				var_58_0.localEulerAngles = var_58_9

				local var_58_10 = GameObjectTools.GetOrAddComponent(var_58_0.gameObject, typeof(DynamicBoneHelper))

				if var_58_10 then
					var_58_10:EnableDynamicBone(true)
				end
			end

			local var_58_11 = 0

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_12 = 0.7

			if arg_55_1.time_ >= var_58_11 + var_58_12 and arg_55_1.time_ < var_58_11 + var_58_12 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play939062014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 939062014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play939062015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.725

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[8].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_59_1.callingController_:SetSelectedState("calling")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(939062014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 29
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_8 and arg_59_1.time_ < var_62_0 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play939062015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 939062015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play939062016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.1

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[8].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_63_1.callingController_:SetSelectedState("calling")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(939062015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 4
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play939062016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 939062016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play939062017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1248ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1248ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1248ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1248ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1248ui_story == nil then
				arg_67_1.var_.characterEffect1248ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1248ui_story and not isNil(var_70_9) then
					local var_70_13 = Mathf.Lerp(0, 0.5, var_70_12)

					arg_67_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1248ui_story.fillRatio = var_70_13
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1248ui_story then
				local var_70_14 = 0.5

				arg_67_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1248ui_story.fillRatio = var_70_14
			end

			local var_70_15 = 0
			local var_70_16 = 5

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				local var_70_17 = "1"

				arg_67_1.marker = "luntantiezi3"

				if not arg_67_1.actionList["1"] then
					arg_67_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_67_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_67_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 206,
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

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play939062017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 939062017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play939062018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				local var_74_2 = "play"
				local var_74_3 = "music"

				arg_71_1:AudioAction(var_74_2, var_74_3, "ui_skip", "ui_bgm_33", "ui_skip.awb")

				local var_74_4 = ""
				local var_74_5 = manager.audio:GetAudioName("ui_skip", "ui_bgm_33")

				if var_74_5 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_5 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_5

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_5
						arg_71_1.bgmTxt2_.text = var_74_5
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_6 = 0
			local var_74_7 = 1.25

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(939062017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 50
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_7 or var_74_7 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_7 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_13 and arg_71_1.time_ < var_74_6 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play939062018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939062018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939062019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.25

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[1544].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(939062018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 10
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play939062019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939062019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939062020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.45

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(939062019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 18
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play939062020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939062020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939062021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.325

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1544].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(939062020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 13
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play939062021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939062021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939062022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 5

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "2"

				arg_88_1.marker = "tingyixiajiuhao"

				if not arg_88_1.actionList["2"] then
					arg_88_1.actionList["2"] = StoryInteractionRogueCardForumGame.New(arg_88_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_88_1.actionList["2"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 313,
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

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play939062022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939062022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play939062023(arg_92_1)
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
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_95_17 = 0
			local var_95_18 = 0.6

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

				local var_95_20 = arg_92_1:GetWordFromCfg(939062022)
				local var_95_21 = arg_92_1:FormatText(var_95_20.content)

				arg_92_1.text_.text = var_95_21

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_22 = 24
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
	Play939062023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 939062023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play939062024(arg_96_1)
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
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_99_22 = 0

			if var_99_22 < arg_96_1.time_ and arg_96_1.time_ <= var_99_22 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_99_23 = 0
			local var_99_24 = 0.775

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

				local var_99_26 = arg_96_1:GetWordFromCfg(939062023)
				local var_99_27 = arg_96_1:FormatText(var_99_26.content)

				arg_96_1.text_.text = var_99_27

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_28 = 31
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
	Play939062024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939062024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939062025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["6148ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect6148ui_story == nil then
				arg_100_1.var_.characterEffect6148ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect6148ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_100_1.var_.characterEffect6148ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect6148ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_100_1.var_.characterEffect6148ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.225

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(939062024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 9
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play939062025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939062025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play939062026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.775

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(939062025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 31
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play939062026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 939062026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play939062027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1054ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1054ui_story = var_111_0.localPosition

				local var_111_2 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(false)
				end
			end

			local var_111_3 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_3 then
				local var_111_4 = (arg_108_1.time_ - var_111_1) / var_111_3
				local var_111_5 = Vector3.New(-0.7, -0.985, -6)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1054ui_story, var_111_5, var_111_4)

				local var_111_6 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_6.x, var_111_6.y, var_111_6.z)

				local var_111_7 = var_111_0.localEulerAngles

				var_111_7.z = 0
				var_111_7.x = 0
				var_111_0.localEulerAngles = var_111_7
			end

			if arg_108_1.time_ >= var_111_1 + var_111_3 and arg_108_1.time_ < var_111_1 + var_111_3 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_111_8 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_8.x, var_111_8.y, var_111_8.z)

				local var_111_9 = var_111_0.localEulerAngles

				var_111_9.z = 0
				var_111_9.x = 0
				var_111_0.localEulerAngles = var_111_9

				local var_111_10 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_10 then
					var_111_10:EnableDynamicBone(true)
				end
			end

			local var_111_11 = arg_108_1.actors_["1054ui_story"]
			local var_111_12 = 0

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.characterEffect1054ui_story == nil then
				arg_108_1.var_.characterEffect1054ui_story = var_111_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_13 = 0.200000002980232

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_13 and not isNil(var_111_11) then
				local var_111_14 = (arg_108_1.time_ - var_111_12) / var_111_13

				if arg_108_1.var_.characterEffect1054ui_story and not isNil(var_111_11) then
					arg_108_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_12 + var_111_13 and arg_108_1.time_ < var_111_12 + var_111_13 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.characterEffect1054ui_story then
				arg_108_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_111_15 = 0

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_111_16 = 0
			local var_111_17 = 0.625

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[1487].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(939062026)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 25
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_24 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_24 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_24

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_24 and arg_108_1.time_ < var_111_16 + var_111_24 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play939062027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 939062027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play939062028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["6148ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos6148ui_story = var_115_0.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_3 then
				local var_115_4 = (arg_112_1.time_ - var_115_1) / var_115_3
				local var_115_5 = Vector3.New(0.7, -0.985, -6)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos6148ui_story, var_115_5, var_115_4)

				local var_115_6 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_6.x, var_115_6.y, var_115_6.z)

				local var_115_7 = var_115_0.localEulerAngles

				var_115_7.z = 0
				var_115_7.x = 0
				var_115_0.localEulerAngles = var_115_7
			end

			if arg_112_1.time_ >= var_115_1 + var_115_3 and arg_112_1.time_ < var_115_1 + var_115_3 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_115_8 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_8.x, var_115_8.y, var_115_8.z)

				local var_115_9 = var_115_0.localEulerAngles

				var_115_9.z = 0
				var_115_9.x = 0
				var_115_0.localEulerAngles = var_115_9

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(true)
				end
			end

			local var_115_11 = arg_112_1.actors_["6148ui_story"]
			local var_115_12 = 0

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect6148ui_story == nil then
				arg_112_1.var_.characterEffect6148ui_story = var_115_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_13 = 0.200000002980232

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_13 and not isNil(var_115_11) then
				local var_115_14 = (arg_112_1.time_ - var_115_12) / var_115_13

				if arg_112_1.var_.characterEffect6148ui_story and not isNil(var_115_11) then
					arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_12 + var_115_13 and arg_112_1.time_ < var_115_12 + var_115_13 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect6148ui_story then
				arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_115_15 = arg_112_1.actors_["1054ui_story"]
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = var_115_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_17 = 0.200000002980232

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 and not isNil(var_115_15) then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17

				if arg_112_1.var_.characterEffect1054ui_story and not isNil(var_115_15) then
					local var_115_19 = Mathf.Lerp(0, 0.5, var_115_18)

					arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1054ui_story.fillRatio = var_115_19
				end
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect1054ui_story then
				local var_115_20 = 0.5

				arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1054ui_story.fillRatio = var_115_20
			end

			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_115_22 = 0

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_115_23 = 0
			local var_115_24 = 0.625

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[1488].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(939062027)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 25
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_31 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_31 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_31

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_31 and arg_112_1.time_ < var_115_23 + var_115_31 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play939062028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 939062028
		arg_116_1.duration_ = 5.35

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play939062029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1054ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["6148ui_story"].transform
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.var_.moveOldPos6148ui_story = var_119_11.localPosition

				local var_119_13 = GameObjectTools.GetOrAddComponent(var_119_11.gameObject, typeof(DynamicBoneHelper))

				if var_119_13 then
					var_119_13:EnableDynamicBone(false)
				end
			end

			local var_119_14 = 0.001

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_14 then
				local var_119_15 = (arg_116_1.time_ - var_119_12) / var_119_14
				local var_119_16 = Vector3.New(0, 100, 0)

				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos6148ui_story, var_119_16, var_119_15)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_11.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_11.localEulerAngles = var_119_18
			end

			if arg_116_1.time_ >= var_119_12 + var_119_14 and arg_116_1.time_ < var_119_12 + var_119_14 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0, 100, 0)

				local var_119_19 = manager.ui.mainCamera.transform.position - var_119_11.position

				var_119_11.forward = Vector3.New(var_119_19.x, var_119_19.y, var_119_19.z)

				local var_119_20 = var_119_11.localEulerAngles

				var_119_20.z = 0
				var_119_20.x = 0
				var_119_11.localEulerAngles = var_119_20

				local var_119_21 = GameObjectTools.GetOrAddComponent(var_119_11.gameObject, typeof(DynamicBoneHelper))

				if var_119_21 then
					var_119_21:EnableDynamicBone(true)
				end
			end

			local var_119_22 = 0

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_11.localPosition
			end

			local var_119_23 = 0.6

			if var_119_22 <= arg_116_1.time_ and arg_116_1.time_ < var_119_22 + var_119_23 then
				local var_119_24 = (arg_116_1.time_ - var_119_22) / 0.066
				local var_119_25, var_119_26 = math.modf(var_119_24)

				var_119_11.localPosition = Vector3.New(var_119_26 * 0.13, var_119_26 * 0.13, var_119_26 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= var_119_22 + var_119_23 and arg_116_1.time_ < var_119_22 + var_119_23 + arg_119_0 then
				var_119_11.localPosition = arg_116_1.var_.shakeOldPos
			end

			local var_119_27 = manager.ui.mainCamera.transform
			local var_119_28 = 0

			if var_119_28 < arg_116_1.time_ and arg_116_1.time_ <= var_119_28 + arg_119_0 then
				local var_119_29 = arg_116_1.var_.effecthetidaoguang1
				local var_119_30
				local var_119_31 = var_119_27

				if not var_119_29 then
					var_119_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang1043_2"), var_119_31)
					var_119_29.name = "hetidaoguang1"
					arg_116_1.var_.effecthetidaoguang1 = var_119_29
				else
					var_119_29.transform:SetParent(var_119_31)
				end

				var_119_29.transform.localPosition = Vector3.New(-0.26, 0, -1.26)
				var_119_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_32 = manager.ui.mainCamera.transform
			local var_119_33 = 0.034000001847744

			if var_119_33 < arg_116_1.time_ and arg_116_1.time_ <= var_119_33 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_32.localPosition
			end

			local var_119_34 = 0.315999998152256

			if var_119_33 <= arg_116_1.time_ and arg_116_1.time_ < var_119_33 + var_119_34 then
				local var_119_35 = (arg_116_1.time_ - var_119_33) / 0.066
				local var_119_36, var_119_37 = math.modf(var_119_35)

				var_119_32.localPosition = Vector3.New(var_119_37 * 0.13, var_119_37 * 0.13, var_119_37 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= var_119_33 + var_119_34 and arg_116_1.time_ < var_119_33 + var_119_34 + arg_119_0 then
				var_119_32.localPosition = arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_38 = 0.35
			local var_119_39 = 0.25

			if var_119_38 < arg_116_1.time_ and arg_116_1.time_ <= var_119_38 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_40 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_40:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_41 = arg_116_1:FormatText(StoryNameCfg[1489].name)

				arg_116_1.leftNameTxt_.text = var_119_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_42 = arg_116_1:GetWordFromCfg(939062028)
				local var_119_43 = arg_116_1:FormatText(var_119_42.content)

				arg_116_1.text_.text = var_119_43

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_44 = 10
				local var_119_45 = utf8.len(var_119_43)
				local var_119_46 = var_119_44 <= 0 and var_119_39 or var_119_39 * (var_119_45 / var_119_44)

				if var_119_46 > 0 and var_119_39 < var_119_46 then
					arg_116_1.talkMaxDuration = var_119_46
					var_119_38 = var_119_38 + 0.3

					if var_119_46 + var_119_38 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_46 + var_119_38
					end
				end

				arg_116_1.text_.text = var_119_43
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_47 = var_119_38 + 0.3
			local var_119_48 = math.max(var_119_39, arg_116_1.talkMaxDuration)

			if var_119_47 <= arg_116_1.time_ and arg_116_1.time_ < var_119_47 + var_119_48 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_47) / var_119_48

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_47 + var_119_48 and arg_116_1.time_ < var_119_47 + var_119_48 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play939062029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 939062029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play939062030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				local var_125_2 = "play"
				local var_125_3 = "music"

				arg_122_1:AudioAction(var_125_2, var_125_3, "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_125_4 = ""
				local var_125_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_125_5 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_5 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_5

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_5
						arg_122_1.bgmTxt2_.text = var_125_5
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_6 = 0
			local var_125_7 = 1.2

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_8 = arg_122_1:GetWordFromCfg(939062029)
				local var_125_9 = arg_122_1:FormatText(var_125_8.content)

				arg_122_1.text_.text = var_125_9

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_10 = 48
				local var_125_11 = utf8.len(var_125_9)
				local var_125_12 = var_125_10 <= 0 and var_125_7 or var_125_7 * (var_125_11 / var_125_10)

				if var_125_12 > 0 and var_125_7 < var_125_12 then
					arg_122_1.talkMaxDuration = var_125_12

					if var_125_12 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_12 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_9
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_13 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_13 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_13

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_13 and arg_122_1.time_ < var_125_6 + var_125_13 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play939062030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 939062030
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play939062031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "STblack"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 2

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.STblack

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "STblack" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 4

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_17 = 0.3

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_19 = 2

			if var_130_18 <= arg_127_1.time_ and arg_127_1.time_ < var_130_18 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_18) / var_130_19
				local var_130_21 = Color.New(0, 0, 0)

				var_130_21.a = Mathf.Lerp(0, 1, var_130_20)
				arg_127_1.mask_.color = var_130_21
			end

			if arg_127_1.time_ >= var_130_18 + var_130_19 and arg_127_1.time_ < var_130_18 + var_130_19 + arg_130_0 then
				local var_130_22 = Color.New(0, 0, 0)

				var_130_22.a = 1
				arg_127_1.mask_.color = var_130_22
			end

			local var_130_23 = 2

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_24 = 2

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24
				local var_130_26 = Color.New(0, 0, 0)

				var_130_26.a = Mathf.Lerp(1, 0, var_130_25)
				arg_127_1.mask_.color = var_130_26
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 then
				local var_130_27 = Color.New(0, 0, 0)
				local var_130_28 = 0

				arg_127_1.mask_.enabled = false
				var_130_27.a = var_130_28
				arg_127_1.mask_.color = var_130_27
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_29 = 4
			local var_130_30 = 0.4

			if var_130_29 < arg_127_1.time_ and arg_127_1.time_ <= var_130_29 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_31 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_31:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_32 = arg_127_1:GetWordFromCfg(939062030)
				local var_130_33 = arg_127_1:FormatText(var_130_32.content)

				arg_127_1.text_.text = var_130_33

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_34 = 16
				local var_130_35 = utf8.len(var_130_33)
				local var_130_36 = var_130_34 <= 0 and var_130_30 or var_130_30 * (var_130_35 / var_130_34)

				if var_130_36 > 0 and var_130_30 < var_130_36 then
					arg_127_1.talkMaxDuration = var_130_36
					var_130_29 = var_130_29 + 0.3

					if var_130_36 + var_130_29 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_36 + var_130_29
					end
				end

				arg_127_1.text_.text = var_130_33
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_37 = var_130_29 + 0.3
			local var_130_38 = math.max(var_130_30, arg_127_1.talkMaxDuration)

			if var_130_37 <= arg_127_1.time_ and arg_127_1.time_ < var_130_37 + var_130_38 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_37) / var_130_38

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_37 + var_130_38 and arg_127_1.time_ < var_130_37 + var_130_38 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play939062031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 939062031
		arg_133_1.duration_ = 7

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play939062032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = "ST12"

			if arg_133_1.bgs_[var_136_0] == nil then
				local var_136_1 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_136_0)
				var_136_1.name = var_136_0
				var_136_1.transform.parent = arg_133_1.stage_.transform
				var_136_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_[var_136_0] = var_136_1
			end

			local var_136_2 = 0

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				local var_136_3 = manager.ui.mainCamera.transform.localPosition
				local var_136_4 = Vector3.New(0, 0, 10) + Vector3.New(var_136_3.x, var_136_3.y, 0)
				local var_136_5 = arg_133_1.bgs_.ST12

				var_136_5.transform.localPosition = var_136_4
				var_136_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_6 = var_136_5:GetComponent("SpriteRenderer")

				if var_136_6 and var_136_6.sprite then
					local var_136_7 = (var_136_5.transform.localPosition - var_136_3).z
					local var_136_8 = manager.ui.mainCameraCom_
					local var_136_9 = 2 * var_136_7 * Mathf.Tan(var_136_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_10 = var_136_9 * var_136_8.aspect
					local var_136_11 = var_136_6.sprite.bounds.size.x
					local var_136_12 = var_136_6.sprite.bounds.size.y
					local var_136_13 = var_136_10 / var_136_11
					local var_136_14 = var_136_9 / var_136_12
					local var_136_15 = var_136_14 < var_136_13 and var_136_13 or var_136_14

					var_136_5.transform.localScale = Vector3.New(var_136_15, var_136_15, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST12" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_16 = 2

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			local var_136_17 = 0.3

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_19 = 2

			if var_136_18 <= arg_133_1.time_ and arg_133_1.time_ < var_136_18 + var_136_19 then
				local var_136_20 = (arg_133_1.time_ - var_136_18) / var_136_19
				local var_136_21 = Color.New(0, 0, 0)

				var_136_21.a = Mathf.Lerp(1, 0, var_136_20)
				arg_133_1.mask_.color = var_136_21
			end

			if arg_133_1.time_ >= var_136_18 + var_136_19 and arg_133_1.time_ < var_136_18 + var_136_19 + arg_136_0 then
				local var_136_22 = Color.New(0, 0, 0)
				local var_136_23 = 0

				arg_133_1.mask_.enabled = false
				var_136_22.a = var_136_23
				arg_133_1.mask_.color = var_136_22
			end

			local var_136_24 = "1019ui_story"

			if arg_133_1.actors_[var_136_24] == nil then
				local var_136_25 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_136_25) then
					local var_136_26 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_133_1.stage_.transform)

					var_136_26.name = var_136_24
					var_136_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_133_1.actors_[var_136_24] = var_136_26

					local var_136_27 = var_136_26:GetComponentInChildren(typeof(CharacterEffect))

					var_136_27.enabled = true

					local var_136_28 = GameObjectTools.GetOrAddComponent(var_136_26, typeof(DynamicBoneHelper))

					if var_136_28 then
						var_136_28:EnableDynamicBone(false)
					end

					arg_133_1:ShowWeapon(var_136_27.transform, false)

					arg_133_1.var_[var_136_24 .. "Animator"] = var_136_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_133_1.var_[var_136_24 .. "Animator"].applyRootMotion = true
					arg_133_1.var_[var_136_24 .. "LipSync"] = var_136_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_136_29 = arg_133_1.actors_["1019ui_story"].transform
			local var_136_30 = 1.8

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.var_.moveOldPos1019ui_story = var_136_29.localPosition
			end

			local var_136_31 = 0.001

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_31 then
				local var_136_32 = (arg_133_1.time_ - var_136_30) / var_136_31
				local var_136_33 = Vector3.New(-0.2, -1.08, -5.9)

				var_136_29.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1019ui_story, var_136_33, var_136_32)

				local var_136_34 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_34.x, var_136_34.y, var_136_34.z)

				local var_136_35 = var_136_29.localEulerAngles

				var_136_35.z = 0
				var_136_35.x = 0
				var_136_29.localEulerAngles = var_136_35
			end

			if arg_133_1.time_ >= var_136_30 + var_136_31 and arg_133_1.time_ < var_136_30 + var_136_31 + arg_136_0 then
				var_136_29.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_136_36 = manager.ui.mainCamera.transform.position - var_136_29.position

				var_136_29.forward = Vector3.New(var_136_36.x, var_136_36.y, var_136_36.z)

				local var_136_37 = var_136_29.localEulerAngles

				var_136_37.z = 0
				var_136_37.x = 0
				var_136_29.localEulerAngles = var_136_37
			end

			local var_136_38 = arg_133_1.actors_["1019ui_story"]
			local var_136_39 = 1.8

			if var_136_39 < arg_133_1.time_ and arg_133_1.time_ <= var_136_39 + arg_136_0 and not isNil(var_136_38) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_40 = 0.200000002980232

			if var_136_39 <= arg_133_1.time_ and arg_133_1.time_ < var_136_39 + var_136_40 and not isNil(var_136_38) then
				local var_136_41 = (arg_133_1.time_ - var_136_39) / var_136_40

				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_38) then
					arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_39 + var_136_40 and arg_133_1.time_ < var_136_39 + var_136_40 + arg_136_0 and not isNil(var_136_38) and arg_133_1.var_.characterEffect1019ui_story then
				arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_136_42 = 1.8

			if var_136_42 < arg_133_1.time_ and arg_133_1.time_ <= var_136_42 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_136_43 = 1.8

			if var_136_43 < arg_133_1.time_ and arg_133_1.time_ <= var_136_43 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_44 = 0
			local var_136_45 = 1

			if var_136_44 < arg_133_1.time_ and arg_133_1.time_ <= var_136_44 + arg_136_0 then
				local var_136_46 = "play"
				local var_136_47 = "music"

				arg_133_1:AudioAction(var_136_46, var_136_47, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_136_48 = ""
				local var_136_49 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if var_136_49 ~= "" then
					if arg_133_1.bgmTxt_.text ~= var_136_49 and arg_133_1.bgmTxt_.text ~= "" then
						if arg_133_1.bgmTxt2_.text ~= "" then
							arg_133_1.bgmTxt_.text = arg_133_1.bgmTxt2_.text
						end

						arg_133_1.bgmTxt2_.text = var_136_49

						arg_133_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_133_1.bgmTxt_.text = var_136_49
						arg_133_1.bgmTxt2_.text = var_136_49
					end

					if arg_133_1.bgmTimer then
						arg_133_1.bgmTimer:Stop()

						arg_133_1.bgmTimer = nil
					end

					if arg_133_1.settingData.show_music_name == 1 then
						arg_133_1.musicController:SetSelectedState("show")
						arg_133_1.musicAnimator_:Play("open", 0, 0)

						if arg_133_1.settingData.music_time ~= 0 then
							arg_133_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_133_1.settingData.music_time), function()
								if arg_133_1 == nil or isNil(arg_133_1.bgmTxt_) then
									return
								end

								arg_133_1.musicController:SetSelectedState("hide")
								arg_133_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_50 = 2
			local var_136_51 = 1

			if var_136_50 < arg_133_1.time_ and arg_133_1.time_ <= var_136_50 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_52 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_52:setOnUpdate(LuaHelper.FloatAction(function(arg_138_0)
					arg_133_1.dialogCg_.alpha = arg_138_0
				end))
				var_136_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_53 = arg_133_1:FormatText(StoryNameCfg[13].name)

				arg_133_1.leftNameTxt_.text = var_136_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_54 = arg_133_1:GetWordFromCfg(939062031)
				local var_136_55 = arg_133_1:FormatText(var_136_54.content)

				arg_133_1.text_.text = var_136_55

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_56 = 40
				local var_136_57 = utf8.len(var_136_55)
				local var_136_58 = var_136_56 <= 0 and var_136_51 or var_136_51 * (var_136_57 / var_136_56)

				if var_136_58 > 0 and var_136_51 < var_136_58 then
					arg_133_1.talkMaxDuration = var_136_58
					var_136_50 = var_136_50 + 0.3

					if var_136_58 + var_136_50 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_58 + var_136_50
					end
				end

				arg_133_1.text_.text = var_136_55
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_59 = var_136_50 + 0.3
			local var_136_60 = math.max(var_136_51, arg_133_1.talkMaxDuration)

			if var_136_59 <= arg_133_1.time_ and arg_133_1.time_ < var_136_59 + var_136_60 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_59) / var_136_60

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_59 + var_136_60 and arg_133_1.time_ < var_136_59 + var_136_60 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play939062032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 939062032
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play939062033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1019ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1019ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1019ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_11 = 0
			local var_143_12 = 0.45

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_13 = arg_140_1:FormatText(StoryNameCfg[13].name)

				arg_140_1.leftNameTxt_.text = var_143_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_14 = arg_140_1:GetWordFromCfg(939062032)
				local var_143_15 = arg_140_1:FormatText(var_143_14.content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_16 = 18
				local var_143_17 = utf8.len(var_143_15)
				local var_143_18 = var_143_16 <= 0 and var_143_12 or var_143_12 * (var_143_17 / var_143_16)

				if var_143_18 > 0 and var_143_12 < var_143_18 then
					arg_140_1.talkMaxDuration = var_143_18

					if var_143_18 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_11
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_19 = math.max(var_143_12, arg_140_1.talkMaxDuration)

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_19 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_11) / var_143_19

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_11 + var_143_19 and arg_140_1.time_ < var_143_11 + var_143_19 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play939062033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 939062033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play939062034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1019ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1019ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 0.7

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_9 = arg_144_1:GetWordFromCfg(939062033)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 28
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play939062034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 939062034
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play939062035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1019ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1019ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1019ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1019ui_story then
				arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_15 = 0
			local var_151_16 = 1.15

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[13].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(939062034)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 46
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_23 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_23 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_23

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_23 and arg_148_1.time_ < var_151_15 + var_151_23 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play939062035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 939062035
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play939062036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1019ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1019ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1019ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1019ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 0.1

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(939062035)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 4
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play939062036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 939062036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play939062037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1284ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1284ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0.7, -0.985, -6.22)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1284ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1019ui_story"].transform
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1.var_.moveOldPos1019ui_story = var_159_9.localPosition
			end

			local var_159_11 = 0.001

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11
				local var_159_13 = Vector3.New(-0.7, -1.08, -5.9)

				var_159_9.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1019ui_story, var_159_13, var_159_12)

				local var_159_14 = manager.ui.mainCamera.transform.position - var_159_9.position

				var_159_9.forward = Vector3.New(var_159_14.x, var_159_14.y, var_159_14.z)

				local var_159_15 = var_159_9.localEulerAngles

				var_159_15.z = 0
				var_159_15.x = 0
				var_159_9.localEulerAngles = var_159_15
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 then
				var_159_9.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_159_16 = manager.ui.mainCamera.transform.position - var_159_9.position

				var_159_9.forward = Vector3.New(var_159_16.x, var_159_16.y, var_159_16.z)

				local var_159_17 = var_159_9.localEulerAngles

				var_159_17.z = 0
				var_159_17.x = 0
				var_159_9.localEulerAngles = var_159_17
			end

			local var_159_18 = arg_156_1.actors_["1284ui_story"]
			local var_159_19 = 0

			if var_159_19 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 and not isNil(var_159_18) and arg_156_1.var_.characterEffect1284ui_story == nil then
				arg_156_1.var_.characterEffect1284ui_story = var_159_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_20 = 0.200000002980232

			if var_159_19 <= arg_156_1.time_ and arg_156_1.time_ < var_159_19 + var_159_20 and not isNil(var_159_18) then
				local var_159_21 = (arg_156_1.time_ - var_159_19) / var_159_20

				if arg_156_1.var_.characterEffect1284ui_story and not isNil(var_159_18) then
					arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_19 + var_159_20 and arg_156_1.time_ < var_159_19 + var_159_20 + arg_159_0 and not isNil(var_159_18) and arg_156_1.var_.characterEffect1284ui_story then
				arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_159_22 = 0

			if var_159_22 < arg_156_1.time_ and arg_156_1.time_ <= var_159_22 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_159_23 = 0

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_159_24 = 0
			local var_159_25 = 1

			if var_159_24 < arg_156_1.time_ and arg_156_1.time_ <= var_159_24 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_26 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_27 = arg_156_1:GetWordFromCfg(939062036)
				local var_159_28 = arg_156_1:FormatText(var_159_27.content)

				arg_156_1.text_.text = var_159_28

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_29 = 40
				local var_159_30 = utf8.len(var_159_28)
				local var_159_31 = var_159_29 <= 0 and var_159_25 or var_159_25 * (var_159_30 / var_159_29)

				if var_159_31 > 0 and var_159_25 < var_159_31 then
					arg_156_1.talkMaxDuration = var_159_31

					if var_159_31 + var_159_24 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_31 + var_159_24
					end
				end

				arg_156_1.text_.text = var_159_28
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_32 = math.max(var_159_25, arg_156_1.talkMaxDuration)

			if var_159_24 <= arg_156_1.time_ and arg_156_1.time_ < var_159_24 + var_159_32 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_24) / var_159_32

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_24 + var_159_32 and arg_156_1.time_ < var_159_24 + var_159_32 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
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
	Play939062037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 939062037
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play939062038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "I03"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 2

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.I03

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "I03" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 4

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_17 = 0.3

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_19 = 2

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19
				local var_163_21 = Color.New(0, 0, 0)

				var_163_21.a = Mathf.Lerp(0, 1, var_163_20)
				arg_160_1.mask_.color = var_163_21
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 then
				local var_163_22 = Color.New(0, 0, 0)

				var_163_22.a = 1
				arg_160_1.mask_.color = var_163_22
			end

			local var_163_23 = 2

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_24 = 2

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Color.New(0, 0, 0)

				var_163_26.a = Mathf.Lerp(1, 0, var_163_25)
				arg_160_1.mask_.color = var_163_26
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				local var_163_27 = Color.New(0, 0, 0)
				local var_163_28 = 0

				arg_160_1.mask_.enabled = false
				var_163_27.a = var_163_28
				arg_160_1.mask_.color = var_163_27
			end

			local var_163_29 = arg_160_1.actors_["1284ui_story"].transform
			local var_163_30 = 1.96599999815226

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.var_.moveOldPos1284ui_story = var_163_29.localPosition
			end

			local var_163_31 = 0.001

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_31 then
				local var_163_32 = (arg_160_1.time_ - var_163_30) / var_163_31
				local var_163_33 = Vector3.New(0, 100, 0)

				var_163_29.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1284ui_story, var_163_33, var_163_32)

				local var_163_34 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_34.x, var_163_34.y, var_163_34.z)

				local var_163_35 = var_163_29.localEulerAngles

				var_163_35.z = 0
				var_163_35.x = 0
				var_163_29.localEulerAngles = var_163_35
			end

			if arg_160_1.time_ >= var_163_30 + var_163_31 and arg_160_1.time_ < var_163_30 + var_163_31 + arg_163_0 then
				var_163_29.localPosition = Vector3.New(0, 100, 0)

				local var_163_36 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_36.x, var_163_36.y, var_163_36.z)

				local var_163_37 = var_163_29.localEulerAngles

				var_163_37.z = 0
				var_163_37.x = 0
				var_163_29.localEulerAngles = var_163_37
			end

			local var_163_38 = arg_160_1.actors_["1019ui_story"].transform
			local var_163_39 = 1.96599999815226

			if var_163_39 < arg_160_1.time_ and arg_160_1.time_ <= var_163_39 + arg_163_0 then
				arg_160_1.var_.moveOldPos1019ui_story = var_163_38.localPosition
			end

			local var_163_40 = 0.001

			if var_163_39 <= arg_160_1.time_ and arg_160_1.time_ < var_163_39 + var_163_40 then
				local var_163_41 = (arg_160_1.time_ - var_163_39) / var_163_40
				local var_163_42 = Vector3.New(0, 100, 0)

				var_163_38.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1019ui_story, var_163_42, var_163_41)

				local var_163_43 = manager.ui.mainCamera.transform.position - var_163_38.position

				var_163_38.forward = Vector3.New(var_163_43.x, var_163_43.y, var_163_43.z)

				local var_163_44 = var_163_38.localEulerAngles

				var_163_44.z = 0
				var_163_44.x = 0
				var_163_38.localEulerAngles = var_163_44
			end

			if arg_160_1.time_ >= var_163_39 + var_163_40 and arg_160_1.time_ < var_163_39 + var_163_40 + arg_163_0 then
				var_163_38.localPosition = Vector3.New(0, 100, 0)

				local var_163_45 = manager.ui.mainCamera.transform.position - var_163_38.position

				var_163_38.forward = Vector3.New(var_163_45.x, var_163_45.y, var_163_45.z)

				local var_163_46 = var_163_38.localEulerAngles

				var_163_46.z = 0
				var_163_46.x = 0
				var_163_38.localEulerAngles = var_163_46
			end

			local var_163_47 = arg_160_1.actors_["1284ui_story"]
			local var_163_48 = 1.96599999815226

			if var_163_48 < arg_160_1.time_ and arg_160_1.time_ <= var_163_48 + arg_163_0 and not isNil(var_163_47) and arg_160_1.var_.characterEffect1284ui_story == nil then
				arg_160_1.var_.characterEffect1284ui_story = var_163_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_49 = 0.034000001847744

			if var_163_48 <= arg_160_1.time_ and arg_160_1.time_ < var_163_48 + var_163_49 and not isNil(var_163_47) then
				local var_163_50 = (arg_160_1.time_ - var_163_48) / var_163_49

				if arg_160_1.var_.characterEffect1284ui_story and not isNil(var_163_47) then
					local var_163_51 = Mathf.Lerp(0, 0.5, var_163_50)

					arg_160_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1284ui_story.fillRatio = var_163_51
				end
			end

			if arg_160_1.time_ >= var_163_48 + var_163_49 and arg_160_1.time_ < var_163_48 + var_163_49 + arg_163_0 and not isNil(var_163_47) and arg_160_1.var_.characterEffect1284ui_story then
				local var_163_52 = 0.5

				arg_160_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1284ui_story.fillRatio = var_163_52
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_53 = 4
			local var_163_54 = 0.775

			if var_163_53 < arg_160_1.time_ and arg_160_1.time_ <= var_163_53 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_55 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_55:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_56 = arg_160_1:GetWordFromCfg(939062037)
				local var_163_57 = arg_160_1:FormatText(var_163_56.content)

				arg_160_1.text_.text = var_163_57

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_58 = 31
				local var_163_59 = utf8.len(var_163_57)
				local var_163_60 = var_163_58 <= 0 and var_163_54 or var_163_54 * (var_163_59 / var_163_58)

				if var_163_60 > 0 and var_163_54 < var_163_60 then
					arg_160_1.talkMaxDuration = var_163_60
					var_163_53 = var_163_53 + 0.3

					if var_163_60 + var_163_53 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_60 + var_163_53
					end
				end

				arg_160_1.text_.text = var_163_57
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_61 = var_163_53 + 0.3
			local var_163_62 = math.max(var_163_54, arg_160_1.talkMaxDuration)

			if var_163_61 <= arg_160_1.time_ and arg_160_1.time_ < var_163_61 + var_163_62 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_61) / var_163_62

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_61 + var_163_62 and arg_160_1.time_ < var_163_61 + var_163_62 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play939062038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 939062038
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play939062039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = "1047ui_story"

			if arg_166_1.actors_[var_169_0] == nil then
				local var_169_1 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_169_1) then
					local var_169_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_166_1.stage_.transform)

					var_169_2.name = var_169_0
					var_169_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_166_1.actors_[var_169_0] = var_169_2

					local var_169_3 = var_169_2:GetComponentInChildren(typeof(CharacterEffect))

					var_169_3.enabled = true

					local var_169_4 = GameObjectTools.GetOrAddComponent(var_169_2, typeof(DynamicBoneHelper))

					if var_169_4 then
						var_169_4:EnableDynamicBone(false)
					end

					arg_166_1:ShowWeapon(var_169_3.transform, false)

					arg_166_1.var_[var_169_0 .. "Animator"] = var_169_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_166_1.var_[var_169_0 .. "Animator"].applyRootMotion = true
					arg_166_1.var_[var_169_0 .. "LipSync"] = var_169_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_169_5 = arg_166_1.actors_["1047ui_story"].transform
			local var_169_6 = 0

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.var_.moveOldPos1047ui_story = var_169_5.localPosition
			end

			local var_169_7 = 0.001

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_7 then
				local var_169_8 = (arg_166_1.time_ - var_169_6) / var_169_7
				local var_169_9 = Vector3.New(0, -1.13, -6.2)

				var_169_5.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1047ui_story, var_169_9, var_169_8)

				local var_169_10 = manager.ui.mainCamera.transform.position - var_169_5.position

				var_169_5.forward = Vector3.New(var_169_10.x, var_169_10.y, var_169_10.z)

				local var_169_11 = var_169_5.localEulerAngles

				var_169_11.z = 0
				var_169_11.x = 0
				var_169_5.localEulerAngles = var_169_11
			end

			if arg_166_1.time_ >= var_169_6 + var_169_7 and arg_166_1.time_ < var_169_6 + var_169_7 + arg_169_0 then
				var_169_5.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_169_12 = manager.ui.mainCamera.transform.position - var_169_5.position

				var_169_5.forward = Vector3.New(var_169_12.x, var_169_12.y, var_169_12.z)

				local var_169_13 = var_169_5.localEulerAngles

				var_169_13.z = 0
				var_169_13.x = 0
				var_169_5.localEulerAngles = var_169_13
			end

			local var_169_14 = arg_166_1.actors_["1047ui_story"]
			local var_169_15 = 0

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 and not isNil(var_169_14) and arg_166_1.var_.characterEffect1047ui_story == nil then
				arg_166_1.var_.characterEffect1047ui_story = var_169_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_16 = 0.200000002980232

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_16 and not isNil(var_169_14) then
				local var_169_17 = (arg_166_1.time_ - var_169_15) / var_169_16

				if arg_166_1.var_.characterEffect1047ui_story and not isNil(var_169_14) then
					arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_15 + var_169_16 and arg_166_1.time_ < var_169_15 + var_169_16 + arg_169_0 and not isNil(var_169_14) and arg_166_1.var_.characterEffect1047ui_story then
				arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_169_18 = 0

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_169_19 = 0

			if var_169_19 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_169_20 = 0
			local var_169_21 = 1.05

			if var_169_20 < arg_166_1.time_ and arg_166_1.time_ <= var_169_20 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_22 = arg_166_1:FormatText(StoryNameCfg[1296].name)

				arg_166_1.leftNameTxt_.text = var_169_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_23 = arg_166_1:GetWordFromCfg(939062038)
				local var_169_24 = arg_166_1:FormatText(var_169_23.content)

				arg_166_1.text_.text = var_169_24

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_25 = 42
				local var_169_26 = utf8.len(var_169_24)
				local var_169_27 = var_169_25 <= 0 and var_169_21 or var_169_21 * (var_169_26 / var_169_25)

				if var_169_27 > 0 and var_169_21 < var_169_27 then
					arg_166_1.talkMaxDuration = var_169_27

					if var_169_27 + var_169_20 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_27 + var_169_20
					end
				end

				arg_166_1.text_.text = var_169_24
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_28 = math.max(var_169_21, arg_166_1.talkMaxDuration)

			if var_169_20 <= arg_166_1.time_ and arg_166_1.time_ < var_169_20 + var_169_28 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_20) / var_169_28

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_20 + var_169_28 and arg_166_1.time_ < var_169_20 + var_169_28 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play939062039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 939062039
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play939062040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1047ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1047ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1047ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1047ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1047ui_story == nil then
				arg_170_1.var_.characterEffect1047ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1047ui_story and not isNil(var_173_9) then
					local var_173_13 = Mathf.Lerp(0, 0.5, var_173_12)

					arg_170_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1047ui_story.fillRatio = var_173_13
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1047ui_story then
				local var_173_14 = 0.5

				arg_170_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1047ui_story.fillRatio = var_173_14
			end

			local var_173_15 = 0
			local var_173_16 = 1.7

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_17 = arg_170_1:GetWordFromCfg(939062039)
				local var_173_18 = arg_170_1:FormatText(var_173_17.content)

				arg_170_1.text_.text = var_173_18

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_19 = 68
				local var_173_20 = utf8.len(var_173_18)
				local var_173_21 = var_173_19 <= 0 and var_173_16 or var_173_16 * (var_173_20 / var_173_19)

				if var_173_21 > 0 and var_173_16 < var_173_21 then
					arg_170_1.talkMaxDuration = var_173_21

					if var_173_21 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_21 + var_173_15
					end
				end

				arg_170_1.text_.text = var_173_18
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_22 = math.max(var_173_16, arg_170_1.talkMaxDuration)

			if var_173_15 <= arg_170_1.time_ and arg_170_1.time_ < var_173_15 + var_173_22 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_15) / var_173_22

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_15 + var_173_22 and arg_170_1.time_ < var_173_15 + var_173_22 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play939062040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 939062040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play939062041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 0.45

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_2

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

				local var_177_3 = arg_174_1:GetWordFromCfg(939062040)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 18
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_8 and arg_174_1.time_ < var_177_0 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play939062041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 939062041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play939062042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1248ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1248ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -0.775, -6.18)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1248ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -0.775, -6.18)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1248ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1248ui_story == nil then
				arg_178_1.var_.characterEffect1248ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1248ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1248ui_story then
				arg_178_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action1_1")
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_181_15 = 0
			local var_181_16 = 0.425

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[8].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(939062041)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 17
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_23 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_23 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_23

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_23 and arg_178_1.time_ < var_181_15 + var_181_23 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play939062042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 939062042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play939062043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1248ui_story"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos1248ui_story = var_185_0.localPosition
			end

			local var_185_2 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2
				local var_185_4 = Vector3.New(0, 100, 0)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1248ui_story, var_185_4, var_185_3)

				local var_185_5 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_5.x, var_185_5.y, var_185_5.z)

				local var_185_6 = var_185_0.localEulerAngles

				var_185_6.z = 0
				var_185_6.x = 0
				var_185_0.localEulerAngles = var_185_6
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, 100, 0)

				local var_185_7 = manager.ui.mainCamera.transform.position - var_185_0.position

				var_185_0.forward = Vector3.New(var_185_7.x, var_185_7.y, var_185_7.z)

				local var_185_8 = var_185_0.localEulerAngles

				var_185_8.z = 0
				var_185_8.x = 0
				var_185_0.localEulerAngles = var_185_8
			end

			local var_185_9 = arg_182_1.actors_["1248ui_story"]
			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1248ui_story == nil then
				arg_182_1.var_.characterEffect1248ui_story = var_185_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_11 = 0.200000002980232

			if var_185_10 <= arg_182_1.time_ and arg_182_1.time_ < var_185_10 + var_185_11 and not isNil(var_185_9) then
				local var_185_12 = (arg_182_1.time_ - var_185_10) / var_185_11

				if arg_182_1.var_.characterEffect1248ui_story and not isNil(var_185_9) then
					local var_185_13 = Mathf.Lerp(0, 0.5, var_185_12)

					arg_182_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1248ui_story.fillRatio = var_185_13
				end
			end

			if arg_182_1.time_ >= var_185_10 + var_185_11 and arg_182_1.time_ < var_185_10 + var_185_11 + arg_185_0 and not isNil(var_185_9) and arg_182_1.var_.characterEffect1248ui_story then
				local var_185_14 = 0.5

				arg_182_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1248ui_story.fillRatio = var_185_14
			end

			local var_185_15 = 0
			local var_185_16 = 0.9

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_17 = arg_182_1:GetWordFromCfg(939062042)
				local var_185_18 = arg_182_1:FormatText(var_185_17.content)

				arg_182_1.text_.text = var_185_18

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_19 = 36
				local var_185_20 = utf8.len(var_185_18)
				local var_185_21 = var_185_19 <= 0 and var_185_16 or var_185_16 * (var_185_20 / var_185_19)

				if var_185_21 > 0 and var_185_16 < var_185_21 then
					arg_182_1.talkMaxDuration = var_185_21

					if var_185_21 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_21 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_18
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_22 and arg_182_1.time_ < var_185_15 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play939062043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 939062043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play939062044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = "1034ui_story"

			if arg_186_1.actors_[var_189_0] == nil then
				local var_189_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_189_1) then
					local var_189_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_186_1.stage_.transform)

					var_189_2.name = var_189_0
					var_189_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_186_1.actors_[var_189_0] = var_189_2

					local var_189_3 = var_189_2:GetComponentInChildren(typeof(CharacterEffect))

					var_189_3.enabled = true

					local var_189_4 = GameObjectTools.GetOrAddComponent(var_189_2, typeof(DynamicBoneHelper))

					if var_189_4 then
						var_189_4:EnableDynamicBone(false)
					end

					arg_186_1:ShowWeapon(var_189_3.transform, false)

					arg_186_1.var_[var_189_0 .. "Animator"] = var_189_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_186_1.var_[var_189_0 .. "Animator"].applyRootMotion = true
					arg_186_1.var_[var_189_0 .. "LipSync"] = var_189_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_189_5 = arg_186_1.actors_["1034ui_story"].transform
			local var_189_6 = 0

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.var_.moveOldPos1034ui_story = var_189_5.localPosition
			end

			local var_189_7 = 0.001

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_7 then
				local var_189_8 = (arg_186_1.time_ - var_189_6) / var_189_7
				local var_189_9 = Vector3.New(-0.7, -0.93, -6)

				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1034ui_story, var_189_9, var_189_8)

				local var_189_10 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_10.x, var_189_10.y, var_189_10.z)

				local var_189_11 = var_189_5.localEulerAngles

				var_189_11.z = 0
				var_189_11.x = 0
				var_189_5.localEulerAngles = var_189_11
			end

			if arg_186_1.time_ >= var_189_6 + var_189_7 and arg_186_1.time_ < var_189_6 + var_189_7 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_189_12 = manager.ui.mainCamera.transform.position - var_189_5.position

				var_189_5.forward = Vector3.New(var_189_12.x, var_189_12.y, var_189_12.z)

				local var_189_13 = var_189_5.localEulerAngles

				var_189_13.z = 0
				var_189_13.x = 0
				var_189_5.localEulerAngles = var_189_13
			end

			local var_189_14 = arg_186_1.actors_["1034ui_story"]
			local var_189_15 = 0

			if var_189_15 < arg_186_1.time_ and arg_186_1.time_ <= var_189_15 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1034ui_story == nil then
				arg_186_1.var_.characterEffect1034ui_story = var_189_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_16 = 0.200000002980232

			if var_189_15 <= arg_186_1.time_ and arg_186_1.time_ < var_189_15 + var_189_16 and not isNil(var_189_14) then
				local var_189_17 = (arg_186_1.time_ - var_189_15) / var_189_16

				if arg_186_1.var_.characterEffect1034ui_story and not isNil(var_189_14) then
					arg_186_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_15 + var_189_16 and arg_186_1.time_ < var_189_15 + var_189_16 + arg_189_0 and not isNil(var_189_14) and arg_186_1.var_.characterEffect1034ui_story then
				arg_186_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_189_18 = 0

			if var_189_18 < arg_186_1.time_ and arg_186_1.time_ <= var_189_18 + arg_189_0 then
				arg_186_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_189_19 = 0

			if var_189_19 < arg_186_1.time_ and arg_186_1.time_ <= var_189_19 + arg_189_0 then
				arg_186_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_20 = 0
			local var_189_21 = 0.4

			if var_189_20 < arg_186_1.time_ and arg_186_1.time_ <= var_189_20 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_22 = arg_186_1:FormatText(StoryNameCfg[1109].name)

				arg_186_1.leftNameTxt_.text = var_189_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_23 = arg_186_1:GetWordFromCfg(939062043)
				local var_189_24 = arg_186_1:FormatText(var_189_23.content)

				arg_186_1.text_.text = var_189_24

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_25 = 16
				local var_189_26 = utf8.len(var_189_24)
				local var_189_27 = var_189_25 <= 0 and var_189_21 or var_189_21 * (var_189_26 / var_189_25)

				if var_189_27 > 0 and var_189_21 < var_189_27 then
					arg_186_1.talkMaxDuration = var_189_27

					if var_189_27 + var_189_20 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_27 + var_189_20
					end
				end

				arg_186_1.text_.text = var_189_24
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_28 = math.max(var_189_21, arg_186_1.talkMaxDuration)

			if var_189_20 <= arg_186_1.time_ and arg_186_1.time_ < var_189_20 + var_189_28 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_20) / var_189_28

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_20 + var_189_28 and arg_186_1.time_ < var_189_20 + var_189_28 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play939062044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 939062044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play939062045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["6148ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos6148ui_story = var_193_0.localPosition

				local var_193_2 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_2 then
					var_193_2:EnableDynamicBone(false)
				end
			end

			local var_193_3 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_3 then
				local var_193_4 = (arg_190_1.time_ - var_193_1) / var_193_3
				local var_193_5 = Vector3.New(0.7, -0.985, -6)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos6148ui_story, var_193_5, var_193_4)

				local var_193_6 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_6.x, var_193_6.y, var_193_6.z)

				local var_193_7 = var_193_0.localEulerAngles

				var_193_7.z = 0
				var_193_7.x = 0
				var_193_0.localEulerAngles = var_193_7
			end

			if arg_190_1.time_ >= var_193_1 + var_193_3 and arg_190_1.time_ < var_193_1 + var_193_3 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_193_8 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_8.x, var_193_8.y, var_193_8.z)

				local var_193_9 = var_193_0.localEulerAngles

				var_193_9.z = 0
				var_193_9.x = 0
				var_193_0.localEulerAngles = var_193_9

				local var_193_10 = GameObjectTools.GetOrAddComponent(var_193_0.gameObject, typeof(DynamicBoneHelper))

				if var_193_10 then
					var_193_10:EnableDynamicBone(true)
				end
			end

			local var_193_11 = arg_190_1.actors_["6148ui_story"]
			local var_193_12 = 0

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect6148ui_story == nil then
				arg_190_1.var_.characterEffect6148ui_story = var_193_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_13 = 0.200000002980232

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_13 and not isNil(var_193_11) then
				local var_193_14 = (arg_190_1.time_ - var_193_12) / var_193_13

				if arg_190_1.var_.characterEffect6148ui_story and not isNil(var_193_11) then
					arg_190_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_12 + var_193_13 and arg_190_1.time_ < var_193_12 + var_193_13 + arg_193_0 and not isNil(var_193_11) and arg_190_1.var_.characterEffect6148ui_story then
				arg_190_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_193_15 = arg_190_1.actors_["1034ui_story"]
			local var_193_16 = 0

			if var_193_16 < arg_190_1.time_ and arg_190_1.time_ <= var_193_16 + arg_193_0 and not isNil(var_193_15) and arg_190_1.var_.characterEffect1034ui_story == nil then
				arg_190_1.var_.characterEffect1034ui_story = var_193_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_17 = 0.200000002980232

			if var_193_16 <= arg_190_1.time_ and arg_190_1.time_ < var_193_16 + var_193_17 and not isNil(var_193_15) then
				local var_193_18 = (arg_190_1.time_ - var_193_16) / var_193_17

				if arg_190_1.var_.characterEffect1034ui_story and not isNil(var_193_15) then
					local var_193_19 = Mathf.Lerp(0, 0.5, var_193_18)

					arg_190_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1034ui_story.fillRatio = var_193_19
				end
			end

			if arg_190_1.time_ >= var_193_16 + var_193_17 and arg_190_1.time_ < var_193_16 + var_193_17 + arg_193_0 and not isNil(var_193_15) and arg_190_1.var_.characterEffect1034ui_story then
				local var_193_20 = 0.5

				arg_190_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1034ui_story.fillRatio = var_193_20
			end

			local var_193_21 = 0

			if var_193_21 < arg_190_1.time_ and arg_190_1.time_ <= var_193_21 + arg_193_0 then
				arg_190_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_193_22 = 0

			if var_193_22 < arg_190_1.time_ and arg_190_1.time_ <= var_193_22 + arg_193_0 then
				arg_190_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_193_23 = 0
			local var_193_24 = 0.575

			if var_193_23 < arg_190_1.time_ and arg_190_1.time_ <= var_193_23 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_25 = arg_190_1:FormatText(StoryNameCfg[1488].name)

				arg_190_1.leftNameTxt_.text = var_193_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_26 = arg_190_1:GetWordFromCfg(939062044)
				local var_193_27 = arg_190_1:FormatText(var_193_26.content)

				arg_190_1.text_.text = var_193_27

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_28 = 23
				local var_193_29 = utf8.len(var_193_27)
				local var_193_30 = var_193_28 <= 0 and var_193_24 or var_193_24 * (var_193_29 / var_193_28)

				if var_193_30 > 0 and var_193_24 < var_193_30 then
					arg_190_1.talkMaxDuration = var_193_30

					if var_193_30 + var_193_23 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_30 + var_193_23
					end
				end

				arg_190_1.text_.text = var_193_27
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_31 = math.max(var_193_24, arg_190_1.talkMaxDuration)

			if var_193_23 <= arg_190_1.time_ and arg_190_1.time_ < var_193_23 + var_193_31 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_23) / var_193_31

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_23 + var_193_31 and arg_190_1.time_ < var_193_23 + var_193_31 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play939062045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 939062045
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play939062046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1034ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(-0.7, -0.93, -6)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1034ui_story"]
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1034ui_story == nil then
				arg_194_1.var_.characterEffect1034ui_story = var_197_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_11 = 0.200000002980232

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 and not isNil(var_197_9) then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11

				if arg_194_1.var_.characterEffect1034ui_story and not isNil(var_197_9) then
					arg_194_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 and not isNil(var_197_9) and arg_194_1.var_.characterEffect1034ui_story then
				arg_194_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_197_13 = arg_194_1.actors_["6148ui_story"]
			local var_197_14 = 0

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 and not isNil(var_197_13) and arg_194_1.var_.characterEffect6148ui_story == nil then
				arg_194_1.var_.characterEffect6148ui_story = var_197_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_15 = 0.200000002980232

			if var_197_14 <= arg_194_1.time_ and arg_194_1.time_ < var_197_14 + var_197_15 and not isNil(var_197_13) then
				local var_197_16 = (arg_194_1.time_ - var_197_14) / var_197_15

				if arg_194_1.var_.characterEffect6148ui_story and not isNil(var_197_13) then
					local var_197_17 = Mathf.Lerp(0, 0.5, var_197_16)

					arg_194_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_194_1.var_.characterEffect6148ui_story.fillRatio = var_197_17
				end
			end

			if arg_194_1.time_ >= var_197_14 + var_197_15 and arg_194_1.time_ < var_197_14 + var_197_15 + arg_197_0 and not isNil(var_197_13) and arg_194_1.var_.characterEffect6148ui_story then
				local var_197_18 = 0.5

				arg_194_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_194_1.var_.characterEffect6148ui_story.fillRatio = var_197_18
			end

			local var_197_19 = 0

			if var_197_19 < arg_194_1.time_ and arg_194_1.time_ <= var_197_19 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_197_20 = 0

			if var_197_20 < arg_194_1.time_ and arg_194_1.time_ <= var_197_20 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_197_21 = 0
			local var_197_22 = 0.575

			if var_197_21 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_23 = arg_194_1:FormatText(StoryNameCfg[1109].name)

				arg_194_1.leftNameTxt_.text = var_197_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_24 = arg_194_1:GetWordFromCfg(939062045)
				local var_197_25 = arg_194_1:FormatText(var_197_24.content)

				arg_194_1.text_.text = var_197_25

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_26 = 23
				local var_197_27 = utf8.len(var_197_25)
				local var_197_28 = var_197_26 <= 0 and var_197_22 or var_197_22 * (var_197_27 / var_197_26)

				if var_197_28 > 0 and var_197_22 < var_197_28 then
					arg_194_1.talkMaxDuration = var_197_28

					if var_197_28 + var_197_21 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_28 + var_197_21
					end
				end

				arg_194_1.text_.text = var_197_25
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_29 = math.max(var_197_22, arg_194_1.talkMaxDuration)

			if var_197_21 <= arg_194_1.time_ and arg_194_1.time_ < var_197_21 + var_197_29 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_21) / var_197_29

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_21 + var_197_29 and arg_194_1.time_ < var_197_21 + var_197_29 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play939062046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 939062046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play939062047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["6148ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos6148ui_story = var_201_0.localPosition

				local var_201_2 = GameObjectTools.GetOrAddComponent(var_201_0.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(false)
				end
			end

			local var_201_3 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_3 then
				local var_201_4 = (arg_198_1.time_ - var_201_1) / var_201_3
				local var_201_5 = Vector3.New(0.7, -0.985, -6)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos6148ui_story, var_201_5, var_201_4)

				local var_201_6 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_6.x, var_201_6.y, var_201_6.z)

				local var_201_7 = var_201_0.localEulerAngles

				var_201_7.z = 0
				var_201_7.x = 0
				var_201_0.localEulerAngles = var_201_7
			end

			if arg_198_1.time_ >= var_201_1 + var_201_3 and arg_198_1.time_ < var_201_1 + var_201_3 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_201_8 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_8.x, var_201_8.y, var_201_8.z)

				local var_201_9 = var_201_0.localEulerAngles

				var_201_9.z = 0
				var_201_9.x = 0
				var_201_0.localEulerAngles = var_201_9

				local var_201_10 = GameObjectTools.GetOrAddComponent(var_201_0.gameObject, typeof(DynamicBoneHelper))

				if var_201_10 then
					var_201_10:EnableDynamicBone(true)
				end
			end

			local var_201_11 = arg_198_1.actors_["6148ui_story"]
			local var_201_12 = 0

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 and not isNil(var_201_11) and arg_198_1.var_.characterEffect6148ui_story == nil then
				arg_198_1.var_.characterEffect6148ui_story = var_201_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_13 = 0.200000002980232

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_13 and not isNil(var_201_11) then
				local var_201_14 = (arg_198_1.time_ - var_201_12) / var_201_13

				if arg_198_1.var_.characterEffect6148ui_story and not isNil(var_201_11) then
					arg_198_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_12 + var_201_13 and arg_198_1.time_ < var_201_12 + var_201_13 + arg_201_0 and not isNil(var_201_11) and arg_198_1.var_.characterEffect6148ui_story then
				arg_198_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_201_15 = arg_198_1.actors_["1034ui_story"]
			local var_201_16 = 0

			if var_201_16 < arg_198_1.time_ and arg_198_1.time_ <= var_201_16 + arg_201_0 and not isNil(var_201_15) and arg_198_1.var_.characterEffect1034ui_story == nil then
				arg_198_1.var_.characterEffect1034ui_story = var_201_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_17 = 0.200000002980232

			if var_201_16 <= arg_198_1.time_ and arg_198_1.time_ < var_201_16 + var_201_17 and not isNil(var_201_15) then
				local var_201_18 = (arg_198_1.time_ - var_201_16) / var_201_17

				if arg_198_1.var_.characterEffect1034ui_story and not isNil(var_201_15) then
					local var_201_19 = Mathf.Lerp(0, 0.5, var_201_18)

					arg_198_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1034ui_story.fillRatio = var_201_19
				end
			end

			if arg_198_1.time_ >= var_201_16 + var_201_17 and arg_198_1.time_ < var_201_16 + var_201_17 + arg_201_0 and not isNil(var_201_15) and arg_198_1.var_.characterEffect1034ui_story then
				local var_201_20 = 0.5

				arg_198_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1034ui_story.fillRatio = var_201_20
			end

			local var_201_21 = 0

			if var_201_21 < arg_198_1.time_ and arg_198_1.time_ <= var_201_21 + arg_201_0 then
				arg_198_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_201_22 = 0
			local var_201_23 = 0.575

			if var_201_22 < arg_198_1.time_ and arg_198_1.time_ <= var_201_22 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_24 = arg_198_1:FormatText(StoryNameCfg[1488].name)

				arg_198_1.leftNameTxt_.text = var_201_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_25 = arg_198_1:GetWordFromCfg(939062046)
				local var_201_26 = arg_198_1:FormatText(var_201_25.content)

				arg_198_1.text_.text = var_201_26

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_27 = 23
				local var_201_28 = utf8.len(var_201_26)
				local var_201_29 = var_201_27 <= 0 and var_201_23 or var_201_23 * (var_201_28 / var_201_27)

				if var_201_29 > 0 and var_201_23 < var_201_29 then
					arg_198_1.talkMaxDuration = var_201_29

					if var_201_29 + var_201_22 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_29 + var_201_22
					end
				end

				arg_198_1.text_.text = var_201_26
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_30 = math.max(var_201_23, arg_198_1.talkMaxDuration)

			if var_201_22 <= arg_198_1.time_ and arg_198_1.time_ < var_201_22 + var_201_30 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_22) / var_201_30

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_22 + var_201_30 and arg_198_1.time_ < var_201_22 + var_201_30 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play939062047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 939062047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play939062048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["6148ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos6148ui_story = var_205_0.localPosition

				local var_205_2 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(false)
				end
			end

			local var_205_3 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_3 then
				local var_205_4 = (arg_202_1.time_ - var_205_1) / var_205_3
				local var_205_5 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos6148ui_story, var_205_5, var_205_4)

				local var_205_6 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_6.x, var_205_6.y, var_205_6.z)

				local var_205_7 = var_205_0.localEulerAngles

				var_205_7.z = 0
				var_205_7.x = 0
				var_205_0.localEulerAngles = var_205_7
			end

			if arg_202_1.time_ >= var_205_1 + var_205_3 and arg_202_1.time_ < var_205_1 + var_205_3 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_8 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_8.x, var_205_8.y, var_205_8.z)

				local var_205_9 = var_205_0.localEulerAngles

				var_205_9.z = 0
				var_205_9.x = 0
				var_205_0.localEulerAngles = var_205_9

				local var_205_10 = GameObjectTools.GetOrAddComponent(var_205_0.gameObject, typeof(DynamicBoneHelper))

				if var_205_10 then
					var_205_10:EnableDynamicBone(true)
				end
			end

			local var_205_11 = arg_202_1.actors_["1034ui_story"].transform
			local var_205_12 = 0

			if var_205_12 < arg_202_1.time_ and arg_202_1.time_ <= var_205_12 + arg_205_0 then
				arg_202_1.var_.moveOldPos1034ui_story = var_205_11.localPosition
			end

			local var_205_13 = 0.001

			if var_205_12 <= arg_202_1.time_ and arg_202_1.time_ < var_205_12 + var_205_13 then
				local var_205_14 = (arg_202_1.time_ - var_205_12) / var_205_13
				local var_205_15 = Vector3.New(0, 100, 0)

				var_205_11.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1034ui_story, var_205_15, var_205_14)

				local var_205_16 = manager.ui.mainCamera.transform.position - var_205_11.position

				var_205_11.forward = Vector3.New(var_205_16.x, var_205_16.y, var_205_16.z)

				local var_205_17 = var_205_11.localEulerAngles

				var_205_17.z = 0
				var_205_17.x = 0
				var_205_11.localEulerAngles = var_205_17
			end

			if arg_202_1.time_ >= var_205_12 + var_205_13 and arg_202_1.time_ < var_205_12 + var_205_13 + arg_205_0 then
				var_205_11.localPosition = Vector3.New(0, 100, 0)

				local var_205_18 = manager.ui.mainCamera.transform.position - var_205_11.position

				var_205_11.forward = Vector3.New(var_205_18.x, var_205_18.y, var_205_18.z)

				local var_205_19 = var_205_11.localEulerAngles

				var_205_19.z = 0
				var_205_19.x = 0
				var_205_11.localEulerAngles = var_205_19
			end

			local var_205_20 = arg_202_1.actors_["6148ui_story"]
			local var_205_21 = 0

			if var_205_21 < arg_202_1.time_ and arg_202_1.time_ <= var_205_21 + arg_205_0 and not isNil(var_205_20) and arg_202_1.var_.characterEffect6148ui_story == nil then
				arg_202_1.var_.characterEffect6148ui_story = var_205_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_22 = 0.200000002980232

			if var_205_21 <= arg_202_1.time_ and arg_202_1.time_ < var_205_21 + var_205_22 and not isNil(var_205_20) then
				local var_205_23 = (arg_202_1.time_ - var_205_21) / var_205_22

				if arg_202_1.var_.characterEffect6148ui_story and not isNil(var_205_20) then
					local var_205_24 = Mathf.Lerp(0, 0.5, var_205_23)

					arg_202_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_202_1.var_.characterEffect6148ui_story.fillRatio = var_205_24
				end
			end

			if arg_202_1.time_ >= var_205_21 + var_205_22 and arg_202_1.time_ < var_205_21 + var_205_22 + arg_205_0 and not isNil(var_205_20) and arg_202_1.var_.characterEffect6148ui_story then
				local var_205_25 = 0.5

				arg_202_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_202_1.var_.characterEffect6148ui_story.fillRatio = var_205_25
			end

			local var_205_26 = 0
			local var_205_27 = 0.775

			if var_205_26 < arg_202_1.time_ and arg_202_1.time_ <= var_205_26 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_28 = arg_202_1:GetWordFromCfg(939062047)
				local var_205_29 = arg_202_1:FormatText(var_205_28.content)

				arg_202_1.text_.text = var_205_29

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_30 = 31
				local var_205_31 = utf8.len(var_205_29)
				local var_205_32 = var_205_30 <= 0 and var_205_27 or var_205_27 * (var_205_31 / var_205_30)

				if var_205_32 > 0 and var_205_27 < var_205_32 then
					arg_202_1.talkMaxDuration = var_205_32

					if var_205_32 + var_205_26 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_32 + var_205_26
					end
				end

				arg_202_1.text_.text = var_205_29
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_33 = math.max(var_205_27, arg_202_1.talkMaxDuration)

			if var_205_26 <= arg_202_1.time_ and arg_202_1.time_ < var_205_26 + var_205_33 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_26) / var_205_33

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_26 + var_205_33 and arg_202_1.time_ < var_205_26 + var_205_33 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play939062048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 939062048
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play939062049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1034ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(-0.7, -0.93, -6)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(-0.7, -0.93, -6)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1034ui_story"]
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1034ui_story == nil then
				arg_206_1.var_.characterEffect1034ui_story = var_209_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 and not isNil(var_209_9) then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11

				if arg_206_1.var_.characterEffect1034ui_story and not isNil(var_209_9) then
					arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 and not isNil(var_209_9) and arg_206_1.var_.characterEffect1034ui_story then
				arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_209_13 = 0

			if var_209_13 < arg_206_1.time_ and arg_206_1.time_ <= var_209_13 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_209_14 = 0

			if var_209_14 < arg_206_1.time_ and arg_206_1.time_ <= var_209_14 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_209_15 = 0
			local var_209_16 = 0.8

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1109].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(939062048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 32
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_23 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_23 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_23

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_23 and arg_206_1.time_ < var_209_15 + var_209_23 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play939062049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 939062049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play939062050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["6148ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos6148ui_story = var_213_0.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_3 then
				local var_213_4 = (arg_210_1.time_ - var_213_1) / var_213_3
				local var_213_5 = Vector3.New(0.7, -0.985, -6)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos6148ui_story, var_213_5, var_213_4)

				local var_213_6 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_6.x, var_213_6.y, var_213_6.z)

				local var_213_7 = var_213_0.localEulerAngles

				var_213_7.z = 0
				var_213_7.x = 0
				var_213_0.localEulerAngles = var_213_7
			end

			if arg_210_1.time_ >= var_213_1 + var_213_3 and arg_210_1.time_ < var_213_1 + var_213_3 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_213_8 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_8.x, var_213_8.y, var_213_8.z)

				local var_213_9 = var_213_0.localEulerAngles

				var_213_9.z = 0
				var_213_9.x = 0
				var_213_0.localEulerAngles = var_213_9

				local var_213_10 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_10 then
					var_213_10:EnableDynamicBone(true)
				end
			end

			local var_213_11 = arg_210_1.actors_["6148ui_story"]
			local var_213_12 = 0

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect6148ui_story == nil then
				arg_210_1.var_.characterEffect6148ui_story = var_213_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_13 = 0.200000002980232

			if var_213_12 <= arg_210_1.time_ and arg_210_1.time_ < var_213_12 + var_213_13 and not isNil(var_213_11) then
				local var_213_14 = (arg_210_1.time_ - var_213_12) / var_213_13

				if arg_210_1.var_.characterEffect6148ui_story and not isNil(var_213_11) then
					arg_210_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_12 + var_213_13 and arg_210_1.time_ < var_213_12 + var_213_13 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect6148ui_story then
				arg_210_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_213_15 = arg_210_1.actors_["1034ui_story"]
			local var_213_16 = 0

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 and not isNil(var_213_15) and arg_210_1.var_.characterEffect1034ui_story == nil then
				arg_210_1.var_.characterEffect1034ui_story = var_213_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_17 = 0.200000002980232

			if var_213_16 <= arg_210_1.time_ and arg_210_1.time_ < var_213_16 + var_213_17 and not isNil(var_213_15) then
				local var_213_18 = (arg_210_1.time_ - var_213_16) / var_213_17

				if arg_210_1.var_.characterEffect1034ui_story and not isNil(var_213_15) then
					local var_213_19 = Mathf.Lerp(0, 0.5, var_213_18)

					arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1034ui_story.fillRatio = var_213_19
				end
			end

			if arg_210_1.time_ >= var_213_16 + var_213_17 and arg_210_1.time_ < var_213_16 + var_213_17 + arg_213_0 and not isNil(var_213_15) and arg_210_1.var_.characterEffect1034ui_story then
				local var_213_20 = 0.5

				arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1034ui_story.fillRatio = var_213_20
			end

			local var_213_21 = 0

			if var_213_21 < arg_210_1.time_ and arg_210_1.time_ <= var_213_21 + arg_213_0 then
				arg_210_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_213_22 = 0
			local var_213_23 = 0.25

			if var_213_22 < arg_210_1.time_ and arg_210_1.time_ <= var_213_22 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_24 = arg_210_1:FormatText(StoryNameCfg[1488].name)

				arg_210_1.leftNameTxt_.text = var_213_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_25 = arg_210_1:GetWordFromCfg(939062049)
				local var_213_26 = arg_210_1:FormatText(var_213_25.content)

				arg_210_1.text_.text = var_213_26

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_27 = 10
				local var_213_28 = utf8.len(var_213_26)
				local var_213_29 = var_213_27 <= 0 and var_213_23 or var_213_23 * (var_213_28 / var_213_27)

				if var_213_29 > 0 and var_213_23 < var_213_29 then
					arg_210_1.talkMaxDuration = var_213_29

					if var_213_29 + var_213_22 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_29 + var_213_22
					end
				end

				arg_210_1.text_.text = var_213_26
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_30 = math.max(var_213_23, arg_210_1.talkMaxDuration)

			if var_213_22 <= arg_210_1.time_ and arg_210_1.time_ < var_213_22 + var_213_30 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_22) / var_213_30

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_22 + var_213_30 and arg_210_1.time_ < var_213_22 + var_213_30 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play939062050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 939062050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play939062051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = "1211ui_story"

			if arg_214_1.actors_[var_217_0] == nil then
				local var_217_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_217_1) then
					local var_217_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_214_1.stage_.transform)

					var_217_2.name = var_217_0
					var_217_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_214_1.actors_[var_217_0] = var_217_2

					local var_217_3 = var_217_2:GetComponentInChildren(typeof(CharacterEffect))

					var_217_3.enabled = true

					local var_217_4 = GameObjectTools.GetOrAddComponent(var_217_2, typeof(DynamicBoneHelper))

					if var_217_4 then
						var_217_4:EnableDynamicBone(false)
					end

					arg_214_1:ShowWeapon(var_217_3.transform, false)

					arg_214_1.var_[var_217_0 .. "Animator"] = var_217_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_214_1.var_[var_217_0 .. "Animator"].applyRootMotion = true
					arg_214_1.var_[var_217_0 .. "LipSync"] = var_217_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_217_5 = arg_214_1.actors_["1211ui_story"].transform
			local var_217_6 = 0

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.var_.moveOldPos1211ui_story = var_217_5.localPosition
			end

			local var_217_7 = 0.001

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_7 then
				local var_217_8 = (arg_214_1.time_ - var_217_6) / var_217_7
				local var_217_9 = Vector3.New(-0.7, -0.67, -6.07)

				var_217_5.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1211ui_story, var_217_9, var_217_8)

				local var_217_10 = manager.ui.mainCamera.transform.position - var_217_5.position

				var_217_5.forward = Vector3.New(var_217_10.x, var_217_10.y, var_217_10.z)

				local var_217_11 = var_217_5.localEulerAngles

				var_217_11.z = 0
				var_217_11.x = 0
				var_217_5.localEulerAngles = var_217_11
			end

			if arg_214_1.time_ >= var_217_6 + var_217_7 and arg_214_1.time_ < var_217_6 + var_217_7 + arg_217_0 then
				var_217_5.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_217_12 = manager.ui.mainCamera.transform.position - var_217_5.position

				var_217_5.forward = Vector3.New(var_217_12.x, var_217_12.y, var_217_12.z)

				local var_217_13 = var_217_5.localEulerAngles

				var_217_13.z = 0
				var_217_13.x = 0
				var_217_5.localEulerAngles = var_217_13
			end

			local var_217_14 = arg_214_1.actors_["1034ui_story"].transform
			local var_217_15 = 0

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.var_.moveOldPos1034ui_story = var_217_14.localPosition
			end

			local var_217_16 = 0.001

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_16 then
				local var_217_17 = (arg_214_1.time_ - var_217_15) / var_217_16
				local var_217_18 = Vector3.New(0, 100, 0)

				var_217_14.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1034ui_story, var_217_18, var_217_17)

				local var_217_19 = manager.ui.mainCamera.transform.position - var_217_14.position

				var_217_14.forward = Vector3.New(var_217_19.x, var_217_19.y, var_217_19.z)

				local var_217_20 = var_217_14.localEulerAngles

				var_217_20.z = 0
				var_217_20.x = 0
				var_217_14.localEulerAngles = var_217_20
			end

			if arg_214_1.time_ >= var_217_15 + var_217_16 and arg_214_1.time_ < var_217_15 + var_217_16 + arg_217_0 then
				var_217_14.localPosition = Vector3.New(0, 100, 0)

				local var_217_21 = manager.ui.mainCamera.transform.position - var_217_14.position

				var_217_14.forward = Vector3.New(var_217_21.x, var_217_21.y, var_217_21.z)

				local var_217_22 = var_217_14.localEulerAngles

				var_217_22.z = 0
				var_217_22.x = 0
				var_217_14.localEulerAngles = var_217_22
			end

			local var_217_23 = arg_214_1.actors_["1211ui_story"]
			local var_217_24 = 0

			if var_217_24 < arg_214_1.time_ and arg_214_1.time_ <= var_217_24 + arg_217_0 and not isNil(var_217_23) and arg_214_1.var_.characterEffect1211ui_story == nil then
				arg_214_1.var_.characterEffect1211ui_story = var_217_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_25 = 0.200000002980232

			if var_217_24 <= arg_214_1.time_ and arg_214_1.time_ < var_217_24 + var_217_25 and not isNil(var_217_23) then
				local var_217_26 = (arg_214_1.time_ - var_217_24) / var_217_25

				if arg_214_1.var_.characterEffect1211ui_story and not isNil(var_217_23) then
					arg_214_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_24 + var_217_25 and arg_214_1.time_ < var_217_24 + var_217_25 + arg_217_0 and not isNil(var_217_23) and arg_214_1.var_.characterEffect1211ui_story then
				arg_214_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_217_27 = arg_214_1.actors_["6148ui_story"]
			local var_217_28 = 0

			if var_217_28 < arg_214_1.time_ and arg_214_1.time_ <= var_217_28 + arg_217_0 and not isNil(var_217_27) and arg_214_1.var_.characterEffect6148ui_story == nil then
				arg_214_1.var_.characterEffect6148ui_story = var_217_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_29 = 0.200000002980232

			if var_217_28 <= arg_214_1.time_ and arg_214_1.time_ < var_217_28 + var_217_29 and not isNil(var_217_27) then
				local var_217_30 = (arg_214_1.time_ - var_217_28) / var_217_29

				if arg_214_1.var_.characterEffect6148ui_story and not isNil(var_217_27) then
					local var_217_31 = Mathf.Lerp(0, 0.5, var_217_30)

					arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_214_1.var_.characterEffect6148ui_story.fillRatio = var_217_31
				end
			end

			if arg_214_1.time_ >= var_217_28 + var_217_29 and arg_214_1.time_ < var_217_28 + var_217_29 + arg_217_0 and not isNil(var_217_27) and arg_214_1.var_.characterEffect6148ui_story then
				local var_217_32 = 0.5

				arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_214_1.var_.characterEffect6148ui_story.fillRatio = var_217_32
			end

			local var_217_33 = 0

			if var_217_33 < arg_214_1.time_ and arg_214_1.time_ <= var_217_33 + arg_217_0 then
				arg_214_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_217_34 = 0

			if var_217_34 < arg_214_1.time_ and arg_214_1.time_ <= var_217_34 + arg_217_0 then
				arg_214_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_217_35 = 0
			local var_217_36 = 0.55

			if var_217_35 < arg_214_1.time_ and arg_214_1.time_ <= var_217_35 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_37 = arg_214_1:FormatText(StoryNameCfg[37].name)

				arg_214_1.leftNameTxt_.text = var_217_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_38 = arg_214_1:GetWordFromCfg(939062050)
				local var_217_39 = arg_214_1:FormatText(var_217_38.content)

				arg_214_1.text_.text = var_217_39

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_40 = 22
				local var_217_41 = utf8.len(var_217_39)
				local var_217_42 = var_217_40 <= 0 and var_217_36 or var_217_36 * (var_217_41 / var_217_40)

				if var_217_42 > 0 and var_217_36 < var_217_42 then
					arg_214_1.talkMaxDuration = var_217_42

					if var_217_42 + var_217_35 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_42 + var_217_35
					end
				end

				arg_214_1.text_.text = var_217_39
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_43 = math.max(var_217_36, arg_214_1.talkMaxDuration)

			if var_217_35 <= arg_214_1.time_ and arg_214_1.time_ < var_217_35 + var_217_43 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_35) / var_217_43

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_35 + var_217_43 and arg_214_1.time_ < var_217_35 + var_217_43 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play939062051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 939062051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play939062052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1211ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1211ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1211ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = arg_218_1.actors_["6148ui_story"].transform
			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1.var_.moveOldPos6148ui_story = var_221_9.localPosition

				local var_221_11 = GameObjectTools.GetOrAddComponent(var_221_9.gameObject, typeof(DynamicBoneHelper))

				if var_221_11 then
					var_221_11:EnableDynamicBone(false)
				end
			end

			local var_221_12 = 0.001

			if var_221_10 <= arg_218_1.time_ and arg_218_1.time_ < var_221_10 + var_221_12 then
				local var_221_13 = (arg_218_1.time_ - var_221_10) / var_221_12
				local var_221_14 = Vector3.New(0, 100, 0)

				var_221_9.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos6148ui_story, var_221_14, var_221_13)

				local var_221_15 = manager.ui.mainCamera.transform.position - var_221_9.position

				var_221_9.forward = Vector3.New(var_221_15.x, var_221_15.y, var_221_15.z)

				local var_221_16 = var_221_9.localEulerAngles

				var_221_16.z = 0
				var_221_16.x = 0
				var_221_9.localEulerAngles = var_221_16
			end

			if arg_218_1.time_ >= var_221_10 + var_221_12 and arg_218_1.time_ < var_221_10 + var_221_12 + arg_221_0 then
				var_221_9.localPosition = Vector3.New(0, 100, 0)

				local var_221_17 = manager.ui.mainCamera.transform.position - var_221_9.position

				var_221_9.forward = Vector3.New(var_221_17.x, var_221_17.y, var_221_17.z)

				local var_221_18 = var_221_9.localEulerAngles

				var_221_18.z = 0
				var_221_18.x = 0
				var_221_9.localEulerAngles = var_221_18

				local var_221_19 = GameObjectTools.GetOrAddComponent(var_221_9.gameObject, typeof(DynamicBoneHelper))

				if var_221_19 then
					var_221_19:EnableDynamicBone(true)
				end
			end

			local var_221_20 = arg_218_1.actors_["1211ui_story"]
			local var_221_21 = 0

			if var_221_21 < arg_218_1.time_ and arg_218_1.time_ <= var_221_21 + arg_221_0 and not isNil(var_221_20) and arg_218_1.var_.characterEffect1211ui_story == nil then
				arg_218_1.var_.characterEffect1211ui_story = var_221_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_22 = 0.200000002980232

			if var_221_21 <= arg_218_1.time_ and arg_218_1.time_ < var_221_21 + var_221_22 and not isNil(var_221_20) then
				local var_221_23 = (arg_218_1.time_ - var_221_21) / var_221_22

				if arg_218_1.var_.characterEffect1211ui_story and not isNil(var_221_20) then
					local var_221_24 = Mathf.Lerp(0, 0.5, var_221_23)

					arg_218_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1211ui_story.fillRatio = var_221_24
				end
			end

			if arg_218_1.time_ >= var_221_21 + var_221_22 and arg_218_1.time_ < var_221_21 + var_221_22 + arg_221_0 and not isNil(var_221_20) and arg_218_1.var_.characterEffect1211ui_story then
				local var_221_25 = 0.5

				arg_218_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1211ui_story.fillRatio = var_221_25
			end

			local var_221_26 = 0
			local var_221_27 = 0.675

			if var_221_26 < arg_218_1.time_ and arg_218_1.time_ <= var_221_26 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_28 = arg_218_1:GetWordFromCfg(939062051)
				local var_221_29 = arg_218_1:FormatText(var_221_28.content)

				arg_218_1.text_.text = var_221_29

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_30 = 27
				local var_221_31 = utf8.len(var_221_29)
				local var_221_32 = var_221_30 <= 0 and var_221_27 or var_221_27 * (var_221_31 / var_221_30)

				if var_221_32 > 0 and var_221_27 < var_221_32 then
					arg_218_1.talkMaxDuration = var_221_32

					if var_221_32 + var_221_26 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_32 + var_221_26
					end
				end

				arg_218_1.text_.text = var_221_29
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_33 = math.max(var_221_27, arg_218_1.talkMaxDuration)

			if var_221_26 <= arg_218_1.time_ and arg_218_1.time_ < var_221_26 + var_221_33 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_26) / var_221_33

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_26 + var_221_33 and arg_218_1.time_ < var_221_26 + var_221_33 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play939062052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 939062052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play939062053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1054ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos1054ui_story = var_225_0.localPosition

				local var_225_2 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(false)
				end
			end

			local var_225_3 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_3 then
				local var_225_4 = (arg_222_1.time_ - var_225_1) / var_225_3
				local var_225_5 = Vector3.New(0, -0.985, -6)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1054ui_story, var_225_5, var_225_4)

				local var_225_6 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_6.x, var_225_6.y, var_225_6.z)

				local var_225_7 = var_225_0.localEulerAngles

				var_225_7.z = 0
				var_225_7.x = 0
				var_225_0.localEulerAngles = var_225_7
			end

			if arg_222_1.time_ >= var_225_1 + var_225_3 and arg_222_1.time_ < var_225_1 + var_225_3 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_225_8 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_8.x, var_225_8.y, var_225_8.z)

				local var_225_9 = var_225_0.localEulerAngles

				var_225_9.z = 0
				var_225_9.x = 0
				var_225_0.localEulerAngles = var_225_9

				local var_225_10 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_10 then
					var_225_10:EnableDynamicBone(true)
				end
			end

			local var_225_11 = arg_222_1.actors_["1054ui_story"]
			local var_225_12 = 0

			if var_225_12 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1054ui_story == nil then
				arg_222_1.var_.characterEffect1054ui_story = var_225_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_13 = 0.200000002980232

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_13 and not isNil(var_225_11) then
				local var_225_14 = (arg_222_1.time_ - var_225_12) / var_225_13

				if arg_222_1.var_.characterEffect1054ui_story and not isNil(var_225_11) then
					arg_222_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_12 + var_225_13 and arg_222_1.time_ < var_225_12 + var_225_13 + arg_225_0 and not isNil(var_225_11) and arg_222_1.var_.characterEffect1054ui_story then
				arg_222_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_225_15 = 0

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_225_16 = 0

			if var_225_16 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_225_17 = 0
			local var_225_18 = 0.8

			if var_225_17 < arg_222_1.time_ and arg_222_1.time_ <= var_225_17 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_19 = arg_222_1:FormatText(StoryNameCfg[1487].name)

				arg_222_1.leftNameTxt_.text = var_225_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_20 = arg_222_1:GetWordFromCfg(939062052)
				local var_225_21 = arg_222_1:FormatText(var_225_20.content)

				arg_222_1.text_.text = var_225_21

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_22 = 32
				local var_225_23 = utf8.len(var_225_21)
				local var_225_24 = var_225_22 <= 0 and var_225_18 or var_225_18 * (var_225_23 / var_225_22)

				if var_225_24 > 0 and var_225_18 < var_225_24 then
					arg_222_1.talkMaxDuration = var_225_24

					if var_225_24 + var_225_17 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_24 + var_225_17
					end
				end

				arg_222_1.text_.text = var_225_21
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_25 = math.max(var_225_18, arg_222_1.talkMaxDuration)

			if var_225_17 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_25 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_17) / var_225_25

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_17 + var_225_25 and arg_222_1.time_ < var_225_17 + var_225_25 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play939062053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 939062053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play939062054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1054ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1054ui_story == nil then
				arg_226_1.var_.characterEffect1054ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1054ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1054ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1054ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1054ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.375

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(939062053)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 15
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play939062054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 939062054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play939062055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.7

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_2 = arg_230_1:GetWordFromCfg(939062054)
				local var_233_3 = arg_230_1:FormatText(var_233_2.content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 28
				local var_233_5 = utf8.len(var_233_3)
				local var_233_6 = var_233_4 <= 0 and var_233_1 or var_233_1 * (var_233_5 / var_233_4)

				if var_233_6 > 0 and var_233_1 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_7 and arg_230_1.time_ < var_233_0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play939062055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 939062055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play939062056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1054ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1054ui_story = var_237_0.localPosition

				local var_237_2 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(false)
				end
			end

			local var_237_3 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_3 then
				local var_237_4 = (arg_234_1.time_ - var_237_1) / var_237_3
				local var_237_5 = Vector3.New(0, -0.985, -6)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1054ui_story, var_237_5, var_237_4)

				local var_237_6 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_6.x, var_237_6.y, var_237_6.z)

				local var_237_7 = var_237_0.localEulerAngles

				var_237_7.z = 0
				var_237_7.x = 0
				var_237_0.localEulerAngles = var_237_7
			end

			if arg_234_1.time_ >= var_237_1 + var_237_3 and arg_234_1.time_ < var_237_1 + var_237_3 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_237_8 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_8.x, var_237_8.y, var_237_8.z)

				local var_237_9 = var_237_0.localEulerAngles

				var_237_9.z = 0
				var_237_9.x = 0
				var_237_0.localEulerAngles = var_237_9

				local var_237_10 = GameObjectTools.GetOrAddComponent(var_237_0.gameObject, typeof(DynamicBoneHelper))

				if var_237_10 then
					var_237_10:EnableDynamicBone(true)
				end
			end

			local var_237_11 = arg_234_1.actors_["1054ui_story"]
			local var_237_12 = 0

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1054ui_story == nil then
				arg_234_1.var_.characterEffect1054ui_story = var_237_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_13 = 0.200000002980232

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_13 and not isNil(var_237_11) then
				local var_237_14 = (arg_234_1.time_ - var_237_12) / var_237_13

				if arg_234_1.var_.characterEffect1054ui_story and not isNil(var_237_11) then
					arg_234_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_12 + var_237_13 and arg_234_1.time_ < var_237_12 + var_237_13 + arg_237_0 and not isNil(var_237_11) and arg_234_1.var_.characterEffect1054ui_story then
				arg_234_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_237_15 = 0

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_17 = 0
			local var_237_18 = 1.025

			if var_237_17 < arg_234_1.time_ and arg_234_1.time_ <= var_237_17 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_19 = arg_234_1:FormatText(StoryNameCfg[1487].name)

				arg_234_1.leftNameTxt_.text = var_237_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_20 = arg_234_1:GetWordFromCfg(939062055)
				local var_237_21 = arg_234_1:FormatText(var_237_20.content)

				arg_234_1.text_.text = var_237_21

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_22 = 41
				local var_237_23 = utf8.len(var_237_21)
				local var_237_24 = var_237_22 <= 0 and var_237_18 or var_237_18 * (var_237_23 / var_237_22)

				if var_237_24 > 0 and var_237_18 < var_237_24 then
					arg_234_1.talkMaxDuration = var_237_24

					if var_237_24 + var_237_17 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_24 + var_237_17
					end
				end

				arg_234_1.text_.text = var_237_21
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_25 = math.max(var_237_18, arg_234_1.talkMaxDuration)

			if var_237_17 <= arg_234_1.time_ and arg_234_1.time_ < var_237_17 + var_237_25 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_17) / var_237_25

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_17 + var_237_25 and arg_234_1.time_ < var_237_17 + var_237_25 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play939062056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 939062056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play939062057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1054ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1054ui_story == nil then
				arg_238_1.var_.characterEffect1054ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1054ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1054ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1054ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1054ui_story.fillRatio = var_241_5
			end

			local var_241_6 = 0
			local var_241_7 = 0.875

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_9 = arg_238_1:GetWordFromCfg(939062056)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 35
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_14 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_14 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_14

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_14 and arg_238_1.time_ < var_241_6 + var_241_14 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play939062057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 939062057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play939062058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1054ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1054ui_story = var_245_0.localPosition

				local var_245_2 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(false)
				end
			end

			local var_245_3 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_3 then
				local var_245_4 = (arg_242_1.time_ - var_245_1) / var_245_3
				local var_245_5 = Vector3.New(0, -0.985, -6)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1054ui_story, var_245_5, var_245_4)

				local var_245_6 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_6.x, var_245_6.y, var_245_6.z)

				local var_245_7 = var_245_0.localEulerAngles

				var_245_7.z = 0
				var_245_7.x = 0
				var_245_0.localEulerAngles = var_245_7
			end

			if arg_242_1.time_ >= var_245_1 + var_245_3 and arg_242_1.time_ < var_245_1 + var_245_3 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_245_8 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_8.x, var_245_8.y, var_245_8.z)

				local var_245_9 = var_245_0.localEulerAngles

				var_245_9.z = 0
				var_245_9.x = 0
				var_245_0.localEulerAngles = var_245_9

				local var_245_10 = GameObjectTools.GetOrAddComponent(var_245_0.gameObject, typeof(DynamicBoneHelper))

				if var_245_10 then
					var_245_10:EnableDynamicBone(true)
				end
			end

			local var_245_11 = arg_242_1.actors_["1054ui_story"]
			local var_245_12 = 0

			if var_245_12 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect1054ui_story == nil then
				arg_242_1.var_.characterEffect1054ui_story = var_245_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_13 = 0.200000002980232

			if var_245_12 <= arg_242_1.time_ and arg_242_1.time_ < var_245_12 + var_245_13 and not isNil(var_245_11) then
				local var_245_14 = (arg_242_1.time_ - var_245_12) / var_245_13

				if arg_242_1.var_.characterEffect1054ui_story and not isNil(var_245_11) then
					arg_242_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_12 + var_245_13 and arg_242_1.time_ < var_245_12 + var_245_13 + arg_245_0 and not isNil(var_245_11) and arg_242_1.var_.characterEffect1054ui_story then
				arg_242_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_245_15 = 0

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_245_16 = 0
			local var_245_17 = 0.7

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_18 = arg_242_1:FormatText(StoryNameCfg[1487].name)

				arg_242_1.leftNameTxt_.text = var_245_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_19 = arg_242_1:GetWordFromCfg(939062057)
				local var_245_20 = arg_242_1:FormatText(var_245_19.content)

				arg_242_1.text_.text = var_245_20

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_21 = 28
				local var_245_22 = utf8.len(var_245_20)
				local var_245_23 = var_245_21 <= 0 and var_245_17 or var_245_17 * (var_245_22 / var_245_21)

				if var_245_23 > 0 and var_245_17 < var_245_23 then
					arg_242_1.talkMaxDuration = var_245_23

					if var_245_23 + var_245_16 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_16
					end
				end

				arg_242_1.text_.text = var_245_20
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_24 = math.max(var_245_17, arg_242_1.talkMaxDuration)

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_24 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_16) / var_245_24

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_16 + var_245_24 and arg_242_1.time_ < var_245_16 + var_245_24 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play939062058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 939062058
		arg_246_1.duration_ = 1

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"

			SetActive(arg_246_1.choicesGo_, true)

			for iter_247_0, iter_247_1 in ipairs(arg_246_1.choices_) do
				local var_247_0 = iter_247_0 <= 1

				SetActive(iter_247_1.go, var_247_0)
			end

			arg_246_1.choices_[1].txt.text = arg_246_1:FormatText(StoryChoiceCfg[1683].name)
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play939062059(arg_246_1)
			end

			arg_246_1:RecordChoiceLog(939062058, 1683)
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1054ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1054ui_story == nil then
				arg_246_1.var_.characterEffect1054ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1054ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1054ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1054ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1054ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.allBtn_.enabled = false
			end

			local var_249_7 = 1

			if arg_246_1.time_ >= var_249_6 + var_249_7 and arg_246_1.time_ < var_249_6 + var_249_7 + arg_249_0 then
				arg_246_1.allBtn_.enabled = true
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play939062059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 939062059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play939062060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1054ui_story"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos1054ui_story = var_253_0.localPosition

				local var_253_2 = GameObjectTools.GetOrAddComponent(var_253_0.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(false)
				end
			end

			local var_253_3 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_3 then
				local var_253_4 = (arg_250_1.time_ - var_253_1) / var_253_3
				local var_253_5 = Vector3.New(0, 100, 0)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1054ui_story, var_253_5, var_253_4)

				local var_253_6 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_6.x, var_253_6.y, var_253_6.z)

				local var_253_7 = var_253_0.localEulerAngles

				var_253_7.z = 0
				var_253_7.x = 0
				var_253_0.localEulerAngles = var_253_7
			end

			if arg_250_1.time_ >= var_253_1 + var_253_3 and arg_250_1.time_ < var_253_1 + var_253_3 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, 100, 0)

				local var_253_8 = manager.ui.mainCamera.transform.position - var_253_0.position

				var_253_0.forward = Vector3.New(var_253_8.x, var_253_8.y, var_253_8.z)

				local var_253_9 = var_253_0.localEulerAngles

				var_253_9.z = 0
				var_253_9.x = 0
				var_253_0.localEulerAngles = var_253_9

				local var_253_10 = GameObjectTools.GetOrAddComponent(var_253_0.gameObject, typeof(DynamicBoneHelper))

				if var_253_10 then
					var_253_10:EnableDynamicBone(true)
				end
			end

			local var_253_11 = 0
			local var_253_12 = 0.9

			if var_253_11 < arg_250_1.time_ and arg_250_1.time_ <= var_253_11 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_13 = arg_250_1:GetWordFromCfg(939062059)
				local var_253_14 = arg_250_1:FormatText(var_253_13.content)

				arg_250_1.text_.text = var_253_14

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_15 = 36
				local var_253_16 = utf8.len(var_253_14)
				local var_253_17 = var_253_15 <= 0 and var_253_12 or var_253_12 * (var_253_16 / var_253_15)

				if var_253_17 > 0 and var_253_12 < var_253_17 then
					arg_250_1.talkMaxDuration = var_253_17

					if var_253_17 + var_253_11 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_17 + var_253_11
					end
				end

				arg_250_1.text_.text = var_253_14
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_18 = math.max(var_253_12, arg_250_1.talkMaxDuration)

			if var_253_11 <= arg_250_1.time_ and arg_250_1.time_ < var_253_11 + var_253_18 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_11) / var_253_18

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_11 + var_253_18 and arg_250_1.time_ < var_253_11 + var_253_18 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play939062060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 939062060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play939062061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1047ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = arg_254_1.actors_["1047ui_story"]
			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = var_257_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_11 = 0.200000002980232

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_11 and not isNil(var_257_9) then
				local var_257_12 = (arg_254_1.time_ - var_257_10) / var_257_11

				if arg_254_1.var_.characterEffect1047ui_story and not isNil(var_257_9) then
					arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_10 + var_257_11 and arg_254_1.time_ < var_257_10 + var_257_11 + arg_257_0 and not isNil(var_257_9) and arg_254_1.var_.characterEffect1047ui_story then
				arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_257_13 = 0

			if var_257_13 < arg_254_1.time_ and arg_254_1.time_ <= var_257_13 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_257_14 = 0

			if var_257_14 < arg_254_1.time_ and arg_254_1.time_ <= var_257_14 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_257_15 = 0
			local var_257_16 = 0.225

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[1296].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(939062060)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 9
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_23 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_23 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_23

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_23 and arg_254_1.time_ < var_257_15 + var_257_23 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play939062061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 939062061
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play939062062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["6148ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos6148ui_story = var_261_0.localPosition

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end
			end

			local var_261_3 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_3 then
				local var_261_4 = (arg_258_1.time_ - var_261_1) / var_261_3
				local var_261_5 = Vector3.New(0.7, -0.985, -6)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos6148ui_story, var_261_5, var_261_4)

				local var_261_6 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_6.x, var_261_6.y, var_261_6.z)

				local var_261_7 = var_261_0.localEulerAngles

				var_261_7.z = 0
				var_261_7.x = 0
				var_261_0.localEulerAngles = var_261_7
			end

			if arg_258_1.time_ >= var_261_1 + var_261_3 and arg_258_1.time_ < var_261_1 + var_261_3 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_261_8 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_8.x, var_261_8.y, var_261_8.z)

				local var_261_9 = var_261_0.localEulerAngles

				var_261_9.z = 0
				var_261_9.x = 0
				var_261_0.localEulerAngles = var_261_9

				local var_261_10 = GameObjectTools.GetOrAddComponent(var_261_0.gameObject, typeof(DynamicBoneHelper))

				if var_261_10 then
					var_261_10:EnableDynamicBone(true)
				end
			end

			local var_261_11 = arg_258_1.actors_["6148ui_story"]
			local var_261_12 = 0

			if var_261_12 < arg_258_1.time_ and arg_258_1.time_ <= var_261_12 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect6148ui_story == nil then
				arg_258_1.var_.characterEffect6148ui_story = var_261_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_13 = 0.200000002980232

			if var_261_12 <= arg_258_1.time_ and arg_258_1.time_ < var_261_12 + var_261_13 and not isNil(var_261_11) then
				local var_261_14 = (arg_258_1.time_ - var_261_12) / var_261_13

				if arg_258_1.var_.characterEffect6148ui_story and not isNil(var_261_11) then
					arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_12 + var_261_13 and arg_258_1.time_ < var_261_12 + var_261_13 + arg_261_0 and not isNil(var_261_11) and arg_258_1.var_.characterEffect6148ui_story then
				arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_261_15 = arg_258_1.actors_["1047ui_story"]
			local var_261_16 = 0

			if var_261_16 < arg_258_1.time_ and arg_258_1.time_ <= var_261_16 + arg_261_0 and not isNil(var_261_15) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = var_261_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_17 = 0.200000002980232

			if var_261_16 <= arg_258_1.time_ and arg_258_1.time_ < var_261_16 + var_261_17 and not isNil(var_261_15) then
				local var_261_18 = (arg_258_1.time_ - var_261_16) / var_261_17

				if arg_258_1.var_.characterEffect1047ui_story and not isNil(var_261_15) then
					local var_261_19 = Mathf.Lerp(0, 0.5, var_261_18)

					arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1047ui_story.fillRatio = var_261_19
				end
			end

			if arg_258_1.time_ >= var_261_16 + var_261_17 and arg_258_1.time_ < var_261_16 + var_261_17 + arg_261_0 and not isNil(var_261_15) and arg_258_1.var_.characterEffect1047ui_story then
				local var_261_20 = 0.5

				arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1047ui_story.fillRatio = var_261_20
			end

			local var_261_21 = 0

			if var_261_21 < arg_258_1.time_ and arg_258_1.time_ <= var_261_21 + arg_261_0 then
				arg_258_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_261_22 = 0

			if var_261_22 < arg_258_1.time_ and arg_258_1.time_ <= var_261_22 + arg_261_0 then
				arg_258_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_261_23 = 0
			local var_261_24 = 0.35

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_25 = arg_258_1:FormatText(StoryNameCfg[1488].name)

				arg_258_1.leftNameTxt_.text = var_261_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_26 = arg_258_1:GetWordFromCfg(939062061)
				local var_261_27 = arg_258_1:FormatText(var_261_26.content)

				arg_258_1.text_.text = var_261_27

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_28 = 14
				local var_261_29 = utf8.len(var_261_27)
				local var_261_30 = var_261_28 <= 0 and var_261_24 or var_261_24 * (var_261_29 / var_261_28)

				if var_261_30 > 0 and var_261_24 < var_261_30 then
					arg_258_1.talkMaxDuration = var_261_30

					if var_261_30 + var_261_23 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_30 + var_261_23
					end
				end

				arg_258_1.text_.text = var_261_27
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_31 = math.max(var_261_24, arg_258_1.talkMaxDuration)

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_31 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_23) / var_261_31

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_23 + var_261_31 and arg_258_1.time_ < var_261_23 + var_261_31 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play939062062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 939062062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play939062063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["6148ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos6148ui_story = var_265_0.localPosition

				local var_265_2 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(false)
				end
			end

			local var_265_3 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_3 then
				local var_265_4 = (arg_262_1.time_ - var_265_1) / var_265_3
				local var_265_5 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos6148ui_story, var_265_5, var_265_4)

				local var_265_6 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_6.x, var_265_6.y, var_265_6.z)

				local var_265_7 = var_265_0.localEulerAngles

				var_265_7.z = 0
				var_265_7.x = 0
				var_265_0.localEulerAngles = var_265_7
			end

			if arg_262_1.time_ >= var_265_1 + var_265_3 and arg_262_1.time_ < var_265_1 + var_265_3 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_8 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_8.x, var_265_8.y, var_265_8.z)

				local var_265_9 = var_265_0.localEulerAngles

				var_265_9.z = 0
				var_265_9.x = 0
				var_265_0.localEulerAngles = var_265_9

				local var_265_10 = GameObjectTools.GetOrAddComponent(var_265_0.gameObject, typeof(DynamicBoneHelper))

				if var_265_10 then
					var_265_10:EnableDynamicBone(true)
				end
			end

			local var_265_11 = arg_262_1.actors_["1047ui_story"].transform
			local var_265_12 = 0

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = var_265_11.localPosition
			end

			local var_265_13 = 0.001

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_13 then
				local var_265_14 = (arg_262_1.time_ - var_265_12) / var_265_13
				local var_265_15 = Vector3.New(0, 100, 0)

				var_265_11.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, var_265_15, var_265_14)

				local var_265_16 = manager.ui.mainCamera.transform.position - var_265_11.position

				var_265_11.forward = Vector3.New(var_265_16.x, var_265_16.y, var_265_16.z)

				local var_265_17 = var_265_11.localEulerAngles

				var_265_17.z = 0
				var_265_17.x = 0
				var_265_11.localEulerAngles = var_265_17
			end

			if arg_262_1.time_ >= var_265_12 + var_265_13 and arg_262_1.time_ < var_265_12 + var_265_13 + arg_265_0 then
				var_265_11.localPosition = Vector3.New(0, 100, 0)

				local var_265_18 = manager.ui.mainCamera.transform.position - var_265_11.position

				var_265_11.forward = Vector3.New(var_265_18.x, var_265_18.y, var_265_18.z)

				local var_265_19 = var_265_11.localEulerAngles

				var_265_19.z = 0
				var_265_19.x = 0
				var_265_11.localEulerAngles = var_265_19
			end

			local var_265_20 = arg_262_1.actors_["6148ui_story"]
			local var_265_21 = 0

			if var_265_21 < arg_262_1.time_ and arg_262_1.time_ <= var_265_21 + arg_265_0 and not isNil(var_265_20) and arg_262_1.var_.characterEffect6148ui_story == nil then
				arg_262_1.var_.characterEffect6148ui_story = var_265_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_22 = 0.200000002980232

			if var_265_21 <= arg_262_1.time_ and arg_262_1.time_ < var_265_21 + var_265_22 and not isNil(var_265_20) then
				local var_265_23 = (arg_262_1.time_ - var_265_21) / var_265_22

				if arg_262_1.var_.characterEffect6148ui_story and not isNil(var_265_20) then
					local var_265_24 = Mathf.Lerp(0, 0.5, var_265_23)

					arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_262_1.var_.characterEffect6148ui_story.fillRatio = var_265_24
				end
			end

			if arg_262_1.time_ >= var_265_21 + var_265_22 and arg_262_1.time_ < var_265_21 + var_265_22 + arg_265_0 and not isNil(var_265_20) and arg_262_1.var_.characterEffect6148ui_story then
				local var_265_25 = 0.5

				arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_262_1.var_.characterEffect6148ui_story.fillRatio = var_265_25
			end

			local var_265_26 = 0
			local var_265_27 = 0.575

			if var_265_26 < arg_262_1.time_ and arg_262_1.time_ <= var_265_26 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_28 = arg_262_1:GetWordFromCfg(939062062)
				local var_265_29 = arg_262_1:FormatText(var_265_28.content)

				arg_262_1.text_.text = var_265_29

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_30 = 23
				local var_265_31 = utf8.len(var_265_29)
				local var_265_32 = var_265_30 <= 0 and var_265_27 or var_265_27 * (var_265_31 / var_265_30)

				if var_265_32 > 0 and var_265_27 < var_265_32 then
					arg_262_1.talkMaxDuration = var_265_32

					if var_265_32 + var_265_26 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_32 + var_265_26
					end
				end

				arg_262_1.text_.text = var_265_29
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_33 = math.max(var_265_27, arg_262_1.talkMaxDuration)

			if var_265_26 <= arg_262_1.time_ and arg_262_1.time_ < var_265_26 + var_265_33 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_26) / var_265_33

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_26 + var_265_33 and arg_262_1.time_ < var_265_26 + var_265_33 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play939062063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 939062063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play939062064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1054ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1054ui_story = var_269_0.localPosition

				local var_269_2 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(false)
				end
			end

			local var_269_3 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_3 then
				local var_269_4 = (arg_266_1.time_ - var_269_1) / var_269_3
				local var_269_5 = Vector3.New(-0.7, -0.985, -6)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1054ui_story, var_269_5, var_269_4)

				local var_269_6 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_6.x, var_269_6.y, var_269_6.z)

				local var_269_7 = var_269_0.localEulerAngles

				var_269_7.z = 0
				var_269_7.x = 0
				var_269_0.localEulerAngles = var_269_7
			end

			if arg_266_1.time_ >= var_269_1 + var_269_3 and arg_266_1.time_ < var_269_1 + var_269_3 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_269_8 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_8.x, var_269_8.y, var_269_8.z)

				local var_269_9 = var_269_0.localEulerAngles

				var_269_9.z = 0
				var_269_9.x = 0
				var_269_0.localEulerAngles = var_269_9

				local var_269_10 = GameObjectTools.GetOrAddComponent(var_269_0.gameObject, typeof(DynamicBoneHelper))

				if var_269_10 then
					var_269_10:EnableDynamicBone(true)
				end
			end

			local var_269_11 = arg_266_1.actors_["1054ui_story"]
			local var_269_12 = 0

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect1054ui_story == nil then
				arg_266_1.var_.characterEffect1054ui_story = var_269_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_13 = 0.200000002980232

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_13 and not isNil(var_269_11) then
				local var_269_14 = (arg_266_1.time_ - var_269_12) / var_269_13

				if arg_266_1.var_.characterEffect1054ui_story and not isNil(var_269_11) then
					arg_266_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_12 + var_269_13 and arg_266_1.time_ < var_269_12 + var_269_13 + arg_269_0 and not isNil(var_269_11) and arg_266_1.var_.characterEffect1054ui_story then
				arg_266_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_269_15 = 0

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_269_16 = 0

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_269_17 = 0
			local var_269_18 = 0.575

			if var_269_17 < arg_266_1.time_ and arg_266_1.time_ <= var_269_17 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_19 = arg_266_1:FormatText(StoryNameCfg[1487].name)

				arg_266_1.leftNameTxt_.text = var_269_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_20 = arg_266_1:GetWordFromCfg(939062063)
				local var_269_21 = arg_266_1:FormatText(var_269_20.content)

				arg_266_1.text_.text = var_269_21

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_22 = 23
				local var_269_23 = utf8.len(var_269_21)
				local var_269_24 = var_269_22 <= 0 and var_269_18 or var_269_18 * (var_269_23 / var_269_22)

				if var_269_24 > 0 and var_269_18 < var_269_24 then
					arg_266_1.talkMaxDuration = var_269_24

					if var_269_24 + var_269_17 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_24 + var_269_17
					end
				end

				arg_266_1.text_.text = var_269_21
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_18, arg_266_1.talkMaxDuration)

			if var_269_17 <= arg_266_1.time_ and arg_266_1.time_ < var_269_17 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_17) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_17 + var_269_25 and arg_266_1.time_ < var_269_17 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play939062064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 939062064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play939062065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = "1042ui_story"

			if arg_270_1.actors_[var_273_0] == nil then
				local var_273_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_273_1) then
					local var_273_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_270_1.stage_.transform)

					var_273_2.name = var_273_0
					var_273_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_270_1.actors_[var_273_0] = var_273_2

					local var_273_3 = var_273_2:GetComponentInChildren(typeof(CharacterEffect))

					var_273_3.enabled = true

					local var_273_4 = GameObjectTools.GetOrAddComponent(var_273_2, typeof(DynamicBoneHelper))

					if var_273_4 then
						var_273_4:EnableDynamicBone(false)
					end

					arg_270_1:ShowWeapon(var_273_3.transform, false)

					arg_270_1.var_[var_273_0 .. "Animator"] = var_273_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_270_1.var_[var_273_0 .. "Animator"].applyRootMotion = true
					arg_270_1.var_[var_273_0 .. "LipSync"] = var_273_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_273_5 = arg_270_1.actors_["1042ui_story"].transform
			local var_273_6 = 0

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.var_.moveOldPos1042ui_story = var_273_5.localPosition
			end

			local var_273_7 = 0.001

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_7 then
				local var_273_8 = (arg_270_1.time_ - var_273_6) / var_273_7
				local var_273_9 = Vector3.New(0.7, -1.06, -6.2)

				var_273_5.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1042ui_story, var_273_9, var_273_8)

				local var_273_10 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_10.x, var_273_10.y, var_273_10.z)

				local var_273_11 = var_273_5.localEulerAngles

				var_273_11.z = 0
				var_273_11.x = 0
				var_273_5.localEulerAngles = var_273_11
			end

			if arg_270_1.time_ >= var_273_6 + var_273_7 and arg_270_1.time_ < var_273_6 + var_273_7 + arg_273_0 then
				var_273_5.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_273_12 = manager.ui.mainCamera.transform.position - var_273_5.position

				var_273_5.forward = Vector3.New(var_273_12.x, var_273_12.y, var_273_12.z)

				local var_273_13 = var_273_5.localEulerAngles

				var_273_13.z = 0
				var_273_13.x = 0
				var_273_5.localEulerAngles = var_273_13
			end

			local var_273_14 = arg_270_1.actors_["1042ui_story"]
			local var_273_15 = 0

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 and not isNil(var_273_14) and arg_270_1.var_.characterEffect1042ui_story == nil then
				arg_270_1.var_.characterEffect1042ui_story = var_273_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_16 = 0.200000002980232

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_16 and not isNil(var_273_14) then
				local var_273_17 = (arg_270_1.time_ - var_273_15) / var_273_16

				if arg_270_1.var_.characterEffect1042ui_story and not isNil(var_273_14) then
					arg_270_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_15 + var_273_16 and arg_270_1.time_ < var_273_15 + var_273_16 + arg_273_0 and not isNil(var_273_14) and arg_270_1.var_.characterEffect1042ui_story then
				arg_270_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_273_18 = arg_270_1.actors_["1054ui_story"]
			local var_273_19 = 0

			if var_273_19 < arg_270_1.time_ and arg_270_1.time_ <= var_273_19 + arg_273_0 and not isNil(var_273_18) and arg_270_1.var_.characterEffect1054ui_story == nil then
				arg_270_1.var_.characterEffect1054ui_story = var_273_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_20 = 0.200000002980232

			if var_273_19 <= arg_270_1.time_ and arg_270_1.time_ < var_273_19 + var_273_20 and not isNil(var_273_18) then
				local var_273_21 = (arg_270_1.time_ - var_273_19) / var_273_20

				if arg_270_1.var_.characterEffect1054ui_story and not isNil(var_273_18) then
					local var_273_22 = Mathf.Lerp(0, 0.5, var_273_21)

					arg_270_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1054ui_story.fillRatio = var_273_22
				end
			end

			if arg_270_1.time_ >= var_273_19 + var_273_20 and arg_270_1.time_ < var_273_19 + var_273_20 + arg_273_0 and not isNil(var_273_18) and arg_270_1.var_.characterEffect1054ui_story then
				local var_273_23 = 0.5

				arg_270_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1054ui_story.fillRatio = var_273_23
			end

			local var_273_24 = 0

			if var_273_24 < arg_270_1.time_ and arg_270_1.time_ <= var_273_24 + arg_273_0 then
				arg_270_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_273_25 = 0

			if var_273_25 < arg_270_1.time_ and arg_270_1.time_ <= var_273_25 + arg_273_0 then
				arg_270_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_273_26 = 0
			local var_273_27 = 0.7

			if var_273_26 < arg_270_1.time_ and arg_270_1.time_ <= var_273_26 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_28 = arg_270_1:FormatText(StoryNameCfg[205].name)

				arg_270_1.leftNameTxt_.text = var_273_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_29 = arg_270_1:GetWordFromCfg(939062064)
				local var_273_30 = arg_270_1:FormatText(var_273_29.content)

				arg_270_1.text_.text = var_273_30

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_31 = 28
				local var_273_32 = utf8.len(var_273_30)
				local var_273_33 = var_273_31 <= 0 and var_273_27 or var_273_27 * (var_273_32 / var_273_31)

				if var_273_33 > 0 and var_273_27 < var_273_33 then
					arg_270_1.talkMaxDuration = var_273_33

					if var_273_33 + var_273_26 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_33 + var_273_26
					end
				end

				arg_270_1.text_.text = var_273_30
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_34 = math.max(var_273_27, arg_270_1.talkMaxDuration)

			if var_273_26 <= arg_270_1.time_ and arg_270_1.time_ < var_273_26 + var_273_34 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_26) / var_273_34

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_26 + var_273_34 and arg_270_1.time_ < var_273_26 + var_273_34 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play939062065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 939062065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play939062066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1042ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1042ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, 100, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1042ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, 100, 0)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1054ui_story"].transform
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 then
				arg_274_1.var_.moveOldPos1054ui_story = var_277_9.localPosition

				local var_277_11 = GameObjectTools.GetOrAddComponent(var_277_9.gameObject, typeof(DynamicBoneHelper))

				if var_277_11 then
					var_277_11:EnableDynamicBone(false)
				end
			end

			local var_277_12 = 0.001

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_12 then
				local var_277_13 = (arg_274_1.time_ - var_277_10) / var_277_12
				local var_277_14 = Vector3.New(0, 100, 0)

				var_277_9.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1054ui_story, var_277_14, var_277_13)

				local var_277_15 = manager.ui.mainCamera.transform.position - var_277_9.position

				var_277_9.forward = Vector3.New(var_277_15.x, var_277_15.y, var_277_15.z)

				local var_277_16 = var_277_9.localEulerAngles

				var_277_16.z = 0
				var_277_16.x = 0
				var_277_9.localEulerAngles = var_277_16
			end

			if arg_274_1.time_ >= var_277_10 + var_277_12 and arg_274_1.time_ < var_277_10 + var_277_12 + arg_277_0 then
				var_277_9.localPosition = Vector3.New(0, 100, 0)

				local var_277_17 = manager.ui.mainCamera.transform.position - var_277_9.position

				var_277_9.forward = Vector3.New(var_277_17.x, var_277_17.y, var_277_17.z)

				local var_277_18 = var_277_9.localEulerAngles

				var_277_18.z = 0
				var_277_18.x = 0
				var_277_9.localEulerAngles = var_277_18

				local var_277_19 = GameObjectTools.GetOrAddComponent(var_277_9.gameObject, typeof(DynamicBoneHelper))

				if var_277_19 then
					var_277_19:EnableDynamicBone(true)
				end
			end

			local var_277_20 = arg_274_1.actors_["1042ui_story"]
			local var_277_21 = 0

			if var_277_21 < arg_274_1.time_ and arg_274_1.time_ <= var_277_21 + arg_277_0 and not isNil(var_277_20) and arg_274_1.var_.characterEffect1042ui_story == nil then
				arg_274_1.var_.characterEffect1042ui_story = var_277_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_22 = 0.200000002980232

			if var_277_21 <= arg_274_1.time_ and arg_274_1.time_ < var_277_21 + var_277_22 and not isNil(var_277_20) then
				local var_277_23 = (arg_274_1.time_ - var_277_21) / var_277_22

				if arg_274_1.var_.characterEffect1042ui_story and not isNil(var_277_20) then
					local var_277_24 = Mathf.Lerp(0, 0.5, var_277_23)

					arg_274_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1042ui_story.fillRatio = var_277_24
				end
			end

			if arg_274_1.time_ >= var_277_21 + var_277_22 and arg_274_1.time_ < var_277_21 + var_277_22 + arg_277_0 and not isNil(var_277_20) and arg_274_1.var_.characterEffect1042ui_story then
				local var_277_25 = 0.5

				arg_274_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1042ui_story.fillRatio = var_277_25
			end

			local var_277_26 = 0
			local var_277_27 = 0.725

			if var_277_26 < arg_274_1.time_ and arg_274_1.time_ <= var_277_26 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_28 = arg_274_1:GetWordFromCfg(939062065)
				local var_277_29 = arg_274_1:FormatText(var_277_28.content)

				arg_274_1.text_.text = var_277_29

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_30 = 29
				local var_277_31 = utf8.len(var_277_29)
				local var_277_32 = var_277_30 <= 0 and var_277_27 or var_277_27 * (var_277_31 / var_277_30)

				if var_277_32 > 0 and var_277_27 < var_277_32 then
					arg_274_1.talkMaxDuration = var_277_32

					if var_277_32 + var_277_26 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_32 + var_277_26
					end
				end

				arg_274_1.text_.text = var_277_29
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_33 = math.max(var_277_27, arg_274_1.talkMaxDuration)

			if var_277_26 <= arg_274_1.time_ and arg_274_1.time_ < var_277_26 + var_277_33 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_26) / var_277_33

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_26 + var_277_33 and arg_274_1.time_ < var_277_26 + var_277_33 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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

		arg_274_1:InitPlayNodeList()
	end,
	Play939062066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 939062066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play939062067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["6148ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos6148ui_story = var_281_0.localPosition

				local var_281_2 = GameObjectTools.GetOrAddComponent(var_281_0.gameObject, typeof(DynamicBoneHelper))

				if var_281_2 then
					var_281_2:EnableDynamicBone(false)
				end
			end

			local var_281_3 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_3 then
				local var_281_4 = (arg_278_1.time_ - var_281_1) / var_281_3
				local var_281_5 = Vector3.New(-0.7, -0.985, -6)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos6148ui_story, var_281_5, var_281_4)

				local var_281_6 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_6.x, var_281_6.y, var_281_6.z)

				local var_281_7 = var_281_0.localEulerAngles

				var_281_7.z = 0
				var_281_7.x = 0
				var_281_0.localEulerAngles = var_281_7
			end

			if arg_278_1.time_ >= var_281_1 + var_281_3 and arg_278_1.time_ < var_281_1 + var_281_3 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_281_8 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_8.x, var_281_8.y, var_281_8.z)

				local var_281_9 = var_281_0.localEulerAngles

				var_281_9.z = 0
				var_281_9.x = 0
				var_281_0.localEulerAngles = var_281_9

				local var_281_10 = GameObjectTools.GetOrAddComponent(var_281_0.gameObject, typeof(DynamicBoneHelper))

				if var_281_10 then
					var_281_10:EnableDynamicBone(true)
				end
			end

			local var_281_11 = arg_278_1.actors_["6148ui_story"]
			local var_281_12 = 0

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 and not isNil(var_281_11) and arg_278_1.var_.characterEffect6148ui_story == nil then
				arg_278_1.var_.characterEffect6148ui_story = var_281_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_13 = 0.200000002980232

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_13 and not isNil(var_281_11) then
				local var_281_14 = (arg_278_1.time_ - var_281_12) / var_281_13

				if arg_278_1.var_.characterEffect6148ui_story and not isNil(var_281_11) then
					arg_278_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_12 + var_281_13 and arg_278_1.time_ < var_281_12 + var_281_13 + arg_281_0 and not isNil(var_281_11) and arg_278_1.var_.characterEffect6148ui_story then
				arg_278_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_281_15 = 0

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_281_16 = 0
			local var_281_17 = 0.425

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_18 = arg_278_1:FormatText(StoryNameCfg[1488].name)

				arg_278_1.leftNameTxt_.text = var_281_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_19 = arg_278_1:GetWordFromCfg(939062066)
				local var_281_20 = arg_278_1:FormatText(var_281_19.content)

				arg_278_1.text_.text = var_281_20

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_21 = 17
				local var_281_22 = utf8.len(var_281_20)
				local var_281_23 = var_281_21 <= 0 and var_281_17 or var_281_17 * (var_281_22 / var_281_21)

				if var_281_23 > 0 and var_281_17 < var_281_23 then
					arg_278_1.talkMaxDuration = var_281_23

					if var_281_23 + var_281_16 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_23 + var_281_16
					end
				end

				arg_278_1.text_.text = var_281_20
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_24 = math.max(var_281_17, arg_278_1.talkMaxDuration)

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_24 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_16) / var_281_24

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_16 + var_281_24 and arg_278_1.time_ < var_281_16 + var_281_24 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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

		arg_278_1:InitPlayNodeList()
	end,
	Play939062067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 939062067
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play939062068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1042ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1042ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0.7, -1.06, -6.2)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1042ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1042ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1042ui_story == nil then
				arg_282_1.var_.characterEffect1042ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1042ui_story and not isNil(var_285_9) then
					arg_282_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1042ui_story then
				arg_282_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_285_13 = arg_282_1.actors_["6148ui_story"]
			local var_285_14 = 0

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 and not isNil(var_285_13) and arg_282_1.var_.characterEffect6148ui_story == nil then
				arg_282_1.var_.characterEffect6148ui_story = var_285_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_15 = 0.200000002980232

			if var_285_14 <= arg_282_1.time_ and arg_282_1.time_ < var_285_14 + var_285_15 and not isNil(var_285_13) then
				local var_285_16 = (arg_282_1.time_ - var_285_14) / var_285_15

				if arg_282_1.var_.characterEffect6148ui_story and not isNil(var_285_13) then
					local var_285_17 = Mathf.Lerp(0, 0.5, var_285_16)

					arg_282_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_282_1.var_.characterEffect6148ui_story.fillRatio = var_285_17
				end
			end

			if arg_282_1.time_ >= var_285_14 + var_285_15 and arg_282_1.time_ < var_285_14 + var_285_15 + arg_285_0 and not isNil(var_285_13) and arg_282_1.var_.characterEffect6148ui_story then
				local var_285_18 = 0.5

				arg_282_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_282_1.var_.characterEffect6148ui_story.fillRatio = var_285_18
			end

			local var_285_19 = 0

			if var_285_19 < arg_282_1.time_ and arg_282_1.time_ <= var_285_19 + arg_285_0 then
				arg_282_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_285_20 = 0

			if var_285_20 < arg_282_1.time_ and arg_282_1.time_ <= var_285_20 + arg_285_0 then
				arg_282_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_285_21 = 0
			local var_285_22 = 0.625

			if var_285_21 < arg_282_1.time_ and arg_282_1.time_ <= var_285_21 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_23 = arg_282_1:FormatText(StoryNameCfg[205].name)

				arg_282_1.leftNameTxt_.text = var_285_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_24 = arg_282_1:GetWordFromCfg(939062067)
				local var_285_25 = arg_282_1:FormatText(var_285_24.content)

				arg_282_1.text_.text = var_285_25

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_26 = 25
				local var_285_27 = utf8.len(var_285_25)
				local var_285_28 = var_285_26 <= 0 and var_285_22 or var_285_22 * (var_285_27 / var_285_26)

				if var_285_28 > 0 and var_285_22 < var_285_28 then
					arg_282_1.talkMaxDuration = var_285_28

					if var_285_28 + var_285_21 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_28 + var_285_21
					end
				end

				arg_282_1.text_.text = var_285_25
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_29 = math.max(var_285_22, arg_282_1.talkMaxDuration)

			if var_285_21 <= arg_282_1.time_ and arg_282_1.time_ < var_285_21 + var_285_29 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_21) / var_285_29

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_21 + var_285_29 and arg_282_1.time_ < var_285_21 + var_285_29 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play939062068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 939062068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play939062069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1054ui_story"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos1054ui_story = var_289_0.localPosition

				local var_289_2 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(false)
				end
			end

			local var_289_3 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_3 then
				local var_289_4 = (arg_286_1.time_ - var_289_1) / var_289_3
				local var_289_5 = Vector3.New(-0.7, -0.985, -6)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1054ui_story, var_289_5, var_289_4)

				local var_289_6 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_6.x, var_289_6.y, var_289_6.z)

				local var_289_7 = var_289_0.localEulerAngles

				var_289_7.z = 0
				var_289_7.x = 0
				var_289_0.localEulerAngles = var_289_7
			end

			if arg_286_1.time_ >= var_289_1 + var_289_3 and arg_286_1.time_ < var_289_1 + var_289_3 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_289_8 = manager.ui.mainCamera.transform.position - var_289_0.position

				var_289_0.forward = Vector3.New(var_289_8.x, var_289_8.y, var_289_8.z)

				local var_289_9 = var_289_0.localEulerAngles

				var_289_9.z = 0
				var_289_9.x = 0
				var_289_0.localEulerAngles = var_289_9

				local var_289_10 = GameObjectTools.GetOrAddComponent(var_289_0.gameObject, typeof(DynamicBoneHelper))

				if var_289_10 then
					var_289_10:EnableDynamicBone(true)
				end
			end

			local var_289_11 = arg_286_1.actors_["6148ui_story"].transform
			local var_289_12 = 0

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.var_.moveOldPos6148ui_story = var_289_11.localPosition

				local var_289_13 = GameObjectTools.GetOrAddComponent(var_289_11.gameObject, typeof(DynamicBoneHelper))

				if var_289_13 then
					var_289_13:EnableDynamicBone(false)
				end
			end

			local var_289_14 = 0.001

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_14 then
				local var_289_15 = (arg_286_1.time_ - var_289_12) / var_289_14
				local var_289_16 = Vector3.New(0, 100, 0)

				var_289_11.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos6148ui_story, var_289_16, var_289_15)

				local var_289_17 = manager.ui.mainCamera.transform.position - var_289_11.position

				var_289_11.forward = Vector3.New(var_289_17.x, var_289_17.y, var_289_17.z)

				local var_289_18 = var_289_11.localEulerAngles

				var_289_18.z = 0
				var_289_18.x = 0
				var_289_11.localEulerAngles = var_289_18
			end

			if arg_286_1.time_ >= var_289_12 + var_289_14 and arg_286_1.time_ < var_289_12 + var_289_14 + arg_289_0 then
				var_289_11.localPosition = Vector3.New(0, 100, 0)

				local var_289_19 = manager.ui.mainCamera.transform.position - var_289_11.position

				var_289_11.forward = Vector3.New(var_289_19.x, var_289_19.y, var_289_19.z)

				local var_289_20 = var_289_11.localEulerAngles

				var_289_20.z = 0
				var_289_20.x = 0
				var_289_11.localEulerAngles = var_289_20

				local var_289_21 = GameObjectTools.GetOrAddComponent(var_289_11.gameObject, typeof(DynamicBoneHelper))

				if var_289_21 then
					var_289_21:EnableDynamicBone(true)
				end
			end

			local var_289_22 = arg_286_1.actors_["1054ui_story"]
			local var_289_23 = 0

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 and not isNil(var_289_22) and arg_286_1.var_.characterEffect1054ui_story == nil then
				arg_286_1.var_.characterEffect1054ui_story = var_289_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_24 = 0.200000002980232

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_24 and not isNil(var_289_22) then
				local var_289_25 = (arg_286_1.time_ - var_289_23) / var_289_24

				if arg_286_1.var_.characterEffect1054ui_story and not isNil(var_289_22) then
					arg_286_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_23 + var_289_24 and arg_286_1.time_ < var_289_23 + var_289_24 + arg_289_0 and not isNil(var_289_22) and arg_286_1.var_.characterEffect1054ui_story then
				arg_286_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_289_26 = arg_286_1.actors_["1042ui_story"]
			local var_289_27 = 0

			if var_289_27 < arg_286_1.time_ and arg_286_1.time_ <= var_289_27 + arg_289_0 and not isNil(var_289_26) and arg_286_1.var_.characterEffect1042ui_story == nil then
				arg_286_1.var_.characterEffect1042ui_story = var_289_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_28 = 0.200000002980232

			if var_289_27 <= arg_286_1.time_ and arg_286_1.time_ < var_289_27 + var_289_28 and not isNil(var_289_26) then
				local var_289_29 = (arg_286_1.time_ - var_289_27) / var_289_28

				if arg_286_1.var_.characterEffect1042ui_story and not isNil(var_289_26) then
					local var_289_30 = Mathf.Lerp(0, 0.5, var_289_29)

					arg_286_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1042ui_story.fillRatio = var_289_30
				end
			end

			if arg_286_1.time_ >= var_289_27 + var_289_28 and arg_286_1.time_ < var_289_27 + var_289_28 + arg_289_0 and not isNil(var_289_26) and arg_286_1.var_.characterEffect1042ui_story then
				local var_289_31 = 0.5

				arg_286_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1042ui_story.fillRatio = var_289_31
			end

			local var_289_32 = 0

			if var_289_32 < arg_286_1.time_ and arg_286_1.time_ <= var_289_32 + arg_289_0 then
				arg_286_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_289_33 = 0

			if var_289_33 < arg_286_1.time_ and arg_286_1.time_ <= var_289_33 + arg_289_0 then
				arg_286_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_289_34 = 0
			local var_289_35 = 0.15

			if var_289_34 < arg_286_1.time_ and arg_286_1.time_ <= var_289_34 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_36 = arg_286_1:FormatText(StoryNameCfg[1487].name)

				arg_286_1.leftNameTxt_.text = var_289_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_37 = arg_286_1:GetWordFromCfg(939062068)
				local var_289_38 = arg_286_1:FormatText(var_289_37.content)

				arg_286_1.text_.text = var_289_38

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_39 = 6
				local var_289_40 = utf8.len(var_289_38)
				local var_289_41 = var_289_39 <= 0 and var_289_35 or var_289_35 * (var_289_40 / var_289_39)

				if var_289_41 > 0 and var_289_35 < var_289_41 then
					arg_286_1.talkMaxDuration = var_289_41

					if var_289_41 + var_289_34 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_41 + var_289_34
					end
				end

				arg_286_1.text_.text = var_289_38
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_42 = math.max(var_289_35, arg_286_1.talkMaxDuration)

			if var_289_34 <= arg_286_1.time_ and arg_286_1.time_ < var_289_34 + var_289_42 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_34) / var_289_42

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_34 + var_289_42 and arg_286_1.time_ < var_289_34 + var_289_42 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play939062069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 939062069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play939062070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1248ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1248ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0.7, -0.775, -6.18)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1248ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0.7, -0.775, -6.18)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = arg_290_1.actors_["1042ui_story"].transform
			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 then
				arg_290_1.var_.moveOldPos1042ui_story = var_293_9.localPosition
			end

			local var_293_11 = 0.001

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_11 then
				local var_293_12 = (arg_290_1.time_ - var_293_10) / var_293_11
				local var_293_13 = Vector3.New(0, 100, 0)

				var_293_9.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1042ui_story, var_293_13, var_293_12)

				local var_293_14 = manager.ui.mainCamera.transform.position - var_293_9.position

				var_293_9.forward = Vector3.New(var_293_14.x, var_293_14.y, var_293_14.z)

				local var_293_15 = var_293_9.localEulerAngles

				var_293_15.z = 0
				var_293_15.x = 0
				var_293_9.localEulerAngles = var_293_15
			end

			if arg_290_1.time_ >= var_293_10 + var_293_11 and arg_290_1.time_ < var_293_10 + var_293_11 + arg_293_0 then
				var_293_9.localPosition = Vector3.New(0, 100, 0)

				local var_293_16 = manager.ui.mainCamera.transform.position - var_293_9.position

				var_293_9.forward = Vector3.New(var_293_16.x, var_293_16.y, var_293_16.z)

				local var_293_17 = var_293_9.localEulerAngles

				var_293_17.z = 0
				var_293_17.x = 0
				var_293_9.localEulerAngles = var_293_17
			end

			local var_293_18 = arg_290_1.actors_["1248ui_story"]
			local var_293_19 = 0

			if var_293_19 < arg_290_1.time_ and arg_290_1.time_ <= var_293_19 + arg_293_0 and not isNil(var_293_18) and arg_290_1.var_.characterEffect1248ui_story == nil then
				arg_290_1.var_.characterEffect1248ui_story = var_293_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_20 = 0.200000002980232

			if var_293_19 <= arg_290_1.time_ and arg_290_1.time_ < var_293_19 + var_293_20 and not isNil(var_293_18) then
				local var_293_21 = (arg_290_1.time_ - var_293_19) / var_293_20

				if arg_290_1.var_.characterEffect1248ui_story and not isNil(var_293_18) then
					arg_290_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_19 + var_293_20 and arg_290_1.time_ < var_293_19 + var_293_20 + arg_293_0 and not isNil(var_293_18) and arg_290_1.var_.characterEffect1248ui_story then
				arg_290_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_293_22 = arg_290_1.actors_["1054ui_story"]
			local var_293_23 = 0

			if var_293_23 < arg_290_1.time_ and arg_290_1.time_ <= var_293_23 + arg_293_0 and not isNil(var_293_22) and arg_290_1.var_.characterEffect1054ui_story == nil then
				arg_290_1.var_.characterEffect1054ui_story = var_293_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_24 = 0.200000002980232

			if var_293_23 <= arg_290_1.time_ and arg_290_1.time_ < var_293_23 + var_293_24 and not isNil(var_293_22) then
				local var_293_25 = (arg_290_1.time_ - var_293_23) / var_293_24

				if arg_290_1.var_.characterEffect1054ui_story and not isNil(var_293_22) then
					local var_293_26 = Mathf.Lerp(0, 0.5, var_293_25)

					arg_290_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1054ui_story.fillRatio = var_293_26
				end
			end

			if arg_290_1.time_ >= var_293_23 + var_293_24 and arg_290_1.time_ < var_293_23 + var_293_24 + arg_293_0 and not isNil(var_293_22) and arg_290_1.var_.characterEffect1054ui_story then
				local var_293_27 = 0.5

				arg_290_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1054ui_story.fillRatio = var_293_27
			end

			local var_293_28 = 0

			if var_293_28 < arg_290_1.time_ and arg_290_1.time_ <= var_293_28 + arg_293_0 then
				arg_290_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_1")
			end

			local var_293_29 = 0

			if var_293_29 < arg_290_1.time_ and arg_290_1.time_ <= var_293_29 + arg_293_0 then
				arg_290_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_293_30 = 0
			local var_293_31 = 0.625

			if var_293_30 < arg_290_1.time_ and arg_290_1.time_ <= var_293_30 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_32 = arg_290_1:FormatText(StoryNameCfg[8].name)

				arg_290_1.leftNameTxt_.text = var_293_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_33 = arg_290_1:GetWordFromCfg(939062069)
				local var_293_34 = arg_290_1:FormatText(var_293_33.content)

				arg_290_1.text_.text = var_293_34

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_35 = 25
				local var_293_36 = utf8.len(var_293_34)
				local var_293_37 = var_293_35 <= 0 and var_293_31 or var_293_31 * (var_293_36 / var_293_35)

				if var_293_37 > 0 and var_293_31 < var_293_37 then
					arg_290_1.talkMaxDuration = var_293_37

					if var_293_37 + var_293_30 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_37 + var_293_30
					end
				end

				arg_290_1.text_.text = var_293_34
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_38 = math.max(var_293_31, arg_290_1.talkMaxDuration)

			if var_293_30 <= arg_290_1.time_ and arg_290_1.time_ < var_293_30 + var_293_38 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_30) / var_293_38

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_30 + var_293_38 and arg_290_1.time_ < var_293_30 + var_293_38 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play939062070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 939062070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play939062071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1248ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1248ui_story == nil then
				arg_294_1.var_.characterEffect1248ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1248ui_story and not isNil(var_297_0) then
					local var_297_4 = Mathf.Lerp(0, 0.5, var_297_3)

					arg_294_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1248ui_story.fillRatio = var_297_4
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1248ui_story then
				local var_297_5 = 0.5

				arg_294_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1248ui_story.fillRatio = var_297_5
			end

			local var_297_6 = 0
			local var_297_7 = 0.425

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_8 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_8

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

				local var_297_9 = arg_294_1:GetWordFromCfg(939062070)
				local var_297_10 = arg_294_1:FormatText(var_297_9.content)

				arg_294_1.text_.text = var_297_10

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 17
				local var_297_12 = utf8.len(var_297_10)
				local var_297_13 = var_297_11 <= 0 and var_297_7 or var_297_7 * (var_297_12 / var_297_11)

				if var_297_13 > 0 and var_297_7 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_10
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play939062071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 939062071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play939062072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1248ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1248ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0.7, -0.775, -6.18)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1248ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0.7, -0.775, -6.18)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1248ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1248ui_story == nil then
				arg_298_1.var_.characterEffect1248ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect1248ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1248ui_story then
				arg_298_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_301_13 = 0

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_2")
			end

			local var_301_14 = 0

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_301_15 = 0
			local var_301_16 = 1.475

			if var_301_15 < arg_298_1.time_ and arg_298_1.time_ <= var_301_15 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_17 = arg_298_1:FormatText(StoryNameCfg[8].name)

				arg_298_1.leftNameTxt_.text = var_301_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_18 = arg_298_1:GetWordFromCfg(939062071)
				local var_301_19 = arg_298_1:FormatText(var_301_18.content)

				arg_298_1.text_.text = var_301_19

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_20 = 59
				local var_301_21 = utf8.len(var_301_19)
				local var_301_22 = var_301_20 <= 0 and var_301_16 or var_301_16 * (var_301_21 / var_301_20)

				if var_301_22 > 0 and var_301_16 < var_301_22 then
					arg_298_1.talkMaxDuration = var_301_22

					if var_301_22 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_22 + var_301_15
					end
				end

				arg_298_1.text_.text = var_301_19
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_23 = math.max(var_301_16, arg_298_1.talkMaxDuration)

			if var_301_15 <= arg_298_1.time_ and arg_298_1.time_ < var_301_15 + var_301_23 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_15) / var_301_23

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_15 + var_301_23 and arg_298_1.time_ < var_301_15 + var_301_23 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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

		arg_298_1:InitPlayNodeList()
	end,
	Play939062072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 939062072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play939062073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = "1081ui_story"

			if arg_302_1.actors_[var_305_0] == nil then
				local var_305_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_305_1) then
					local var_305_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_302_1.stage_.transform)

					var_305_2.name = var_305_0
					var_305_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_302_1.actors_[var_305_0] = var_305_2

					local var_305_3 = var_305_2:GetComponentInChildren(typeof(CharacterEffect))

					var_305_3.enabled = true

					local var_305_4 = GameObjectTools.GetOrAddComponent(var_305_2, typeof(DynamicBoneHelper))

					if var_305_4 then
						var_305_4:EnableDynamicBone(false)
					end

					arg_302_1:ShowWeapon(var_305_3.transform, false)

					arg_302_1.var_[var_305_0 .. "Animator"] = var_305_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_302_1.var_[var_305_0 .. "Animator"].applyRootMotion = true
					arg_302_1.var_[var_305_0 .. "LipSync"] = var_305_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_305_5 = arg_302_1.actors_["1081ui_story"].transform
			local var_305_6 = 0

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.var_.moveOldPos1081ui_story = var_305_5.localPosition
			end

			local var_305_7 = 0.001

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_7 then
				local var_305_8 = (arg_302_1.time_ - var_305_6) / var_305_7
				local var_305_9 = Vector3.New(0, -0.92, -5.8)

				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1081ui_story, var_305_9, var_305_8)

				local var_305_10 = manager.ui.mainCamera.transform.position - var_305_5.position

				var_305_5.forward = Vector3.New(var_305_10.x, var_305_10.y, var_305_10.z)

				local var_305_11 = var_305_5.localEulerAngles

				var_305_11.z = 0
				var_305_11.x = 0
				var_305_5.localEulerAngles = var_305_11
			end

			if arg_302_1.time_ >= var_305_6 + var_305_7 and arg_302_1.time_ < var_305_6 + var_305_7 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_305_12 = manager.ui.mainCamera.transform.position - var_305_5.position

				var_305_5.forward = Vector3.New(var_305_12.x, var_305_12.y, var_305_12.z)

				local var_305_13 = var_305_5.localEulerAngles

				var_305_13.z = 0
				var_305_13.x = 0
				var_305_5.localEulerAngles = var_305_13
			end

			local var_305_14 = arg_302_1.actors_["1248ui_story"].transform
			local var_305_15 = 0

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.var_.moveOldPos1248ui_story = var_305_14.localPosition
			end

			local var_305_16 = 0.001

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_16 then
				local var_305_17 = (arg_302_1.time_ - var_305_15) / var_305_16
				local var_305_18 = Vector3.New(0, 100, 0)

				var_305_14.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1248ui_story, var_305_18, var_305_17)

				local var_305_19 = manager.ui.mainCamera.transform.position - var_305_14.position

				var_305_14.forward = Vector3.New(var_305_19.x, var_305_19.y, var_305_19.z)

				local var_305_20 = var_305_14.localEulerAngles

				var_305_20.z = 0
				var_305_20.x = 0
				var_305_14.localEulerAngles = var_305_20
			end

			if arg_302_1.time_ >= var_305_15 + var_305_16 and arg_302_1.time_ < var_305_15 + var_305_16 + arg_305_0 then
				var_305_14.localPosition = Vector3.New(0, 100, 0)

				local var_305_21 = manager.ui.mainCamera.transform.position - var_305_14.position

				var_305_14.forward = Vector3.New(var_305_21.x, var_305_21.y, var_305_21.z)

				local var_305_22 = var_305_14.localEulerAngles

				var_305_22.z = 0
				var_305_22.x = 0
				var_305_14.localEulerAngles = var_305_22
			end

			local var_305_23 = arg_302_1.actors_["1054ui_story"].transform
			local var_305_24 = 0

			if var_305_24 < arg_302_1.time_ and arg_302_1.time_ <= var_305_24 + arg_305_0 then
				arg_302_1.var_.moveOldPos1054ui_story = var_305_23.localPosition

				local var_305_25 = GameObjectTools.GetOrAddComponent(var_305_23.gameObject, typeof(DynamicBoneHelper))

				if var_305_25 then
					var_305_25:EnableDynamicBone(false)
				end
			end

			local var_305_26 = 0.001

			if var_305_24 <= arg_302_1.time_ and arg_302_1.time_ < var_305_24 + var_305_26 then
				local var_305_27 = (arg_302_1.time_ - var_305_24) / var_305_26
				local var_305_28 = Vector3.New(0, 100, 0)

				var_305_23.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1054ui_story, var_305_28, var_305_27)

				local var_305_29 = manager.ui.mainCamera.transform.position - var_305_23.position

				var_305_23.forward = Vector3.New(var_305_29.x, var_305_29.y, var_305_29.z)

				local var_305_30 = var_305_23.localEulerAngles

				var_305_30.z = 0
				var_305_30.x = 0
				var_305_23.localEulerAngles = var_305_30
			end

			if arg_302_1.time_ >= var_305_24 + var_305_26 and arg_302_1.time_ < var_305_24 + var_305_26 + arg_305_0 then
				var_305_23.localPosition = Vector3.New(0, 100, 0)

				local var_305_31 = manager.ui.mainCamera.transform.position - var_305_23.position

				var_305_23.forward = Vector3.New(var_305_31.x, var_305_31.y, var_305_31.z)

				local var_305_32 = var_305_23.localEulerAngles

				var_305_32.z = 0
				var_305_32.x = 0
				var_305_23.localEulerAngles = var_305_32

				local var_305_33 = GameObjectTools.GetOrAddComponent(var_305_23.gameObject, typeof(DynamicBoneHelper))

				if var_305_33 then
					var_305_33:EnableDynamicBone(true)
				end
			end

			local var_305_34 = arg_302_1.actors_["1081ui_story"]
			local var_305_35 = 0

			if var_305_35 < arg_302_1.time_ and arg_302_1.time_ <= var_305_35 + arg_305_0 and not isNil(var_305_34) and arg_302_1.var_.characterEffect1081ui_story == nil then
				arg_302_1.var_.characterEffect1081ui_story = var_305_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_36 = 0.200000002980232

			if var_305_35 <= arg_302_1.time_ and arg_302_1.time_ < var_305_35 + var_305_36 and not isNil(var_305_34) then
				local var_305_37 = (arg_302_1.time_ - var_305_35) / var_305_36

				if arg_302_1.var_.characterEffect1081ui_story and not isNil(var_305_34) then
					arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_35 + var_305_36 and arg_302_1.time_ < var_305_35 + var_305_36 + arg_305_0 and not isNil(var_305_34) and arg_302_1.var_.characterEffect1081ui_story then
				arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_305_38 = arg_302_1.actors_["1248ui_story"]
			local var_305_39 = 0

			if var_305_39 < arg_302_1.time_ and arg_302_1.time_ <= var_305_39 + arg_305_0 and not isNil(var_305_38) and arg_302_1.var_.characterEffect1248ui_story == nil then
				arg_302_1.var_.characterEffect1248ui_story = var_305_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_40 = 0.200000002980232

			if var_305_39 <= arg_302_1.time_ and arg_302_1.time_ < var_305_39 + var_305_40 and not isNil(var_305_38) then
				local var_305_41 = (arg_302_1.time_ - var_305_39) / var_305_40

				if arg_302_1.var_.characterEffect1248ui_story and not isNil(var_305_38) then
					local var_305_42 = Mathf.Lerp(0, 0.5, var_305_41)

					arg_302_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1248ui_story.fillRatio = var_305_42
				end
			end

			if arg_302_1.time_ >= var_305_39 + var_305_40 and arg_302_1.time_ < var_305_39 + var_305_40 + arg_305_0 and not isNil(var_305_38) and arg_302_1.var_.characterEffect1248ui_story then
				local var_305_43 = 0.5

				arg_302_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1248ui_story.fillRatio = var_305_43
			end

			local var_305_44 = 0

			if var_305_44 < arg_302_1.time_ and arg_302_1.time_ <= var_305_44 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			local var_305_45 = 0

			if var_305_45 < arg_302_1.time_ and arg_302_1.time_ <= var_305_45 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_46 = 0
			local var_305_47 = 1.275

			if var_305_46 < arg_302_1.time_ and arg_302_1.time_ <= var_305_46 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_48 = arg_302_1:FormatText(StoryNameCfg[202].name)

				arg_302_1.leftNameTxt_.text = var_305_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_49 = arg_302_1:GetWordFromCfg(939062072)
				local var_305_50 = arg_302_1:FormatText(var_305_49.content)

				arg_302_1.text_.text = var_305_50

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_51 = 51
				local var_305_52 = utf8.len(var_305_50)
				local var_305_53 = var_305_51 <= 0 and var_305_47 or var_305_47 * (var_305_52 / var_305_51)

				if var_305_53 > 0 and var_305_47 < var_305_53 then
					arg_302_1.talkMaxDuration = var_305_53

					if var_305_53 + var_305_46 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_53 + var_305_46
					end
				end

				arg_302_1.text_.text = var_305_50
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_54 = math.max(var_305_47, arg_302_1.talkMaxDuration)

			if var_305_46 <= arg_302_1.time_ and arg_302_1.time_ < var_305_46 + var_305_54 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_46) / var_305_54

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_46 + var_305_54 and arg_302_1.time_ < var_305_46 + var_305_54 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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

		arg_302_1:InitPlayNodeList()
	end,
	Play939062073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 939062073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
			arg_306_1.auto_ = false
		end

		function arg_306_1.playNext_(arg_308_0)
			arg_306_1.onStoryFinished_()
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1081ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1081ui_story == nil then
				arg_306_1.var_.characterEffect1081ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1081ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1081ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1081ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1081ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.4

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_9 = arg_306_1:GetWordFromCfg(939062073)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 16
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/I03"
	},
	voices = {},
	skipMarkers = {
		939062016,
		939062021
	}
}
