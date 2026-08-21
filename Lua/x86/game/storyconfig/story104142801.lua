return {
	Play414281001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414281001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414281002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H07f"

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
				local var_4_5 = arg_1_1.bgs_.H07f

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
					if iter_4_0 ~= "H07f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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
			local var_4_25 = 0.266666666666667

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

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

			local var_4_30 = 0.366666666666667
			local var_4_31 = 0.833333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

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

			local var_4_36 = 1.999999999999
			local var_4_37 = 1.075

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

				local var_4_39 = arg_1_1:GetWordFromCfg(414281001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 43
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
	Play414281002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414281002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414281003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "104902ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "104902ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["104902ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos104902ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.2, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos104902ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["104902ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect104902ui_story == nil then
				arg_9_1.var_.characterEffect104902ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect104902ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect104902ui_story then
				arg_9_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_12_20 = 0
			local var_12_21 = 0.1

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[562].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(414281002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 4
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
				actorName = "104902ui_story",
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
	Play414281003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414281003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414281004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["104902ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos104902ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos104902ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["104902ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect104902ui_story == nil then
				arg_13_1.var_.characterEffect104902ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect104902ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_13_1.var_.characterEffect104902ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect104902ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_13_1.var_.characterEffect104902ui_story.fillRatio = var_16_14
			end

			local var_16_15 = "4010ui_story"

			if arg_13_1.actors_[var_16_15] == nil then
				local var_16_16 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_16_16) then
					local var_16_17 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_13_1.stage_.transform)

					var_16_17.name = var_16_15
					var_16_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_15] = var_16_17

					local var_16_18 = var_16_17:GetComponentInChildren(typeof(CharacterEffect))

					var_16_18.enabled = true

					local var_16_19 = GameObjectTools.GetOrAddComponent(var_16_17, typeof(DynamicBoneHelper))

					if var_16_19 then
						var_16_19:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_18.transform, false)

					arg_13_1.var_[var_16_15 .. "Animator"] = var_16_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_15 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_15 .. "LipSync"] = var_16_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_20 = arg_13_1.actors_["4010ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos4010ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0, -1.59, -5.2)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4010ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["4010ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect4010ui_story == nil then
				arg_13_1.var_.characterEffect4010ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect4010ui_story and not isNil(var_16_29) then
					arg_13_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect4010ui_story then
				arg_13_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_16_33 = 0

			if var_16_33 < arg_13_1.time_ and arg_13_1.time_ <= var_16_33 + arg_16_0 then
				arg_13_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_16_34 = 0

			if var_16_34 < arg_13_1.time_ and arg_13_1.time_ <= var_16_34 + arg_16_0 then
				arg_13_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_35 = 0
			local var_16_36 = 0.7

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[42].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(414281003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 28
				local var_16_41 = utf8.len(var_16_39)
				local var_16_42 = var_16_40 <= 0 and var_16_36 or var_16_36 * (var_16_41 / var_16_40)

				if var_16_42 > 0 and var_16_36 < var_16_42 then
					arg_13_1.talkMaxDuration = var_16_42

					if var_16_42 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_35
					end
				end

				arg_13_1.text_.text = var_16_39
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_43 = math.max(var_16_36, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_43 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_43

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_43 and arg_13_1.time_ < var_16_35 + var_16_43 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play414281004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414281004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414281005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["4010ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4010ui_story == nil then
				arg_17_1.var_.characterEffect4010ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect4010ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_17_1.var_.characterEffect4010ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect4010ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_17_1.var_.characterEffect4010ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.625

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(414281004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 25
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play414281005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414281005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414281006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["4010ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect4010ui_story == nil then
				arg_21_1.var_.characterEffect4010ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect4010ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect4010ui_story then
				arg_21_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.475

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[42].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(414281005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 19
				local var_24_10 = utf8.len(var_24_8)
				local var_24_11 = var_24_9 <= 0 and var_24_5 or var_24_5 * (var_24_10 / var_24_9)

				if var_24_11 > 0 and var_24_5 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play414281006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414281006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414281007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "102201ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "102201ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["102201ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos102201ui_story = var_28_5.localPosition

				local var_28_7 = "102201ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_7 .. "Animator"].transform, false)
			end

			local var_28_8 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_6) / var_28_8
				local var_28_10 = Vector3.New(-0.7, -1.08, -6)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos102201ui_story, var_28_10, var_28_9)

				local var_28_11 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_11.x, var_28_11.y, var_28_11.z)

				local var_28_12 = var_28_5.localEulerAngles

				var_28_12.z = 0
				var_28_12.x = 0
				var_28_5.localEulerAngles = var_28_12
			end

			if arg_25_1.time_ >= var_28_6 + var_28_8 and arg_25_1.time_ < var_28_6 + var_28_8 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-0.7, -1.08, -6)

				local var_28_13 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_13.x, var_28_13.y, var_28_13.z)

				local var_28_14 = var_28_5.localEulerAngles

				var_28_14.z = 0
				var_28_14.x = 0
				var_28_5.localEulerAngles = var_28_14
			end

			local var_28_15 = arg_25_1.actors_["102201ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect102201ui_story == nil then
				arg_25_1.var_.characterEffect102201ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect102201ui_story and not isNil(var_28_15) then
					arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect102201ui_story then
				arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_28_20 = arg_25_1.actors_["4010ui_story"].transform
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.var_.moveOldPos4010ui_story = var_28_20.localPosition
			end

			local var_28_22 = 0.001

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22
				local var_28_24 = Vector3.New(0.7, -1.59, -5.2)

				var_28_20.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos4010ui_story, var_28_24, var_28_23)

				local var_28_25 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_25.x, var_28_25.y, var_28_25.z)

				local var_28_26 = var_28_20.localEulerAngles

				var_28_26.z = 0
				var_28_26.x = 0
				var_28_20.localEulerAngles = var_28_26
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 then
				var_28_20.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_28_27 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_27.x, var_28_27.y, var_28_27.z)

				local var_28_28 = var_28_20.localEulerAngles

				var_28_28.z = 0
				var_28_28.x = 0
				var_28_20.localEulerAngles = var_28_28
			end

			local var_28_29 = arg_25_1.actors_["4010ui_story"]
			local var_28_30 = 0

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect4010ui_story == nil then
				arg_25_1.var_.characterEffect4010ui_story = var_28_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_31 = 0.200000002980232

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_31 and not isNil(var_28_29) then
				local var_28_32 = (arg_25_1.time_ - var_28_30) / var_28_31

				if arg_25_1.var_.characterEffect4010ui_story and not isNil(var_28_29) then
					local var_28_33 = Mathf.Lerp(0, 0.5, var_28_32)

					arg_25_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_25_1.var_.characterEffect4010ui_story.fillRatio = var_28_33
				end
			end

			if arg_25_1.time_ >= var_28_30 + var_28_31 and arg_25_1.time_ < var_28_30 + var_28_31 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect4010ui_story then
				local var_28_34 = 0.5

				arg_25_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_25_1.var_.characterEffect4010ui_story.fillRatio = var_28_34
			end

			local var_28_35 = 0

			if var_28_35 < arg_25_1.time_ and arg_25_1.time_ <= var_28_35 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_28_36 = 0
			local var_28_37 = 0.225

			if var_28_36 < arg_25_1.time_ and arg_25_1.time_ <= var_28_36 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_38 = arg_25_1:FormatText(StoryNameCfg[259].name)

				arg_25_1.leftNameTxt_.text = var_28_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_39 = arg_25_1:GetWordFromCfg(414281006)
				local var_28_40 = arg_25_1:FormatText(var_28_39.content)

				arg_25_1.text_.text = var_28_40

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_41 = 9
				local var_28_42 = utf8.len(var_28_40)
				local var_28_43 = var_28_41 <= 0 and var_28_37 or var_28_37 * (var_28_42 / var_28_41)

				if var_28_43 > 0 and var_28_37 < var_28_43 then
					arg_25_1.talkMaxDuration = var_28_43

					if var_28_43 + var_28_36 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_43 + var_28_36
					end
				end

				arg_25_1.text_.text = var_28_40
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_44 = math.max(var_28_37, arg_25_1.talkMaxDuration)

			if var_28_36 <= arg_25_1.time_ and arg_25_1.time_ < var_28_36 + var_28_44 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_36) / var_28_44

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_36 + var_28_44 and arg_25_1.time_ < var_28_36 + var_28_44 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play414281007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414281007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414281008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["102201ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect102201ui_story == nil then
				arg_29_1.var_.characterEffect102201ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect102201ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_29_1.var_.characterEffect102201ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect102201ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_29_1.var_.characterEffect102201ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_8 = arg_29_1.actors_["4010ui_story"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.characterEffect4010ui_story == nil then
				arg_29_1.var_.characterEffect4010ui_story = var_32_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_10 = 0.200000002980232

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.characterEffect4010ui_story and not isNil(var_32_8) then
					arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.characterEffect4010ui_story then
				arg_29_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_32_12 = 0
			local var_32_13 = 0.8

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[42].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(414281007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 32
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_20 and arg_29_1.time_ < var_32_12 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play414281008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414281008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414281009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["102201ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos102201ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos102201ui_story, var_36_4, var_36_3)

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

			local var_36_9 = arg_33_1.actors_["102201ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect102201ui_story == nil then
				arg_33_1.var_.characterEffect102201ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect102201ui_story and not isNil(var_36_9) then
					local var_36_13 = Mathf.Lerp(0, 0.5, var_36_12)

					arg_33_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_33_1.var_.characterEffect102201ui_story.fillRatio = var_36_13
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect102201ui_story then
				local var_36_14 = 0.5

				arg_33_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_33_1.var_.characterEffect102201ui_story.fillRatio = var_36_14
			end

			local var_36_15 = arg_33_1.actors_["4010ui_story"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos4010ui_story = var_36_15.localPosition
			end

			local var_36_17 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Vector3.New(0, 100, 0)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos4010ui_story, var_36_19, var_36_18)

				local var_36_20 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_20.x, var_36_20.y, var_36_20.z)

				local var_36_21 = var_36_15.localEulerAngles

				var_36_21.z = 0
				var_36_21.x = 0
				var_36_15.localEulerAngles = var_36_21
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(0, 100, 0)

				local var_36_22 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_22.x, var_36_22.y, var_36_22.z)

				local var_36_23 = var_36_15.localEulerAngles

				var_36_23.z = 0
				var_36_23.x = 0
				var_36_15.localEulerAngles = var_36_23
			end

			local var_36_24 = arg_33_1.actors_["4010ui_story"]
			local var_36_25 = 0

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect4010ui_story == nil then
				arg_33_1.var_.characterEffect4010ui_story = var_36_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_26 = 0.200000002980232

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_26 and not isNil(var_36_24) then
				local var_36_27 = (arg_33_1.time_ - var_36_25) / var_36_26

				if arg_33_1.var_.characterEffect4010ui_story and not isNil(var_36_24) then
					local var_36_28 = Mathf.Lerp(0, 0.5, var_36_27)

					arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_28
				end
			end

			if arg_33_1.time_ >= var_36_25 + var_36_26 and arg_33_1.time_ < var_36_25 + var_36_26 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect4010ui_story then
				local var_36_29 = 0.5

				arg_33_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4010ui_story.fillRatio = var_36_29
			end

			local var_36_30 = 0
			local var_36_31 = 1.25

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_32 = arg_33_1:GetWordFromCfg(414281008)
				local var_36_33 = arg_33_1:FormatText(var_36_32.content)

				arg_33_1.text_.text = var_36_33

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_34 = 50
				local var_36_35 = utf8.len(var_36_33)
				local var_36_36 = var_36_34 <= 0 and var_36_31 or var_36_31 * (var_36_35 / var_36_34)

				if var_36_36 > 0 and var_36_31 < var_36_36 then
					arg_33_1.talkMaxDuration = var_36_36

					if var_36_36 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_36 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_33
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_37 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_37 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_37

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_37 and arg_33_1.time_ < var_36_30 + var_36_37 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play414281009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 414281009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play414281010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "3045ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "3045ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "3045ui_story"), arg_37_1.stage_.transform)

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

			local var_40_5 = arg_37_1.actors_["3045ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos3045ui_story = var_40_5.localPosition

				local var_40_7 = "3045ui_story"

				arg_37_1:ShowWeapon(arg_37_1.var_[var_40_7 .. "Animator"].transform, false)
			end

			local var_40_8 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_6) / var_40_8
				local var_40_10 = Vector3.New(0, -1.75, -4.8)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos3045ui_story, var_40_10, var_40_9)

				local var_40_11 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_11.x, var_40_11.y, var_40_11.z)

				local var_40_12 = var_40_5.localEulerAngles

				var_40_12.z = 0
				var_40_12.x = 0
				var_40_5.localEulerAngles = var_40_12
			end

			if arg_37_1.time_ >= var_40_6 + var_40_8 and arg_37_1.time_ < var_40_6 + var_40_8 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -1.75, -4.8)

				local var_40_13 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_13.x, var_40_13.y, var_40_13.z)

				local var_40_14 = var_40_5.localEulerAngles

				var_40_14.z = 0
				var_40_14.x = 0
				var_40_5.localEulerAngles = var_40_14
			end

			local var_40_15 = arg_37_1.actors_["3045ui_story"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect3045ui_story == nil then
				arg_37_1.var_.characterEffect3045ui_story = var_40_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_17 = 0.200000002980232

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.characterEffect3045ui_story and not isNil(var_40_15) then
					arg_37_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.characterEffect3045ui_story then
				arg_37_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_21 = 0
			local var_40_22 = 0.2

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_23 = arg_37_1:FormatText(StoryNameCfg[43].name)

				arg_37_1.leftNameTxt_.text = var_40_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(414281009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 8
				local var_40_27 = utf8.len(var_40_25)
				local var_40_28 = var_40_26 <= 0 and var_40_22 or var_40_22 * (var_40_27 / var_40_26)

				if var_40_28 > 0 and var_40_22 < var_40_28 then
					arg_37_1.talkMaxDuration = var_40_28

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_29 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_29 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_21) / var_40_29

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_21 + var_40_29 and arg_37_1.time_ < var_40_21 + var_40_29 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
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
	Play414281010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 414281010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play414281011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["3045ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect3045ui_story == nil then
				arg_41_1.var_.characterEffect3045ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect3045ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect3045ui_story.fillFlat = true
					arg_41_1.var_.characterEffect3045ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect3045ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect3045ui_story.fillFlat = true
				arg_41_1.var_.characterEffect3045ui_story.fillRatio = var_44_5
			end

			local var_44_6 = arg_41_1.actors_["4010ui_story"].transform
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.var_.moveOldPos4010ui_story = var_44_6.localPosition
			end

			local var_44_8 = 0.001

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8
				local var_44_10 = Vector3.New(0, -1.59, -5.2)

				var_44_6.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4010ui_story, var_44_10, var_44_9)

				local var_44_11 = manager.ui.mainCamera.transform.position - var_44_6.position

				var_44_6.forward = Vector3.New(var_44_11.x, var_44_11.y, var_44_11.z)

				local var_44_12 = var_44_6.localEulerAngles

				var_44_12.z = 0
				var_44_12.x = 0
				var_44_6.localEulerAngles = var_44_12
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 then
				var_44_6.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_44_13 = manager.ui.mainCamera.transform.position - var_44_6.position

				var_44_6.forward = Vector3.New(var_44_13.x, var_44_13.y, var_44_13.z)

				local var_44_14 = var_44_6.localEulerAngles

				var_44_14.z = 0
				var_44_14.x = 0
				var_44_6.localEulerAngles = var_44_14
			end

			local var_44_15 = arg_41_1.actors_["4010ui_story"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect4010ui_story == nil then
				arg_41_1.var_.characterEffect4010ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_17 = 0.200000002980232

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.characterEffect4010ui_story and not isNil(var_44_15) then
					arg_41_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect4010ui_story then
				arg_41_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_44_20 = 0

			if var_44_20 < arg_41_1.time_ and arg_41_1.time_ <= var_44_20 + arg_44_0 then
				arg_41_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_44_21 = arg_41_1.actors_["3045ui_story"].transform
			local var_44_22 = 0

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1.var_.moveOldPos3045ui_story = var_44_21.localPosition
			end

			local var_44_23 = 0.001

			if var_44_22 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_23 then
				local var_44_24 = (arg_41_1.time_ - var_44_22) / var_44_23
				local var_44_25 = Vector3.New(0, 100, 0)

				var_44_21.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos3045ui_story, var_44_25, var_44_24)

				local var_44_26 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_26.x, var_44_26.y, var_44_26.z)

				local var_44_27 = var_44_21.localEulerAngles

				var_44_27.z = 0
				var_44_27.x = 0
				var_44_21.localEulerAngles = var_44_27
			end

			if arg_41_1.time_ >= var_44_22 + var_44_23 and arg_41_1.time_ < var_44_22 + var_44_23 + arg_44_0 then
				var_44_21.localPosition = Vector3.New(0, 100, 0)

				local var_44_28 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_28.x, var_44_28.y, var_44_28.z)

				local var_44_29 = var_44_21.localEulerAngles

				var_44_29.z = 0
				var_44_29.x = 0
				var_44_21.localEulerAngles = var_44_29
			end

			local var_44_30 = 0
			local var_44_31 = 0.725

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[991].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(414281010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 29
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_38 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_38 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_38

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_38 and arg_41_1.time_ < var_44_30 + var_44_38 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play414281011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 414281011
		arg_45_1.duration_ = 5.87

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play414281012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_2 = 0.866666666666667
			local var_48_3 = 0.225

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_4 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_4:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_5 = arg_45_1:FormatText(StoryNameCfg[991].name)

				arg_45_1.leftNameTxt_.text = var_48_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(414281011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 9
				local var_48_9 = utf8.len(var_48_7)
				local var_48_10 = var_48_8 <= 0 and var_48_3 or var_48_3 * (var_48_9 / var_48_8)

				if var_48_10 > 0 and var_48_3 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10
					var_48_2 = var_48_2 + 0.3

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = var_48_2 + 0.3
			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_12 and arg_45_1.time_ < var_48_11 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play414281012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414281012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414281013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["4010ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect4010ui_story == nil then
				arg_51_1.var_.characterEffect4010ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect4010ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect4010ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_51_1.var_.characterEffect4010ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 0.625

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:GetWordFromCfg(414281012)
				local var_54_9 = arg_51_1:FormatText(var_54_8.content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 25
				local var_54_11 = utf8.len(var_54_9)
				local var_54_12 = var_54_10 <= 0 and var_54_7 or var_54_7 * (var_54_11 / var_54_10)

				if var_54_12 > 0 and var_54_7 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_13 and arg_51_1.time_ < var_54_6 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play414281013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414281013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414281014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.1

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(414281013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 4
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414281014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414281014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414281015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["4010ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect4010ui_story == nil then
				arg_59_1.var_.characterEffect4010ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect4010ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect4010ui_story then
				arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_62_4 = 0

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_62_6 = 0
			local var_62_7 = 0.15

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[991].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(414281014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 6
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play414281015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414281015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414281016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["4010ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect4010ui_story == nil then
				arg_63_1.var_.characterEffect4010ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect4010ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_63_1.var_.characterEffect4010ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect4010ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_63_1.var_.characterEffect4010ui_story.fillRatio = var_66_5
			end

			local var_66_6 = arg_63_1.actors_["4010ui_story"].transform
			local var_66_7 = 0

			if var_66_7 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.var_.moveOldPos4010ui_story = var_66_6.localPosition
			end

			local var_66_8 = 0.001

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_8 then
				local var_66_9 = (arg_63_1.time_ - var_66_7) / var_66_8
				local var_66_10 = Vector3.New(0, 100, 0)

				var_66_6.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos4010ui_story, var_66_10, var_66_9)

				local var_66_11 = manager.ui.mainCamera.transform.position - var_66_6.position

				var_66_6.forward = Vector3.New(var_66_11.x, var_66_11.y, var_66_11.z)

				local var_66_12 = var_66_6.localEulerAngles

				var_66_12.z = 0
				var_66_12.x = 0
				var_66_6.localEulerAngles = var_66_12
			end

			if arg_63_1.time_ >= var_66_7 + var_66_8 and arg_63_1.time_ < var_66_7 + var_66_8 + arg_66_0 then
				var_66_6.localPosition = Vector3.New(0, 100, 0)

				local var_66_13 = manager.ui.mainCamera.transform.position - var_66_6.position

				var_66_6.forward = Vector3.New(var_66_13.x, var_66_13.y, var_66_13.z)

				local var_66_14 = var_66_6.localEulerAngles

				var_66_14.z = 0
				var_66_14.x = 0
				var_66_6.localEulerAngles = var_66_14
			end

			local var_66_15 = 0
			local var_66_16 = 0.875

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_17 = arg_63_1:GetWordFromCfg(414281015)
				local var_66_18 = arg_63_1:FormatText(var_66_17.content)

				arg_63_1.text_.text = var_66_18

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_19 = 35
				local var_66_20 = utf8.len(var_66_18)
				local var_66_21 = var_66_19 <= 0 and var_66_16 or var_66_16 * (var_66_20 / var_66_19)

				if var_66_21 > 0 and var_66_16 < var_66_21 then
					arg_63_1.talkMaxDuration = var_66_21

					if var_66_21 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_21 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_18
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_22 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_22 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_22

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_22 and arg_63_1.time_ < var_66_15 + var_66_22 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play414281016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414281016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414281017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["4010ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect4010ui_story == nil then
				arg_67_1.var_.characterEffect4010ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect4010ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect4010ui_story then
				arg_67_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_70_4 = 0

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_6 = arg_67_1.actors_["4010ui_story"].transform
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.var_.moveOldPos4010ui_story = var_70_6.localPosition
			end

			local var_70_8 = 0.001

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8
				local var_70_10 = Vector3.New(0, -1.59, -5.2)

				var_70_6.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos4010ui_story, var_70_10, var_70_9)

				local var_70_11 = manager.ui.mainCamera.transform.position - var_70_6.position

				var_70_6.forward = Vector3.New(var_70_11.x, var_70_11.y, var_70_11.z)

				local var_70_12 = var_70_6.localEulerAngles

				var_70_12.z = 0
				var_70_12.x = 0
				var_70_6.localEulerAngles = var_70_12
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 then
				var_70_6.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_70_13 = manager.ui.mainCamera.transform.position - var_70_6.position

				var_70_6.forward = Vector3.New(var_70_13.x, var_70_13.y, var_70_13.z)

				local var_70_14 = var_70_6.localEulerAngles

				var_70_14.z = 0
				var_70_14.x = 0
				var_70_6.localEulerAngles = var_70_14
			end

			local var_70_15 = 0
			local var_70_16 = 1

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[42].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(414281016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 40
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_23 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_23 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_23

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_23 and arg_67_1.time_ < var_70_15 + var_70_23 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play414281017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 414281017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play414281018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["3045ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos3045ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(-0.7, -1.75, -4.8)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos3045ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(-0.7, -1.75, -4.8)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["3045ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect3045ui_story == nil then
				arg_71_1.var_.characterEffect3045ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect3045ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect3045ui_story then
				arg_71_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			local var_74_13 = arg_71_1.actors_["4010ui_story"].transform
			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.var_.moveOldPos4010ui_story = var_74_13.localPosition
			end

			local var_74_15 = 0.001

			if var_74_14 <= arg_71_1.time_ and arg_71_1.time_ < var_74_14 + var_74_15 then
				local var_74_16 = (arg_71_1.time_ - var_74_14) / var_74_15
				local var_74_17 = Vector3.New(0.7, -1.59, -5.2)

				var_74_13.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos4010ui_story, var_74_17, var_74_16)

				local var_74_18 = manager.ui.mainCamera.transform.position - var_74_13.position

				var_74_13.forward = Vector3.New(var_74_18.x, var_74_18.y, var_74_18.z)

				local var_74_19 = var_74_13.localEulerAngles

				var_74_19.z = 0
				var_74_19.x = 0
				var_74_13.localEulerAngles = var_74_19
			end

			if arg_71_1.time_ >= var_74_14 + var_74_15 and arg_71_1.time_ < var_74_14 + var_74_15 + arg_74_0 then
				var_74_13.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_74_20 = manager.ui.mainCamera.transform.position - var_74_13.position

				var_74_13.forward = Vector3.New(var_74_20.x, var_74_20.y, var_74_20.z)

				local var_74_21 = var_74_13.localEulerAngles

				var_74_21.z = 0
				var_74_21.x = 0
				var_74_13.localEulerAngles = var_74_21
			end

			local var_74_22 = arg_71_1.actors_["4010ui_story"]
			local var_74_23 = 0

			if var_74_23 < arg_71_1.time_ and arg_71_1.time_ <= var_74_23 + arg_74_0 and not isNil(var_74_22) and arg_71_1.var_.characterEffect4010ui_story == nil then
				arg_71_1.var_.characterEffect4010ui_story = var_74_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_24 = 0.200000002980232

			if var_74_23 <= arg_71_1.time_ and arg_71_1.time_ < var_74_23 + var_74_24 and not isNil(var_74_22) then
				local var_74_25 = (arg_71_1.time_ - var_74_23) / var_74_24

				if arg_71_1.var_.characterEffect4010ui_story and not isNil(var_74_22) then
					local var_74_26 = Mathf.Lerp(0, 0.5, var_74_25)

					arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_71_1.var_.characterEffect4010ui_story.fillRatio = var_74_26
				end
			end

			if arg_71_1.time_ >= var_74_23 + var_74_24 and arg_71_1.time_ < var_74_23 + var_74_24 + arg_74_0 and not isNil(var_74_22) and arg_71_1.var_.characterEffect4010ui_story then
				local var_74_27 = 0.5

				arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_71_1.var_.characterEffect4010ui_story.fillRatio = var_74_27
			end

			local var_74_28 = 0

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_2")
			end

			local var_74_29 = 0

			if var_74_29 < arg_71_1.time_ and arg_71_1.time_ <= var_74_29 + arg_74_0 then
				arg_71_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_30 = 0
			local var_74_31 = 0.425

			if var_74_30 < arg_71_1.time_ and arg_71_1.time_ <= var_74_30 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_32 = arg_71_1:FormatText(StoryNameCfg[43].name)

				arg_71_1.leftNameTxt_.text = var_74_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_33 = arg_71_1:GetWordFromCfg(414281017)
				local var_74_34 = arg_71_1:FormatText(var_74_33.content)

				arg_71_1.text_.text = var_74_34

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_35 = 17
				local var_74_36 = utf8.len(var_74_34)
				local var_74_37 = var_74_35 <= 0 and var_74_31 or var_74_31 * (var_74_36 / var_74_35)

				if var_74_37 > 0 and var_74_31 < var_74_37 then
					arg_71_1.talkMaxDuration = var_74_37

					if var_74_37 + var_74_30 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_37 + var_74_30
					end
				end

				arg_71_1.text_.text = var_74_34
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_38 = math.max(var_74_31, arg_71_1.talkMaxDuration)

			if var_74_30 <= arg_71_1.time_ and arg_71_1.time_ < var_74_30 + var_74_38 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_30) / var_74_38

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_30 + var_74_38 and arg_71_1.time_ < var_74_30 + var_74_38 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play414281018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 414281018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play414281019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["3045ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect3045ui_story == nil then
				arg_75_1.var_.characterEffect3045ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect3045ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect3045ui_story.fillFlat = true
					arg_75_1.var_.characterEffect3045ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect3045ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect3045ui_story.fillFlat = true
				arg_75_1.var_.characterEffect3045ui_story.fillRatio = var_78_5
			end

			local var_78_6 = arg_75_1.actors_["4010ui_story"]
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect4010ui_story == nil then
				arg_75_1.var_.characterEffect4010ui_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_8 = 0.200000002980232

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 and not isNil(var_78_6) then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8

				if arg_75_1.var_.characterEffect4010ui_story and not isNil(var_78_6) then
					arg_75_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect4010ui_story then
				arg_75_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_78_10 = 0
			local var_78_11 = 0.225

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_12 = arg_75_1:FormatText(StoryNameCfg[42].name)

				arg_75_1.leftNameTxt_.text = var_78_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(414281018)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 9
				local var_78_16 = utf8.len(var_78_14)
				local var_78_17 = var_78_15 <= 0 and var_78_11 or var_78_11 * (var_78_16 / var_78_15)

				if var_78_17 > 0 and var_78_11 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_10 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_10
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_18 = math.max(var_78_11, arg_75_1.talkMaxDuration)

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_18 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_10) / var_78_18

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_10 + var_78_18 and arg_75_1.time_ < var_78_10 + var_78_18 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play414281019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 414281019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play414281020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["3045ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect3045ui_story == nil then
				arg_79_1.var_.characterEffect3045ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect3045ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect3045ui_story then
				arg_79_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["4010ui_story"]
			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect4010ui_story == nil then
				arg_79_1.var_.characterEffect4010ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_6 and not isNil(var_82_4) then
				local var_82_7 = (arg_79_1.time_ - var_82_5) / var_82_6

				if arg_79_1.var_.characterEffect4010ui_story and not isNil(var_82_4) then
					local var_82_8 = Mathf.Lerp(0, 0.5, var_82_7)

					arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_79_1.var_.characterEffect4010ui_story.fillRatio = var_82_8
				end
			end

			if arg_79_1.time_ >= var_82_5 + var_82_6 and arg_79_1.time_ < var_82_5 + var_82_6 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect4010ui_story then
				local var_82_9 = 0.5

				arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_79_1.var_.characterEffect4010ui_story.fillRatio = var_82_9
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_82_11 = 0
			local var_82_12 = 0.3

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_13 = arg_79_1:FormatText(StoryNameCfg[43].name)

				arg_79_1.leftNameTxt_.text = var_82_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_14 = arg_79_1:GetWordFromCfg(414281019)
				local var_82_15 = arg_79_1:FormatText(var_82_14.content)

				arg_79_1.text_.text = var_82_15

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_16 = 12
				local var_82_17 = utf8.len(var_82_15)
				local var_82_18 = var_82_16 <= 0 and var_82_12 or var_82_12 * (var_82_17 / var_82_16)

				if var_82_18 > 0 and var_82_12 < var_82_18 then
					arg_79_1.talkMaxDuration = var_82_18

					if var_82_18 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_18 + var_82_11
					end
				end

				arg_79_1.text_.text = var_82_15
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_19 = math.max(var_82_12, arg_79_1.talkMaxDuration)

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_19 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_11) / var_82_19

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_11 + var_82_19 and arg_79_1.time_ < var_82_11 + var_82_19 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play414281020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 414281020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play414281021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["3045ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos3045ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos3045ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["4010ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect4010ui_story == nil then
				arg_83_1.var_.characterEffect4010ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect4010ui_story and not isNil(var_86_9) then
					local var_86_13 = Mathf.Lerp(0, 0.5, var_86_12)

					arg_83_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_83_1.var_.characterEffect4010ui_story.fillRatio = var_86_13
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect4010ui_story then
				local var_86_14 = 0.5

				arg_83_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_83_1.var_.characterEffect4010ui_story.fillRatio = var_86_14
			end

			local var_86_15 = arg_83_1.actors_["4010ui_story"]
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.characterEffect4010ui_story == nil then
				arg_83_1.var_.characterEffect4010ui_story = var_86_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_17 = 0.200000002980232

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 and not isNil(var_86_15) then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17

				if arg_83_1.var_.characterEffect4010ui_story and not isNil(var_86_15) then
					local var_86_19 = Mathf.Lerp(0, 0.5, var_86_18)

					arg_83_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_83_1.var_.characterEffect4010ui_story.fillRatio = var_86_19
				end
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.characterEffect4010ui_story then
				local var_86_20 = 0.5

				arg_83_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_83_1.var_.characterEffect4010ui_story.fillRatio = var_86_20
			end

			local var_86_21 = arg_83_1.actors_["4010ui_story"].transform
			local var_86_22 = 0

			if var_86_22 < arg_83_1.time_ and arg_83_1.time_ <= var_86_22 + arg_86_0 then
				arg_83_1.var_.moveOldPos4010ui_story = var_86_21.localPosition
			end

			local var_86_23 = 0.001

			if var_86_22 <= arg_83_1.time_ and arg_83_1.time_ < var_86_22 + var_86_23 then
				local var_86_24 = (arg_83_1.time_ - var_86_22) / var_86_23
				local var_86_25 = Vector3.New(0, 100, 0)

				var_86_21.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos4010ui_story, var_86_25, var_86_24)

				local var_86_26 = manager.ui.mainCamera.transform.position - var_86_21.position

				var_86_21.forward = Vector3.New(var_86_26.x, var_86_26.y, var_86_26.z)

				local var_86_27 = var_86_21.localEulerAngles

				var_86_27.z = 0
				var_86_27.x = 0
				var_86_21.localEulerAngles = var_86_27
			end

			if arg_83_1.time_ >= var_86_22 + var_86_23 and arg_83_1.time_ < var_86_22 + var_86_23 + arg_86_0 then
				var_86_21.localPosition = Vector3.New(0, 100, 0)

				local var_86_28 = manager.ui.mainCamera.transform.position - var_86_21.position

				var_86_21.forward = Vector3.New(var_86_28.x, var_86_28.y, var_86_28.z)

				local var_86_29 = var_86_21.localEulerAngles

				var_86_29.z = 0
				var_86_29.x = 0
				var_86_21.localEulerAngles = var_86_29
			end

			local var_86_30 = 0
			local var_86_31 = 0.575

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_32 = arg_83_1:GetWordFromCfg(414281020)
				local var_86_33 = arg_83_1:FormatText(var_86_32.content)

				arg_83_1.text_.text = var_86_33

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_34 = 23
				local var_86_35 = utf8.len(var_86_33)
				local var_86_36 = var_86_34 <= 0 and var_86_31 or var_86_31 * (var_86_35 / var_86_34)

				if var_86_36 > 0 and var_86_31 < var_86_36 then
					arg_83_1.talkMaxDuration = var_86_36

					if var_86_36 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_36 + var_86_30
					end
				end

				arg_83_1.text_.text = var_86_33
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_37 = math.max(var_86_31, arg_83_1.talkMaxDuration)

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_37 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_30) / var_86_37

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_30 + var_86_37 and arg_83_1.time_ < var_86_30 + var_86_37 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play414281021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 414281021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play414281022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.725

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(414281021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 29
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play414281022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 414281022
		arg_91_1.duration_ = 5.43

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
			arg_91_1.auto_ = false
		end

		function arg_91_1.playNext_(arg_93_0)
			arg_91_1.onStoryFinished_()
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["102201ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos102201ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -1.08, -6)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos102201ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["102201ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect102201ui_story == nil then
				arg_91_1.var_.characterEffect102201ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect102201ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect102201ui_story then
				arg_91_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_15 = 0.433333333333333
			local var_94_16 = 0.05

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_17 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_17:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_18 = arg_91_1:FormatText(StoryNameCfg[259].name)

				arg_91_1.leftNameTxt_.text = var_94_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(414281022)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 2
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_16 or var_94_16 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_16 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23
					var_94_15 = var_94_15 + 0.3

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = var_94_15 + 0.3
			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_24 <= arg_91_1.time_ and arg_91_1.time_ < var_94_24 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_24) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_24 + var_94_25 and arg_91_1.time_ < var_94_24 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07f"
	},
	voices = {}
}
