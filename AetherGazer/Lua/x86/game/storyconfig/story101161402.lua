return {
	Play116142001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116142001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116142002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST07b"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST07b

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
					if iter_4_0 ~= "ST07b" then
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

			local var_4_22 = 1.26666666666667
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_16", "se_story_16_thunder", "")
			end

			local var_4_26 = 1.4

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_27 = 0.6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / var_4_27
				local var_4_29 = Color.New(1, 1, 1)

				var_4_29.a = Mathf.Lerp(1, 0, var_4_28)
				arg_1_1.mask_.color = var_4_29
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				local var_4_30 = Color.New(1, 1, 1)
				local var_4_31 = 0

				arg_1_1.mask_.enabled = false
				var_4_30.a = var_4_31
				arg_1_1.mask_.color = var_4_30
			end

			local var_4_32 = manager.ui.mainCamera.transform
			local var_4_33 = 1.26666666666667

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_32.localPosition
			end

			local var_4_34 = 0.8666668

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_33) / 0.066
				local var_4_36, var_4_37 = math.modf(var_4_35)

				var_4_32.localPosition = Vector3.New(var_4_37 * 0.13, var_4_37 * 0.13, var_4_37 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				var_4_32.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_38 = 2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_39 = 0.133333466666667

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_40 = 0
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 2
			local var_4_47 = 1.5

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 2.2
			local var_4_53 = 0.733333333333333

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 2
			local var_4_59 = 1.125

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(116142001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 45
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_59 or var_4_59 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_59 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_58 = var_4_58 + 0.3

					if var_4_65 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_58 + 0.3
			local var_4_67 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116142002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116142002
		arg_10_1.duration_ = 2.87

		local var_10_0 = {
			zh = 2.866,
			ja = 1.999999999999
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116142003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1028ui_story"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_10_1.stage_.transform)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentInChildren(typeof(CharacterEffect))

					var_13_3.enabled = true

					local var_13_4 = GameObjectTools.GetOrAddComponent(var_13_2, typeof(DynamicBoneHelper))

					if var_13_4 then
						var_13_4:EnableDynamicBone(false)
					end

					arg_10_1:ShowWeapon(var_13_3.transform, false)

					arg_10_1.var_[var_13_0 .. "Animator"] = var_13_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_10_1.var_[var_13_0 .. "Animator"].applyRootMotion = true
					arg_10_1.var_[var_13_0 .. "LipSync"] = var_13_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_13_5 = arg_10_1.actors_["1028ui_story"].transform
			local var_13_6 = 0

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.var_.moveOldPos1028ui_story = var_13_5.localPosition
			end

			local var_13_7 = 0.001

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_7 then
				local var_13_8 = (arg_10_1.time_ - var_13_6) / var_13_7
				local var_13_9 = Vector3.New(-0.7, -0.9, -5.9)

				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1028ui_story, var_13_9, var_13_8)

				local var_13_10 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_10.x, var_13_10.y, var_13_10.z)

				local var_13_11 = var_13_5.localEulerAngles

				var_13_11.z = 0
				var_13_11.x = 0
				var_13_5.localEulerAngles = var_13_11
			end

			if arg_10_1.time_ >= var_13_6 + var_13_7 and arg_10_1.time_ < var_13_6 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_13_12 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_12.x, var_13_12.y, var_13_12.z)

				local var_13_13 = var_13_5.localEulerAngles

				var_13_13.z = 0
				var_13_13.x = 0
				var_13_5.localEulerAngles = var_13_13
			end

			local var_13_14 = 0

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				arg_10_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_13_15 = 0

			if var_13_15 < arg_10_1.time_ and arg_10_1.time_ <= var_13_15 + arg_13_0 then
				arg_10_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_13_16 = arg_10_1.actors_["1028ui_story"]
			local var_13_17 = 0

			if var_13_17 < arg_10_1.time_ and arg_10_1.time_ <= var_13_17 + arg_13_0 and not isNil(var_13_16) and arg_10_1.var_.characterEffect1028ui_story == nil then
				arg_10_1.var_.characterEffect1028ui_story = var_13_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_18 = 0.2

			if var_13_17 <= arg_10_1.time_ and arg_10_1.time_ < var_13_17 + var_13_18 and not isNil(var_13_16) then
				local var_13_19 = (arg_10_1.time_ - var_13_17) / var_13_18

				if arg_10_1.var_.characterEffect1028ui_story and not isNil(var_13_16) then
					arg_10_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_17 + var_13_18 and arg_10_1.time_ < var_13_17 + var_13_18 + arg_13_0 and not isNil(var_13_16) and arg_10_1.var_.characterEffect1028ui_story then
				arg_10_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_13_20 = 0
			local var_13_21 = 0.1

			if var_13_20 < arg_10_1.time_ and arg_10_1.time_ <= var_13_20 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_22 = arg_10_1:FormatText(StoryNameCfg[327].name)

				arg_10_1.leftNameTxt_.text = var_13_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_23 = arg_10_1:GetWordFromCfg(116142002)
				local var_13_24 = arg_10_1:FormatText(var_13_23.content)

				arg_10_1.text_.text = var_13_24

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_25 = 4
				local var_13_26 = utf8.len(var_13_24)
				local var_13_27 = var_13_25 <= 0 and var_13_21 or var_13_21 * (var_13_26 / var_13_25)

				if var_13_27 > 0 and var_13_21 < var_13_27 then
					arg_10_1.talkMaxDuration = var_13_27

					if var_13_27 + var_13_20 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_27 + var_13_20
					end
				end

				arg_10_1.text_.text = var_13_24
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142002", "story_v_out_116142.awb") ~= 0 then
					local var_13_28 = manager.audio:GetVoiceLength("story_v_out_116142", "116142002", "story_v_out_116142.awb") / 1000

					if var_13_28 + var_13_20 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_28 + var_13_20
					end

					if var_13_23.prefab_name ~= "" and arg_10_1.actors_[var_13_23.prefab_name] ~= nil then
						local var_13_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_23.prefab_name].transform, "story_v_out_116142", "116142002", "story_v_out_116142.awb")

						arg_10_1:RecordAudio("116142002", var_13_29)
						arg_10_1:RecordAudio("116142002", var_13_29)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116142", "116142002", "story_v_out_116142.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116142", "116142002", "story_v_out_116142.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_30 = math.max(var_13_21, arg_10_1.talkMaxDuration)

			if var_13_20 <= arg_10_1.time_ and arg_10_1.time_ < var_13_20 + var_13_30 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_20) / var_13_30

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_20 + var_13_30 and arg_10_1.time_ < var_13_20 + var_13_30 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116142003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116142003
		arg_14_1.duration_ = 8.03

		local var_14_0 = {
			zh = 6.866,
			ja = 8.033
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116142004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "1059ui_story"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_14_1.stage_.transform)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentInChildren(typeof(CharacterEffect))

					var_17_3.enabled = true

					local var_17_4 = GameObjectTools.GetOrAddComponent(var_17_2, typeof(DynamicBoneHelper))

					if var_17_4 then
						var_17_4:EnableDynamicBone(false)
					end

					arg_14_1:ShowWeapon(var_17_3.transform, false)

					arg_14_1.var_[var_17_0 .. "Animator"] = var_17_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_14_1.var_[var_17_0 .. "Animator"].applyRootMotion = true
					arg_14_1.var_[var_17_0 .. "LipSync"] = var_17_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_17_5 = arg_14_1.actors_["1059ui_story"].transform
			local var_17_6 = 0

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.var_.moveOldPos1059ui_story = var_17_5.localPosition
			end

			local var_17_7 = 0.001

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_7 then
				local var_17_8 = (arg_14_1.time_ - var_17_6) / var_17_7
				local var_17_9 = Vector3.New(0.7, -1.05, -6)

				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1059ui_story, var_17_9, var_17_8)

				local var_17_10 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_10.x, var_17_10.y, var_17_10.z)

				local var_17_11 = var_17_5.localEulerAngles

				var_17_11.z = 0
				var_17_11.x = 0
				var_17_5.localEulerAngles = var_17_11
			end

			if arg_14_1.time_ >= var_17_6 + var_17_7 and arg_14_1.time_ < var_17_6 + var_17_7 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_17_12 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_12.x, var_17_12.y, var_17_12.z)

				local var_17_13 = var_17_5.localEulerAngles

				var_17_13.z = 0
				var_17_13.x = 0
				var_17_5.localEulerAngles = var_17_13
			end

			local var_17_14 = 0

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_17_15 = 0

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_17_16 = arg_14_1.actors_["1059ui_story"]
			local var_17_17 = 0

			if var_17_17 < arg_14_1.time_ and arg_14_1.time_ <= var_17_17 + arg_17_0 and not isNil(var_17_16) and arg_14_1.var_.characterEffect1059ui_story == nil then
				arg_14_1.var_.characterEffect1059ui_story = var_17_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_18 = 0.2

			if var_17_17 <= arg_14_1.time_ and arg_14_1.time_ < var_17_17 + var_17_18 and not isNil(var_17_16) then
				local var_17_19 = (arg_14_1.time_ - var_17_17) / var_17_18

				if arg_14_1.var_.characterEffect1059ui_story and not isNil(var_17_16) then
					arg_14_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_17 + var_17_18 and arg_14_1.time_ < var_17_17 + var_17_18 + arg_17_0 and not isNil(var_17_16) and arg_14_1.var_.characterEffect1059ui_story then
				arg_14_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_17_20 = arg_14_1.actors_["1028ui_story"]
			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 and not isNil(var_17_20) and arg_14_1.var_.characterEffect1028ui_story == nil then
				arg_14_1.var_.characterEffect1028ui_story = var_17_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_22 = 0.2

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_22 and not isNil(var_17_20) then
				local var_17_23 = (arg_14_1.time_ - var_17_21) / var_17_22

				if arg_14_1.var_.characterEffect1028ui_story and not isNil(var_17_20) then
					local var_17_24 = Mathf.Lerp(0, 0.5, var_17_23)

					arg_14_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1028ui_story.fillRatio = var_17_24
				end
			end

			if arg_14_1.time_ >= var_17_21 + var_17_22 and arg_14_1.time_ < var_17_21 + var_17_22 + arg_17_0 and not isNil(var_17_20) and arg_14_1.var_.characterEffect1028ui_story then
				local var_17_25 = 0.5

				arg_14_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1028ui_story.fillRatio = var_17_25
			end

			local var_17_26 = 0
			local var_17_27 = 0.925

			if var_17_26 < arg_14_1.time_ and arg_14_1.time_ <= var_17_26 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_28 = arg_14_1:FormatText(StoryNameCfg[28].name)

				arg_14_1.leftNameTxt_.text = var_17_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_29 = arg_14_1:GetWordFromCfg(116142003)
				local var_17_30 = arg_14_1:FormatText(var_17_29.content)

				arg_14_1.text_.text = var_17_30

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_31 = 36
				local var_17_32 = utf8.len(var_17_30)
				local var_17_33 = var_17_31 <= 0 and var_17_27 or var_17_27 * (var_17_32 / var_17_31)

				if var_17_33 > 0 and var_17_27 < var_17_33 then
					arg_14_1.talkMaxDuration = var_17_33

					if var_17_33 + var_17_26 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_33 + var_17_26
					end
				end

				arg_14_1.text_.text = var_17_30
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142003", "story_v_out_116142.awb") ~= 0 then
					local var_17_34 = manager.audio:GetVoiceLength("story_v_out_116142", "116142003", "story_v_out_116142.awb") / 1000

					if var_17_34 + var_17_26 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_34 + var_17_26
					end

					if var_17_29.prefab_name ~= "" and arg_14_1.actors_[var_17_29.prefab_name] ~= nil then
						local var_17_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_29.prefab_name].transform, "story_v_out_116142", "116142003", "story_v_out_116142.awb")

						arg_14_1:RecordAudio("116142003", var_17_35)
						arg_14_1:RecordAudio("116142003", var_17_35)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116142", "116142003", "story_v_out_116142.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116142", "116142003", "story_v_out_116142.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_36 = math.max(var_17_27, arg_14_1.talkMaxDuration)

			if var_17_26 <= arg_14_1.time_ and arg_14_1.time_ < var_17_26 + var_17_36 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_26) / var_17_36

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_26 + var_17_36 and arg_14_1.time_ < var_17_26 + var_17_36 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116142004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116142004
		arg_18_1.duration_ = 4.43

		local var_18_0 = {
			zh = 4.433,
			ja = 2.833
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116142005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_21_1 = 0
			local var_21_2 = 0.5

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_3 = arg_18_1:FormatText(StoryNameCfg[28].name)

				arg_18_1.leftNameTxt_.text = var_21_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_4 = arg_18_1:GetWordFromCfg(116142004)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_6 = 20
				local var_21_7 = utf8.len(var_21_5)
				local var_21_8 = var_21_6 <= 0 and var_21_2 or var_21_2 * (var_21_7 / var_21_6)

				if var_21_8 > 0 and var_21_2 < var_21_8 then
					arg_18_1.talkMaxDuration = var_21_8

					if var_21_8 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142004", "story_v_out_116142.awb") ~= 0 then
					local var_21_9 = manager.audio:GetVoiceLength("story_v_out_116142", "116142004", "story_v_out_116142.awb") / 1000

					if var_21_9 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_1
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_116142", "116142004", "story_v_out_116142.awb")

						arg_18_1:RecordAudio("116142004", var_21_10)
						arg_18_1:RecordAudio("116142004", var_21_10)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116142", "116142004", "story_v_out_116142.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116142", "116142004", "story_v_out_116142.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_11 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_11 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_11

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_11 and arg_18_1.time_ < var_21_1 + var_21_11 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play116142005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116142005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116142006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1059ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos1059ui_story = var_25_0.localPosition
			end

			local var_25_2 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2
				local var_25_4 = Vector3.New(0, 100, 0)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1059ui_story, var_25_4, var_25_3)

				local var_25_5 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_5.x, var_25_5.y, var_25_5.z)

				local var_25_6 = var_25_0.localEulerAngles

				var_25_6.z = 0
				var_25_6.x = 0
				var_25_0.localEulerAngles = var_25_6
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0, 100, 0)

				local var_25_7 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_7.x, var_25_7.y, var_25_7.z)

				local var_25_8 = var_25_0.localEulerAngles

				var_25_8.z = 0
				var_25_8.x = 0
				var_25_0.localEulerAngles = var_25_8
			end

			local var_25_9 = arg_22_1.actors_["1028ui_story"].transform
			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1.var_.moveOldPos1028ui_story = var_25_9.localPosition
			end

			local var_25_11 = 0.001

			if var_25_10 <= arg_22_1.time_ and arg_22_1.time_ < var_25_10 + var_25_11 then
				local var_25_12 = (arg_22_1.time_ - var_25_10) / var_25_11
				local var_25_13 = Vector3.New(0, 100, 0)

				var_25_9.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1028ui_story, var_25_13, var_25_12)

				local var_25_14 = manager.ui.mainCamera.transform.position - var_25_9.position

				var_25_9.forward = Vector3.New(var_25_14.x, var_25_14.y, var_25_14.z)

				local var_25_15 = var_25_9.localEulerAngles

				var_25_15.z = 0
				var_25_15.x = 0
				var_25_9.localEulerAngles = var_25_15
			end

			if arg_22_1.time_ >= var_25_10 + var_25_11 and arg_22_1.time_ < var_25_10 + var_25_11 + arg_25_0 then
				var_25_9.localPosition = Vector3.New(0, 100, 0)

				local var_25_16 = manager.ui.mainCamera.transform.position - var_25_9.position

				var_25_9.forward = Vector3.New(var_25_16.x, var_25_16.y, var_25_16.z)

				local var_25_17 = var_25_9.localEulerAngles

				var_25_17.z = 0
				var_25_17.x = 0
				var_25_9.localEulerAngles = var_25_17
			end

			local var_25_18 = 0
			local var_25_19 = 0.7

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_20 = arg_22_1:GetWordFromCfg(116142005)
				local var_25_21 = arg_22_1:FormatText(var_25_20.content)

				arg_22_1.text_.text = var_25_21

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_22 = 28
				local var_25_23 = utf8.len(var_25_21)
				local var_25_24 = var_25_22 <= 0 and var_25_19 or var_25_19 * (var_25_23 / var_25_22)

				if var_25_24 > 0 and var_25_19 < var_25_24 then
					arg_22_1.talkMaxDuration = var_25_24

					if var_25_24 + var_25_18 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_24 + var_25_18
					end
				end

				arg_22_1.text_.text = var_25_21
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_25 = math.max(var_25_19, arg_22_1.talkMaxDuration)

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_25 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_18) / var_25_25

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_18 + var_25_25 and arg_22_1.time_ < var_25_18 + var_25_25 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play116142006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116142006
		arg_26_1.duration_ = 4.8

		local var_26_0 = {
			zh = 2.4,
			ja = 4.8
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116142007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = manager.ui.mainCamera.transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.shakeOldPos = var_29_0.localPosition
			end

			local var_29_2 = 0.6

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / 0.066
				local var_29_4, var_29_5 = math.modf(var_29_3)

				var_29_0.localPosition = Vector3.New(var_29_5 * 0.13, var_29_5 * 0.13, var_29_5 * 0.13) + arg_26_1.var_.shakeOldPos
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = arg_26_1.var_.shakeOldPos
			end

			local var_29_6 = 0

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_7 = 0.6

			if arg_26_1.time_ >= var_29_6 + var_29_7 and arg_26_1.time_ < var_29_6 + var_29_7 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_8 = 0
			local var_29_9 = 0.175

			if var_29_8 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_10 = arg_26_1:FormatText(StoryNameCfg[8].name)

				arg_26_1.leftNameTxt_.text = var_29_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_11 = arg_26_1:GetWordFromCfg(116142006)
				local var_29_12 = arg_26_1:FormatText(var_29_11.content)

				arg_26_1.text_.text = var_29_12

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 7
				local var_29_14 = utf8.len(var_29_12)
				local var_29_15 = var_29_13 <= 0 and var_29_9 or var_29_9 * (var_29_14 / var_29_13)

				if var_29_15 > 0 and var_29_9 < var_29_15 then
					arg_26_1.talkMaxDuration = var_29_15

					if var_29_15 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_15 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_12
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142006", "story_v_out_116142.awb") ~= 0 then
					local var_29_16 = manager.audio:GetVoiceLength("story_v_out_116142", "116142006", "story_v_out_116142.awb") / 1000

					if var_29_16 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_16 + var_29_8
					end

					if var_29_11.prefab_name ~= "" and arg_26_1.actors_[var_29_11.prefab_name] ~= nil then
						local var_29_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_11.prefab_name].transform, "story_v_out_116142", "116142006", "story_v_out_116142.awb")

						arg_26_1:RecordAudio("116142006", var_29_17)
						arg_26_1:RecordAudio("116142006", var_29_17)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116142", "116142006", "story_v_out_116142.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116142", "116142006", "story_v_out_116142.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_18 = math.max(var_29_9, arg_26_1.talkMaxDuration)

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_18 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_8) / var_29_18

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_8 + var_29_18 and arg_26_1.time_ < var_29_8 + var_29_18 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116142007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116142007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116142008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.325

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_2 = arg_30_1:GetWordFromCfg(116142007)
				local var_33_3 = arg_30_1:FormatText(var_33_2.content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 13
				local var_33_5 = utf8.len(var_33_3)
				local var_33_6 = var_33_4 <= 0 and var_33_1 or var_33_1 * (var_33_5 / var_33_4)

				if var_33_6 > 0 and var_33_1 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_7 and arg_30_1.time_ < var_33_0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116142008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116142008
		arg_34_1.duration_ = 2.8

		local var_34_0 = {
			zh = 2.8,
			ja = 2.366
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116142009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_2 = arg_34_1.actors_["1059ui_story"]
			local var_37_3 = 0

			if var_37_3 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1059ui_story == nil then
				arg_34_1.var_.characterEffect1059ui_story = var_37_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_4 = 0.2

			if var_37_3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_3 + var_37_4 and not isNil(var_37_2) then
				local var_37_5 = (arg_34_1.time_ - var_37_3) / var_37_4

				if arg_34_1.var_.characterEffect1059ui_story and not isNil(var_37_2) then
					arg_34_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_3 + var_37_4 and arg_34_1.time_ < var_37_3 + var_37_4 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1059ui_story then
				arg_34_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_37_6 = arg_34_1.actors_["1059ui_story"].transform
			local var_37_7 = 0

			if var_37_7 < arg_34_1.time_ and arg_34_1.time_ <= var_37_7 + arg_37_0 then
				arg_34_1.var_.moveOldPos1059ui_story = var_37_6.localPosition
			end

			local var_37_8 = 0.001

			if var_37_7 <= arg_34_1.time_ and arg_34_1.time_ < var_37_7 + var_37_8 then
				local var_37_9 = (arg_34_1.time_ - var_37_7) / var_37_8
				local var_37_10 = Vector3.New(0, -1.05, -6)

				var_37_6.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1059ui_story, var_37_10, var_37_9)

				local var_37_11 = manager.ui.mainCamera.transform.position - var_37_6.position

				var_37_6.forward = Vector3.New(var_37_11.x, var_37_11.y, var_37_11.z)

				local var_37_12 = var_37_6.localEulerAngles

				var_37_12.z = 0
				var_37_12.x = 0
				var_37_6.localEulerAngles = var_37_12
			end

			if arg_34_1.time_ >= var_37_7 + var_37_8 and arg_34_1.time_ < var_37_7 + var_37_8 + arg_37_0 then
				var_37_6.localPosition = Vector3.New(0, -1.05, -6)

				local var_37_13 = manager.ui.mainCamera.transform.position - var_37_6.position

				var_37_6.forward = Vector3.New(var_37_13.x, var_37_13.y, var_37_13.z)

				local var_37_14 = var_37_6.localEulerAngles

				var_37_14.z = 0
				var_37_14.x = 0
				var_37_6.localEulerAngles = var_37_14
			end

			local var_37_15 = 0
			local var_37_16 = 0.225

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[28].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(116142008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 9
				local var_37_21 = utf8.len(var_37_19)
				local var_37_22 = var_37_20 <= 0 and var_37_16 or var_37_16 * (var_37_21 / var_37_20)

				if var_37_22 > 0 and var_37_16 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22

					if var_37_22 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142008", "story_v_out_116142.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_116142", "116142008", "story_v_out_116142.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_116142", "116142008", "story_v_out_116142.awb")

						arg_34_1:RecordAudio("116142008", var_37_24)
						arg_34_1:RecordAudio("116142008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_116142", "116142008", "story_v_out_116142.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_116142", "116142008", "story_v_out_116142.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_25 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_25

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_25 and arg_34_1.time_ < var_37_15 + var_37_25 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play116142009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116142009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116142010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1059ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1059ui_story == nil then
				arg_38_1.var_.characterEffect1059ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1059ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1059ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1059ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1059ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.975

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(116142009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 39
				local var_41_11 = utf8.len(var_41_9)
				local var_41_12 = var_41_10 <= 0 and var_41_7 or var_41_7 * (var_41_11 / var_41_10)

				if var_41_12 > 0 and var_41_7 < var_41_12 then
					arg_38_1.talkMaxDuration = var_41_12

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_13 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_13 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_13

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_13 and arg_38_1.time_ < var_41_6 + var_41_13 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116142010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116142010
		arg_42_1.duration_ = 9.2

		local var_42_0 = {
			zh = 7.866,
			ja = 9.2
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116142011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_45_2 = arg_42_1.actors_["1059ui_story"]
			local var_45_3 = 0

			if var_45_3 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1059ui_story == nil then
				arg_42_1.var_.characterEffect1059ui_story = var_45_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.2

			if var_45_3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_3 + var_45_4 and not isNil(var_45_2) then
				local var_45_5 = (arg_42_1.time_ - var_45_3) / var_45_4

				if arg_42_1.var_.characterEffect1059ui_story and not isNil(var_45_2) then
					arg_42_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_3 + var_45_4 and arg_42_1.time_ < var_45_3 + var_45_4 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1059ui_story then
				arg_42_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_45_6 = 0
			local var_45_7 = 0.775

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[28].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_9 = arg_42_1:GetWordFromCfg(116142010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 31
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142010", "story_v_out_116142.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_116142", "116142010", "story_v_out_116142.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_out_116142", "116142010", "story_v_out_116142.awb")

						arg_42_1:RecordAudio("116142010", var_45_15)
						arg_42_1:RecordAudio("116142010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116142", "116142010", "story_v_out_116142.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116142", "116142010", "story_v_out_116142.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116142011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116142011
		arg_46_1.duration_ = 6.3

		local var_46_0 = {
			zh = 6.3,
			ja = 6.2
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play116142012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1059ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1059ui_story == nil then
				arg_46_1.var_.characterEffect1059ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1059ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1059ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1059ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1059ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.75

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[8].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_9 = arg_46_1:GetWordFromCfg(116142011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 30
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142011", "story_v_out_116142.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_116142", "116142011", "story_v_out_116142.awb") / 1000

					if var_49_14 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_6
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_out_116142", "116142011", "story_v_out_116142.awb")

						arg_46_1:RecordAudio("116142011", var_49_15)
						arg_46_1:RecordAudio("116142011", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116142", "116142011", "story_v_out_116142.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116142", "116142011", "story_v_out_116142.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_16 and arg_46_1.time_ < var_49_6 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116142012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116142012
		arg_50_1.duration_ = 4.3

		local var_50_0 = {
			zh = 4.3,
			ja = 3.3
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116142013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_53_2 = arg_50_1.actors_["1059ui_story"]
			local var_53_3 = 0

			if var_53_3 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1059ui_story == nil then
				arg_50_1.var_.characterEffect1059ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.2

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_4 and not isNil(var_53_2) then
				local var_53_5 = (arg_50_1.time_ - var_53_3) / var_53_4

				if arg_50_1.var_.characterEffect1059ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_3 + var_53_4 and arg_50_1.time_ < var_53_3 + var_53_4 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1059ui_story then
				arg_50_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_53_6 = 0
			local var_53_7 = 0.375

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[28].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(116142012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 15
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142012", "story_v_out_116142.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_116142", "116142012", "story_v_out_116142.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_116142", "116142012", "story_v_out_116142.awb")

						arg_50_1:RecordAudio("116142012", var_53_15)
						arg_50_1:RecordAudio("116142012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_116142", "116142012", "story_v_out_116142.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_116142", "116142012", "story_v_out_116142.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116142013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116142013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116142014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1059ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1059ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0, 100, 0)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1059ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, 100, 0)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = 0
			local var_57_10 = 1

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				local var_57_11 = "play"
				local var_57_12 = "effect"

				arg_54_1:AudioAction(var_57_11, var_57_12, "se_story_16", "se_story_16_gun", "")
			end

			local var_57_13 = manager.ui.mainCamera.transform
			local var_57_14 = 0

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1.var_.shakeOldPos = var_57_13.localPosition
			end

			local var_57_15 = 0.6

			if var_57_14 <= arg_54_1.time_ and arg_54_1.time_ < var_57_14 + var_57_15 then
				local var_57_16 = (arg_54_1.time_ - var_57_14) / 0.066
				local var_57_17, var_57_18 = math.modf(var_57_16)

				var_57_13.localPosition = Vector3.New(var_57_18 * 0.13, var_57_18 * 0.13, var_57_18 * 0.13) + arg_54_1.var_.shakeOldPos
			end

			if arg_54_1.time_ >= var_57_14 + var_57_15 and arg_54_1.time_ < var_57_14 + var_57_15 + arg_57_0 then
				var_57_13.localPosition = arg_54_1.var_.shakeOldPos
			end

			local var_57_19 = 0

			if var_57_19 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 then
				arg_54_1.allBtn_.enabled = false
			end

			local var_57_20 = 0.6

			if arg_54_1.time_ >= var_57_19 + var_57_20 and arg_54_1.time_ < var_57_19 + var_57_20 + arg_57_0 then
				arg_54_1.allBtn_.enabled = true
			end

			local var_57_21 = 0
			local var_57_22 = 0.075

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_23 = arg_54_1:GetWordFromCfg(116142013)
				local var_57_24 = arg_54_1:FormatText(var_57_23.content)

				arg_54_1.text_.text = var_57_24

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_25 = 3
				local var_57_26 = utf8.len(var_57_24)
				local var_57_27 = var_57_25 <= 0 and var_57_22 or var_57_22 * (var_57_26 / var_57_25)

				if var_57_27 > 0 and var_57_22 < var_57_27 then
					arg_54_1.talkMaxDuration = var_57_27

					if var_57_27 + var_57_21 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_27 + var_57_21
					end
				end

				arg_54_1.text_.text = var_57_24
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_28 = math.max(var_57_22, arg_54_1.talkMaxDuration)

			if var_57_21 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_28 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_21) / var_57_28

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_21 + var_57_28 and arg_54_1.time_ < var_57_21 + var_57_28 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play116142014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 116142014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play116142015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.95

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(116142014)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 38
				local var_61_5 = utf8.len(var_61_3)
				local var_61_6 = var_61_4 <= 0 and var_61_1 or var_61_1 * (var_61_5 / var_61_4)

				if var_61_6 > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_7 and arg_58_1.time_ < var_61_0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play116142015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116142015
		arg_62_1.duration_ = 9.07

		local var_62_0 = {
			zh = 9.066,
			ja = 5.8
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116142016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.55

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[28].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(116142015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 22
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142015", "story_v_out_116142.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_116142", "116142015", "story_v_out_116142.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_116142", "116142015", "story_v_out_116142.awb")

						arg_62_1:RecordAudio("116142015", var_65_9)
						arg_62_1:RecordAudio("116142015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_116142", "116142015", "story_v_out_116142.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_116142", "116142015", "story_v_out_116142.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116142016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116142016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116142017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1059ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, 100, 0)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = 0
			local var_69_10 = 1

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				local var_69_11 = "play"
				local var_69_12 = "effect"

				arg_66_1:AudioAction(var_69_11, var_69_12, "se_story_16", "se_story_16_gun", "")
			end

			local var_69_13 = manager.ui.mainCamera.transform
			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.var_.shakeOldPos = var_69_13.localPosition
			end

			local var_69_15 = 1

			if var_69_14 <= arg_66_1.time_ and arg_66_1.time_ < var_69_14 + var_69_15 then
				local var_69_16 = (arg_66_1.time_ - var_69_14) / 0.066
				local var_69_17, var_69_18 = math.modf(var_69_16)

				var_69_13.localPosition = Vector3.New(var_69_18 * 0.13, var_69_18 * 0.13, var_69_18 * 0.13) + arg_66_1.var_.shakeOldPos
			end

			if arg_66_1.time_ >= var_69_14 + var_69_15 and arg_66_1.time_ < var_69_14 + var_69_15 + arg_69_0 then
				var_69_13.localPosition = arg_66_1.var_.shakeOldPos
			end

			local var_69_19 = 0

			if var_69_19 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_20 = 1

			if arg_66_1.time_ >= var_69_19 + var_69_20 and arg_66_1.time_ < var_69_19 + var_69_20 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_21 = 0
			local var_69_22 = 0.075

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_23 = arg_66_1:GetWordFromCfg(116142016)
				local var_69_24 = arg_66_1:FormatText(var_69_23.content)

				arg_66_1.text_.text = var_69_24

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_25 = 3
				local var_69_26 = utf8.len(var_69_24)
				local var_69_27 = var_69_25 <= 0 and var_69_22 or var_69_22 * (var_69_26 / var_69_25)

				if var_69_27 > 0 and var_69_22 < var_69_27 then
					arg_66_1.talkMaxDuration = var_69_27

					if var_69_27 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_27 + var_69_21
					end
				end

				arg_66_1.text_.text = var_69_24
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_28 = math.max(var_69_22, arg_66_1.talkMaxDuration)

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_28 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_21) / var_69_28

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_21 + var_69_28 and arg_66_1.time_ < var_69_21 + var_69_28 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play116142017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116142017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116142018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.85

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(116142017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 34
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116142018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116142018
		arg_74_1.duration_ = 11.5

		local var_74_0 = {
			zh = 7.233,
			ja = 11.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116142019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.725

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[8].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(116142018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 29
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142018", "story_v_out_116142.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_116142", "116142018", "story_v_out_116142.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_116142", "116142018", "story_v_out_116142.awb")

						arg_74_1:RecordAudio("116142018", var_77_9)
						arg_74_1:RecordAudio("116142018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116142", "116142018", "story_v_out_116142.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116142", "116142018", "story_v_out_116142.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116142019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116142019
		arg_78_1.duration_ = 6.5

		local var_78_0 = {
			zh = 5.033,
			ja = 6.5
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116142020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.7

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[8].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(116142019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 28
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142019", "story_v_out_116142.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_116142", "116142019", "story_v_out_116142.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_116142", "116142019", "story_v_out_116142.awb")

						arg_78_1:RecordAudio("116142019", var_81_9)
						arg_78_1:RecordAudio("116142019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_116142", "116142019", "story_v_out_116142.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_116142", "116142019", "story_v_out_116142.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116142020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116142020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116142021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.925

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(116142020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 37
				local var_85_5 = utf8.len(var_85_3)
				local var_85_6 = var_85_4 <= 0 and var_85_1 or var_85_1 * (var_85_5 / var_85_4)

				if var_85_6 > 0 and var_85_1 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_7 and arg_82_1.time_ < var_85_0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116142021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116142021
		arg_86_1.duration_ = 6.27

		local var_86_0 = {
			zh = 6.266,
			ja = 5.5
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116142022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.375

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[28].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(116142021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 15
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116142", "116142021", "story_v_out_116142.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_116142", "116142021", "story_v_out_116142.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_116142", "116142021", "story_v_out_116142.awb")

						arg_86_1:RecordAudio("116142021", var_89_9)
						arg_86_1:RecordAudio("116142021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_116142", "116142021", "story_v_out_116142.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_116142", "116142021", "story_v_out_116142.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116142022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116142022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116142023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				local var_93_2 = "play"
				local var_93_3 = "effect"

				arg_90_1:AudioAction(var_93_2, var_93_3, "se_story_16", "se_story_16_arch", "")
			end

			local var_93_4 = 0
			local var_93_5 = 0.975

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(116142022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_8 = 39
				local var_93_9 = utf8.len(var_93_7)
				local var_93_10 = var_93_8 <= 0 and var_93_5 or var_93_5 * (var_93_9 / var_93_8)

				if var_93_10 > 0 and var_93_5 < var_93_10 then
					arg_90_1.talkMaxDuration = var_93_10

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_11 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_11 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_11

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_11 and arg_90_1.time_ < var_93_4 + var_93_11 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116142023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116142023
		arg_94_1.duration_ = 7.23

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116142024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "STwhite"

			if arg_94_1.bgs_[var_97_0] == nil then
				local var_97_1 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_97_0)
				var_97_1.name = var_97_0
				var_97_1.transform.parent = arg_94_1.stage_.transform
				var_97_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_[var_97_0] = var_97_1
			end

			local var_97_2 = 0

			if var_97_2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				local var_97_3 = manager.ui.mainCamera.transform.localPosition
				local var_97_4 = Vector3.New(0, 0, 10) + Vector3.New(var_97_3.x, var_97_3.y, 0)
				local var_97_5 = arg_94_1.bgs_.STwhite

				var_97_5.transform.localPosition = var_97_4
				var_97_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_6 = var_97_5:GetComponent("SpriteRenderer")

				if var_97_6 and var_97_6.sprite then
					local var_97_7 = (var_97_5.transform.localPosition - var_97_3).z
					local var_97_8 = manager.ui.mainCameraCom_
					local var_97_9 = 2 * var_97_7 * Mathf.Tan(var_97_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_97_10 = var_97_9 * var_97_8.aspect
					local var_97_11 = var_97_6.sprite.bounds.size.x
					local var_97_12 = var_97_6.sprite.bounds.size.y
					local var_97_13 = var_97_10 / var_97_11
					local var_97_14 = var_97_9 / var_97_12
					local var_97_15 = var_97_14 < var_97_13 and var_97_13 or var_97_14

					var_97_5.transform.localScale = Vector3.New(var_97_15, var_97_15, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "STwhite" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_16 = 0

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_17 = 2

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 then
				local var_97_18 = (arg_94_1.time_ - var_97_16) / var_97_17
				local var_97_19 = Color.New(1, 1, 1)

				var_97_19.a = Mathf.Lerp(1, 0, var_97_18)
				arg_94_1.mask_.color = var_97_19
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 then
				local var_97_20 = Color.New(1, 1, 1)
				local var_97_21 = 0

				arg_94_1.mask_.enabled = false
				var_97_20.a = var_97_21
				arg_94_1.mask_.color = var_97_20
			end

			local var_97_22 = arg_94_1.bgs_.STwhite.transform
			local var_97_23 = 0

			if var_97_23 < arg_94_1.time_ and arg_94_1.time_ <= var_97_23 + arg_97_0 then
				arg_94_1.var_.moveOldPosSTwhite = var_97_22.localPosition
				var_97_22.localScale = Vector3.New(12, 12, 12)
			end

			local var_97_24 = 0.001

			if var_97_23 <= arg_94_1.time_ and arg_94_1.time_ < var_97_23 + var_97_24 then
				local var_97_25 = (arg_94_1.time_ - var_97_23) / var_97_24
				local var_97_26 = Vector3.New(0, 0, 0)

				var_97_22.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPosSTwhite, var_97_26, var_97_25)
			end

			if arg_94_1.time_ >= var_97_23 + var_97_24 and arg_94_1.time_ < var_97_23 + var_97_24 + arg_97_0 then
				var_97_22.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_27 = 2.23333333333333
			local var_97_28 = 0.35

			if var_97_27 < arg_94_1.time_ and arg_94_1.time_ <= var_97_27 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_29 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_29:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_30 = arg_94_1:GetWordFromCfg(116142023)
				local var_97_31 = arg_94_1:FormatText(var_97_30.content)

				arg_94_1.text_.text = var_97_31

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_32 = 14
				local var_97_33 = utf8.len(var_97_31)
				local var_97_34 = var_97_32 <= 0 and var_97_28 or var_97_28 * (var_97_33 / var_97_32)

				if var_97_34 > 0 and var_97_28 < var_97_34 then
					arg_94_1.talkMaxDuration = var_97_34
					var_97_27 = var_97_27 + 0.3

					if var_97_34 + var_97_27 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_34 + var_97_27
					end
				end

				arg_94_1.text_.text = var_97_31
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_35 = var_97_27 + 0.3
			local var_97_36 = math.max(var_97_28, arg_94_1.talkMaxDuration)

			if var_97_35 <= arg_94_1.time_ and arg_94_1.time_ < var_97_35 + var_97_36 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_35) / var_97_36

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_35 + var_97_36 and arg_94_1.time_ < var_97_35 + var_97_36 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play116142024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116142024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
			arg_100_1.auto_ = false
		end

		function arg_100_1.playNext_(arg_102_0)
			arg_100_1.onStoryFinished_()
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.525

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(116142024)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 21
				local var_103_5 = utf8.len(var_103_3)
				local var_103_6 = var_103_4 <= 0 and var_103_1 or var_103_1 * (var_103_5 / var_103_4)

				if var_103_6 > 0 and var_103_1 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_7 and arg_100_1.time_ < var_103_0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116142.awb"
	}
}
