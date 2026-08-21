return {
	Play939052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST03a"

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
				local var_4_5 = arg_1_1.bgs_.ST03a

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
					if iter_4_0 ~= "ST03a" then
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

			local var_4_30 = 1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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
			local var_4_37 = 0.425

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

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

				local var_4_40 = arg_1_1:GetWordFromCfg(939052001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 17
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939052003(arg_9_1)
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
				local var_12_9 = Vector3.New(0, -0.985, -6.22)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1284ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.985, -6.22)

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
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_12_20 = 0
			local var_12_21 = 0.825

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

				local var_12_23 = arg_9_1:GetWordFromCfg(939052002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 33
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
	Play939052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939052003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1284ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1284ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1284ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1284ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 1.575

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(939052003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 63
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_14 and arg_13_1.time_ < var_16_6 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play939052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939052004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1284ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.985, -6.22)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1284ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1284ui_story == nil then
				arg_17_1.var_.characterEffect1284ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1284ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1284ui_story then
				arg_17_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_20_15 = 0
			local var_20_16 = 0.65

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(939052004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 26
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_23 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_23 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_23

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_23 and arg_17_1.time_ < var_20_15 + var_20_23 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
	Play939052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939052005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1211ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["1211ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1211ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.67, -6.07)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1211ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1284ui_story"].transform
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.var_.moveOldPos1284ui_story = var_24_14.localPosition
			end

			local var_24_16 = 0.001

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16
				local var_24_18 = Vector3.New(-0.7, -0.985, -6.22)

				var_24_14.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1284ui_story, var_24_18, var_24_17)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_14.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_14.localEulerAngles = var_24_20
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 then
				var_24_14.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_24_21 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_21.x, var_24_21.y, var_24_21.z)

				local var_24_22 = var_24_14.localEulerAngles

				var_24_22.z = 0
				var_24_22.x = 0
				var_24_14.localEulerAngles = var_24_22
			end

			local var_24_23 = arg_21_1.actors_["1211ui_story"]
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1211ui_story == nil then
				arg_21_1.var_.characterEffect1211ui_story = var_24_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.200000002980232

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 and not isNil(var_24_23) then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25

				if arg_21_1.var_.characterEffect1211ui_story and not isNil(var_24_23) then
					arg_21_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1211ui_story then
				arg_21_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_24_27 = arg_21_1.actors_["1284ui_story"]
			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 and not isNil(var_24_27) and arg_21_1.var_.characterEffect1284ui_story == nil then
				arg_21_1.var_.characterEffect1284ui_story = var_24_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_29 = 0.200000002980232

			if var_24_28 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_29 and not isNil(var_24_27) then
				local var_24_30 = (arg_21_1.time_ - var_24_28) / var_24_29

				if arg_21_1.var_.characterEffect1284ui_story and not isNil(var_24_27) then
					local var_24_31 = Mathf.Lerp(0, 0.5, var_24_30)

					arg_21_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1284ui_story.fillRatio = var_24_31
				end
			end

			if arg_21_1.time_ >= var_24_28 + var_24_29 and arg_21_1.time_ < var_24_28 + var_24_29 + arg_24_0 and not isNil(var_24_27) and arg_21_1.var_.characterEffect1284ui_story then
				local var_24_32 = 0.5

				arg_21_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1284ui_story.fillRatio = var_24_32
			end

			local var_24_33 = 0

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 then
				arg_21_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_24_34 = 0

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_35 = 0
			local var_24_36 = 1.025

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[37].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(939052005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 41
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_43 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_43 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_43

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_43 and arg_21_1.time_ < var_24_35 + var_24_43 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play939052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1211ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1211ui_story == nil then
				arg_25_1.var_.characterEffect1211ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1211ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1211ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1211ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1211ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.325

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(939052006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 53
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play939052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 939052007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play939052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1211ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1211ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0.7, -0.67, -6.07)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1211ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1211ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1211ui_story == nil then
				arg_29_1.var_.characterEffect1211ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1211ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1211ui_story then
				arg_29_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_15 = 0
			local var_32_16 = 0.225

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[37].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(939052007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 9
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_23 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_23

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_23 and arg_29_1.time_ < var_32_15 + var_32_23 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play939052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 939052008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play939052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1211ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1211ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1211ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1284ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos1284ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0, 100, 0)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1284ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0, 100, 0)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = arg_33_1.actors_["1211ui_story"]
			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1211ui_story == nil then
				arg_33_1.var_.characterEffect1211ui_story = var_36_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_20 = 0.200000002980232

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_20 and not isNil(var_36_18) then
				local var_36_21 = (arg_33_1.time_ - var_36_19) / var_36_20

				if arg_33_1.var_.characterEffect1211ui_story and not isNil(var_36_18) then
					local var_36_22 = Mathf.Lerp(0, 0.5, var_36_21)

					arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1211ui_story.fillRatio = var_36_22
				end
			end

			if arg_33_1.time_ >= var_36_19 + var_36_20 and arg_33_1.time_ < var_36_19 + var_36_20 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1211ui_story then
				local var_36_23 = 0.5

				arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1211ui_story.fillRatio = var_36_23
			end

			local var_36_24 = 0
			local var_36_25 = 0.925

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(939052008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 37
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_25 or var_36_25 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_25 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_24 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_24
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = math.max(var_36_25, arg_33_1.talkMaxDuration)

			if var_36_24 <= arg_33_1.time_ and arg_33_1.time_ < var_36_24 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_24) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_24 + var_36_31 and arg_33_1.time_ < var_36_24 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play939052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 939052009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play939052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1054ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["1054ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1054ui_story = var_40_5.localPosition

				local var_40_7 = GameObjectTools.GetOrAddComponent(var_40_5.gameObject, typeof(DynamicBoneHelper))

				if var_40_7 then
					var_40_7:EnableDynamicBone(false)
				end
			end

			local var_40_8 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_6) / var_40_8
				local var_40_10 = Vector3.New(0, -0.985, -6)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1054ui_story, var_40_10, var_40_9)

				local var_40_11 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_11.x, var_40_11.y, var_40_11.z)

				local var_40_12 = var_40_5.localEulerAngles

				var_40_12.z = 0
				var_40_12.x = 0
				var_40_5.localEulerAngles = var_40_12
			end

			if arg_37_1.time_ >= var_40_6 + var_40_8 and arg_37_1.time_ < var_40_6 + var_40_8 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_40_13 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_13.x, var_40_13.y, var_40_13.z)

				local var_40_14 = var_40_5.localEulerAngles

				var_40_14.z = 0
				var_40_14.x = 0
				var_40_5.localEulerAngles = var_40_14

				local var_40_15 = GameObjectTools.GetOrAddComponent(var_40_5.gameObject, typeof(DynamicBoneHelper))

				if var_40_15 then
					var_40_15:EnableDynamicBone(true)
				end
			end

			local var_40_16 = arg_37_1.actors_["1054ui_story"]
			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.characterEffect1054ui_story == nil then
				arg_37_1.var_.characterEffect1054ui_story = var_40_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_18 = 0.200000002980232

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_18 and not isNil(var_40_16) then
				local var_40_19 = (arg_37_1.time_ - var_40_17) / var_40_18

				if arg_37_1.var_.characterEffect1054ui_story and not isNil(var_40_16) then
					arg_37_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_17 + var_40_18 and arg_37_1.time_ < var_40_17 + var_40_18 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.characterEffect1054ui_story then
				arg_37_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_40_21 = 0

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_40_22 = 0
			local var_40_23 = 0.875

			if var_40_22 < arg_37_1.time_ and arg_37_1.time_ <= var_40_22 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_24 = arg_37_1:FormatText(StoryNameCfg[1487].name)

				arg_37_1.leftNameTxt_.text = var_40_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_25 = arg_37_1:GetWordFromCfg(939052009)
				local var_40_26 = arg_37_1:FormatText(var_40_25.content)

				arg_37_1.text_.text = var_40_26

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_27 = 35
				local var_40_28 = utf8.len(var_40_26)
				local var_40_29 = var_40_27 <= 0 and var_40_23 or var_40_23 * (var_40_28 / var_40_27)

				if var_40_29 > 0 and var_40_23 < var_40_29 then
					arg_37_1.talkMaxDuration = var_40_29

					if var_40_29 + var_40_22 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_29 + var_40_22
					end
				end

				arg_37_1.text_.text = var_40_26
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_30 = math.max(var_40_23, arg_37_1.talkMaxDuration)

			if var_40_22 <= arg_37_1.time_ and arg_37_1.time_ < var_40_22 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_22) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_22 + var_40_30 and arg_37_1.time_ < var_40_22 + var_40_30 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play939052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 939052010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play939052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1054ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1054ui_story == nil then
				arg_41_1.var_.characterEffect1054ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1054ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1054ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1054ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1054ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.275

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(939052010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 11
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play939052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 939052011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play939052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1054ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1054ui_story = var_48_0.localPosition

				local var_48_2 = GameObjectTools.GetOrAddComponent(var_48_0.gameObject, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(false)
				end
			end

			local var_48_3 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_3 then
				local var_48_4 = (arg_45_1.time_ - var_48_1) / var_48_3
				local var_48_5 = Vector3.New(0, -0.985, -6)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1054ui_story, var_48_5, var_48_4)

				local var_48_6 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_6.x, var_48_6.y, var_48_6.z)

				local var_48_7 = var_48_0.localEulerAngles

				var_48_7.z = 0
				var_48_7.x = 0
				var_48_0.localEulerAngles = var_48_7
			end

			if arg_45_1.time_ >= var_48_1 + var_48_3 and arg_45_1.time_ < var_48_1 + var_48_3 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_48_8 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_8.x, var_48_8.y, var_48_8.z)

				local var_48_9 = var_48_0.localEulerAngles

				var_48_9.z = 0
				var_48_9.x = 0
				var_48_0.localEulerAngles = var_48_9

				local var_48_10 = GameObjectTools.GetOrAddComponent(var_48_0.gameObject, typeof(DynamicBoneHelper))

				if var_48_10 then
					var_48_10:EnableDynamicBone(true)
				end
			end

			local var_48_11 = arg_45_1.actors_["1054ui_story"]
			local var_48_12 = 0

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 and not isNil(var_48_11) and arg_45_1.var_.characterEffect1054ui_story == nil then
				arg_45_1.var_.characterEffect1054ui_story = var_48_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_13 = 0.200000002980232

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_13 and not isNil(var_48_11) then
				local var_48_14 = (arg_45_1.time_ - var_48_12) / var_48_13

				if arg_45_1.var_.characterEffect1054ui_story and not isNil(var_48_11) then
					arg_45_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_12 + var_48_13 and arg_45_1.time_ < var_48_12 + var_48_13 + arg_48_0 and not isNil(var_48_11) and arg_45_1.var_.characterEffect1054ui_story then
				arg_45_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_48_17 = 0
			local var_48_18 = 0.7

			if var_48_17 < arg_45_1.time_ and arg_45_1.time_ <= var_48_17 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_19 = arg_45_1:FormatText(StoryNameCfg[1487].name)

				arg_45_1.leftNameTxt_.text = var_48_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(939052011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 28
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_18 or var_48_18 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_18 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_17 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_17
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_18, arg_45_1.talkMaxDuration)

			if var_48_17 <= arg_45_1.time_ and arg_45_1.time_ < var_48_17 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_17) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_17 + var_48_25 and arg_45_1.time_ < var_48_17 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play939052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 939052012
		arg_49_1.duration_ = 1

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"

			SetActive(arg_49_1.choicesGo_, true)

			for iter_50_0, iter_50_1 in ipairs(arg_49_1.choices_) do
				local var_50_0 = iter_50_0 <= 2

				SetActive(iter_50_1.go, var_50_0)
			end

			arg_49_1.choices_[1].txt.text = arg_49_1:FormatText(StoryChoiceCfg[1676].name)
			arg_49_1.choices_[2].txt.text = arg_49_1:FormatText(StoryChoiceCfg[1677].name)
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play939052013(arg_49_1)
			end

			if arg_51_0 == 2 then
				arg_49_0:Play939052013(arg_49_1)
			end

			arg_49_1:RecordChoiceLog(939052012, 1676, 1677)
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1054ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1054ui_story = var_52_0.localPosition

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end
			end

			local var_52_3 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1054ui_story, var_52_5, var_52_4)

				local var_52_6 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_6.x, var_52_6.y, var_52_6.z)

				local var_52_7 = var_52_0.localEulerAngles

				var_52_7.z = 0
				var_52_7.x = 0
				var_52_0.localEulerAngles = var_52_7
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_8 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_8.x, var_52_8.y, var_52_8.z)

				local var_52_9 = var_52_0.localEulerAngles

				var_52_9.z = 0
				var_52_9.x = 0
				var_52_0.localEulerAngles = var_52_9

				local var_52_10 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_10 then
					var_52_10:EnableDynamicBone(true)
				end
			end

			local var_52_11 = arg_49_1.actors_["1054ui_story"]
			local var_52_12 = 0

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1054ui_story == nil then
				arg_49_1.var_.characterEffect1054ui_story = var_52_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_13 = 0.200000002980232

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_13 and not isNil(var_52_11) then
				local var_52_14 = (arg_49_1.time_ - var_52_12) / var_52_13

				if arg_49_1.var_.characterEffect1054ui_story and not isNil(var_52_11) then
					local var_52_15 = Mathf.Lerp(0, 0.5, var_52_14)

					arg_49_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1054ui_story.fillRatio = var_52_15
				end
			end

			if arg_49_1.time_ >= var_52_12 + var_52_13 and arg_49_1.time_ < var_52_12 + var_52_13 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect1054ui_story then
				local var_52_16 = 0.5

				arg_49_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1054ui_story.fillRatio = var_52_16
			end

			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_18 = 0.466666666666667

			if arg_49_1.time_ >= var_52_17 + var_52_18 and arg_49_1.time_ < var_52_17 + var_52_18 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play939052013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 939052013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play939052014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "6148ui_story"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_53_1.stage_.transform)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentInChildren(typeof(CharacterEffect))

					var_56_3.enabled = true

					local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_2, typeof(DynamicBoneHelper))

					if var_56_4 then
						var_56_4:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_3.transform, false)

					arg_53_1.var_[var_56_0 .. "Animator"] = var_56_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_0 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_0 .. "LipSync"] = var_56_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_5 = arg_53_1.actors_["6148ui_story"].transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.moveOldPos6148ui_story = var_56_5.localPosition

				local var_56_7 = GameObjectTools.GetOrAddComponent(var_56_5.gameObject, typeof(DynamicBoneHelper))

				if var_56_7 then
					var_56_7:EnableDynamicBone(false)
				end
			end

			local var_56_8 = 0.001

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_6) / var_56_8
				local var_56_10 = Vector3.New(0, -0.985, -6)

				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos6148ui_story, var_56_10, var_56_9)

				local var_56_11 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_11.x, var_56_11.y, var_56_11.z)

				local var_56_12 = var_56_5.localEulerAngles

				var_56_12.z = 0
				var_56_12.x = 0
				var_56_5.localEulerAngles = var_56_12
			end

			if arg_53_1.time_ >= var_56_6 + var_56_8 and arg_53_1.time_ < var_56_6 + var_56_8 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_56_13 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_13.x, var_56_13.y, var_56_13.z)

				local var_56_14 = var_56_5.localEulerAngles

				var_56_14.z = 0
				var_56_14.x = 0
				var_56_5.localEulerAngles = var_56_14

				local var_56_15 = GameObjectTools.GetOrAddComponent(var_56_5.gameObject, typeof(DynamicBoneHelper))

				if var_56_15 then
					var_56_15:EnableDynamicBone(true)
				end
			end

			local var_56_16 = arg_53_1.actors_["6148ui_story"]
			local var_56_17 = 0

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 and not isNil(var_56_16) and arg_53_1.var_.characterEffect6148ui_story == nil then
				arg_53_1.var_.characterEffect6148ui_story = var_56_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_18 = 0.200000002980232

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_18 and not isNil(var_56_16) then
				local var_56_19 = (arg_53_1.time_ - var_56_17) / var_56_18

				if arg_53_1.var_.characterEffect6148ui_story and not isNil(var_56_16) then
					arg_53_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_17 + var_56_18 and arg_53_1.time_ < var_56_17 + var_56_18 + arg_56_0 and not isNil(var_56_16) and arg_53_1.var_.characterEffect6148ui_story then
				arg_53_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_56_20 = "6148ui_story"

			if arg_53_1.actors_[var_56_20] == nil then
				local var_56_21 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_56_21) then
					local var_56_22 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_53_1.stage_.transform)

					var_56_22.name = var_56_20
					var_56_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_20] = var_56_22

					local var_56_23 = var_56_22:GetComponentInChildren(typeof(CharacterEffect))

					var_56_23.enabled = true

					local var_56_24 = GameObjectTools.GetOrAddComponent(var_56_22, typeof(DynamicBoneHelper))

					if var_56_24 then
						var_56_24:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_23.transform, false)

					arg_53_1.var_[var_56_20 .. "Animator"] = var_56_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_20 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_20 .. "LipSync"] = var_56_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_56_26 = "6148ui_story"

			if arg_53_1.actors_[var_56_26] == nil then
				local var_56_27 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_56_27) then
					local var_56_28 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_53_1.stage_.transform)

					var_56_28.name = var_56_26
					var_56_28.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_26] = var_56_28

					local var_56_29 = var_56_28:GetComponentInChildren(typeof(CharacterEffect))

					var_56_29.enabled = true

					local var_56_30 = GameObjectTools.GetOrAddComponent(var_56_28, typeof(DynamicBoneHelper))

					if var_56_30 then
						var_56_30:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_29.transform, false)

					arg_53_1.var_[var_56_26 .. "Animator"] = var_56_29.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_26 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_26 .. "LipSync"] = var_56_29.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_31 = 0

			if var_56_31 < arg_53_1.time_ and arg_53_1.time_ <= var_56_31 + arg_56_0 then
				arg_53_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_56_32 = 0
			local var_56_33 = 0.7

			if var_56_32 < arg_53_1.time_ and arg_53_1.time_ <= var_56_32 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_34 = arg_53_1:FormatText(StoryNameCfg[1488].name)

				arg_53_1.leftNameTxt_.text = var_56_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_35 = arg_53_1:GetWordFromCfg(939052013)
				local var_56_36 = arg_53_1:FormatText(var_56_35.content)

				arg_53_1.text_.text = var_56_36

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_37 = 28
				local var_56_38 = utf8.len(var_56_36)
				local var_56_39 = var_56_37 <= 0 and var_56_33 or var_56_33 * (var_56_38 / var_56_37)

				if var_56_39 > 0 and var_56_33 < var_56_39 then
					arg_53_1.talkMaxDuration = var_56_39

					if var_56_39 + var_56_32 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_39 + var_56_32
					end
				end

				arg_53_1.text_.text = var_56_36
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_40 = math.max(var_56_33, arg_53_1.talkMaxDuration)

			if var_56_32 <= arg_53_1.time_ and arg_53_1.time_ < var_56_32 + var_56_40 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_32) / var_56_40

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_32 + var_56_40 and arg_53_1.time_ < var_56_32 + var_56_40 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play939052014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 939052014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play939052015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["6148ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos6148ui_story = var_60_0.localPosition

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end
			end

			local var_60_3 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_3 then
				local var_60_4 = (arg_57_1.time_ - var_60_1) / var_60_3
				local var_60_5 = Vector3.New(0, -0.985, -6)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos6148ui_story, var_60_5, var_60_4)

				local var_60_6 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_6.x, var_60_6.y, var_60_6.z)

				local var_60_7 = var_60_0.localEulerAngles

				var_60_7.z = 0
				var_60_7.x = 0
				var_60_0.localEulerAngles = var_60_7
			end

			if arg_57_1.time_ >= var_60_1 + var_60_3 and arg_57_1.time_ < var_60_1 + var_60_3 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_60_8 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_8.x, var_60_8.y, var_60_8.z)

				local var_60_9 = var_60_0.localEulerAngles

				var_60_9.z = 0
				var_60_9.x = 0
				var_60_0.localEulerAngles = var_60_9

				local var_60_10 = GameObjectTools.GetOrAddComponent(var_60_0.gameObject, typeof(DynamicBoneHelper))

				if var_60_10 then
					var_60_10:EnableDynamicBone(true)
				end
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_60_13 = 0
			local var_60_14 = 1.575

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_15 = arg_57_1:FormatText(StoryNameCfg[1488].name)

				arg_57_1.leftNameTxt_.text = var_60_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_16 = arg_57_1:GetWordFromCfg(939052014)
				local var_60_17 = arg_57_1:FormatText(var_60_16.content)

				arg_57_1.text_.text = var_60_17

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 63
				local var_60_19 = utf8.len(var_60_17)
				local var_60_20 = var_60_18 <= 0 and var_60_14 or var_60_14 * (var_60_19 / var_60_18)

				if var_60_20 > 0 and var_60_14 < var_60_20 then
					arg_57_1.talkMaxDuration = var_60_20

					if var_60_20 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_17
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_13) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_13 + var_60_21 and arg_57_1.time_ < var_60_13 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play939052015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 939052015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play939052016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["6148ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos6148ui_story = var_64_0.localPosition

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end
			end

			local var_64_3 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos6148ui_story, var_64_5, var_64_4)

				local var_64_6 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_6.x, var_64_6.y, var_64_6.z)

				local var_64_7 = var_64_0.localEulerAngles

				var_64_7.z = 0
				var_64_7.x = 0
				var_64_0.localEulerAngles = var_64_7
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_8 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_8.x, var_64_8.y, var_64_8.z)

				local var_64_9 = var_64_0.localEulerAngles

				var_64_9.z = 0
				var_64_9.x = 0
				var_64_0.localEulerAngles = var_64_9

				local var_64_10 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_10 then
					var_64_10:EnableDynamicBone(true)
				end
			end

			local var_64_11 = arg_61_1.actors_["6148ui_story"]
			local var_64_12 = 0

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_13 = 0.200000002980232

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_13 and not isNil(var_64_11) then
				local var_64_14 = (arg_61_1.time_ - var_64_12) / var_64_13

				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_11) then
					local var_64_15 = Mathf.Lerp(0, 0.5, var_64_14)

					arg_61_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_61_1.var_.characterEffect6148ui_story.fillRatio = var_64_15
				end
			end

			if arg_61_1.time_ >= var_64_12 + var_64_13 and arg_61_1.time_ < var_64_12 + var_64_13 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect6148ui_story then
				local var_64_16 = 0.5

				arg_61_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_61_1.var_.characterEffect6148ui_story.fillRatio = var_64_16
			end

			local var_64_17 = 0
			local var_64_18 = 0.65

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(939052015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 26
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_18 or var_64_18 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_18 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_17
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_24 = math.max(var_64_18, arg_61_1.talkMaxDuration)

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_17) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_17 + var_64_24 and arg_61_1.time_ < var_64_17 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play939052016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 939052016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play939052017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.475

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(939052016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 19
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play939052017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 939052017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play939052018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1054ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1054ui_story = var_72_0.localPosition

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end
			end

			local var_72_3 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3
				local var_72_5 = Vector3.New(0, -0.985, -6)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1054ui_story, var_72_5, var_72_4)

				local var_72_6 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_6.x, var_72_6.y, var_72_6.z)

				local var_72_7 = var_72_0.localEulerAngles

				var_72_7.z = 0
				var_72_7.x = 0
				var_72_0.localEulerAngles = var_72_7
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_72_8 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_8.x, var_72_8.y, var_72_8.z)

				local var_72_9 = var_72_0.localEulerAngles

				var_72_9.z = 0
				var_72_9.x = 0
				var_72_0.localEulerAngles = var_72_9

				local var_72_10 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_10 then
					var_72_10:EnableDynamicBone(true)
				end
			end

			local var_72_11 = arg_69_1.actors_["1054ui_story"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect1054ui_story == nil then
				arg_69_1.var_.characterEffect1054ui_story = var_72_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_13 = 0.200000002980232

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.characterEffect1054ui_story and not isNil(var_72_11) then
					arg_69_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect1054ui_story then
				arg_69_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_72_17 = 0
			local var_72_18 = 0.4

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_19 = arg_69_1:FormatText(StoryNameCfg[1487].name)

				arg_69_1.leftNameTxt_.text = var_72_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_20 = arg_69_1:GetWordFromCfg(939052017)
				local var_72_21 = arg_69_1:FormatText(var_72_20.content)

				arg_69_1.text_.text = var_72_21

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_22 = 16
				local var_72_23 = utf8.len(var_72_21)
				local var_72_24 = var_72_22 <= 0 and var_72_18 or var_72_18 * (var_72_23 / var_72_22)

				if var_72_24 > 0 and var_72_18 < var_72_24 then
					arg_69_1.talkMaxDuration = var_72_24

					if var_72_24 + var_72_17 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_17
					end
				end

				arg_69_1.text_.text = var_72_21
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_18, arg_69_1.talkMaxDuration)

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_17) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_17 + var_72_25 and arg_69_1.time_ < var_72_17 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play939052018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 939052018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play939052019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1054ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1054ui_story = var_76_0.localPosition

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0.gameObject, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end
			end

			local var_76_3 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_3 then
				local var_76_4 = (arg_73_1.time_ - var_76_1) / var_76_3
				local var_76_5 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1054ui_story, var_76_5, var_76_4)

				local var_76_6 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_6.x, var_76_6.y, var_76_6.z)

				local var_76_7 = var_76_0.localEulerAngles

				var_76_7.z = 0
				var_76_7.x = 0
				var_76_0.localEulerAngles = var_76_7
			end

			if arg_73_1.time_ >= var_76_1 + var_76_3 and arg_73_1.time_ < var_76_1 + var_76_3 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_8 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_8.x, var_76_8.y, var_76_8.z)

				local var_76_9 = var_76_0.localEulerAngles

				var_76_9.z = 0
				var_76_9.x = 0
				var_76_0.localEulerAngles = var_76_9

				local var_76_10 = GameObjectTools.GetOrAddComponent(var_76_0.gameObject, typeof(DynamicBoneHelper))

				if var_76_10 then
					var_76_10:EnableDynamicBone(true)
				end
			end

			local var_76_11 = arg_73_1.actors_["1054ui_story"]
			local var_76_12 = 0

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 and not isNil(var_76_11) and arg_73_1.var_.characterEffect1054ui_story == nil then
				arg_73_1.var_.characterEffect1054ui_story = var_76_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_13 = 0.200000002980232

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_13 and not isNil(var_76_11) then
				local var_76_14 = (arg_73_1.time_ - var_76_12) / var_76_13

				if arg_73_1.var_.characterEffect1054ui_story and not isNil(var_76_11) then
					local var_76_15 = Mathf.Lerp(0, 0.5, var_76_14)

					arg_73_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1054ui_story.fillRatio = var_76_15
				end
			end

			if arg_73_1.time_ >= var_76_12 + var_76_13 and arg_73_1.time_ < var_76_12 + var_76_13 + arg_76_0 and not isNil(var_76_11) and arg_73_1.var_.characterEffect1054ui_story then
				local var_76_16 = 0.5

				arg_73_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1054ui_story.fillRatio = var_76_16
			end

			local var_76_17 = 0
			local var_76_18 = 1

			if var_76_17 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(939052018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 40
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_18 or var_76_18 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_18 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23

					if var_76_23 + var_76_17 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_17
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_24 = math.max(var_76_18, arg_73_1.talkMaxDuration)

			if var_76_17 <= arg_73_1.time_ and arg_73_1.time_ < var_76_17 + var_76_24 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_17) / var_76_24

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_17 + var_76_24 and arg_73_1.time_ < var_76_17 + var_76_24 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play939052019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 939052019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play939052020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.875

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(939052019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 35
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play939052020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 939052020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play939052021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.775

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(939052020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 31
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play939052021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 939052021
		arg_85_1.duration_ = 6.3

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play939052022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "I03"

			if arg_85_1.bgs_[var_88_0] == nil then
				local var_88_1 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_0)
				var_88_1.name = var_88_0
				var_88_1.transform.parent = arg_85_1.stage_.transform
				var_88_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_0] = var_88_1
			end

			local var_88_2 = 0.866666666666667

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				local var_88_3 = manager.ui.mainCamera.transform.localPosition
				local var_88_4 = Vector3.New(0, 0, 10) + Vector3.New(var_88_3.x, var_88_3.y, 0)
				local var_88_5 = arg_85_1.bgs_.I03

				var_88_5.transform.localPosition = var_88_4
				var_88_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_6 = var_88_5:GetComponent("SpriteRenderer")

				if var_88_6 and var_88_6.sprite then
					local var_88_7 = (var_88_5.transform.localPosition - var_88_3).z
					local var_88_8 = manager.ui.mainCameraCom_
					local var_88_9 = 2 * var_88_7 * Mathf.Tan(var_88_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_10 = var_88_9 * var_88_8.aspect
					local var_88_11 = var_88_6.sprite.bounds.size.x
					local var_88_12 = var_88_6.sprite.bounds.size.y
					local var_88_13 = var_88_10 / var_88_11
					local var_88_14 = var_88_9 / var_88_12
					local var_88_15 = var_88_14 < var_88_13 and var_88_13 or var_88_14

					var_88_5.transform.localScale = Vector3.New(var_88_15, var_88_15, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "I03" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_16 = 1.33400000184774

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_17 = 0.3

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_18 = "1047ui_story"

			if arg_85_1.actors_[var_88_18] == nil then
				local var_88_19 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_88_19) then
					local var_88_20 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_85_1.stage_.transform)

					var_88_20.name = var_88_18
					var_88_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_85_1.actors_[var_88_18] = var_88_20

					local var_88_21 = var_88_20:GetComponentInChildren(typeof(CharacterEffect))

					var_88_21.enabled = true

					local var_88_22 = GameObjectTools.GetOrAddComponent(var_88_20, typeof(DynamicBoneHelper))

					if var_88_22 then
						var_88_22:EnableDynamicBone(false)
					end

					arg_85_1:ShowWeapon(var_88_21.transform, false)

					arg_85_1.var_[var_88_18 .. "Animator"] = var_88_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_85_1.var_[var_88_18 .. "Animator"].applyRootMotion = true
					arg_85_1.var_[var_88_18 .. "LipSync"] = var_88_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_88_23 = arg_85_1.actors_["1047ui_story"].transform
			local var_88_24 = 1.3

			if var_88_24 < arg_85_1.time_ and arg_85_1.time_ <= var_88_24 + arg_88_0 then
				arg_85_1.var_.moveOldPos1047ui_story = var_88_23.localPosition
			end

			local var_88_25 = 0.001

			if var_88_24 <= arg_85_1.time_ and arg_85_1.time_ < var_88_24 + var_88_25 then
				local var_88_26 = (arg_85_1.time_ - var_88_24) / var_88_25
				local var_88_27 = Vector3.New(0, -1.13, -6.2)

				var_88_23.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1047ui_story, var_88_27, var_88_26)

				local var_88_28 = manager.ui.mainCamera.transform.position - var_88_23.position

				var_88_23.forward = Vector3.New(var_88_28.x, var_88_28.y, var_88_28.z)

				local var_88_29 = var_88_23.localEulerAngles

				var_88_29.z = 0
				var_88_29.x = 0
				var_88_23.localEulerAngles = var_88_29
			end

			if arg_85_1.time_ >= var_88_24 + var_88_25 and arg_85_1.time_ < var_88_24 + var_88_25 + arg_88_0 then
				var_88_23.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_88_30 = manager.ui.mainCamera.transform.position - var_88_23.position

				var_88_23.forward = Vector3.New(var_88_30.x, var_88_30.y, var_88_30.z)

				local var_88_31 = var_88_23.localEulerAngles

				var_88_31.z = 0
				var_88_31.x = 0
				var_88_23.localEulerAngles = var_88_31
			end

			local var_88_32 = 1.3

			if var_88_32 < arg_85_1.time_ and arg_85_1.time_ <= var_88_32 + arg_88_0 then
				arg_85_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_88_33 = 1.3

			if var_88_33 < arg_85_1.time_ and arg_85_1.time_ <= var_88_33 + arg_88_0 then
				arg_85_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_88_34 = manager.ui.mainCamera.transform
			local var_88_35 = 0

			if var_88_35 < arg_85_1.time_ and arg_85_1.time_ <= var_88_35 + arg_88_0 then
				local var_88_36 = arg_85_1.var_.effectguochang122131
				local var_88_37
				local var_88_38 = var_88_34

				if not var_88_36 then
					var_88_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_88_38)
					var_88_36.name = "guochang122131"
					arg_85_1.var_.effectguochang122131 = var_88_36
				else
					var_88_36.transform:SetParent(var_88_38)
				end

				var_88_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_88_39 = arg_85_1.actors_["1047ui_story"]
			local var_88_40 = 1.3

			if var_88_40 < arg_85_1.time_ and arg_85_1.time_ <= var_88_40 + arg_88_0 and not isNil(var_88_39) and arg_85_1.var_.characterEffect1047ui_story == nil then
				arg_85_1.var_.characterEffect1047ui_story = var_88_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_41 = 0.2

			if var_88_40 <= arg_85_1.time_ and arg_85_1.time_ < var_88_40 + var_88_41 and not isNil(var_88_39) then
				local var_88_42 = (arg_85_1.time_ - var_88_40) / var_88_41

				if arg_85_1.var_.characterEffect1047ui_story and not isNil(var_88_39) then
					arg_85_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_40 + var_88_41 and arg_85_1.time_ < var_88_40 + var_88_41 + arg_88_0 and not isNil(var_88_39) and arg_85_1.var_.characterEffect1047ui_story then
				arg_85_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_43 = 1.3
			local var_88_44 = 0.475

			if var_88_43 < arg_85_1.time_ and arg_85_1.time_ <= var_88_43 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_45 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_45:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_46 = arg_85_1:FormatText(StoryNameCfg[1296].name)

				arg_85_1.leftNameTxt_.text = var_88_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_47 = arg_85_1:GetWordFromCfg(939052021)
				local var_88_48 = arg_85_1:FormatText(var_88_47.content)

				arg_85_1.text_.text = var_88_48

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_49 = 19
				local var_88_50 = utf8.len(var_88_48)
				local var_88_51 = var_88_49 <= 0 and var_88_44 or var_88_44 * (var_88_50 / var_88_49)

				if var_88_51 > 0 and var_88_44 < var_88_51 then
					arg_85_1.talkMaxDuration = var_88_51
					var_88_43 = var_88_43 + 0.3

					if var_88_51 + var_88_43 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_51 + var_88_43
					end
				end

				arg_85_1.text_.text = var_88_48
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_52 = var_88_43 + 0.3
			local var_88_53 = math.max(var_88_44, arg_85_1.talkMaxDuration)

			if var_88_52 <= arg_85_1.time_ and arg_85_1.time_ < var_88_52 + var_88_53 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_52) / var_88_53

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_52 + var_88_53 and arg_85_1.time_ < var_88_52 + var_88_53 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play939052022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 939052022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play939052023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1047ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1047ui_story == nil then
				arg_91_1.var_.characterEffect1047ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1047ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1047ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1047ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1047ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.575

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_9 = arg_91_1:GetWordFromCfg(939052022)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 23
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play939052023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 939052023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play939052024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1047ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1047ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, -1.13, -6.2)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1047ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = 0

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_98_11 = arg_95_1.actors_["1047ui_story"]
			local var_98_12 = 0

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect1047ui_story == nil then
				arg_95_1.var_.characterEffect1047ui_story = var_98_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_13 = 0.2

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_13 and not isNil(var_98_11) then
				local var_98_14 = (arg_95_1.time_ - var_98_12) / var_98_13

				if arg_95_1.var_.characterEffect1047ui_story and not isNil(var_98_11) then
					arg_95_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_12 + var_98_13 and arg_95_1.time_ < var_98_12 + var_98_13 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect1047ui_story then
				arg_95_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_98_15 = 0
			local var_98_16 = 0.525

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[1296].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(939052023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 21
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_23 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_23 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_23

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_23 and arg_95_1.time_ < var_98_15 + var_98_23 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play939052024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 939052024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play939052025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1047ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1047ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -1.13, -6.2)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1047ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action437")
			end

			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_102_11 = 0
			local var_102_12 = 1.35

			if var_102_11 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_13 = arg_99_1:FormatText(StoryNameCfg[1296].name)

				arg_99_1.leftNameTxt_.text = var_102_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_14 = arg_99_1:GetWordFromCfg(939052024)
				local var_102_15 = arg_99_1:FormatText(var_102_14.content)

				arg_99_1.text_.text = var_102_15

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 54
				local var_102_17 = utf8.len(var_102_15)
				local var_102_18 = var_102_16 <= 0 and var_102_12 or var_102_12 * (var_102_17 / var_102_16)

				if var_102_18 > 0 and var_102_12 < var_102_18 then
					arg_99_1.talkMaxDuration = var_102_18

					if var_102_18 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_15
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_19 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_11) / var_102_19

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_11 + var_102_19 and arg_99_1.time_ < var_102_11 + var_102_19 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play939052025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 939052025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play939052026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1047ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1047ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1047ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = 0
			local var_106_10 = 0.675

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_11 = arg_103_1:GetWordFromCfg(939052025)
				local var_106_12 = arg_103_1:FormatText(var_106_11.content)

				arg_103_1.text_.text = var_106_12

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 27
				local var_106_14 = utf8.len(var_106_12)
				local var_106_15 = var_106_13 <= 0 and var_106_10 or var_106_10 * (var_106_14 / var_106_13)

				if var_106_15 > 0 and var_106_10 < var_106_15 then
					arg_103_1.talkMaxDuration = var_106_15

					if var_106_15 + var_106_9 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_15 + var_106_9
					end
				end

				arg_103_1.text_.text = var_106_12
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_10, arg_103_1.talkMaxDuration)

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_9) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_9 + var_106_16 and arg_103_1.time_ < var_106_9 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play939052026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 939052026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play939052027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["6148ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos6148ui_story = var_110_0.localPosition

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end
			end

			local var_110_3 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3
				local var_110_5 = Vector3.New(-0.7, -0.985, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos6148ui_story, var_110_5, var_110_4)

				local var_110_6 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_6.x, var_110_6.y, var_110_6.z)

				local var_110_7 = var_110_0.localEulerAngles

				var_110_7.z = 0
				var_110_7.x = 0
				var_110_0.localEulerAngles = var_110_7
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_110_8 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_8.x, var_110_8.y, var_110_8.z)

				local var_110_9 = var_110_0.localEulerAngles

				var_110_9.z = 0
				var_110_9.x = 0
				var_110_0.localEulerAngles = var_110_9

				local var_110_10 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_10 then
					var_110_10:EnableDynamicBone(true)
				end
			end

			local var_110_11 = arg_107_1.actors_["6148ui_story"]
			local var_110_12 = 0

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect6148ui_story == nil then
				arg_107_1.var_.characterEffect6148ui_story = var_110_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.200000002980232

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 and not isNil(var_110_11) then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13

				if arg_107_1.var_.characterEffect6148ui_story and not isNil(var_110_11) then
					arg_107_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect6148ui_story then
				arg_107_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_110_17 = 0
			local var_110_18 = 0.65

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_19 = arg_107_1:FormatText(StoryNameCfg[1488].name)

				arg_107_1.leftNameTxt_.text = var_110_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_20 = arg_107_1:GetWordFromCfg(939052026)
				local var_110_21 = arg_107_1:FormatText(var_110_20.content)

				arg_107_1.text_.text = var_110_21

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_22 = 26
				local var_110_23 = utf8.len(var_110_21)
				local var_110_24 = var_110_22 <= 0 and var_110_18 or var_110_18 * (var_110_23 / var_110_22)

				if var_110_24 > 0 and var_110_18 < var_110_24 then
					arg_107_1.talkMaxDuration = var_110_24

					if var_110_24 + var_110_17 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_24 + var_110_17
					end
				end

				arg_107_1.text_.text = var_110_21
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_18, arg_107_1.talkMaxDuration)

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_17) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_17 + var_110_25 and arg_107_1.time_ < var_110_17 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play939052027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 939052027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play939052028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1047ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1047ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0.74, -1.13, -6.2)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1047ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["6148ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect6148ui_story == nil then
				arg_111_1.var_.characterEffect6148ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect6148ui_story and not isNil(var_114_9) then
					local var_114_13 = Mathf.Lerp(0, 0.5, var_114_12)

					arg_111_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_111_1.var_.characterEffect6148ui_story.fillRatio = var_114_13
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect6148ui_story then
				local var_114_14 = 0.5

				arg_111_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_111_1.var_.characterEffect6148ui_story.fillRatio = var_114_14
			end

			local var_114_15 = 0

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_114_17 = 0
			local var_114_18 = 1.15

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_19 = arg_111_1:FormatText(StoryNameCfg[1296].name)

				arg_111_1.leftNameTxt_.text = var_114_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(939052027)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 46
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_18 or var_114_18 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_18 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24

					if var_114_24 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_17) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_17 + var_114_25 and arg_111_1.time_ < var_114_17 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play939052028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 939052028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play939052029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1054ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1054ui_story = var_118_0.localPosition

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end
			end

			local var_118_3 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_3 then
				local var_118_4 = (arg_115_1.time_ - var_118_1) / var_118_3
				local var_118_5 = Vector3.New(-0.7, -0.985, -6)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1054ui_story, var_118_5, var_118_4)

				local var_118_6 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_6.x, var_118_6.y, var_118_6.z)

				local var_118_7 = var_118_0.localEulerAngles

				var_118_7.z = 0
				var_118_7.x = 0
				var_118_0.localEulerAngles = var_118_7
			end

			if arg_115_1.time_ >= var_118_1 + var_118_3 and arg_115_1.time_ < var_118_1 + var_118_3 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_118_8 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_8.x, var_118_8.y, var_118_8.z)

				local var_118_9 = var_118_0.localEulerAngles

				var_118_9.z = 0
				var_118_9.x = 0
				var_118_0.localEulerAngles = var_118_9

				local var_118_10 = GameObjectTools.GetOrAddComponent(var_118_0.gameObject, typeof(DynamicBoneHelper))

				if var_118_10 then
					var_118_10:EnableDynamicBone(true)
				end
			end

			local var_118_11 = arg_115_1.actors_["6148ui_story"].transform
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.var_.moveOldPos6148ui_story = var_118_11.localPosition

				local var_118_13 = GameObjectTools.GetOrAddComponent(var_118_11.gameObject, typeof(DynamicBoneHelper))

				if var_118_13 then
					var_118_13:EnableDynamicBone(false)
				end
			end

			local var_118_14 = 0.001

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_14 then
				local var_118_15 = (arg_115_1.time_ - var_118_12) / var_118_14
				local var_118_16 = Vector3.New(0, 100, 0)

				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos6148ui_story, var_118_16, var_118_15)

				local var_118_17 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_17.x, var_118_17.y, var_118_17.z)

				local var_118_18 = var_118_11.localEulerAngles

				var_118_18.z = 0
				var_118_18.x = 0
				var_118_11.localEulerAngles = var_118_18
			end

			if arg_115_1.time_ >= var_118_12 + var_118_14 and arg_115_1.time_ < var_118_12 + var_118_14 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(0, 100, 0)

				local var_118_19 = manager.ui.mainCamera.transform.position - var_118_11.position

				var_118_11.forward = Vector3.New(var_118_19.x, var_118_19.y, var_118_19.z)

				local var_118_20 = var_118_11.localEulerAngles

				var_118_20.z = 0
				var_118_20.x = 0
				var_118_11.localEulerAngles = var_118_20

				local var_118_21 = GameObjectTools.GetOrAddComponent(var_118_11.gameObject, typeof(DynamicBoneHelper))

				if var_118_21 then
					var_118_21:EnableDynamicBone(true)
				end
			end

			local var_118_22 = arg_115_1.actors_["1054ui_story"]
			local var_118_23 = 0

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect1054ui_story == nil then
				arg_115_1.var_.characterEffect1054ui_story = var_118_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_24 = 0.200000002980232

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 and not isNil(var_118_22) then
				local var_118_25 = (arg_115_1.time_ - var_118_23) / var_118_24

				if arg_115_1.var_.characterEffect1054ui_story and not isNil(var_118_22) then
					arg_115_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect1054ui_story then
				arg_115_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_118_26 = 0

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_118_27 = 0

			if var_118_27 < arg_115_1.time_ and arg_115_1.time_ <= var_118_27 + arg_118_0 then
				arg_115_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_118_28 = 0
			local var_118_29 = 0.85

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_30 = arg_115_1:FormatText(StoryNameCfg[1487].name)

				arg_115_1.leftNameTxt_.text = var_118_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_31 = arg_115_1:GetWordFromCfg(939052028)
				local var_118_32 = arg_115_1:FormatText(var_118_31.content)

				arg_115_1.text_.text = var_118_32

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_33 = 34
				local var_118_34 = utf8.len(var_118_32)
				local var_118_35 = var_118_33 <= 0 and var_118_29 or var_118_29 * (var_118_34 / var_118_33)

				if var_118_35 > 0 and var_118_29 < var_118_35 then
					arg_115_1.talkMaxDuration = var_118_35

					if var_118_35 + var_118_28 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_35 + var_118_28
					end
				end

				arg_115_1.text_.text = var_118_32
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_36 = math.max(var_118_29, arg_115_1.talkMaxDuration)

			if var_118_28 <= arg_115_1.time_ and arg_115_1.time_ < var_118_28 + var_118_36 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_28) / var_118_36

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_28 + var_118_36 and arg_115_1.time_ < var_118_28 + var_118_36 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play939052029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 939052029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play939052030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1284ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1284ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0.7, -0.985, -6.22)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1284ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1047ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos1047ui_story = var_122_9.localPosition
			end

			local var_122_11 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11
				local var_122_13 = Vector3.New(0, 100, 0)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1047ui_story, var_122_13, var_122_12)

				local var_122_14 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_14.x, var_122_14.y, var_122_14.z)

				local var_122_15 = var_122_9.localEulerAngles

				var_122_15.z = 0
				var_122_15.x = 0
				var_122_9.localEulerAngles = var_122_15
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_9.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_9.localEulerAngles = var_122_17
			end

			local var_122_18 = arg_119_1.actors_["1284ui_story"]
			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.characterEffect1284ui_story == nil then
				arg_119_1.var_.characterEffect1284ui_story = var_122_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_20 = 0.200000002980232

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 and not isNil(var_122_18) then
				local var_122_21 = (arg_119_1.time_ - var_122_19) / var_122_20

				if arg_119_1.var_.characterEffect1284ui_story and not isNil(var_122_18) then
					arg_119_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.characterEffect1284ui_story then
				arg_119_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_122_22 = arg_119_1.actors_["1054ui_story"]
			local var_122_23 = 0

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 and not isNil(var_122_22) and arg_119_1.var_.characterEffect1054ui_story == nil then
				arg_119_1.var_.characterEffect1054ui_story = var_122_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_24 = 0.200000002980232

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_24 and not isNil(var_122_22) then
				local var_122_25 = (arg_119_1.time_ - var_122_23) / var_122_24

				if arg_119_1.var_.characterEffect1054ui_story and not isNil(var_122_22) then
					local var_122_26 = Mathf.Lerp(0, 0.5, var_122_25)

					arg_119_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1054ui_story.fillRatio = var_122_26
				end
			end

			if arg_119_1.time_ >= var_122_23 + var_122_24 and arg_119_1.time_ < var_122_23 + var_122_24 + arg_122_0 and not isNil(var_122_22) and arg_119_1.var_.characterEffect1054ui_story then
				local var_122_27 = 0.5

				arg_119_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1054ui_story.fillRatio = var_122_27
			end

			local var_122_28 = 0

			if var_122_28 < arg_119_1.time_ and arg_119_1.time_ <= var_122_28 + arg_122_0 then
				arg_119_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 then
				arg_119_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_122_30 = 0
			local var_122_31 = 1.225

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_32 = arg_119_1:FormatText(StoryNameCfg[6].name)

				arg_119_1.leftNameTxt_.text = var_122_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_33 = arg_119_1:GetWordFromCfg(939052029)
				local var_122_34 = arg_119_1:FormatText(var_122_33.content)

				arg_119_1.text_.text = var_122_34

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_35 = 49
				local var_122_36 = utf8.len(var_122_34)
				local var_122_37 = var_122_35 <= 0 and var_122_31 or var_122_31 * (var_122_36 / var_122_35)

				if var_122_37 > 0 and var_122_31 < var_122_37 then
					arg_119_1.talkMaxDuration = var_122_37

					if var_122_37 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_37 + var_122_30
					end
				end

				arg_119_1.text_.text = var_122_34
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_38 = math.max(var_122_31, arg_119_1.talkMaxDuration)

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_38 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_30) / var_122_38

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_30 + var_122_38 and arg_119_1.time_ < var_122_30 + var_122_38 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play939052030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 939052030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play939052031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1211ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1211ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1211ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["1054ui_story"].transform
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.var_.moveOldPos1054ui_story = var_126_9.localPosition

				local var_126_11 = GameObjectTools.GetOrAddComponent(var_126_9.gameObject, typeof(DynamicBoneHelper))

				if var_126_11 then
					var_126_11:EnableDynamicBone(false)
				end
			end

			local var_126_12 = 0.001

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_10) / var_126_12
				local var_126_14 = Vector3.New(0, 100, 0)

				var_126_9.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1054ui_story, var_126_14, var_126_13)

				local var_126_15 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_15.x, var_126_15.y, var_126_15.z)

				local var_126_16 = var_126_9.localEulerAngles

				var_126_16.z = 0
				var_126_16.x = 0
				var_126_9.localEulerAngles = var_126_16
			end

			if arg_123_1.time_ >= var_126_10 + var_126_12 and arg_123_1.time_ < var_126_10 + var_126_12 + arg_126_0 then
				var_126_9.localPosition = Vector3.New(0, 100, 0)

				local var_126_17 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_17.x, var_126_17.y, var_126_17.z)

				local var_126_18 = var_126_9.localEulerAngles

				var_126_18.z = 0
				var_126_18.x = 0
				var_126_9.localEulerAngles = var_126_18

				local var_126_19 = GameObjectTools.GetOrAddComponent(var_126_9.gameObject, typeof(DynamicBoneHelper))

				if var_126_19 then
					var_126_19:EnableDynamicBone(true)
				end
			end

			local var_126_20 = arg_123_1.actors_["1211ui_story"]
			local var_126_21 = 0

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 and not isNil(var_126_20) and arg_123_1.var_.characterEffect1211ui_story == nil then
				arg_123_1.var_.characterEffect1211ui_story = var_126_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_22 = 0.200000002980232

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_22 and not isNil(var_126_20) then
				local var_126_23 = (arg_123_1.time_ - var_126_21) / var_126_22

				if arg_123_1.var_.characterEffect1211ui_story and not isNil(var_126_20) then
					arg_123_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_21 + var_126_22 and arg_123_1.time_ < var_126_21 + var_126_22 + arg_126_0 and not isNil(var_126_20) and arg_123_1.var_.characterEffect1211ui_story then
				arg_123_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_126_24 = arg_123_1.actors_["1284ui_story"]
			local var_126_25 = 0

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = var_126_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_26 = 0.200000002980232

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 and not isNil(var_126_24) then
				local var_126_27 = (arg_123_1.time_ - var_126_25) / var_126_26

				if arg_123_1.var_.characterEffect1284ui_story and not isNil(var_126_24) then
					local var_126_28 = Mathf.Lerp(0, 0.5, var_126_27)

					arg_123_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1284ui_story.fillRatio = var_126_28
				end
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1284ui_story then
				local var_126_29 = 0.5

				arg_123_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1284ui_story.fillRatio = var_126_29
			end

			local var_126_30 = 0

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			local var_126_31 = 0

			if var_126_31 < arg_123_1.time_ and arg_123_1.time_ <= var_126_31 + arg_126_0 then
				arg_123_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_126_32 = 0
			local var_126_33 = 0.575

			if var_126_32 < arg_123_1.time_ and arg_123_1.time_ <= var_126_32 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_34 = arg_123_1:FormatText(StoryNameCfg[37].name)

				arg_123_1.leftNameTxt_.text = var_126_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_35 = arg_123_1:GetWordFromCfg(939052030)
				local var_126_36 = arg_123_1:FormatText(var_126_35.content)

				arg_123_1.text_.text = var_126_36

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_37 = 23
				local var_126_38 = utf8.len(var_126_36)
				local var_126_39 = var_126_37 <= 0 and var_126_33 or var_126_33 * (var_126_38 / var_126_37)

				if var_126_39 > 0 and var_126_33 < var_126_39 then
					arg_123_1.talkMaxDuration = var_126_39

					if var_126_39 + var_126_32 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_39 + var_126_32
					end
				end

				arg_123_1.text_.text = var_126_36
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_40 = math.max(var_126_33, arg_123_1.talkMaxDuration)

			if var_126_32 <= arg_123_1.time_ and arg_123_1.time_ < var_126_32 + var_126_40 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_32) / var_126_40

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_32 + var_126_40 and arg_123_1.time_ < var_126_32 + var_126_40 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play939052031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 939052031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play939052032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1211ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1211ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, 100, 0)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1211ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, 100, 0)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1284ui_story"].transform
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.var_.moveOldPos1284ui_story = var_130_9.localPosition
			end

			local var_130_11 = 0.001

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11
				local var_130_13 = Vector3.New(0, 100, 0)

				var_130_9.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1284ui_story, var_130_13, var_130_12)

				local var_130_14 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_14.x, var_130_14.y, var_130_14.z)

				local var_130_15 = var_130_9.localEulerAngles

				var_130_15.z = 0
				var_130_15.x = 0
				var_130_9.localEulerAngles = var_130_15
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 then
				var_130_9.localPosition = Vector3.New(0, 100, 0)

				local var_130_16 = manager.ui.mainCamera.transform.position - var_130_9.position

				var_130_9.forward = Vector3.New(var_130_16.x, var_130_16.y, var_130_16.z)

				local var_130_17 = var_130_9.localEulerAngles

				var_130_17.z = 0
				var_130_17.x = 0
				var_130_9.localEulerAngles = var_130_17
			end

			local var_130_18 = arg_127_1.actors_["1211ui_story"]
			local var_130_19 = 0

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1211ui_story == nil then
				arg_127_1.var_.characterEffect1211ui_story = var_130_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_20 = 0.200000002980232

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_20 and not isNil(var_130_18) then
				local var_130_21 = (arg_127_1.time_ - var_130_19) / var_130_20

				if arg_127_1.var_.characterEffect1211ui_story and not isNil(var_130_18) then
					local var_130_22 = Mathf.Lerp(0, 0.5, var_130_21)

					arg_127_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1211ui_story.fillRatio = var_130_22
				end
			end

			if arg_127_1.time_ >= var_130_19 + var_130_20 and arg_127_1.time_ < var_130_19 + var_130_20 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1211ui_story then
				local var_130_23 = 0.5

				arg_127_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1211ui_story.fillRatio = var_130_23
			end

			local var_130_24 = 0
			local var_130_25 = 0.6

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_26 = arg_127_1:GetWordFromCfg(939052031)
				local var_130_27 = arg_127_1:FormatText(var_130_26.content)

				arg_127_1.text_.text = var_130_27

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_28 = 24
				local var_130_29 = utf8.len(var_130_27)
				local var_130_30 = var_130_28 <= 0 and var_130_25 or var_130_25 * (var_130_29 / var_130_28)

				if var_130_30 > 0 and var_130_25 < var_130_30 then
					arg_127_1.talkMaxDuration = var_130_30

					if var_130_30 + var_130_24 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_30 + var_130_24
					end
				end

				arg_127_1.text_.text = var_130_27
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_31 = math.max(var_130_25, arg_127_1.talkMaxDuration)

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_31 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_24) / var_130_31

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_24 + var_130_31 and arg_127_1.time_ < var_130_24 + var_130_31 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play939052032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 939052032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play939052033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.375

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(939052032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 15
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play939052033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 939052033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play939052034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1047ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1047ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -1.13, -6.2)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1047ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_11 = 0
			local var_138_12 = 0.575

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_13 = arg_135_1:FormatText(StoryNameCfg[1296].name)

				arg_135_1.leftNameTxt_.text = var_138_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(939052033)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 23
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_12 or var_138_12 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_12 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_19 and arg_135_1.time_ < var_138_11 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play939052034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 939052034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play939052035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1047ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1047ui_story == nil then
				arg_139_1.var_.characterEffect1047ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1047ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1047ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1047ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1047ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.8

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(939052034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 32
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play939052035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 939052035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play939052036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1047ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1047ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -1.13, -6.2)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1047ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_146_11 = arg_143_1.actors_["1047ui_story"]
			local var_146_12 = 0

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect1047ui_story == nil then
				arg_143_1.var_.characterEffect1047ui_story = var_146_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_13 = 0.2

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_13 and not isNil(var_146_11) then
				local var_146_14 = (arg_143_1.time_ - var_146_12) / var_146_13

				if arg_143_1.var_.characterEffect1047ui_story and not isNil(var_146_11) then
					arg_143_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_12 + var_146_13 and arg_143_1.time_ < var_146_12 + var_146_13 + arg_146_0 and not isNil(var_146_11) and arg_143_1.var_.characterEffect1047ui_story then
				arg_143_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_146_15 = 0
			local var_146_16 = 0.375

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_17 = arg_143_1:FormatText(StoryNameCfg[1296].name)

				arg_143_1.leftNameTxt_.text = var_146_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_18 = arg_143_1:GetWordFromCfg(939052035)
				local var_146_19 = arg_143_1:FormatText(var_146_18.content)

				arg_143_1.text_.text = var_146_19

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_20 = 15
				local var_146_21 = utf8.len(var_146_19)
				local var_146_22 = var_146_20 <= 0 and var_146_16 or var_146_16 * (var_146_21 / var_146_20)

				if var_146_22 > 0 and var_146_16 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22

					if var_146_22 + var_146_15 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_15
					end
				end

				arg_143_1.text_.text = var_146_19
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_23 = math.max(var_146_16, arg_143_1.talkMaxDuration)

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_23 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_23

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_23 and arg_143_1.time_ < var_146_15 + var_146_23 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play939052036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 939052036
		arg_147_1.duration_ = 1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				local var_148_0 = iter_148_0 <= 2

				SetActive(iter_148_1.go, var_148_0)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1678].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1679].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play939052037(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play939052037(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(939052036, 1678, 1679)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_1 = 0.6

			if arg_147_1.time_ >= var_150_0 + var_150_1 and arg_147_1.time_ < var_150_0 + var_150_1 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play939052037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 939052037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play939052038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1047ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1047ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -1.13, -6.2)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1047ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = "1047ui_story"

			if arg_151_1.actors_[var_154_9] == nil then
				local var_154_10 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_154_10) then
					local var_154_11 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_151_1.stage_.transform)

					var_154_11.name = var_154_9
					var_154_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_151_1.actors_[var_154_9] = var_154_11

					local var_154_12 = var_154_11:GetComponentInChildren(typeof(CharacterEffect))

					var_154_12.enabled = true

					local var_154_13 = GameObjectTools.GetOrAddComponent(var_154_11, typeof(DynamicBoneHelper))

					if var_154_13 then
						var_154_13:EnableDynamicBone(false)
					end

					arg_151_1:ShowWeapon(var_154_12.transform, false)

					arg_151_1.var_[var_154_9 .. "Animator"] = var_154_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_151_1.var_[var_154_9 .. "Animator"].applyRootMotion = true
					arg_151_1.var_[var_154_9 .. "LipSync"] = var_154_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_154_15 = "1047ui_story"

			if arg_151_1.actors_[var_154_15] == nil then
				local var_154_16 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_154_16) then
					local var_154_17 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_151_1.stage_.transform)

					var_154_17.name = var_154_15
					var_154_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_151_1.actors_[var_154_15] = var_154_17

					local var_154_18 = var_154_17:GetComponentInChildren(typeof(CharacterEffect))

					var_154_18.enabled = true

					local var_154_19 = GameObjectTools.GetOrAddComponent(var_154_17, typeof(DynamicBoneHelper))

					if var_154_19 then
						var_154_19:EnableDynamicBone(false)
					end

					arg_151_1:ShowWeapon(var_154_18.transform, false)

					arg_151_1.var_[var_154_15 .. "Animator"] = var_154_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_151_1.var_[var_154_15 .. "Animator"].applyRootMotion = true
					arg_151_1.var_[var_154_15 .. "LipSync"] = var_154_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_154_20 = 0

			if var_154_20 < arg_151_1.time_ and arg_151_1.time_ <= var_154_20 + arg_154_0 then
				arg_151_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_154_21 = 0
			local var_154_22 = 0.825

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_23 = arg_151_1:FormatText(StoryNameCfg[1296].name)

				arg_151_1.leftNameTxt_.text = var_154_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_24 = arg_151_1:GetWordFromCfg(939052037)
				local var_154_25 = arg_151_1:FormatText(var_154_24.content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_26 = 33
				local var_154_27 = utf8.len(var_154_25)
				local var_154_28 = var_154_26 <= 0 and var_154_22 or var_154_22 * (var_154_27 / var_154_26)

				if var_154_28 > 0 and var_154_22 < var_154_28 then
					arg_151_1.talkMaxDuration = var_154_28

					if var_154_28 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_28 + var_154_21
					end
				end

				arg_151_1.text_.text = var_154_25
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_29 = math.max(var_154_22, arg_151_1.talkMaxDuration)

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_29 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_21) / var_154_29

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_21 + var_154_29 and arg_151_1.time_ < var_154_21 + var_154_29 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play939052038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 939052038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play939052039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1047ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1047ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1047ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0
			local var_158_10 = 0.6

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_11 = arg_155_1:GetWordFromCfg(939052038)
				local var_158_12 = arg_155_1:FormatText(var_158_11.content)

				arg_155_1.text_.text = var_158_12

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 24
				local var_158_14 = utf8.len(var_158_12)
				local var_158_15 = var_158_13 <= 0 and var_158_10 or var_158_10 * (var_158_14 / var_158_13)

				if var_158_15 > 0 and var_158_10 < var_158_15 then
					arg_155_1.talkMaxDuration = var_158_15

					if var_158_15 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_15 + var_158_9
					end
				end

				arg_155_1.text_.text = var_158_12
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_10, arg_155_1.talkMaxDuration)

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_9) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_9 + var_158_16 and arg_155_1.time_ < var_158_9 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play939052039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 939052039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play939052040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1054ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = var_162_0.localPosition

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end
			end

			local var_162_3 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Vector3.New(-0.7, -0.985, -6)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, var_162_5, var_162_4)

				local var_162_6 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_6.x, var_162_6.y, var_162_6.z)

				local var_162_7 = var_162_0.localEulerAngles

				var_162_7.z = 0
				var_162_7.x = 0
				var_162_0.localEulerAngles = var_162_7
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_162_8 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_8.x, var_162_8.y, var_162_8.z)

				local var_162_9 = var_162_0.localEulerAngles

				var_162_9.z = 0
				var_162_9.x = 0
				var_162_0.localEulerAngles = var_162_9

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = arg_159_1.actors_["1054ui_story"]
			local var_162_12 = 0

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_13 = 0.200000002980232

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_13 and not isNil(var_162_11) then
				local var_162_14 = (arg_159_1.time_ - var_162_12) / var_162_13

				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_11) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_12 + var_162_13 and arg_159_1.time_ < var_162_12 + var_162_13 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_162_15 = 0

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 then
				arg_159_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_162_17 = 0
			local var_162_18 = 0.3

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_19 = arg_159_1:FormatText(StoryNameCfg[1487].name)

				arg_159_1.leftNameTxt_.text = var_162_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_20 = arg_159_1:GetWordFromCfg(939052039)
				local var_162_21 = arg_159_1:FormatText(var_162_20.content)

				arg_159_1.text_.text = var_162_21

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_22 = 12
				local var_162_23 = utf8.len(var_162_21)
				local var_162_24 = var_162_22 <= 0 and var_162_18 or var_162_18 * (var_162_23 / var_162_22)

				if var_162_24 > 0 and var_162_18 < var_162_24 then
					arg_159_1.talkMaxDuration = var_162_24

					if var_162_24 + var_162_17 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_24 + var_162_17
					end
				end

				arg_159_1.text_.text = var_162_21
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_18, arg_159_1.talkMaxDuration)

			if var_162_17 <= arg_159_1.time_ and arg_159_1.time_ < var_162_17 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_17) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_17 + var_162_25 and arg_159_1.time_ < var_162_17 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play939052040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 939052040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play939052041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1047ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1047ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0.74, -1.13, -6.2)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1047ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["1054ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1054ui_story == nil then
				arg_163_1.var_.characterEffect1054ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect1054ui_story and not isNil(var_166_9) then
					local var_166_13 = Mathf.Lerp(0, 0.5, var_166_12)

					arg_163_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1054ui_story.fillRatio = var_166_13
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect1054ui_story then
				local var_166_14 = 0.5

				arg_163_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1054ui_story.fillRatio = var_166_14
			end

			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_166_17 = 0
			local var_166_18 = 1.125

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_19 = arg_163_1:FormatText(StoryNameCfg[1296].name)

				arg_163_1.leftNameTxt_.text = var_166_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_20 = arg_163_1:GetWordFromCfg(939052040)
				local var_166_21 = arg_163_1:FormatText(var_166_20.content)

				arg_163_1.text_.text = var_166_21

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_22 = 45
				local var_166_23 = utf8.len(var_166_21)
				local var_166_24 = var_166_22 <= 0 and var_166_18 or var_166_18 * (var_166_23 / var_166_22)

				if var_166_24 > 0 and var_166_18 < var_166_24 then
					arg_163_1.talkMaxDuration = var_166_24

					if var_166_24 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_24 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_21
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_17) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_17 + var_166_25 and arg_163_1.time_ < var_166_17 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play939052041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 939052041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play939052042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1047ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1047ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0.74, -1.13, -6.2)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1047ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_170_11 = 0
			local var_170_12 = 1.175

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_13 = arg_167_1:FormatText(StoryNameCfg[1296].name)

				arg_167_1.leftNameTxt_.text = var_170_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(939052041)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 47
				local var_170_17 = utf8.len(var_170_15)
				local var_170_18 = var_170_16 <= 0 and var_170_12 or var_170_12 * (var_170_17 / var_170_16)

				if var_170_18 > 0 and var_170_12 < var_170_18 then
					arg_167_1.talkMaxDuration = var_170_18

					if var_170_18 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_19 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_19 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_19

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_19 and arg_167_1.time_ < var_170_11 + var_170_19 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play939052042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 939052042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play939052043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["6148ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos6148ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(-0.7, -0.985, -6)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos6148ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["1054ui_story"].transform
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = var_174_11.localPosition

				local var_174_13 = GameObjectTools.GetOrAddComponent(var_174_11.gameObject, typeof(DynamicBoneHelper))

				if var_174_13 then
					var_174_13:EnableDynamicBone(false)
				end
			end

			local var_174_14 = 0.001

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_14 then
				local var_174_15 = (arg_171_1.time_ - var_174_12) / var_174_14
				local var_174_16 = Vector3.New(0, 100, 0)

				var_174_11.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, var_174_16, var_174_15)

				local var_174_17 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_17.x, var_174_17.y, var_174_17.z)

				local var_174_18 = var_174_11.localEulerAngles

				var_174_18.z = 0
				var_174_18.x = 0
				var_174_11.localEulerAngles = var_174_18
			end

			if arg_171_1.time_ >= var_174_12 + var_174_14 and arg_171_1.time_ < var_174_12 + var_174_14 + arg_174_0 then
				var_174_11.localPosition = Vector3.New(0, 100, 0)

				local var_174_19 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_19.x, var_174_19.y, var_174_19.z)

				local var_174_20 = var_174_11.localEulerAngles

				var_174_20.z = 0
				var_174_20.x = 0
				var_174_11.localEulerAngles = var_174_20

				local var_174_21 = GameObjectTools.GetOrAddComponent(var_174_11.gameObject, typeof(DynamicBoneHelper))

				if var_174_21 then
					var_174_21:EnableDynamicBone(true)
				end
			end

			local var_174_22 = arg_171_1.actors_["6148ui_story"]
			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect6148ui_story == nil then
				arg_171_1.var_.characterEffect6148ui_story = var_174_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_24 = 0.200000002980232

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 and not isNil(var_174_22) then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24

				if arg_171_1.var_.characterEffect6148ui_story and not isNil(var_174_22) then
					arg_171_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect6148ui_story then
				arg_171_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_174_26 = 0

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 then
				arg_171_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_174_27 = 0

			if var_174_27 < arg_171_1.time_ and arg_171_1.time_ <= var_174_27 + arg_174_0 then
				arg_171_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_174_28 = 0
			local var_174_29 = 1.025

			if var_174_28 < arg_171_1.time_ and arg_171_1.time_ <= var_174_28 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_30 = arg_171_1:FormatText(StoryNameCfg[1488].name)

				arg_171_1.leftNameTxt_.text = var_174_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_31 = arg_171_1:GetWordFromCfg(939052042)
				local var_174_32 = arg_171_1:FormatText(var_174_31.content)

				arg_171_1.text_.text = var_174_32

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_33 = 41
				local var_174_34 = utf8.len(var_174_32)
				local var_174_35 = var_174_33 <= 0 and var_174_29 or var_174_29 * (var_174_34 / var_174_33)

				if var_174_35 > 0 and var_174_29 < var_174_35 then
					arg_171_1.talkMaxDuration = var_174_35

					if var_174_35 + var_174_28 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_35 + var_174_28
					end
				end

				arg_171_1.text_.text = var_174_32
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_36 = math.max(var_174_29, arg_171_1.talkMaxDuration)

			if var_174_28 <= arg_171_1.time_ and arg_171_1.time_ < var_174_28 + var_174_36 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_28) / var_174_36

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_28 + var_174_36 and arg_171_1.time_ < var_174_28 + var_174_36 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play939052043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 939052043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play939052044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1054ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1054ui_story = var_178_0.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_3 then
				local var_178_4 = (arg_175_1.time_ - var_178_1) / var_178_3
				local var_178_5 = Vector3.New(0.7, -0.985, -6)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1054ui_story, var_178_5, var_178_4)

				local var_178_6 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_6.x, var_178_6.y, var_178_6.z)

				local var_178_7 = var_178_0.localEulerAngles

				var_178_7.z = 0
				var_178_7.x = 0
				var_178_0.localEulerAngles = var_178_7
			end

			if arg_175_1.time_ >= var_178_1 + var_178_3 and arg_175_1.time_ < var_178_1 + var_178_3 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_178_8 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_8.x, var_178_8.y, var_178_8.z)

				local var_178_9 = var_178_0.localEulerAngles

				var_178_9.z = 0
				var_178_9.x = 0
				var_178_0.localEulerAngles = var_178_9

				local var_178_10 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_10 then
					var_178_10:EnableDynamicBone(true)
				end
			end

			local var_178_11 = arg_175_1.actors_["1047ui_story"].transform
			local var_178_12 = 0

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.var_.moveOldPos1047ui_story = var_178_11.localPosition
			end

			local var_178_13 = 0.001

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_13 then
				local var_178_14 = (arg_175_1.time_ - var_178_12) / var_178_13
				local var_178_15 = Vector3.New(0, 100, 0)

				var_178_11.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1047ui_story, var_178_15, var_178_14)

				local var_178_16 = manager.ui.mainCamera.transform.position - var_178_11.position

				var_178_11.forward = Vector3.New(var_178_16.x, var_178_16.y, var_178_16.z)

				local var_178_17 = var_178_11.localEulerAngles

				var_178_17.z = 0
				var_178_17.x = 0
				var_178_11.localEulerAngles = var_178_17
			end

			if arg_175_1.time_ >= var_178_12 + var_178_13 and arg_175_1.time_ < var_178_12 + var_178_13 + arg_178_0 then
				var_178_11.localPosition = Vector3.New(0, 100, 0)

				local var_178_18 = manager.ui.mainCamera.transform.position - var_178_11.position

				var_178_11.forward = Vector3.New(var_178_18.x, var_178_18.y, var_178_18.z)

				local var_178_19 = var_178_11.localEulerAngles

				var_178_19.z = 0
				var_178_19.x = 0
				var_178_11.localEulerAngles = var_178_19
			end

			local var_178_20 = arg_175_1.actors_["1054ui_story"]
			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1054ui_story == nil then
				arg_175_1.var_.characterEffect1054ui_story = var_178_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_22 = 0.200000002980232

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 and not isNil(var_178_20) then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22

				if arg_175_1.var_.characterEffect1054ui_story and not isNil(var_178_20) then
					arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 and not isNil(var_178_20) and arg_175_1.var_.characterEffect1054ui_story then
				arg_175_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_178_24 = arg_175_1.actors_["6148ui_story"]
			local var_178_25 = 0

			if var_178_25 < arg_175_1.time_ and arg_175_1.time_ <= var_178_25 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect6148ui_story == nil then
				arg_175_1.var_.characterEffect6148ui_story = var_178_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_26 = 0.200000002980232

			if var_178_25 <= arg_175_1.time_ and arg_175_1.time_ < var_178_25 + var_178_26 and not isNil(var_178_24) then
				local var_178_27 = (arg_175_1.time_ - var_178_25) / var_178_26

				if arg_175_1.var_.characterEffect6148ui_story and not isNil(var_178_24) then
					local var_178_28 = Mathf.Lerp(0, 0.5, var_178_27)

					arg_175_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_175_1.var_.characterEffect6148ui_story.fillRatio = var_178_28
				end
			end

			if arg_175_1.time_ >= var_178_25 + var_178_26 and arg_175_1.time_ < var_178_25 + var_178_26 + arg_178_0 and not isNil(var_178_24) and arg_175_1.var_.characterEffect6148ui_story then
				local var_178_29 = 0.5

				arg_175_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_175_1.var_.characterEffect6148ui_story.fillRatio = var_178_29
			end

			local var_178_30 = 0

			if var_178_30 < arg_175_1.time_ and arg_175_1.time_ <= var_178_30 + arg_178_0 then
				arg_175_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_178_31 = 0

			if var_178_31 < arg_175_1.time_ and arg_175_1.time_ <= var_178_31 + arg_178_0 then
				arg_175_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_32 = 0
			local var_178_33 = 0.075

			if var_178_32 < arg_175_1.time_ and arg_175_1.time_ <= var_178_32 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_34 = arg_175_1:FormatText(StoryNameCfg[1487].name)

				arg_175_1.leftNameTxt_.text = var_178_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_35 = arg_175_1:GetWordFromCfg(939052043)
				local var_178_36 = arg_175_1:FormatText(var_178_35.content)

				arg_175_1.text_.text = var_178_36

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_37 = 3
				local var_178_38 = utf8.len(var_178_36)
				local var_178_39 = var_178_37 <= 0 and var_178_33 or var_178_33 * (var_178_38 / var_178_37)

				if var_178_39 > 0 and var_178_33 < var_178_39 then
					arg_175_1.talkMaxDuration = var_178_39

					if var_178_39 + var_178_32 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_39 + var_178_32
					end
				end

				arg_175_1.text_.text = var_178_36
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_40 = math.max(var_178_33, arg_175_1.talkMaxDuration)

			if var_178_32 <= arg_175_1.time_ and arg_175_1.time_ < var_178_32 + var_178_40 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_32) / var_178_40

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_32 + var_178_40 and arg_175_1.time_ < var_178_32 + var_178_40 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play939052044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 939052044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play939052045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1047ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1047ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1047ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["6148ui_story"].transform
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1.var_.moveOldPos6148ui_story = var_182_9.localPosition

				local var_182_11 = GameObjectTools.GetOrAddComponent(var_182_9.gameObject, typeof(DynamicBoneHelper))

				if var_182_11 then
					var_182_11:EnableDynamicBone(false)
				end
			end

			local var_182_12 = 0.001

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_12 then
				local var_182_13 = (arg_179_1.time_ - var_182_10) / var_182_12
				local var_182_14 = Vector3.New(0, 100, 0)

				var_182_9.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos6148ui_story, var_182_14, var_182_13)

				local var_182_15 = manager.ui.mainCamera.transform.position - var_182_9.position

				var_182_9.forward = Vector3.New(var_182_15.x, var_182_15.y, var_182_15.z)

				local var_182_16 = var_182_9.localEulerAngles

				var_182_16.z = 0
				var_182_16.x = 0
				var_182_9.localEulerAngles = var_182_16
			end

			if arg_179_1.time_ >= var_182_10 + var_182_12 and arg_179_1.time_ < var_182_10 + var_182_12 + arg_182_0 then
				var_182_9.localPosition = Vector3.New(0, 100, 0)

				local var_182_17 = manager.ui.mainCamera.transform.position - var_182_9.position

				var_182_9.forward = Vector3.New(var_182_17.x, var_182_17.y, var_182_17.z)

				local var_182_18 = var_182_9.localEulerAngles

				var_182_18.z = 0
				var_182_18.x = 0
				var_182_9.localEulerAngles = var_182_18

				local var_182_19 = GameObjectTools.GetOrAddComponent(var_182_9.gameObject, typeof(DynamicBoneHelper))

				if var_182_19 then
					var_182_19:EnableDynamicBone(true)
				end
			end

			local var_182_20 = arg_179_1.actors_["1054ui_story"]
			local var_182_21 = 0

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 and not isNil(var_182_20) and arg_179_1.var_.characterEffect1054ui_story == nil then
				arg_179_1.var_.characterEffect1054ui_story = var_182_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_22 = 0.200000002980232

			if var_182_21 <= arg_179_1.time_ and arg_179_1.time_ < var_182_21 + var_182_22 and not isNil(var_182_20) then
				local var_182_23 = (arg_179_1.time_ - var_182_21) / var_182_22

				if arg_179_1.var_.characterEffect1054ui_story and not isNil(var_182_20) then
					local var_182_24 = Mathf.Lerp(0, 0.5, var_182_23)

					arg_179_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1054ui_story.fillRatio = var_182_24
				end
			end

			if arg_179_1.time_ >= var_182_21 + var_182_22 and arg_179_1.time_ < var_182_21 + var_182_22 + arg_182_0 and not isNil(var_182_20) and arg_179_1.var_.characterEffect1054ui_story then
				local var_182_25 = 0.5

				arg_179_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1054ui_story.fillRatio = var_182_25
			end

			local var_182_26 = 0

			if var_182_26 < arg_179_1.time_ and arg_179_1.time_ <= var_182_26 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_182_27 = 0

			if var_182_27 < arg_179_1.time_ and arg_179_1.time_ <= var_182_27 + arg_182_0 then
				arg_179_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_28 = 0
			local var_182_29 = 1.55

			if var_182_28 < arg_179_1.time_ and arg_179_1.time_ <= var_182_28 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_30 = arg_179_1:FormatText(StoryNameCfg[1296].name)

				arg_179_1.leftNameTxt_.text = var_182_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_31 = arg_179_1:GetWordFromCfg(939052044)
				local var_182_32 = arg_179_1:FormatText(var_182_31.content)

				arg_179_1.text_.text = var_182_32

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_33 = 62
				local var_182_34 = utf8.len(var_182_32)
				local var_182_35 = var_182_33 <= 0 and var_182_29 or var_182_29 * (var_182_34 / var_182_33)

				if var_182_35 > 0 and var_182_29 < var_182_35 then
					arg_179_1.talkMaxDuration = var_182_35

					if var_182_35 + var_182_28 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_35 + var_182_28
					end
				end

				arg_179_1.text_.text = var_182_32
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_36 = math.max(var_182_29, arg_179_1.talkMaxDuration)

			if var_182_28 <= arg_179_1.time_ and arg_179_1.time_ < var_182_28 + var_182_36 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_28) / var_182_36

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_28 + var_182_36 and arg_179_1.time_ < var_182_28 + var_182_36 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_179_1:InitPlayNodeList()
	end,
	Play939052045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 939052045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play939052046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1047ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1047ui_story == nil then
				arg_183_1.var_.characterEffect1047ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1047ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1047ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1047ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1047ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.525

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(939052045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 21
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play939052046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 939052046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play939052047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1047ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1047ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1047ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = 0

			if var_190_9 < arg_187_1.time_ and arg_187_1.time_ <= var_190_9 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_190_11 = arg_187_1.actors_["1047ui_story"]
			local var_190_12 = 0

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 and not isNil(var_190_11) and arg_187_1.var_.characterEffect1047ui_story == nil then
				arg_187_1.var_.characterEffect1047ui_story = var_190_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_13 = 0.2

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_13 and not isNil(var_190_11) then
				local var_190_14 = (arg_187_1.time_ - var_190_12) / var_190_13

				if arg_187_1.var_.characterEffect1047ui_story and not isNil(var_190_11) then
					arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_12 + var_190_13 and arg_187_1.time_ < var_190_12 + var_190_13 + arg_190_0 and not isNil(var_190_11) and arg_187_1.var_.characterEffect1047ui_story then
				arg_187_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_190_15 = 0
			local var_190_16 = 0.7

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[1296].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(939052046)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 28
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_23 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_23 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_23

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_23 and arg_187_1.time_ < var_190_15 + var_190_23 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play939052047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 939052047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play939052048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1047ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1047ui_story == nil then
				arg_191_1.var_.characterEffect1047ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1047ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1047ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1047ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1047ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.9

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(939052047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 36
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play939052048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 939052048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
			arg_195_1.auto_ = false
		end

		function arg_195_1.playNext_(arg_197_0)
			arg_195_1.onStoryFinished_()
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 5

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				local var_198_2 = "1"

				arg_195_1.marker = "2132121111"

				if not arg_195_1.actionList["1"] then
					arg_195_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_195_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_195_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 2,
					postId = 205,
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

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/I03"
	},
	voices = {},
	skipMarkers = {
		939052048
	}
}
