return {
	Play414223001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414223001
		arg_1_1.duration_ = 7.07

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414223002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H07j"

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
				local var_4_5 = arg_1_1.bgs_.H07j

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
					if iter_4_0 ~= "H07j" then
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

			local var_4_22 = "10089ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10089ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10089ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["10089ui_story"].transform
			local var_4_28 = 1.86666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10089ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.12, -5.99)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10089ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10089ui_story"]
			local var_4_37 = 1.86666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10089ui_story == nil then
				arg_1_1.var_.characterEffect10089ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10089ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10089ui_story then
				arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_4_40 = 1.86666666666667

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_41 = 0
			local var_4_42 = 0.266666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0.366666666666667
			local var_4_48 = 0.833333333333333

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 1.86666666666667

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 2.0666666696469
			local var_4_55 = 0.35

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[988].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(414223001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 14
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_54 + 0.3
			local var_4_64 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play414223002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414223002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414223003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10089ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10089ui_story == nil then
				arg_9_1.var_.characterEffect10089ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect10089ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10089ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10089ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10089ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.375

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[980].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(414223002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 15
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play414223003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414223003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414223004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10089ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10089ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -1.12, -5.99)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10089ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["10089ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10089ui_story == nil then
				arg_13_1.var_.characterEffect10089ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect10089ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10089ui_story then
				arg_13_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_16_13 = 0
			local var_16_14 = 0.5

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_15 = arg_13_1:FormatText(StoryNameCfg[988].name)

				arg_13_1.leftNameTxt_.text = var_16_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_16 = arg_13_1:GetWordFromCfg(414223003)
				local var_16_17 = arg_13_1:FormatText(var_16_16.content)

				arg_13_1.text_.text = var_16_17

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_18 = 20
				local var_16_19 = utf8.len(var_16_17)
				local var_16_20 = var_16_18 <= 0 and var_16_14 or var_16_14 * (var_16_19 / var_16_18)

				if var_16_20 > 0 and var_16_14 < var_16_20 then
					arg_13_1.talkMaxDuration = var_16_20

					if var_16_20 + var_16_13 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_13
					end
				end

				arg_13_1.text_.text = var_16_17
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = math.max(var_16_14, arg_13_1.talkMaxDuration)

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_13) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_13 + var_16_21 and arg_13_1.time_ < var_16_13 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414223004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414223005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10089ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10089ui_story == nil then
				arg_17_1.var_.characterEffect10089ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10089ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10089ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10089ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10089ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.275

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[36].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(414223004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 11
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
	Play414223005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414223005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414223006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10089ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10089ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.12, -5.99)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10089ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["10089ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10089ui_story == nil then
				arg_21_1.var_.characterEffect10089ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect10089ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect10089ui_story then
				arg_21_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_2")
			end

			local var_24_15 = 0
			local var_24_16 = 0.225

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[988].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(414223005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 9
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_23 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_23 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_23

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_23 and arg_21_1.time_ < var_24_15 + var_24_23 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414223006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414223007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10089ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10089ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10089ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["10089ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10089ui_story == nil then
				arg_25_1.var_.characterEffect10089ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect10089ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10089ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect10089ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10089ui_story.fillRatio = var_28_14
			end

			local var_28_15 = "102201ui_story"

			if arg_25_1.actors_[var_28_15] == nil then
				local var_28_16 = Asset.Load("Char/" .. "102201ui_story")

				if not isNil(var_28_16) then
					local var_28_17 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_25_1.stage_.transform)

					var_28_17.name = var_28_15
					var_28_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_15] = var_28_17

					local var_28_18 = var_28_17:GetComponentInChildren(typeof(CharacterEffect))

					var_28_18.enabled = true

					local var_28_19 = GameObjectTools.GetOrAddComponent(var_28_17, typeof(DynamicBoneHelper))

					if var_28_19 then
						var_28_19:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_18.transform, false)

					arg_25_1.var_[var_28_15 .. "Animator"] = var_28_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_15 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_15 .. "LipSync"] = var_28_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_20 = arg_25_1.actors_["102201ui_story"].transform
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.var_.moveOldPos102201ui_story = var_28_20.localPosition

				local var_28_22 = "102201ui_story"

				arg_25_1:ShowWeapon(arg_25_1.var_[var_28_22 .. "Animator"].transform, false)
			end

			local var_28_23 = 0.001

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_23 then
				local var_28_24 = (arg_25_1.time_ - var_28_21) / var_28_23
				local var_28_25 = Vector3.New(0, -1.08, -6)

				var_28_20.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos102201ui_story, var_28_25, var_28_24)

				local var_28_26 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_26.x, var_28_26.y, var_28_26.z)

				local var_28_27 = var_28_20.localEulerAngles

				var_28_27.z = 0
				var_28_27.x = 0
				var_28_20.localEulerAngles = var_28_27
			end

			if arg_25_1.time_ >= var_28_21 + var_28_23 and arg_25_1.time_ < var_28_21 + var_28_23 + arg_28_0 then
				var_28_20.localPosition = Vector3.New(0, -1.08, -6)

				local var_28_28 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_28.x, var_28_28.y, var_28_28.z)

				local var_28_29 = var_28_20.localEulerAngles

				var_28_29.z = 0
				var_28_29.x = 0
				var_28_20.localEulerAngles = var_28_29
			end

			local var_28_30 = arg_25_1.actors_["102201ui_story"]
			local var_28_31 = 0

			if var_28_31 < arg_25_1.time_ and arg_25_1.time_ <= var_28_31 + arg_28_0 and not isNil(var_28_30) and arg_25_1.var_.characterEffect102201ui_story == nil then
				arg_25_1.var_.characterEffect102201ui_story = var_28_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_32 = 0.200000002980232

			if var_28_31 <= arg_25_1.time_ and arg_25_1.time_ < var_28_31 + var_28_32 and not isNil(var_28_30) then
				local var_28_33 = (arg_25_1.time_ - var_28_31) / var_28_32

				if arg_25_1.var_.characterEffect102201ui_story and not isNil(var_28_30) then
					arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_31 + var_28_32 and arg_25_1.time_ < var_28_31 + var_28_32 + arg_28_0 and not isNil(var_28_30) and arg_25_1.var_.characterEffect102201ui_story then
				arg_25_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_28_34 = 0

			if var_28_34 < arg_25_1.time_ and arg_25_1.time_ <= var_28_34 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_28_35 = 0

			if var_28_35 < arg_25_1.time_ and arg_25_1.time_ <= var_28_35 + arg_28_0 then
				arg_25_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			local var_28_36 = 0
			local var_28_37 = 0.325

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

				local var_28_39 = arg_25_1:GetWordFromCfg(414223006)
				local var_28_40 = arg_25_1:FormatText(var_28_39.content)

				arg_25_1.text_.text = var_28_40

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_41 = 13
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
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_25_1:InitPlayNodeList()
	end,
	Play414223007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414223007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414223008(arg_29_1)
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
			local var_32_7 = 1.1

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(414223007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 44
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_7 or var_32_7 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_7 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_13 and arg_29_1.time_ < var_32_6 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play414223008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414223008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414223009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10089ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10089ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -1.12, -5.99)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10089ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10089ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10089ui_story == nil then
				arg_33_1.var_.characterEffect10089ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10089ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10089ui_story then
				arg_33_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_14 = arg_33_1.actors_["102201ui_story"].transform
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.var_.moveOldPos102201ui_story = var_36_14.localPosition
			end

			local var_36_16 = 0.001

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16
				local var_36_18 = Vector3.New(0, 100, 0)

				var_36_14.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos102201ui_story, var_36_18, var_36_17)

				local var_36_19 = manager.ui.mainCamera.transform.position - var_36_14.position

				var_36_14.forward = Vector3.New(var_36_19.x, var_36_19.y, var_36_19.z)

				local var_36_20 = var_36_14.localEulerAngles

				var_36_20.z = 0
				var_36_20.x = 0
				var_36_14.localEulerAngles = var_36_20
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 then
				var_36_14.localPosition = Vector3.New(0, 100, 0)

				local var_36_21 = manager.ui.mainCamera.transform.position - var_36_14.position

				var_36_14.forward = Vector3.New(var_36_21.x, var_36_21.y, var_36_21.z)

				local var_36_22 = var_36_14.localEulerAngles

				var_36_22.z = 0
				var_36_22.x = 0
				var_36_14.localEulerAngles = var_36_22
			end

			local var_36_23 = arg_33_1.actors_["102201ui_story"]
			local var_36_24 = 0

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 and not isNil(var_36_23) and arg_33_1.var_.characterEffect102201ui_story == nil then
				arg_33_1.var_.characterEffect102201ui_story = var_36_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_25 = 0.200000002980232

			if var_36_24 <= arg_33_1.time_ and arg_33_1.time_ < var_36_24 + var_36_25 and not isNil(var_36_23) then
				local var_36_26 = (arg_33_1.time_ - var_36_24) / var_36_25

				if arg_33_1.var_.characterEffect102201ui_story and not isNil(var_36_23) then
					local var_36_27 = Mathf.Lerp(0, 0.5, var_36_26)

					arg_33_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_33_1.var_.characterEffect102201ui_story.fillRatio = var_36_27
				end
			end

			if arg_33_1.time_ >= var_36_24 + var_36_25 and arg_33_1.time_ < var_36_24 + var_36_25 + arg_36_0 and not isNil(var_36_23) and arg_33_1.var_.characterEffect102201ui_story then
				local var_36_28 = 0.5

				arg_33_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_33_1.var_.characterEffect102201ui_story.fillRatio = var_36_28
			end

			local var_36_29 = 0

			if var_36_29 < arg_33_1.time_ and arg_33_1.time_ <= var_36_29 + arg_36_0 then
				arg_33_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_1")
			end

			local var_36_30 = 0
			local var_36_31 = 0.55

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[988].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(414223008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 22
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_38 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_38 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_38

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_38 and arg_33_1.time_ < var_36_30 + var_36_38 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_33_1:InitPlayNodeList()
	end,
	Play414223009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 414223009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play414223010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10089ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10089ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10089ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["10089ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10089ui_story == nil then
				arg_37_1.var_.characterEffect10089ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect10089ui_story and not isNil(var_40_9) then
					local var_40_13 = Mathf.Lerp(0, 0.5, var_40_12)

					arg_37_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10089ui_story.fillRatio = var_40_13
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10089ui_story then
				local var_40_14 = 0.5

				arg_37_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10089ui_story.fillRatio = var_40_14
			end

			local var_40_15 = 0
			local var_40_16 = 0.9

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_17 = arg_37_1:GetWordFromCfg(414223009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 36
				local var_40_20 = utf8.len(var_40_18)
				local var_40_21 = var_40_19 <= 0 and var_40_16 or var_40_16 * (var_40_20 / var_40_19)

				if var_40_21 > 0 and var_40_16 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21

					if var_40_21 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_22 and arg_37_1.time_ < var_40_15 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 414223010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play414223011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.3

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[990].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(414223010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 12
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play414223011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 414223011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play414223012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.325

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[980].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(414223011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 13
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play414223012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 414223012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play414223013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10089ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10089ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1.12, -5.99)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10089ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10089ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10089ui_story == nil then
				arg_49_1.var_.characterEffect10089ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10089ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10089ui_story then
				arg_49_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_2")
			end

			local var_52_15 = 0
			local var_52_16 = 0.35

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[988].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(414223012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 14
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_23 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_23 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_23

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_23 and arg_49_1.time_ < var_52_15 + var_52_23 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 414223013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play414223014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["102201ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos102201ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0.7, -1.08, -6)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos102201ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["102201ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect102201ui_story == nil then
				arg_53_1.var_.characterEffect102201ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect102201ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect102201ui_story then
				arg_53_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_56_15 = arg_53_1.actors_["10089ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos10089ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(-0.7, -1.12, -5.99)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10089ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["10089ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10089ui_story == nil then
				arg_53_1.var_.characterEffect10089ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect10089ui_story and not isNil(var_56_24) then
					local var_56_28 = Mathf.Lerp(0, 0.5, var_56_27)

					arg_53_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10089ui_story.fillRatio = var_56_28
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect10089ui_story then
				local var_56_29 = 0.5

				arg_53_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10089ui_story.fillRatio = var_56_29
			end

			local var_56_30 = 0
			local var_56_31 = 0.55

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_32 = arg_53_1:FormatText(StoryNameCfg[259].name)

				arg_53_1.leftNameTxt_.text = var_56_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_33 = arg_53_1:GetWordFromCfg(414223013)
				local var_56_34 = arg_53_1:FormatText(var_56_33.content)

				arg_53_1.text_.text = var_56_34

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_35 = 22
				local var_56_36 = utf8.len(var_56_34)
				local var_56_37 = var_56_35 <= 0 and var_56_31 or var_56_31 * (var_56_36 / var_56_35)

				if var_56_37 > 0 and var_56_31 < var_56_37 then
					arg_53_1.talkMaxDuration = var_56_37

					if var_56_37 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_37 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_34
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_38 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_38 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_38

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_38 and arg_53_1.time_ < var_56_30 + var_56_38 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "10089ui_story",
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
	Play414223014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 414223014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play414223015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["102201ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect102201ui_story == nil then
				arg_57_1.var_.characterEffect102201ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect102201ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_57_1.var_.characterEffect102201ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect102201ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_57_1.var_.characterEffect102201ui_story.fillRatio = var_60_5
			end

			local var_60_6 = arg_57_1.actors_["10089ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10089ui_story == nil then
				arg_57_1.var_.characterEffect10089ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect10089ui_story and not isNil(var_60_6) then
					arg_57_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect10089ui_story then
				arg_57_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_60_10 = arg_57_1.actors_["10089ui_story"].transform
			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.var_.moveOldPos10089ui_story = var_60_10.localPosition
			end

			local var_60_12 = 0.001

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_11) / var_60_12
				local var_60_14 = Vector3.New(-0.7, -1.12, -5.99)

				var_60_10.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10089ui_story, var_60_14, var_60_13)

				local var_60_15 = manager.ui.mainCamera.transform.position - var_60_10.position

				var_60_10.forward = Vector3.New(var_60_15.x, var_60_15.y, var_60_15.z)

				local var_60_16 = var_60_10.localEulerAngles

				var_60_16.z = 0
				var_60_16.x = 0
				var_60_10.localEulerAngles = var_60_16
			end

			if arg_57_1.time_ >= var_60_11 + var_60_12 and arg_57_1.time_ < var_60_11 + var_60_12 + arg_60_0 then
				var_60_10.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_60_17 = manager.ui.mainCamera.transform.position - var_60_10.position

				var_60_10.forward = Vector3.New(var_60_17.x, var_60_17.y, var_60_17.z)

				local var_60_18 = var_60_10.localEulerAngles

				var_60_18.z = 0
				var_60_18.x = 0
				var_60_10.localEulerAngles = var_60_18
			end

			local var_60_19 = 0
			local var_60_20 = 0.225

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_21 = arg_57_1:FormatText(StoryNameCfg[988].name)

				arg_57_1.leftNameTxt_.text = var_60_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_22 = arg_57_1:GetWordFromCfg(414223014)
				local var_60_23 = arg_57_1:FormatText(var_60_22.content)

				arg_57_1.text_.text = var_60_23

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_24 = 9
				local var_60_25 = utf8.len(var_60_23)
				local var_60_26 = var_60_24 <= 0 and var_60_20 or var_60_20 * (var_60_25 / var_60_24)

				if var_60_26 > 0 and var_60_20 < var_60_26 then
					arg_57_1.talkMaxDuration = var_60_26

					if var_60_26 + var_60_19 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_26 + var_60_19
					end
				end

				arg_57_1.text_.text = var_60_23
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = math.max(var_60_20, arg_57_1.talkMaxDuration)

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_27 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_19) / var_60_27

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_19 + var_60_27 and arg_57_1.time_ < var_60_19 + var_60_27 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 414223015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play414223016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10089ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10089ui_story == nil then
				arg_61_1.var_.characterEffect10089ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10089ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10089ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10089ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10089ui_story.fillRatio = var_64_5
			end

			local var_64_6 = arg_61_1.actors_["102201ui_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect102201ui_story == nil then
				arg_61_1.var_.characterEffect102201ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect102201ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect102201ui_story then
				arg_61_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_64_10 = 0
			local var_64_11 = 0.2

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_12 = arg_61_1:FormatText(StoryNameCfg[259].name)

				arg_61_1.leftNameTxt_.text = var_64_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(414223015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 8
				local var_64_16 = utf8.len(var_64_14)
				local var_64_17 = var_64_15 <= 0 and var_64_11 or var_64_11 * (var_64_16 / var_64_15)

				if var_64_17 > 0 and var_64_11 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_10
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_11, arg_61_1.talkMaxDuration)

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_10) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_10 + var_64_18 and arg_61_1.time_ < var_64_10 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play414223016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 414223016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play414223017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["102201ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect102201ui_story == nil then
				arg_65_1.var_.characterEffect102201ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect102201ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_65_1.var_.characterEffect102201ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect102201ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_65_1.var_.characterEffect102201ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				local var_68_8 = "play"
				local var_68_9 = "effect"

				arg_65_1:AudioAction(var_68_8, var_68_9, "se_story_133", "se_story_133_win", "")
			end

			local var_68_10 = 0
			local var_68_11 = 0.475

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_12 = arg_65_1:FormatText(StoryNameCfg[672].name)

				arg_65_1.leftNameTxt_.text = var_68_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_13 = arg_65_1:GetWordFromCfg(414223016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 19
				local var_68_16 = utf8.len(var_68_14)
				local var_68_17 = var_68_15 <= 0 and var_68_11 or var_68_11 * (var_68_16 / var_68_15)

				if var_68_17 > 0 and var_68_11 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_18 and arg_65_1.time_ < var_68_10 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play414223017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 414223017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play414223018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10089ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10089ui_story == nil then
				arg_69_1.var_.characterEffect10089ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10089ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10089ui_story then
				arg_69_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_1")
			end

			local var_72_5 = 0
			local var_72_6 = 0.5

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_7 = arg_69_1:FormatText(StoryNameCfg[988].name)

				arg_69_1.leftNameTxt_.text = var_72_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(414223017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 20
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_6 or var_72_6 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_6 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play414223018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 414223018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play414223019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10089ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10089ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10089ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_10 = 0
			local var_76_11 = 0.775

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_12 = arg_73_1:FormatText(StoryNameCfg[988].name)

				arg_73_1.leftNameTxt_.text = var_76_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(414223018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_15 = 31
				local var_76_16 = utf8.len(var_76_14)
				local var_76_17 = var_76_15 <= 0 and var_76_11 or var_76_11 * (var_76_16 / var_76_15)

				if var_76_17 > 0 and var_76_11 < var_76_17 then
					arg_73_1.talkMaxDuration = var_76_17

					if var_76_17 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_18 and arg_73_1.time_ < var_76_10 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414223019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 414223019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play414223020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["102201ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos102201ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0.7, -1.08, -6)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos102201ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["102201ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect102201ui_story == nil then
				arg_77_1.var_.characterEffect102201ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect102201ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect102201ui_story then
				arg_77_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_80_14 = arg_77_1.actors_["10089ui_story"]
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect10089ui_story == nil then
				arg_77_1.var_.characterEffect10089ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_16 = 0.200000002980232

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.characterEffect10089ui_story and not isNil(var_80_14) then
					local var_80_18 = Mathf.Lerp(0, 0.5, var_80_17)

					arg_77_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10089ui_story.fillRatio = var_80_18
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect10089ui_story then
				local var_80_19 = 0.5

				arg_77_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10089ui_story.fillRatio = var_80_19
			end

			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_80_21 = 0
			local var_80_22 = 0.1

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_23 = arg_77_1:FormatText(StoryNameCfg[259].name)

				arg_77_1.leftNameTxt_.text = var_80_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(414223019)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 4
				local var_80_27 = utf8.len(var_80_25)
				local var_80_28 = var_80_26 <= 0 and var_80_22 or var_80_22 * (var_80_27 / var_80_26)

				if var_80_28 > 0 and var_80_22 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28

					if var_80_28 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_21
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_29 = math.max(var_80_22, arg_77_1.talkMaxDuration)

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_29 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_21) / var_80_29

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_21 + var_80_29 and arg_77_1.time_ < var_80_21 + var_80_29 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play414223020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 414223020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play414223021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10089ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10089ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(-0.7, -1.12, -5.99)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10089ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-0.7, -1.12, -5.99)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["10089ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10089ui_story == nil then
				arg_81_1.var_.characterEffect10089ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10089ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10089ui_story then
				arg_81_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_14 = arg_81_1.actors_["102201ui_story"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect102201ui_story == nil then
				arg_81_1.var_.characterEffect102201ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_16 = 0.200000002980232

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.characterEffect102201ui_story and not isNil(var_84_14) then
					local var_84_18 = Mathf.Lerp(0, 0.5, var_84_17)

					arg_81_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_81_1.var_.characterEffect102201ui_story.fillRatio = var_84_18
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect102201ui_story then
				local var_84_19 = 0.5

				arg_81_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_81_1.var_.characterEffect102201ui_story.fillRatio = var_84_19
			end

			local var_84_20 = 0

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action438")
			end

			local var_84_21 = 0
			local var_84_22 = 0.8

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[988].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(414223020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 32
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_29 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_29 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_29

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_29 and arg_81_1.time_ < var_84_21 + var_84_29 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play414223021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 414223021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play414223022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10089ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10089ui_story == nil then
				arg_85_1.var_.characterEffect10089ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10089ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10089ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10089ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10089ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.275

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[981].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(414223021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 11
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play414223022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 414223022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10089ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10089ui_story == nil then
				arg_89_1.var_.characterEffect10089ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10089ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10089ui_story then
				arg_89_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.675

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_6 = arg_89_1:FormatText(StoryNameCfg[988].name)

				arg_89_1.leftNameTxt_.text = var_92_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(414223022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 27
				local var_92_10 = utf8.len(var_92_8)
				local var_92_11 = var_92_9 <= 0 and var_92_5 or var_92_5 * (var_92_10 / var_92_9)

				if var_92_11 > 0 and var_92_5 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07j"
	},
	voices = {}
}
