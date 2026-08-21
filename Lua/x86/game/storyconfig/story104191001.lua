return {
	Play419101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 419101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play419101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST02"

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
				local var_4_5 = arg_1_1.bgs_.ST02

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
					if iter_4_0 ~= "ST02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = "1045ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1045ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1045ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1045ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1045ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1, -6.05)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1045ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1, -6.05)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1045ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1045ui_story == nil then
				arg_1_1.var_.characterEffect1045ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1045ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1045ui_story then
				arg_1_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action2_2")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0
			local var_4_45 = 0.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0.4
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_2_story_daily", "bgm_activity_4_2_story_daily", "bgm_activity_4_2_story_daily.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_2_story_daily", "bgm_activity_4_2_story_daily")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 0.2
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 1.999999999999
			local var_4_61 = 0.725

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[1202].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(419101001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 29
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_60 + 0.3
			local var_4_70 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play419101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 419101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play419101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1045ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1045ui_story == nil then
				arg_9_1.var_.characterEffect1045ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1045ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1045ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1045ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1045ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 1.05

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(419101002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 42
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
	Play419101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 419101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play419101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1045ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1045ui_story == nil then
				arg_13_1.var_.characterEffect1045ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1045ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1045ui_story then
				arg_13_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_16_4 = 0
			local var_16_5 = 0.425

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_6 = arg_13_1:FormatText(StoryNameCfg[1202].name)

				arg_13_1.leftNameTxt_.text = var_16_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(419101003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 17
				local var_16_10 = utf8.len(var_16_8)
				local var_16_11 = var_16_9 <= 0 and var_16_5 or var_16_5 * (var_16_10 / var_16_9)

				if var_16_11 > 0 and var_16_5 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play419101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 419101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play419101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1045ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1045ui_story == nil then
				arg_17_1.var_.characterEffect1045ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1045ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1045ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1045ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1045ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.925

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

				local var_20_9 = arg_17_1:GetWordFromCfg(419101004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 37
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
	Play419101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 419101005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play419101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10102ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["10102ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos10102ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.985, -6.275)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10102ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1045ui_story"].transform
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.var_.moveOldPos1045ui_story = var_24_14.localPosition
			end

			local var_24_16 = 0.001

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16
				local var_24_18 = Vector3.New(-0.7, -1, -6.05)

				var_24_14.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1045ui_story, var_24_18, var_24_17)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_14.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_14.localEulerAngles = var_24_20
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 then
				var_24_14.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_24_21 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_21.x, var_24_21.y, var_24_21.z)

				local var_24_22 = var_24_14.localEulerAngles

				var_24_22.z = 0
				var_24_22.x = 0
				var_24_14.localEulerAngles = var_24_22
			end

			local var_24_23 = arg_21_1.actors_["10102ui_story"]
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect10102ui_story == nil then
				arg_21_1.var_.characterEffect10102ui_story = var_24_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.200000002980232

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 and not isNil(var_24_23) then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25

				if arg_21_1.var_.characterEffect10102ui_story and not isNil(var_24_23) then
					arg_21_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect10102ui_story then
				arg_21_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_24_29 = 0
			local var_24_30 = 0.575

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_31 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(419101005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 23
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_30 or var_24_30 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_30 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_29
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_37 = math.max(var_24_30, arg_21_1.talkMaxDuration)

			if var_24_29 <= arg_21_1.time_ and arg_21_1.time_ < var_24_29 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_29) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_29 + var_24_37 and arg_21_1.time_ < var_24_29 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 419101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play419101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10102ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102ui_story, var_28_4, var_28_3)

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

			local var_28_9 = arg_25_1.actors_["1045ui_story"].transform
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.moveOldPos1045ui_story = var_28_9.localPosition
			end

			local var_28_11 = 0.001

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11
				local var_28_13 = Vector3.New(0, 100, 0)

				var_28_9.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1045ui_story, var_28_13, var_28_12)

				local var_28_14 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_14.x, var_28_14.y, var_28_14.z)

				local var_28_15 = var_28_9.localEulerAngles

				var_28_15.z = 0
				var_28_15.x = 0
				var_28_9.localEulerAngles = var_28_15
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = Vector3.New(0, 100, 0)

				local var_28_16 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_16.x, var_28_16.y, var_28_16.z)

				local var_28_17 = var_28_9.localEulerAngles

				var_28_17.z = 0
				var_28_17.x = 0
				var_28_9.localEulerAngles = var_28_17
			end

			local var_28_18 = "1046ui_story"

			if arg_25_1.actors_[var_28_18] == nil then
				local var_28_19 = Asset.Load("Char/" .. "1046ui_story")

				if not isNil(var_28_19) then
					local var_28_20 = Object.Instantiate(Asset.Load("Char/" .. "1046ui_story"), arg_25_1.stage_.transform)

					var_28_20.name = var_28_18
					var_28_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_18] = var_28_20

					local var_28_21 = var_28_20:GetComponentInChildren(typeof(CharacterEffect))

					var_28_21.enabled = true

					local var_28_22 = GameObjectTools.GetOrAddComponent(var_28_20, typeof(DynamicBoneHelper))

					if var_28_22 then
						var_28_22:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_21.transform, false)

					arg_25_1.var_[var_28_18 .. "Animator"] = var_28_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_18 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_18 .. "LipSync"] = var_28_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_23 = arg_25_1.actors_["1046ui_story"].transform
			local var_28_24 = 0

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 then
				arg_25_1.var_.moveOldPos1046ui_story = var_28_23.localPosition
			end

			local var_28_25 = 0.001

			if var_28_24 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_25 then
				local var_28_26 = (arg_25_1.time_ - var_28_24) / var_28_25
				local var_28_27 = Vector3.New(0, -1, -6.1)

				var_28_23.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1046ui_story, var_28_27, var_28_26)

				local var_28_28 = manager.ui.mainCamera.transform.position - var_28_23.position

				var_28_23.forward = Vector3.New(var_28_28.x, var_28_28.y, var_28_28.z)

				local var_28_29 = var_28_23.localEulerAngles

				var_28_29.z = 0
				var_28_29.x = 0
				var_28_23.localEulerAngles = var_28_29
			end

			if arg_25_1.time_ >= var_28_24 + var_28_25 and arg_25_1.time_ < var_28_24 + var_28_25 + arg_28_0 then
				var_28_23.localPosition = Vector3.New(0, -1, -6.1)

				local var_28_30 = manager.ui.mainCamera.transform.position - var_28_23.position

				var_28_23.forward = Vector3.New(var_28_30.x, var_28_30.y, var_28_30.z)

				local var_28_31 = var_28_23.localEulerAngles

				var_28_31.z = 0
				var_28_31.x = 0
				var_28_23.localEulerAngles = var_28_31
			end

			local var_28_32 = arg_25_1.actors_["1046ui_story"]
			local var_28_33 = 0

			if var_28_33 < arg_25_1.time_ and arg_25_1.time_ <= var_28_33 + arg_28_0 and not isNil(var_28_32) and arg_25_1.var_.characterEffect1046ui_story == nil then
				arg_25_1.var_.characterEffect1046ui_story = var_28_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_34 = 0.200000002980232

			if var_28_33 <= arg_25_1.time_ and arg_25_1.time_ < var_28_33 + var_28_34 and not isNil(var_28_32) then
				local var_28_35 = (arg_25_1.time_ - var_28_33) / var_28_34

				if arg_25_1.var_.characterEffect1046ui_story and not isNil(var_28_32) then
					arg_25_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_33 + var_28_34 and arg_25_1.time_ < var_28_33 + var_28_34 + arg_28_0 and not isNil(var_28_32) and arg_25_1.var_.characterEffect1046ui_story then
				arg_25_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_28_36 = arg_25_1.actors_["10102ui_story"]
			local var_28_37 = 0

			if var_28_37 < arg_25_1.time_ and arg_25_1.time_ <= var_28_37 + arg_28_0 and not isNil(var_28_36) and arg_25_1.var_.characterEffect10102ui_story == nil then
				arg_25_1.var_.characterEffect10102ui_story = var_28_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_38 = 0.200000002980232

			if var_28_37 <= arg_25_1.time_ and arg_25_1.time_ < var_28_37 + var_28_38 and not isNil(var_28_36) then
				local var_28_39 = (arg_25_1.time_ - var_28_37) / var_28_38

				if arg_25_1.var_.characterEffect10102ui_story and not isNil(var_28_36) then
					local var_28_40 = Mathf.Lerp(0, 0.5, var_28_39)

					arg_25_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10102ui_story.fillRatio = var_28_40
				end
			end

			if arg_25_1.time_ >= var_28_37 + var_28_38 and arg_25_1.time_ < var_28_37 + var_28_38 + arg_28_0 and not isNil(var_28_36) and arg_25_1.var_.characterEffect10102ui_story then
				local var_28_41 = 0.5

				arg_25_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10102ui_story.fillRatio = var_28_41
			end

			local var_28_42 = 0

			if var_28_42 < arg_25_1.time_ and arg_25_1.time_ <= var_28_42 + arg_28_0 then
				arg_25_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_1")
			end

			local var_28_43 = 0

			if var_28_43 < arg_25_1.time_ and arg_25_1.time_ <= var_28_43 + arg_28_0 then
				arg_25_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_44 = 0
			local var_28_45 = 0.575

			if var_28_44 < arg_25_1.time_ and arg_25_1.time_ <= var_28_44 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_46 = arg_25_1:FormatText(StoryNameCfg[1207].name)

				arg_25_1.leftNameTxt_.text = var_28_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_47 = arg_25_1:GetWordFromCfg(419101006)
				local var_28_48 = arg_25_1:FormatText(var_28_47.content)

				arg_25_1.text_.text = var_28_48

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_49 = 23
				local var_28_50 = utf8.len(var_28_48)
				local var_28_51 = var_28_49 <= 0 and var_28_45 or var_28_45 * (var_28_50 / var_28_49)

				if var_28_51 > 0 and var_28_45 < var_28_51 then
					arg_25_1.talkMaxDuration = var_28_51

					if var_28_51 + var_28_44 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_51 + var_28_44
					end
				end

				arg_25_1.text_.text = var_28_48
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_52 = math.max(var_28_45, arg_25_1.talkMaxDuration)

			if var_28_44 <= arg_25_1.time_ and arg_25_1.time_ < var_28_44 + var_28_52 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_44) / var_28_52

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_44 + var_28_52 and arg_25_1.time_ < var_28_44 + var_28_52 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 419101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play419101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.675

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1207].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(419101007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 27
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play419101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 419101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play419101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1046ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1046ui_story == nil then
				arg_33_1.var_.characterEffect1046ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1046ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1046ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1046ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1046ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.5

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(419101008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 20
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play419101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 419101009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play419101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1045ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1045ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0.7, -1, -6.05)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1045ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1045ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1045ui_story == nil then
				arg_37_1.var_.characterEffect1045ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1045ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1045ui_story then
				arg_37_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action7_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_40_15 = arg_37_1.actors_["1046ui_story"].transform
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.var_.moveOldPos1046ui_story = var_40_15.localPosition
			end

			local var_40_17 = 0.001

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Vector3.New(-0.7, -1, -6.1)

				var_40_15.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1046ui_story, var_40_19, var_40_18)

				local var_40_20 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_20.x, var_40_20.y, var_40_20.z)

				local var_40_21 = var_40_15.localEulerAngles

				var_40_21.z = 0
				var_40_21.x = 0
				var_40_15.localEulerAngles = var_40_21
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				var_40_15.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_40_22 = manager.ui.mainCamera.transform.position - var_40_15.position

				var_40_15.forward = Vector3.New(var_40_22.x, var_40_22.y, var_40_22.z)

				local var_40_23 = var_40_15.localEulerAngles

				var_40_23.z = 0
				var_40_23.x = 0
				var_40_15.localEulerAngles = var_40_23
			end

			local var_40_24 = 0
			local var_40_25 = 0.525

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_26 = arg_37_1:FormatText(StoryNameCfg[1202].name)

				arg_37_1.leftNameTxt_.text = var_40_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_27 = arg_37_1:GetWordFromCfg(419101009)
				local var_40_28 = arg_37_1:FormatText(var_40_27.content)

				arg_37_1.text_.text = var_40_28

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_29 = 21
				local var_40_30 = utf8.len(var_40_28)
				local var_40_31 = var_40_29 <= 0 and var_40_25 or var_40_25 * (var_40_30 / var_40_29)

				if var_40_31 > 0 and var_40_25 < var_40_31 then
					arg_37_1.talkMaxDuration = var_40_31

					if var_40_31 + var_40_24 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_24
					end
				end

				arg_37_1.text_.text = var_40_28
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_32 = math.max(var_40_25, arg_37_1.talkMaxDuration)

			if var_40_24 <= arg_37_1.time_ and arg_37_1.time_ < var_40_24 + var_40_32 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_24) / var_40_32

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_24 + var_40_32 and arg_37_1.time_ < var_40_24 + var_40_32 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 419101010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play419101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1046ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1046ui_story == nil then
				arg_41_1.var_.characterEffect1046ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1046ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1046ui_story then
				arg_41_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1045ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1045ui_story == nil then
				arg_41_1.var_.characterEffect1045ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1045ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1045ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1045ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1045ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_2")
			end

			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_44_12 = 0
			local var_44_13 = 0.2

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[1207].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(419101010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 23
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_20 and arg_41_1.time_ < var_44_12 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play419101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 419101011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play419101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1046ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1046ui_story == nil then
				arg_45_1.var_.characterEffect1046ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1046ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1046ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1046ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1046ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.675

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(419101011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 27
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play419101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 419101012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play419101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1045ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1045ui_story == nil then
				arg_49_1.var_.characterEffect1045ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1045ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1045ui_story then
				arg_49_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action7_2")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.575

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[1202].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(419101012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 21
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play419101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 419101013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play419101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1045ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1045ui_story == nil then
				arg_53_1.var_.characterEffect1045ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1045ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1045ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1045ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1045ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.8

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(419101013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 32
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play419101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 419101014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play419101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10102ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10102ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, -0.985, -6.275)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10102ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["10102ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10102ui_story == nil then
				arg_57_1.var_.characterEffect10102ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect10102ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect10102ui_story then
				arg_57_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_60_15 = arg_57_1.actors_["1045ui_story"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos1045ui_story = var_60_15.localPosition
			end

			local var_60_17 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17
				local var_60_19 = Vector3.New(0, 100, 0)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1045ui_story, var_60_19, var_60_18)

				local var_60_20 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_20.x, var_60_20.y, var_60_20.z)

				local var_60_21 = var_60_15.localEulerAngles

				var_60_21.z = 0
				var_60_21.x = 0
				var_60_15.localEulerAngles = var_60_21
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(0, 100, 0)

				local var_60_22 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_22.x, var_60_22.y, var_60_22.z)

				local var_60_23 = var_60_15.localEulerAngles

				var_60_23.z = 0
				var_60_23.x = 0
				var_60_15.localEulerAngles = var_60_23
			end

			local var_60_24 = arg_57_1.actors_["1046ui_story"].transform
			local var_60_25 = 0

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 then
				arg_57_1.var_.moveOldPos1046ui_story = var_60_24.localPosition
			end

			local var_60_26 = 0.001

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_26 then
				local var_60_27 = (arg_57_1.time_ - var_60_25) / var_60_26
				local var_60_28 = Vector3.New(0, 100, 0)

				var_60_24.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1046ui_story, var_60_28, var_60_27)

				local var_60_29 = manager.ui.mainCamera.transform.position - var_60_24.position

				var_60_24.forward = Vector3.New(var_60_29.x, var_60_29.y, var_60_29.z)

				local var_60_30 = var_60_24.localEulerAngles

				var_60_30.z = 0
				var_60_30.x = 0
				var_60_24.localEulerAngles = var_60_30
			end

			if arg_57_1.time_ >= var_60_25 + var_60_26 and arg_57_1.time_ < var_60_25 + var_60_26 + arg_60_0 then
				var_60_24.localPosition = Vector3.New(0, 100, 0)

				local var_60_31 = manager.ui.mainCamera.transform.position - var_60_24.position

				var_60_24.forward = Vector3.New(var_60_31.x, var_60_31.y, var_60_31.z)

				local var_60_32 = var_60_24.localEulerAngles

				var_60_32.z = 0
				var_60_32.x = 0
				var_60_24.localEulerAngles = var_60_32
			end

			local var_60_33 = 0
			local var_60_34 = 0.75

			if var_60_33 < arg_57_1.time_ and arg_57_1.time_ <= var_60_33 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_35 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_36 = arg_57_1:GetWordFromCfg(419101014)
				local var_60_37 = arg_57_1:FormatText(var_60_36.content)

				arg_57_1.text_.text = var_60_37

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_38 = 30
				local var_60_39 = utf8.len(var_60_37)
				local var_60_40 = var_60_38 <= 0 and var_60_34 or var_60_34 * (var_60_39 / var_60_38)

				if var_60_40 > 0 and var_60_34 < var_60_40 then
					arg_57_1.talkMaxDuration = var_60_40

					if var_60_40 + var_60_33 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_40 + var_60_33
					end
				end

				arg_57_1.text_.text = var_60_37
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_41 = math.max(var_60_34, arg_57_1.talkMaxDuration)

			if var_60_33 <= arg_57_1.time_ and arg_57_1.time_ < var_60_33 + var_60_41 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_33) / var_60_41

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_33 + var_60_41 and arg_57_1.time_ < var_60_33 + var_60_41 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 419101015
		arg_61_1.duration_ = 9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play419101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "ST18a"

			if arg_61_1.bgs_[var_64_0] == nil then
				local var_64_1 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_64_0)
				var_64_1.name = var_64_0
				var_64_1.transform.parent = arg_61_1.stage_.transform
				var_64_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_[var_64_0] = var_64_1
			end

			local var_64_2 = 2

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				local var_64_3 = manager.ui.mainCamera.transform.localPosition
				local var_64_4 = Vector3.New(0, 0, 10) + Vector3.New(var_64_3.x, var_64_3.y, 0)
				local var_64_5 = arg_61_1.bgs_.ST18a

				var_64_5.transform.localPosition = var_64_4
				var_64_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_6 = var_64_5:GetComponent("SpriteRenderer")

				if var_64_6 and var_64_6.sprite then
					local var_64_7 = (var_64_5.transform.localPosition - var_64_3).z
					local var_64_8 = manager.ui.mainCameraCom_
					local var_64_9 = 2 * var_64_7 * Mathf.Tan(var_64_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_10 = var_64_9 * var_64_8.aspect
					local var_64_11 = var_64_6.sprite.bounds.size.x
					local var_64_12 = var_64_6.sprite.bounds.size.y
					local var_64_13 = var_64_10 / var_64_11
					local var_64_14 = var_64_9 / var_64_12
					local var_64_15 = var_64_14 < var_64_13 and var_64_13 or var_64_14

					var_64_5.transform.localScale = Vector3.New(var_64_15, var_64_15, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST18a" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_16 = 4

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_17 = 0.3

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_19 = 2

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_19 then
				local var_64_20 = (arg_61_1.time_ - var_64_18) / var_64_19
				local var_64_21 = Color.New(0, 0, 0)

				var_64_21.a = Mathf.Lerp(0, 1, var_64_20)
				arg_61_1.mask_.color = var_64_21
			end

			if arg_61_1.time_ >= var_64_18 + var_64_19 and arg_61_1.time_ < var_64_18 + var_64_19 + arg_64_0 then
				local var_64_22 = Color.New(0, 0, 0)

				var_64_22.a = 1
				arg_61_1.mask_.color = var_64_22
			end

			local var_64_23 = 2

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_24 = 2

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24
				local var_64_26 = Color.New(0, 0, 0)

				var_64_26.a = Mathf.Lerp(1, 0, var_64_25)
				arg_61_1.mask_.color = var_64_26
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				local var_64_27 = Color.New(0, 0, 0)
				local var_64_28 = 0

				arg_61_1.mask_.enabled = false
				var_64_27.a = var_64_28
				arg_61_1.mask_.color = var_64_27
			end

			local var_64_29 = arg_61_1.actors_["10102ui_story"].transform
			local var_64_30 = 1.96666666666667

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.var_.moveOldPos10102ui_story = var_64_29.localPosition
			end

			local var_64_31 = 0.001

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_31 then
				local var_64_32 = (arg_61_1.time_ - var_64_30) / var_64_31
				local var_64_33 = Vector3.New(0, 100, 0)

				var_64_29.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10102ui_story, var_64_33, var_64_32)

				local var_64_34 = manager.ui.mainCamera.transform.position - var_64_29.position

				var_64_29.forward = Vector3.New(var_64_34.x, var_64_34.y, var_64_34.z)

				local var_64_35 = var_64_29.localEulerAngles

				var_64_35.z = 0
				var_64_35.x = 0
				var_64_29.localEulerAngles = var_64_35
			end

			if arg_61_1.time_ >= var_64_30 + var_64_31 and arg_61_1.time_ < var_64_30 + var_64_31 + arg_64_0 then
				var_64_29.localPosition = Vector3.New(0, 100, 0)

				local var_64_36 = manager.ui.mainCamera.transform.position - var_64_29.position

				var_64_29.forward = Vector3.New(var_64_36.x, var_64_36.y, var_64_36.z)

				local var_64_37 = var_64_29.localEulerAngles

				var_64_37.z = 0
				var_64_37.x = 0
				var_64_29.localEulerAngles = var_64_37
			end

			local var_64_38 = "1066ui_story"

			if arg_61_1.actors_[var_64_38] == nil then
				local var_64_39 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_64_39) then
					local var_64_40 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_61_1.stage_.transform)

					var_64_40.name = var_64_38
					var_64_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_38] = var_64_40

					local var_64_41 = var_64_40:GetComponentInChildren(typeof(CharacterEffect))

					var_64_41.enabled = true

					local var_64_42 = GameObjectTools.GetOrAddComponent(var_64_40, typeof(DynamicBoneHelper))

					if var_64_42 then
						var_64_42:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_41.transform, false)

					arg_61_1.var_[var_64_38 .. "Animator"] = var_64_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_38 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_38 .. "LipSync"] = var_64_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_43 = arg_61_1.actors_["1066ui_story"].transform
			local var_64_44 = 3.73333333333333

			if var_64_44 < arg_61_1.time_ and arg_61_1.time_ <= var_64_44 + arg_64_0 then
				arg_61_1.var_.moveOldPos1066ui_story = var_64_43.localPosition
			end

			local var_64_45 = 0.001

			if var_64_44 <= arg_61_1.time_ and arg_61_1.time_ < var_64_44 + var_64_45 then
				local var_64_46 = (arg_61_1.time_ - var_64_44) / var_64_45
				local var_64_47 = Vector3.New(0, -0.77, -6.1)

				var_64_43.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1066ui_story, var_64_47, var_64_46)

				local var_64_48 = manager.ui.mainCamera.transform.position - var_64_43.position

				var_64_43.forward = Vector3.New(var_64_48.x, var_64_48.y, var_64_48.z)

				local var_64_49 = var_64_43.localEulerAngles

				var_64_49.z = 0
				var_64_49.x = 0
				var_64_43.localEulerAngles = var_64_49
			end

			if arg_61_1.time_ >= var_64_44 + var_64_45 and arg_61_1.time_ < var_64_44 + var_64_45 + arg_64_0 then
				var_64_43.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_64_50 = manager.ui.mainCamera.transform.position - var_64_43.position

				var_64_43.forward = Vector3.New(var_64_50.x, var_64_50.y, var_64_50.z)

				local var_64_51 = var_64_43.localEulerAngles

				var_64_51.z = 0
				var_64_51.x = 0
				var_64_43.localEulerAngles = var_64_51
			end

			local var_64_52 = arg_61_1.actors_["1066ui_story"]
			local var_64_53 = 3.73333333333333

			if var_64_53 < arg_61_1.time_ and arg_61_1.time_ <= var_64_53 + arg_64_0 and not isNil(var_64_52) and arg_61_1.var_.characterEffect1066ui_story == nil then
				arg_61_1.var_.characterEffect1066ui_story = var_64_52:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_54 = 0.200000002980232

			if var_64_53 <= arg_61_1.time_ and arg_61_1.time_ < var_64_53 + var_64_54 and not isNil(var_64_52) then
				local var_64_55 = (arg_61_1.time_ - var_64_53) / var_64_54

				if arg_61_1.var_.characterEffect1066ui_story and not isNil(var_64_52) then
					arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_53 + var_64_54 and arg_61_1.time_ < var_64_53 + var_64_54 + arg_64_0 and not isNil(var_64_52) and arg_61_1.var_.characterEffect1066ui_story then
				arg_61_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_64_56 = 3.73333333333333

			if var_64_56 < arg_61_1.time_ and arg_61_1.time_ <= var_64_56 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			local var_64_57 = 3.73333333333333

			if var_64_57 < arg_61_1.time_ and arg_61_1.time_ <= var_64_57 + arg_64_0 then
				arg_61_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_58 = 2.00066666851441

			arg_61_1.isInRecall_ = false

			if var_64_58 < arg_61_1.time_ and arg_61_1.time_ <= var_64_58 + arg_64_0 then
				arg_61_1.screenFilterGo_:SetActive(true)

				arg_61_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_64_2, iter_64_3 in pairs(arg_61_1.actors_) do
					local var_64_59 = iter_64_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_64_4, iter_64_5 in ipairs(var_64_59) do
						if iter_64_5.color.r > 0.51 then
							iter_64_5.color = Color.New(1, 1, 1)
						else
							iter_64_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_64_60 = 0.0659999981522561

			if var_64_58 <= arg_61_1.time_ and arg_61_1.time_ < var_64_58 + var_64_60 then
				local var_64_61 = (arg_61_1.time_ - var_64_58) / var_64_60

				arg_61_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_64_61)
			end

			if arg_61_1.time_ >= var_64_58 + var_64_60 and arg_61_1.time_ < var_64_58 + var_64_60 + arg_64_0 then
				arg_61_1.screenFilterEffect_.weight = 1
			end

			local var_64_62 = 0.366666666666667
			local var_64_63 = 1

			if var_64_62 < arg_61_1.time_ and arg_61_1.time_ <= var_64_62 + arg_64_0 then
				local var_64_64 = "stop"
				local var_64_65 = "effect"

				arg_61_1:AudioAction(var_64_64, var_64_65, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			local var_64_66 = 1.53333333333333
			local var_64_67 = 1

			if var_64_66 < arg_61_1.time_ and arg_61_1.time_ <= var_64_66 + arg_64_0 then
				local var_64_68 = "play"
				local var_64_69 = "effect"

				arg_61_1:AudioAction(var_64_68, var_64_69, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_70 = 3.999999999999
			local var_64_71 = 0.225

			if var_64_70 < arg_61_1.time_ and arg_61_1.time_ <= var_64_70 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_72 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_72:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_73 = arg_61_1:FormatText(StoryNameCfg[32].name)

				arg_61_1.leftNameTxt_.text = var_64_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_74 = arg_61_1:GetWordFromCfg(419101015)
				local var_64_75 = arg_61_1:FormatText(var_64_74.content)

				arg_61_1.text_.text = var_64_75

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_76 = 9
				local var_64_77 = utf8.len(var_64_75)
				local var_64_78 = var_64_76 <= 0 and var_64_71 or var_64_71 * (var_64_77 / var_64_76)

				if var_64_78 > 0 and var_64_71 < var_64_78 then
					arg_61_1.talkMaxDuration = var_64_78
					var_64_70 = var_64_70 + 0.3

					if var_64_78 + var_64_70 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_78 + var_64_70
					end
				end

				arg_61_1.text_.text = var_64_75
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_79 = var_64_70 + 0.3
			local var_64_80 = math.max(var_64_71, arg_61_1.talkMaxDuration)

			if var_64_79 <= arg_61_1.time_ and arg_61_1.time_ < var_64_79 + var_64_80 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_79) / var_64_80

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_79 + var_64_80 and arg_61_1.time_ < var_64_79 + var_64_80 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play419101016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 419101016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play419101017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1066ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1066ui_story == nil then
				arg_67_1.var_.characterEffect1066ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1066ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1066ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1066ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1066ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.9

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(419101016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 36
				local var_70_11 = utf8.len(var_70_9)
				local var_70_12 = var_70_10 <= 0 and var_70_7 or var_70_7 * (var_70_11 / var_70_10)

				if var_70_12 > 0 and var_70_7 < var_70_12 then
					arg_67_1.talkMaxDuration = var_70_12

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_13 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_13 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_13

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_13 and arg_67_1.time_ < var_70_6 + var_70_13 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play419101017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 419101017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play419101018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.4

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(419101017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 16
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_8 and arg_71_1.time_ < var_74_0 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play419101018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 419101018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play419101019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1066ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1066ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -0.77, -6.1)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1066ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1066ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1066ui_story == nil then
				arg_75_1.var_.characterEffect1066ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1066ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1066ui_story then
				arg_75_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_78_13 = 0

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_78_15 = 0
			local var_78_16 = 0.975

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_17 = arg_75_1:FormatText(StoryNameCfg[32].name)

				arg_75_1.leftNameTxt_.text = var_78_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_18 = arg_75_1:GetWordFromCfg(419101018)
				local var_78_19 = arg_75_1:FormatText(var_78_18.content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_20 = 39
				local var_78_21 = utf8.len(var_78_19)
				local var_78_22 = var_78_20 <= 0 and var_78_16 or var_78_16 * (var_78_21 / var_78_20)

				if var_78_22 > 0 and var_78_16 < var_78_22 then
					arg_75_1.talkMaxDuration = var_78_22

					if var_78_22 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_22 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_19
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_23 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_23 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_23

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_23 and arg_75_1.time_ < var_78_15 + var_78_23 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play419101019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 419101019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play419101020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1045ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1045ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(-0.7, -1, -6.05)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1045ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1066ui_story"].transform
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.var_.moveOldPos1066ui_story = var_82_9.localPosition
			end

			local var_82_11 = 0.001

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11
				local var_82_13 = Vector3.New(0, 100, 0)

				var_82_9.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1066ui_story, var_82_13, var_82_12)

				local var_82_14 = manager.ui.mainCamera.transform.position - var_82_9.position

				var_82_9.forward = Vector3.New(var_82_14.x, var_82_14.y, var_82_14.z)

				local var_82_15 = var_82_9.localEulerAngles

				var_82_15.z = 0
				var_82_15.x = 0
				var_82_9.localEulerAngles = var_82_15
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 then
				var_82_9.localPosition = Vector3.New(0, 100, 0)

				local var_82_16 = manager.ui.mainCamera.transform.position - var_82_9.position

				var_82_9.forward = Vector3.New(var_82_16.x, var_82_16.y, var_82_16.z)

				local var_82_17 = var_82_9.localEulerAngles

				var_82_17.z = 0
				var_82_17.x = 0
				var_82_9.localEulerAngles = var_82_17
			end

			local var_82_18 = arg_79_1.actors_["1045ui_story"]
			local var_82_19 = 0

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 and not isNil(var_82_18) and arg_79_1.var_.characterEffect1045ui_story == nil then
				arg_79_1.var_.characterEffect1045ui_story = var_82_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_20 = 0.200000002980232

			if var_82_19 <= arg_79_1.time_ and arg_79_1.time_ < var_82_19 + var_82_20 and not isNil(var_82_18) then
				local var_82_21 = (arg_79_1.time_ - var_82_19) / var_82_20

				if arg_79_1.var_.characterEffect1045ui_story and not isNil(var_82_18) then
					arg_79_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_19 + var_82_20 and arg_79_1.time_ < var_82_19 + var_82_20 + arg_82_0 and not isNil(var_82_18) and arg_79_1.var_.characterEffect1045ui_story then
				arg_79_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_82_22 = arg_79_1.actors_["1066ui_story"]
			local var_82_23 = 0

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 and not isNil(var_82_22) and arg_79_1.var_.characterEffect1066ui_story == nil then
				arg_79_1.var_.characterEffect1066ui_story = var_82_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_24 = 0.200000002980232

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_24 and not isNil(var_82_22) then
				local var_82_25 = (arg_79_1.time_ - var_82_23) / var_82_24

				if arg_79_1.var_.characterEffect1066ui_story and not isNil(var_82_22) then
					local var_82_26 = Mathf.Lerp(0, 0.5, var_82_25)

					arg_79_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1066ui_story.fillRatio = var_82_26
				end
			end

			if arg_79_1.time_ >= var_82_23 + var_82_24 and arg_79_1.time_ < var_82_23 + var_82_24 + arg_82_0 and not isNil(var_82_22) and arg_79_1.var_.characterEffect1066ui_story then
				local var_82_27 = 0.5

				arg_79_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1066ui_story.fillRatio = var_82_27
			end

			local var_82_28 = 0

			if var_82_28 < arg_79_1.time_ and arg_79_1.time_ <= var_82_28 + arg_82_0 then
				arg_79_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action5_1")
			end

			local var_82_29 = 0

			if var_82_29 < arg_79_1.time_ and arg_79_1.time_ <= var_82_29 + arg_82_0 then
				arg_79_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_82_30 = 0
			local var_82_31 = 0.45

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_32 = arg_79_1:FormatText(StoryNameCfg[1202].name)

				arg_79_1.leftNameTxt_.text = var_82_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_33 = arg_79_1:GetWordFromCfg(419101019)
				local var_82_34 = arg_79_1:FormatText(var_82_33.content)

				arg_79_1.text_.text = var_82_34

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_35 = 18
				local var_82_36 = utf8.len(var_82_34)
				local var_82_37 = var_82_35 <= 0 and var_82_31 or var_82_31 * (var_82_36 / var_82_35)

				if var_82_37 > 0 and var_82_31 < var_82_37 then
					arg_79_1.talkMaxDuration = var_82_37

					if var_82_37 + var_82_30 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_37 + var_82_30
					end
				end

				arg_79_1.text_.text = var_82_34
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_38 = math.max(var_82_31, arg_79_1.talkMaxDuration)

			if var_82_30 <= arg_79_1.time_ and arg_79_1.time_ < var_82_30 + var_82_38 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_30) / var_82_38

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_30 + var_82_38 and arg_79_1.time_ < var_82_30 + var_82_38 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play419101020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 419101020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play419101021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1045ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1045ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(-0.7, -1, -6.05)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1045ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1046ui_story"].transform
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos1046ui_story = var_86_9.localPosition
			end

			local var_86_11 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11
				local var_86_13 = Vector3.New(0.7, -1, -6.1)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1046ui_story, var_86_13, var_86_12)

				local var_86_14 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_14.x, var_86_14.y, var_86_14.z)

				local var_86_15 = var_86_9.localEulerAngles

				var_86_15.z = 0
				var_86_15.x = 0
				var_86_9.localEulerAngles = var_86_15
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_9.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_9.localEulerAngles = var_86_17
			end

			local var_86_18 = arg_83_1.actors_["1046ui_story"]
			local var_86_19 = 0

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 and not isNil(var_86_18) and arg_83_1.var_.characterEffect1046ui_story == nil then
				arg_83_1.var_.characterEffect1046ui_story = var_86_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_20 = 0.200000002980232

			if var_86_19 <= arg_83_1.time_ and arg_83_1.time_ < var_86_19 + var_86_20 and not isNil(var_86_18) then
				local var_86_21 = (arg_83_1.time_ - var_86_19) / var_86_20

				if arg_83_1.var_.characterEffect1046ui_story and not isNil(var_86_18) then
					arg_83_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_19 + var_86_20 and arg_83_1.time_ < var_86_19 + var_86_20 + arg_86_0 and not isNil(var_86_18) and arg_83_1.var_.characterEffect1046ui_story then
				arg_83_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_86_22 = arg_83_1.actors_["1045ui_story"]
			local var_86_23 = 0

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 and not isNil(var_86_22) and arg_83_1.var_.characterEffect1045ui_story == nil then
				arg_83_1.var_.characterEffect1045ui_story = var_86_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_24 = 0.200000002980232

			if var_86_23 <= arg_83_1.time_ and arg_83_1.time_ < var_86_23 + var_86_24 and not isNil(var_86_22) then
				local var_86_25 = (arg_83_1.time_ - var_86_23) / var_86_24

				if arg_83_1.var_.characterEffect1045ui_story and not isNil(var_86_22) then
					local var_86_26 = Mathf.Lerp(0, 0.5, var_86_25)

					arg_83_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1045ui_story.fillRatio = var_86_26
				end
			end

			if arg_83_1.time_ >= var_86_23 + var_86_24 and arg_83_1.time_ < var_86_23 + var_86_24 + arg_86_0 and not isNil(var_86_22) and arg_83_1.var_.characterEffect1045ui_story then
				local var_86_27 = 0.5

				arg_83_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1045ui_story.fillRatio = var_86_27
			end

			local var_86_28 = 0

			if var_86_28 < arg_83_1.time_ and arg_83_1.time_ <= var_86_28 + arg_86_0 then
				arg_83_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_1")
			end

			local var_86_29 = 0

			if var_86_29 < arg_83_1.time_ and arg_83_1.time_ <= var_86_29 + arg_86_0 then
				arg_83_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_86_30 = 0
			local var_86_31 = 0.35

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_32 = arg_83_1:FormatText(StoryNameCfg[1207].name)

				arg_83_1.leftNameTxt_.text = var_86_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_33 = arg_83_1:GetWordFromCfg(419101020)
				local var_86_34 = arg_83_1:FormatText(var_86_33.content)

				arg_83_1.text_.text = var_86_34

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_35 = 14
				local var_86_36 = utf8.len(var_86_34)
				local var_86_37 = var_86_35 <= 0 and var_86_31 or var_86_31 * (var_86_36 / var_86_35)

				if var_86_37 > 0 and var_86_31 < var_86_37 then
					arg_83_1.talkMaxDuration = var_86_37

					if var_86_37 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_37 + var_86_30
					end
				end

				arg_83_1.text_.text = var_86_34
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_38 = math.max(var_86_31, arg_83_1.talkMaxDuration)

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_38 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_30) / var_86_38

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_30 + var_86_38 and arg_83_1.time_ < var_86_30 + var_86_38 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419101021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 419101021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play419101022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1045ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1045ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1045ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1046ui_story"].transform
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.var_.moveOldPos1046ui_story = var_90_9.localPosition
			end

			local var_90_11 = 0.001

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11
				local var_90_13 = Vector3.New(0, 100, 0)

				var_90_9.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1046ui_story, var_90_13, var_90_12)

				local var_90_14 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_14.x, var_90_14.y, var_90_14.z)

				local var_90_15 = var_90_9.localEulerAngles

				var_90_15.z = 0
				var_90_15.x = 0
				var_90_9.localEulerAngles = var_90_15
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 then
				var_90_9.localPosition = Vector3.New(0, 100, 0)

				local var_90_16 = manager.ui.mainCamera.transform.position - var_90_9.position

				var_90_9.forward = Vector3.New(var_90_16.x, var_90_16.y, var_90_16.z)

				local var_90_17 = var_90_9.localEulerAngles

				var_90_17.z = 0
				var_90_17.x = 0
				var_90_9.localEulerAngles = var_90_17
			end

			local var_90_18 = arg_87_1.actors_["1066ui_story"].transform
			local var_90_19 = 0

			if var_90_19 < arg_87_1.time_ and arg_87_1.time_ <= var_90_19 + arg_90_0 then
				arg_87_1.var_.moveOldPos1066ui_story = var_90_18.localPosition
			end

			local var_90_20 = 0.001

			if var_90_19 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				local var_90_21 = (arg_87_1.time_ - var_90_19) / var_90_20
				local var_90_22 = Vector3.New(0, -0.77, -6.1)

				var_90_18.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1066ui_story, var_90_22, var_90_21)

				local var_90_23 = manager.ui.mainCamera.transform.position - var_90_18.position

				var_90_18.forward = Vector3.New(var_90_23.x, var_90_23.y, var_90_23.z)

				local var_90_24 = var_90_18.localEulerAngles

				var_90_24.z = 0
				var_90_24.x = 0
				var_90_18.localEulerAngles = var_90_24
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				var_90_18.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_90_25 = manager.ui.mainCamera.transform.position - var_90_18.position

				var_90_18.forward = Vector3.New(var_90_25.x, var_90_25.y, var_90_25.z)

				local var_90_26 = var_90_18.localEulerAngles

				var_90_26.z = 0
				var_90_26.x = 0
				var_90_18.localEulerAngles = var_90_26
			end

			local var_90_27 = arg_87_1.actors_["1066ui_story"]
			local var_90_28 = 0

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 and not isNil(var_90_27) and arg_87_1.var_.characterEffect1066ui_story == nil then
				arg_87_1.var_.characterEffect1066ui_story = var_90_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_29 = 0.200000002980232

			if var_90_28 <= arg_87_1.time_ and arg_87_1.time_ < var_90_28 + var_90_29 and not isNil(var_90_27) then
				local var_90_30 = (arg_87_1.time_ - var_90_28) / var_90_29

				if arg_87_1.var_.characterEffect1066ui_story and not isNil(var_90_27) then
					arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_28 + var_90_29 and arg_87_1.time_ < var_90_28 + var_90_29 + arg_90_0 and not isNil(var_90_27) and arg_87_1.var_.characterEffect1066ui_story then
				arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_90_31 = arg_87_1.actors_["1046ui_story"]
			local var_90_32 = 0

			if var_90_32 < arg_87_1.time_ and arg_87_1.time_ <= var_90_32 + arg_90_0 and not isNil(var_90_31) and arg_87_1.var_.characterEffect1046ui_story == nil then
				arg_87_1.var_.characterEffect1046ui_story = var_90_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_33 = 0.200000002980232

			if var_90_32 <= arg_87_1.time_ and arg_87_1.time_ < var_90_32 + var_90_33 and not isNil(var_90_31) then
				local var_90_34 = (arg_87_1.time_ - var_90_32) / var_90_33

				if arg_87_1.var_.characterEffect1046ui_story and not isNil(var_90_31) then
					local var_90_35 = Mathf.Lerp(0, 0.5, var_90_34)

					arg_87_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1046ui_story.fillRatio = var_90_35
				end
			end

			if arg_87_1.time_ >= var_90_32 + var_90_33 and arg_87_1.time_ < var_90_32 + var_90_33 + arg_90_0 and not isNil(var_90_31) and arg_87_1.var_.characterEffect1046ui_story then
				local var_90_36 = 0.5

				arg_87_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1046ui_story.fillRatio = var_90_36
			end

			local var_90_37 = 0

			if var_90_37 < arg_87_1.time_ and arg_87_1.time_ <= var_90_37 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_90_38 = 0

			if var_90_38 < arg_87_1.time_ and arg_87_1.time_ <= var_90_38 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_90_39 = 0
			local var_90_40 = 0.4

			if var_90_39 < arg_87_1.time_ and arg_87_1.time_ <= var_90_39 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_41 = arg_87_1:FormatText(StoryNameCfg[32].name)

				arg_87_1.leftNameTxt_.text = var_90_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_42 = arg_87_1:GetWordFromCfg(419101021)
				local var_90_43 = arg_87_1:FormatText(var_90_42.content)

				arg_87_1.text_.text = var_90_43

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_44 = 16
				local var_90_45 = utf8.len(var_90_43)
				local var_90_46 = var_90_44 <= 0 and var_90_40 or var_90_40 * (var_90_45 / var_90_44)

				if var_90_46 > 0 and var_90_40 < var_90_46 then
					arg_87_1.talkMaxDuration = var_90_46

					if var_90_46 + var_90_39 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_46 + var_90_39
					end
				end

				arg_87_1.text_.text = var_90_43
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_47 = math.max(var_90_40, arg_87_1.talkMaxDuration)

			if var_90_39 <= arg_87_1.time_ and arg_87_1.time_ < var_90_39 + var_90_47 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_39) / var_90_47

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_39 + var_90_47 and arg_87_1.time_ < var_90_39 + var_90_47 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play419101022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 419101022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play419101023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1066ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1066ui_story == nil then
				arg_91_1.var_.characterEffect1066ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1066ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1066ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1066ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1066ui_story.fillRatio = var_94_5
			end

			local var_94_6 = arg_91_1.actors_["1066ui_story"].transform
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.var_.moveOldPos1066ui_story = var_94_6.localPosition
			end

			local var_94_8 = 0.001

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_8 then
				local var_94_9 = (arg_91_1.time_ - var_94_7) / var_94_8
				local var_94_10 = Vector3.New(0, 100, 0)

				var_94_6.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1066ui_story, var_94_10, var_94_9)

				local var_94_11 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_11.x, var_94_11.y, var_94_11.z)

				local var_94_12 = var_94_6.localEulerAngles

				var_94_12.z = 0
				var_94_12.x = 0
				var_94_6.localEulerAngles = var_94_12
			end

			if arg_91_1.time_ >= var_94_7 + var_94_8 and arg_91_1.time_ < var_94_7 + var_94_8 + arg_94_0 then
				var_94_6.localPosition = Vector3.New(0, 100, 0)

				local var_94_13 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_13.x, var_94_13.y, var_94_13.z)

				local var_94_14 = var_94_6.localEulerAngles

				var_94_14.z = 0
				var_94_14.x = 0
				var_94_6.localEulerAngles = var_94_14
			end

			local var_94_15 = 0
			local var_94_16 = 0.9

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(419101022)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_19 = 36
				local var_94_20 = utf8.len(var_94_18)
				local var_94_21 = var_94_19 <= 0 and var_94_16 or var_94_16 * (var_94_20 / var_94_19)

				if var_94_21 > 0 and var_94_16 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_22 and arg_91_1.time_ < var_94_15 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play419101023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 419101023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play419101024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1066ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1066ui_story == nil then
				arg_95_1.var_.characterEffect1066ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1066ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1066ui_story then
				arg_95_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["1066ui_story"].transform
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.var_.moveOldPos1066ui_story = var_98_4.localPosition
			end

			local var_98_6 = 0.001

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6
				local var_98_8 = Vector3.New(0, -0.77, -6.1)

				var_98_4.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1066ui_story, var_98_8, var_98_7)

				local var_98_9 = manager.ui.mainCamera.transform.position - var_98_4.position

				var_98_4.forward = Vector3.New(var_98_9.x, var_98_9.y, var_98_9.z)

				local var_98_10 = var_98_4.localEulerAngles

				var_98_10.z = 0
				var_98_10.x = 0
				var_98_4.localEulerAngles = var_98_10
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 then
				var_98_4.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_98_11 = manager.ui.mainCamera.transform.position - var_98_4.position

				var_98_4.forward = Vector3.New(var_98_11.x, var_98_11.y, var_98_11.z)

				local var_98_12 = var_98_4.localEulerAngles

				var_98_12.z = 0
				var_98_12.x = 0
				var_98_4.localEulerAngles = var_98_12
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.675

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[32].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(419101023)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 27
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
				actorName = "1066ui_story",
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
	Play419101024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 419101024
		arg_99_1.duration_ = 9

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play419101025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.999999999999

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				local var_102_1 = manager.ui.mainCamera.transform.localPosition
				local var_102_2 = Vector3.New(0, 0, 10) + Vector3.New(var_102_1.x, var_102_1.y, 0)
				local var_102_3 = arg_99_1.bgs_.ST02

				var_102_3.transform.localPosition = var_102_2
				var_102_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_4 = var_102_3:GetComponent("SpriteRenderer")

				if var_102_4 and var_102_4.sprite then
					local var_102_5 = (var_102_3.transform.localPosition - var_102_1).z
					local var_102_6 = manager.ui.mainCameraCom_
					local var_102_7 = 2 * var_102_5 * Mathf.Tan(var_102_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_8 = var_102_7 * var_102_6.aspect
					local var_102_9 = var_102_4.sprite.bounds.size.x
					local var_102_10 = var_102_4.sprite.bounds.size.y
					local var_102_11 = var_102_8 / var_102_9
					local var_102_12 = var_102_7 / var_102_10
					local var_102_13 = var_102_12 < var_102_11 and var_102_11 or var_102_12

					var_102_3.transform.localScale = Vector3.New(var_102_13, var_102_13, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "ST02" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_14 = 4

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			local var_102_15 = 0.3

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_16 = 0

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_17 = 2

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_17 then
				local var_102_18 = (arg_99_1.time_ - var_102_16) / var_102_17
				local var_102_19 = Color.New(0, 0, 0)

				var_102_19.a = Mathf.Lerp(0, 1, var_102_18)
				arg_99_1.mask_.color = var_102_19
			end

			if arg_99_1.time_ >= var_102_16 + var_102_17 and arg_99_1.time_ < var_102_16 + var_102_17 + arg_102_0 then
				local var_102_20 = Color.New(0, 0, 0)

				var_102_20.a = 1
				arg_99_1.mask_.color = var_102_20
			end

			local var_102_21 = 2

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_22 = 2

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_22 then
				local var_102_23 = (arg_99_1.time_ - var_102_21) / var_102_22
				local var_102_24 = Color.New(0, 0, 0)

				var_102_24.a = Mathf.Lerp(1, 0, var_102_23)
				arg_99_1.mask_.color = var_102_24
			end

			if arg_99_1.time_ >= var_102_21 + var_102_22 and arg_99_1.time_ < var_102_21 + var_102_22 + arg_102_0 then
				local var_102_25 = Color.New(0, 0, 0)
				local var_102_26 = 0

				arg_99_1.mask_.enabled = false
				var_102_25.a = var_102_26
				arg_99_1.mask_.color = var_102_25
			end

			local var_102_27 = arg_99_1.actors_["1066ui_story"].transform
			local var_102_28 = 2

			if var_102_28 < arg_99_1.time_ and arg_99_1.time_ <= var_102_28 + arg_102_0 then
				arg_99_1.var_.moveOldPos1066ui_story = var_102_27.localPosition
			end

			local var_102_29 = 0.001

			if var_102_28 <= arg_99_1.time_ and arg_99_1.time_ < var_102_28 + var_102_29 then
				local var_102_30 = (arg_99_1.time_ - var_102_28) / var_102_29
				local var_102_31 = Vector3.New(0, 100, 0)

				var_102_27.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1066ui_story, var_102_31, var_102_30)

				local var_102_32 = manager.ui.mainCamera.transform.position - var_102_27.position

				var_102_27.forward = Vector3.New(var_102_32.x, var_102_32.y, var_102_32.z)

				local var_102_33 = var_102_27.localEulerAngles

				var_102_33.z = 0
				var_102_33.x = 0
				var_102_27.localEulerAngles = var_102_33
			end

			if arg_99_1.time_ >= var_102_28 + var_102_29 and arg_99_1.time_ < var_102_28 + var_102_29 + arg_102_0 then
				var_102_27.localPosition = Vector3.New(0, 100, 0)

				local var_102_34 = manager.ui.mainCamera.transform.position - var_102_27.position

				var_102_27.forward = Vector3.New(var_102_34.x, var_102_34.y, var_102_34.z)

				local var_102_35 = var_102_27.localEulerAngles

				var_102_35.z = 0
				var_102_35.x = 0
				var_102_27.localEulerAngles = var_102_35
			end

			local var_102_36 = 2.00066666851441

			arg_99_1.isInRecall_ = false

			if var_102_36 < arg_99_1.time_ and arg_99_1.time_ <= var_102_36 + arg_102_0 then
				arg_99_1.screenFilterGo_:SetActive(false)

				for iter_102_2, iter_102_3 in pairs(arg_99_1.actors_) do
					local var_102_37 = iter_102_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_102_4, iter_102_5 in ipairs(var_102_37) do
						if iter_102_5.color.r > 0.51 then
							iter_102_5.color = Color.New(1, 1, 1)
						else
							iter_102_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_102_38 = 0.0659999981522561

			if var_102_36 <= arg_99_1.time_ and arg_99_1.time_ < var_102_36 + var_102_38 then
				local var_102_39 = (arg_99_1.time_ - var_102_36) / var_102_38

				arg_99_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_102_39)
			end

			if arg_99_1.time_ >= var_102_36 + var_102_38 and arg_99_1.time_ < var_102_36 + var_102_38 + arg_102_0 then
				arg_99_1.screenFilterEffect_.weight = 0
			end

			local var_102_40 = 0.433333333333333
			local var_102_41 = 1

			if var_102_40 < arg_99_1.time_ and arg_99_1.time_ <= var_102_40 + arg_102_0 then
				local var_102_42 = "stop"
				local var_102_43 = "effect"

				arg_99_1:AudioAction(var_102_42, var_102_43, "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_102_44 = 1.6
			local var_102_45 = 1

			if var_102_44 < arg_99_1.time_ and arg_99_1.time_ <= var_102_44 + arg_102_0 then
				local var_102_46 = "play"
				local var_102_47 = "effect"

				arg_99_1:AudioAction(var_102_46, var_102_47, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_48 = 4
			local var_102_49 = 0.5

			if var_102_48 < arg_99_1.time_ and arg_99_1.time_ <= var_102_48 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_50 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_50:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_51 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_52 = arg_99_1:GetWordFromCfg(419101024)
				local var_102_53 = arg_99_1:FormatText(var_102_52.content)

				arg_99_1.text_.text = var_102_53

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_54 = 20
				local var_102_55 = utf8.len(var_102_53)
				local var_102_56 = var_102_54 <= 0 and var_102_49 or var_102_49 * (var_102_55 / var_102_54)

				if var_102_56 > 0 and var_102_49 < var_102_56 then
					arg_99_1.talkMaxDuration = var_102_56
					var_102_48 = var_102_48 + 0.3

					if var_102_56 + var_102_48 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_56 + var_102_48
					end
				end

				arg_99_1.text_.text = var_102_53
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_57 = var_102_48 + 0.3
			local var_102_58 = math.max(var_102_49, arg_99_1.talkMaxDuration)

			if var_102_57 <= arg_99_1.time_ and arg_99_1.time_ < var_102_57 + var_102_58 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_57) / var_102_58

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_57 + var_102_58 and arg_99_1.time_ < var_102_57 + var_102_58 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play419101025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 419101025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play419101026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10102ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10102ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -0.985, -6.275)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10102ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10102ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10102ui_story == nil then
				arg_105_1.var_.characterEffect10102ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10102ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10102ui_story then
				arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_108_15 = 0
			local var_108_16 = 0.325

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(419101025)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 13
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_23 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_23 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_23

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_23 and arg_105_1.time_ < var_108_15 + var_108_23 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play419101026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 419101026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play419101027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10102ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10102ui_story == nil then
				arg_109_1.var_.characterEffect10102ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10102ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10102ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10102ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10102ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.725

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(419101026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 29
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play419101027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 419101027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play419101028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_2")
			end

			local var_116_1 = 0
			local var_116_2 = 0.5

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_3 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:GetWordFromCfg(419101027)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 20
				local var_116_7 = utf8.len(var_116_5)
				local var_116_8 = var_116_6 <= 0 and var_116_2 or var_116_2 * (var_116_7 / var_116_6)

				if var_116_8 > 0 and var_116_2 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play419101028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 419101028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play419101029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1046ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1046ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -0.98, -5.86)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1046ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -0.98, -5.86)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1046ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1046ui_story == nil then
				arg_117_1.var_.characterEffect1046ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1046ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1046ui_story then
				arg_117_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_120_15 = arg_117_1.actors_["10102ui_story"].transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.var_.moveOldPos10102ui_story = var_120_15.localPosition
			end

			local var_120_17 = 0.001

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Vector3.New(0, 100, 0)

				var_120_15.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10102ui_story, var_120_19, var_120_18)

				local var_120_20 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_20.x, var_120_20.y, var_120_20.z)

				local var_120_21 = var_120_15.localEulerAngles

				var_120_21.z = 0
				var_120_21.x = 0
				var_120_15.localEulerAngles = var_120_21
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				var_120_15.localPosition = Vector3.New(0, 100, 0)

				local var_120_22 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_22.x, var_120_22.y, var_120_22.z)

				local var_120_23 = var_120_15.localEulerAngles

				var_120_23.z = 0
				var_120_23.x = 0
				var_120_15.localEulerAngles = var_120_23
			end

			local var_120_24 = 0
			local var_120_25 = 0.55

			if var_120_24 < arg_117_1.time_ and arg_117_1.time_ <= var_120_24 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_26 = arg_117_1:FormatText(StoryNameCfg[1207].name)

				arg_117_1.leftNameTxt_.text = var_120_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_27 = arg_117_1:GetWordFromCfg(419101028)
				local var_120_28 = arg_117_1:FormatText(var_120_27.content)

				arg_117_1.text_.text = var_120_28

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_29 = 22
				local var_120_30 = utf8.len(var_120_28)
				local var_120_31 = var_120_29 <= 0 and var_120_25 or var_120_25 * (var_120_30 / var_120_29)

				if var_120_31 > 0 and var_120_25 < var_120_31 then
					arg_117_1.talkMaxDuration = var_120_31

					if var_120_31 + var_120_24 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_24
					end
				end

				arg_117_1.text_.text = var_120_28
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_32 = math.max(var_120_25, arg_117_1.talkMaxDuration)

			if var_120_24 <= arg_117_1.time_ and arg_117_1.time_ < var_120_24 + var_120_32 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_24) / var_120_32

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_24 + var_120_32 and arg_117_1.time_ < var_120_24 + var_120_32 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play419101029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 419101029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play419101030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1046ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1046ui_story == nil then
				arg_121_1.var_.characterEffect1046ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1046ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1046ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1046ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1046ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.525

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(419101029)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 21
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play419101030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 419101030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play419101031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10102ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10102ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -0.985, -6.275)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10102ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10102ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10102ui_story == nil then
				arg_125_1.var_.characterEffect10102ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect10102ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10102ui_story then
				arg_125_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_128_15 = arg_125_1.actors_["1046ui_story"].transform
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.var_.moveOldPos1046ui_story = var_128_15.localPosition
			end

			local var_128_17 = 0.001

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17
				local var_128_19 = Vector3.New(0, 100, 0)

				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1046ui_story, var_128_19, var_128_18)

				local var_128_20 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_20.x, var_128_20.y, var_128_20.z)

				local var_128_21 = var_128_15.localEulerAngles

				var_128_21.z = 0
				var_128_21.x = 0
				var_128_15.localEulerAngles = var_128_21
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)

				local var_128_22 = manager.ui.mainCamera.transform.position - var_128_15.position

				var_128_15.forward = Vector3.New(var_128_22.x, var_128_22.y, var_128_22.z)

				local var_128_23 = var_128_15.localEulerAngles

				var_128_23.z = 0
				var_128_23.x = 0
				var_128_15.localEulerAngles = var_128_23
			end

			local var_128_24 = 0
			local var_128_25 = 0.7

			if var_128_24 < arg_125_1.time_ and arg_125_1.time_ <= var_128_24 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_26 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_27 = arg_125_1:GetWordFromCfg(419101030)
				local var_128_28 = arg_125_1:FormatText(var_128_27.content)

				arg_125_1.text_.text = var_128_28

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_29 = 28
				local var_128_30 = utf8.len(var_128_28)
				local var_128_31 = var_128_29 <= 0 and var_128_25 or var_128_25 * (var_128_30 / var_128_29)

				if var_128_31 > 0 and var_128_25 < var_128_31 then
					arg_125_1.talkMaxDuration = var_128_31

					if var_128_31 + var_128_24 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_24
					end
				end

				arg_125_1.text_.text = var_128_28
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_32 = math.max(var_128_25, arg_125_1.talkMaxDuration)

			if var_128_24 <= arg_125_1.time_ and arg_125_1.time_ < var_128_24 + var_128_32 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_24) / var_128_32

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_24 + var_128_32 and arg_125_1.time_ < var_128_24 + var_128_32 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play419101031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 419101031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play419101032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10102ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10102ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, 100, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10102ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, 100, 0)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1045ui_story"].transform
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.var_.moveOldPos1045ui_story = var_132_9.localPosition
			end

			local var_132_11 = 0.001

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11
				local var_132_13 = Vector3.New(0, -1, -6.05)

				var_132_9.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1045ui_story, var_132_13, var_132_12)

				local var_132_14 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_14.x, var_132_14.y, var_132_14.z)

				local var_132_15 = var_132_9.localEulerAngles

				var_132_15.z = 0
				var_132_15.x = 0
				var_132_9.localEulerAngles = var_132_15
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 then
				var_132_9.localPosition = Vector3.New(0, -1, -6.05)

				local var_132_16 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_16.x, var_132_16.y, var_132_16.z)

				local var_132_17 = var_132_9.localEulerAngles

				var_132_17.z = 0
				var_132_17.x = 0
				var_132_9.localEulerAngles = var_132_17
			end

			local var_132_18 = arg_129_1.actors_["1045ui_story"]
			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect1045ui_story == nil then
				arg_129_1.var_.characterEffect1045ui_story = var_132_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_20 = 0.200000002980232

			if var_132_19 <= arg_129_1.time_ and arg_129_1.time_ < var_132_19 + var_132_20 and not isNil(var_132_18) then
				local var_132_21 = (arg_129_1.time_ - var_132_19) / var_132_20

				if arg_129_1.var_.characterEffect1045ui_story and not isNil(var_132_18) then
					arg_129_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_19 + var_132_20 and arg_129_1.time_ < var_132_19 + var_132_20 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect1045ui_story then
				arg_129_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_132_22 = arg_129_1.actors_["10102ui_story"]
			local var_132_23 = 0

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.characterEffect10102ui_story == nil then
				arg_129_1.var_.characterEffect10102ui_story = var_132_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_24 = 0.200000002980232

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_24 and not isNil(var_132_22) then
				local var_132_25 = (arg_129_1.time_ - var_132_23) / var_132_24

				if arg_129_1.var_.characterEffect10102ui_story and not isNil(var_132_22) then
					local var_132_26 = Mathf.Lerp(0, 0.5, var_132_25)

					arg_129_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10102ui_story.fillRatio = var_132_26
				end
			end

			if arg_129_1.time_ >= var_132_23 + var_132_24 and arg_129_1.time_ < var_132_23 + var_132_24 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.characterEffect10102ui_story then
				local var_132_27 = 0.5

				arg_129_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10102ui_story.fillRatio = var_132_27
			end

			local var_132_28 = 0

			if var_132_28 < arg_129_1.time_ and arg_129_1.time_ <= var_132_28 + arg_132_0 then
				arg_129_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action5_2")
			end

			local var_132_29 = 0
			local var_132_30 = 0.725

			if var_132_29 < arg_129_1.time_ and arg_129_1.time_ <= var_132_29 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_31 = arg_129_1:FormatText(StoryNameCfg[1202].name)

				arg_129_1.leftNameTxt_.text = var_132_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_32 = arg_129_1:GetWordFromCfg(419101031)
				local var_132_33 = arg_129_1:FormatText(var_132_32.content)

				arg_129_1.text_.text = var_132_33

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_34 = 23
				local var_132_35 = utf8.len(var_132_33)
				local var_132_36 = var_132_34 <= 0 and var_132_30 or var_132_30 * (var_132_35 / var_132_34)

				if var_132_36 > 0 and var_132_30 < var_132_36 then
					arg_129_1.talkMaxDuration = var_132_36

					if var_132_36 + var_132_29 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_36 + var_132_29
					end
				end

				arg_129_1.text_.text = var_132_33
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_37 = math.max(var_132_30, arg_129_1.talkMaxDuration)

			if var_132_29 <= arg_129_1.time_ and arg_129_1.time_ < var_132_29 + var_132_37 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_29) / var_132_37

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_29 + var_132_37 and arg_129_1.time_ < var_132_29 + var_132_37 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play419101032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 419101032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play419101033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.65

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1202].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(419101032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play419101033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 419101033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play419101034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1045ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1045ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(-0.7, -1, -6.05)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1045ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1046ui_story"].transform
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.var_.moveOldPos1046ui_story = var_140_9.localPosition
			end

			local var_140_11 = 0.001

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11
				local var_140_13 = Vector3.New(0.7, -1, -6.1)

				var_140_9.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1046ui_story, var_140_13, var_140_12)

				local var_140_14 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_14.x, var_140_14.y, var_140_14.z)

				local var_140_15 = var_140_9.localEulerAngles

				var_140_15.z = 0
				var_140_15.x = 0
				var_140_9.localEulerAngles = var_140_15
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 then
				var_140_9.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_140_16 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_16.x, var_140_16.y, var_140_16.z)

				local var_140_17 = var_140_9.localEulerAngles

				var_140_17.z = 0
				var_140_17.x = 0
				var_140_9.localEulerAngles = var_140_17
			end

			local var_140_18 = arg_137_1.actors_["1046ui_story"]
			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.characterEffect1046ui_story == nil then
				arg_137_1.var_.characterEffect1046ui_story = var_140_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_20 = 0.200000002980232

			if var_140_19 <= arg_137_1.time_ and arg_137_1.time_ < var_140_19 + var_140_20 and not isNil(var_140_18) then
				local var_140_21 = (arg_137_1.time_ - var_140_19) / var_140_20

				if arg_137_1.var_.characterEffect1046ui_story and not isNil(var_140_18) then
					arg_137_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_19 + var_140_20 and arg_137_1.time_ < var_140_19 + var_140_20 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.characterEffect1046ui_story then
				arg_137_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_140_22 = arg_137_1.actors_["1045ui_story"]
			local var_140_23 = 0

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.characterEffect1045ui_story == nil then
				arg_137_1.var_.characterEffect1045ui_story = var_140_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_24 = 0.200000002980232

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 and not isNil(var_140_22) then
				local var_140_25 = (arg_137_1.time_ - var_140_23) / var_140_24

				if arg_137_1.var_.characterEffect1045ui_story and not isNil(var_140_22) then
					local var_140_26 = Mathf.Lerp(0, 0.5, var_140_25)

					arg_137_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1045ui_story.fillRatio = var_140_26
				end
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.characterEffect1045ui_story then
				local var_140_27 = 0.5

				arg_137_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1045ui_story.fillRatio = var_140_27
			end

			local var_140_28 = 0

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				arg_137_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_2")
			end

			local var_140_29 = 0

			if var_140_29 < arg_137_1.time_ and arg_137_1.time_ <= var_140_29 + arg_140_0 then
				arg_137_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_140_30 = 0
			local var_140_31 = 0.775

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_32 = arg_137_1:FormatText(StoryNameCfg[1207].name)

				arg_137_1.leftNameTxt_.text = var_140_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_33 = arg_137_1:GetWordFromCfg(419101033)
				local var_140_34 = arg_137_1:FormatText(var_140_33.content)

				arg_137_1.text_.text = var_140_34

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_35 = 31
				local var_140_36 = utf8.len(var_140_34)
				local var_140_37 = var_140_35 <= 0 and var_140_31 or var_140_31 * (var_140_36 / var_140_35)

				if var_140_37 > 0 and var_140_31 < var_140_37 then
					arg_137_1.talkMaxDuration = var_140_37

					if var_140_37 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_37 + var_140_30
					end
				end

				arg_137_1.text_.text = var_140_34
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_38 = math.max(var_140_31, arg_137_1.talkMaxDuration)

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_38 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_38

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_38 and arg_137_1.time_ < var_140_30 + var_140_38 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play419101034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 419101034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play419101035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.425

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[1207].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(419101034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 17
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play419101035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 419101035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play419101036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1045ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1045ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1045ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1046ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos1046ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1046ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = arg_145_1.actors_["1046ui_story"]
			local var_148_19 = 0

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1046ui_story == nil then
				arg_145_1.var_.characterEffect1046ui_story = var_148_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_20 = 0.200000002980232

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_20 and not isNil(var_148_18) then
				local var_148_21 = (arg_145_1.time_ - var_148_19) / var_148_20

				if arg_145_1.var_.characterEffect1046ui_story and not isNil(var_148_18) then
					local var_148_22 = Mathf.Lerp(0, 0.5, var_148_21)

					arg_145_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1046ui_story.fillRatio = var_148_22
				end
			end

			if arg_145_1.time_ >= var_148_19 + var_148_20 and arg_145_1.time_ < var_148_19 + var_148_20 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1046ui_story then
				local var_148_23 = 0.5

				arg_145_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1046ui_story.fillRatio = var_148_23
			end

			local var_148_24 = 0.05
			local var_148_25 = 1

			if var_148_24 < arg_145_1.time_ and arg_145_1.time_ <= var_148_24 + arg_148_0 then
				local var_148_26 = "play"
				local var_148_27 = "effect"

				arg_145_1:AudioAction(var_148_26, var_148_27, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_148_28 = 0
			local var_148_29 = 0.5

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_30 = arg_145_1:GetWordFromCfg(419101035)
				local var_148_31 = arg_145_1:FormatText(var_148_30.content)

				arg_145_1.text_.text = var_148_31

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_32 = 20
				local var_148_33 = utf8.len(var_148_31)
				local var_148_34 = var_148_32 <= 0 and var_148_29 or var_148_29 * (var_148_33 / var_148_32)

				if var_148_34 > 0 and var_148_29 < var_148_34 then
					arg_145_1.talkMaxDuration = var_148_34

					if var_148_34 + var_148_28 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_34 + var_148_28
					end
				end

				arg_145_1.text_.text = var_148_31
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_35 = math.max(var_148_29, arg_145_1.talkMaxDuration)

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_35 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_28) / var_148_35

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_28 + var_148_35 and arg_145_1.time_ < var_148_28 + var_148_35 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play419101036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 419101036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play419101037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1045ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1045ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, -1, -6.05)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1045ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1045ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1045ui_story == nil then
				arg_149_1.var_.characterEffect1045ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1045ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1045ui_story then
				arg_149_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action1_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_152_15 = 0
			local var_152_16 = 0.225

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_17 = arg_149_1:FormatText(StoryNameCfg[1202].name)

				arg_149_1.leftNameTxt_.text = var_152_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:GetWordFromCfg(419101036)
				local var_152_19 = arg_149_1:FormatText(var_152_18.content)

				arg_149_1.text_.text = var_152_19

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 9
				local var_152_21 = utf8.len(var_152_19)
				local var_152_22 = var_152_20 <= 0 and var_152_16 or var_152_16 * (var_152_21 / var_152_20)

				if var_152_22 > 0 and var_152_16 < var_152_22 then
					arg_149_1.talkMaxDuration = var_152_22

					if var_152_22 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_19
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_23 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_23 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_23

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_23 and arg_149_1.time_ < var_152_15 + var_152_23 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play419101037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 419101037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play419101038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1045ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1045ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(-0.7, -1, -6.05)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1045ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = "1095ui_story"

			if arg_153_1.actors_[var_156_9] == nil then
				local var_156_10 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_156_10) then
					local var_156_11 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_153_1.stage_.transform)

					var_156_11.name = var_156_9
					var_156_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_153_1.actors_[var_156_9] = var_156_11

					local var_156_12 = var_156_11:GetComponentInChildren(typeof(CharacterEffect))

					var_156_12.enabled = true

					local var_156_13 = GameObjectTools.GetOrAddComponent(var_156_11, typeof(DynamicBoneHelper))

					if var_156_13 then
						var_156_13:EnableDynamicBone(false)
					end

					arg_153_1:ShowWeapon(var_156_12.transform, false)

					arg_153_1.var_[var_156_9 .. "Animator"] = var_156_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_153_1.var_[var_156_9 .. "Animator"].applyRootMotion = true
					arg_153_1.var_[var_156_9 .. "LipSync"] = var_156_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_156_14 = arg_153_1.actors_["1095ui_story"].transform
			local var_156_15 = 0

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.var_.moveOldPos1095ui_story = var_156_14.localPosition
			end

			local var_156_16 = 0.001

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_16 then
				local var_156_17 = (arg_153_1.time_ - var_156_15) / var_156_16
				local var_156_18 = Vector3.New(0.7, -0.98, -6.1)

				var_156_14.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1095ui_story, var_156_18, var_156_17)

				local var_156_19 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_19.x, var_156_19.y, var_156_19.z)

				local var_156_20 = var_156_14.localEulerAngles

				var_156_20.z = 0
				var_156_20.x = 0
				var_156_14.localEulerAngles = var_156_20
			end

			if arg_153_1.time_ >= var_156_15 + var_156_16 and arg_153_1.time_ < var_156_15 + var_156_16 + arg_156_0 then
				var_156_14.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_156_21 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_21.x, var_156_21.y, var_156_21.z)

				local var_156_22 = var_156_14.localEulerAngles

				var_156_22.z = 0
				var_156_22.x = 0
				var_156_14.localEulerAngles = var_156_22
			end

			local var_156_23 = arg_153_1.actors_["1095ui_story"]
			local var_156_24 = 0

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 and not isNil(var_156_23) and arg_153_1.var_.characterEffect1095ui_story == nil then
				arg_153_1.var_.characterEffect1095ui_story = var_156_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_25 = 0.200000002980232

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_25 and not isNil(var_156_23) then
				local var_156_26 = (arg_153_1.time_ - var_156_24) / var_156_25

				if arg_153_1.var_.characterEffect1095ui_story and not isNil(var_156_23) then
					arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_24 + var_156_25 and arg_153_1.time_ < var_156_24 + var_156_25 + arg_156_0 and not isNil(var_156_23) and arg_153_1.var_.characterEffect1095ui_story then
				arg_153_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_156_27 = arg_153_1.actors_["1045ui_story"]
			local var_156_28 = 0

			if var_156_28 < arg_153_1.time_ and arg_153_1.time_ <= var_156_28 + arg_156_0 and not isNil(var_156_27) and arg_153_1.var_.characterEffect1045ui_story == nil then
				arg_153_1.var_.characterEffect1045ui_story = var_156_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_29 = 0.200000002980232

			if var_156_28 <= arg_153_1.time_ and arg_153_1.time_ < var_156_28 + var_156_29 and not isNil(var_156_27) then
				local var_156_30 = (arg_153_1.time_ - var_156_28) / var_156_29

				if arg_153_1.var_.characterEffect1045ui_story and not isNil(var_156_27) then
					local var_156_31 = Mathf.Lerp(0, 0.5, var_156_30)

					arg_153_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1045ui_story.fillRatio = var_156_31
				end
			end

			if arg_153_1.time_ >= var_156_28 + var_156_29 and arg_153_1.time_ < var_156_28 + var_156_29 + arg_156_0 and not isNil(var_156_27) and arg_153_1.var_.characterEffect1045ui_story then
				local var_156_32 = 0.5

				arg_153_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1045ui_story.fillRatio = var_156_32
			end

			local var_156_33 = 0

			if var_156_33 < arg_153_1.time_ and arg_153_1.time_ <= var_156_33 + arg_156_0 then
				arg_153_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_156_34 = 0

			if var_156_34 < arg_153_1.time_ and arg_153_1.time_ <= var_156_34 + arg_156_0 then
				arg_153_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_156_35 = arg_153_1.actors_["1095ui_story"]
			local var_156_36 = 0

			if var_156_36 < arg_153_1.time_ and arg_153_1.time_ <= var_156_36 + arg_156_0 then
				if arg_153_1.var_.characterEffect1095ui_story == nil then
					arg_153_1.var_.characterEffect1095ui_story = var_156_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_156_37 = arg_153_1.var_.characterEffect1095ui_story

				var_156_37.imageEffect:turnOff()

				var_156_37.interferenceEffect.enabled = true
				var_156_37.interferenceEffect.noise = 0.001
				var_156_37.interferenceEffect.simTimeScale = 1
				var_156_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_156_38 = arg_153_1.actors_["1095ui_story"]
			local var_156_39 = 0
			local var_156_40 = 0.2

			if var_156_39 < arg_153_1.time_ and arg_153_1.time_ <= var_156_39 + arg_156_0 then
				if arg_153_1.var_.characterEffect1095ui_story == nil then
					arg_153_1.var_.characterEffect1095ui_story = var_156_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_153_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)
			end

			local var_156_41 = 0
			local var_156_42 = 0.625

			if var_156_41 < arg_153_1.time_ and arg_153_1.time_ <= var_156_41 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_43 = arg_153_1:FormatText(StoryNameCfg[471].name)

				arg_153_1.leftNameTxt_.text = var_156_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_44 = arg_153_1:GetWordFromCfg(419101037)
				local var_156_45 = arg_153_1:FormatText(var_156_44.content)

				arg_153_1.text_.text = var_156_45

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_46 = 25
				local var_156_47 = utf8.len(var_156_45)
				local var_156_48 = var_156_46 <= 0 and var_156_42 or var_156_42 * (var_156_47 / var_156_46)

				if var_156_48 > 0 and var_156_42 < var_156_48 then
					arg_153_1.talkMaxDuration = var_156_48

					if var_156_48 + var_156_41 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_48 + var_156_41
					end
				end

				arg_153_1.text_.text = var_156_45
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_49 = math.max(var_156_42, arg_153_1.talkMaxDuration)

			if var_156_41 <= arg_153_1.time_ and arg_153_1.time_ < var_156_41 + var_156_49 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_41) / var_156_49

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_41 + var_156_49 and arg_153_1.time_ < var_156_41 + var_156_49 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play419101038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 419101038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play419101039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1045ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1045ui_story == nil then
				arg_157_1.var_.characterEffect1045ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1045ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1045ui_story then
				arg_157_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1095ui_story"]
			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1095ui_story == nil then
				arg_157_1.var_.characterEffect1095ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 and not isNil(var_160_4) then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6

				if arg_157_1.var_.characterEffect1095ui_story and not isNil(var_160_4) then
					local var_160_8 = Mathf.Lerp(0, 0.5, var_160_7)

					arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1095ui_story.fillRatio = var_160_8
				end
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1095ui_story then
				local var_160_9 = 0.5

				arg_157_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1095ui_story.fillRatio = var_160_9
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action5_1")
			end

			local var_160_11 = 0

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_160_12 = 0
			local var_160_13 = 0.225

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[1202].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(419101038)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 9
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_20 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_20 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_20

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_20 and arg_157_1.time_ < var_160_12 + var_160_20 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play419101039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 419101039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play419101040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1095ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1095ui_story == nil then
				arg_161_1.var_.characterEffect1095ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1095ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1095ui_story then
				arg_161_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1045ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1045ui_story == nil then
				arg_161_1.var_.characterEffect1045ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect1045ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1045ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1045ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1045ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0
			local var_164_11 = 0.7

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_12 = arg_161_1:FormatText(StoryNameCfg[471].name)

				arg_161_1.leftNameTxt_.text = var_164_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(419101039)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 28
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_11 or var_164_11 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_11 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_18 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_18 and arg_161_1.time_ < var_164_10 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play419101040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 419101040
		arg_165_1.duration_ = 9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play419101041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "I03"

			if arg_165_1.bgs_[var_168_0] == nil then
				local var_168_1 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_168_0)
				var_168_1.name = var_168_0
				var_168_1.transform.parent = arg_165_1.stage_.transform
				var_168_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_[var_168_0] = var_168_1
			end

			local var_168_2 = 2

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				local var_168_3 = manager.ui.mainCamera.transform.localPosition
				local var_168_4 = Vector3.New(0, 0, 10) + Vector3.New(var_168_3.x, var_168_3.y, 0)
				local var_168_5 = arg_165_1.bgs_.I03

				var_168_5.transform.localPosition = var_168_4
				var_168_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_6 = var_168_5:GetComponent("SpriteRenderer")

				if var_168_6 and var_168_6.sprite then
					local var_168_7 = (var_168_5.transform.localPosition - var_168_3).z
					local var_168_8 = manager.ui.mainCameraCom_
					local var_168_9 = 2 * var_168_7 * Mathf.Tan(var_168_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_168_10 = var_168_9 * var_168_8.aspect
					local var_168_11 = var_168_6.sprite.bounds.size.x
					local var_168_12 = var_168_6.sprite.bounds.size.y
					local var_168_13 = var_168_10 / var_168_11
					local var_168_14 = var_168_9 / var_168_12
					local var_168_15 = var_168_14 < var_168_13 and var_168_13 or var_168_14

					var_168_5.transform.localScale = Vector3.New(var_168_15, var_168_15, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "I03" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_16 = 3.999999999999

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_17 = 0.3

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_18 = 0

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_19 = 2

			if var_168_18 <= arg_165_1.time_ and arg_165_1.time_ < var_168_18 + var_168_19 then
				local var_168_20 = (arg_165_1.time_ - var_168_18) / var_168_19
				local var_168_21 = Color.New(0, 0, 0)

				var_168_21.a = Mathf.Lerp(0, 1, var_168_20)
				arg_165_1.mask_.color = var_168_21
			end

			if arg_165_1.time_ >= var_168_18 + var_168_19 and arg_165_1.time_ < var_168_18 + var_168_19 + arg_168_0 then
				local var_168_22 = Color.New(0, 0, 0)

				var_168_22.a = 1
				arg_165_1.mask_.color = var_168_22
			end

			local var_168_23 = 2

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_24 = 2

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 then
				local var_168_25 = (arg_165_1.time_ - var_168_23) / var_168_24
				local var_168_26 = Color.New(0, 0, 0)

				var_168_26.a = Mathf.Lerp(1, 0, var_168_25)
				arg_165_1.mask_.color = var_168_26
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 then
				local var_168_27 = Color.New(0, 0, 0)
				local var_168_28 = 0

				arg_165_1.mask_.enabled = false
				var_168_27.a = var_168_28
				arg_165_1.mask_.color = var_168_27
			end

			local var_168_29 = arg_165_1.actors_["1045ui_story"].transform
			local var_168_30 = 2

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.var_.moveOldPos1045ui_story = var_168_29.localPosition
			end

			local var_168_31 = 0.001

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_31 then
				local var_168_32 = (arg_165_1.time_ - var_168_30) / var_168_31
				local var_168_33 = Vector3.New(0, 100, 0)

				var_168_29.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1045ui_story, var_168_33, var_168_32)

				local var_168_34 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_34.x, var_168_34.y, var_168_34.z)

				local var_168_35 = var_168_29.localEulerAngles

				var_168_35.z = 0
				var_168_35.x = 0
				var_168_29.localEulerAngles = var_168_35
			end

			if arg_165_1.time_ >= var_168_30 + var_168_31 and arg_165_1.time_ < var_168_30 + var_168_31 + arg_168_0 then
				var_168_29.localPosition = Vector3.New(0, 100, 0)

				local var_168_36 = manager.ui.mainCamera.transform.position - var_168_29.position

				var_168_29.forward = Vector3.New(var_168_36.x, var_168_36.y, var_168_36.z)

				local var_168_37 = var_168_29.localEulerAngles

				var_168_37.z = 0
				var_168_37.x = 0
				var_168_29.localEulerAngles = var_168_37
			end

			local var_168_38 = arg_165_1.actors_["1095ui_story"].transform
			local var_168_39 = 2

			if var_168_39 < arg_165_1.time_ and arg_165_1.time_ <= var_168_39 + arg_168_0 then
				arg_165_1.var_.moveOldPos1095ui_story = var_168_38.localPosition
			end

			local var_168_40 = 0.001

			if var_168_39 <= arg_165_1.time_ and arg_165_1.time_ < var_168_39 + var_168_40 then
				local var_168_41 = (arg_165_1.time_ - var_168_39) / var_168_40
				local var_168_42 = Vector3.New(0, 100, 0)

				var_168_38.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1095ui_story, var_168_42, var_168_41)

				local var_168_43 = manager.ui.mainCamera.transform.position - var_168_38.position

				var_168_38.forward = Vector3.New(var_168_43.x, var_168_43.y, var_168_43.z)

				local var_168_44 = var_168_38.localEulerAngles

				var_168_44.z = 0
				var_168_44.x = 0
				var_168_38.localEulerAngles = var_168_44
			end

			if arg_165_1.time_ >= var_168_39 + var_168_40 and arg_165_1.time_ < var_168_39 + var_168_40 + arg_168_0 then
				var_168_38.localPosition = Vector3.New(0, 100, 0)

				local var_168_45 = manager.ui.mainCamera.transform.position - var_168_38.position

				var_168_38.forward = Vector3.New(var_168_45.x, var_168_45.y, var_168_45.z)

				local var_168_46 = var_168_38.localEulerAngles

				var_168_46.z = 0
				var_168_46.x = 0
				var_168_38.localEulerAngles = var_168_46
			end

			local var_168_47 = arg_165_1.actors_["1095ui_story"]
			local var_168_48 = 2.03400000184774

			if var_168_48 < arg_165_1.time_ and arg_165_1.time_ <= var_168_48 + arg_168_0 then
				if arg_165_1.var_.characterEffect1095ui_story == nil then
					arg_165_1.var_.characterEffect1095ui_story = var_168_47:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_168_49 = arg_165_1.var_.characterEffect1095ui_story

				var_168_49.imageEffect:turnOff()

				var_168_49.interferenceEffect.enabled = false
				var_168_49.interferenceEffect.noise = 0.001
				var_168_49.interferenceEffect.simTimeScale = 1
				var_168_49.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_168_50 = arg_165_1.actors_["1095ui_story"]
			local var_168_51 = 2.03400000184774
			local var_168_52 = 0.2

			if var_168_51 < arg_165_1.time_ and arg_165_1.time_ <= var_168_51 + arg_168_0 then
				if arg_165_1.var_.characterEffect1095ui_story == nil then
					arg_165_1.var_.characterEffect1095ui_story = var_168_50:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_165_1.var_.characterEffect1095ui_story.imageEffect:turnOff()
			end

			local var_168_53 = 0.533333333333333
			local var_168_54 = 1

			if var_168_53 < arg_165_1.time_ and arg_165_1.time_ <= var_168_53 + arg_168_0 then
				local var_168_55 = "stop"
				local var_168_56 = "effect"

				arg_165_1:AudioAction(var_168_55, var_168_56, "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			local var_168_57 = 1.66666666666667
			local var_168_58 = 1

			if var_168_57 < arg_165_1.time_ and arg_165_1.time_ <= var_168_57 + arg_168_0 then
				local var_168_59 = "play"
				local var_168_60 = "effect"

				arg_165_1:AudioAction(var_168_59, var_168_60, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_61 = 3.999999999999
			local var_168_62 = 1.075

			if var_168_61 < arg_165_1.time_ and arg_165_1.time_ <= var_168_61 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_63 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_63:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_64 = arg_165_1:GetWordFromCfg(419101040)
				local var_168_65 = arg_165_1:FormatText(var_168_64.content)

				arg_165_1.text_.text = var_168_65

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_66 = 43
				local var_168_67 = utf8.len(var_168_65)
				local var_168_68 = var_168_66 <= 0 and var_168_62 or var_168_62 * (var_168_67 / var_168_66)

				if var_168_68 > 0 and var_168_62 < var_168_68 then
					arg_165_1.talkMaxDuration = var_168_68
					var_168_61 = var_168_61 + 0.3

					if var_168_68 + var_168_61 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_68 + var_168_61
					end
				end

				arg_165_1.text_.text = var_168_65
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_69 = var_168_61 + 0.3
			local var_168_70 = math.max(var_168_62, arg_165_1.talkMaxDuration)

			if var_168_69 <= arg_165_1.time_ and arg_165_1.time_ < var_168_69 + var_168_70 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_69) / var_168_70

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_69 + var_168_70 and arg_165_1.time_ < var_168_69 + var_168_70 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play419101041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 419101041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play419101042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.825

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(419101041)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 33
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play419101042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 419101042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play419101043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.45

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(419101042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 18
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play419101043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 419101043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play419101044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_182_1 = arg_179_1.actors_["1045ui_story"].transform
			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.var_.moveOldPos1045ui_story = var_182_1.localPosition
			end

			local var_182_3 = 0.001

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_2) / var_182_3
				local var_182_5 = Vector3.New(0, -1, -6.05)

				var_182_1.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1045ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_1.position

				var_182_1.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_1.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_1.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_2 + var_182_3 and arg_179_1.time_ < var_182_2 + var_182_3 + arg_182_0 then
				var_182_1.localPosition = Vector3.New(0, -1, -6.05)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_1.position

				var_182_1.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_1.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_1.localEulerAngles = var_182_9
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action1_1")
			end

			local var_182_11 = arg_179_1.actors_["1045ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1045ui_story == nil then
				arg_179_1.var_.characterEffect1045ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect1045ui_story and not isNil(var_182_11) then
					arg_179_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect1045ui_story then
				arg_179_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_182_15 = 0
			local var_182_16 = 0.375

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[1202].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(419101043)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 15
				local var_182_21 = utf8.len(var_182_19)
				local var_182_22 = var_182_20 <= 0 and var_182_16 or var_182_16 * (var_182_21 / var_182_20)

				if var_182_22 > 0 and var_182_16 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22

					if var_182_22 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_23 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_23 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_23

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_23 and arg_179_1.time_ < var_182_15 + var_182_23 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419101044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 419101044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play419101045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1045ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1045ui_story == nil then
				arg_183_1.var_.characterEffect1045ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1045ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1045ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1045ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1045ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.425

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

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(419101044)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 17
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
	Play419101045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 419101045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play419101046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1045ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1045ui_story == nil then
				arg_187_1.var_.characterEffect1045ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1045ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1045ui_story then
				arg_187_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["1045ui_story"].transform
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.var_.moveOldPos1045ui_story = var_190_4.localPosition
			end

			local var_190_6 = 0.001

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 then
				local var_190_7 = (arg_187_1.time_ - var_190_5) / var_190_6
				local var_190_8 = Vector3.New(0, -1, -6.05)

				var_190_4.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1045ui_story, var_190_8, var_190_7)

				local var_190_9 = manager.ui.mainCamera.transform.position - var_190_4.position

				var_190_4.forward = Vector3.New(var_190_9.x, var_190_9.y, var_190_9.z)

				local var_190_10 = var_190_4.localEulerAngles

				var_190_10.z = 0
				var_190_10.x = 0
				var_190_4.localEulerAngles = var_190_10
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 then
				var_190_4.localPosition = Vector3.New(0, -1, -6.05)

				local var_190_11 = manager.ui.mainCamera.transform.position - var_190_4.position

				var_190_4.forward = Vector3.New(var_190_11.x, var_190_11.y, var_190_11.z)

				local var_190_12 = var_190_4.localEulerAngles

				var_190_12.z = 0
				var_190_12.x = 0
				var_190_4.localEulerAngles = var_190_12
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action9_1")
			end

			local var_190_14 = 0
			local var_190_15 = 0.725

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_16 = arg_187_1:FormatText(StoryNameCfg[1202].name)

				arg_187_1.leftNameTxt_.text = var_190_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_17 = arg_187_1:GetWordFromCfg(419101045)
				local var_190_18 = arg_187_1:FormatText(var_190_17.content)

				arg_187_1.text_.text = var_190_18

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_19 = 29
				local var_190_20 = utf8.len(var_190_18)
				local var_190_21 = var_190_19 <= 0 and var_190_15 or var_190_15 * (var_190_20 / var_190_19)

				if var_190_21 > 0 and var_190_15 < var_190_21 then
					arg_187_1.talkMaxDuration = var_190_21

					if var_190_21 + var_190_14 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_21 + var_190_14
					end
				end

				arg_187_1.text_.text = var_190_18
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_15, arg_187_1.talkMaxDuration)

			if var_190_14 <= arg_187_1.time_ and arg_187_1.time_ < var_190_14 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_14) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_14 + var_190_22 and arg_187_1.time_ < var_190_14 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419101046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 419101046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play419101047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1045ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1045ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1045ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1046ui_story"].transform
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.var_.moveOldPos1046ui_story = var_194_9.localPosition
			end

			local var_194_11 = 0.001

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11
				local var_194_13 = Vector3.New(0, -1, -6.1)

				var_194_9.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1046ui_story, var_194_13, var_194_12)

				local var_194_14 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_14.x, var_194_14.y, var_194_14.z)

				local var_194_15 = var_194_9.localEulerAngles

				var_194_15.z = 0
				var_194_15.x = 0
				var_194_9.localEulerAngles = var_194_15
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 then
				var_194_9.localPosition = Vector3.New(0, -1, -6.1)

				local var_194_16 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_16.x, var_194_16.y, var_194_16.z)

				local var_194_17 = var_194_9.localEulerAngles

				var_194_17.z = 0
				var_194_17.x = 0
				var_194_9.localEulerAngles = var_194_17
			end

			local var_194_18 = arg_191_1.actors_["1046ui_story"]
			local var_194_19 = 0

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect1046ui_story == nil then
				arg_191_1.var_.characterEffect1046ui_story = var_194_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_20 = 0.200000002980232

			if var_194_19 <= arg_191_1.time_ and arg_191_1.time_ < var_194_19 + var_194_20 and not isNil(var_194_18) then
				local var_194_21 = (arg_191_1.time_ - var_194_19) / var_194_20

				if arg_191_1.var_.characterEffect1046ui_story and not isNil(var_194_18) then
					arg_191_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_19 + var_194_20 and arg_191_1.time_ < var_194_19 + var_194_20 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect1046ui_story then
				arg_191_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_194_22 = arg_191_1.actors_["1045ui_story"]
			local var_194_23 = 0

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 and not isNil(var_194_22) and arg_191_1.var_.characterEffect1045ui_story == nil then
				arg_191_1.var_.characterEffect1045ui_story = var_194_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_24 = 0.200000002980232

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_24 and not isNil(var_194_22) then
				local var_194_25 = (arg_191_1.time_ - var_194_23) / var_194_24

				if arg_191_1.var_.characterEffect1045ui_story and not isNil(var_194_22) then
					local var_194_26 = Mathf.Lerp(0, 0.5, var_194_25)

					arg_191_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1045ui_story.fillRatio = var_194_26
				end
			end

			if arg_191_1.time_ >= var_194_23 + var_194_24 and arg_191_1.time_ < var_194_23 + var_194_24 + arg_194_0 and not isNil(var_194_22) and arg_191_1.var_.characterEffect1045ui_story then
				local var_194_27 = 0.5

				arg_191_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1045ui_story.fillRatio = var_194_27
			end

			local var_194_28 = 0

			if var_194_28 < arg_191_1.time_ and arg_191_1.time_ <= var_194_28 + arg_194_0 then
				arg_191_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_2")
			end

			local var_194_29 = 0

			if var_194_29 < arg_191_1.time_ and arg_191_1.time_ <= var_194_29 + arg_194_0 then
				arg_191_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_194_30 = 0
			local var_194_31 = 0.75

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_32 = arg_191_1:FormatText(StoryNameCfg[1207].name)

				arg_191_1.leftNameTxt_.text = var_194_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_33 = arg_191_1:GetWordFromCfg(419101046)
				local var_194_34 = arg_191_1:FormatText(var_194_33.content)

				arg_191_1.text_.text = var_194_34

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_35 = 30
				local var_194_36 = utf8.len(var_194_34)
				local var_194_37 = var_194_35 <= 0 and var_194_31 or var_194_31 * (var_194_36 / var_194_35)

				if var_194_37 > 0 and var_194_31 < var_194_37 then
					arg_191_1.talkMaxDuration = var_194_37

					if var_194_37 + var_194_30 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_37 + var_194_30
					end
				end

				arg_191_1.text_.text = var_194_34
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_38 = math.max(var_194_31, arg_191_1.talkMaxDuration)

			if var_194_30 <= arg_191_1.time_ and arg_191_1.time_ < var_194_30 + var_194_38 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_30) / var_194_38

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_30 + var_194_38 and arg_191_1.time_ < var_194_30 + var_194_38 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play419101047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 419101047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play419101048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1046ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1046ui_story == nil then
				arg_195_1.var_.characterEffect1046ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1046ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1046ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1046ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1046ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.55

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(419101047)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 22
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play419101048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 419101048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
			arg_199_1.auto_ = false
		end

		function arg_199_1.playNext_(arg_201_0)
			arg_199_1.onStoryFinished_()
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1046ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1046ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1046ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = 0
			local var_202_10 = 0.675

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_11 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_12 = arg_199_1:GetWordFromCfg(419101048)
				local var_202_13 = arg_199_1:FormatText(var_202_12.content)

				arg_199_1.text_.text = var_202_13

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_14 = 27
				local var_202_15 = utf8.len(var_202_13)
				local var_202_16 = var_202_14 <= 0 and var_202_10 or var_202_10 * (var_202_15 / var_202_14)

				if var_202_16 > 0 and var_202_10 < var_202_16 then
					arg_199_1.talkMaxDuration = var_202_16

					if var_202_16 + var_202_9 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_9
					end
				end

				arg_199_1.text_.text = var_202_13
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_17 = math.max(var_202_10, arg_199_1.talkMaxDuration)

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_17 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_9) / var_202_17

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_9 + var_202_17 and arg_199_1.time_ < var_202_9 + var_202_17 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST18a",
		"TextureConfig/Background/I03"
	},
	voices = {}
}
