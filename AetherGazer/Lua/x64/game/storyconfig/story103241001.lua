return {
	Play324101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324101001
		arg_1_1.duration_ = 6.7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2007"

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
				local var_4_5 = arg_1_1.bgs_.ST2007

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
					if iter_4_0 ~= "ST2007" then
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

			local var_4_24 = 0.1
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 1.7
			local var_4_33 = 1.25

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(324101001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 50
				local var_4_38 = utf8.len(var_4_36)
				local var_4_39 = var_4_37 <= 0 and var_4_33 or var_4_33 * (var_4_38 / var_4_37)

				if var_4_39 > 0 and var_4_33 < var_4_39 then
					arg_1_1.talkMaxDuration = var_4_39
					var_4_32 = var_4_32 + 0.3

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_32 + 0.3
			local var_4_41 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324101002
		arg_7_1.duration_ = 7.53

		local var_7_0 = {
			zh = 6.76633333333333,
			ja = 7.53333333333333
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.53333333333333

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				local var_10_1 = manager.ui.mainCamera.transform.localPosition
				local var_10_2 = Vector3.New(0, 0, 10) + Vector3.New(var_10_1.x, var_10_1.y, 0)
				local var_10_3 = arg_7_1.bgs_.ST2007

				var_10_3.transform.localPosition = var_10_2
				var_10_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_4 = var_10_3:GetComponent("SpriteRenderer")

				if var_10_4 and var_10_4.sprite then
					local var_10_5 = (var_10_3.transform.localPosition - var_10_1).z
					local var_10_6 = manager.ui.mainCameraCom_
					local var_10_7 = 2 * var_10_5 * Mathf.Tan(var_10_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_8 = var_10_7 * var_10_6.aspect
					local var_10_9 = var_10_4.sprite.bounds.size.x
					local var_10_10 = var_10_4.sprite.bounds.size.y
					local var_10_11 = var_10_8 / var_10_9
					local var_10_12 = var_10_7 / var_10_10
					local var_10_13 = var_10_12 < var_10_11 and var_10_11 or var_10_12

					var_10_3.transform.localScale = Vector3.New(var_10_13, var_10_13, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST2007" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_14 = 1.53333333333333

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1.allBtn_.enabled = false
			end

			local var_10_15 = 0.3

			if arg_7_1.time_ >= var_10_14 + var_10_15 and arg_7_1.time_ < var_10_14 + var_10_15 + arg_10_0 then
				arg_7_1.allBtn_.enabled = true
			end

			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_17 = 1.55

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17
				local var_10_19 = Color.New(0, 0, 0)

				var_10_19.a = Mathf.Lerp(0, 1, var_10_18)
				arg_7_1.mask_.color = var_10_19
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				local var_10_20 = Color.New(0, 0, 0)

				var_10_20.a = 1
				arg_7_1.mask_.color = var_10_20
			end

			local var_10_21 = 1.55

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_22 = 1.98333333333333

			if var_10_21 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_21) / var_10_22
				local var_10_24 = Color.New(0, 0, 0)

				var_10_24.a = Mathf.Lerp(1, 0, var_10_23)
				arg_7_1.mask_.color = var_10_24
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 then
				local var_10_25 = Color.New(0, 0, 0)
				local var_10_26 = 0

				arg_7_1.mask_.enabled = false
				var_10_25.a = var_10_26
				arg_7_1.mask_.color = var_10_25
			end

			local var_10_27 = "1054ui_story"

			if arg_7_1.actors_[var_10_27] == nil then
				local var_10_28 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_10_28) then
					local var_10_29 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_7_1.stage_.transform)

					var_10_29.name = var_10_27
					var_10_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_27] = var_10_29

					local var_10_30 = var_10_29:GetComponentInChildren(typeof(CharacterEffect))

					var_10_30.enabled = true

					local var_10_31 = GameObjectTools.GetOrAddComponent(var_10_29, typeof(DynamicBoneHelper))

					if var_10_31 then
						var_10_31:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_30.transform, false)

					arg_7_1.var_[var_10_27 .. "Animator"] = var_10_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_27 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_27 .. "LipSync"] = var_10_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_32 = arg_7_1.actors_["1054ui_story"].transform
			local var_10_33 = 3.2

			if var_10_33 < arg_7_1.time_ and arg_7_1.time_ <= var_10_33 + arg_10_0 then
				arg_7_1.var_.moveOldPos1054ui_story = var_10_32.localPosition

				local var_10_34 = GameObjectTools.GetOrAddComponent(var_10_32.gameObject, typeof(DynamicBoneHelper))

				if var_10_34 then
					var_10_34:EnableDynamicBone(false)
				end
			end

			local var_10_35 = 0.001

			if var_10_33 <= arg_7_1.time_ and arg_7_1.time_ < var_10_33 + var_10_35 then
				local var_10_36 = (arg_7_1.time_ - var_10_33) / var_10_35
				local var_10_37 = Vector3.New(0, -0.985, -6)

				var_10_32.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1054ui_story, var_10_37, var_10_36)

				local var_10_38 = manager.ui.mainCamera.transform.position - var_10_32.position

				var_10_32.forward = Vector3.New(var_10_38.x, var_10_38.y, var_10_38.z)

				local var_10_39 = var_10_32.localEulerAngles

				var_10_39.z = 0
				var_10_39.x = 0
				var_10_32.localEulerAngles = var_10_39
			end

			if arg_7_1.time_ >= var_10_33 + var_10_35 and arg_7_1.time_ < var_10_33 + var_10_35 + arg_10_0 then
				var_10_32.localPosition = Vector3.New(0, -0.985, -6)

				local var_10_40 = manager.ui.mainCamera.transform.position - var_10_32.position

				var_10_32.forward = Vector3.New(var_10_40.x, var_10_40.y, var_10_40.z)

				local var_10_41 = var_10_32.localEulerAngles

				var_10_41.z = 0
				var_10_41.x = 0
				var_10_32.localEulerAngles = var_10_41

				local var_10_42 = GameObjectTools.GetOrAddComponent(var_10_32.gameObject, typeof(DynamicBoneHelper))

				if var_10_42 then
					var_10_42:EnableDynamicBone(true)
				end
			end

			local var_10_43 = arg_7_1.actors_["1054ui_story"]
			local var_10_44 = 3.2

			if var_10_44 < arg_7_1.time_ and arg_7_1.time_ <= var_10_44 + arg_10_0 and not isNil(var_10_43) and arg_7_1.var_.characterEffect1054ui_story == nil then
				arg_7_1.var_.characterEffect1054ui_story = var_10_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_45 = 0.200000002980232

			if var_10_44 <= arg_7_1.time_ and arg_7_1.time_ < var_10_44 + var_10_45 and not isNil(var_10_43) then
				local var_10_46 = (arg_7_1.time_ - var_10_44) / var_10_45

				if arg_7_1.var_.characterEffect1054ui_story and not isNil(var_10_43) then
					arg_7_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_44 + var_10_45 and arg_7_1.time_ < var_10_44 + var_10_45 + arg_10_0 and not isNil(var_10_43) and arg_7_1.var_.characterEffect1054ui_story then
				arg_7_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_10_47 = 3.2

			if var_10_47 < arg_7_1.time_ and arg_7_1.time_ <= var_10_47 + arg_10_0 then
				arg_7_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_10_48 = 3.2

			if var_10_48 < arg_7_1.time_ and arg_7_1.time_ <= var_10_48 + arg_10_0 then
				arg_7_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_10_49 = 1.53333333333333

			arg_7_1.isInRecall_ = true

			if var_10_49 < arg_7_1.time_ and arg_7_1.time_ <= var_10_49 + arg_10_0 then
				arg_7_1.screenFilterGo_:SetActive(true)

				arg_7_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_7_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_7_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_10_2, iter_10_3 in pairs(arg_7_1.actors_) do
					local var_10_50 = iter_10_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_10_4, iter_10_5 in ipairs(var_10_50) do
						if iter_10_5.color.r > 0.51 then
							iter_10_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_10_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_10_51 = 0.0166666666666667

			if var_10_49 <= arg_7_1.time_ and arg_7_1.time_ < var_10_49 + var_10_51 then
				local var_10_52 = (arg_7_1.time_ - var_10_49) / var_10_51

				arg_7_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_10_52)
			end

			if arg_7_1.time_ >= var_10_49 + var_10_51 and arg_7_1.time_ < var_10_49 + var_10_51 + arg_10_0 then
				arg_7_1.screenFilterEffect_.weight = 1
			end

			local var_10_53 = 1.53333333333333
			local var_10_54 = 1

			if var_10_53 < arg_7_1.time_ and arg_7_1.time_ <= var_10_53 + arg_10_0 then
				local var_10_55 = "play"
				local var_10_56 = "music"

				arg_7_1:AudioAction(var_10_55, var_10_56, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_10_57 = ""
				local var_10_58 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_10_58 ~= "" then
					if arg_7_1.bgmTxt_.text ~= var_10_58 and arg_7_1.bgmTxt_.text ~= "" then
						if arg_7_1.bgmTxt2_.text ~= "" then
							arg_7_1.bgmTxt_.text = arg_7_1.bgmTxt2_.text
						end

						arg_7_1.bgmTxt2_.text = var_10_58

						arg_7_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_7_1.bgmTxt_.text = var_10_58
						arg_7_1.bgmTxt2_.text = var_10_58
					end

					if arg_7_1.bgmTimer then
						arg_7_1.bgmTimer:Stop()

						arg_7_1.bgmTimer = nil
					end

					if arg_7_1.settingData.show_music_name == 1 then
						arg_7_1.musicController:SetSelectedState("show")
						arg_7_1.musicAnimator_:Play("open", 0, 0)

						if arg_7_1.settingData.music_time ~= 0 then
							arg_7_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_7_1.settingData.music_time), function()
								if arg_7_1 == nil or isNil(arg_7_1.bgmTxt_) then
									return
								end

								arg_7_1.musicController:SetSelectedState("hide")
								arg_7_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_59 = 3.43333333333333
			local var_10_60 = 0.25

			if var_10_59 < arg_7_1.time_ and arg_7_1.time_ <= var_10_59 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_61 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_61:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_7_1.dialogCg_.alpha = arg_12_0
				end))
				var_10_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_62 = arg_7_1:FormatText(StoryNameCfg[1487].name)

				arg_7_1.leftNameTxt_.text = var_10_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_63 = arg_7_1:GetWordFromCfg(324101002)
				local var_10_64 = arg_7_1:FormatText(var_10_63.content)

				arg_7_1.text_.text = var_10_64

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_65 = 10
				local var_10_66 = utf8.len(var_10_64)
				local var_10_67 = var_10_65 <= 0 and var_10_60 or var_10_60 * (var_10_66 / var_10_65)

				if var_10_67 > 0 and var_10_60 < var_10_67 then
					arg_7_1.talkMaxDuration = var_10_67
					var_10_59 = var_10_59 + 0.3

					if var_10_67 + var_10_59 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_67 + var_10_59
					end
				end

				arg_7_1.text_.text = var_10_64
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101002", "story_v_out_324101.awb") ~= 0 then
					local var_10_68 = manager.audio:GetVoiceLength("story_v_out_324101", "324101002", "story_v_out_324101.awb") / 1000

					if var_10_68 + var_10_59 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_68 + var_10_59
					end

					if var_10_63.prefab_name ~= "" and arg_7_1.actors_[var_10_63.prefab_name] ~= nil then
						local var_10_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_63.prefab_name].transform, "story_v_out_324101", "324101002", "story_v_out_324101.awb")

						arg_7_1:RecordAudio("324101002", var_10_69)
						arg_7_1:RecordAudio("324101002", var_10_69)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_324101", "324101002", "story_v_out_324101.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_324101", "324101002", "story_v_out_324101.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_70 = var_10_59 + 0.3
			local var_10_71 = math.max(var_10_60, arg_7_1.talkMaxDuration)

			if var_10_70 <= arg_7_1.time_ and arg_7_1.time_ < var_10_70 + var_10_71 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_70) / var_10_71

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_70 + var_10_71 and arg_7_1.time_ < var_10_70 + var_10_71 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play324101003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 324101003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play324101004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1054ui_story"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect1054ui_story == nil then
				arg_14_1.var_.characterEffect1054ui_story = var_17_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_2 = 0.200000002980232

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.characterEffect1054ui_story and not isNil(var_17_0) then
					local var_17_4 = Mathf.Lerp(0, 0.5, var_17_3)

					arg_14_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1054ui_story.fillRatio = var_17_4
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect1054ui_story then
				local var_17_5 = 0.5

				arg_14_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1054ui_story.fillRatio = var_17_5
			end

			local var_17_6 = 0
			local var_17_7 = 0.125

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_8 = arg_14_1:FormatText(StoryNameCfg[7].name)

				arg_14_1.leftNameTxt_.text = var_17_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_14_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_17_9 = arg_14_1:GetWordFromCfg(324101003)
				local var_17_10 = arg_14_1:FormatText(var_17_9.content)

				arg_14_1.text_.text = var_17_10

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_11 = 5
				local var_17_12 = utf8.len(var_17_10)
				local var_17_13 = var_17_11 <= 0 and var_17_7 or var_17_7 * (var_17_12 / var_17_11)

				if var_17_13 > 0 and var_17_7 < var_17_13 then
					arg_14_1.talkMaxDuration = var_17_13

					if var_17_13 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_13 + var_17_6
					end
				end

				arg_14_1.text_.text = var_17_10
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_14 = math.max(var_17_7, arg_14_1.talkMaxDuration)

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_14 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_6) / var_17_14

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_6 + var_17_14 and arg_14_1.time_ < var_17_6 + var_17_14 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play324101004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 324101004
		arg_18_1.duration_ = 6.93

		local var_18_0 = {
			zh = 6.566,
			ja = 6.933
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
				arg_18_0:Play324101005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1054ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1054ui_story == nil then
				arg_18_1.var_.characterEffect1054ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.200000002980232

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect1054ui_story and not isNil(var_21_0) then
					arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1054ui_story then
				arg_18_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_21_4 = 0
			local var_21_5 = 0.55

			if var_21_4 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_6 = arg_18_1:FormatText(StoryNameCfg[1487].name)

				arg_18_1.leftNameTxt_.text = var_21_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_7 = arg_18_1:GetWordFromCfg(324101004)
				local var_21_8 = arg_18_1:FormatText(var_21_7.content)

				arg_18_1.text_.text = var_21_8

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_9 = 22
				local var_21_10 = utf8.len(var_21_8)
				local var_21_11 = var_21_9 <= 0 and var_21_5 or var_21_5 * (var_21_10 / var_21_9)

				if var_21_11 > 0 and var_21_5 < var_21_11 then
					arg_18_1.talkMaxDuration = var_21_11

					if var_21_11 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_4
					end
				end

				arg_18_1.text_.text = var_21_8
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101004", "story_v_out_324101.awb") ~= 0 then
					local var_21_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101004", "story_v_out_324101.awb") / 1000

					if var_21_12 + var_21_4 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_12 + var_21_4
					end

					if var_21_7.prefab_name ~= "" and arg_18_1.actors_[var_21_7.prefab_name] ~= nil then
						local var_21_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_7.prefab_name].transform, "story_v_out_324101", "324101004", "story_v_out_324101.awb")

						arg_18_1:RecordAudio("324101004", var_21_13)
						arg_18_1:RecordAudio("324101004", var_21_13)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_324101", "324101004", "story_v_out_324101.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_324101", "324101004", "story_v_out_324101.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_14 = math.max(var_21_5, arg_18_1.talkMaxDuration)

			if var_21_4 <= arg_18_1.time_ and arg_18_1.time_ < var_21_4 + var_21_14 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_4) / var_21_14

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_4 + var_21_14 and arg_18_1.time_ < var_21_4 + var_21_14 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play324101005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 324101005
		arg_22_1.duration_ = 5.77

		local var_22_0 = {
			zh = 3.966,
			ja = 5.766
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play324101006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1054ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos1054ui_story = var_25_0.localPosition

				local var_25_2 = GameObjectTools.GetOrAddComponent(var_25_0.gameObject, typeof(DynamicBoneHelper))

				if var_25_2 then
					var_25_2:EnableDynamicBone(false)
				end
			end

			local var_25_3 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_3 then
				local var_25_4 = (arg_22_1.time_ - var_25_1) / var_25_3
				local var_25_5 = Vector3.New(-0.7, -0.985, -6)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1054ui_story, var_25_5, var_25_4)

				local var_25_6 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_6.x, var_25_6.y, var_25_6.z)

				local var_25_7 = var_25_0.localEulerAngles

				var_25_7.z = 0
				var_25_7.x = 0
				var_25_0.localEulerAngles = var_25_7
			end

			if arg_22_1.time_ >= var_25_1 + var_25_3 and arg_22_1.time_ < var_25_1 + var_25_3 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_25_8 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_8.x, var_25_8.y, var_25_8.z)

				local var_25_9 = var_25_0.localEulerAngles

				var_25_9.z = 0
				var_25_9.x = 0
				var_25_0.localEulerAngles = var_25_9

				local var_25_10 = GameObjectTools.GetOrAddComponent(var_25_0.gameObject, typeof(DynamicBoneHelper))

				if var_25_10 then
					var_25_10:EnableDynamicBone(true)
				end
			end

			local var_25_11 = "6148ui_story"

			if arg_22_1.actors_[var_25_11] == nil then
				local var_25_12 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_25_12) then
					local var_25_13 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_22_1.stage_.transform)

					var_25_13.name = var_25_11
					var_25_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_22_1.actors_[var_25_11] = var_25_13

					local var_25_14 = var_25_13:GetComponentInChildren(typeof(CharacterEffect))

					var_25_14.enabled = true

					local var_25_15 = GameObjectTools.GetOrAddComponent(var_25_13, typeof(DynamicBoneHelper))

					if var_25_15 then
						var_25_15:EnableDynamicBone(false)
					end

					arg_22_1:ShowWeapon(var_25_14.transform, false)

					arg_22_1.var_[var_25_11 .. "Animator"] = var_25_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_22_1.var_[var_25_11 .. "Animator"].applyRootMotion = true
					arg_22_1.var_[var_25_11 .. "LipSync"] = var_25_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_25_16 = arg_22_1.actors_["6148ui_story"].transform
			local var_25_17 = 0

			if var_25_17 < arg_22_1.time_ and arg_22_1.time_ <= var_25_17 + arg_25_0 then
				arg_22_1.var_.moveOldPos6148ui_story = var_25_16.localPosition

				local var_25_18 = GameObjectTools.GetOrAddComponent(var_25_16.gameObject, typeof(DynamicBoneHelper))

				if var_25_18 then
					var_25_18:EnableDynamicBone(false)
				end
			end

			local var_25_19 = 0.001

			if var_25_17 <= arg_22_1.time_ and arg_22_1.time_ < var_25_17 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_17) / var_25_19
				local var_25_21 = Vector3.New(0.7, -0.985, -6)

				var_25_16.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos6148ui_story, var_25_21, var_25_20)

				local var_25_22 = manager.ui.mainCamera.transform.position - var_25_16.position

				var_25_16.forward = Vector3.New(var_25_22.x, var_25_22.y, var_25_22.z)

				local var_25_23 = var_25_16.localEulerAngles

				var_25_23.z = 0
				var_25_23.x = 0
				var_25_16.localEulerAngles = var_25_23
			end

			if arg_22_1.time_ >= var_25_17 + var_25_19 and arg_22_1.time_ < var_25_17 + var_25_19 + arg_25_0 then
				var_25_16.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_25_24 = manager.ui.mainCamera.transform.position - var_25_16.position

				var_25_16.forward = Vector3.New(var_25_24.x, var_25_24.y, var_25_24.z)

				local var_25_25 = var_25_16.localEulerAngles

				var_25_25.z = 0
				var_25_25.x = 0
				var_25_16.localEulerAngles = var_25_25

				local var_25_26 = GameObjectTools.GetOrAddComponent(var_25_16.gameObject, typeof(DynamicBoneHelper))

				if var_25_26 then
					var_25_26:EnableDynamicBone(true)
				end
			end

			local var_25_27 = arg_22_1.actors_["6148ui_story"]
			local var_25_28 = 0

			if var_25_28 < arg_22_1.time_ and arg_22_1.time_ <= var_25_28 + arg_25_0 and not isNil(var_25_27) and arg_22_1.var_.characterEffect6148ui_story == nil then
				arg_22_1.var_.characterEffect6148ui_story = var_25_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_29 = 0.200000002980232

			if var_25_28 <= arg_22_1.time_ and arg_22_1.time_ < var_25_28 + var_25_29 and not isNil(var_25_27) then
				local var_25_30 = (arg_22_1.time_ - var_25_28) / var_25_29

				if arg_22_1.var_.characterEffect6148ui_story and not isNil(var_25_27) then
					arg_22_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_28 + var_25_29 and arg_22_1.time_ < var_25_28 + var_25_29 + arg_25_0 and not isNil(var_25_27) and arg_22_1.var_.characterEffect6148ui_story then
				arg_22_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_25_31 = arg_22_1.actors_["1054ui_story"]
			local var_25_32 = 0

			if var_25_32 < arg_22_1.time_ and arg_22_1.time_ <= var_25_32 + arg_25_0 and not isNil(var_25_31) and arg_22_1.var_.characterEffect1054ui_story == nil then
				arg_22_1.var_.characterEffect1054ui_story = var_25_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_33 = 0.200000002980232

			if var_25_32 <= arg_22_1.time_ and arg_22_1.time_ < var_25_32 + var_25_33 and not isNil(var_25_31) then
				local var_25_34 = (arg_22_1.time_ - var_25_32) / var_25_33

				if arg_22_1.var_.characterEffect1054ui_story and not isNil(var_25_31) then
					local var_25_35 = Mathf.Lerp(0, 0.5, var_25_34)

					arg_22_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1054ui_story.fillRatio = var_25_35
				end
			end

			if arg_22_1.time_ >= var_25_32 + var_25_33 and arg_22_1.time_ < var_25_32 + var_25_33 + arg_25_0 and not isNil(var_25_31) and arg_22_1.var_.characterEffect1054ui_story then
				local var_25_36 = 0.5

				arg_22_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1054ui_story.fillRatio = var_25_36
			end

			local var_25_37 = 0

			if var_25_37 < arg_22_1.time_ and arg_22_1.time_ <= var_25_37 + arg_25_0 then
				arg_22_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_25_38 = 0

			if var_25_38 < arg_22_1.time_ and arg_22_1.time_ <= var_25_38 + arg_25_0 then
				arg_22_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_25_39 = 0
			local var_25_40 = 0.575

			if var_25_39 < arg_22_1.time_ and arg_22_1.time_ <= var_25_39 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_41 = arg_22_1:FormatText(StoryNameCfg[1488].name)

				arg_22_1.leftNameTxt_.text = var_25_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_42 = arg_22_1:GetWordFromCfg(324101005)
				local var_25_43 = arg_22_1:FormatText(var_25_42.content)

				arg_22_1.text_.text = var_25_43

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_44 = 23
				local var_25_45 = utf8.len(var_25_43)
				local var_25_46 = var_25_44 <= 0 and var_25_40 or var_25_40 * (var_25_45 / var_25_44)

				if var_25_46 > 0 and var_25_40 < var_25_46 then
					arg_22_1.talkMaxDuration = var_25_46

					if var_25_46 + var_25_39 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_46 + var_25_39
					end
				end

				arg_22_1.text_.text = var_25_43
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101005", "story_v_out_324101.awb") ~= 0 then
					local var_25_47 = manager.audio:GetVoiceLength("story_v_out_324101", "324101005", "story_v_out_324101.awb") / 1000

					if var_25_47 + var_25_39 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_47 + var_25_39
					end

					if var_25_42.prefab_name ~= "" and arg_22_1.actors_[var_25_42.prefab_name] ~= nil then
						local var_25_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_42.prefab_name].transform, "story_v_out_324101", "324101005", "story_v_out_324101.awb")

						arg_22_1:RecordAudio("324101005", var_25_48)
						arg_22_1:RecordAudio("324101005", var_25_48)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_324101", "324101005", "story_v_out_324101.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_324101", "324101005", "story_v_out_324101.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_49 = math.max(var_25_40, arg_22_1.talkMaxDuration)

			if var_25_39 <= arg_22_1.time_ and arg_22_1.time_ < var_25_39 + var_25_49 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_39) / var_25_49

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_39 + var_25_49 and arg_22_1.time_ < var_25_39 + var_25_49 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
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

		arg_22_1:InitPlayNodeList()
	end,
	Play324101006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 324101006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play324101007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["6148ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect6148ui_story == nil then
				arg_26_1.var_.characterEffect6148ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect6148ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_26_1.var_.characterEffect6148ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect6148ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_26_1.var_.characterEffect6148ui_story.fillRatio = var_29_5
			end

			local var_29_6 = 0
			local var_29_7 = 0.5

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_8 = arg_26_1:FormatText(StoryNameCfg[7].name)

				arg_26_1.leftNameTxt_.text = var_29_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_26_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_29_9 = arg_26_1:GetWordFromCfg(324101006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 20
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_7 or var_29_7 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_7 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play324101007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324101007
		arg_30_1.duration_ = 9.97

		local var_30_0 = {
			zh = 7,
			ja = 9.966
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play324101008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1054ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1054ui_story == nil then
				arg_30_1.var_.characterEffect1054ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect1054ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1054ui_story then
				arg_30_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_33_4 = 0

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_33_6 = 0
			local var_33_7 = 0.6

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[1487].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_9 = arg_30_1:GetWordFromCfg(324101007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 24
				local var_33_12 = utf8.len(var_33_10)
				local var_33_13 = var_33_11 <= 0 and var_33_7 or var_33_7 * (var_33_12 / var_33_11)

				if var_33_13 > 0 and var_33_7 < var_33_13 then
					arg_30_1.talkMaxDuration = var_33_13

					if var_33_13 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_13 + var_33_6
					end
				end

				arg_30_1.text_.text = var_33_10
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101007", "story_v_out_324101.awb") ~= 0 then
					local var_33_14 = manager.audio:GetVoiceLength("story_v_out_324101", "324101007", "story_v_out_324101.awb") / 1000

					if var_33_14 + var_33_6 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_6
					end

					if var_33_9.prefab_name ~= "" and arg_30_1.actors_[var_33_9.prefab_name] ~= nil then
						local var_33_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_9.prefab_name].transform, "story_v_out_324101", "324101007", "story_v_out_324101.awb")

						arg_30_1:RecordAudio("324101007", var_33_15)
						arg_30_1:RecordAudio("324101007", var_33_15)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_324101", "324101007", "story_v_out_324101.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_324101", "324101007", "story_v_out_324101.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_16 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_16 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_16

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_16 and arg_30_1.time_ < var_33_6 + var_33_16 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play324101008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324101008
		arg_34_1.duration_ = 5.4

		local var_34_0 = {
			zh = 4.8,
			ja = 5.4
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
				arg_34_0:Play324101009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["6148ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6148ui_story == nil then
				arg_34_1.var_.characterEffect6148ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect6148ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6148ui_story then
				arg_34_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_37_4 = arg_34_1.actors_["1054ui_story"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1054ui_story == nil then
				arg_34_1.var_.characterEffect1054ui_story = var_37_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.characterEffect1054ui_story and not isNil(var_37_4) then
					local var_37_8 = Mathf.Lerp(0, 0.5, var_37_7)

					arg_34_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1054ui_story.fillRatio = var_37_8
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1054ui_story then
				local var_37_9 = 0.5

				arg_34_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1054ui_story.fillRatio = var_37_9
			end

			local var_37_10 = 0
			local var_37_11 = 0.5

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_12 = arg_34_1:FormatText(StoryNameCfg[1488].name)

				arg_34_1.leftNameTxt_.text = var_37_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_13 = arg_34_1:GetWordFromCfg(324101008)
				local var_37_14 = arg_34_1:FormatText(var_37_13.content)

				arg_34_1.text_.text = var_37_14

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_15 = 20
				local var_37_16 = utf8.len(var_37_14)
				local var_37_17 = var_37_15 <= 0 and var_37_11 or var_37_11 * (var_37_16 / var_37_15)

				if var_37_17 > 0 and var_37_11 < var_37_17 then
					arg_34_1.talkMaxDuration = var_37_17

					if var_37_17 + var_37_10 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_17 + var_37_10
					end
				end

				arg_34_1.text_.text = var_37_14
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101008", "story_v_out_324101.awb") ~= 0 then
					local var_37_18 = manager.audio:GetVoiceLength("story_v_out_324101", "324101008", "story_v_out_324101.awb") / 1000

					if var_37_18 + var_37_10 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_18 + var_37_10
					end

					if var_37_13.prefab_name ~= "" and arg_34_1.actors_[var_37_13.prefab_name] ~= nil then
						local var_37_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_13.prefab_name].transform, "story_v_out_324101", "324101008", "story_v_out_324101.awb")

						arg_34_1:RecordAudio("324101008", var_37_19)
						arg_34_1:RecordAudio("324101008", var_37_19)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_324101", "324101008", "story_v_out_324101.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_324101", "324101008", "story_v_out_324101.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_20 = math.max(var_37_11, arg_34_1.talkMaxDuration)

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_20 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_10) / var_37_20

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_10 + var_37_20 and arg_34_1.time_ < var_37_10 + var_37_20 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play324101009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324101009
		arg_38_1.duration_ = 12.2

		local var_38_0 = {
			zh = 9.2,
			ja = 12.2
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324101010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action453")
			end

			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_41_2 = 0
			local var_41_3 = 1.15

			if var_41_2 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_4 = arg_38_1:FormatText(StoryNameCfg[1488].name)

				arg_38_1.leftNameTxt_.text = var_41_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_5 = arg_38_1:GetWordFromCfg(324101009)
				local var_41_6 = arg_38_1:FormatText(var_41_5.content)

				arg_38_1.text_.text = var_41_6

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_7 = 46
				local var_41_8 = utf8.len(var_41_6)
				local var_41_9 = var_41_7 <= 0 and var_41_3 or var_41_3 * (var_41_8 / var_41_7)

				if var_41_9 > 0 and var_41_3 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_6
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101009", "story_v_out_324101.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_324101", "324101009", "story_v_out_324101.awb") / 1000

					if var_41_10 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_2
					end

					if var_41_5.prefab_name ~= "" and arg_38_1.actors_[var_41_5.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_5.prefab_name].transform, "story_v_out_324101", "324101009", "story_v_out_324101.awb")

						arg_38_1:RecordAudio("324101009", var_41_11)
						arg_38_1:RecordAudio("324101009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_324101", "324101009", "story_v_out_324101.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_324101", "324101009", "story_v_out_324101.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_12 and arg_38_1.time_ < var_41_2 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play324101010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324101010
		arg_42_1.duration_ = 8.33

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324101011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "ST2008"

			if arg_42_1.bgs_[var_45_0] == nil then
				local var_45_1 = Object.Instantiate(arg_42_1.paintGo_)

				var_45_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_45_0)
				var_45_1.name = var_45_0
				var_45_1.transform.parent = arg_42_1.stage_.transform
				var_45_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.bgs_[var_45_0] = var_45_1
			end

			local var_45_2 = 2.00066666851441

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				local var_45_3 = manager.ui.mainCamera.transform.localPosition
				local var_45_4 = Vector3.New(0, 0, 10) + Vector3.New(var_45_3.x, var_45_3.y, 0)
				local var_45_5 = arg_42_1.bgs_.ST2008

				var_45_5.transform.localPosition = var_45_4
				var_45_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_6 = var_45_5:GetComponent("SpriteRenderer")

				if var_45_6 and var_45_6.sprite then
					local var_45_7 = (var_45_5.transform.localPosition - var_45_3).z
					local var_45_8 = manager.ui.mainCameraCom_
					local var_45_9 = 2 * var_45_7 * Mathf.Tan(var_45_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_10 = var_45_9 * var_45_8.aspect
					local var_45_11 = var_45_6.sprite.bounds.size.x
					local var_45_12 = var_45_6.sprite.bounds.size.y
					local var_45_13 = var_45_10 / var_45_11
					local var_45_14 = var_45_9 / var_45_12
					local var_45_15 = var_45_14 < var_45_13 and var_45_13 or var_45_14

					var_45_5.transform.localScale = Vector3.New(var_45_15, var_45_15, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "ST2008" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_17 = 0.3

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_18 = 0

			if var_45_18 < arg_42_1.time_ and arg_42_1.time_ <= var_45_18 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_19 = 2

			if var_45_18 <= arg_42_1.time_ and arg_42_1.time_ < var_45_18 + var_45_19 then
				local var_45_20 = (arg_42_1.time_ - var_45_18) / var_45_19
				local var_45_21 = Color.New(0, 0, 0)

				var_45_21.a = Mathf.Lerp(0, 1, var_45_20)
				arg_42_1.mask_.color = var_45_21
			end

			if arg_42_1.time_ >= var_45_18 + var_45_19 and arg_42_1.time_ < var_45_18 + var_45_19 + arg_45_0 then
				local var_45_22 = Color.New(0, 0, 0)

				var_45_22.a = 1
				arg_42_1.mask_.color = var_45_22
			end

			local var_45_23 = 2

			if var_45_23 < arg_42_1.time_ and arg_42_1.time_ <= var_45_23 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_24 = 2

			if var_45_23 <= arg_42_1.time_ and arg_42_1.time_ < var_45_23 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_23) / var_45_24
				local var_45_26 = Color.New(0, 0, 0)

				var_45_26.a = Mathf.Lerp(1, 0, var_45_25)
				arg_42_1.mask_.color = var_45_26
			end

			if arg_42_1.time_ >= var_45_23 + var_45_24 and arg_42_1.time_ < var_45_23 + var_45_24 + arg_45_0 then
				local var_45_27 = Color.New(0, 0, 0)
				local var_45_28 = 0

				arg_42_1.mask_.enabled = false
				var_45_27.a = var_45_28
				arg_42_1.mask_.color = var_45_27
			end

			local var_45_29 = arg_42_1.actors_["1054ui_story"].transform
			local var_45_30 = 1.96666666666667

			if var_45_30 < arg_42_1.time_ and arg_42_1.time_ <= var_45_30 + arg_45_0 then
				arg_42_1.var_.moveOldPos1054ui_story = var_45_29.localPosition

				local var_45_31 = GameObjectTools.GetOrAddComponent(var_45_29.gameObject, typeof(DynamicBoneHelper))

				if var_45_31 then
					var_45_31:EnableDynamicBone(false)
				end
			end

			local var_45_32 = 0.001

			if var_45_30 <= arg_42_1.time_ and arg_42_1.time_ < var_45_30 + var_45_32 then
				local var_45_33 = (arg_42_1.time_ - var_45_30) / var_45_32
				local var_45_34 = Vector3.New(0, 100, 0)

				var_45_29.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1054ui_story, var_45_34, var_45_33)

				local var_45_35 = manager.ui.mainCamera.transform.position - var_45_29.position

				var_45_29.forward = Vector3.New(var_45_35.x, var_45_35.y, var_45_35.z)

				local var_45_36 = var_45_29.localEulerAngles

				var_45_36.z = 0
				var_45_36.x = 0
				var_45_29.localEulerAngles = var_45_36
			end

			if arg_42_1.time_ >= var_45_30 + var_45_32 and arg_42_1.time_ < var_45_30 + var_45_32 + arg_45_0 then
				var_45_29.localPosition = Vector3.New(0, 100, 0)

				local var_45_37 = manager.ui.mainCamera.transform.position - var_45_29.position

				var_45_29.forward = Vector3.New(var_45_37.x, var_45_37.y, var_45_37.z)

				local var_45_38 = var_45_29.localEulerAngles

				var_45_38.z = 0
				var_45_38.x = 0
				var_45_29.localEulerAngles = var_45_38

				local var_45_39 = GameObjectTools.GetOrAddComponent(var_45_29.gameObject, typeof(DynamicBoneHelper))

				if var_45_39 then
					var_45_39:EnableDynamicBone(true)
				end
			end

			local var_45_40 = arg_42_1.actors_["6148ui_story"].transform
			local var_45_41 = 1.96666666666667

			if var_45_41 < arg_42_1.time_ and arg_42_1.time_ <= var_45_41 + arg_45_0 then
				arg_42_1.var_.moveOldPos6148ui_story = var_45_40.localPosition

				local var_45_42 = GameObjectTools.GetOrAddComponent(var_45_40.gameObject, typeof(DynamicBoneHelper))

				if var_45_42 then
					var_45_42:EnableDynamicBone(false)
				end
			end

			local var_45_43 = 0.001

			if var_45_41 <= arg_42_1.time_ and arg_42_1.time_ < var_45_41 + var_45_43 then
				local var_45_44 = (arg_42_1.time_ - var_45_41) / var_45_43
				local var_45_45 = Vector3.New(0, 100, 0)

				var_45_40.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos6148ui_story, var_45_45, var_45_44)

				local var_45_46 = manager.ui.mainCamera.transform.position - var_45_40.position

				var_45_40.forward = Vector3.New(var_45_46.x, var_45_46.y, var_45_46.z)

				local var_45_47 = var_45_40.localEulerAngles

				var_45_47.z = 0
				var_45_47.x = 0
				var_45_40.localEulerAngles = var_45_47
			end

			if arg_42_1.time_ >= var_45_41 + var_45_43 and arg_42_1.time_ < var_45_41 + var_45_43 + arg_45_0 then
				var_45_40.localPosition = Vector3.New(0, 100, 0)

				local var_45_48 = manager.ui.mainCamera.transform.position - var_45_40.position

				var_45_40.forward = Vector3.New(var_45_48.x, var_45_48.y, var_45_48.z)

				local var_45_49 = var_45_40.localEulerAngles

				var_45_49.z = 0
				var_45_49.x = 0
				var_45_40.localEulerAngles = var_45_49

				local var_45_50 = GameObjectTools.GetOrAddComponent(var_45_40.gameObject, typeof(DynamicBoneHelper))

				if var_45_50 then
					var_45_50:EnableDynamicBone(true)
				end
			end

			local var_45_51 = arg_42_1.actors_["6148ui_story"]
			local var_45_52 = 1.96666666666667

			if var_45_52 < arg_42_1.time_ and arg_42_1.time_ <= var_45_52 + arg_45_0 and not isNil(var_45_51) and arg_42_1.var_.characterEffect6148ui_story == nil then
				arg_42_1.var_.characterEffect6148ui_story = var_45_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_53 = 0.200000002980232

			if var_45_52 <= arg_42_1.time_ and arg_42_1.time_ < var_45_52 + var_45_53 and not isNil(var_45_51) then
				local var_45_54 = (arg_42_1.time_ - var_45_52) / var_45_53

				if arg_42_1.var_.characterEffect6148ui_story and not isNil(var_45_51) then
					local var_45_55 = Mathf.Lerp(0, 0.5, var_45_54)

					arg_42_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_42_1.var_.characterEffect6148ui_story.fillRatio = var_45_55
				end
			end

			if arg_42_1.time_ >= var_45_52 + var_45_53 and arg_42_1.time_ < var_45_52 + var_45_53 + arg_45_0 and not isNil(var_45_51) and arg_42_1.var_.characterEffect6148ui_story then
				local var_45_56 = 0.5

				arg_42_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_42_1.var_.characterEffect6148ui_story.fillRatio = var_45_56
			end

			local var_45_57 = 2

			arg_42_1.isInRecall_ = false

			if var_45_57 < arg_42_1.time_ and arg_42_1.time_ <= var_45_57 + arg_45_0 then
				arg_42_1.screenFilterGo_:SetActive(false)

				for iter_45_2, iter_45_3 in pairs(arg_42_1.actors_) do
					local var_45_58 = iter_45_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_45_4, iter_45_5 in ipairs(var_45_58) do
						if iter_45_5.color.r > 0.51 then
							iter_45_5.color = Color.New(1, 1, 1)
						else
							iter_45_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_45_59 = 0.0166666666666667

			if var_45_57 <= arg_42_1.time_ and arg_42_1.time_ < var_45_57 + var_45_59 then
				local var_45_60 = (arg_42_1.time_ - var_45_57) / var_45_59

				arg_42_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_45_60)
			end

			if arg_42_1.time_ >= var_45_57 + var_45_59 and arg_42_1.time_ < var_45_57 + var_45_59 + arg_45_0 then
				arg_42_1.screenFilterEffect_.weight = 0
			end

			local var_45_61 = 1.2
			local var_45_62 = 1

			if var_45_61 < arg_42_1.time_ and arg_42_1.time_ <= var_45_61 + arg_45_0 then
				local var_45_63 = "play"
				local var_45_64 = "effect"

				arg_42_1:AudioAction(var_45_63, var_45_64, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_45_65 = 0.1
			local var_45_66 = 1

			if var_45_65 < arg_42_1.time_ and arg_42_1.time_ <= var_45_65 + arg_45_0 then
				local var_45_67 = "stop"
				local var_45_68 = "effect"

				arg_42_1:AudioAction(var_45_67, var_45_68, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_69 = 3.33333333333333
			local var_45_70 = 1.475

			if var_45_69 < arg_42_1.time_ and arg_42_1.time_ <= var_45_69 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_71 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_71:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_72 = arg_42_1:GetWordFromCfg(324101010)
				local var_45_73 = arg_42_1:FormatText(var_45_72.content)

				arg_42_1.text_.text = var_45_73

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_74 = 59
				local var_45_75 = utf8.len(var_45_73)
				local var_45_76 = var_45_74 <= 0 and var_45_70 or var_45_70 * (var_45_75 / var_45_74)

				if var_45_76 > 0 and var_45_70 < var_45_76 then
					arg_42_1.talkMaxDuration = var_45_76
					var_45_69 = var_45_69 + 0.3

					if var_45_76 + var_45_69 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_76 + var_45_69
					end
				end

				arg_42_1.text_.text = var_45_73
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_77 = var_45_69 + 0.3
			local var_45_78 = math.max(var_45_70, arg_42_1.talkMaxDuration)

			if var_45_77 <= arg_42_1.time_ and arg_42_1.time_ < var_45_77 + var_45_78 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_77) / var_45_78

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_77 + var_45_78 and arg_42_1.time_ < var_45_77 + var_45_78 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play324101011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324101011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324101012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.225

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(324101011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 9
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324101012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324101012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324101013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.6

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(324101012)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 24
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324101013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324101013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324101014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.4

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

				local var_59_3 = arg_56_1:GetWordFromCfg(324101013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 16
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
	Play324101014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324101014
		arg_60_1.duration_ = 4.43

		local var_60_0 = {
			zh = 3.533,
			ja = 4.433
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324101015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["6148ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos6148ui_story = var_63_0.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_3 then
				local var_63_4 = (arg_60_1.time_ - var_63_1) / var_63_3
				local var_63_5 = Vector3.New(0.7, -0.985, -6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos6148ui_story, var_63_5, var_63_4)

				local var_63_6 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_6.x, var_63_6.y, var_63_6.z)

				local var_63_7 = var_63_0.localEulerAngles

				var_63_7.z = 0
				var_63_7.x = 0
				var_63_0.localEulerAngles = var_63_7
			end

			if arg_60_1.time_ >= var_63_1 + var_63_3 and arg_60_1.time_ < var_63_1 + var_63_3 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0.7, -0.985, -6)

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

			local var_63_11 = arg_60_1.actors_["6148ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect6148ui_story == nil then
				arg_60_1.var_.characterEffect6148ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.200000002980232

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect6148ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect6148ui_story then
				arg_60_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_63_16 = 0

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_63_17 = 0
			local var_63_18 = 0.425

			if var_63_17 < arg_60_1.time_ and arg_60_1.time_ <= var_63_17 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_19 = arg_60_1:FormatText(StoryNameCfg[1488].name)

				arg_60_1.leftNameTxt_.text = var_63_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_20 = arg_60_1:GetWordFromCfg(324101014)
				local var_63_21 = arg_60_1:FormatText(var_63_20.content)

				arg_60_1.text_.text = var_63_21

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_22 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101014", "story_v_out_324101.awb") ~= 0 then
					local var_63_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101014", "story_v_out_324101.awb") / 1000

					if var_63_25 + var_63_17 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_25 + var_63_17
					end

					if var_63_20.prefab_name ~= "" and arg_60_1.actors_[var_63_20.prefab_name] ~= nil then
						local var_63_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_20.prefab_name].transform, "story_v_out_324101", "324101014", "story_v_out_324101.awb")

						arg_60_1:RecordAudio("324101014", var_63_26)
						arg_60_1:RecordAudio("324101014", var_63_26)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324101", "324101014", "story_v_out_324101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324101", "324101014", "story_v_out_324101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_27 = math.max(var_63_18, arg_60_1.talkMaxDuration)

			if var_63_17 <= arg_60_1.time_ and arg_60_1.time_ < var_63_17 + var_63_27 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_17) / var_63_27

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_17 + var_63_27 and arg_60_1.time_ < var_63_17 + var_63_27 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play324101015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324101015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324101016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["6148ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect6148ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect6148ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.475

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

				local var_67_9 = arg_64_1:GetWordFromCfg(324101015)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 19
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
	Play324101016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324101016
		arg_68_1.duration_ = 5.8

		local var_68_0 = {
			zh = 4.066,
			ja = 5.8
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324101017(arg_68_1)
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
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_17 = 0
			local var_71_18 = 0.4

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

				local var_71_20 = arg_68_1:GetWordFromCfg(324101016)
				local var_71_21 = arg_68_1:FormatText(var_71_20.content)

				arg_68_1.text_.text = var_71_21

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_22 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101016", "story_v_out_324101.awb") ~= 0 then
					local var_71_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101016", "story_v_out_324101.awb") / 1000

					if var_71_25 + var_71_17 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_25 + var_71_17
					end

					if var_71_20.prefab_name ~= "" and arg_68_1.actors_[var_71_20.prefab_name] ~= nil then
						local var_71_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_20.prefab_name].transform, "story_v_out_324101", "324101016", "story_v_out_324101.awb")

						arg_68_1:RecordAudio("324101016", var_71_26)
						arg_68_1:RecordAudio("324101016", var_71_26)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324101", "324101016", "story_v_out_324101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324101", "324101016", "story_v_out_324101.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_27 = math.max(var_71_18, arg_68_1.talkMaxDuration)

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_27 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_17) / var_71_27

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_17 + var_71_27 and arg_68_1.time_ < var_71_17 + var_71_27 + arg_71_0 then
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
	Play324101017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324101017
		arg_72_1.duration_ = 5.73

		local var_72_0 = {
			zh = 4.7,
			ja = 5.733
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324101018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["6148ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect6148ui_story == nil then
				arg_72_1.var_.characterEffect6148ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect6148ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect6148ui_story then
				arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1054ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1054ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action425")
			end

			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_12 = 0
			local var_75_13 = 0.55

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[1488].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_15 = arg_72_1:GetWordFromCfg(324101017)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 22
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101017", "story_v_out_324101.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_324101", "324101017", "story_v_out_324101.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_324101", "324101017", "story_v_out_324101.awb")

						arg_72_1:RecordAudio("324101017", var_75_21)
						arg_72_1:RecordAudio("324101017", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_324101", "324101017", "story_v_out_324101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_324101", "324101017", "story_v_out_324101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324101018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324101018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324101019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["6148ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect6148ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.325

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(324101018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 13
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324101019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324101019
		arg_80_1.duration_ = 6

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324101020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "STblack"

			if arg_80_1.bgs_[var_83_0] == nil then
				local var_83_1 = Object.Instantiate(arg_80_1.paintGo_)

				var_83_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_83_0)
				var_83_1.name = var_83_0
				var_83_1.transform.parent = arg_80_1.stage_.transform
				var_83_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.bgs_[var_83_0] = var_83_1
			end

			local var_83_2 = 1

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				local var_83_3 = manager.ui.mainCamera.transform.localPosition
				local var_83_4 = Vector3.New(0, 0, 10) + Vector3.New(var_83_3.x, var_83_3.y, 0)
				local var_83_5 = arg_80_1.bgs_.STblack

				var_83_5.transform.localPosition = var_83_4
				var_83_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_6 = var_83_5:GetComponent("SpriteRenderer")

				if var_83_6 and var_83_6.sprite then
					local var_83_7 = (var_83_5.transform.localPosition - var_83_3).z
					local var_83_8 = manager.ui.mainCameraCom_
					local var_83_9 = 2 * var_83_7 * Mathf.Tan(var_83_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_10 = var_83_9 * var_83_8.aspect
					local var_83_11 = var_83_6.sprite.bounds.size.x
					local var_83_12 = var_83_6.sprite.bounds.size.y
					local var_83_13 = var_83_10 / var_83_11
					local var_83_14 = var_83_9 / var_83_12
					local var_83_15 = var_83_14 < var_83_13 and var_83_13 or var_83_14

					var_83_5.transform.localScale = Vector3.New(var_83_15, var_83_15, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "STblack" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_17 = 0.3

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_18 = 0

			if var_83_18 < arg_80_1.time_ and arg_80_1.time_ <= var_83_18 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_19 = 1.03400000184774

			if var_83_18 <= arg_80_1.time_ and arg_80_1.time_ < var_83_18 + var_83_19 then
				local var_83_20 = (arg_80_1.time_ - var_83_18) / var_83_19
				local var_83_21 = Color.New(0, 0, 0)

				var_83_21.a = Mathf.Lerp(0, 1, var_83_20)
				arg_80_1.mask_.color = var_83_21
			end

			if arg_80_1.time_ >= var_83_18 + var_83_19 and arg_80_1.time_ < var_83_18 + var_83_19 + arg_83_0 then
				local var_83_22 = Color.New(0, 0, 0)

				var_83_22.a = 1
				arg_80_1.mask_.color = var_83_22
			end

			local var_83_23 = 1.03400000184774

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_24 = 2

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24
				local var_83_26 = Color.New(0, 0, 0)

				var_83_26.a = Mathf.Lerp(1, 0, var_83_25)
				arg_80_1.mask_.color = var_83_26
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 then
				local var_83_27 = Color.New(0, 0, 0)
				local var_83_28 = 0

				arg_80_1.mask_.enabled = false
				var_83_27.a = var_83_28
				arg_80_1.mask_.color = var_83_27
			end

			local var_83_29 = arg_80_1.actors_["1054ui_story"].transform
			local var_83_30 = 1

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 then
				arg_80_1.var_.moveOldPos1054ui_story = var_83_29.localPosition

				local var_83_31 = GameObjectTools.GetOrAddComponent(var_83_29.gameObject, typeof(DynamicBoneHelper))

				if var_83_31 then
					var_83_31:EnableDynamicBone(false)
				end
			end

			local var_83_32 = 0.001

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_32 then
				local var_83_33 = (arg_80_1.time_ - var_83_30) / var_83_32
				local var_83_34 = Vector3.New(0, 100, 0)

				var_83_29.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1054ui_story, var_83_34, var_83_33)

				local var_83_35 = manager.ui.mainCamera.transform.position - var_83_29.position

				var_83_29.forward = Vector3.New(var_83_35.x, var_83_35.y, var_83_35.z)

				local var_83_36 = var_83_29.localEulerAngles

				var_83_36.z = 0
				var_83_36.x = 0
				var_83_29.localEulerAngles = var_83_36
			end

			if arg_80_1.time_ >= var_83_30 + var_83_32 and arg_80_1.time_ < var_83_30 + var_83_32 + arg_83_0 then
				var_83_29.localPosition = Vector3.New(0, 100, 0)

				local var_83_37 = manager.ui.mainCamera.transform.position - var_83_29.position

				var_83_29.forward = Vector3.New(var_83_37.x, var_83_37.y, var_83_37.z)

				local var_83_38 = var_83_29.localEulerAngles

				var_83_38.z = 0
				var_83_38.x = 0
				var_83_29.localEulerAngles = var_83_38

				local var_83_39 = GameObjectTools.GetOrAddComponent(var_83_29.gameObject, typeof(DynamicBoneHelper))

				if var_83_39 then
					var_83_39:EnableDynamicBone(true)
				end
			end

			local var_83_40 = arg_80_1.actors_["6148ui_story"].transform
			local var_83_41 = 1

			if var_83_41 < arg_80_1.time_ and arg_80_1.time_ <= var_83_41 + arg_83_0 then
				arg_80_1.var_.moveOldPos6148ui_story = var_83_40.localPosition

				local var_83_42 = GameObjectTools.GetOrAddComponent(var_83_40.gameObject, typeof(DynamicBoneHelper))

				if var_83_42 then
					var_83_42:EnableDynamicBone(false)
				end
			end

			local var_83_43 = 0.001

			if var_83_41 <= arg_80_1.time_ and arg_80_1.time_ < var_83_41 + var_83_43 then
				local var_83_44 = (arg_80_1.time_ - var_83_41) / var_83_43
				local var_83_45 = Vector3.New(0, 100, 0)

				var_83_40.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos6148ui_story, var_83_45, var_83_44)

				local var_83_46 = manager.ui.mainCamera.transform.position - var_83_40.position

				var_83_40.forward = Vector3.New(var_83_46.x, var_83_46.y, var_83_46.z)

				local var_83_47 = var_83_40.localEulerAngles

				var_83_47.z = 0
				var_83_47.x = 0
				var_83_40.localEulerAngles = var_83_47
			end

			if arg_80_1.time_ >= var_83_41 + var_83_43 and arg_80_1.time_ < var_83_41 + var_83_43 + arg_83_0 then
				var_83_40.localPosition = Vector3.New(0, 100, 0)

				local var_83_48 = manager.ui.mainCamera.transform.position - var_83_40.position

				var_83_40.forward = Vector3.New(var_83_48.x, var_83_48.y, var_83_48.z)

				local var_83_49 = var_83_40.localEulerAngles

				var_83_49.z = 0
				var_83_49.x = 0
				var_83_40.localEulerAngles = var_83_49

				local var_83_50 = GameObjectTools.GetOrAddComponent(var_83_40.gameObject, typeof(DynamicBoneHelper))

				if var_83_50 then
					var_83_50:EnableDynamicBone(true)
				end
			end

			local var_83_51 = 1

			if var_83_51 < arg_80_1.time_ and arg_80_1.time_ <= var_83_51 + arg_83_0 then
				arg_80_1.fswbg_:SetActive(true)
				arg_80_1.dialog_:SetActive(false)

				arg_80_1.fswtw_.percent = 0

				local var_83_52 = arg_80_1:GetWordFromCfg(324101019)
				local var_83_53 = arg_80_1:FormatText(var_83_52.content)

				arg_80_1.fswt_.text = var_83_53

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.fswt_)

				arg_80_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_80_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_80_1.fswtw_:SetDirty()

				arg_80_1.typewritterCharCountI18N = 0

				SetActive(arg_80_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_80_1:ShowNextGo(false)
			end

			local var_83_54 = 1.96666666666667

			if var_83_54 < arg_80_1.time_ and arg_80_1.time_ <= var_83_54 + arg_83_0 then
				arg_80_1.var_.oldValueTypewriter = arg_80_1.fswtw_.percent

				SetActive(arg_80_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_80_1:ShowNextGo(false)
			end

			local var_83_55 = 4
			local var_83_56 = 0.266666666666667
			local var_83_57 = arg_80_1:GetWordFromCfg(324101019)
			local var_83_58 = arg_80_1:FormatText(var_83_57.content)
			local var_83_59, var_83_60 = arg_80_1:GetPercentByPara(var_83_58, 1)

			if var_83_54 < arg_80_1.time_ and arg_80_1.time_ <= var_83_54 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				local var_83_61 = var_83_55 <= 0 and var_83_56 or var_83_56 * ((var_83_60 - arg_80_1.typewritterCharCountI18N) / var_83_55)

				if var_83_61 > 0 and var_83_56 < var_83_61 then
					arg_80_1.talkMaxDuration = var_83_61

					if var_83_61 + var_83_54 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_61 + var_83_54
					end
				end
			end

			local var_83_62 = 0.266666666666667
			local var_83_63 = math.max(var_83_62, arg_80_1.talkMaxDuration)

			if var_83_54 <= arg_80_1.time_ and arg_80_1.time_ < var_83_54 + var_83_63 then
				local var_83_64 = (arg_80_1.time_ - var_83_54) / var_83_63

				arg_80_1.fswtw_.percent = Mathf.Lerp(arg_80_1.var_.oldValueTypewriter, var_83_59, var_83_64)
				arg_80_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_80_1.fswtw_:SetDirty()
			end

			if arg_80_1.time_ >= var_83_54 + var_83_63 and arg_80_1.time_ < var_83_54 + var_83_63 + arg_83_0 then
				arg_80_1.fswtw_.percent = var_83_59

				arg_80_1.fswtw_:SetDirty()
				arg_80_1:ShowNextGo(true)

				arg_80_1.typewritterCharCountI18N = var_83_60
			end

			local var_83_65 = 1

			if var_83_65 < arg_80_1.time_ and arg_80_1.time_ <= var_83_65 + arg_83_0 then
				local var_83_66 = arg_80_1.fswbg_.transform:Find("textbox/adapt/content") or arg_80_1.fswbg_.transform:Find("textbox/content")
				local var_83_67 = arg_80_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_83_68 = var_83_66:GetComponent("Text")
				local var_83_69 = var_83_66:GetComponent("RectTransform")

				var_83_68.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_83_69.offsetMin = Vector2.New(0, 8.6)
				var_83_69.offsetMax = Vector2.New(-21, -33.84)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play324101020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324101020
		arg_84_1.duration_ = 7.27

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324101021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 1.23333333333333

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_1 = manager.ui.mainCamera.transform.localPosition
				local var_87_2 = Vector3.New(0, 0, 10) + Vector3.New(var_87_1.x, var_87_1.y, 0)
				local var_87_3 = arg_84_1.bgs_.ST2008

				var_87_3.transform.localPosition = var_87_2
				var_87_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_4 = var_87_3:GetComponent("SpriteRenderer")

				if var_87_4 and var_87_4.sprite then
					local var_87_5 = (var_87_3.transform.localPosition - var_87_1).z
					local var_87_6 = manager.ui.mainCameraCom_
					local var_87_7 = 2 * var_87_5 * Mathf.Tan(var_87_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_87_8 = var_87_7 * var_87_6.aspect
					local var_87_9 = var_87_4.sprite.bounds.size.x
					local var_87_10 = var_87_4.sprite.bounds.size.y
					local var_87_11 = var_87_8 / var_87_9
					local var_87_12 = var_87_7 / var_87_10
					local var_87_13 = var_87_12 < var_87_11 and var_87_11 or var_87_12

					var_87_3.transform.localScale = Vector3.New(var_87_13, var_87_13, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "ST2008" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			local var_87_15 = 0.3

			if arg_84_1.time_ >= var_87_14 + var_87_15 and arg_84_1.time_ < var_87_14 + var_87_15 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_16 = 0

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_17 = 1.23333333333333

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_17 then
				local var_87_18 = (arg_84_1.time_ - var_87_16) / var_87_17
				local var_87_19 = Color.New(0, 0, 0)

				var_87_19.a = Mathf.Lerp(0, 1, var_87_18)
				arg_84_1.mask_.color = var_87_19
			end

			if arg_84_1.time_ >= var_87_16 + var_87_17 and arg_84_1.time_ < var_87_16 + var_87_17 + arg_87_0 then
				local var_87_20 = Color.New(0, 0, 0)

				var_87_20.a = 1
				arg_84_1.mask_.color = var_87_20
			end

			local var_87_21 = 1.23333333333333

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_22 = 1.63333333333333

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22
				local var_87_24 = Color.New(0, 0, 0)

				var_87_24.a = Mathf.Lerp(1, 0, var_87_23)
				arg_84_1.mask_.color = var_87_24
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 then
				local var_87_25 = Color.New(0, 0, 0)
				local var_87_26 = 0

				arg_84_1.mask_.enabled = false
				var_87_25.a = var_87_26
				arg_84_1.mask_.color = var_87_25
			end

			local var_87_27 = 1.23333333333333

			if var_87_27 < arg_84_1.time_ and arg_84_1.time_ <= var_87_27 + arg_87_0 then
				arg_84_1.fswbg_:SetActive(false)
				arg_84_1.dialog_:SetActive(false)
				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_28 = 1.25

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.fswbg_:SetActive(false)
				arg_84_1.dialog_:SetActive(false)
				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_29 = 2.26666666666667
			local var_87_30 = 0.75

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_31 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_31:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_32 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_33 = arg_84_1:GetWordFromCfg(324101020)
				local var_87_34 = arg_84_1:FormatText(var_87_33.content)

				arg_84_1.text_.text = var_87_34

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_35 = 30
				local var_87_36 = utf8.len(var_87_34)
				local var_87_37 = var_87_35 <= 0 and var_87_30 or var_87_30 * (var_87_36 / var_87_35)

				if var_87_37 > 0 and var_87_30 < var_87_37 then
					arg_84_1.talkMaxDuration = var_87_37
					var_87_29 = var_87_29 + 0.3

					if var_87_37 + var_87_29 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_29
					end
				end

				arg_84_1.text_.text = var_87_34
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_38 = var_87_29 + 0.3
			local var_87_39 = math.max(var_87_30, arg_84_1.talkMaxDuration)

			if var_87_38 <= arg_84_1.time_ and arg_84_1.time_ < var_87_38 + var_87_39 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_38) / var_87_39

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_38 + var_87_39 and arg_84_1.time_ < var_87_38 + var_87_39 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324101021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324101021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324101022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.925

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(324101021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 37
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324101022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324101022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324101023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.55

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(324101022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 62
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324101023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324101023
		arg_98_1.duration_ = 4.9

		local var_98_0 = {
			zh = 3.4,
			ja = 4.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324101024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1054ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1054ui_story = var_101_0.localPosition

				local var_101_2 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(false)
				end
			end

			local var_101_3 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_1) / var_101_3
				local var_101_5 = Vector3.New(-0.7, -0.985, -6)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1054ui_story, var_101_5, var_101_4)

				local var_101_6 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_6.x, var_101_6.y, var_101_6.z)

				local var_101_7 = var_101_0.localEulerAngles

				var_101_7.z = 0
				var_101_7.x = 0
				var_101_0.localEulerAngles = var_101_7
			end

			if arg_98_1.time_ >= var_101_1 + var_101_3 and arg_98_1.time_ < var_101_1 + var_101_3 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_101_8 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_8.x, var_101_8.y, var_101_8.z)

				local var_101_9 = var_101_0.localEulerAngles

				var_101_9.z = 0
				var_101_9.x = 0
				var_101_0.localEulerAngles = var_101_9

				local var_101_10 = GameObjectTools.GetOrAddComponent(var_101_0.gameObject, typeof(DynamicBoneHelper))

				if var_101_10 then
					var_101_10:EnableDynamicBone(true)
				end
			end

			local var_101_11 = arg_98_1.actors_["1054ui_story"]
			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect1054ui_story == nil then
				arg_98_1.var_.characterEffect1054ui_story = var_101_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_13 and not isNil(var_101_11) then
				local var_101_14 = (arg_98_1.time_ - var_101_12) / var_101_13

				if arg_98_1.var_.characterEffect1054ui_story and not isNil(var_101_11) then
					arg_98_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_12 + var_101_13 and arg_98_1.time_ < var_101_12 + var_101_13 + arg_101_0 and not isNil(var_101_11) and arg_98_1.var_.characterEffect1054ui_story then
				arg_98_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_101_15 = 0

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_101_17 = 0
			local var_101_18 = 0.25

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_19 = arg_98_1:FormatText(StoryNameCfg[1487].name)

				arg_98_1.leftNameTxt_.text = var_101_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_20 = arg_98_1:GetWordFromCfg(324101023)
				local var_101_21 = arg_98_1:FormatText(var_101_20.content)

				arg_98_1.text_.text = var_101_21

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_22 = 10
				local var_101_23 = utf8.len(var_101_21)
				local var_101_24 = var_101_22 <= 0 and var_101_18 or var_101_18 * (var_101_23 / var_101_22)

				if var_101_24 > 0 and var_101_18 < var_101_24 then
					arg_98_1.talkMaxDuration = var_101_24

					if var_101_24 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_17
					end
				end

				arg_98_1.text_.text = var_101_21
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101023", "story_v_out_324101.awb") ~= 0 then
					local var_101_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101023", "story_v_out_324101.awb") / 1000

					if var_101_25 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_25 + var_101_17
					end

					if var_101_20.prefab_name ~= "" and arg_98_1.actors_[var_101_20.prefab_name] ~= nil then
						local var_101_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_20.prefab_name].transform, "story_v_out_324101", "324101023", "story_v_out_324101.awb")

						arg_98_1:RecordAudio("324101023", var_101_26)
						arg_98_1:RecordAudio("324101023", var_101_26)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324101", "324101023", "story_v_out_324101.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324101", "324101023", "story_v_out_324101.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_27 = math.max(var_101_18, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_27 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_17) / var_101_27

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_27 and arg_98_1.time_ < var_101_17 + var_101_27 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play324101024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324101024
		arg_102_1.duration_ = 3.2

		local var_102_0 = {
			zh = 2.5,
			ja = 3.2
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324101025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["6148ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos6148ui_story = var_105_0.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_3 then
				local var_105_4 = (arg_102_1.time_ - var_105_1) / var_105_3
				local var_105_5 = Vector3.New(0.7, -0.985, -6)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos6148ui_story, var_105_5, var_105_4)

				local var_105_6 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_6.x, var_105_6.y, var_105_6.z)

				local var_105_7 = var_105_0.localEulerAngles

				var_105_7.z = 0
				var_105_7.x = 0
				var_105_0.localEulerAngles = var_105_7
			end

			if arg_102_1.time_ >= var_105_1 + var_105_3 and arg_102_1.time_ < var_105_1 + var_105_3 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_105_8 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_8.x, var_105_8.y, var_105_8.z)

				local var_105_9 = var_105_0.localEulerAngles

				var_105_9.z = 0
				var_105_9.x = 0
				var_105_0.localEulerAngles = var_105_9

				local var_105_10 = GameObjectTools.GetOrAddComponent(var_105_0.gameObject, typeof(DynamicBoneHelper))

				if var_105_10 then
					var_105_10:EnableDynamicBone(true)
				end
			end

			local var_105_11 = arg_102_1.actors_["6148ui_story"]
			local var_105_12 = 0

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect6148ui_story == nil then
				arg_102_1.var_.characterEffect6148ui_story = var_105_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_13 = 0.200000002980232

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_13 and not isNil(var_105_11) then
				local var_105_14 = (arg_102_1.time_ - var_105_12) / var_105_13

				if arg_102_1.var_.characterEffect6148ui_story and not isNil(var_105_11) then
					arg_102_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_12 + var_105_13 and arg_102_1.time_ < var_105_12 + var_105_13 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect6148ui_story then
				arg_102_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_105_15 = arg_102_1.actors_["1054ui_story"]
			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 and not isNil(var_105_15) and arg_102_1.var_.characterEffect1054ui_story == nil then
				arg_102_1.var_.characterEffect1054ui_story = var_105_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_17 = 0.200000002980232

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_17 and not isNil(var_105_15) then
				local var_105_18 = (arg_102_1.time_ - var_105_16) / var_105_17

				if arg_102_1.var_.characterEffect1054ui_story and not isNil(var_105_15) then
					local var_105_19 = Mathf.Lerp(0, 0.5, var_105_18)

					arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1054ui_story.fillRatio = var_105_19
				end
			end

			if arg_102_1.time_ >= var_105_16 + var_105_17 and arg_102_1.time_ < var_105_16 + var_105_17 + arg_105_0 and not isNil(var_105_15) and arg_102_1.var_.characterEffect1054ui_story then
				local var_105_20 = 0.5

				arg_102_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1054ui_story.fillRatio = var_105_20
			end

			local var_105_21 = 0

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_105_22 = 0

			if var_105_22 < arg_102_1.time_ and arg_102_1.time_ <= var_105_22 + arg_105_0 then
				arg_102_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_105_23 = 0
			local var_105_24 = 0.225

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_25 = arg_102_1:FormatText(StoryNameCfg[1488].name)

				arg_102_1.leftNameTxt_.text = var_105_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_26 = arg_102_1:GetWordFromCfg(324101024)
				local var_105_27 = arg_102_1:FormatText(var_105_26.content)

				arg_102_1.text_.text = var_105_27

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_28 = 9
				local var_105_29 = utf8.len(var_105_27)
				local var_105_30 = var_105_28 <= 0 and var_105_24 or var_105_24 * (var_105_29 / var_105_28)

				if var_105_30 > 0 and var_105_24 < var_105_30 then
					arg_102_1.talkMaxDuration = var_105_30

					if var_105_30 + var_105_23 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_30 + var_105_23
					end
				end

				arg_102_1.text_.text = var_105_27
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101024", "story_v_out_324101.awb") ~= 0 then
					local var_105_31 = manager.audio:GetVoiceLength("story_v_out_324101", "324101024", "story_v_out_324101.awb") / 1000

					if var_105_31 + var_105_23 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_31 + var_105_23
					end

					if var_105_26.prefab_name ~= "" and arg_102_1.actors_[var_105_26.prefab_name] ~= nil then
						local var_105_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_26.prefab_name].transform, "story_v_out_324101", "324101024", "story_v_out_324101.awb")

						arg_102_1:RecordAudio("324101024", var_105_32)
						arg_102_1:RecordAudio("324101024", var_105_32)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324101", "324101024", "story_v_out_324101.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324101", "324101024", "story_v_out_324101.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_33 = math.max(var_105_24, arg_102_1.talkMaxDuration)

			if var_105_23 <= arg_102_1.time_ and arg_102_1.time_ < var_105_23 + var_105_33 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_23) / var_105_33

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_23 + var_105_33 and arg_102_1.time_ < var_105_23 + var_105_33 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play324101025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324101025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324101026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["6148ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect6148ui_story == nil then
				arg_106_1.var_.characterEffect6148ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect6148ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_106_1.var_.characterEffect6148ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect6148ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_106_1.var_.characterEffect6148ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.975

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[7].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(324101025)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 39
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324101026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324101026
		arg_110_1.duration_ = 13.03

		local var_110_0 = {
			zh = 9,
			ja = 13.033
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324101027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["6148ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect6148ui_story == nil then
				arg_110_1.var_.characterEffect6148ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect6148ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect6148ui_story then
				arg_110_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_113_4 = 0

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_113_6 = 0
			local var_113_7 = 1.025

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[1488].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_9 = arg_110_1:GetWordFromCfg(324101026)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 41
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101026", "story_v_out_324101.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_324101", "324101026", "story_v_out_324101.awb") / 1000

					if var_113_14 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_6
					end

					if var_113_9.prefab_name ~= "" and arg_110_1.actors_[var_113_9.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_9.prefab_name].transform, "story_v_out_324101", "324101026", "story_v_out_324101.awb")

						arg_110_1:RecordAudio("324101026", var_113_15)
						arg_110_1:RecordAudio("324101026", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324101", "324101026", "story_v_out_324101.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324101", "324101026", "story_v_out_324101.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_16 and arg_110_1.time_ < var_113_6 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324101027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324101027
		arg_114_1.duration_ = 3.1

		local var_114_0 = {
			zh = 2.566,
			ja = 3.1
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324101028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1054ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1054ui_story == nil then
				arg_114_1.var_.characterEffect1054ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1054ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1054ui_story then
				arg_114_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["6148ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect6148ui_story == nil then
				arg_114_1.var_.characterEffect6148ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect6148ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_114_1.var_.characterEffect6148ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect6148ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_114_1.var_.characterEffect6148ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_117_11 = 0
			local var_117_12 = 0.25

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_13 = arg_114_1:FormatText(StoryNameCfg[1487].name)

				arg_114_1.leftNameTxt_.text = var_117_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_14 = arg_114_1:GetWordFromCfg(324101027)
				local var_117_15 = arg_114_1:FormatText(var_117_14.content)

				arg_114_1.text_.text = var_117_15

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_16 = 10
				local var_117_17 = utf8.len(var_117_15)
				local var_117_18 = var_117_16 <= 0 and var_117_12 or var_117_12 * (var_117_17 / var_117_16)

				if var_117_18 > 0 and var_117_12 < var_117_18 then
					arg_114_1.talkMaxDuration = var_117_18

					if var_117_18 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_11
					end
				end

				arg_114_1.text_.text = var_117_15
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101027", "story_v_out_324101.awb") ~= 0 then
					local var_117_19 = manager.audio:GetVoiceLength("story_v_out_324101", "324101027", "story_v_out_324101.awb") / 1000

					if var_117_19 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_11
					end

					if var_117_14.prefab_name ~= "" and arg_114_1.actors_[var_117_14.prefab_name] ~= nil then
						local var_117_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_14.prefab_name].transform, "story_v_out_324101", "324101027", "story_v_out_324101.awb")

						arg_114_1:RecordAudio("324101027", var_117_20)
						arg_114_1:RecordAudio("324101027", var_117_20)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_324101", "324101027", "story_v_out_324101.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_324101", "324101027", "story_v_out_324101.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_21 = math.max(var_117_12, arg_114_1.talkMaxDuration)

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_21 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_11) / var_117_21

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_11 + var_117_21 and arg_114_1.time_ < var_117_11 + var_117_21 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324101028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324101028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324101029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1054ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1054ui_story == nil then
				arg_118_1.var_.characterEffect1054ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1054ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1054ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1054ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1054ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.225

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(324101028)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 9
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324101029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324101029
		arg_122_1.duration_ = 6.8

		local var_122_0 = {
			zh = 6.8,
			ja = 5.1
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324101030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1054ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1054ui_story == nil then
				arg_122_1.var_.characterEffect1054ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1054ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1054ui_story then
				arg_122_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_125_6 = 0
			local var_125_7 = 0.5

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[1487].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:GetWordFromCfg(324101029)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 20
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101029", "story_v_out_324101.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_324101", "324101029", "story_v_out_324101.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_324101", "324101029", "story_v_out_324101.awb")

						arg_122_1:RecordAudio("324101029", var_125_15)
						arg_122_1:RecordAudio("324101029", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_324101", "324101029", "story_v_out_324101.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_324101", "324101029", "story_v_out_324101.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324101030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324101030
		arg_126_1.duration_ = 4.07

		local var_126_0 = {
			zh = 4.066,
			ja = 3.666
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324101031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["6148ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect6148ui_story == nil then
				arg_126_1.var_.characterEffect6148ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect6148ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect6148ui_story then
				arg_126_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["1054ui_story"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1054ui_story == nil then
				arg_126_1.var_.characterEffect1054ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect1054ui_story and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1054ui_story.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1054ui_story then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1054ui_story.fillRatio = var_129_9
			end

			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_129_12 = 0
			local var_129_13 = 0.425

			if var_129_12 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_14 = arg_126_1:FormatText(StoryNameCfg[1488].name)

				arg_126_1.leftNameTxt_.text = var_129_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:GetWordFromCfg(324101030)
				local var_129_16 = arg_126_1:FormatText(var_129_15.content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 17
				local var_129_18 = utf8.len(var_129_16)
				local var_129_19 = var_129_17 <= 0 and var_129_13 or var_129_13 * (var_129_18 / var_129_17)

				if var_129_19 > 0 and var_129_13 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19

					if var_129_19 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_12
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101030", "story_v_out_324101.awb") ~= 0 then
					local var_129_20 = manager.audio:GetVoiceLength("story_v_out_324101", "324101030", "story_v_out_324101.awb") / 1000

					if var_129_20 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_20 + var_129_12
					end

					if var_129_15.prefab_name ~= "" and arg_126_1.actors_[var_129_15.prefab_name] ~= nil then
						local var_129_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_15.prefab_name].transform, "story_v_out_324101", "324101030", "story_v_out_324101.awb")

						arg_126_1:RecordAudio("324101030", var_129_21)
						arg_126_1:RecordAudio("324101030", var_129_21)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324101", "324101030", "story_v_out_324101.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324101", "324101030", "story_v_out_324101.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_22 = math.max(var_129_13, arg_126_1.talkMaxDuration)

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_22 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_12) / var_129_22

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_12 + var_129_22 and arg_126_1.time_ < var_129_12 + var_129_22 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324101031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324101031
		arg_130_1.duration_ = 6.93

		local var_130_0 = {
			zh = 6.933,
			ja = 5.966
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324101032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1054ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1054ui_story == nil then
				arg_130_1.var_.characterEffect1054ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1054ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1054ui_story then
				arg_130_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["6148ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect6148ui_story == nil then
				arg_130_1.var_.characterEffect6148ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect6148ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_130_1.var_.characterEffect6148ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect6148ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_130_1.var_.characterEffect6148ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_133_12 = 0
			local var_133_13 = 0.625

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[1487].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(324101031)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 25
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101031", "story_v_out_324101.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_324101", "324101031", "story_v_out_324101.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_324101", "324101031", "story_v_out_324101.awb")

						arg_130_1:RecordAudio("324101031", var_133_21)
						arg_130_1:RecordAudio("324101031", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_324101", "324101031", "story_v_out_324101.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_324101", "324101031", "story_v_out_324101.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play324101032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324101032
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324101033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["6148ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect6148ui_story == nil then
				arg_134_1.var_.characterEffect6148ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect6148ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect6148ui_story then
				arg_134_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1054ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1054ui_story == nil then
				arg_134_1.var_.characterEffect1054ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.200000002980232

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1054ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1054ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1054ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1054ui_story.fillRatio = var_137_9
			end

			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_137_11 = 0
			local var_137_12 = 0.075

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_13 = arg_134_1:FormatText(StoryNameCfg[1488].name)

				arg_134_1.leftNameTxt_.text = var_137_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_14 = arg_134_1:GetWordFromCfg(324101032)
				local var_137_15 = arg_134_1:FormatText(var_137_14.content)

				arg_134_1.text_.text = var_137_15

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_16 = 3
				local var_137_17 = utf8.len(var_137_15)
				local var_137_18 = var_137_16 <= 0 and var_137_12 or var_137_12 * (var_137_17 / var_137_16)

				if var_137_18 > 0 and var_137_12 < var_137_18 then
					arg_134_1.talkMaxDuration = var_137_18

					if var_137_18 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_11
					end
				end

				arg_134_1.text_.text = var_137_15
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101032", "story_v_out_324101.awb") ~= 0 then
					local var_137_19 = manager.audio:GetVoiceLength("story_v_out_324101", "324101032", "story_v_out_324101.awb") / 1000

					if var_137_19 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_19 + var_137_11
					end

					if var_137_14.prefab_name ~= "" and arg_134_1.actors_[var_137_14.prefab_name] ~= nil then
						local var_137_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_14.prefab_name].transform, "story_v_out_324101", "324101032", "story_v_out_324101.awb")

						arg_134_1:RecordAudio("324101032", var_137_20)
						arg_134_1:RecordAudio("324101032", var_137_20)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_324101", "324101032", "story_v_out_324101.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_324101", "324101032", "story_v_out_324101.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_21 = math.max(var_137_12, arg_134_1.talkMaxDuration)

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_21 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_11) / var_137_21

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_11 + var_137_21 and arg_134_1.time_ < var_137_11 + var_137_21 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324101033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324101033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play324101034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1054ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1054ui_story = var_141_0.localPosition

				local var_141_2 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(false)
				end
			end

			local var_141_3 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_3 then
				local var_141_4 = (arg_138_1.time_ - var_141_1) / var_141_3
				local var_141_5 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1054ui_story, var_141_5, var_141_4)

				local var_141_6 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_6.x, var_141_6.y, var_141_6.z)

				local var_141_7 = var_141_0.localEulerAngles

				var_141_7.z = 0
				var_141_7.x = 0
				var_141_0.localEulerAngles = var_141_7
			end

			if arg_138_1.time_ >= var_141_1 + var_141_3 and arg_138_1.time_ < var_141_1 + var_141_3 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_8 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_8.x, var_141_8.y, var_141_8.z)

				local var_141_9 = var_141_0.localEulerAngles

				var_141_9.z = 0
				var_141_9.x = 0
				var_141_0.localEulerAngles = var_141_9

				local var_141_10 = GameObjectTools.GetOrAddComponent(var_141_0.gameObject, typeof(DynamicBoneHelper))

				if var_141_10 then
					var_141_10:EnableDynamicBone(true)
				end
			end

			local var_141_11 = arg_138_1.actors_["6148ui_story"].transform
			local var_141_12 = 0

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.var_.moveOldPos6148ui_story = var_141_11.localPosition

				local var_141_13 = GameObjectTools.GetOrAddComponent(var_141_11.gameObject, typeof(DynamicBoneHelper))

				if var_141_13 then
					var_141_13:EnableDynamicBone(false)
				end
			end

			local var_141_14 = 0.001

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_14 then
				local var_141_15 = (arg_138_1.time_ - var_141_12) / var_141_14
				local var_141_16 = Vector3.New(0, 100, 0)

				var_141_11.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos6148ui_story, var_141_16, var_141_15)

				local var_141_17 = manager.ui.mainCamera.transform.position - var_141_11.position

				var_141_11.forward = Vector3.New(var_141_17.x, var_141_17.y, var_141_17.z)

				local var_141_18 = var_141_11.localEulerAngles

				var_141_18.z = 0
				var_141_18.x = 0
				var_141_11.localEulerAngles = var_141_18
			end

			if arg_138_1.time_ >= var_141_12 + var_141_14 and arg_138_1.time_ < var_141_12 + var_141_14 + arg_141_0 then
				var_141_11.localPosition = Vector3.New(0, 100, 0)

				local var_141_19 = manager.ui.mainCamera.transform.position - var_141_11.position

				var_141_11.forward = Vector3.New(var_141_19.x, var_141_19.y, var_141_19.z)

				local var_141_20 = var_141_11.localEulerAngles

				var_141_20.z = 0
				var_141_20.x = 0
				var_141_11.localEulerAngles = var_141_20

				local var_141_21 = GameObjectTools.GetOrAddComponent(var_141_11.gameObject, typeof(DynamicBoneHelper))

				if var_141_21 then
					var_141_21:EnableDynamicBone(true)
				end
			end

			local var_141_22 = arg_138_1.actors_["6148ui_story"]
			local var_141_23 = 0

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 and not isNil(var_141_22) and arg_138_1.var_.characterEffect6148ui_story == nil then
				arg_138_1.var_.characterEffect6148ui_story = var_141_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_24 = 0.200000002980232

			if var_141_23 <= arg_138_1.time_ and arg_138_1.time_ < var_141_23 + var_141_24 and not isNil(var_141_22) then
				local var_141_25 = (arg_138_1.time_ - var_141_23) / var_141_24

				if arg_138_1.var_.characterEffect6148ui_story and not isNil(var_141_22) then
					local var_141_26 = Mathf.Lerp(0, 0.5, var_141_25)

					arg_138_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_138_1.var_.characterEffect6148ui_story.fillRatio = var_141_26
				end
			end

			if arg_138_1.time_ >= var_141_23 + var_141_24 and arg_138_1.time_ < var_141_23 + var_141_24 + arg_141_0 and not isNil(var_141_22) and arg_138_1.var_.characterEffect6148ui_story then
				local var_141_27 = 0.5

				arg_138_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_138_1.var_.characterEffect6148ui_story.fillRatio = var_141_27
			end

			local var_141_28 = 0
			local var_141_29 = 1.1

			if var_141_28 < arg_138_1.time_ and arg_138_1.time_ <= var_141_28 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_30 = arg_138_1:GetWordFromCfg(324101033)
				local var_141_31 = arg_138_1:FormatText(var_141_30.content)

				arg_138_1.text_.text = var_141_31

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_32 = 44
				local var_141_33 = utf8.len(var_141_31)
				local var_141_34 = var_141_32 <= 0 and var_141_29 or var_141_29 * (var_141_33 / var_141_32)

				if var_141_34 > 0 and var_141_29 < var_141_34 then
					arg_138_1.talkMaxDuration = var_141_34

					if var_141_34 + var_141_28 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_34 + var_141_28
					end
				end

				arg_138_1.text_.text = var_141_31
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_35 = math.max(var_141_29, arg_138_1.talkMaxDuration)

			if var_141_28 <= arg_138_1.time_ and arg_138_1.time_ < var_141_28 + var_141_35 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_28) / var_141_35

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_28 + var_141_35 and arg_138_1.time_ < var_141_28 + var_141_35 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play324101034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324101034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324101035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.7

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(324101034)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 28
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324101035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324101035
		arg_146_1.duration_ = 7.57

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324101036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.2

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				local var_149_1 = manager.ui.mainCamera.transform.localPosition
				local var_149_2 = Vector3.New(0, 0, 10) + Vector3.New(var_149_1.x, var_149_1.y, 0)
				local var_149_3 = arg_146_1.bgs_.ST2007

				var_149_3.transform.localPosition = var_149_2
				var_149_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_4 = var_149_3:GetComponent("SpriteRenderer")

				if var_149_4 and var_149_4.sprite then
					local var_149_5 = (var_149_3.transform.localPosition - var_149_1).z
					local var_149_6 = manager.ui.mainCameraCom_
					local var_149_7 = 2 * var_149_5 * Mathf.Tan(var_149_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_149_8 = var_149_7 * var_149_6.aspect
					local var_149_9 = var_149_4.sprite.bounds.size.x
					local var_149_10 = var_149_4.sprite.bounds.size.y
					local var_149_11 = var_149_8 / var_149_9
					local var_149_12 = var_149_7 / var_149_10
					local var_149_13 = var_149_12 < var_149_11 and var_149_11 or var_149_12

					var_149_3.transform.localScale = Vector3.New(var_149_13, var_149_13, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "ST2007" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			local var_149_15 = 0.3

			if arg_146_1.time_ >= var_149_14 + var_149_15 and arg_146_1.time_ < var_149_14 + var_149_15 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_16 = 0

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_17 = 1.2

			if var_149_16 <= arg_146_1.time_ and arg_146_1.time_ < var_149_16 + var_149_17 then
				local var_149_18 = (arg_146_1.time_ - var_149_16) / var_149_17
				local var_149_19 = Color.New(0, 0, 0)

				var_149_19.a = Mathf.Lerp(0, 1, var_149_18)
				arg_146_1.mask_.color = var_149_19
			end

			if arg_146_1.time_ >= var_149_16 + var_149_17 and arg_146_1.time_ < var_149_16 + var_149_17 + arg_149_0 then
				local var_149_20 = Color.New(0, 0, 0)

				var_149_20.a = 1
				arg_146_1.mask_.color = var_149_20
			end

			local var_149_21 = 1.2

			if var_149_21 < arg_146_1.time_ and arg_146_1.time_ <= var_149_21 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_22 = 1.36666666666667

			if var_149_21 <= arg_146_1.time_ and arg_146_1.time_ < var_149_21 + var_149_22 then
				local var_149_23 = (arg_146_1.time_ - var_149_21) / var_149_22
				local var_149_24 = Color.New(0, 0, 0)

				var_149_24.a = Mathf.Lerp(1, 0, var_149_23)
				arg_146_1.mask_.color = var_149_24
			end

			if arg_146_1.time_ >= var_149_21 + var_149_22 and arg_146_1.time_ < var_149_21 + var_149_22 + arg_149_0 then
				local var_149_25 = Color.New(0, 0, 0)
				local var_149_26 = 0

				arg_146_1.mask_.enabled = false
				var_149_25.a = var_149_26
				arg_146_1.mask_.color = var_149_25
			end

			local var_149_27 = 1.2
			local var_149_28 = 1

			if var_149_27 < arg_146_1.time_ and arg_146_1.time_ <= var_149_27 + arg_149_0 then
				local var_149_29 = "play"
				local var_149_30 = "effect"

				arg_146_1:AudioAction(var_149_29, var_149_30, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_149_31 = 0.1
			local var_149_32 = 1

			if var_149_31 < arg_146_1.time_ and arg_146_1.time_ <= var_149_31 + arg_149_0 then
				local var_149_33 = "stop"
				local var_149_34 = "effect"

				arg_146_1:AudioAction(var_149_33, var_149_34, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_35 = 2.56666666666667
			local var_149_36 = 0.3

			if var_149_35 < arg_146_1.time_ and arg_146_1.time_ <= var_149_35 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_37 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_37:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_38 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_39 = arg_146_1:GetWordFromCfg(324101035)
				local var_149_40 = arg_146_1:FormatText(var_149_39.content)

				arg_146_1.text_.text = var_149_40

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_41 = 12
				local var_149_42 = utf8.len(var_149_40)
				local var_149_43 = var_149_41 <= 0 and var_149_36 or var_149_36 * (var_149_42 / var_149_41)

				if var_149_43 > 0 and var_149_36 < var_149_43 then
					arg_146_1.talkMaxDuration = var_149_43
					var_149_35 = var_149_35 + 0.3

					if var_149_43 + var_149_35 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_43 + var_149_35
					end
				end

				arg_146_1.text_.text = var_149_40
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_44 = var_149_35 + 0.3
			local var_149_45 = math.max(var_149_36, arg_146_1.talkMaxDuration)

			if var_149_44 <= arg_146_1.time_ and arg_146_1.time_ < var_149_44 + var_149_45 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_44) / var_149_45

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_44 + var_149_45 and arg_146_1.time_ < var_149_44 + var_149_45 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324101036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324101036
		arg_152_1.duration_ = 10.83

		local var_152_0 = {
			zh = 9.833,
			ja = 10.833
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324101037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = "1071ui_story"

			if arg_152_1.actors_[var_155_0] == nil then
				local var_155_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_155_1) then
					local var_155_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_152_1.stage_.transform)

					var_155_2.name = var_155_0
					var_155_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_152_1.actors_[var_155_0] = var_155_2

					local var_155_3 = var_155_2:GetComponentInChildren(typeof(CharacterEffect))

					var_155_3.enabled = true

					local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_2, typeof(DynamicBoneHelper))

					if var_155_4 then
						var_155_4:EnableDynamicBone(false)
					end

					arg_152_1:ShowWeapon(var_155_3.transform, false)

					arg_152_1.var_[var_155_0 .. "Animator"] = var_155_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_152_1.var_[var_155_0 .. "Animator"].applyRootMotion = true
					arg_152_1.var_[var_155_0 .. "LipSync"] = var_155_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_155_5 = arg_152_1.actors_["1071ui_story"].transform
			local var_155_6 = 0

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.var_.moveOldPos1071ui_story = var_155_5.localPosition
			end

			local var_155_7 = 0.001

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_7 then
				local var_155_8 = (arg_152_1.time_ - var_155_6) / var_155_7
				local var_155_9 = Vector3.New(0, -1.05, -6.2)

				var_155_5.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1071ui_story, var_155_9, var_155_8)

				local var_155_10 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_10.x, var_155_10.y, var_155_10.z)

				local var_155_11 = var_155_5.localEulerAngles

				var_155_11.z = 0
				var_155_11.x = 0
				var_155_5.localEulerAngles = var_155_11
			end

			if arg_152_1.time_ >= var_155_6 + var_155_7 and arg_152_1.time_ < var_155_6 + var_155_7 + arg_155_0 then
				var_155_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_155_12 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_12.x, var_155_12.y, var_155_12.z)

				local var_155_13 = var_155_5.localEulerAngles

				var_155_13.z = 0
				var_155_13.x = 0
				var_155_5.localEulerAngles = var_155_13
			end

			local var_155_14 = arg_152_1.actors_["1071ui_story"]
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1071ui_story == nil then
				arg_152_1.var_.characterEffect1071ui_story = var_155_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_16 = 0.200000002980232

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 and not isNil(var_155_14) then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16

				if arg_152_1.var_.characterEffect1071ui_story and not isNil(var_155_14) then
					arg_152_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.characterEffect1071ui_story then
				arg_152_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_155_18 = 0

			if var_155_18 < arg_152_1.time_ and arg_152_1.time_ <= var_155_18 + arg_155_0 then
				arg_152_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_155_19 = 0

			if var_155_19 < arg_152_1.time_ and arg_152_1.time_ <= var_155_19 + arg_155_0 then
				arg_152_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_155_20 = arg_152_1.actors_["1071ui_story"]
			local var_155_21 = 0

			if var_155_21 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				if arg_152_1.var_.characterEffect1071ui_story == nil then
					arg_152_1.var_.characterEffect1071ui_story = var_155_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_155_22 = arg_152_1.var_.characterEffect1071ui_story

				var_155_22.imageEffect:turnOff()

				var_155_22.interferenceEffect.enabled = true
				var_155_22.interferenceEffect.noise = 0.001
				var_155_22.interferenceEffect.simTimeScale = 1
				var_155_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_155_23 = arg_152_1.actors_["1071ui_story"]
			local var_155_24 = 0
			local var_155_25 = 5

			if var_155_24 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 then
				if arg_152_1.var_.characterEffect1071ui_story == nil then
					arg_152_1.var_.characterEffect1071ui_story = var_155_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_152_1.var_.characterEffect1071ui_story.imageEffect:turnOn(false)
			end

			local var_155_26 = 0
			local var_155_27 = 1.325

			if var_155_26 < arg_152_1.time_ and arg_152_1.time_ <= var_155_26 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_28 = arg_152_1:FormatText(StoryNameCfg[384].name)

				arg_152_1.leftNameTxt_.text = var_155_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_29 = arg_152_1:GetWordFromCfg(324101036)
				local var_155_30 = arg_152_1:FormatText(var_155_29.content)

				arg_152_1.text_.text = var_155_30

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_31 = 53
				local var_155_32 = utf8.len(var_155_30)
				local var_155_33 = var_155_31 <= 0 and var_155_27 or var_155_27 * (var_155_32 / var_155_31)

				if var_155_33 > 0 and var_155_27 < var_155_33 then
					arg_152_1.talkMaxDuration = var_155_33

					if var_155_33 + var_155_26 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_33 + var_155_26
					end
				end

				arg_152_1.text_.text = var_155_30
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101036", "story_v_out_324101.awb") ~= 0 then
					local var_155_34 = manager.audio:GetVoiceLength("story_v_out_324101", "324101036", "story_v_out_324101.awb") / 1000

					if var_155_34 + var_155_26 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_34 + var_155_26
					end

					if var_155_29.prefab_name ~= "" and arg_152_1.actors_[var_155_29.prefab_name] ~= nil then
						local var_155_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_29.prefab_name].transform, "story_v_out_324101", "324101036", "story_v_out_324101.awb")

						arg_152_1:RecordAudio("324101036", var_155_35)
						arg_152_1:RecordAudio("324101036", var_155_35)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324101", "324101036", "story_v_out_324101.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324101", "324101036", "story_v_out_324101.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_36 = math.max(var_155_27, arg_152_1.talkMaxDuration)

			if var_155_26 <= arg_152_1.time_ and arg_152_1.time_ < var_155_26 + var_155_36 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_26) / var_155_36

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_26 + var_155_36 and arg_152_1.time_ < var_155_26 + var_155_36 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play324101037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324101037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324101038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1071ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1071ui_story == nil then
				arg_156_1.var_.characterEffect1071ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1071ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1071ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1071ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1071ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.325

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(324101037)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 13
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324101038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324101038
		arg_160_1.duration_ = 4.63

		local var_160_0 = {
			zh = 4.633,
			ja = 4.3
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324101039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1071ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1071ui_story == nil then
				arg_160_1.var_.characterEffect1071ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1071ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1071ui_story then
				arg_160_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_163_4 = 0
			local var_163_5 = 0.475

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_6 = arg_160_1:FormatText(StoryNameCfg[384].name)

				arg_160_1.leftNameTxt_.text = var_163_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_7 = arg_160_1:GetWordFromCfg(324101038)
				local var_163_8 = arg_160_1:FormatText(var_163_7.content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 19
				local var_163_10 = utf8.len(var_163_8)
				local var_163_11 = var_163_9 <= 0 and var_163_5 or var_163_5 * (var_163_10 / var_163_9)

				if var_163_11 > 0 and var_163_5 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101038", "story_v_out_324101.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101038", "story_v_out_324101.awb") / 1000

					if var_163_12 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_4
					end

					if var_163_7.prefab_name ~= "" and arg_160_1.actors_[var_163_7.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_7.prefab_name].transform, "story_v_out_324101", "324101038", "story_v_out_324101.awb")

						arg_160_1:RecordAudio("324101038", var_163_13)
						arg_160_1:RecordAudio("324101038", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324101", "324101038", "story_v_out_324101.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324101", "324101038", "story_v_out_324101.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_14 and arg_160_1.time_ < var_163_4 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324101039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324101039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324101040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1071ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1071ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, 100, 0)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1071ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, 100, 0)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1071ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1071ui_story == nil then
				arg_164_1.var_.characterEffect1071ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect1071ui_story and not isNil(var_167_9) then
					local var_167_13 = Mathf.Lerp(0, 0.5, var_167_12)

					arg_164_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1071ui_story.fillRatio = var_167_13
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1071ui_story then
				local var_167_14 = 0.5

				arg_164_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1071ui_story.fillRatio = var_167_14
			end

			local var_167_15 = 0
			local var_167_16 = 0.8

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_17 = arg_164_1:GetWordFromCfg(324101039)
				local var_167_18 = arg_164_1:FormatText(var_167_17.content)

				arg_164_1.text_.text = var_167_18

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_19 = 32
				local var_167_20 = utf8.len(var_167_18)
				local var_167_21 = var_167_19 <= 0 and var_167_16 or var_167_16 * (var_167_20 / var_167_19)

				if var_167_21 > 0 and var_167_16 < var_167_21 then
					arg_164_1.talkMaxDuration = var_167_21

					if var_167_21 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_21 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_18
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_22 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_22 and arg_164_1.time_ < var_167_15 + var_167_22 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play324101040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324101040
		arg_168_1.duration_ = 5.2

		local var_168_0 = {
			zh = 4.333,
			ja = 5.2
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324101041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1071ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1071ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0, -1.05, -6.2)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1071ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1071ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1071ui_story == nil then
				arg_168_1.var_.characterEffect1071ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect1071ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1071ui_story then
				arg_168_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_171_14 = 0
			local var_171_15 = 0.575

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_16 = arg_168_1:FormatText(StoryNameCfg[384].name)

				arg_168_1.leftNameTxt_.text = var_171_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_17 = arg_168_1:GetWordFromCfg(324101040)
				local var_171_18 = arg_168_1:FormatText(var_171_17.content)

				arg_168_1.text_.text = var_171_18

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_19 = 23
				local var_171_20 = utf8.len(var_171_18)
				local var_171_21 = var_171_19 <= 0 and var_171_15 or var_171_15 * (var_171_20 / var_171_19)

				if var_171_21 > 0 and var_171_15 < var_171_21 then
					arg_168_1.talkMaxDuration = var_171_21

					if var_171_21 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_21 + var_171_14
					end
				end

				arg_168_1.text_.text = var_171_18
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101040", "story_v_out_324101.awb") ~= 0 then
					local var_171_22 = manager.audio:GetVoiceLength("story_v_out_324101", "324101040", "story_v_out_324101.awb") / 1000

					if var_171_22 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_22 + var_171_14
					end

					if var_171_17.prefab_name ~= "" and arg_168_1.actors_[var_171_17.prefab_name] ~= nil then
						local var_171_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_17.prefab_name].transform, "story_v_out_324101", "324101040", "story_v_out_324101.awb")

						arg_168_1:RecordAudio("324101040", var_171_23)
						arg_168_1:RecordAudio("324101040", var_171_23)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324101", "324101040", "story_v_out_324101.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324101", "324101040", "story_v_out_324101.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_24 = math.max(var_171_15, arg_168_1.talkMaxDuration)

			if var_171_14 <= arg_168_1.time_ and arg_168_1.time_ < var_171_14 + var_171_24 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_14) / var_171_24

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_14 + var_171_24 and arg_168_1.time_ < var_171_14 + var_171_24 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play324101041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324101041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324101042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1071ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1071ui_story == nil then
				arg_172_1.var_.characterEffect1071ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1071ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1071ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1071ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1071ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.25

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(324101041)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 10
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324101042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324101042
		arg_176_1.duration_ = 7.1

		local var_176_0 = {
			zh = 6.466,
			ja = 7.1
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324101043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1071ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1071ui_story == nil then
				arg_176_1.var_.characterEffect1071ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1071ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1071ui_story then
				arg_176_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_179_4 = 0
			local var_179_5 = 0.8

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_6 = arg_176_1:FormatText(StoryNameCfg[384].name)

				arg_176_1.leftNameTxt_.text = var_179_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(324101042)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 32
				local var_179_10 = utf8.len(var_179_8)
				local var_179_11 = var_179_9 <= 0 and var_179_5 or var_179_5 * (var_179_10 / var_179_9)

				if var_179_11 > 0 and var_179_5 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101042", "story_v_out_324101.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101042", "story_v_out_324101.awb") / 1000

					if var_179_12 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_4
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_324101", "324101042", "story_v_out_324101.awb")

						arg_176_1:RecordAudio("324101042", var_179_13)
						arg_176_1:RecordAudio("324101042", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324101", "324101042", "story_v_out_324101.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324101", "324101042", "story_v_out_324101.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_14 and arg_176_1.time_ < var_179_4 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324101043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324101043
		arg_180_1.duration_ = 11.37

		local var_180_0 = {
			zh = 5.866,
			ja = 11.366
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324101044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_183_1 = 0
			local var_183_2 = 0.8

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_3 = arg_180_1:FormatText(StoryNameCfg[384].name)

				arg_180_1.leftNameTxt_.text = var_183_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(324101043)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 32
				local var_183_7 = utf8.len(var_183_5)
				local var_183_8 = var_183_6 <= 0 and var_183_2 or var_183_2 * (var_183_7 / var_183_6)

				if var_183_8 > 0 and var_183_2 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101043", "story_v_out_324101.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_324101", "324101043", "story_v_out_324101.awb") / 1000

					if var_183_9 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_1
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_324101", "324101043", "story_v_out_324101.awb")

						arg_180_1:RecordAudio("324101043", var_183_10)
						arg_180_1:RecordAudio("324101043", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324101", "324101043", "story_v_out_324101.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324101", "324101043", "story_v_out_324101.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_11 and arg_180_1.time_ < var_183_1 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324101044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324101044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324101045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1071ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1071ui_story == nil then
				arg_184_1.var_.characterEffect1071ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1071ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1071ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1071ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1071ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.725

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(324101044)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 29
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324101045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324101045
		arg_188_1.duration_ = 7.5

		local var_188_0 = {
			zh = 7.5,
			ja = 7.4
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324101046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1071ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1071ui_story == nil then
				arg_188_1.var_.characterEffect1071ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1071ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1071ui_story then
				arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_191_4 = 0
			local var_191_5 = 0.825

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_6 = arg_188_1:FormatText(StoryNameCfg[384].name)

				arg_188_1.leftNameTxt_.text = var_191_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_7 = arg_188_1:GetWordFromCfg(324101045)
				local var_191_8 = arg_188_1:FormatText(var_191_7.content)

				arg_188_1.text_.text = var_191_8

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 33
				local var_191_10 = utf8.len(var_191_8)
				local var_191_11 = var_191_9 <= 0 and var_191_5 or var_191_5 * (var_191_10 / var_191_9)

				if var_191_11 > 0 and var_191_5 < var_191_11 then
					arg_188_1.talkMaxDuration = var_191_11

					if var_191_11 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_4
					end
				end

				arg_188_1.text_.text = var_191_8
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101045", "story_v_out_324101.awb") ~= 0 then
					local var_191_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101045", "story_v_out_324101.awb") / 1000

					if var_191_12 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_4
					end

					if var_191_7.prefab_name ~= "" and arg_188_1.actors_[var_191_7.prefab_name] ~= nil then
						local var_191_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_7.prefab_name].transform, "story_v_out_324101", "324101045", "story_v_out_324101.awb")

						arg_188_1:RecordAudio("324101045", var_191_13)
						arg_188_1:RecordAudio("324101045", var_191_13)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324101", "324101045", "story_v_out_324101.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324101", "324101045", "story_v_out_324101.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_5, arg_188_1.talkMaxDuration)

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_4) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_4 + var_191_14 and arg_188_1.time_ < var_191_4 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324101046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324101046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324101047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1071ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1071ui_story == nil then
				arg_192_1.var_.characterEffect1071ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1071ui_story and not isNil(var_195_0) then
					local var_195_4 = Mathf.Lerp(0, 0.5, var_195_3)

					arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1071ui_story.fillRatio = var_195_4
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1071ui_story then
				local var_195_5 = 0.5

				arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1071ui_story.fillRatio = var_195_5
			end

			local var_195_6 = 0
			local var_195_7 = 0.6

			if var_195_6 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_8 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_9 = arg_192_1:GetWordFromCfg(324101046)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 24
				local var_195_12 = utf8.len(var_195_10)
				local var_195_13 = var_195_11 <= 0 and var_195_7 or var_195_7 * (var_195_12 / var_195_11)

				if var_195_13 > 0 and var_195_7 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play324101047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324101047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324101048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1071ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1071ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1071ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1071ui_story"]
			local var_199_10 = 0
			local var_199_11 = 0.3

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				if arg_196_1.var_.characterEffect1071ui_story == nil then
					arg_196_1.var_.characterEffect1071ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_196_1.var_.characterEffect1071ui_story.imageEffect:turnOff()
			end

			local var_199_12 = 0
			local var_199_13 = 1.175

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_14 = arg_196_1:GetWordFromCfg(324101047)
				local var_199_15 = arg_196_1:FormatText(var_199_14.content)

				arg_196_1.text_.text = var_199_15

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_16 = 47
				local var_199_17 = utf8.len(var_199_15)
				local var_199_18 = var_199_16 <= 0 and var_199_13 or var_199_13 * (var_199_17 / var_199_16)

				if var_199_18 > 0 and var_199_13 < var_199_18 then
					arg_196_1.talkMaxDuration = var_199_18

					if var_199_18 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_15
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_19 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_19 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_19

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_19 and arg_196_1.time_ < var_199_12 + var_199_19 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play324101048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324101048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324101049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.4

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(324101048)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 56
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324101049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324101049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324101050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.775

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(324101049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 31
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324101050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324101050
		arg_208_1.duration_ = 1.67

		local var_208_0 = {
			zh = 1.3,
			ja = 1.666
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324101051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.15

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[1489].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(324101050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 6
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101050", "story_v_out_324101.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_324101", "324101050", "story_v_out_324101.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_324101", "324101050", "story_v_out_324101.awb")

						arg_208_1:RecordAudio("324101050", var_211_9)
						arg_208_1:RecordAudio("324101050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324101", "324101050", "story_v_out_324101.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324101", "324101050", "story_v_out_324101.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324101051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324101051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324101052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.25

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:GetWordFromCfg(324101051)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 10
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_8 and arg_212_1.time_ < var_215_0 + var_215_8 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324101052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324101052
		arg_216_1.duration_ = 2.53

		local var_216_0 = {
			zh = 2.533,
			ja = 1.999999999999
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324101053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1054ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1054ui_story = var_219_0.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Vector3.New(-0.7, -0.985, -6)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1054ui_story, var_219_5, var_219_4)

				local var_219_6 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_6.x, var_219_6.y, var_219_6.z)

				local var_219_7 = var_219_0.localEulerAngles

				var_219_7.z = 0
				var_219_7.x = 0
				var_219_0.localEulerAngles = var_219_7
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_219_8 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_8.x, var_219_8.y, var_219_8.z)

				local var_219_9 = var_219_0.localEulerAngles

				var_219_9.z = 0
				var_219_9.x = 0
				var_219_0.localEulerAngles = var_219_9

				local var_219_10 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_10 then
					var_219_10:EnableDynamicBone(true)
				end
			end

			local var_219_11 = arg_216_1.actors_["1054ui_story"]
			local var_219_12 = 0

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect1054ui_story == nil then
				arg_216_1.var_.characterEffect1054ui_story = var_219_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_13 = 0.200000002980232

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_13 and not isNil(var_219_11) then
				local var_219_14 = (arg_216_1.time_ - var_219_12) / var_219_13

				if arg_216_1.var_.characterEffect1054ui_story and not isNil(var_219_11) then
					arg_216_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_12 + var_219_13 and arg_216_1.time_ < var_219_12 + var_219_13 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect1054ui_story then
				arg_216_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_219_15 = 0

			if var_219_15 < arg_216_1.time_ and arg_216_1.time_ <= var_219_15 + arg_219_0 then
				arg_216_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_219_17 = 0
			local var_219_18 = 0.15

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_19 = arg_216_1:FormatText(StoryNameCfg[1487].name)

				arg_216_1.leftNameTxt_.text = var_219_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_20 = arg_216_1:GetWordFromCfg(324101052)
				local var_219_21 = arg_216_1:FormatText(var_219_20.content)

				arg_216_1.text_.text = var_219_21

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_22 = 6
				local var_219_23 = utf8.len(var_219_21)
				local var_219_24 = var_219_22 <= 0 and var_219_18 or var_219_18 * (var_219_23 / var_219_22)

				if var_219_24 > 0 and var_219_18 < var_219_24 then
					arg_216_1.talkMaxDuration = var_219_24

					if var_219_24 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_24 + var_219_17
					end
				end

				arg_216_1.text_.text = var_219_21
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101052", "story_v_out_324101.awb") ~= 0 then
					local var_219_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101052", "story_v_out_324101.awb") / 1000

					if var_219_25 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_25 + var_219_17
					end

					if var_219_20.prefab_name ~= "" and arg_216_1.actors_[var_219_20.prefab_name] ~= nil then
						local var_219_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_20.prefab_name].transform, "story_v_out_324101", "324101052", "story_v_out_324101.awb")

						arg_216_1:RecordAudio("324101052", var_219_26)
						arg_216_1:RecordAudio("324101052", var_219_26)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324101", "324101052", "story_v_out_324101.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324101", "324101052", "story_v_out_324101.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_27 = math.max(var_219_18, arg_216_1.talkMaxDuration)

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_27 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_17) / var_219_27

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_17 + var_219_27 and arg_216_1.time_ < var_219_17 + var_219_27 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play324101053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324101053
		arg_220_1.duration_ = 5.87

		local var_220_0 = {
			zh = 3.966,
			ja = 5.866
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324101054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["6148ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos6148ui_story = var_223_0.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_3 then
				local var_223_4 = (arg_220_1.time_ - var_223_1) / var_223_3
				local var_223_5 = Vector3.New(0.7, -0.985, -6)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos6148ui_story, var_223_5, var_223_4)

				local var_223_6 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_6.x, var_223_6.y, var_223_6.z)

				local var_223_7 = var_223_0.localEulerAngles

				var_223_7.z = 0
				var_223_7.x = 0
				var_223_0.localEulerAngles = var_223_7
			end

			if arg_220_1.time_ >= var_223_1 + var_223_3 and arg_220_1.time_ < var_223_1 + var_223_3 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_223_8 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_8.x, var_223_8.y, var_223_8.z)

				local var_223_9 = var_223_0.localEulerAngles

				var_223_9.z = 0
				var_223_9.x = 0
				var_223_0.localEulerAngles = var_223_9

				local var_223_10 = GameObjectTools.GetOrAddComponent(var_223_0.gameObject, typeof(DynamicBoneHelper))

				if var_223_10 then
					var_223_10:EnableDynamicBone(true)
				end
			end

			local var_223_11 = arg_220_1.actors_["6148ui_story"]
			local var_223_12 = 0

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_13 = 0.200000002980232

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_13 and not isNil(var_223_11) then
				local var_223_14 = (arg_220_1.time_ - var_223_12) / var_223_13

				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_11) then
					arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_12 + var_223_13 and arg_220_1.time_ < var_223_12 + var_223_13 + arg_223_0 and not isNil(var_223_11) and arg_220_1.var_.characterEffect6148ui_story then
				arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_223_15 = arg_220_1.actors_["1054ui_story"]
			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 and not isNil(var_223_15) and arg_220_1.var_.characterEffect1054ui_story == nil then
				arg_220_1.var_.characterEffect1054ui_story = var_223_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_17 = 0.200000002980232

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_17 and not isNil(var_223_15) then
				local var_223_18 = (arg_220_1.time_ - var_223_16) / var_223_17

				if arg_220_1.var_.characterEffect1054ui_story and not isNil(var_223_15) then
					local var_223_19 = Mathf.Lerp(0, 0.5, var_223_18)

					arg_220_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1054ui_story.fillRatio = var_223_19
				end
			end

			if arg_220_1.time_ >= var_223_16 + var_223_17 and arg_220_1.time_ < var_223_16 + var_223_17 + arg_223_0 and not isNil(var_223_15) and arg_220_1.var_.characterEffect1054ui_story then
				local var_223_20 = 0.5

				arg_220_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1054ui_story.fillRatio = var_223_20
			end

			local var_223_21 = 0

			if var_223_21 < arg_220_1.time_ and arg_220_1.time_ <= var_223_21 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_223_22 = 0

			if var_223_22 < arg_220_1.time_ and arg_220_1.time_ <= var_223_22 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_223_23 = 0
			local var_223_24 = 0.5

			if var_223_23 < arg_220_1.time_ and arg_220_1.time_ <= var_223_23 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_25 = arg_220_1:FormatText(StoryNameCfg[1488].name)

				arg_220_1.leftNameTxt_.text = var_223_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_26 = arg_220_1:GetWordFromCfg(324101053)
				local var_223_27 = arg_220_1:FormatText(var_223_26.content)

				arg_220_1.text_.text = var_223_27

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_28 = 20
				local var_223_29 = utf8.len(var_223_27)
				local var_223_30 = var_223_28 <= 0 and var_223_24 or var_223_24 * (var_223_29 / var_223_28)

				if var_223_30 > 0 and var_223_24 < var_223_30 then
					arg_220_1.talkMaxDuration = var_223_30

					if var_223_30 + var_223_23 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_30 + var_223_23
					end
				end

				arg_220_1.text_.text = var_223_27
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101053", "story_v_out_324101.awb") ~= 0 then
					local var_223_31 = manager.audio:GetVoiceLength("story_v_out_324101", "324101053", "story_v_out_324101.awb") / 1000

					if var_223_31 + var_223_23 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_31 + var_223_23
					end

					if var_223_26.prefab_name ~= "" and arg_220_1.actors_[var_223_26.prefab_name] ~= nil then
						local var_223_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_26.prefab_name].transform, "story_v_out_324101", "324101053", "story_v_out_324101.awb")

						arg_220_1:RecordAudio("324101053", var_223_32)
						arg_220_1:RecordAudio("324101053", var_223_32)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324101", "324101053", "story_v_out_324101.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324101", "324101053", "story_v_out_324101.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_33 = math.max(var_223_24, arg_220_1.talkMaxDuration)

			if var_223_23 <= arg_220_1.time_ and arg_220_1.time_ < var_223_23 + var_223_33 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_23) / var_223_33

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_23 + var_223_33 and arg_220_1.time_ < var_223_23 + var_223_33 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play324101054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324101054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324101055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["6148ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect6148ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_224_1.var_.characterEffect6148ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect6148ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_224_1.var_.characterEffect6148ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 0.05

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_9 = arg_224_1:GetWordFromCfg(324101054)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 2
				local var_227_12 = utf8.len(var_227_10)
				local var_227_13 = var_227_11 <= 0 and var_227_7 or var_227_7 * (var_227_12 / var_227_11)

				if var_227_13 > 0 and var_227_7 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324101055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324101055
		arg_228_1.duration_ = 10.2

		local var_228_0 = {
			zh = 8.1,
			ja = 10.2
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324101056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["6148ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect6148ui_story == nil then
				arg_228_1.var_.characterEffect6148ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect6148ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect6148ui_story then
				arg_228_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_231_4 = 0
			local var_231_5 = 1.075

			if var_231_4 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_6 = arg_228_1:FormatText(StoryNameCfg[1488].name)

				arg_228_1.leftNameTxt_.text = var_231_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:GetWordFromCfg(324101055)
				local var_231_8 = arg_228_1:FormatText(var_231_7.content)

				arg_228_1.text_.text = var_231_8

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 43
				local var_231_10 = utf8.len(var_231_8)
				local var_231_11 = var_231_9 <= 0 and var_231_5 or var_231_5 * (var_231_10 / var_231_9)

				if var_231_11 > 0 and var_231_5 < var_231_11 then
					arg_228_1.talkMaxDuration = var_231_11

					if var_231_11 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_8
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101055", "story_v_out_324101.awb") ~= 0 then
					local var_231_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101055", "story_v_out_324101.awb") / 1000

					if var_231_12 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_12 + var_231_4
					end

					if var_231_7.prefab_name ~= "" and arg_228_1.actors_[var_231_7.prefab_name] ~= nil then
						local var_231_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_7.prefab_name].transform, "story_v_out_324101", "324101055", "story_v_out_324101.awb")

						arg_228_1:RecordAudio("324101055", var_231_13)
						arg_228_1:RecordAudio("324101055", var_231_13)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324101", "324101055", "story_v_out_324101.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324101", "324101055", "story_v_out_324101.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_14 and arg_228_1.time_ < var_231_4 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324101056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324101056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324101057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["6148ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect6148ui_story == nil then
				arg_232_1.var_.characterEffect6148ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect6148ui_story and not isNil(var_235_0) then
					local var_235_4 = Mathf.Lerp(0, 0.5, var_235_3)

					arg_232_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_232_1.var_.characterEffect6148ui_story.fillRatio = var_235_4
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect6148ui_story then
				local var_235_5 = 0.5

				arg_232_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_232_1.var_.characterEffect6148ui_story.fillRatio = var_235_5
			end

			local var_235_6 = 0
			local var_235_7 = 0.25

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_8 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_9 = arg_232_1:GetWordFromCfg(324101056)
				local var_235_10 = arg_232_1:FormatText(var_235_9.content)

				arg_232_1.text_.text = var_235_10

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 10
				local var_235_12 = utf8.len(var_235_10)
				local var_235_13 = var_235_11 <= 0 and var_235_7 or var_235_7 * (var_235_12 / var_235_11)

				if var_235_13 > 0 and var_235_7 < var_235_13 then
					arg_232_1.talkMaxDuration = var_235_13

					if var_235_13 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_6
					end
				end

				arg_232_1.text_.text = var_235_10
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_14 = math.max(var_235_7, arg_232_1.talkMaxDuration)

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_14 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_6) / var_235_14

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_6 + var_235_14 and arg_232_1.time_ < var_235_6 + var_235_14 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324101057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324101057
		arg_236_1.duration_ = 3.93

		local var_236_0 = {
			zh = 2.633,
			ja = 3.933
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324101058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1054ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1054ui_story == nil then
				arg_236_1.var_.characterEffect1054ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1054ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1054ui_story then
				arg_236_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_239_4 = 0

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_239_6 = 0
			local var_239_7 = 0.3

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[1487].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_9 = arg_236_1:GetWordFromCfg(324101057)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 12
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101057", "story_v_out_324101.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_324101", "324101057", "story_v_out_324101.awb") / 1000

					if var_239_14 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_6
					end

					if var_239_9.prefab_name ~= "" and arg_236_1.actors_[var_239_9.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_9.prefab_name].transform, "story_v_out_324101", "324101057", "story_v_out_324101.awb")

						arg_236_1:RecordAudio("324101057", var_239_15)
						arg_236_1:RecordAudio("324101057", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324101", "324101057", "story_v_out_324101.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324101", "324101057", "story_v_out_324101.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_16 and arg_236_1.time_ < var_239_6 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324101058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324101058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324101059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1054ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1054ui_story == nil then
				arg_240_1.var_.characterEffect1054ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1054ui_story and not isNil(var_243_0) then
					local var_243_4 = Mathf.Lerp(0, 0.5, var_243_3)

					arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1054ui_story.fillRatio = var_243_4
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1054ui_story then
				local var_243_5 = 0.5

				arg_240_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1054ui_story.fillRatio = var_243_5
			end

			local var_243_6 = 0
			local var_243_7 = 1.05

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_8 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_9 = arg_240_1:GetWordFromCfg(324101058)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 42
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_7 or var_243_7 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_7 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324101059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324101059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324101060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 1.175

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(324101059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 47
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_8 and arg_244_1.time_ < var_247_0 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324101060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324101060
		arg_248_1.duration_ = 7

		local var_248_0 = {
			zh = 3.9,
			ja = 7
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324101061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["6148ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect6148ui_story == nil then
				arg_248_1.var_.characterEffect6148ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect6148ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect6148ui_story then
				arg_248_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_251_4 = 0

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_6 = 0
			local var_251_7 = 0.35

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[1488].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:GetWordFromCfg(324101060)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 14
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101060", "story_v_out_324101.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_324101", "324101060", "story_v_out_324101.awb") / 1000

					if var_251_14 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_6
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_out_324101", "324101060", "story_v_out_324101.awb")

						arg_248_1:RecordAudio("324101060", var_251_15)
						arg_248_1:RecordAudio("324101060", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_324101", "324101060", "story_v_out_324101.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_324101", "324101060", "story_v_out_324101.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_16 and arg_248_1.time_ < var_251_6 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play324101061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324101061
		arg_252_1.duration_ = 11.13

		local var_252_0 = {
			zh = 6.333,
			ja = 11.133
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324101062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1054ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1054ui_story == nil then
				arg_252_1.var_.characterEffect1054ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1054ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1054ui_story then
				arg_252_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_255_4 = arg_252_1.actors_["6148ui_story"]
			local var_255_5 = 0

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect6148ui_story == nil then
				arg_252_1.var_.characterEffect6148ui_story = var_255_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_6 = 0.200000002980232

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_6 and not isNil(var_255_4) then
				local var_255_7 = (arg_252_1.time_ - var_255_5) / var_255_6

				if arg_252_1.var_.characterEffect6148ui_story and not isNil(var_255_4) then
					local var_255_8 = Mathf.Lerp(0, 0.5, var_255_7)

					arg_252_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_252_1.var_.characterEffect6148ui_story.fillRatio = var_255_8
				end
			end

			if arg_252_1.time_ >= var_255_5 + var_255_6 and arg_252_1.time_ < var_255_5 + var_255_6 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect6148ui_story then
				local var_255_9 = 0.5

				arg_252_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_252_1.var_.characterEffect6148ui_story.fillRatio = var_255_9
			end

			local var_255_10 = 0

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 then
				arg_252_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action424")
			end

			local var_255_11 = 0

			if var_255_11 < arg_252_1.time_ and arg_252_1.time_ <= var_255_11 + arg_255_0 then
				arg_252_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_12 = 0
			local var_255_13 = 0.575

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_14 = arg_252_1:FormatText(StoryNameCfg[1487].name)

				arg_252_1.leftNameTxt_.text = var_255_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_15 = arg_252_1:GetWordFromCfg(324101061)
				local var_255_16 = arg_252_1:FormatText(var_255_15.content)

				arg_252_1.text_.text = var_255_16

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_17 = 23
				local var_255_18 = utf8.len(var_255_16)
				local var_255_19 = var_255_17 <= 0 and var_255_13 or var_255_13 * (var_255_18 / var_255_17)

				if var_255_19 > 0 and var_255_13 < var_255_19 then
					arg_252_1.talkMaxDuration = var_255_19

					if var_255_19 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_19 + var_255_12
					end
				end

				arg_252_1.text_.text = var_255_16
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101061", "story_v_out_324101.awb") ~= 0 then
					local var_255_20 = manager.audio:GetVoiceLength("story_v_out_324101", "324101061", "story_v_out_324101.awb") / 1000

					if var_255_20 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_20 + var_255_12
					end

					if var_255_15.prefab_name ~= "" and arg_252_1.actors_[var_255_15.prefab_name] ~= nil then
						local var_255_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_15.prefab_name].transform, "story_v_out_324101", "324101061", "story_v_out_324101.awb")

						arg_252_1:RecordAudio("324101061", var_255_21)
						arg_252_1:RecordAudio("324101061", var_255_21)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324101", "324101061", "story_v_out_324101.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324101", "324101061", "story_v_out_324101.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_22 = math.max(var_255_13, arg_252_1.talkMaxDuration)

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_22 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_12) / var_255_22

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_12 + var_255_22 and arg_252_1.time_ < var_255_12 + var_255_22 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324101062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324101062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324101063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1054ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1054ui_story == nil then
				arg_256_1.var_.characterEffect1054ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1054ui_story and not isNil(var_259_0) then
					local var_259_4 = Mathf.Lerp(0, 0.5, var_259_3)

					arg_256_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1054ui_story.fillRatio = var_259_4
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1054ui_story then
				local var_259_5 = 0.5

				arg_256_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1054ui_story.fillRatio = var_259_5
			end

			local var_259_6 = 0
			local var_259_7 = 0.6

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_9 = arg_256_1:GetWordFromCfg(324101062)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 24
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_14 and arg_256_1.time_ < var_259_6 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play324101063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324101063
		arg_260_1.duration_ = 7.8

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324101064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = "J27g"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 1

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.J27g

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "J27g" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_17 = 0.3

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_18 = 0

			if var_263_18 < arg_260_1.time_ and arg_260_1.time_ <= var_263_18 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_19 = 1

			if var_263_18 <= arg_260_1.time_ and arg_260_1.time_ < var_263_18 + var_263_19 then
				local var_263_20 = (arg_260_1.time_ - var_263_18) / var_263_19
				local var_263_21 = Color.New(0, 0, 0)

				var_263_21.a = Mathf.Lerp(0, 1, var_263_20)
				arg_260_1.mask_.color = var_263_21
			end

			if arg_260_1.time_ >= var_263_18 + var_263_19 and arg_260_1.time_ < var_263_18 + var_263_19 + arg_263_0 then
				local var_263_22 = Color.New(0, 0, 0)

				var_263_22.a = 1
				arg_260_1.mask_.color = var_263_22
			end

			local var_263_23 = 1

			if var_263_23 < arg_260_1.time_ and arg_260_1.time_ <= var_263_23 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_24 = 2

			if var_263_23 <= arg_260_1.time_ and arg_260_1.time_ < var_263_23 + var_263_24 then
				local var_263_25 = (arg_260_1.time_ - var_263_23) / var_263_24
				local var_263_26 = Color.New(0, 0, 0)

				var_263_26.a = Mathf.Lerp(1, 0, var_263_25)
				arg_260_1.mask_.color = var_263_26
			end

			if arg_260_1.time_ >= var_263_23 + var_263_24 and arg_260_1.time_ < var_263_23 + var_263_24 + arg_263_0 then
				local var_263_27 = Color.New(0, 0, 0)
				local var_263_28 = 0

				arg_260_1.mask_.enabled = false
				var_263_27.a = var_263_28
				arg_260_1.mask_.color = var_263_27
			end

			local var_263_29 = arg_260_1.actors_["1054ui_story"].transform
			local var_263_30 = 1

			if var_263_30 < arg_260_1.time_ and arg_260_1.time_ <= var_263_30 + arg_263_0 then
				arg_260_1.var_.moveOldPos1054ui_story = var_263_29.localPosition

				local var_263_31 = GameObjectTools.GetOrAddComponent(var_263_29.gameObject, typeof(DynamicBoneHelper))

				if var_263_31 then
					var_263_31:EnableDynamicBone(false)
				end
			end

			local var_263_32 = 0.001

			if var_263_30 <= arg_260_1.time_ and arg_260_1.time_ < var_263_30 + var_263_32 then
				local var_263_33 = (arg_260_1.time_ - var_263_30) / var_263_32
				local var_263_34 = Vector3.New(0, 100, 0)

				var_263_29.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1054ui_story, var_263_34, var_263_33)

				local var_263_35 = manager.ui.mainCamera.transform.position - var_263_29.position

				var_263_29.forward = Vector3.New(var_263_35.x, var_263_35.y, var_263_35.z)

				local var_263_36 = var_263_29.localEulerAngles

				var_263_36.z = 0
				var_263_36.x = 0
				var_263_29.localEulerAngles = var_263_36
			end

			if arg_260_1.time_ >= var_263_30 + var_263_32 and arg_260_1.time_ < var_263_30 + var_263_32 + arg_263_0 then
				var_263_29.localPosition = Vector3.New(0, 100, 0)

				local var_263_37 = manager.ui.mainCamera.transform.position - var_263_29.position

				var_263_29.forward = Vector3.New(var_263_37.x, var_263_37.y, var_263_37.z)

				local var_263_38 = var_263_29.localEulerAngles

				var_263_38.z = 0
				var_263_38.x = 0
				var_263_29.localEulerAngles = var_263_38

				local var_263_39 = GameObjectTools.GetOrAddComponent(var_263_29.gameObject, typeof(DynamicBoneHelper))

				if var_263_39 then
					var_263_39:EnableDynamicBone(true)
				end
			end

			local var_263_40 = arg_260_1.actors_["6148ui_story"].transform
			local var_263_41 = 1

			if var_263_41 < arg_260_1.time_ and arg_260_1.time_ <= var_263_41 + arg_263_0 then
				arg_260_1.var_.moveOldPos6148ui_story = var_263_40.localPosition

				local var_263_42 = GameObjectTools.GetOrAddComponent(var_263_40.gameObject, typeof(DynamicBoneHelper))

				if var_263_42 then
					var_263_42:EnableDynamicBone(false)
				end
			end

			local var_263_43 = 0.001

			if var_263_41 <= arg_260_1.time_ and arg_260_1.time_ < var_263_41 + var_263_43 then
				local var_263_44 = (arg_260_1.time_ - var_263_41) / var_263_43
				local var_263_45 = Vector3.New(0, 100, 0)

				var_263_40.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos6148ui_story, var_263_45, var_263_44)

				local var_263_46 = manager.ui.mainCamera.transform.position - var_263_40.position

				var_263_40.forward = Vector3.New(var_263_46.x, var_263_46.y, var_263_46.z)

				local var_263_47 = var_263_40.localEulerAngles

				var_263_47.z = 0
				var_263_47.x = 0
				var_263_40.localEulerAngles = var_263_47
			end

			if arg_260_1.time_ >= var_263_41 + var_263_43 and arg_260_1.time_ < var_263_41 + var_263_43 + arg_263_0 then
				var_263_40.localPosition = Vector3.New(0, 100, 0)

				local var_263_48 = manager.ui.mainCamera.transform.position - var_263_40.position

				var_263_40.forward = Vector3.New(var_263_48.x, var_263_48.y, var_263_48.z)

				local var_263_49 = var_263_40.localEulerAngles

				var_263_49.z = 0
				var_263_49.x = 0
				var_263_40.localEulerAngles = var_263_49

				local var_263_50 = GameObjectTools.GetOrAddComponent(var_263_40.gameObject, typeof(DynamicBoneHelper))

				if var_263_50 then
					var_263_50:EnableDynamicBone(true)
				end
			end

			local var_263_51 = 1.3
			local var_263_52 = 1

			if var_263_51 < arg_260_1.time_ and arg_260_1.time_ <= var_263_51 + arg_263_0 then
				local var_263_53 = "play"
				local var_263_54 = "effect"

				arg_260_1:AudioAction(var_263_53, var_263_54, "se_story_150", "se_story_150_huatian", "")
			end

			local var_263_55 = 0.1
			local var_263_56 = 1

			if var_263_55 < arg_260_1.time_ and arg_260_1.time_ <= var_263_55 + arg_263_0 then
				local var_263_57 = "stop"
				local var_263_58 = "effect"

				arg_260_1:AudioAction(var_263_57, var_263_58, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_263_59 = 0
			local var_263_60 = 1

			if var_263_59 < arg_260_1.time_ and arg_260_1.time_ <= var_263_59 + arg_263_0 then
				local var_263_61 = "play"
				local var_263_62 = "effect"

				arg_260_1:AudioAction(var_263_61, var_263_62, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_263_63 = 0
			local var_263_64 = 1

			if var_263_63 < arg_260_1.time_ and arg_260_1.time_ <= var_263_63 + arg_263_0 then
				local var_263_65 = "play"
				local var_263_66 = "music"

				arg_260_1:AudioAction(var_263_65, var_263_66, "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_263_67 = ""
				local var_263_68 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

				if var_263_68 ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_68 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_68

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_68
						arg_260_1.bgmTxt2_.text = var_263_68
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_69 = 2.8
			local var_263_70 = 1.275

			if var_263_69 < arg_260_1.time_ and arg_260_1.time_ <= var_263_69 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_71 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_71:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_260_1.dialogCg_.alpha = arg_265_0
				end))
				var_263_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_72 = arg_260_1:GetWordFromCfg(324101063)
				local var_263_73 = arg_260_1:FormatText(var_263_72.content)

				arg_260_1.text_.text = var_263_73

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_74 = 51
				local var_263_75 = utf8.len(var_263_73)
				local var_263_76 = var_263_74 <= 0 and var_263_70 or var_263_70 * (var_263_75 / var_263_74)

				if var_263_76 > 0 and var_263_70 < var_263_76 then
					arg_260_1.talkMaxDuration = var_263_76
					var_263_69 = var_263_69 + 0.3

					if var_263_76 + var_263_69 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_76 + var_263_69
					end
				end

				arg_260_1.text_.text = var_263_73
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_77 = var_263_69 + 0.3
			local var_263_78 = math.max(var_263_70, arg_260_1.talkMaxDuration)

			if var_263_77 <= arg_260_1.time_ and arg_260_1.time_ < var_263_77 + var_263_78 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_77) / var_263_78

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_77 + var_263_78 and arg_260_1.time_ < var_263_77 + var_263_78 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play324101064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 324101064
		arg_267_1.duration_ = 2.07

		local var_267_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play324101065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["6148ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos6148ui_story = var_270_0.localPosition

				local var_270_2 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_2 then
					var_270_2:EnableDynamicBone(false)
				end
			end

			local var_270_3 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_3 then
				local var_270_4 = (arg_267_1.time_ - var_270_1) / var_270_3
				local var_270_5 = Vector3.New(0, -0.985, -6)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos6148ui_story, var_270_5, var_270_4)

				local var_270_6 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_6.x, var_270_6.y, var_270_6.z)

				local var_270_7 = var_270_0.localEulerAngles

				var_270_7.z = 0
				var_270_7.x = 0
				var_270_0.localEulerAngles = var_270_7
			end

			if arg_267_1.time_ >= var_270_1 + var_270_3 and arg_267_1.time_ < var_270_1 + var_270_3 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_270_8 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_8.x, var_270_8.y, var_270_8.z)

				local var_270_9 = var_270_0.localEulerAngles

				var_270_9.z = 0
				var_270_9.x = 0
				var_270_0.localEulerAngles = var_270_9

				local var_270_10 = GameObjectTools.GetOrAddComponent(var_270_0.gameObject, typeof(DynamicBoneHelper))

				if var_270_10 then
					var_270_10:EnableDynamicBone(true)
				end
			end

			local var_270_11 = arg_267_1.actors_["6148ui_story"]
			local var_270_12 = 0

			if var_270_12 < arg_267_1.time_ and arg_267_1.time_ <= var_270_12 + arg_270_0 and not isNil(var_270_11) and arg_267_1.var_.characterEffect6148ui_story == nil then
				arg_267_1.var_.characterEffect6148ui_story = var_270_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_13 = 0.200000002980232

			if var_270_12 <= arg_267_1.time_ and arg_267_1.time_ < var_270_12 + var_270_13 and not isNil(var_270_11) then
				local var_270_14 = (arg_267_1.time_ - var_270_12) / var_270_13

				if arg_267_1.var_.characterEffect6148ui_story and not isNil(var_270_11) then
					arg_267_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_12 + var_270_13 and arg_267_1.time_ < var_270_12 + var_270_13 + arg_270_0 and not isNil(var_270_11) and arg_267_1.var_.characterEffect6148ui_story then
				arg_267_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_270_15 = 0

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_270_16 = 0

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				arg_267_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_270_17 = 0
			local var_270_18 = 0.15

			if var_270_17 < arg_267_1.time_ and arg_267_1.time_ <= var_270_17 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_19 = arg_267_1:FormatText(StoryNameCfg[1488].name)

				arg_267_1.leftNameTxt_.text = var_270_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_20 = arg_267_1:GetWordFromCfg(324101064)
				local var_270_21 = arg_267_1:FormatText(var_270_20.content)

				arg_267_1.text_.text = var_270_21

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_22 = 6
				local var_270_23 = utf8.len(var_270_21)
				local var_270_24 = var_270_22 <= 0 and var_270_18 or var_270_18 * (var_270_23 / var_270_22)

				if var_270_24 > 0 and var_270_18 < var_270_24 then
					arg_267_1.talkMaxDuration = var_270_24

					if var_270_24 + var_270_17 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_24 + var_270_17
					end
				end

				arg_267_1.text_.text = var_270_21
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101064", "story_v_out_324101.awb") ~= 0 then
					local var_270_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101064", "story_v_out_324101.awb") / 1000

					if var_270_25 + var_270_17 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_25 + var_270_17
					end

					if var_270_20.prefab_name ~= "" and arg_267_1.actors_[var_270_20.prefab_name] ~= nil then
						local var_270_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_20.prefab_name].transform, "story_v_out_324101", "324101064", "story_v_out_324101.awb")

						arg_267_1:RecordAudio("324101064", var_270_26)
						arg_267_1:RecordAudio("324101064", var_270_26)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_324101", "324101064", "story_v_out_324101.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_324101", "324101064", "story_v_out_324101.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_27 = math.max(var_270_18, arg_267_1.talkMaxDuration)

			if var_270_17 <= arg_267_1.time_ and arg_267_1.time_ < var_270_17 + var_270_27 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_17) / var_270_27

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_17 + var_270_27 and arg_267_1.time_ < var_270_17 + var_270_27 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play324101065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 324101065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play324101066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["6148ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect6148ui_story == nil then
				arg_271_1.var_.characterEffect6148ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect6148ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_271_1.var_.characterEffect6148ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect6148ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_271_1.var_.characterEffect6148ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 0.575

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_8 = arg_271_1:FormatText(StoryNameCfg[7].name)

				arg_271_1.leftNameTxt_.text = var_274_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_9 = arg_271_1:GetWordFromCfg(324101065)
				local var_274_10 = arg_271_1:FormatText(var_274_9.content)

				arg_271_1.text_.text = var_274_10

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 23
				local var_274_12 = utf8.len(var_274_10)
				local var_274_13 = var_274_11 <= 0 and var_274_7 or var_274_7 * (var_274_12 / var_274_11)

				if var_274_13 > 0 and var_274_7 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_10
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play324101066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 324101066
		arg_275_1.duration_ = 5.87

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play324101067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["6148ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos6148ui_story = var_278_0.localPosition

				local var_278_2 = GameObjectTools.GetOrAddComponent(var_278_0.gameObject, typeof(DynamicBoneHelper))

				if var_278_2 then
					var_278_2:EnableDynamicBone(false)
				end
			end

			local var_278_3 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_3 then
				local var_278_4 = (arg_275_1.time_ - var_278_1) / var_278_3
				local var_278_5 = Vector3.New(0, 100, 0)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos6148ui_story, var_278_5, var_278_4)

				local var_278_6 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_6.x, var_278_6.y, var_278_6.z)

				local var_278_7 = var_278_0.localEulerAngles

				var_278_7.z = 0
				var_278_7.x = 0
				var_278_0.localEulerAngles = var_278_7
			end

			if arg_275_1.time_ >= var_278_1 + var_278_3 and arg_275_1.time_ < var_278_1 + var_278_3 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0, 100, 0)

				local var_278_8 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_8.x, var_278_8.y, var_278_8.z)

				local var_278_9 = var_278_0.localEulerAngles

				var_278_9.z = 0
				var_278_9.x = 0
				var_278_0.localEulerAngles = var_278_9

				local var_278_10 = GameObjectTools.GetOrAddComponent(var_278_0.gameObject, typeof(DynamicBoneHelper))

				if var_278_10 then
					var_278_10:EnableDynamicBone(true)
				end
			end

			local var_278_11 = 0.1
			local var_278_12 = 1

			if var_278_11 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				local var_278_13 = "play"
				local var_278_14 = "effect"

				arg_275_1:AudioAction(var_278_13, var_278_14, "se_story_150", "se_story_150_sword02", "")
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_15 = 0.866666666666667
			local var_278_16 = 1.275

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_17 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_17:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(324101066)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_20 = 51
				local var_278_21 = utf8.len(var_278_19)
				local var_278_22 = var_278_20 <= 0 and var_278_16 or var_278_16 * (var_278_21 / var_278_20)

				if var_278_22 > 0 and var_278_16 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22
					var_278_15 = var_278_15 + 0.3

					if var_278_22 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_23 = var_278_15 + 0.3
			local var_278_24 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_23 <= arg_275_1.time_ and arg_275_1.time_ < var_278_23 + var_278_24 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_23) / var_278_24

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_23 + var_278_24 and arg_275_1.time_ < var_278_23 + var_278_24 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play324101067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 324101067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play324101068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.5

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(324101067)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 60
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play324101068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 324101068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play324101069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.125

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(324101068)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 5
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_8 and arg_285_1.time_ < var_288_0 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play324101069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 324101069
		arg_289_1.duration_ = 10.07

		local var_289_0 = {
			zh = 8.3,
			ja = 10.066
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play324101070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["6148ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos6148ui_story = var_292_0.localPosition

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end
			end

			local var_292_3 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_3 then
				local var_292_4 = (arg_289_1.time_ - var_292_1) / var_292_3
				local var_292_5 = Vector3.New(0, -0.985, -6)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos6148ui_story, var_292_5, var_292_4)

				local var_292_6 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_6.x, var_292_6.y, var_292_6.z)

				local var_292_7 = var_292_0.localEulerAngles

				var_292_7.z = 0
				var_292_7.x = 0
				var_292_0.localEulerAngles = var_292_7
			end

			if arg_289_1.time_ >= var_292_1 + var_292_3 and arg_289_1.time_ < var_292_1 + var_292_3 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_292_8 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_8.x, var_292_8.y, var_292_8.z)

				local var_292_9 = var_292_0.localEulerAngles

				var_292_9.z = 0
				var_292_9.x = 0
				var_292_0.localEulerAngles = var_292_9

				local var_292_10 = GameObjectTools.GetOrAddComponent(var_292_0.gameObject, typeof(DynamicBoneHelper))

				if var_292_10 then
					var_292_10:EnableDynamicBone(true)
				end
			end

			local var_292_11 = arg_289_1.actors_["6148ui_story"]
			local var_292_12 = 0

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect6148ui_story == nil then
				arg_289_1.var_.characterEffect6148ui_story = var_292_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_13 = 0.200000002980232

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_13 and not isNil(var_292_11) then
				local var_292_14 = (arg_289_1.time_ - var_292_12) / var_292_13

				if arg_289_1.var_.characterEffect6148ui_story and not isNil(var_292_11) then
					arg_289_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_12 + var_292_13 and arg_289_1.time_ < var_292_12 + var_292_13 + arg_292_0 and not isNil(var_292_11) and arg_289_1.var_.characterEffect6148ui_story then
				arg_289_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_292_15 = 0

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_292_17 = 0
			local var_292_18 = 1

			if var_292_17 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_19 = arg_289_1:FormatText(StoryNameCfg[1488].name)

				arg_289_1.leftNameTxt_.text = var_292_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_20 = arg_289_1:GetWordFromCfg(324101069)
				local var_292_21 = arg_289_1:FormatText(var_292_20.content)

				arg_289_1.text_.text = var_292_21

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_22 = 40
				local var_292_23 = utf8.len(var_292_21)
				local var_292_24 = var_292_22 <= 0 and var_292_18 or var_292_18 * (var_292_23 / var_292_22)

				if var_292_24 > 0 and var_292_18 < var_292_24 then
					arg_289_1.talkMaxDuration = var_292_24

					if var_292_24 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_17
					end
				end

				arg_289_1.text_.text = var_292_21
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101069", "story_v_out_324101.awb") ~= 0 then
					local var_292_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101069", "story_v_out_324101.awb") / 1000

					if var_292_25 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_25 + var_292_17
					end

					if var_292_20.prefab_name ~= "" and arg_289_1.actors_[var_292_20.prefab_name] ~= nil then
						local var_292_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_20.prefab_name].transform, "story_v_out_324101", "324101069", "story_v_out_324101.awb")

						arg_289_1:RecordAudio("324101069", var_292_26)
						arg_289_1:RecordAudio("324101069", var_292_26)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_324101", "324101069", "story_v_out_324101.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_324101", "324101069", "story_v_out_324101.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_27 = math.max(var_292_18, arg_289_1.talkMaxDuration)

			if var_292_17 <= arg_289_1.time_ and arg_289_1.time_ < var_292_17 + var_292_27 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_17) / var_292_27

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_17 + var_292_27 and arg_289_1.time_ < var_292_17 + var_292_27 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play324101070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 324101070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play324101071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["6148ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect6148ui_story == nil then
				arg_293_1.var_.characterEffect6148ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect6148ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_293_1.var_.characterEffect6148ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect6148ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_293_1.var_.characterEffect6148ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.325

			if var_296_6 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_8 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(324101070)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 13
				local var_296_12 = utf8.len(var_296_10)
				local var_296_13 = var_296_11 <= 0 and var_296_7 or var_296_7 * (var_296_12 / var_296_11)

				if var_296_13 > 0 and var_296_7 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_10
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play324101071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 324101071
		arg_297_1.duration_ = 3.73

		local var_297_0 = {
			zh = 3.033,
			ja = 3.733
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play324101072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["6148ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect6148ui_story == nil then
				arg_297_1.var_.characterEffect6148ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect6148ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect6148ui_story then
				arg_297_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_300_4 = 0
			local var_300_5 = 0.3

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_6 = arg_297_1:FormatText(StoryNameCfg[1488].name)

				arg_297_1.leftNameTxt_.text = var_300_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(324101071)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 12
				local var_300_10 = utf8.len(var_300_8)
				local var_300_11 = var_300_9 <= 0 and var_300_5 or var_300_5 * (var_300_10 / var_300_9)

				if var_300_11 > 0 and var_300_5 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101071", "story_v_out_324101.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_324101", "324101071", "story_v_out_324101.awb") / 1000

					if var_300_12 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_4
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_324101", "324101071", "story_v_out_324101.awb")

						arg_297_1:RecordAudio("324101071", var_300_13)
						arg_297_1:RecordAudio("324101071", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_324101", "324101071", "story_v_out_324101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_324101", "324101071", "story_v_out_324101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_14 and arg_297_1.time_ < var_300_4 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play324101072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 324101072
		arg_301_1.duration_ = 9.8

		local var_301_0 = {
			zh = 9.8,
			ja = 6.9
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play324101073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1054ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1054ui_story = var_304_0.localPosition

				local var_304_2 = GameObjectTools.GetOrAddComponent(var_304_0.gameObject, typeof(DynamicBoneHelper))

				if var_304_2 then
					var_304_2:EnableDynamicBone(false)
				end
			end

			local var_304_3 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_3 then
				local var_304_4 = (arg_301_1.time_ - var_304_1) / var_304_3
				local var_304_5 = Vector3.New(0, -0.985, -6)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1054ui_story, var_304_5, var_304_4)

				local var_304_6 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_6.x, var_304_6.y, var_304_6.z)

				local var_304_7 = var_304_0.localEulerAngles

				var_304_7.z = 0
				var_304_7.x = 0
				var_304_0.localEulerAngles = var_304_7
			end

			if arg_301_1.time_ >= var_304_1 + var_304_3 and arg_301_1.time_ < var_304_1 + var_304_3 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_304_8 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_8.x, var_304_8.y, var_304_8.z)

				local var_304_9 = var_304_0.localEulerAngles

				var_304_9.z = 0
				var_304_9.x = 0
				var_304_0.localEulerAngles = var_304_9

				local var_304_10 = GameObjectTools.GetOrAddComponent(var_304_0.gameObject, typeof(DynamicBoneHelper))

				if var_304_10 then
					var_304_10:EnableDynamicBone(true)
				end
			end

			local var_304_11 = arg_301_1.actors_["6148ui_story"].transform
			local var_304_12 = 0

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.var_.moveOldPos6148ui_story = var_304_11.localPosition

				local var_304_13 = GameObjectTools.GetOrAddComponent(var_304_11.gameObject, typeof(DynamicBoneHelper))

				if var_304_13 then
					var_304_13:EnableDynamicBone(false)
				end
			end

			local var_304_14 = 0.001

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_14 then
				local var_304_15 = (arg_301_1.time_ - var_304_12) / var_304_14
				local var_304_16 = Vector3.New(0, 100, 0)

				var_304_11.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos6148ui_story, var_304_16, var_304_15)

				local var_304_17 = manager.ui.mainCamera.transform.position - var_304_11.position

				var_304_11.forward = Vector3.New(var_304_17.x, var_304_17.y, var_304_17.z)

				local var_304_18 = var_304_11.localEulerAngles

				var_304_18.z = 0
				var_304_18.x = 0
				var_304_11.localEulerAngles = var_304_18
			end

			if arg_301_1.time_ >= var_304_12 + var_304_14 and arg_301_1.time_ < var_304_12 + var_304_14 + arg_304_0 then
				var_304_11.localPosition = Vector3.New(0, 100, 0)

				local var_304_19 = manager.ui.mainCamera.transform.position - var_304_11.position

				var_304_11.forward = Vector3.New(var_304_19.x, var_304_19.y, var_304_19.z)

				local var_304_20 = var_304_11.localEulerAngles

				var_304_20.z = 0
				var_304_20.x = 0
				var_304_11.localEulerAngles = var_304_20

				local var_304_21 = GameObjectTools.GetOrAddComponent(var_304_11.gameObject, typeof(DynamicBoneHelper))

				if var_304_21 then
					var_304_21:EnableDynamicBone(true)
				end
			end

			local var_304_22 = arg_301_1.actors_["1054ui_story"]
			local var_304_23 = 0

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 and not isNil(var_304_22) and arg_301_1.var_.characterEffect1054ui_story == nil then
				arg_301_1.var_.characterEffect1054ui_story = var_304_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_24 = 0.200000002980232

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_24 and not isNil(var_304_22) then
				local var_304_25 = (arg_301_1.time_ - var_304_23) / var_304_24

				if arg_301_1.var_.characterEffect1054ui_story and not isNil(var_304_22) then
					arg_301_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_23 + var_304_24 and arg_301_1.time_ < var_304_23 + var_304_24 + arg_304_0 and not isNil(var_304_22) and arg_301_1.var_.characterEffect1054ui_story then
				arg_301_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_304_26 = arg_301_1.actors_["6148ui_story"]
			local var_304_27 = 0

			if var_304_27 < arg_301_1.time_ and arg_301_1.time_ <= var_304_27 + arg_304_0 and not isNil(var_304_26) and arg_301_1.var_.characterEffect6148ui_story == nil then
				arg_301_1.var_.characterEffect6148ui_story = var_304_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_28 = 0.200000002980232

			if var_304_27 <= arg_301_1.time_ and arg_301_1.time_ < var_304_27 + var_304_28 and not isNil(var_304_26) then
				local var_304_29 = (arg_301_1.time_ - var_304_27) / var_304_28

				if arg_301_1.var_.characterEffect6148ui_story and not isNil(var_304_26) then
					local var_304_30 = Mathf.Lerp(0, 0.5, var_304_29)

					arg_301_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_301_1.var_.characterEffect6148ui_story.fillRatio = var_304_30
				end
			end

			if arg_301_1.time_ >= var_304_27 + var_304_28 and arg_301_1.time_ < var_304_27 + var_304_28 + arg_304_0 and not isNil(var_304_26) and arg_301_1.var_.characterEffect6148ui_story then
				local var_304_31 = 0.5

				arg_301_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_301_1.var_.characterEffect6148ui_story.fillRatio = var_304_31
			end

			local var_304_32 = 0

			if var_304_32 < arg_301_1.time_ and arg_301_1.time_ <= var_304_32 + arg_304_0 then
				arg_301_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_304_33 = 0

			if var_304_33 < arg_301_1.time_ and arg_301_1.time_ <= var_304_33 + arg_304_0 then
				arg_301_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_304_34 = 0
			local var_304_35 = 0.825

			if var_304_34 < arg_301_1.time_ and arg_301_1.time_ <= var_304_34 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_36 = arg_301_1:FormatText(StoryNameCfg[1487].name)

				arg_301_1.leftNameTxt_.text = var_304_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_37 = arg_301_1:GetWordFromCfg(324101072)
				local var_304_38 = arg_301_1:FormatText(var_304_37.content)

				arg_301_1.text_.text = var_304_38

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_39 = 33
				local var_304_40 = utf8.len(var_304_38)
				local var_304_41 = var_304_39 <= 0 and var_304_35 or var_304_35 * (var_304_40 / var_304_39)

				if var_304_41 > 0 and var_304_35 < var_304_41 then
					arg_301_1.talkMaxDuration = var_304_41

					if var_304_41 + var_304_34 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_41 + var_304_34
					end
				end

				arg_301_1.text_.text = var_304_38
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101072", "story_v_out_324101.awb") ~= 0 then
					local var_304_42 = manager.audio:GetVoiceLength("story_v_out_324101", "324101072", "story_v_out_324101.awb") / 1000

					if var_304_42 + var_304_34 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_42 + var_304_34
					end

					if var_304_37.prefab_name ~= "" and arg_301_1.actors_[var_304_37.prefab_name] ~= nil then
						local var_304_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_37.prefab_name].transform, "story_v_out_324101", "324101072", "story_v_out_324101.awb")

						arg_301_1:RecordAudio("324101072", var_304_43)
						arg_301_1:RecordAudio("324101072", var_304_43)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_324101", "324101072", "story_v_out_324101.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_324101", "324101072", "story_v_out_324101.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_44 = math.max(var_304_35, arg_301_1.talkMaxDuration)

			if var_304_34 <= arg_301_1.time_ and arg_301_1.time_ < var_304_34 + var_304_44 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_34) / var_304_44

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_34 + var_304_44 and arg_301_1.time_ < var_304_34 + var_304_44 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play324101073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 324101073
		arg_305_1.duration_ = 5.77

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play324101074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1054ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1054ui_story == nil then
				arg_305_1.var_.characterEffect1054ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1054ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1054ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1054ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1054ui_story.fillRatio = var_308_5
			end

			local var_308_6 = arg_305_1.actors_["1054ui_story"].transform
			local var_308_7 = 0

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.var_.moveOldPos1054ui_story = var_308_6.localPosition

				local var_308_8 = GameObjectTools.GetOrAddComponent(var_308_6.gameObject, typeof(DynamicBoneHelper))

				if var_308_8 then
					var_308_8:EnableDynamicBone(false)
				end
			end

			local var_308_9 = 0.001

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_9 then
				local var_308_10 = (arg_305_1.time_ - var_308_7) / var_308_9
				local var_308_11 = Vector3.New(0, 100, 0)

				var_308_6.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1054ui_story, var_308_11, var_308_10)

				local var_308_12 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_12.x, var_308_12.y, var_308_12.z)

				local var_308_13 = var_308_6.localEulerAngles

				var_308_13.z = 0
				var_308_13.x = 0
				var_308_6.localEulerAngles = var_308_13
			end

			if arg_305_1.time_ >= var_308_7 + var_308_9 and arg_305_1.time_ < var_308_7 + var_308_9 + arg_308_0 then
				var_308_6.localPosition = Vector3.New(0, 100, 0)

				local var_308_14 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_14.x, var_308_14.y, var_308_14.z)

				local var_308_15 = var_308_6.localEulerAngles

				var_308_15.z = 0
				var_308_15.x = 0
				var_308_6.localEulerAngles = var_308_15

				local var_308_16 = GameObjectTools.GetOrAddComponent(var_308_6.gameObject, typeof(DynamicBoneHelper))

				if var_308_16 then
					var_308_16:EnableDynamicBone(true)
				end
			end

			local var_308_17 = arg_305_1.actors_["6148ui_story"].transform
			local var_308_18 = 0

			if var_308_18 < arg_305_1.time_ and arg_305_1.time_ <= var_308_18 + arg_308_0 then
				arg_305_1.var_.moveOldPos6148ui_story = var_308_17.localPosition

				local var_308_19 = GameObjectTools.GetOrAddComponent(var_308_17.gameObject, typeof(DynamicBoneHelper))

				if var_308_19 then
					var_308_19:EnableDynamicBone(false)
				end
			end

			local var_308_20 = 0.001

			if var_308_18 <= arg_305_1.time_ and arg_305_1.time_ < var_308_18 + var_308_20 then
				local var_308_21 = (arg_305_1.time_ - var_308_18) / var_308_20
				local var_308_22 = Vector3.New(0, 100, 0)

				var_308_17.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos6148ui_story, var_308_22, var_308_21)

				local var_308_23 = manager.ui.mainCamera.transform.position - var_308_17.position

				var_308_17.forward = Vector3.New(var_308_23.x, var_308_23.y, var_308_23.z)

				local var_308_24 = var_308_17.localEulerAngles

				var_308_24.z = 0
				var_308_24.x = 0
				var_308_17.localEulerAngles = var_308_24
			end

			if arg_305_1.time_ >= var_308_18 + var_308_20 and arg_305_1.time_ < var_308_18 + var_308_20 + arg_308_0 then
				var_308_17.localPosition = Vector3.New(0, 100, 0)

				local var_308_25 = manager.ui.mainCamera.transform.position - var_308_17.position

				var_308_17.forward = Vector3.New(var_308_25.x, var_308_25.y, var_308_25.z)

				local var_308_26 = var_308_17.localEulerAngles

				var_308_26.z = 0
				var_308_26.x = 0
				var_308_17.localEulerAngles = var_308_26

				local var_308_27 = GameObjectTools.GetOrAddComponent(var_308_17.gameObject, typeof(DynamicBoneHelper))

				if var_308_27 then
					var_308_27:EnableDynamicBone(true)
				end
			end

			local var_308_28 = 0.1
			local var_308_29 = 1

			if var_308_28 < arg_305_1.time_ and arg_305_1.time_ <= var_308_28 + arg_308_0 then
				local var_308_30 = "play"
				local var_308_31 = "effect"

				arg_305_1:AudioAction(var_308_30, var_308_31, "se_story_150", "se_story_150_sword03", "")
			end

			local var_308_32 = 0

			if var_308_32 < arg_305_1.time_ and arg_305_1.time_ <= var_308_32 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			local var_308_33 = 1.36666666666667

			if arg_305_1.time_ >= var_308_32 + var_308_33 and arg_305_1.time_ < var_308_32 + var_308_33 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_34 = 0.766666666666667
			local var_308_35 = 1.525

			if var_308_34 < arg_305_1.time_ and arg_305_1.time_ <= var_308_34 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_36 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_36:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_37 = arg_305_1:GetWordFromCfg(324101073)
				local var_308_38 = arg_305_1:FormatText(var_308_37.content)

				arg_305_1.text_.text = var_308_38

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_39 = 61
				local var_308_40 = utf8.len(var_308_38)
				local var_308_41 = var_308_39 <= 0 and var_308_35 or var_308_35 * (var_308_40 / var_308_39)

				if var_308_41 > 0 and var_308_35 < var_308_41 then
					arg_305_1.talkMaxDuration = var_308_41
					var_308_34 = var_308_34 + 0.3

					if var_308_41 + var_308_34 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_41 + var_308_34
					end
				end

				arg_305_1.text_.text = var_308_38
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_42 = var_308_34 + 0.3
			local var_308_43 = math.max(var_308_35, arg_305_1.talkMaxDuration)

			if var_308_42 <= arg_305_1.time_ and arg_305_1.time_ < var_308_42 + var_308_43 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_42) / var_308_43

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_42 + var_308_43 and arg_305_1.time_ < var_308_42 + var_308_43 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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

		arg_305_1:InitPlayNodeList()
	end,
	Play324101074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 324101074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play324101075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 1.275

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(324101074)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 51
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play324101075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 324101075
		arg_315_1.duration_ = 3.47

		local var_315_0 = {
			zh = 3.466,
			ja = 3.2
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play324101076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1054ui_story"].transform
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.var_.moveOldPos1054ui_story = var_318_0.localPosition

				local var_318_2 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(false)
				end
			end

			local var_318_3 = 0.001

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_3 then
				local var_318_4 = (arg_315_1.time_ - var_318_1) / var_318_3
				local var_318_5 = Vector3.New(0, -0.985, -6)

				var_318_0.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1054ui_story, var_318_5, var_318_4)

				local var_318_6 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_6.x, var_318_6.y, var_318_6.z)

				local var_318_7 = var_318_0.localEulerAngles

				var_318_7.z = 0
				var_318_7.x = 0
				var_318_0.localEulerAngles = var_318_7
			end

			if arg_315_1.time_ >= var_318_1 + var_318_3 and arg_315_1.time_ < var_318_1 + var_318_3 + arg_318_0 then
				var_318_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_318_8 = manager.ui.mainCamera.transform.position - var_318_0.position

				var_318_0.forward = Vector3.New(var_318_8.x, var_318_8.y, var_318_8.z)

				local var_318_9 = var_318_0.localEulerAngles

				var_318_9.z = 0
				var_318_9.x = 0
				var_318_0.localEulerAngles = var_318_9

				local var_318_10 = GameObjectTools.GetOrAddComponent(var_318_0.gameObject, typeof(DynamicBoneHelper))

				if var_318_10 then
					var_318_10:EnableDynamicBone(true)
				end
			end

			local var_318_11 = arg_315_1.actors_["1054ui_story"]
			local var_318_12 = 0

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 and not isNil(var_318_11) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = var_318_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_13 = 0.200000002980232

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_13 and not isNil(var_318_11) then
				local var_318_14 = (arg_315_1.time_ - var_318_12) / var_318_13

				if arg_315_1.var_.characterEffect1054ui_story and not isNil(var_318_11) then
					arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= var_318_12 + var_318_13 and arg_315_1.time_ < var_318_12 + var_318_13 + arg_318_0 and not isNil(var_318_11) and arg_315_1.var_.characterEffect1054ui_story then
				arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_318_15 = 0

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_318_16 = 0

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_318_17 = 0
			local var_318_18 = 0.225

			if var_318_17 < arg_315_1.time_ and arg_315_1.time_ <= var_318_17 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_19 = arg_315_1:FormatText(StoryNameCfg[1487].name)

				arg_315_1.leftNameTxt_.text = var_318_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_20 = arg_315_1:GetWordFromCfg(324101075)
				local var_318_21 = arg_315_1:FormatText(var_318_20.content)

				arg_315_1.text_.text = var_318_21

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_22 = 9
				local var_318_23 = utf8.len(var_318_21)
				local var_318_24 = var_318_22 <= 0 and var_318_18 or var_318_18 * (var_318_23 / var_318_22)

				if var_318_24 > 0 and var_318_18 < var_318_24 then
					arg_315_1.talkMaxDuration = var_318_24

					if var_318_24 + var_318_17 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_17
					end
				end

				arg_315_1.text_.text = var_318_21
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101075", "story_v_out_324101.awb") ~= 0 then
					local var_318_25 = manager.audio:GetVoiceLength("story_v_out_324101", "324101075", "story_v_out_324101.awb") / 1000

					if var_318_25 + var_318_17 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_25 + var_318_17
					end

					if var_318_20.prefab_name ~= "" and arg_315_1.actors_[var_318_20.prefab_name] ~= nil then
						local var_318_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_20.prefab_name].transform, "story_v_out_324101", "324101075", "story_v_out_324101.awb")

						arg_315_1:RecordAudio("324101075", var_318_26)
						arg_315_1:RecordAudio("324101075", var_318_26)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_324101", "324101075", "story_v_out_324101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_324101", "324101075", "story_v_out_324101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_27 = math.max(var_318_18, arg_315_1.talkMaxDuration)

			if var_318_17 <= arg_315_1.time_ and arg_315_1.time_ < var_318_17 + var_318_27 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_17) / var_318_27

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_17 + var_318_27 and arg_315_1.time_ < var_318_17 + var_318_27 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play324101076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 324101076
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play324101077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1054ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1054ui_story and not isNil(var_322_0) then
					local var_322_4 = Mathf.Lerp(0, 0.5, var_322_3)

					arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_4
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1054ui_story then
				local var_322_5 = 0.5

				arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1054ui_story.fillRatio = var_322_5
			end

			local var_322_6 = 0
			local var_322_7 = 0.175

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_9 = arg_319_1:GetWordFromCfg(324101076)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 7
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_14 and arg_319_1.time_ < var_322_6 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play324101077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 324101077
		arg_323_1.duration_ = 2

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play324101078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["6148ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos6148ui_story = var_326_0.localPosition

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end
			end

			local var_326_3 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Vector3.New(0.7, -0.985, -6)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos6148ui_story, var_326_5, var_326_4)

				local var_326_6 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_6.x, var_326_6.y, var_326_6.z)

				local var_326_7 = var_326_0.localEulerAngles

				var_326_7.z = 0
				var_326_7.x = 0
				var_326_0.localEulerAngles = var_326_7
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_326_8 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_8.x, var_326_8.y, var_326_8.z)

				local var_326_9 = var_326_0.localEulerAngles

				var_326_9.z = 0
				var_326_9.x = 0
				var_326_0.localEulerAngles = var_326_9

				local var_326_10 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_10 then
					var_326_10:EnableDynamicBone(true)
				end
			end

			local var_326_11 = arg_323_1.actors_["6148ui_story"]
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect6148ui_story == nil then
				arg_323_1.var_.characterEffect6148ui_story = var_326_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_13 = 0.200000002980232

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_13 and not isNil(var_326_11) then
				local var_326_14 = (arg_323_1.time_ - var_326_12) / var_326_13

				if arg_323_1.var_.characterEffect6148ui_story and not isNil(var_326_11) then
					arg_323_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_12 + var_326_13 and arg_323_1.time_ < var_326_12 + var_326_13 + arg_326_0 and not isNil(var_326_11) and arg_323_1.var_.characterEffect6148ui_story then
				arg_323_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_326_15 = 0

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_326_17 = arg_323_1.actors_["1054ui_story"].transform
			local var_326_18 = 0

			if var_326_18 < arg_323_1.time_ and arg_323_1.time_ <= var_326_18 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = var_326_17.localPosition

				local var_326_19 = GameObjectTools.GetOrAddComponent(var_326_17.gameObject, typeof(DynamicBoneHelper))

				if var_326_19 then
					var_326_19:EnableDynamicBone(false)
				end
			end

			local var_326_20 = 0.001

			if var_326_18 <= arg_323_1.time_ and arg_323_1.time_ < var_326_18 + var_326_20 then
				local var_326_21 = (arg_323_1.time_ - var_326_18) / var_326_20
				local var_326_22 = Vector3.New(-0.7, -0.985, -6)

				var_326_17.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, var_326_22, var_326_21)

				local var_326_23 = manager.ui.mainCamera.transform.position - var_326_17.position

				var_326_17.forward = Vector3.New(var_326_23.x, var_326_23.y, var_326_23.z)

				local var_326_24 = var_326_17.localEulerAngles

				var_326_24.z = 0
				var_326_24.x = 0
				var_326_17.localEulerAngles = var_326_24
			end

			if arg_323_1.time_ >= var_326_18 + var_326_20 and arg_323_1.time_ < var_326_18 + var_326_20 + arg_326_0 then
				var_326_17.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_326_25 = manager.ui.mainCamera.transform.position - var_326_17.position

				var_326_17.forward = Vector3.New(var_326_25.x, var_326_25.y, var_326_25.z)

				local var_326_26 = var_326_17.localEulerAngles

				var_326_26.z = 0
				var_326_26.x = 0
				var_326_17.localEulerAngles = var_326_26

				local var_326_27 = GameObjectTools.GetOrAddComponent(var_326_17.gameObject, typeof(DynamicBoneHelper))

				if var_326_27 then
					var_326_27:EnableDynamicBone(true)
				end
			end

			local var_326_28 = 0
			local var_326_29 = 0.125

			if var_326_28 < arg_323_1.time_ and arg_323_1.time_ <= var_326_28 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_30 = arg_323_1:FormatText(StoryNameCfg[1488].name)

				arg_323_1.leftNameTxt_.text = var_326_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_31 = arg_323_1:GetWordFromCfg(324101077)
				local var_326_32 = arg_323_1:FormatText(var_326_31.content)

				arg_323_1.text_.text = var_326_32

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_33 = 5
				local var_326_34 = utf8.len(var_326_32)
				local var_326_35 = var_326_33 <= 0 and var_326_29 or var_326_29 * (var_326_34 / var_326_33)

				if var_326_35 > 0 and var_326_29 < var_326_35 then
					arg_323_1.talkMaxDuration = var_326_35

					if var_326_35 + var_326_28 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_35 + var_326_28
					end
				end

				arg_323_1.text_.text = var_326_32
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324101", "324101077", "story_v_out_324101.awb") ~= 0 then
					local var_326_36 = manager.audio:GetVoiceLength("story_v_out_324101", "324101077", "story_v_out_324101.awb") / 1000

					if var_326_36 + var_326_28 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_36 + var_326_28
					end

					if var_326_31.prefab_name ~= "" and arg_323_1.actors_[var_326_31.prefab_name] ~= nil then
						local var_326_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_31.prefab_name].transform, "story_v_out_324101", "324101077", "story_v_out_324101.awb")

						arg_323_1:RecordAudio("324101077", var_326_37)
						arg_323_1:RecordAudio("324101077", var_326_37)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_324101", "324101077", "story_v_out_324101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_324101", "324101077", "story_v_out_324101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_38 = math.max(var_326_29, arg_323_1.talkMaxDuration)

			if var_326_28 <= arg_323_1.time_ and arg_323_1.time_ < var_326_28 + var_326_38 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_28) / var_326_38

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_28 + var_326_38 and arg_323_1.time_ < var_326_28 + var_326_38 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play324101078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 324101078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
			arg_327_1.auto_ = false
		end

		function arg_327_1.playNext_(arg_329_0)
			arg_327_1.onStoryFinished_()
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["6148ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect6148ui_story == nil then
				arg_327_1.var_.characterEffect6148ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect6148ui_story and not isNil(var_330_0) then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_327_1.var_.characterEffect6148ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect6148ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_327_1.var_.characterEffect6148ui_story.fillRatio = var_330_5
			end

			local var_330_6 = 0
			local var_330_7 = 0.3

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_8 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_9 = arg_327_1:GetWordFromCfg(324101078)
				local var_330_10 = arg_327_1:FormatText(var_330_9.content)

				arg_327_1.text_.text = var_330_10

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_11 = 12
				local var_330_12 = utf8.len(var_330_10)
				local var_330_13 = var_330_11 <= 0 and var_330_7 or var_330_7 * (var_330_12 / var_330_11)

				if var_330_13 > 0 and var_330_7 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_10
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_14 and arg_327_1.time_ < var_330_6 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/ST2008",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J27g"
	},
	voices = {
		"story_v_out_324101.awb"
	}
}
