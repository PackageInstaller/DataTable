return {
	Play935011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 935011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play935011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2003a"

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
				local var_4_5 = arg_1_1.bgs_.ST2003a

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
					if iter_4_0 ~= "ST2003a" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily")

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
			local var_4_37 = 0.975

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

				local var_4_39 = arg_1_1:GetWordFromCfg(935011001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 39
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
	Play935011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 935011002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play935011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.95

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(935011002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 38
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play935011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 935011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play935011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1070ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1070ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1070ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.95, -6.05)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1070ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1070ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1070ui_story == nil then
				arg_13_1.var_.characterEffect1070ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1070ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1070ui_story then
				arg_13_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_16_20 = 0
			local var_16_21 = 0.3

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[318].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(935011003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 12
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_28 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_28 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_28

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_28 and arg_13_1.time_ < var_16_20 + var_16_28 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play935011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 935011004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play935011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1070ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1070ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1070ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1070ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1070ui_story == nil then
				arg_17_1.var_.characterEffect1070ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1070ui_story and not isNil(var_20_9) then
					local var_20_13 = Mathf.Lerp(0, 0.5, var_20_12)

					arg_17_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1070ui_story.fillRatio = var_20_13
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1070ui_story then
				local var_20_14 = 0.5

				arg_17_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1070ui_story.fillRatio = var_20_14
			end

			local var_20_15 = 0
			local var_20_16 = 0.575

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(935011004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 23
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_16 or var_20_16 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_16 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_22 and arg_17_1.time_ < var_20_15 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST2003a",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.0666666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0.1)
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play935011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 935011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play935011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1070ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1070ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1070ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1070ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1070ui_story == nil then
				arg_21_1.var_.characterEffect1070ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1070ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1070ui_story then
				arg_21_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_24_15 = 0
			local var_24_16 = 0.15

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[318].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(935011005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 6
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play935011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 935011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play935011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10039ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_25_1.stage_.transform)

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

			local var_28_5 = arg_25_1.actors_["10039ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos10039ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0.7, -0.8, -6.2)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10039ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["10039ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10039ui_story == nil then
				arg_25_1.var_.characterEffect10039ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect10039ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10039ui_story then
				arg_25_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_28_18 = arg_25_1.actors_["1070ui_story"]
			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect1070ui_story == nil then
				arg_25_1.var_.characterEffect1070ui_story = var_28_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_20 = 0.200000002980232

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 and not isNil(var_28_18) then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20

				if arg_25_1.var_.characterEffect1070ui_story and not isNil(var_28_18) then
					local var_28_22 = Mathf.Lerp(0, 0.5, var_28_21)

					arg_25_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1070ui_story.fillRatio = var_28_22
				end
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect1070ui_story then
				local var_28_23 = 0.5

				arg_25_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1070ui_story.fillRatio = var_28_23
			end

			local var_28_24 = 0

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 then
				arg_25_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 then
				arg_25_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_28_26 = 0
			local var_28_27 = 0.5

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_28 = arg_25_1:FormatText(StoryNameCfg[472].name)

				arg_25_1.leftNameTxt_.text = var_28_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_29 = arg_25_1:GetWordFromCfg(935011006)
				local var_28_30 = arg_25_1:FormatText(var_28_29.content)

				arg_25_1.text_.text = var_28_30

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_31 = 20
				local var_28_32 = utf8.len(var_28_30)
				local var_28_33 = var_28_31 <= 0 and var_28_27 or var_28_27 * (var_28_32 / var_28_31)

				if var_28_33 > 0 and var_28_27 < var_28_33 then
					arg_25_1.talkMaxDuration = var_28_33

					if var_28_33 + var_28_26 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_33 + var_28_26
					end
				end

				arg_25_1.text_.text = var_28_30
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_34 = math.max(var_28_27, arg_25_1.talkMaxDuration)

			if var_28_26 <= arg_25_1.time_ and arg_25_1.time_ < var_28_26 + var_28_34 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_26) / var_28_34

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_26 + var_28_34 and arg_25_1.time_ < var_28_26 + var_28_34 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play935011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 935011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play935011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1070ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1070ui_story == nil then
				arg_29_1.var_.characterEffect1070ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1070ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1070ui_story then
				arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["10039ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10039ui_story == nil then
				arg_29_1.var_.characterEffect10039ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect10039ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10039ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10039ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10039ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_32_11 = 0
			local var_32_12 = 0.925

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[318].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(935011007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 37
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_19 and arg_29_1.time_ < var_32_11 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play935011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 935011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play935011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10039ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10039ui_story == nil then
				arg_33_1.var_.characterEffect10039ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10039ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10039ui_story then
				arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1070ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1070ui_story == nil then
				arg_33_1.var_.characterEffect1070ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1070ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1070ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1070ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1070ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_36_11 = 0
			local var_36_12 = 0.125

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_13 = arg_33_1:FormatText(StoryNameCfg[472].name)

				arg_33_1.leftNameTxt_.text = var_36_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(935011008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 5
				local var_36_17 = utf8.len(var_36_15)
				local var_36_18 = var_36_16 <= 0 and var_36_12 or var_36_12 * (var_36_17 / var_36_16)

				if var_36_18 > 0 and var_36_12 < var_36_18 then
					arg_33_1.talkMaxDuration = var_36_18

					if var_36_18 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_19 and arg_33_1.time_ < var_36_11 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play935011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 935011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play935011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1070ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1070ui_story == nil then
				arg_37_1.var_.characterEffect1070ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1070ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1070ui_story then
				arg_37_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10039ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10039ui_story == nil then
				arg_37_1.var_.characterEffect10039ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect10039ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10039ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10039ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10039ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_40_11 = 0
			local var_40_12 = 0.125

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[318].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(935011009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 5
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play935011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 935011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play935011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1070ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1070ui_story == nil then
				arg_41_1.var_.characterEffect1070ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1070ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1070ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1070ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1070ui_story.fillRatio = var_44_5
			end

			local var_44_6 = arg_41_1.actors_["1070ui_story"].transform
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 then
				arg_41_1.var_.moveOldPos1070ui_story = var_44_6.localPosition
			end

			local var_44_8 = 0.001

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8
				local var_44_10 = Vector3.New(0, 100, 0)

				var_44_6.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1070ui_story, var_44_10, var_44_9)

				local var_44_11 = manager.ui.mainCamera.transform.position - var_44_6.position

				var_44_6.forward = Vector3.New(var_44_11.x, var_44_11.y, var_44_11.z)

				local var_44_12 = var_44_6.localEulerAngles

				var_44_12.z = 0
				var_44_12.x = 0
				var_44_6.localEulerAngles = var_44_12
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 then
				var_44_6.localPosition = Vector3.New(0, 100, 0)

				local var_44_13 = manager.ui.mainCamera.transform.position - var_44_6.position

				var_44_6.forward = Vector3.New(var_44_13.x, var_44_13.y, var_44_13.z)

				local var_44_14 = var_44_6.localEulerAngles

				var_44_14.z = 0
				var_44_14.x = 0
				var_44_6.localEulerAngles = var_44_14
			end

			local var_44_15 = 0
			local var_44_16 = 1.125

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(935011010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 45
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_16 or var_44_16 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_16 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_22 and arg_41_1.time_ < var_44_15 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play935011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 935011011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play935011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1070ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1070ui_story == nil then
				arg_45_1.var_.characterEffect1070ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1070ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1070ui_story then
				arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1070ui_story"].transform
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.var_.moveOldPos1070ui_story = var_48_4.localPosition
			end

			local var_48_6 = 0.001

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6
				local var_48_8 = Vector3.New(-0.7, -0.95, -6.05)

				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1070ui_story, var_48_8, var_48_7)

				local var_48_9 = manager.ui.mainCamera.transform.position - var_48_4.position

				var_48_4.forward = Vector3.New(var_48_9.x, var_48_9.y, var_48_9.z)

				local var_48_10 = var_48_4.localEulerAngles

				var_48_10.z = 0
				var_48_10.x = 0
				var_48_4.localEulerAngles = var_48_10
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_48_11 = manager.ui.mainCamera.transform.position - var_48_4.position

				var_48_4.forward = Vector3.New(var_48_11.x, var_48_11.y, var_48_11.z)

				local var_48_12 = var_48_4.localEulerAngles

				var_48_12.z = 0
				var_48_12.x = 0
				var_48_4.localEulerAngles = var_48_12
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action476")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva", "EmotionTimelineAnimator")
			end

			local var_48_15 = 0
			local var_48_16 = 1

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[318].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(935011011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 40
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_23 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_23 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_23

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_23 and arg_45_1.time_ < var_48_15 + var_48_23 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play935011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 935011012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play935011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.5

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[318].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(935011012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 20
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play935011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 935011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play935011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_56_1 = 0
			local var_56_2 = 1.275

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[318].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(935011013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 51
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play935011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 935011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play935011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10039ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10039ui_story == nil then
				arg_57_1.var_.characterEffect10039ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10039ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10039ui_story then
				arg_57_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1070ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1070ui_story == nil then
				arg_57_1.var_.characterEffect1070ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect1070ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1070ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1070ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1070ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action456")
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_60_12 = 0
			local var_60_13 = 0.075

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[472].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(935011014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 3
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_20 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_20 and arg_57_1.time_ < var_60_12 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play935011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 935011015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play935011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1070ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1070ui_story == nil then
				arg_61_1.var_.characterEffect1070ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1070ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1070ui_story then
				arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["10039ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10039ui_story == nil then
				arg_61_1.var_.characterEffect10039ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect10039ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10039ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10039ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10039ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_64_12 = 0
			local var_64_13 = 0.125

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[318].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(935011015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 5
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_20 and arg_61_1.time_ < var_64_12 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play935011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 935011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play935011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10039ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10039ui_story == nil then
				arg_65_1.var_.characterEffect10039ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10039ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10039ui_story then
				arg_65_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1070ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1070ui_story == nil then
				arg_65_1.var_.characterEffect1070ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1070ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1070ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_68_11 = 0
			local var_68_12 = 0.625

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_13 = arg_65_1:FormatText(StoryNameCfg[472].name)

				arg_65_1.leftNameTxt_.text = var_68_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(935011016)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 25
				local var_68_17 = utf8.len(var_68_15)
				local var_68_18 = var_68_16 <= 0 and var_68_12 or var_68_12 * (var_68_17 / var_68_16)

				if var_68_18 > 0 and var_68_12 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_19 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_19 and arg_65_1.time_ < var_68_11 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play935011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 935011017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play935011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1070ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1070ui_story == nil then
				arg_69_1.var_.characterEffect1070ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1070ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1070ui_story then
				arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["10039ui_story"]
			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10039ui_story == nil then
				arg_69_1.var_.characterEffect10039ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 and not isNil(var_72_4) then
				local var_72_7 = (arg_69_1.time_ - var_72_5) / var_72_6

				if arg_69_1.var_.characterEffect10039ui_story and not isNil(var_72_4) then
					local var_72_8 = Mathf.Lerp(0, 0.5, var_72_7)

					arg_69_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10039ui_story.fillRatio = var_72_8
				end
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10039ui_story then
				local var_72_9 = 0.5

				arg_69_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10039ui_story.fillRatio = var_72_9
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_72_11 = 0

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_72_12 = 0
			local var_72_13 = 0.25

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[318].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(935011017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 10
				local var_72_18 = utf8.len(var_72_16)
				local var_72_19 = var_72_17 <= 0 and var_72_13 or var_72_13 * (var_72_18 / var_72_17)

				if var_72_19 > 0 and var_72_13 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_20 and arg_69_1.time_ < var_72_12 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play935011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 935011018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play935011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1070ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1070ui_story == nil then
				arg_73_1.var_.characterEffect1070ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1070ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1070ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1070ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1070ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_76_7 = 0
			local var_76_8 = 0.8

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(935011018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 32
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_8 or var_76_8 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_8 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_14 and arg_73_1.time_ < var_76_7 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play935011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 935011019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play935011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1070ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1070ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_80_5 = 0
			local var_80_6 = 1.475

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_7 = arg_77_1:FormatText(StoryNameCfg[318].name)

				arg_77_1.leftNameTxt_.text = var_80_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(935011019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 59
				local var_80_11 = utf8.len(var_80_9)
				local var_80_12 = var_80_10 <= 0 and var_80_6 or var_80_6 * (var_80_11 / var_80_10)

				if var_80_12 > 0 and var_80_6 < var_80_12 then
					arg_77_1.talkMaxDuration = var_80_12

					if var_80_12 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play935011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 935011020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play935011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_84_1 = 0
			local var_84_2 = 0.625

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_3 = arg_81_1:FormatText(StoryNameCfg[318].name)

				arg_81_1.leftNameTxt_.text = var_84_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(935011020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 25
				local var_84_7 = utf8.len(var_84_5)
				local var_84_8 = var_84_6 <= 0 and var_84_2 or var_84_2 * (var_84_7 / var_84_6)

				if var_84_8 > 0 and var_84_2 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_9 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_9 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_9

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_9 and arg_81_1.time_ < var_84_1 + var_84_9 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play935011021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 935011021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play935011022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			local var_88_2 = 0
			local var_88_3 = 1.425

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_4 = arg_85_1:FormatText(StoryNameCfg[318].name)

				arg_85_1.leftNameTxt_.text = var_88_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(935011021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 57
				local var_88_8 = utf8.len(var_88_6)
				local var_88_9 = var_88_7 <= 0 and var_88_3 or var_88_3 * (var_88_8 / var_88_7)

				if var_88_9 > 0 and var_88_3 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play935011022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 935011022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play935011023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1070ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1070ui_story == nil then
				arg_89_1.var_.characterEffect1070ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1070ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1070ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1070ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1070ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 1.15

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(935011022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 46
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play935011023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 935011023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play935011024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.4

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(935011023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 56
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play935011024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 935011024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play935011025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10039ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10039ui_story == nil then
				arg_97_1.var_.characterEffect10039ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10039ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10039ui_story then
				arg_97_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 0.625

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[472].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(935011024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 25
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play935011025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 935011025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play935011026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1070ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1070ui_story == nil then
				arg_101_1.var_.characterEffect1070ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1070ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1070ui_story then
				arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["10039ui_story"]
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10039ui_story == nil then
				arg_101_1.var_.characterEffect10039ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 and not isNil(var_104_4) then
				local var_104_7 = (arg_101_1.time_ - var_104_5) / var_104_6

				if arg_101_1.var_.characterEffect10039ui_story and not isNil(var_104_4) then
					local var_104_8 = Mathf.Lerp(0, 0.5, var_104_7)

					arg_101_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10039ui_story.fillRatio = var_104_8
				end
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10039ui_story then
				local var_104_9 = 0.5

				arg_101_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10039ui_story.fillRatio = var_104_9
			end

			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_12 = 0
			local var_104_13 = 0.05

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[318].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(935011025)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 2
				local var_104_18 = utf8.len(var_104_16)
				local var_104_19 = var_104_17 <= 0 and var_104_13 or var_104_13 * (var_104_18 / var_104_17)

				if var_104_19 > 0 and var_104_13 < var_104_19 then
					arg_101_1.talkMaxDuration = var_104_19

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_20 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_20 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_12) / var_104_20

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_12 + var_104_20 and arg_101_1.time_ < var_104_12 + var_104_20 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play935011026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 935011026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play935011027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1070ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1070ui_story == nil then
				arg_105_1.var_.characterEffect1070ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1070ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1070ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1070ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1070ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.8

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(935011026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 32
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_7 or var_108_7 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_7 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_13 and arg_105_1.time_ < var_108_6 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play935011027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 935011027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play935011028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10039ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10039ui_story == nil then
				arg_109_1.var_.characterEffect10039ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10039ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10039ui_story then
				arg_109_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_1")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_112_6 = 0
			local var_112_7 = 0.55

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[472].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(935011027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 22
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
	Play935011028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 935011028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play935011029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1070ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1070ui_story == nil then
				arg_113_1.var_.characterEffect1070ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1070ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1070ui_story then
				arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["10039ui_story"]
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10039ui_story == nil then
				arg_113_1.var_.characterEffect10039ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 and not isNil(var_116_4) then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6

				if arg_113_1.var_.characterEffect10039ui_story and not isNil(var_116_4) then
					local var_116_8 = Mathf.Lerp(0, 0.5, var_116_7)

					arg_113_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10039ui_story.fillRatio = var_116_8
				end
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10039ui_story then
				local var_116_9 = 0.5

				arg_113_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10039ui_story.fillRatio = var_116_9
			end

			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_116_11 = 0
			local var_116_12 = 0.1

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_13 = arg_113_1:FormatText(StoryNameCfg[318].name)

				arg_113_1.leftNameTxt_.text = var_116_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(935011028)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 4
				local var_116_17 = utf8.len(var_116_15)
				local var_116_18 = var_116_16 <= 0 and var_116_12 or var_116_12 * (var_116_17 / var_116_16)

				if var_116_18 > 0 and var_116_12 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_19 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_19 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_19

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_19 and arg_113_1.time_ < var_116_11 + var_116_19 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play935011029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 935011029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play935011030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1070ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1070ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1070ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1070ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1070ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.575

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(935011029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 23
				local var_120_11 = utf8.len(var_120_9)
				local var_120_12 = var_120_10 <= 0 and var_120_7 or var_120_7 * (var_120_11 / var_120_10)

				if var_120_12 > 0 and var_120_7 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_13 and arg_117_1.time_ < var_120_6 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play935011030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 935011030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play935011031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1070ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1070ui_story == nil then
				arg_121_1.var_.characterEffect1070ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1070ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1070ui_story then
				arg_121_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_124_6 = 0
			local var_124_7 = 0.125

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[318].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(935011030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 5
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
	Play935011031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 935011031
		arg_125_1.duration_ = 9

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play935011032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = "ST2003"

			if arg_125_1.bgs_[var_128_0] == nil then
				local var_128_1 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_0)
				var_128_1.name = var_128_0
				var_128_1.transform.parent = arg_125_1.stage_.transform
				var_128_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_0] = var_128_1
			end

			local var_128_2 = 2

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				local var_128_3 = manager.ui.mainCamera.transform.localPosition
				local var_128_4 = Vector3.New(0, 0, 10) + Vector3.New(var_128_3.x, var_128_3.y, 0)
				local var_128_5 = arg_125_1.bgs_.ST2003

				var_128_5.transform.localPosition = var_128_4
				var_128_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_6 = var_128_5:GetComponent("SpriteRenderer")

				if var_128_6 and var_128_6.sprite then
					local var_128_7 = (var_128_5.transform.localPosition - var_128_3).z
					local var_128_8 = manager.ui.mainCameraCom_
					local var_128_9 = 2 * var_128_7 * Mathf.Tan(var_128_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_128_10 = var_128_9 * var_128_8.aspect
					local var_128_11 = var_128_6.sprite.bounds.size.x
					local var_128_12 = var_128_6.sprite.bounds.size.y
					local var_128_13 = var_128_10 / var_128_11
					local var_128_14 = var_128_9 / var_128_12
					local var_128_15 = var_128_14 < var_128_13 and var_128_13 or var_128_14

					var_128_5.transform.localScale = Vector3.New(var_128_15, var_128_15, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "ST2003" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_16 = 4

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_17 = 0.3

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_18 = 0

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_19 = 2

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_19 then
				local var_128_20 = (arg_125_1.time_ - var_128_18) / var_128_19
				local var_128_21 = Color.New(0, 0, 0)

				var_128_21.a = Mathf.Lerp(0, 1, var_128_20)
				arg_125_1.mask_.color = var_128_21
			end

			if arg_125_1.time_ >= var_128_18 + var_128_19 and arg_125_1.time_ < var_128_18 + var_128_19 + arg_128_0 then
				local var_128_22 = Color.New(0, 0, 0)

				var_128_22.a = 1
				arg_125_1.mask_.color = var_128_22
			end

			local var_128_23 = 2

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_24 = 2

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				local var_128_25 = (arg_125_1.time_ - var_128_23) / var_128_24
				local var_128_26 = Color.New(0, 0, 0)

				var_128_26.a = Mathf.Lerp(1, 0, var_128_25)
				arg_125_1.mask_.color = var_128_26
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				local var_128_27 = Color.New(0, 0, 0)
				local var_128_28 = 0

				arg_125_1.mask_.enabled = false
				var_128_27.a = var_128_28
				arg_125_1.mask_.color = var_128_27
			end

			local var_128_29 = arg_125_1.actors_["1070ui_story"]
			local var_128_30 = 4

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 and not isNil(var_128_29) and arg_125_1.var_.characterEffect1070ui_story == nil then
				arg_125_1.var_.characterEffect1070ui_story = var_128_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_31 = 0.200000002980232

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_31 and not isNil(var_128_29) then
				local var_128_32 = (arg_125_1.time_ - var_128_30) / var_128_31

				if arg_125_1.var_.characterEffect1070ui_story and not isNil(var_128_29) then
					local var_128_33 = Mathf.Lerp(0, 0.5, var_128_32)

					arg_125_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1070ui_story.fillRatio = var_128_33
				end
			end

			if arg_125_1.time_ >= var_128_30 + var_128_31 and arg_125_1.time_ < var_128_30 + var_128_31 + arg_128_0 and not isNil(var_128_29) and arg_125_1.var_.characterEffect1070ui_story then
				local var_128_34 = 0.5

				arg_125_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1070ui_story.fillRatio = var_128_34
			end

			local var_128_35 = arg_125_1.actors_["1070ui_story"].transform
			local var_128_36 = 2

			if var_128_36 < arg_125_1.time_ and arg_125_1.time_ <= var_128_36 + arg_128_0 then
				arg_125_1.var_.moveOldPos1070ui_story = var_128_35.localPosition
			end

			local var_128_37 = 0.001

			if var_128_36 <= arg_125_1.time_ and arg_125_1.time_ < var_128_36 + var_128_37 then
				local var_128_38 = (arg_125_1.time_ - var_128_36) / var_128_37
				local var_128_39 = Vector3.New(0, 100, 0)

				var_128_35.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1070ui_story, var_128_39, var_128_38)

				local var_128_40 = manager.ui.mainCamera.transform.position - var_128_35.position

				var_128_35.forward = Vector3.New(var_128_40.x, var_128_40.y, var_128_40.z)

				local var_128_41 = var_128_35.localEulerAngles

				var_128_41.z = 0
				var_128_41.x = 0
				var_128_35.localEulerAngles = var_128_41
			end

			if arg_125_1.time_ >= var_128_36 + var_128_37 and arg_125_1.time_ < var_128_36 + var_128_37 + arg_128_0 then
				var_128_35.localPosition = Vector3.New(0, 100, 0)

				local var_128_42 = manager.ui.mainCamera.transform.position - var_128_35.position

				var_128_35.forward = Vector3.New(var_128_42.x, var_128_42.y, var_128_42.z)

				local var_128_43 = var_128_35.localEulerAngles

				var_128_43.z = 0
				var_128_43.x = 0
				var_128_35.localEulerAngles = var_128_43
			end

			local var_128_44 = arg_125_1.actors_["10039ui_story"].transform
			local var_128_45 = 2

			if var_128_45 < arg_125_1.time_ and arg_125_1.time_ <= var_128_45 + arg_128_0 then
				arg_125_1.var_.moveOldPos10039ui_story = var_128_44.localPosition
			end

			local var_128_46 = 0.001

			if var_128_45 <= arg_125_1.time_ and arg_125_1.time_ < var_128_45 + var_128_46 then
				local var_128_47 = (arg_125_1.time_ - var_128_45) / var_128_46
				local var_128_48 = Vector3.New(0, 100, 0)

				var_128_44.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10039ui_story, var_128_48, var_128_47)

				local var_128_49 = manager.ui.mainCamera.transform.position - var_128_44.position

				var_128_44.forward = Vector3.New(var_128_49.x, var_128_49.y, var_128_49.z)

				local var_128_50 = var_128_44.localEulerAngles

				var_128_50.z = 0
				var_128_50.x = 0
				var_128_44.localEulerAngles = var_128_50
			end

			if arg_125_1.time_ >= var_128_45 + var_128_46 and arg_125_1.time_ < var_128_45 + var_128_46 + arg_128_0 then
				var_128_44.localPosition = Vector3.New(0, 100, 0)

				local var_128_51 = manager.ui.mainCamera.transform.position - var_128_44.position

				var_128_44.forward = Vector3.New(var_128_51.x, var_128_51.y, var_128_51.z)

				local var_128_52 = var_128_44.localEulerAngles

				var_128_52.z = 0
				var_128_52.x = 0
				var_128_44.localEulerAngles = var_128_52
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_53 = 4
			local var_128_54 = 1.16666666666667

			if var_128_53 < arg_125_1.time_ and arg_125_1.time_ <= var_128_53 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_55 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_55:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_56 = arg_125_1:GetWordFromCfg(935011031)
				local var_128_57 = arg_125_1:FormatText(var_128_56.content)

				arg_125_1.text_.text = var_128_57

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_58 = 51
				local var_128_59 = utf8.len(var_128_57)
				local var_128_60 = var_128_58 <= 0 and var_128_54 or var_128_54 * (var_128_59 / var_128_58)

				if var_128_60 > 0 and var_128_54 < var_128_60 then
					arg_125_1.talkMaxDuration = var_128_60
					var_128_53 = var_128_53 + 0.3

					if var_128_60 + var_128_53 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_60 + var_128_53
					end
				end

				arg_125_1.text_.text = var_128_57
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_61 = var_128_53 + 0.3
			local var_128_62 = math.max(var_128_54, arg_125_1.talkMaxDuration)

			if var_128_61 <= arg_125_1.time_ and arg_125_1.time_ < var_128_61 + var_128_62 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_61) / var_128_62

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_61 + var_128_62 and arg_125_1.time_ < var_128_61 + var_128_62 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play935011032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 935011032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play935011033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.9

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(935011032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 36
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play935011033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 935011033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play935011034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.625

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(935011033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 25
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play935011034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 935011034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play935011035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10039ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10039ui_story == nil then
				arg_139_1.var_.characterEffect10039ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10039ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10039ui_story then
				arg_139_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["10039ui_story"].transform
			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.var_.moveOldPos10039ui_story = var_142_4.localPosition
			end

			local var_142_6 = 0.001

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_6 then
				local var_142_7 = (arg_139_1.time_ - var_142_5) / var_142_6
				local var_142_8 = Vector3.New(0.7, -0.8, -6.2)

				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10039ui_story, var_142_8, var_142_7)

				local var_142_9 = manager.ui.mainCamera.transform.position - var_142_4.position

				var_142_4.forward = Vector3.New(var_142_9.x, var_142_9.y, var_142_9.z)

				local var_142_10 = var_142_4.localEulerAngles

				var_142_10.z = 0
				var_142_10.x = 0
				var_142_4.localEulerAngles = var_142_10
			end

			if arg_139_1.time_ >= var_142_5 + var_142_6 and arg_139_1.time_ < var_142_5 + var_142_6 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_142_11 = manager.ui.mainCamera.transform.position - var_142_4.position

				var_142_4.forward = Vector3.New(var_142_11.x, var_142_11.y, var_142_11.z)

				local var_142_12 = var_142_4.localEulerAngles

				var_142_12.z = 0
				var_142_12.x = 0
				var_142_4.localEulerAngles = var_142_12
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_142_15 = 0
			local var_142_16 = 0.125

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[472].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(935011034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 5
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_23 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_23 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_23

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_23 and arg_139_1.time_ < var_142_15 + var_142_23 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play935011035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 935011035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play935011036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1070ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1070ui_story == nil then
				arg_143_1.var_.characterEffect1070ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1070ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1070ui_story then
				arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_146_4 = arg_143_1.actors_["10039ui_story"]
			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10039ui_story == nil then
				arg_143_1.var_.characterEffect10039ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_6 = 0.200000002980232

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_6 and not isNil(var_146_4) then
				local var_146_7 = (arg_143_1.time_ - var_146_5) / var_146_6

				if arg_143_1.var_.characterEffect10039ui_story and not isNil(var_146_4) then
					local var_146_8 = Mathf.Lerp(0, 0.5, var_146_7)

					arg_143_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10039ui_story.fillRatio = var_146_8
				end
			end

			if arg_143_1.time_ >= var_146_5 + var_146_6 and arg_143_1.time_ < var_146_5 + var_146_6 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10039ui_story then
				local var_146_9 = 0.5

				arg_143_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10039ui_story.fillRatio = var_146_9
			end

			local var_146_10 = arg_143_1.actors_["1070ui_story"].transform
			local var_146_11 = 0

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.var_.moveOldPos1070ui_story = var_146_10.localPosition
			end

			local var_146_12 = 0.001

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_12 then
				local var_146_13 = (arg_143_1.time_ - var_146_11) / var_146_12
				local var_146_14 = Vector3.New(-0.7, -0.95, -6.05)

				var_146_10.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1070ui_story, var_146_14, var_146_13)

				local var_146_15 = manager.ui.mainCamera.transform.position - var_146_10.position

				var_146_10.forward = Vector3.New(var_146_15.x, var_146_15.y, var_146_15.z)

				local var_146_16 = var_146_10.localEulerAngles

				var_146_16.z = 0
				var_146_16.x = 0
				var_146_10.localEulerAngles = var_146_16
			end

			if arg_143_1.time_ >= var_146_11 + var_146_12 and arg_143_1.time_ < var_146_11 + var_146_12 + arg_146_0 then
				var_146_10.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_146_17 = manager.ui.mainCamera.transform.position - var_146_10.position

				var_146_10.forward = Vector3.New(var_146_17.x, var_146_17.y, var_146_17.z)

				local var_146_18 = var_146_10.localEulerAngles

				var_146_18.z = 0
				var_146_18.x = 0
				var_146_10.localEulerAngles = var_146_18
			end

			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_146_20 = 0

			if var_146_20 < arg_143_1.time_ and arg_143_1.time_ <= var_146_20 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva", "EmotionTimelineAnimator")
			end

			local var_146_21 = 0
			local var_146_22 = 0.05

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_23 = arg_143_1:FormatText(StoryNameCfg[318].name)

				arg_143_1.leftNameTxt_.text = var_146_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_24 = arg_143_1:GetWordFromCfg(935011035)
				local var_146_25 = arg_143_1:FormatText(var_146_24.content)

				arg_143_1.text_.text = var_146_25

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_26 = 2
				local var_146_27 = utf8.len(var_146_25)
				local var_146_28 = var_146_26 <= 0 and var_146_22 or var_146_22 * (var_146_27 / var_146_26)

				if var_146_28 > 0 and var_146_22 < var_146_28 then
					arg_143_1.talkMaxDuration = var_146_28

					if var_146_28 + var_146_21 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_28 + var_146_21
					end
				end

				arg_143_1.text_.text = var_146_25
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_29 = math.max(var_146_22, arg_143_1.talkMaxDuration)

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_29 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_21) / var_146_29

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_21 + var_146_29 and arg_143_1.time_ < var_146_21 + var_146_29 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play935011036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 935011036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play935011037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1070ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1070ui_story == nil then
				arg_147_1.var_.characterEffect1070ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1070ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1070ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1070ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1070ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.85

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(935011036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 34
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_7 or var_150_7 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_7 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_13 and arg_147_1.time_ < var_150_6 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play935011037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 935011037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play935011038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10039ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10039ui_story == nil then
				arg_151_1.var_.characterEffect10039ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10039ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10039ui_story then
				arg_151_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_154_4 = 0
			local var_154_5 = 0.6

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_6 = arg_151_1:FormatText(StoryNameCfg[472].name)

				arg_151_1.leftNameTxt_.text = var_154_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(935011037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 24
				local var_154_10 = utf8.len(var_154_8)
				local var_154_11 = var_154_9 <= 0 and var_154_5 or var_154_5 * (var_154_10 / var_154_9)

				if var_154_11 > 0 and var_154_5 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play935011038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 935011038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play935011039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva", "EmotionTimelineAnimator")
			end

			local var_158_1 = 0
			local var_158_2 = 0.475

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_3 = arg_155_1:FormatText(StoryNameCfg[472].name)

				arg_155_1.leftNameTxt_.text = var_158_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(935011038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 19
				local var_158_7 = utf8.len(var_158_5)
				local var_158_8 = var_158_6 <= 0 and var_158_2 or var_158_2 * (var_158_7 / var_158_6)

				if var_158_8 > 0 and var_158_2 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_9 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_9 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_9

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_9 and arg_155_1.time_ < var_158_1 + var_158_9 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play935011039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 935011039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play935011040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1070ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1070ui_story == nil then
				arg_159_1.var_.characterEffect1070ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1070ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1070ui_story then
				arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["10039ui_story"]
			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect10039ui_story == nil then
				arg_159_1.var_.characterEffect10039ui_story = var_162_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_6 and not isNil(var_162_4) then
				local var_162_7 = (arg_159_1.time_ - var_162_5) / var_162_6

				if arg_159_1.var_.characterEffect10039ui_story and not isNil(var_162_4) then
					local var_162_8 = Mathf.Lerp(0, 0.5, var_162_7)

					arg_159_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10039ui_story.fillRatio = var_162_8
				end
			end

			if arg_159_1.time_ >= var_162_5 + var_162_6 and arg_159_1.time_ < var_162_5 + var_162_6 + arg_162_0 and not isNil(var_162_4) and arg_159_1.var_.characterEffect10039ui_story then
				local var_162_9 = 0.5

				arg_159_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10039ui_story.fillRatio = var_162_9
			end

			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_162_11 = 0
			local var_162_12 = 0.125

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_13 = arg_159_1:FormatText(StoryNameCfg[318].name)

				arg_159_1.leftNameTxt_.text = var_162_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_14 = arg_159_1:GetWordFromCfg(935011039)
				local var_162_15 = arg_159_1:FormatText(var_162_14.content)

				arg_159_1.text_.text = var_162_15

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_16 = 5
				local var_162_17 = utf8.len(var_162_15)
				local var_162_18 = var_162_16 <= 0 and var_162_12 or var_162_12 * (var_162_17 / var_162_16)

				if var_162_18 > 0 and var_162_12 < var_162_18 then
					arg_159_1.talkMaxDuration = var_162_18

					if var_162_18 + var_162_11 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_11
					end
				end

				arg_159_1.text_.text = var_162_15
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_19 = math.max(var_162_12, arg_159_1.talkMaxDuration)

			if var_162_11 <= arg_159_1.time_ and arg_159_1.time_ < var_162_11 + var_162_19 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_11) / var_162_19

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_11 + var_162_19 and arg_159_1.time_ < var_162_11 + var_162_19 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play935011040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 935011040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play935011041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10039ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10039ui_story == nil then
				arg_163_1.var_.characterEffect10039ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10039ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10039ui_story then
				arg_163_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["1070ui_story"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1070ui_story == nil then
				arg_163_1.var_.characterEffect1070ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.characterEffect1070ui_story and not isNil(var_166_4) then
					local var_166_8 = Mathf.Lerp(0, 0.5, var_166_7)

					arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1070ui_story.fillRatio = var_166_8
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect1070ui_story then
				local var_166_9 = 0.5

				arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1070ui_story.fillRatio = var_166_9
			end

			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_166_11 = 0

			if var_166_11 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action463")
			end

			local var_166_12 = 0
			local var_166_13 = 0.225

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_14 = arg_163_1:FormatText(StoryNameCfg[472].name)

				arg_163_1.leftNameTxt_.text = var_166_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_15 = arg_163_1:GetWordFromCfg(935011040)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 9
				local var_166_18 = utf8.len(var_166_16)
				local var_166_19 = var_166_17 <= 0 and var_166_13 or var_166_13 * (var_166_18 / var_166_17)

				if var_166_19 > 0 and var_166_13 < var_166_19 then
					arg_163_1.talkMaxDuration = var_166_19

					if var_166_19 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_19 + var_166_12
					end
				end

				arg_163_1.text_.text = var_166_16
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_20 and arg_163_1.time_ < var_166_12 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play935011041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 935011041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play935011042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1070ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1070ui_story == nil then
				arg_167_1.var_.characterEffect1070ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1070ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1070ui_story then
				arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_170_4 = arg_167_1.actors_["10039ui_story"]
			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect10039ui_story == nil then
				arg_167_1.var_.characterEffect10039ui_story = var_170_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_6 and not isNil(var_170_4) then
				local var_170_7 = (arg_167_1.time_ - var_170_5) / var_170_6

				if arg_167_1.var_.characterEffect10039ui_story and not isNil(var_170_4) then
					local var_170_8 = Mathf.Lerp(0, 0.5, var_170_7)

					arg_167_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10039ui_story.fillRatio = var_170_8
				end
			end

			if arg_167_1.time_ >= var_170_5 + var_170_6 and arg_167_1.time_ < var_170_5 + var_170_6 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect10039ui_story then
				local var_170_9 = 0.5

				arg_167_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10039ui_story.fillRatio = var_170_9
			end

			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_170_11 = 0

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_170_12 = 0
			local var_170_13 = 0.1

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_14 = arg_167_1:FormatText(StoryNameCfg[318].name)

				arg_167_1.leftNameTxt_.text = var_170_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_15 = arg_167_1:GetWordFromCfg(935011041)
				local var_170_16 = arg_167_1:FormatText(var_170_15.content)

				arg_167_1.text_.text = var_170_16

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 4
				local var_170_18 = utf8.len(var_170_16)
				local var_170_19 = var_170_17 <= 0 and var_170_13 or var_170_13 * (var_170_18 / var_170_17)

				if var_170_19 > 0 and var_170_13 < var_170_19 then
					arg_167_1.talkMaxDuration = var_170_19

					if var_170_19 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_19 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_16
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_20 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_20 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_20

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_20 and arg_167_1.time_ < var_170_12 + var_170_20 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play935011042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 935011042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play935011043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10039ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10039ui_story == nil then
				arg_171_1.var_.characterEffect10039ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect10039ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10039ui_story then
				arg_171_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1070ui_story"]
			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1070ui_story == nil then
				arg_171_1.var_.characterEffect1070ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 and not isNil(var_174_4) then
				local var_174_7 = (arg_171_1.time_ - var_174_5) / var_174_6

				if arg_171_1.var_.characterEffect1070ui_story and not isNil(var_174_4) then
					local var_174_8 = Mathf.Lerp(0, 0.5, var_174_7)

					arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1070ui_story.fillRatio = var_174_8
				end
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1070ui_story then
				local var_174_9 = 0.5

				arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1070ui_story.fillRatio = var_174_9
			end

			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_174_11 = 0

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action3_2")
			end

			local var_174_12 = 0
			local var_174_13 = 0.25

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_14 = arg_171_1:FormatText(StoryNameCfg[472].name)

				arg_171_1.leftNameTxt_.text = var_174_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_15 = arg_171_1:GetWordFromCfg(935011042)
				local var_174_16 = arg_171_1:FormatText(var_174_15.content)

				arg_171_1.text_.text = var_174_16

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_17 = 10
				local var_174_18 = utf8.len(var_174_16)
				local var_174_19 = var_174_17 <= 0 and var_174_13 or var_174_13 * (var_174_18 / var_174_17)

				if var_174_19 > 0 and var_174_13 < var_174_19 then
					arg_171_1.talkMaxDuration = var_174_19

					if var_174_19 + var_174_12 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_19 + var_174_12
					end
				end

				arg_171_1.text_.text = var_174_16
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_20 = math.max(var_174_13, arg_171_1.talkMaxDuration)

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_20 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_12) / var_174_20

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_12 + var_174_20 and arg_171_1.time_ < var_174_12 + var_174_20 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play935011043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 935011043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play935011044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.4

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[472].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(935011043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 16
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
	Play935011044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 935011044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play935011045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1070ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1070ui_story == nil then
				arg_179_1.var_.characterEffect1070ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.166666666666667

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1070ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1070ui_story then
				arg_179_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["10039ui_story"]
			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect10039ui_story == nil then
				arg_179_1.var_.characterEffect10039ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_6 = 0.166666666666667

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_6 and not isNil(var_182_4) then
				local var_182_7 = (arg_179_1.time_ - var_182_5) / var_182_6

				if arg_179_1.var_.characterEffect10039ui_story and not isNil(var_182_4) then
					local var_182_8 = Mathf.Lerp(0, 0.5, var_182_7)

					arg_179_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10039ui_story.fillRatio = var_182_8
				end
			end

			if arg_179_1.time_ >= var_182_5 + var_182_6 and arg_179_1.time_ < var_182_5 + var_182_6 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect10039ui_story then
				local var_182_9 = 0.5

				arg_179_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10039ui_story.fillRatio = var_182_9
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_11 = arg_179_1.actors_["10039ui_story"].transform
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 then
				arg_179_1.var_.moveOldPos10039ui_story = var_182_11.localPosition
			end

			local var_182_13 = 0.001

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13
				local var_182_15 = Vector3.New(0.7, -0.8, -6.2)

				var_182_11.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10039ui_story, var_182_15, var_182_14)

				local var_182_16 = manager.ui.mainCamera.transform.position - var_182_11.position

				var_182_11.forward = Vector3.New(var_182_16.x, var_182_16.y, var_182_16.z)

				local var_182_17 = var_182_11.localEulerAngles

				var_182_17.z = 0
				var_182_17.x = 0
				var_182_11.localEulerAngles = var_182_17
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 then
				var_182_11.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_182_18 = manager.ui.mainCamera.transform.position - var_182_11.position

				var_182_11.forward = Vector3.New(var_182_18.x, var_182_18.y, var_182_18.z)

				local var_182_19 = var_182_11.localEulerAngles

				var_182_19.z = 0
				var_182_19.x = 0
				var_182_11.localEulerAngles = var_182_19
			end

			local var_182_20 = 0

			if var_182_20 < arg_179_1.time_ and arg_179_1.time_ <= var_182_20 + arg_182_0 then
				arg_179_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_182_21 = 0

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 then
				arg_179_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			local var_182_22 = 0
			local var_182_23 = 0.675

			if var_182_22 < arg_179_1.time_ and arg_179_1.time_ <= var_182_22 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_24 = arg_179_1:FormatText(StoryNameCfg[318].name)

				arg_179_1.leftNameTxt_.text = var_182_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_25 = arg_179_1:GetWordFromCfg(935011044)
				local var_182_26 = arg_179_1:FormatText(var_182_25.content)

				arg_179_1.text_.text = var_182_26

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_27 = 27
				local var_182_28 = utf8.len(var_182_26)
				local var_182_29 = var_182_27 <= 0 and var_182_23 or var_182_23 * (var_182_28 / var_182_27)

				if var_182_29 > 0 and var_182_23 < var_182_29 then
					arg_179_1.talkMaxDuration = var_182_29

					if var_182_29 + var_182_22 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_29 + var_182_22
					end
				end

				arg_179_1.text_.text = var_182_26
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_30 = math.max(var_182_23, arg_179_1.talkMaxDuration)

			if var_182_22 <= arg_179_1.time_ and arg_179_1.time_ < var_182_22 + var_182_30 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_22) / var_182_30

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_22 + var_182_30 and arg_179_1.time_ < var_182_22 + var_182_30 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play935011045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 935011045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play935011046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1070ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1070ui_story == nil then
				arg_183_1.var_.characterEffect1070ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1070ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1070ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1070ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1070ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_7 = 0
			local var_186_8 = 0.725

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_9 = arg_183_1:GetWordFromCfg(935011045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 29
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_8 or var_186_8 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_8 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_7 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_7
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_8, arg_183_1.talkMaxDuration)

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_7) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_7 + var_186_14 and arg_183_1.time_ < var_186_7 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play935011046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 935011046
		arg_187_1.duration_ = 9

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play935011047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_1 = manager.ui.mainCamera.transform.localPosition
				local var_190_2 = Vector3.New(0, 0, 10) + Vector3.New(var_190_1.x, var_190_1.y, 0)
				local var_190_3 = arg_187_1.bgs_.ST2003

				var_190_3.transform.localPosition = var_190_2
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = (var_190_3.transform.localPosition - var_190_1).z
					local var_190_6 = manager.ui.mainCameraCom_
					local var_190_7 = 2 * var_190_5 * Mathf.Tan(var_190_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_8 = var_190_7 * var_190_6.aspect
					local var_190_9 = var_190_4.sprite.bounds.size.x
					local var_190_10 = var_190_4.sprite.bounds.size.y
					local var_190_11 = var_190_8 / var_190_9
					local var_190_12 = var_190_7 / var_190_10
					local var_190_13 = var_190_12 < var_190_11 and var_190_11 or var_190_12

					var_190_3.transform.localScale = Vector3.New(var_190_13, var_190_13, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST2003" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_14 = 2

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				local var_190_15 = manager.ui.mainCamera.transform.localPosition
				local var_190_16 = Vector3.New(0, 0, 10) + Vector3.New(var_190_15.x, var_190_15.y, 0)
				local var_190_17 = arg_187_1.bgs_.ST2003

				var_190_17.transform.localPosition = var_190_16
				var_190_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_18 = var_190_17:GetComponent("SpriteRenderer")

				if var_190_18 and var_190_18.sprite then
					local var_190_19 = (var_190_17.transform.localPosition - var_190_15).z
					local var_190_20 = manager.ui.mainCameraCom_
					local var_190_21 = 2 * var_190_19 * Mathf.Tan(var_190_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_22 = var_190_21 * var_190_20.aspect
					local var_190_23 = var_190_18.sprite.bounds.size.x
					local var_190_24 = var_190_18.sprite.bounds.size.y
					local var_190_25 = var_190_22 / var_190_23
					local var_190_26 = var_190_21 / var_190_24
					local var_190_27 = var_190_26 < var_190_25 and var_190_25 or var_190_26

					var_190_17.transform.localScale = Vector3.New(var_190_27, var_190_27, 0)
				end

				for iter_190_2, iter_190_3 in pairs(arg_187_1.bgs_) do
					if iter_190_2 ~= "ST2003" then
						iter_190_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_28 = 0

			if var_190_28 < arg_187_1.time_ and arg_187_1.time_ <= var_190_28 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_29 = 0.3

			if arg_187_1.time_ >= var_190_28 + var_190_29 and arg_187_1.time_ < var_190_28 + var_190_29 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_30 = 0

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_31 = 2

			if var_190_30 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_31 then
				local var_190_32 = (arg_187_1.time_ - var_190_30) / var_190_31
				local var_190_33 = Color.New(0, 0, 0)

				var_190_33.a = Mathf.Lerp(0, 1, var_190_32)
				arg_187_1.mask_.color = var_190_33
			end

			if arg_187_1.time_ >= var_190_30 + var_190_31 and arg_187_1.time_ < var_190_30 + var_190_31 + arg_190_0 then
				local var_190_34 = Color.New(0, 0, 0)

				var_190_34.a = 1
				arg_187_1.mask_.color = var_190_34
			end

			local var_190_35 = 2

			if var_190_35 < arg_187_1.time_ and arg_187_1.time_ <= var_190_35 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_36 = 2

			if var_190_35 <= arg_187_1.time_ and arg_187_1.time_ < var_190_35 + var_190_36 then
				local var_190_37 = (arg_187_1.time_ - var_190_35) / var_190_36
				local var_190_38 = Color.New(0, 0, 0)

				var_190_38.a = Mathf.Lerp(1, 0, var_190_37)
				arg_187_1.mask_.color = var_190_38
			end

			if arg_187_1.time_ >= var_190_35 + var_190_36 and arg_187_1.time_ < var_190_35 + var_190_36 + arg_190_0 then
				local var_190_39 = Color.New(0, 0, 0)
				local var_190_40 = 0

				arg_187_1.mask_.enabled = false
				var_190_39.a = var_190_40
				arg_187_1.mask_.color = var_190_39
			end

			local var_190_41 = arg_187_1.actors_["1070ui_story"].transform
			local var_190_42 = 4

			if var_190_42 < arg_187_1.time_ and arg_187_1.time_ <= var_190_42 + arg_190_0 then
				arg_187_1.var_.moveOldPos1070ui_story = var_190_41.localPosition
			end

			local var_190_43 = 0.001

			if var_190_42 <= arg_187_1.time_ and arg_187_1.time_ < var_190_42 + var_190_43 then
				local var_190_44 = (arg_187_1.time_ - var_190_42) / var_190_43
				local var_190_45 = Vector3.New(-0.7, -0.95, -6.05)

				var_190_41.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1070ui_story, var_190_45, var_190_44)

				local var_190_46 = manager.ui.mainCamera.transform.position - var_190_41.position

				var_190_41.forward = Vector3.New(var_190_46.x, var_190_46.y, var_190_46.z)

				local var_190_47 = var_190_41.localEulerAngles

				var_190_47.z = 0
				var_190_47.x = 0
				var_190_41.localEulerAngles = var_190_47
			end

			if arg_187_1.time_ >= var_190_42 + var_190_43 and arg_187_1.time_ < var_190_42 + var_190_43 + arg_190_0 then
				var_190_41.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_190_48 = manager.ui.mainCamera.transform.position - var_190_41.position

				var_190_41.forward = Vector3.New(var_190_48.x, var_190_48.y, var_190_48.z)

				local var_190_49 = var_190_41.localEulerAngles

				var_190_49.z = 0
				var_190_49.x = 0
				var_190_41.localEulerAngles = var_190_49
			end

			local var_190_50 = arg_187_1.actors_["1070ui_story"]
			local var_190_51 = 4

			if var_190_51 < arg_187_1.time_ and arg_187_1.time_ <= var_190_51 + arg_190_0 and not isNil(var_190_50) and arg_187_1.var_.characterEffect1070ui_story == nil then
				arg_187_1.var_.characterEffect1070ui_story = var_190_50:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_52 = 0.200000002980232

			if var_190_51 <= arg_187_1.time_ and arg_187_1.time_ < var_190_51 + var_190_52 and not isNil(var_190_50) then
				local var_190_53 = (arg_187_1.time_ - var_190_51) / var_190_52

				if arg_187_1.var_.characterEffect1070ui_story and not isNil(var_190_50) then
					arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_51 + var_190_52 and arg_187_1.time_ < var_190_51 + var_190_52 + arg_190_0 and not isNil(var_190_50) and arg_187_1.var_.characterEffect1070ui_story then
				arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_190_54 = arg_187_1.actors_["1070ui_story"].transform
			local var_190_55 = 1.98333333333333

			if var_190_55 < arg_187_1.time_ and arg_187_1.time_ <= var_190_55 + arg_190_0 then
				arg_187_1.var_.moveOldPos1070ui_story = var_190_54.localPosition
			end

			local var_190_56 = 0.001

			if var_190_55 <= arg_187_1.time_ and arg_187_1.time_ < var_190_55 + var_190_56 then
				local var_190_57 = (arg_187_1.time_ - var_190_55) / var_190_56
				local var_190_58 = Vector3.New(0, 100, 0)

				var_190_54.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1070ui_story, var_190_58, var_190_57)

				local var_190_59 = manager.ui.mainCamera.transform.position - var_190_54.position

				var_190_54.forward = Vector3.New(var_190_59.x, var_190_59.y, var_190_59.z)

				local var_190_60 = var_190_54.localEulerAngles

				var_190_60.z = 0
				var_190_60.x = 0
				var_190_54.localEulerAngles = var_190_60
			end

			if arg_187_1.time_ >= var_190_55 + var_190_56 and arg_187_1.time_ < var_190_55 + var_190_56 + arg_190_0 then
				var_190_54.localPosition = Vector3.New(0, 100, 0)

				local var_190_61 = manager.ui.mainCamera.transform.position - var_190_54.position

				var_190_54.forward = Vector3.New(var_190_61.x, var_190_61.y, var_190_61.z)

				local var_190_62 = var_190_54.localEulerAngles

				var_190_62.z = 0
				var_190_62.x = 0
				var_190_54.localEulerAngles = var_190_62
			end

			local var_190_63 = arg_187_1.actors_["10039ui_story"].transform
			local var_190_64 = 1.98333333333333

			if var_190_64 < arg_187_1.time_ and arg_187_1.time_ <= var_190_64 + arg_190_0 then
				arg_187_1.var_.moveOldPos10039ui_story = var_190_63.localPosition
			end

			local var_190_65 = 0.001

			if var_190_64 <= arg_187_1.time_ and arg_187_1.time_ < var_190_64 + var_190_65 then
				local var_190_66 = (arg_187_1.time_ - var_190_64) / var_190_65
				local var_190_67 = Vector3.New(0, 100, 0)

				var_190_63.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10039ui_story, var_190_67, var_190_66)

				local var_190_68 = manager.ui.mainCamera.transform.position - var_190_63.position

				var_190_63.forward = Vector3.New(var_190_68.x, var_190_68.y, var_190_68.z)

				local var_190_69 = var_190_63.localEulerAngles

				var_190_69.z = 0
				var_190_69.x = 0
				var_190_63.localEulerAngles = var_190_69
			end

			if arg_187_1.time_ >= var_190_64 + var_190_65 and arg_187_1.time_ < var_190_64 + var_190_65 + arg_190_0 then
				var_190_63.localPosition = Vector3.New(0, 100, 0)

				local var_190_70 = manager.ui.mainCamera.transform.position - var_190_63.position

				var_190_63.forward = Vector3.New(var_190_70.x, var_190_70.y, var_190_70.z)

				local var_190_71 = var_190_63.localEulerAngles

				var_190_71.z = 0
				var_190_71.x = 0
				var_190_63.localEulerAngles = var_190_71
			end

			local var_190_72 = 4

			if var_190_72 < arg_187_1.time_ and arg_187_1.time_ <= var_190_72 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_190_73 = 4

			if var_190_73 < arg_187_1.time_ and arg_187_1.time_ <= var_190_73 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_74 = 4
			local var_190_75 = 0.175

			if var_190_74 < arg_187_1.time_ and arg_187_1.time_ <= var_190_74 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_76 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_76:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_77 = arg_187_1:FormatText(StoryNameCfg[318].name)

				arg_187_1.leftNameTxt_.text = var_190_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_78 = arg_187_1:GetWordFromCfg(935011046)
				local var_190_79 = arg_187_1:FormatText(var_190_78.content)

				arg_187_1.text_.text = var_190_79

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_80 = 7
				local var_190_81 = utf8.len(var_190_79)
				local var_190_82 = var_190_80 <= 0 and var_190_75 or var_190_75 * (var_190_81 / var_190_80)

				if var_190_82 > 0 and var_190_75 < var_190_82 then
					arg_187_1.talkMaxDuration = var_190_82
					var_190_74 = var_190_74 + 0.3

					if var_190_82 + var_190_74 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_82 + var_190_74
					end
				end

				arg_187_1.text_.text = var_190_79
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_83 = var_190_74 + 0.3
			local var_190_84 = math.max(var_190_75, arg_187_1.talkMaxDuration)

			if var_190_83 <= arg_187_1.time_ and arg_187_1.time_ < var_190_83 + var_190_84 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_83) / var_190_84

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_83 + var_190_84 and arg_187_1.time_ < var_190_83 + var_190_84 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play935011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 935011047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play935011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10039ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10039ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0.7, -0.8, -6.2)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10039ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["10039ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10039ui_story == nil then
				arg_193_1.var_.characterEffect10039ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect10039ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10039ui_story then
				arg_193_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_196_13 = arg_193_1.actors_["1070ui_story"]
			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 and not isNil(var_196_13) and arg_193_1.var_.characterEffect1070ui_story == nil then
				arg_193_1.var_.characterEffect1070ui_story = var_196_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_15 = 0.200000002980232

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_15 and not isNil(var_196_13) then
				local var_196_16 = (arg_193_1.time_ - var_196_14) / var_196_15

				if arg_193_1.var_.characterEffect1070ui_story and not isNil(var_196_13) then
					local var_196_17 = Mathf.Lerp(0, 0.5, var_196_16)

					arg_193_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1070ui_story.fillRatio = var_196_17
				end
			end

			if arg_193_1.time_ >= var_196_14 + var_196_15 and arg_193_1.time_ < var_196_14 + var_196_15 + arg_196_0 and not isNil(var_196_13) and arg_193_1.var_.characterEffect1070ui_story then
				local var_196_18 = 0.5

				arg_193_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1070ui_story.fillRatio = var_196_18
			end

			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_1")
			end

			local var_196_20 = 0

			if var_196_20 < arg_193_1.time_ and arg_193_1.time_ <= var_196_20 + arg_196_0 then
				arg_193_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_196_21 = 0
			local var_196_22 = 0.225

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_23 = arg_193_1:FormatText(StoryNameCfg[472].name)

				arg_193_1.leftNameTxt_.text = var_196_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_24 = arg_193_1:GetWordFromCfg(935011047)
				local var_196_25 = arg_193_1:FormatText(var_196_24.content)

				arg_193_1.text_.text = var_196_25

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_26 = 9
				local var_196_27 = utf8.len(var_196_25)
				local var_196_28 = var_196_26 <= 0 and var_196_22 or var_196_22 * (var_196_27 / var_196_26)

				if var_196_28 > 0 and var_196_22 < var_196_28 then
					arg_193_1.talkMaxDuration = var_196_28

					if var_196_28 + var_196_21 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_28 + var_196_21
					end
				end

				arg_193_1.text_.text = var_196_25
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_29 = math.max(var_196_22, arg_193_1.talkMaxDuration)

			if var_196_21 <= arg_193_1.time_ and arg_193_1.time_ < var_196_21 + var_196_29 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_21) / var_196_29

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_21 + var_196_29 and arg_193_1.time_ < var_196_21 + var_196_29 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play935011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 935011048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play935011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1070ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1070ui_story == nil then
				arg_197_1.var_.characterEffect1070ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1070ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1070ui_story then
				arg_197_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["10039ui_story"]
			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect10039ui_story == nil then
				arg_197_1.var_.characterEffect10039ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.200000002980232

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_6 and not isNil(var_200_4) then
				local var_200_7 = (arg_197_1.time_ - var_200_5) / var_200_6

				if arg_197_1.var_.characterEffect10039ui_story and not isNil(var_200_4) then
					local var_200_8 = Mathf.Lerp(0, 0.5, var_200_7)

					arg_197_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10039ui_story.fillRatio = var_200_8
				end
			end

			if arg_197_1.time_ >= var_200_5 + var_200_6 and arg_197_1.time_ < var_200_5 + var_200_6 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect10039ui_story then
				local var_200_9 = 0.5

				arg_197_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10039ui_story.fillRatio = var_200_9
			end

			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_200_11 = 0

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_200_12 = 0
			local var_200_13 = 0.275

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_14 = arg_197_1:FormatText(StoryNameCfg[318].name)

				arg_197_1.leftNameTxt_.text = var_200_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(935011048)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 11
				local var_200_18 = utf8.len(var_200_16)
				local var_200_19 = var_200_17 <= 0 and var_200_13 or var_200_13 * (var_200_18 / var_200_17)

				if var_200_19 > 0 and var_200_13 < var_200_19 then
					arg_197_1.talkMaxDuration = var_200_19

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_20 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_20 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_20

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_20 and arg_197_1.time_ < var_200_12 + var_200_20 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play935011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 935011049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play935011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10039ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10039ui_story == nil then
				arg_201_1.var_.characterEffect10039ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect10039ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10039ui_story then
				arg_201_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1070ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1070ui_story == nil then
				arg_201_1.var_.characterEffect1070ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect1070ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1070ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1070ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1070ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action423")
			end

			local var_204_11 = 0

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_204_12 = 0
			local var_204_13 = 0.15

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_14 = arg_201_1:FormatText(StoryNameCfg[472].name)

				arg_201_1.leftNameTxt_.text = var_204_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_15 = arg_201_1:GetWordFromCfg(935011049)
				local var_204_16 = arg_201_1:FormatText(var_204_15.content)

				arg_201_1.text_.text = var_204_16

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_17 = 6
				local var_204_18 = utf8.len(var_204_16)
				local var_204_19 = var_204_17 <= 0 and var_204_13 or var_204_13 * (var_204_18 / var_204_17)

				if var_204_19 > 0 and var_204_13 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_12
					end
				end

				arg_201_1.text_.text = var_204_16
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_20 = math.max(var_204_13, arg_201_1.talkMaxDuration)

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_20 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_12) / var_204_20

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_12 + var_204_20 and arg_201_1.time_ < var_204_12 + var_204_20 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play935011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 935011050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play935011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1070ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1070ui_story == nil then
				arg_205_1.var_.characterEffect1070ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1070ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1070ui_story then
				arg_205_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_208_4 = arg_205_1.actors_["10039ui_story"]
			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10039ui_story == nil then
				arg_205_1.var_.characterEffect10039ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_6 = 0.200000002980232

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 and not isNil(var_208_4) then
				local var_208_7 = (arg_205_1.time_ - var_208_5) / var_208_6

				if arg_205_1.var_.characterEffect10039ui_story and not isNil(var_208_4) then
					local var_208_8 = Mathf.Lerp(0, 0.5, var_208_7)

					arg_205_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10039ui_story.fillRatio = var_208_8
				end
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10039ui_story then
				local var_208_9 = 0.5

				arg_205_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10039ui_story.fillRatio = var_208_9
			end

			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_208_11 = 0

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva", "EmotionTimelineAnimator")
			end

			local var_208_12 = 0
			local var_208_13 = 0.075

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_14 = arg_205_1:FormatText(StoryNameCfg[318].name)

				arg_205_1.leftNameTxt_.text = var_208_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_15 = arg_205_1:GetWordFromCfg(935011050)
				local var_208_16 = arg_205_1:FormatText(var_208_15.content)

				arg_205_1.text_.text = var_208_16

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 3
				local var_208_18 = utf8.len(var_208_16)
				local var_208_19 = var_208_17 <= 0 and var_208_13 or var_208_13 * (var_208_18 / var_208_17)

				if var_208_19 > 0 and var_208_13 < var_208_19 then
					arg_205_1.talkMaxDuration = var_208_19

					if var_208_19 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_19 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_16
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_20 and arg_205_1.time_ < var_208_12 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play935011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 935011051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play935011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1070ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1070ui_story == nil then
				arg_209_1.var_.characterEffect1070ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1070ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1070ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1070ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1070ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 1.125

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(935011051)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 45
				local var_212_11 = utf8.len(var_212_9)
				local var_212_12 = var_212_10 <= 0 and var_212_7 or var_212_7 * (var_212_11 / var_212_10)

				if var_212_12 > 0 and var_212_7 < var_212_12 then
					arg_209_1.talkMaxDuration = var_212_12

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_13 and arg_209_1.time_ < var_212_6 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play935011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 935011052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play935011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1070ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1070ui_story == nil then
				arg_213_1.var_.characterEffect1070ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1070ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1070ui_story then
				arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_216_4 = 0
			local var_216_5 = 0.55

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_6 = arg_213_1:FormatText(StoryNameCfg[318].name)

				arg_213_1.leftNameTxt_.text = var_216_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(935011052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 22
				local var_216_10 = utf8.len(var_216_8)
				local var_216_11 = var_216_9 <= 0 and var_216_5 or var_216_5 * (var_216_10 / var_216_9)

				if var_216_11 > 0 and var_216_5 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play935011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 935011053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play935011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.775

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[318].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(935011053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 31
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play935011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 935011054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play935011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1070ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1070ui_story == nil then
				arg_221_1.var_.characterEffect1070ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1070ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1070ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1070ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1070ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action436")
			end

			local var_224_7 = 0
			local var_224_8 = 0.9

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_9 = arg_221_1:GetWordFromCfg(935011054)
				local var_224_10 = arg_221_1:FormatText(var_224_9.content)

				arg_221_1.text_.text = var_224_10

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 36
				local var_224_12 = utf8.len(var_224_10)
				local var_224_13 = var_224_11 <= 0 and var_224_8 or var_224_8 * (var_224_12 / var_224_11)

				if var_224_13 > 0 and var_224_8 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_7 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_7
					end
				end

				arg_221_1.text_.text = var_224_10
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_8, arg_221_1.talkMaxDuration)

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_7) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_7 + var_224_14 and arg_221_1.time_ < var_224_7 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play935011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 935011055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play935011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1070ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1070ui_story == nil then
				arg_225_1.var_.characterEffect1070ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1070ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1070ui_story then
				arg_225_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_228_4 = 0

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_228_6 = 0
			local var_228_7 = 0.225

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[318].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_9 = arg_225_1:GetWordFromCfg(935011055)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 9
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play935011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 935011056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play935011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10039ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10039ui_story == nil then
				arg_229_1.var_.characterEffect10039ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10039ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10039ui_story then
				arg_229_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["1070ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1070ui_story == nil then
				arg_229_1.var_.characterEffect1070ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect1070ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1070ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1070ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1070ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0
			local var_232_11 = 0.6

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_12 = arg_229_1:FormatText(StoryNameCfg[472].name)

				arg_229_1.leftNameTxt_.text = var_232_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_13 = arg_229_1:GetWordFromCfg(935011056)
				local var_232_14 = arg_229_1:FormatText(var_232_13.content)

				arg_229_1.text_.text = var_232_14

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_15 = 24
				local var_232_16 = utf8.len(var_232_14)
				local var_232_17 = var_232_15 <= 0 and var_232_11 or var_232_11 * (var_232_16 / var_232_15)

				if var_232_17 > 0 and var_232_11 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_10
					end
				end

				arg_229_1.text_.text = var_232_14
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_18 = math.max(var_232_11, arg_229_1.talkMaxDuration)

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_18 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_10) / var_232_18

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_10 + var_232_18 and arg_229_1.time_ < var_232_10 + var_232_18 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play935011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 935011057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play935011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1070ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1070ui_story == nil then
				arg_233_1.var_.characterEffect1070ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1070ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1070ui_story then
				arg_233_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["10039ui_story"]
			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect10039ui_story == nil then
				arg_233_1.var_.characterEffect10039ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 and not isNil(var_236_4) then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6

				if arg_233_1.var_.characterEffect10039ui_story and not isNil(var_236_4) then
					local var_236_8 = Mathf.Lerp(0, 0.5, var_236_7)

					arg_233_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10039ui_story.fillRatio = var_236_8
				end
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect10039ui_story then
				local var_236_9 = 0.5

				arg_233_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10039ui_story.fillRatio = var_236_9
			end

			local var_236_10 = 0
			local var_236_11 = 0.3

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_12 = arg_233_1:FormatText(StoryNameCfg[318].name)

				arg_233_1.leftNameTxt_.text = var_236_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_13 = arg_233_1:GetWordFromCfg(935011057)
				local var_236_14 = arg_233_1:FormatText(var_236_13.content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_15 = 12
				local var_236_16 = utf8.len(var_236_14)
				local var_236_17 = var_236_15 <= 0 and var_236_11 or var_236_11 * (var_236_16 / var_236_15)

				if var_236_17 > 0 and var_236_11 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17

					if var_236_17 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_10
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_11, arg_233_1.talkMaxDuration)

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_10) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_10 + var_236_18 and arg_233_1.time_ < var_236_10 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play935011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 935011058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play935011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10039ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10039ui_story == nil then
				arg_237_1.var_.characterEffect10039ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect10039ui_story and not isNil(var_240_0) then
					arg_237_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10039ui_story then
				arg_237_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_240_4 = arg_237_1.actors_["1070ui_story"]
			local var_240_5 = 0

			if var_240_5 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1070ui_story == nil then
				arg_237_1.var_.characterEffect1070ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.200000002980232

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_6 and not isNil(var_240_4) then
				local var_240_7 = (arg_237_1.time_ - var_240_5) / var_240_6

				if arg_237_1.var_.characterEffect1070ui_story and not isNil(var_240_4) then
					local var_240_8 = Mathf.Lerp(0, 0.5, var_240_7)

					arg_237_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1070ui_story.fillRatio = var_240_8
				end
			end

			if arg_237_1.time_ >= var_240_5 + var_240_6 and arg_237_1.time_ < var_240_5 + var_240_6 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1070ui_story then
				local var_240_9 = 0.5

				arg_237_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1070ui_story.fillRatio = var_240_9
			end

			local var_240_10 = 0
			local var_240_11 = 0.625

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_12 = arg_237_1:FormatText(StoryNameCfg[472].name)

				arg_237_1.leftNameTxt_.text = var_240_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(935011058)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_15 = 25
				local var_240_16 = utf8.len(var_240_14)
				local var_240_17 = var_240_15 <= 0 and var_240_11 or var_240_11 * (var_240_16 / var_240_15)

				if var_240_17 > 0 and var_240_11 < var_240_17 then
					arg_237_1.talkMaxDuration = var_240_17

					if var_240_17 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_10
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_18 = math.max(var_240_11, arg_237_1.talkMaxDuration)

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_18 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_10) / var_240_18

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_10 + var_240_18 and arg_237_1.time_ < var_240_10 + var_240_18 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play935011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 935011059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play935011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1070ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1070ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1070ui_story then
				arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["10039ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10039ui_story == nil then
				arg_241_1.var_.characterEffect10039ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect10039ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10039ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10039ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10039ui_story.fillRatio = var_244_9
			end

			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_244_11 = 0

			if var_244_11 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva", "EmotionTimelineAnimator")
			end

			local var_244_12 = 0
			local var_244_13 = 0.45

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_14 = arg_241_1:FormatText(StoryNameCfg[318].name)

				arg_241_1.leftNameTxt_.text = var_244_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_15 = arg_241_1:GetWordFromCfg(935011059)
				local var_244_16 = arg_241_1:FormatText(var_244_15.content)

				arg_241_1.text_.text = var_244_16

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_17 = 18
				local var_244_18 = utf8.len(var_244_16)
				local var_244_19 = var_244_17 <= 0 and var_244_13 or var_244_13 * (var_244_18 / var_244_17)

				if var_244_19 > 0 and var_244_13 < var_244_19 then
					arg_241_1.talkMaxDuration = var_244_19

					if var_244_19 + var_244_12 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_12
					end
				end

				arg_241_1.text_.text = var_244_16
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_20 = math.max(var_244_13, arg_241_1.talkMaxDuration)

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_20 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_12) / var_244_20

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_12 + var_244_20 and arg_241_1.time_ < var_244_12 + var_244_20 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play935011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 935011060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play935011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1070ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story == nil then
				arg_245_1.var_.characterEffect1070ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1070ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1070ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1070ui_story.fillRatio = var_248_5
			end

			local var_248_6 = 0
			local var_248_7 = 1

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(935011060)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 40
				local var_248_11 = utf8.len(var_248_9)
				local var_248_12 = var_248_10 <= 0 and var_248_7 or var_248_7 * (var_248_11 / var_248_10)

				if var_248_12 > 0 and var_248_7 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_13 and arg_245_1.time_ < var_248_6 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play935011061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 935011061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play935011062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1070ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1070ui_story == nil then
				arg_249_1.var_.characterEffect1070ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1070ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1070ui_story then
				arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_252_4 = 0

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action474")
			end

			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_252_6 = 0
			local var_252_7 = 1.2

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[318].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_9 = arg_249_1:GetWordFromCfg(935011061)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 48
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play935011062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 935011062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play935011063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_1 = 0
			local var_256_2 = 1.15

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_3 = arg_253_1:FormatText(StoryNameCfg[318].name)

				arg_253_1.leftNameTxt_.text = var_256_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(935011062)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 46
				local var_256_7 = utf8.len(var_256_5)
				local var_256_8 = var_256_6 <= 0 and var_256_2 or var_256_2 * (var_256_7 / var_256_6)

				if var_256_8 > 0 and var_256_2 < var_256_8 then
					arg_253_1.talkMaxDuration = var_256_8

					if var_256_8 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_9 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_9 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_9

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_9 and arg_253_1.time_ < var_256_1 + var_256_9 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play935011063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 935011063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play935011064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10039ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10039ui_story == nil then
				arg_257_1.var_.characterEffect10039ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect10039ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10039ui_story then
				arg_257_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["1070ui_story"]
			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1070ui_story == nil then
				arg_257_1.var_.characterEffect1070ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_6 and not isNil(var_260_4) then
				local var_260_7 = (arg_257_1.time_ - var_260_5) / var_260_6

				if arg_257_1.var_.characterEffect1070ui_story and not isNil(var_260_4) then
					local var_260_8 = Mathf.Lerp(0, 0.5, var_260_7)

					arg_257_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1070ui_story.fillRatio = var_260_8
				end
			end

			if arg_257_1.time_ >= var_260_5 + var_260_6 and arg_257_1.time_ < var_260_5 + var_260_6 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1070ui_story then
				local var_260_9 = 0.5

				arg_257_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1070ui_story.fillRatio = var_260_9
			end

			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva", "EmotionTimelineAnimator")
			end

			local var_260_11 = 0
			local var_260_12 = 0.75

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_13 = arg_257_1:FormatText(StoryNameCfg[472].name)

				arg_257_1.leftNameTxt_.text = var_260_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_14 = arg_257_1:GetWordFromCfg(935011063)
				local var_260_15 = arg_257_1:FormatText(var_260_14.content)

				arg_257_1.text_.text = var_260_15

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_16 = 30
				local var_260_17 = utf8.len(var_260_15)
				local var_260_18 = var_260_16 <= 0 and var_260_12 or var_260_12 * (var_260_17 / var_260_16)

				if var_260_18 > 0 and var_260_12 < var_260_18 then
					arg_257_1.talkMaxDuration = var_260_18

					if var_260_18 + var_260_11 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_18 + var_260_11
					end
				end

				arg_257_1.text_.text = var_260_15
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_19 = math.max(var_260_12, arg_257_1.talkMaxDuration)

			if var_260_11 <= arg_257_1.time_ and arg_257_1.time_ < var_260_11 + var_260_19 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_11) / var_260_19

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_11 + var_260_19 and arg_257_1.time_ < var_260_11 + var_260_19 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play935011064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 935011064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play935011065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10039ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10039ui_story == nil then
				arg_261_1.var_.characterEffect10039ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect10039ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10039ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10039ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10039ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.55

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(935011064)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 22
				local var_264_11 = utf8.len(var_264_9)
				local var_264_12 = var_264_10 <= 0 and var_264_7 or var_264_7 * (var_264_11 / var_264_10)

				if var_264_12 > 0 and var_264_7 < var_264_12 then
					arg_261_1.talkMaxDuration = var_264_12

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_13 and arg_261_1.time_ < var_264_6 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play935011065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 935011065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play935011066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1070ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1070ui_story == nil then
				arg_265_1.var_.characterEffect1070ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1070ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1070ui_story then
				arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_268_6 = 0
			local var_268_7 = 1

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[318].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_9 = arg_265_1:GetWordFromCfg(935011065)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 40
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play935011066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 935011066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play935011067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_272_1 = 0
			local var_272_2 = 1.175

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_3 = arg_269_1:FormatText(StoryNameCfg[318].name)

				arg_269_1.leftNameTxt_.text = var_272_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(935011066)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_6 = 47
				local var_272_7 = utf8.len(var_272_5)
				local var_272_8 = var_272_6 <= 0 and var_272_2 or var_272_2 * (var_272_7 / var_272_6)

				if var_272_8 > 0 and var_272_2 < var_272_8 then
					arg_269_1.talkMaxDuration = var_272_8

					if var_272_8 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_9 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_9 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_9

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_9 and arg_269_1.time_ < var_272_1 + var_272_9 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play935011067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 935011067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play935011068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10039ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10039ui_story == nil then
				arg_273_1.var_.characterEffect10039ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect10039ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10039ui_story then
				arg_273_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["1070ui_story"]
			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1070ui_story == nil then
				arg_273_1.var_.characterEffect1070ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_6 = 0.200000002980232

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_6 and not isNil(var_276_4) then
				local var_276_7 = (arg_273_1.time_ - var_276_5) / var_276_6

				if arg_273_1.var_.characterEffect1070ui_story and not isNil(var_276_4) then
					local var_276_8 = Mathf.Lerp(0, 0.5, var_276_7)

					arg_273_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1070ui_story.fillRatio = var_276_8
				end
			end

			if arg_273_1.time_ >= var_276_5 + var_276_6 and arg_273_1.time_ < var_276_5 + var_276_6 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1070ui_story then
				local var_276_9 = 0.5

				arg_273_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1070ui_story.fillRatio = var_276_9
			end

			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action465")
			end

			local var_276_11 = 0

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva", "EmotionTimelineAnimator")
			end

			local var_276_12 = 0
			local var_276_13 = 0.125

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_14 = arg_273_1:FormatText(StoryNameCfg[472].name)

				arg_273_1.leftNameTxt_.text = var_276_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_15 = arg_273_1:GetWordFromCfg(935011067)
				local var_276_16 = arg_273_1:FormatText(var_276_15.content)

				arg_273_1.text_.text = var_276_16

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_17 = 5
				local var_276_18 = utf8.len(var_276_16)
				local var_276_19 = var_276_17 <= 0 and var_276_13 or var_276_13 * (var_276_18 / var_276_17)

				if var_276_19 > 0 and var_276_13 < var_276_19 then
					arg_273_1.talkMaxDuration = var_276_19

					if var_276_19 + var_276_12 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_12
					end
				end

				arg_273_1.text_.text = var_276_16
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_20 = math.max(var_276_13, arg_273_1.talkMaxDuration)

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_20 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_12) / var_276_20

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_12 + var_276_20 and arg_273_1.time_ < var_276_12 + var_276_20 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play935011068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 935011068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play935011069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1070ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1070ui_story == nil then
				arg_277_1.var_.characterEffect1070ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1070ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1070ui_story then
				arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["10039ui_story"]
			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10039ui_story == nil then
				arg_277_1.var_.characterEffect10039ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_6 = 0.200000002980232

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_6 and not isNil(var_280_4) then
				local var_280_7 = (arg_277_1.time_ - var_280_5) / var_280_6

				if arg_277_1.var_.characterEffect10039ui_story and not isNil(var_280_4) then
					local var_280_8 = Mathf.Lerp(0, 0.5, var_280_7)

					arg_277_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10039ui_story.fillRatio = var_280_8
				end
			end

			if arg_277_1.time_ >= var_280_5 + var_280_6 and arg_277_1.time_ < var_280_5 + var_280_6 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10039ui_story then
				local var_280_9 = 0.5

				arg_277_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10039ui_story.fillRatio = var_280_9
			end

			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_280_11 = 0
			local var_280_12 = 0.075

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_13 = arg_277_1:FormatText(StoryNameCfg[318].name)

				arg_277_1.leftNameTxt_.text = var_280_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_14 = arg_277_1:GetWordFromCfg(935011068)
				local var_280_15 = arg_277_1:FormatText(var_280_14.content)

				arg_277_1.text_.text = var_280_15

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_16 = 3
				local var_280_17 = utf8.len(var_280_15)
				local var_280_18 = var_280_16 <= 0 and var_280_12 or var_280_12 * (var_280_17 / var_280_16)

				if var_280_18 > 0 and var_280_12 < var_280_18 then
					arg_277_1.talkMaxDuration = var_280_18

					if var_280_18 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_18 + var_280_11
					end
				end

				arg_277_1.text_.text = var_280_15
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_19 = math.max(var_280_12, arg_277_1.talkMaxDuration)

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_19 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_11) / var_280_19

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_11 + var_280_19 and arg_277_1.time_ < var_280_11 + var_280_19 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play935011069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 935011069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play935011070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10039ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect10039ui_story == nil then
				arg_281_1.var_.characterEffect10039ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect10039ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect10039ui_story then
				arg_281_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_284_4 = arg_281_1.actors_["1070ui_story"]
			local var_284_5 = 0

			if var_284_5 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1070ui_story == nil then
				arg_281_1.var_.characterEffect1070ui_story = var_284_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_6 and not isNil(var_284_4) then
				local var_284_7 = (arg_281_1.time_ - var_284_5) / var_284_6

				if arg_281_1.var_.characterEffect1070ui_story and not isNil(var_284_4) then
					local var_284_8 = Mathf.Lerp(0, 0.5, var_284_7)

					arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1070ui_story.fillRatio = var_284_8
				end
			end

			if arg_281_1.time_ >= var_284_5 + var_284_6 and arg_281_1.time_ < var_284_5 + var_284_6 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1070ui_story then
				local var_284_9 = 0.5

				arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1070ui_story.fillRatio = var_284_9
			end

			local var_284_10 = 0
			local var_284_11 = 0.225

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_12 = arg_281_1:FormatText(StoryNameCfg[472].name)

				arg_281_1.leftNameTxt_.text = var_284_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_13 = arg_281_1:GetWordFromCfg(935011069)
				local var_284_14 = arg_281_1:FormatText(var_284_13.content)

				arg_281_1.text_.text = var_284_14

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 9
				local var_284_16 = utf8.len(var_284_14)
				local var_284_17 = var_284_15 <= 0 and var_284_11 or var_284_11 * (var_284_16 / var_284_15)

				if var_284_17 > 0 and var_284_11 < var_284_17 then
					arg_281_1.talkMaxDuration = var_284_17

					if var_284_17 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_17 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_14
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_10) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_10 + var_284_18 and arg_281_1.time_ < var_284_10 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play935011070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 935011070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play935011071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1070ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1070ui_story == nil then
				arg_285_1.var_.characterEffect1070ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1070ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1070ui_story then
				arg_285_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["10039ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10039ui_story == nil then
				arg_285_1.var_.characterEffect10039ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect10039ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10039ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10039ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10039ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_288_11 = 0
			local var_288_12 = 0.075

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_13 = arg_285_1:FormatText(StoryNameCfg[318].name)

				arg_285_1.leftNameTxt_.text = var_288_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_14 = arg_285_1:GetWordFromCfg(935011070)
				local var_288_15 = arg_285_1:FormatText(var_288_14.content)

				arg_285_1.text_.text = var_288_15

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 3
				local var_288_17 = utf8.len(var_288_15)
				local var_288_18 = var_288_16 <= 0 and var_288_12 or var_288_12 * (var_288_17 / var_288_16)

				if var_288_18 > 0 and var_288_12 < var_288_18 then
					arg_285_1.talkMaxDuration = var_288_18

					if var_288_18 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_15
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_19 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_19 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_19

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_19 and arg_285_1.time_ < var_288_11 + var_288_19 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play935011071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 935011071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play935011072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10039ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect10039ui_story == nil then
				arg_289_1.var_.characterEffect10039ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect10039ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect10039ui_story then
				arg_289_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["1070ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1070ui_story == nil then
				arg_289_1.var_.characterEffect1070ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect1070ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1070ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1070ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1070ui_story.fillRatio = var_292_9
			end

			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action452")
			end

			local var_292_11 = 0

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_292_12 = 0
			local var_292_13 = 0.925

			if var_292_12 < arg_289_1.time_ and arg_289_1.time_ <= var_292_12 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_14 = arg_289_1:FormatText(StoryNameCfg[472].name)

				arg_289_1.leftNameTxt_.text = var_292_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_15 = arg_289_1:GetWordFromCfg(935011071)
				local var_292_16 = arg_289_1:FormatText(var_292_15.content)

				arg_289_1.text_.text = var_292_16

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_17 = 37
				local var_292_18 = utf8.len(var_292_16)
				local var_292_19 = var_292_17 <= 0 and var_292_13 or var_292_13 * (var_292_18 / var_292_17)

				if var_292_19 > 0 and var_292_13 < var_292_19 then
					arg_289_1.talkMaxDuration = var_292_19

					if var_292_19 + var_292_12 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_12
					end
				end

				arg_289_1.text_.text = var_292_16
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_20 = math.max(var_292_13, arg_289_1.talkMaxDuration)

			if var_292_12 <= arg_289_1.time_ and arg_289_1.time_ < var_292_12 + var_292_20 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_12) / var_292_20

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_12 + var_292_20 and arg_289_1.time_ < var_292_12 + var_292_20 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play935011072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 935011072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play935011073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1070ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1070ui_story == nil then
				arg_293_1.var_.characterEffect1070ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1070ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1070ui_story then
				arg_293_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["10039ui_story"]
			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10039ui_story == nil then
				arg_293_1.var_.characterEffect10039ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 and not isNil(var_296_4) then
				local var_296_7 = (arg_293_1.time_ - var_296_5) / var_296_6

				if arg_293_1.var_.characterEffect10039ui_story and not isNil(var_296_4) then
					local var_296_8 = Mathf.Lerp(0, 0.5, var_296_7)

					arg_293_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10039ui_story.fillRatio = var_296_8
				end
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect10039ui_story then
				local var_296_9 = 0.5

				arg_293_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10039ui_story.fillRatio = var_296_9
			end

			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_296_11 = 0
			local var_296_12 = 0.125

			if var_296_11 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_13 = arg_293_1:FormatText(StoryNameCfg[318].name)

				arg_293_1.leftNameTxt_.text = var_296_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_14 = arg_293_1:GetWordFromCfg(935011072)
				local var_296_15 = arg_293_1:FormatText(var_296_14.content)

				arg_293_1.text_.text = var_296_15

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_16 = 5
				local var_296_17 = utf8.len(var_296_15)
				local var_296_18 = var_296_16 <= 0 and var_296_12 or var_296_12 * (var_296_17 / var_296_16)

				if var_296_18 > 0 and var_296_12 < var_296_18 then
					arg_293_1.talkMaxDuration = var_296_18

					if var_296_18 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_15
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_19 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 <= arg_293_1.time_ and arg_293_1.time_ < var_296_11 + var_296_19 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_11) / var_296_19

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_11 + var_296_19 and arg_293_1.time_ < var_296_11 + var_296_19 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play935011073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 935011073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play935011074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10039ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect10039ui_story == nil then
				arg_297_1.var_.characterEffect10039ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect10039ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect10039ui_story then
				arg_297_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["1070ui_story"]
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1070ui_story == nil then
				arg_297_1.var_.characterEffect1070ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 and not isNil(var_300_4) then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6

				if arg_297_1.var_.characterEffect1070ui_story and not isNil(var_300_4) then
					local var_300_8 = Mathf.Lerp(0, 0.5, var_300_7)

					arg_297_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1070ui_story.fillRatio = var_300_8
				end
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1070ui_story then
				local var_300_9 = 0.5

				arg_297_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1070ui_story.fillRatio = var_300_9
			end

			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_300_11 = 0
			local var_300_12 = 0.525

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_13 = arg_297_1:FormatText(StoryNameCfg[472].name)

				arg_297_1.leftNameTxt_.text = var_300_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_14 = arg_297_1:GetWordFromCfg(935011073)
				local var_300_15 = arg_297_1:FormatText(var_300_14.content)

				arg_297_1.text_.text = var_300_15

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_16 = 21
				local var_300_17 = utf8.len(var_300_15)
				local var_300_18 = var_300_16 <= 0 and var_300_12 or var_300_12 * (var_300_17 / var_300_16)

				if var_300_18 > 0 and var_300_12 < var_300_18 then
					arg_297_1.talkMaxDuration = var_300_18

					if var_300_18 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_11
					end
				end

				arg_297_1.text_.text = var_300_15
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_19 = math.max(var_300_12, arg_297_1.talkMaxDuration)

			if var_300_11 <= arg_297_1.time_ and arg_297_1.time_ < var_300_11 + var_300_19 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_11) / var_300_19

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_11 + var_300_19 and arg_297_1.time_ < var_300_11 + var_300_19 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play935011074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 935011074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play935011075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1070ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1070ui_story == nil then
				arg_301_1.var_.characterEffect1070ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1070ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1070ui_story then
				arg_301_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_304_4 = arg_301_1.actors_["10039ui_story"]
			local var_304_5 = 0

			if var_304_5 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10039ui_story == nil then
				arg_301_1.var_.characterEffect10039ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_6 = 0.200000002980232

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 and not isNil(var_304_4) then
				local var_304_7 = (arg_301_1.time_ - var_304_5) / var_304_6

				if arg_301_1.var_.characterEffect10039ui_story and not isNil(var_304_4) then
					local var_304_8 = Mathf.Lerp(0, 0.5, var_304_7)

					arg_301_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10039ui_story.fillRatio = var_304_8
				end
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10039ui_story then
				local var_304_9 = 0.5

				arg_301_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10039ui_story.fillRatio = var_304_9
			end

			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 then
				arg_301_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_304_11 = 0

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva", "EmotionTimelineAnimator")
			end

			local var_304_12 = 0
			local var_304_13 = 0.975

			if var_304_12 < arg_301_1.time_ and arg_301_1.time_ <= var_304_12 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_14 = arg_301_1:FormatText(StoryNameCfg[318].name)

				arg_301_1.leftNameTxt_.text = var_304_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_15 = arg_301_1:GetWordFromCfg(935011074)
				local var_304_16 = arg_301_1:FormatText(var_304_15.content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_17 = 39
				local var_304_18 = utf8.len(var_304_16)
				local var_304_19 = var_304_17 <= 0 and var_304_13 or var_304_13 * (var_304_18 / var_304_17)

				if var_304_19 > 0 and var_304_13 < var_304_19 then
					arg_301_1.talkMaxDuration = var_304_19

					if var_304_19 + var_304_12 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_12
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_20 = math.max(var_304_13, arg_301_1.talkMaxDuration)

			if var_304_12 <= arg_301_1.time_ and arg_301_1.time_ < var_304_12 + var_304_20 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_12) / var_304_20

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_12 + var_304_20 and arg_301_1.time_ < var_304_12 + var_304_20 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play935011075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 935011075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play935011076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action447")
			end

			local var_308_1 = 0
			local var_308_2 = 0.85

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_3 = arg_305_1:FormatText(StoryNameCfg[318].name)

				arg_305_1.leftNameTxt_.text = var_308_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_4 = arg_305_1:GetWordFromCfg(935011075)
				local var_308_5 = arg_305_1:FormatText(var_308_4.content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_6 = 34
				local var_308_7 = utf8.len(var_308_5)
				local var_308_8 = var_308_6 <= 0 and var_308_2 or var_308_2 * (var_308_7 / var_308_6)

				if var_308_8 > 0 and var_308_2 < var_308_8 then
					arg_305_1.talkMaxDuration = var_308_8

					if var_308_8 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_9 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_9 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_9

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_9 and arg_305_1.time_ < var_308_1 + var_308_9 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play935011076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 935011076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play935011077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_312_1 = 0
			local var_312_2 = 0.725

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_3 = arg_309_1:FormatText(StoryNameCfg[318].name)

				arg_309_1.leftNameTxt_.text = var_312_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(935011076)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 29
				local var_312_7 = utf8.len(var_312_5)
				local var_312_8 = var_312_6 <= 0 and var_312_2 or var_312_2 * (var_312_7 / var_312_6)

				if var_312_8 > 0 and var_312_2 < var_312_8 then
					arg_309_1.talkMaxDuration = var_312_8

					if var_312_8 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_9 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_9 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_9

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_9 and arg_309_1.time_ < var_312_1 + var_312_9 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play935011077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 935011077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play935011078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1070ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1070ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1070ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 1.275

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(935011077)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 51
				local var_316_11 = utf8.len(var_316_9)
				local var_316_12 = var_316_10 <= 0 and var_316_7 or var_316_7 * (var_316_11 / var_316_10)

				if var_316_12 > 0 and var_316_7 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_13 and arg_313_1.time_ < var_316_6 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play935011078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 935011078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play935011079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1070ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1070ui_story == nil then
				arg_317_1.var_.characterEffect1070ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1070ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1070ui_story then
				arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_320_4 = 0

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_320_6 = 0
			local var_320_7 = 0.15

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[318].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:GetWordFromCfg(935011078)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 6
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play935011079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 935011079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play935011080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10039ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10039ui_story == nil then
				arg_321_1.var_.characterEffect10039ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect10039ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10039ui_story then
				arg_321_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_324_4 = arg_321_1.actors_["1070ui_story"]
			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1070ui_story == nil then
				arg_321_1.var_.characterEffect1070ui_story = var_324_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_6 = 0.200000002980232

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 and not isNil(var_324_4) then
				local var_324_7 = (arg_321_1.time_ - var_324_5) / var_324_6

				if arg_321_1.var_.characterEffect1070ui_story and not isNil(var_324_4) then
					local var_324_8 = Mathf.Lerp(0, 0.5, var_324_7)

					arg_321_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1070ui_story.fillRatio = var_324_8
				end
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1070ui_story then
				local var_324_9 = 0.5

				arg_321_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1070ui_story.fillRatio = var_324_9
			end

			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			local var_324_11 = 0
			local var_324_12 = 0.375

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_13 = arg_321_1:FormatText(StoryNameCfg[472].name)

				arg_321_1.leftNameTxt_.text = var_324_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_14 = arg_321_1:GetWordFromCfg(935011079)
				local var_324_15 = arg_321_1:FormatText(var_324_14.content)

				arg_321_1.text_.text = var_324_15

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_16 = 15
				local var_324_17 = utf8.len(var_324_15)
				local var_324_18 = var_324_16 <= 0 and var_324_12 or var_324_12 * (var_324_17 / var_324_16)

				if var_324_18 > 0 and var_324_12 < var_324_18 then
					arg_321_1.talkMaxDuration = var_324_18

					if var_324_18 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_18 + var_324_11
					end
				end

				arg_321_1.text_.text = var_324_15
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_19 = math.max(var_324_12, arg_321_1.talkMaxDuration)

			if var_324_11 <= arg_321_1.time_ and arg_321_1.time_ < var_324_11 + var_324_19 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_11) / var_324_19

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_11 + var_324_19 and arg_321_1.time_ < var_324_11 + var_324_19 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play935011080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 935011080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play935011081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_1 = 0
			local var_328_2 = 1.3

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_3 = arg_325_1:FormatText(StoryNameCfg[472].name)

				arg_325_1.leftNameTxt_.text = var_328_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(935011080)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 52
				local var_328_7 = utf8.len(var_328_5)
				local var_328_8 = var_328_6 <= 0 and var_328_2 or var_328_2 * (var_328_7 / var_328_6)

				if var_328_8 > 0 and var_328_2 < var_328_8 then
					arg_325_1.talkMaxDuration = var_328_8

					if var_328_8 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_9 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_9 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_9

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_9 and arg_325_1.time_ < var_328_1 + var_328_9 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play935011081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 935011081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play935011082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1070ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1070ui_story == nil then
				arg_329_1.var_.characterEffect1070ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1070ui_story and not isNil(var_332_0) then
					arg_329_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1070ui_story then
				arg_329_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_332_4 = arg_329_1.actors_["10039ui_story"]
			local var_332_5 = 0

			if var_332_5 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect10039ui_story == nil then
				arg_329_1.var_.characterEffect10039ui_story = var_332_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_6 and not isNil(var_332_4) then
				local var_332_7 = (arg_329_1.time_ - var_332_5) / var_332_6

				if arg_329_1.var_.characterEffect10039ui_story and not isNil(var_332_4) then
					local var_332_8 = Mathf.Lerp(0, 0.5, var_332_7)

					arg_329_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10039ui_story.fillRatio = var_332_8
				end
			end

			if arg_329_1.time_ >= var_332_5 + var_332_6 and arg_329_1.time_ < var_332_5 + var_332_6 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect10039ui_story then
				local var_332_9 = 0.5

				arg_329_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10039ui_story.fillRatio = var_332_9
			end

			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_332_11 = 0

			if var_332_11 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				arg_329_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_332_12 = 0
			local var_332_13 = 0.225

			if var_332_12 < arg_329_1.time_ and arg_329_1.time_ <= var_332_12 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_14 = arg_329_1:FormatText(StoryNameCfg[318].name)

				arg_329_1.leftNameTxt_.text = var_332_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_15 = arg_329_1:GetWordFromCfg(935011081)
				local var_332_16 = arg_329_1:FormatText(var_332_15.content)

				arg_329_1.text_.text = var_332_16

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_17 = 9
				local var_332_18 = utf8.len(var_332_16)
				local var_332_19 = var_332_17 <= 0 and var_332_13 or var_332_13 * (var_332_18 / var_332_17)

				if var_332_19 > 0 and var_332_13 < var_332_19 then
					arg_329_1.talkMaxDuration = var_332_19

					if var_332_19 + var_332_12 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_19 + var_332_12
					end
				end

				arg_329_1.text_.text = var_332_16
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_20 = math.max(var_332_13, arg_329_1.talkMaxDuration)

			if var_332_12 <= arg_329_1.time_ and arg_329_1.time_ < var_332_12 + var_332_20 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_12) / var_332_20

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_12 + var_332_20 and arg_329_1.time_ < var_332_12 + var_332_20 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play935011082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 935011082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play935011083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1070ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1070ui_story == nil then
				arg_333_1.var_.characterEffect1070ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1070ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1070ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1070ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1070ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 0.875

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_8 = arg_333_1:GetWordFromCfg(935011082)
				local var_336_9 = arg_333_1:FormatText(var_336_8.content)

				arg_333_1.text_.text = var_336_9

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 35
				local var_336_11 = utf8.len(var_336_9)
				local var_336_12 = var_336_10 <= 0 and var_336_7 or var_336_7 * (var_336_11 / var_336_10)

				if var_336_12 > 0 and var_336_7 < var_336_12 then
					arg_333_1.talkMaxDuration = var_336_12

					if var_336_12 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_12 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_9
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_13 and arg_333_1.time_ < var_336_6 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play935011083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 935011083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play935011084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1070ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1070ui_story == nil then
				arg_337_1.var_.characterEffect1070ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1070ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1070ui_story then
				arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_340_4 = 0

			if var_340_4 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_340_5 = 0

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_340_6 = 0
			local var_340_7 = 0.825

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[318].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_9 = arg_337_1:GetWordFromCfg(935011083)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 33
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play935011084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 935011084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play935011085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1070ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1070ui_story == nil then
				arg_341_1.var_.characterEffect1070ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1070ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1070ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1070ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1070ui_story.fillRatio = var_344_5
			end

			local var_344_6 = 0
			local var_344_7 = 1.35

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_8 = arg_341_1:GetWordFromCfg(935011084)
				local var_344_9 = arg_341_1:FormatText(var_344_8.content)

				arg_341_1.text_.text = var_344_9

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 54
				local var_344_11 = utf8.len(var_344_9)
				local var_344_12 = var_344_10 <= 0 and var_344_7 or var_344_7 * (var_344_11 / var_344_10)

				if var_344_12 > 0 and var_344_7 < var_344_12 then
					arg_341_1.talkMaxDuration = var_344_12

					if var_344_12 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_12 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_9
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_13 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_13 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_13

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_13 and arg_341_1.time_ < var_344_6 + var_344_13 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play935011085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 935011085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play935011086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10039ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect10039ui_story == nil then
				arg_345_1.var_.characterEffect10039ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect10039ui_story and not isNil(var_348_0) then
					arg_345_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect10039ui_story then
				arg_345_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_348_4 = 0

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action426")
			end

			local var_348_5 = 0

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva", "EmotionTimelineAnimator")
			end

			local var_348_6 = 0
			local var_348_7 = 0.5

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[472].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_9 = arg_345_1:GetWordFromCfg(935011085)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 20
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play935011086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 935011086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play935011087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_352_1 = 0
			local var_352_2 = 0.725

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_3 = arg_349_1:FormatText(StoryNameCfg[472].name)

				arg_349_1.leftNameTxt_.text = var_352_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(935011086)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 29
				local var_352_7 = utf8.len(var_352_5)
				local var_352_8 = var_352_6 <= 0 and var_352_2 or var_352_2 * (var_352_7 / var_352_6)

				if var_352_8 > 0 and var_352_2 < var_352_8 then
					arg_349_1.talkMaxDuration = var_352_8

					if var_352_8 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_9 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_9 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_9

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_9 and arg_349_1.time_ < var_352_1 + var_352_9 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play935011087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 935011087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play935011088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_356_2 = 0
			local var_356_3 = 0.825

			if var_356_2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_4 = arg_353_1:FormatText(StoryNameCfg[472].name)

				arg_353_1.leftNameTxt_.text = var_356_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_5 = arg_353_1:GetWordFromCfg(935011087)
				local var_356_6 = arg_353_1:FormatText(var_356_5.content)

				arg_353_1.text_.text = var_356_6

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 33
				local var_356_8 = utf8.len(var_356_6)
				local var_356_9 = var_356_7 <= 0 and var_356_3 or var_356_3 * (var_356_8 / var_356_7)

				if var_356_9 > 0 and var_356_3 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_6
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play935011088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 935011088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play935011089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1070ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1070ui_story == nil then
				arg_357_1.var_.characterEffect1070ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1070ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1070ui_story then
				arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_360_4 = arg_357_1.actors_["10039ui_story"]
			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10039ui_story == nil then
				arg_357_1.var_.characterEffect10039ui_story = var_360_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_6 = 0.200000002980232

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_6 and not isNil(var_360_4) then
				local var_360_7 = (arg_357_1.time_ - var_360_5) / var_360_6

				if arg_357_1.var_.characterEffect10039ui_story and not isNil(var_360_4) then
					local var_360_8 = Mathf.Lerp(0, 0.5, var_360_7)

					arg_357_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10039ui_story.fillRatio = var_360_8
				end
			end

			if arg_357_1.time_ >= var_360_5 + var_360_6 and arg_357_1.time_ < var_360_5 + var_360_6 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect10039ui_story then
				local var_360_9 = 0.5

				arg_357_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10039ui_story.fillRatio = var_360_9
			end

			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva", "EmotionTimelineAnimator")
			end

			local var_360_11 = 0

			if var_360_11 < arg_357_1.time_ and arg_357_1.time_ <= var_360_11 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_360_12 = 0
			local var_360_13 = 0.075

			if var_360_12 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_14 = arg_357_1:FormatText(StoryNameCfg[318].name)

				arg_357_1.leftNameTxt_.text = var_360_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_15 = arg_357_1:GetWordFromCfg(935011088)
				local var_360_16 = arg_357_1:FormatText(var_360_15.content)

				arg_357_1.text_.text = var_360_16

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_17 = 3
				local var_360_18 = utf8.len(var_360_16)
				local var_360_19 = var_360_17 <= 0 and var_360_13 or var_360_13 * (var_360_18 / var_360_17)

				if var_360_19 > 0 and var_360_13 < var_360_19 then
					arg_357_1.talkMaxDuration = var_360_19

					if var_360_19 + var_360_12 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_19 + var_360_12
					end
				end

				arg_357_1.text_.text = var_360_16
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_20 = math.max(var_360_13, arg_357_1.talkMaxDuration)

			if var_360_12 <= arg_357_1.time_ and arg_357_1.time_ < var_360_12 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_12) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_12 + var_360_20 and arg_357_1.time_ < var_360_12 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play935011089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 935011089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play935011090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1070ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1070ui_story == nil then
				arg_361_1.var_.characterEffect1070ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect1070ui_story and not isNil(var_364_0) then
					local var_364_4 = Mathf.Lerp(0, 0.5, var_364_3)

					arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1070ui_story.fillRatio = var_364_4
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.characterEffect1070ui_story then
				local var_364_5 = 0.5

				arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1070ui_story.fillRatio = var_364_5
			end

			local var_364_6 = 0

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action435")
			end

			local var_364_7 = 0
			local var_364_8 = 0.8

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_9 = arg_361_1:GetWordFromCfg(935011089)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 32
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_8 or var_364_8 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_8 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_7
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_8, arg_361_1.talkMaxDuration)

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_7) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_7 + var_364_14 and arg_361_1.time_ < var_364_7 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play935011090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 935011090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play935011091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1070ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1070ui_story == nil then
				arg_365_1.var_.characterEffect1070ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1070ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1070ui_story then
				arg_365_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_368_5 = 0
			local var_368_6 = 0.825

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_7 = arg_365_1:FormatText(StoryNameCfg[318].name)

				arg_365_1.leftNameTxt_.text = var_368_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_8 = arg_365_1:GetWordFromCfg(935011090)
				local var_368_9 = arg_365_1:FormatText(var_368_8.content)

				arg_365_1.text_.text = var_368_9

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_10 = 33
				local var_368_11 = utf8.len(var_368_9)
				local var_368_12 = var_368_10 <= 0 and var_368_6 or var_368_6 * (var_368_11 / var_368_10)

				if var_368_12 > 0 and var_368_6 < var_368_12 then
					arg_365_1.talkMaxDuration = var_368_12

					if var_368_12 + var_368_5 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_12 + var_368_5
					end
				end

				arg_365_1.text_.text = var_368_9
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_13 = math.max(var_368_6, arg_365_1.talkMaxDuration)

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_13 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_5) / var_368_13

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_5 + var_368_13 and arg_365_1.time_ < var_368_5 + var_368_13 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play935011091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 935011091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play935011092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10039ui_story"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect10039ui_story == nil then
				arg_369_1.var_.characterEffect10039ui_story = var_372_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.characterEffect10039ui_story and not isNil(var_372_0) then
					arg_369_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.characterEffect10039ui_story then
				arg_369_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_372_4 = arg_369_1.actors_["1070ui_story"]
			local var_372_5 = 0

			if var_372_5 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.characterEffect1070ui_story == nil then
				arg_369_1.var_.characterEffect1070ui_story = var_372_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_6 = 0.200000002980232

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_6 and not isNil(var_372_4) then
				local var_372_7 = (arg_369_1.time_ - var_372_5) / var_372_6

				if arg_369_1.var_.characterEffect1070ui_story and not isNil(var_372_4) then
					local var_372_8 = Mathf.Lerp(0, 0.5, var_372_7)

					arg_369_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1070ui_story.fillRatio = var_372_8
				end
			end

			if arg_369_1.time_ >= var_372_5 + var_372_6 and arg_369_1.time_ < var_372_5 + var_372_6 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.characterEffect1070ui_story then
				local var_372_9 = 0.5

				arg_369_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1070ui_story.fillRatio = var_372_9
			end

			local var_372_10 = 0

			if var_372_10 < arg_369_1.time_ and arg_369_1.time_ <= var_372_10 + arg_372_0 then
				arg_369_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_372_11 = 0

			if var_372_11 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 then
				arg_369_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_372_12 = 0
			local var_372_13 = 0.25

			if var_372_12 < arg_369_1.time_ and arg_369_1.time_ <= var_372_12 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_14 = arg_369_1:FormatText(StoryNameCfg[472].name)

				arg_369_1.leftNameTxt_.text = var_372_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_15 = arg_369_1:GetWordFromCfg(935011091)
				local var_372_16 = arg_369_1:FormatText(var_372_15.content)

				arg_369_1.text_.text = var_372_16

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_17 = 10
				local var_372_18 = utf8.len(var_372_16)
				local var_372_19 = var_372_17 <= 0 and var_372_13 or var_372_13 * (var_372_18 / var_372_17)

				if var_372_19 > 0 and var_372_13 < var_372_19 then
					arg_369_1.talkMaxDuration = var_372_19

					if var_372_19 + var_372_12 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_19 + var_372_12
					end
				end

				arg_369_1.text_.text = var_372_16
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_20 = math.max(var_372_13, arg_369_1.talkMaxDuration)

			if var_372_12 <= arg_369_1.time_ and arg_369_1.time_ < var_372_12 + var_372_20 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_12) / var_372_20

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_12 + var_372_20 and arg_369_1.time_ < var_372_12 + var_372_20 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play935011092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 935011092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play935011093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1070ui_story"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1070ui_story == nil then
				arg_373_1.var_.characterEffect1070ui_story = var_376_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.characterEffect1070ui_story and not isNil(var_376_0) then
					arg_373_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.characterEffect1070ui_story then
				arg_373_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_376_4 = arg_373_1.actors_["10039ui_story"]
			local var_376_5 = 0

			if var_376_5 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect10039ui_story == nil then
				arg_373_1.var_.characterEffect10039ui_story = var_376_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_6 = 0.200000002980232

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_6 and not isNil(var_376_4) then
				local var_376_7 = (arg_373_1.time_ - var_376_5) / var_376_6

				if arg_373_1.var_.characterEffect10039ui_story and not isNil(var_376_4) then
					local var_376_8 = Mathf.Lerp(0, 0.5, var_376_7)

					arg_373_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10039ui_story.fillRatio = var_376_8
				end
			end

			if arg_373_1.time_ >= var_376_5 + var_376_6 and arg_373_1.time_ < var_376_5 + var_376_6 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect10039ui_story then
				local var_376_9 = 0.5

				arg_373_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10039ui_story.fillRatio = var_376_9
			end

			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 then
				arg_373_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action457")
			end

			local var_376_11 = 0

			if var_376_11 < arg_373_1.time_ and arg_373_1.time_ <= var_376_11 + arg_376_0 then
				arg_373_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			local var_376_12 = 0
			local var_376_13 = 0.525

			if var_376_12 < arg_373_1.time_ and arg_373_1.time_ <= var_376_12 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_14 = arg_373_1:FormatText(StoryNameCfg[318].name)

				arg_373_1.leftNameTxt_.text = var_376_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_15 = arg_373_1:GetWordFromCfg(935011092)
				local var_376_16 = arg_373_1:FormatText(var_376_15.content)

				arg_373_1.text_.text = var_376_16

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_17 = 21
				local var_376_18 = utf8.len(var_376_16)
				local var_376_19 = var_376_17 <= 0 and var_376_13 or var_376_13 * (var_376_18 / var_376_17)

				if var_376_19 > 0 and var_376_13 < var_376_19 then
					arg_373_1.talkMaxDuration = var_376_19

					if var_376_19 + var_376_12 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_19 + var_376_12
					end
				end

				arg_373_1.text_.text = var_376_16
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_20 = math.max(var_376_13, arg_373_1.talkMaxDuration)

			if var_376_12 <= arg_373_1.time_ and arg_373_1.time_ < var_376_12 + var_376_20 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_12) / var_376_20

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_12 + var_376_20 and arg_373_1.time_ < var_376_12 + var_376_20 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play935011093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 935011093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play935011094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10039ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect10039ui_story == nil then
				arg_377_1.var_.characterEffect10039ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect10039ui_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect10039ui_story then
				arg_377_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_380_4 = arg_377_1.actors_["1070ui_story"]
			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect1070ui_story == nil then
				arg_377_1.var_.characterEffect1070ui_story = var_380_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_6 = 0.200000002980232

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_6 and not isNil(var_380_4) then
				local var_380_7 = (arg_377_1.time_ - var_380_5) / var_380_6

				if arg_377_1.var_.characterEffect1070ui_story and not isNil(var_380_4) then
					local var_380_8 = Mathf.Lerp(0, 0.5, var_380_7)

					arg_377_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1070ui_story.fillRatio = var_380_8
				end
			end

			if arg_377_1.time_ >= var_380_5 + var_380_6 and arg_377_1.time_ < var_380_5 + var_380_6 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect1070ui_story then
				local var_380_9 = 0.5

				arg_377_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1070ui_story.fillRatio = var_380_9
			end

			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 then
				arg_377_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_380_11 = 0
			local var_380_12 = 0.075

			if var_380_11 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_13 = arg_377_1:FormatText(StoryNameCfg[472].name)

				arg_377_1.leftNameTxt_.text = var_380_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_14 = arg_377_1:GetWordFromCfg(935011093)
				local var_380_15 = arg_377_1:FormatText(var_380_14.content)

				arg_377_1.text_.text = var_380_15

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_16 = 3
				local var_380_17 = utf8.len(var_380_15)
				local var_380_18 = var_380_16 <= 0 and var_380_12 or var_380_12 * (var_380_17 / var_380_16)

				if var_380_18 > 0 and var_380_12 < var_380_18 then
					arg_377_1.talkMaxDuration = var_380_18

					if var_380_18 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_18 + var_380_11
					end
				end

				arg_377_1.text_.text = var_380_15
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_19 = math.max(var_380_12, arg_377_1.talkMaxDuration)

			if var_380_11 <= arg_377_1.time_ and arg_377_1.time_ < var_380_11 + var_380_19 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_11) / var_380_19

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_11 + var_380_19 and arg_377_1.time_ < var_380_11 + var_380_19 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play935011094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 935011094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play935011095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1070ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1070ui_story == nil then
				arg_381_1.var_.characterEffect1070ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1070ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1070ui_story then
				arg_381_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_384_4 = arg_381_1.actors_["10039ui_story"]
			local var_384_5 = 0

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect10039ui_story == nil then
				arg_381_1.var_.characterEffect10039ui_story = var_384_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_6 = 0.200000002980232

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_6 and not isNil(var_384_4) then
				local var_384_7 = (arg_381_1.time_ - var_384_5) / var_384_6

				if arg_381_1.var_.characterEffect10039ui_story and not isNil(var_384_4) then
					local var_384_8 = Mathf.Lerp(0, 0.5, var_384_7)

					arg_381_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_381_1.var_.characterEffect10039ui_story.fillRatio = var_384_8
				end
			end

			if arg_381_1.time_ >= var_384_5 + var_384_6 and arg_381_1.time_ < var_384_5 + var_384_6 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect10039ui_story then
				local var_384_9 = 0.5

				arg_381_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_381_1.var_.characterEffect10039ui_story.fillRatio = var_384_9
			end

			local var_384_10 = 0

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 then
				arg_381_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_384_11 = 0

			if var_384_11 < arg_381_1.time_ and arg_381_1.time_ <= var_384_11 + arg_384_0 then
				arg_381_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_384_12 = 0
			local var_384_13 = 0.775

			if var_384_12 < arg_381_1.time_ and arg_381_1.time_ <= var_384_12 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_14 = arg_381_1:FormatText(StoryNameCfg[318].name)

				arg_381_1.leftNameTxt_.text = var_384_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_15 = arg_381_1:GetWordFromCfg(935011094)
				local var_384_16 = arg_381_1:FormatText(var_384_15.content)

				arg_381_1.text_.text = var_384_16

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_17 = 31
				local var_384_18 = utf8.len(var_384_16)
				local var_384_19 = var_384_17 <= 0 and var_384_13 or var_384_13 * (var_384_18 / var_384_17)

				if var_384_19 > 0 and var_384_13 < var_384_19 then
					arg_381_1.talkMaxDuration = var_384_19

					if var_384_19 + var_384_12 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_19 + var_384_12
					end
				end

				arg_381_1.text_.text = var_384_16
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_20 = math.max(var_384_13, arg_381_1.talkMaxDuration)

			if var_384_12 <= arg_381_1.time_ and arg_381_1.time_ < var_384_12 + var_384_20 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_12) / var_384_20

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_12 + var_384_20 and arg_381_1.time_ < var_384_12 + var_384_20 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play935011095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 935011095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play935011096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10039ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10039ui_story == nil then
				arg_385_1.var_.characterEffect10039ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect10039ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10039ui_story then
				arg_385_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_388_4 = arg_385_1.actors_["1070ui_story"]
			local var_388_5 = 0

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1070ui_story == nil then
				arg_385_1.var_.characterEffect1070ui_story = var_388_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_6 = 0.200000002980232

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_6 and not isNil(var_388_4) then
				local var_388_7 = (arg_385_1.time_ - var_388_5) / var_388_6

				if arg_385_1.var_.characterEffect1070ui_story and not isNil(var_388_4) then
					local var_388_8 = Mathf.Lerp(0, 0.5, var_388_7)

					arg_385_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1070ui_story.fillRatio = var_388_8
				end
			end

			if arg_385_1.time_ >= var_388_5 + var_388_6 and arg_385_1.time_ < var_388_5 + var_388_6 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1070ui_story then
				local var_388_9 = 0.5

				arg_385_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1070ui_story.fillRatio = var_388_9
			end

			local var_388_10 = 0

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 then
				arg_385_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action452")
			end

			local var_388_11 = 0

			if var_388_11 < arg_385_1.time_ and arg_385_1.time_ <= var_388_11 + arg_388_0 then
				arg_385_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_388_12 = 0
			local var_388_13 = 0.6

			if var_388_12 < arg_385_1.time_ and arg_385_1.time_ <= var_388_12 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_14 = arg_385_1:FormatText(StoryNameCfg[472].name)

				arg_385_1.leftNameTxt_.text = var_388_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_15 = arg_385_1:GetWordFromCfg(935011095)
				local var_388_16 = arg_385_1:FormatText(var_388_15.content)

				arg_385_1.text_.text = var_388_16

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_17 = 24
				local var_388_18 = utf8.len(var_388_16)
				local var_388_19 = var_388_17 <= 0 and var_388_13 or var_388_13 * (var_388_18 / var_388_17)

				if var_388_19 > 0 and var_388_13 < var_388_19 then
					arg_385_1.talkMaxDuration = var_388_19

					if var_388_19 + var_388_12 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_19 + var_388_12
					end
				end

				arg_385_1.text_.text = var_388_16
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_20 = math.max(var_388_13, arg_385_1.talkMaxDuration)

			if var_388_12 <= arg_385_1.time_ and arg_385_1.time_ < var_388_12 + var_388_20 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_12) / var_388_20

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_12 + var_388_20 and arg_385_1.time_ < var_388_12 + var_388_20 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play935011096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 935011096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play935011097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1070ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1070ui_story == nil then
				arg_389_1.var_.characterEffect1070ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect1070ui_story and not isNil(var_392_0) then
					arg_389_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1070ui_story then
				arg_389_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_392_4 = arg_389_1.actors_["10039ui_story"]
			local var_392_5 = 0

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 and not isNil(var_392_4) and arg_389_1.var_.characterEffect10039ui_story == nil then
				arg_389_1.var_.characterEffect10039ui_story = var_392_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_6 = 0.200000002980232

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_6 and not isNil(var_392_4) then
				local var_392_7 = (arg_389_1.time_ - var_392_5) / var_392_6

				if arg_389_1.var_.characterEffect10039ui_story and not isNil(var_392_4) then
					local var_392_8 = Mathf.Lerp(0, 0.5, var_392_7)

					arg_389_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10039ui_story.fillRatio = var_392_8
				end
			end

			if arg_389_1.time_ >= var_392_5 + var_392_6 and arg_389_1.time_ < var_392_5 + var_392_6 + arg_392_0 and not isNil(var_392_4) and arg_389_1.var_.characterEffect10039ui_story then
				local var_392_9 = 0.5

				arg_389_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10039ui_story.fillRatio = var_392_9
			end

			local var_392_10 = 0

			if var_392_10 < arg_389_1.time_ and arg_389_1.time_ <= var_392_10 + arg_392_0 then
				arg_389_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_392_11 = 0

			if var_392_11 < arg_389_1.time_ and arg_389_1.time_ <= var_392_11 + arg_392_0 then
				arg_389_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_392_12 = 0
			local var_392_13 = 1.1

			if var_392_12 < arg_389_1.time_ and arg_389_1.time_ <= var_392_12 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_14 = arg_389_1:FormatText(StoryNameCfg[318].name)

				arg_389_1.leftNameTxt_.text = var_392_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_15 = arg_389_1:GetWordFromCfg(935011096)
				local var_392_16 = arg_389_1:FormatText(var_392_15.content)

				arg_389_1.text_.text = var_392_16

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_17 = 44
				local var_392_18 = utf8.len(var_392_16)
				local var_392_19 = var_392_17 <= 0 and var_392_13 or var_392_13 * (var_392_18 / var_392_17)

				if var_392_19 > 0 and var_392_13 < var_392_19 then
					arg_389_1.talkMaxDuration = var_392_19

					if var_392_19 + var_392_12 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_19 + var_392_12
					end
				end

				arg_389_1.text_.text = var_392_16
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_20 = math.max(var_392_13, arg_389_1.talkMaxDuration)

			if var_392_12 <= arg_389_1.time_ and arg_389_1.time_ < var_392_12 + var_392_20 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_12) / var_392_20

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_12 + var_392_20 and arg_389_1.time_ < var_392_12 + var_392_20 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play935011097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 935011097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play935011098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1070ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1070ui_story == nil then
				arg_393_1.var_.characterEffect1070ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1070ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1070ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1070ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1070ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.825

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(935011097)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 33
				local var_396_11 = utf8.len(var_396_9)
				local var_396_12 = var_396_10 <= 0 and var_396_7 or var_396_7 * (var_396_11 / var_396_10)

				if var_396_12 > 0 and var_396_7 < var_396_12 then
					arg_393_1.talkMaxDuration = var_396_12

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_13 and arg_393_1.time_ < var_396_6 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play935011098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 935011098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play935011099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1070ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1070ui_story == nil then
				arg_397_1.var_.characterEffect1070ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1070ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1070ui_story then
				arg_397_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_400_6 = 0
			local var_400_7 = 0.65

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[318].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_9 = arg_397_1:GetWordFromCfg(935011098)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 26
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play935011099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 935011099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play935011100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_404_1 = 0
			local var_404_2 = 0.9

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_3 = arg_401_1:FormatText(StoryNameCfg[318].name)

				arg_401_1.leftNameTxt_.text = var_404_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(935011099)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 36
				local var_404_7 = utf8.len(var_404_5)
				local var_404_8 = var_404_6 <= 0 and var_404_2 or var_404_2 * (var_404_7 / var_404_6)

				if var_404_8 > 0 and var_404_2 < var_404_8 then
					arg_401_1.talkMaxDuration = var_404_8

					if var_404_8 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_9 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_9 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_9

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_9 and arg_401_1.time_ < var_404_1 + var_404_9 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play935011100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 935011100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play935011101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_408_2 = 0
			local var_408_3 = 0.375

			if var_408_2 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_4 = arg_405_1:FormatText(StoryNameCfg[318].name)

				arg_405_1.leftNameTxt_.text = var_408_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_5 = arg_405_1:GetWordFromCfg(935011100)
				local var_408_6 = arg_405_1:FormatText(var_408_5.content)

				arg_405_1.text_.text = var_408_6

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_7 = 15
				local var_408_8 = utf8.len(var_408_6)
				local var_408_9 = var_408_7 <= 0 and var_408_3 or var_408_3 * (var_408_8 / var_408_7)

				if var_408_9 > 0 and var_408_3 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_2
					end
				end

				arg_405_1.text_.text = var_408_6
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_3, arg_405_1.talkMaxDuration)

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_2) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_2 + var_408_10 and arg_405_1.time_ < var_408_2 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play935011101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 935011101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play935011102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10039ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10039ui_story == nil then
				arg_409_1.var_.characterEffect10039ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect10039ui_story and not isNil(var_412_0) then
					arg_409_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10039ui_story then
				arg_409_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_412_4 = arg_409_1.actors_["1070ui_story"]
			local var_412_5 = 0

			if var_412_5 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect1070ui_story == nil then
				arg_409_1.var_.characterEffect1070ui_story = var_412_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_6 = 0.200000002980232

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_6 and not isNil(var_412_4) then
				local var_412_7 = (arg_409_1.time_ - var_412_5) / var_412_6

				if arg_409_1.var_.characterEffect1070ui_story and not isNil(var_412_4) then
					local var_412_8 = Mathf.Lerp(0, 0.5, var_412_7)

					arg_409_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1070ui_story.fillRatio = var_412_8
				end
			end

			if arg_409_1.time_ >= var_412_5 + var_412_6 and arg_409_1.time_ < var_412_5 + var_412_6 + arg_412_0 and not isNil(var_412_4) and arg_409_1.var_.characterEffect1070ui_story then
				local var_412_9 = 0.5

				arg_409_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1070ui_story.fillRatio = var_412_9
			end

			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 then
				arg_409_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action426")
			end

			local var_412_11 = 0
			local var_412_12 = 0.65

			if var_412_11 < arg_409_1.time_ and arg_409_1.time_ <= var_412_11 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_13 = arg_409_1:FormatText(StoryNameCfg[472].name)

				arg_409_1.leftNameTxt_.text = var_412_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_14 = arg_409_1:GetWordFromCfg(935011101)
				local var_412_15 = arg_409_1:FormatText(var_412_14.content)

				arg_409_1.text_.text = var_412_15

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_16 = 26
				local var_412_17 = utf8.len(var_412_15)
				local var_412_18 = var_412_16 <= 0 and var_412_12 or var_412_12 * (var_412_17 / var_412_16)

				if var_412_18 > 0 and var_412_12 < var_412_18 then
					arg_409_1.talkMaxDuration = var_412_18

					if var_412_18 + var_412_11 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_18 + var_412_11
					end
				end

				arg_409_1.text_.text = var_412_15
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_19 = math.max(var_412_12, arg_409_1.talkMaxDuration)

			if var_412_11 <= arg_409_1.time_ and arg_409_1.time_ < var_412_11 + var_412_19 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_11) / var_412_19

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_11 + var_412_19 and arg_409_1.time_ < var_412_11 + var_412_19 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play935011102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 935011102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play935011103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1070ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1070ui_story == nil then
				arg_413_1.var_.characterEffect1070ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1070ui_story and not isNil(var_416_0) then
					arg_413_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1070ui_story then
				arg_413_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_416_4 = arg_413_1.actors_["10039ui_story"]
			local var_416_5 = 0

			if var_416_5 < arg_413_1.time_ and arg_413_1.time_ <= var_416_5 + arg_416_0 and not isNil(var_416_4) and arg_413_1.var_.characterEffect10039ui_story == nil then
				arg_413_1.var_.characterEffect10039ui_story = var_416_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_6 = 0.200000002980232

			if var_416_5 <= arg_413_1.time_ and arg_413_1.time_ < var_416_5 + var_416_6 and not isNil(var_416_4) then
				local var_416_7 = (arg_413_1.time_ - var_416_5) / var_416_6

				if arg_413_1.var_.characterEffect10039ui_story and not isNil(var_416_4) then
					local var_416_8 = Mathf.Lerp(0, 0.5, var_416_7)

					arg_413_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_413_1.var_.characterEffect10039ui_story.fillRatio = var_416_8
				end
			end

			if arg_413_1.time_ >= var_416_5 + var_416_6 and arg_413_1.time_ < var_416_5 + var_416_6 + arg_416_0 and not isNil(var_416_4) and arg_413_1.var_.characterEffect10039ui_story then
				local var_416_9 = 0.5

				arg_413_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_413_1.var_.characterEffect10039ui_story.fillRatio = var_416_9
			end

			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 then
				arg_413_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_416_11 = 0

			if var_416_11 < arg_413_1.time_ and arg_413_1.time_ <= var_416_11 + arg_416_0 then
				arg_413_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_416_12 = 0
			local var_416_13 = 0.875

			if var_416_12 < arg_413_1.time_ and arg_413_1.time_ <= var_416_12 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_14 = arg_413_1:FormatText(StoryNameCfg[318].name)

				arg_413_1.leftNameTxt_.text = var_416_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_15 = arg_413_1:GetWordFromCfg(935011102)
				local var_416_16 = arg_413_1:FormatText(var_416_15.content)

				arg_413_1.text_.text = var_416_16

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_17 = 35
				local var_416_18 = utf8.len(var_416_16)
				local var_416_19 = var_416_17 <= 0 and var_416_13 or var_416_13 * (var_416_18 / var_416_17)

				if var_416_19 > 0 and var_416_13 < var_416_19 then
					arg_413_1.talkMaxDuration = var_416_19

					if var_416_19 + var_416_12 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_19 + var_416_12
					end
				end

				arg_413_1.text_.text = var_416_16
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_20 = math.max(var_416_13, arg_413_1.talkMaxDuration)

			if var_416_12 <= arg_413_1.time_ and arg_413_1.time_ < var_416_12 + var_416_20 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_12) / var_416_20

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_12 + var_416_20 and arg_413_1.time_ < var_416_12 + var_416_20 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play935011103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 935011103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play935011104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10039ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos10039ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(0, 100, 0)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10039ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, 100, 0)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["10039ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect10039ui_story == nil then
				arg_417_1.var_.characterEffect10039ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect10039ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect10039ui_story then
				arg_417_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_420_13 = arg_417_1.actors_["1070ui_story"]
			local var_420_14 = 0

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect1070ui_story == nil then
				arg_417_1.var_.characterEffect1070ui_story = var_420_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_15 = 0.200000002980232

			if var_420_14 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_15 and not isNil(var_420_13) then
				local var_420_16 = (arg_417_1.time_ - var_420_14) / var_420_15

				if arg_417_1.var_.characterEffect1070ui_story and not isNil(var_420_13) then
					local var_420_17 = Mathf.Lerp(0, 0.5, var_420_16)

					arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1070ui_story.fillRatio = var_420_17
				end
			end

			if arg_417_1.time_ >= var_420_14 + var_420_15 and arg_417_1.time_ < var_420_14 + var_420_15 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect1070ui_story then
				local var_420_18 = 0.5

				arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1070ui_story.fillRatio = var_420_18
			end

			local var_420_19 = 0
			local var_420_20 = 0.85

			if var_420_19 < arg_417_1.time_ and arg_417_1.time_ <= var_420_19 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_21 = arg_417_1:FormatText(StoryNameCfg[472].name)

				arg_417_1.leftNameTxt_.text = var_420_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10039")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_22 = arg_417_1:GetWordFromCfg(935011103)
				local var_420_23 = arg_417_1:FormatText(var_420_22.content)

				arg_417_1.text_.text = var_420_23

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_24 = 34
				local var_420_25 = utf8.len(var_420_23)
				local var_420_26 = var_420_24 <= 0 and var_420_20 or var_420_20 * (var_420_25 / var_420_24)

				if var_420_26 > 0 and var_420_20 < var_420_26 then
					arg_417_1.talkMaxDuration = var_420_26

					if var_420_26 + var_420_19 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_26 + var_420_19
					end
				end

				arg_417_1.text_.text = var_420_23
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_27 = math.max(var_420_20, arg_417_1.talkMaxDuration)

			if var_420_19 <= arg_417_1.time_ and arg_417_1.time_ < var_420_19 + var_420_27 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_19) / var_420_27

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_19 + var_420_27 and arg_417_1.time_ < var_420_19 + var_420_27 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play935011104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 935011104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play935011105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1070ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1070ui_story == nil then
				arg_421_1.var_.characterEffect1070ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1070ui_story and not isNil(var_424_0) then
					arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1070ui_story then
				arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_424_4 = arg_421_1.actors_["10039ui_story"]
			local var_424_5 = 0

			if var_424_5 < arg_421_1.time_ and arg_421_1.time_ <= var_424_5 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect10039ui_story == nil then
				arg_421_1.var_.characterEffect10039ui_story = var_424_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_6 = 0.200000002980232

			if var_424_5 <= arg_421_1.time_ and arg_421_1.time_ < var_424_5 + var_424_6 and not isNil(var_424_4) then
				local var_424_7 = (arg_421_1.time_ - var_424_5) / var_424_6

				if arg_421_1.var_.characterEffect10039ui_story and not isNil(var_424_4) then
					local var_424_8 = Mathf.Lerp(0, 0.5, var_424_7)

					arg_421_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_421_1.var_.characterEffect10039ui_story.fillRatio = var_424_8
				end
			end

			if arg_421_1.time_ >= var_424_5 + var_424_6 and arg_421_1.time_ < var_424_5 + var_424_6 + arg_424_0 and not isNil(var_424_4) and arg_421_1.var_.characterEffect10039ui_story then
				local var_424_9 = 0.5

				arg_421_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_421_1.var_.characterEffect10039ui_story.fillRatio = var_424_9
			end

			local var_424_10 = arg_421_1.actors_["1070ui_story"].transform
			local var_424_11 = 0

			if var_424_11 < arg_421_1.time_ and arg_421_1.time_ <= var_424_11 + arg_424_0 then
				arg_421_1.var_.moveOldPos1070ui_story = var_424_10.localPosition
			end

			local var_424_12 = 0.001

			if var_424_11 <= arg_421_1.time_ and arg_421_1.time_ < var_424_11 + var_424_12 then
				local var_424_13 = (arg_421_1.time_ - var_424_11) / var_424_12
				local var_424_14 = Vector3.New(0, 100, 0)

				var_424_10.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1070ui_story, var_424_14, var_424_13)

				local var_424_15 = manager.ui.mainCamera.transform.position - var_424_10.position

				var_424_10.forward = Vector3.New(var_424_15.x, var_424_15.y, var_424_15.z)

				local var_424_16 = var_424_10.localEulerAngles

				var_424_16.z = 0
				var_424_16.x = 0
				var_424_10.localEulerAngles = var_424_16
			end

			if arg_421_1.time_ >= var_424_11 + var_424_12 and arg_421_1.time_ < var_424_11 + var_424_12 + arg_424_0 then
				var_424_10.localPosition = Vector3.New(0, 100, 0)

				local var_424_17 = manager.ui.mainCamera.transform.position - var_424_10.position

				var_424_10.forward = Vector3.New(var_424_17.x, var_424_17.y, var_424_17.z)

				local var_424_18 = var_424_10.localEulerAngles

				var_424_18.z = 0
				var_424_18.x = 0
				var_424_10.localEulerAngles = var_424_18
			end

			local var_424_19 = 0
			local var_424_20 = 0.4

			if var_424_19 < arg_421_1.time_ and arg_421_1.time_ <= var_424_19 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_21 = arg_421_1:FormatText(StoryNameCfg[318].name)

				arg_421_1.leftNameTxt_.text = var_424_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_2")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_22 = arg_421_1:GetWordFromCfg(935011104)
				local var_424_23 = arg_421_1:FormatText(var_424_22.content)

				arg_421_1.text_.text = var_424_23

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_24 = 16
				local var_424_25 = utf8.len(var_424_23)
				local var_424_26 = var_424_24 <= 0 and var_424_20 or var_424_20 * (var_424_25 / var_424_24)

				if var_424_26 > 0 and var_424_20 < var_424_26 then
					arg_421_1.talkMaxDuration = var_424_26

					if var_424_26 + var_424_19 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_26 + var_424_19
					end
				end

				arg_421_1.text_.text = var_424_23
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_27 = math.max(var_424_20, arg_421_1.talkMaxDuration)

			if var_424_19 <= arg_421_1.time_ and arg_421_1.time_ < var_424_19 + var_424_27 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_19) / var_424_27

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_19 + var_424_27 and arg_421_1.time_ < var_424_19 + var_424_27 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play935011105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 935011105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
			arg_425_1.auto_ = false
		end

		function arg_425_1.playNext_(arg_427_0)
			arg_425_1.onStoryFinished_()
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0
			local var_428_1 = 0.475

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_2 = arg_425_1:FormatText(StoryNameCfg[318].name)

				arg_425_1.leftNameTxt_.text = var_428_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_1")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(935011105)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 19
				local var_428_6 = utf8.len(var_428_4)
				local var_428_7 = var_428_5 <= 0 and var_428_1 or var_428_1 * (var_428_6 / var_428_5)

				if var_428_7 > 0 and var_428_1 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_8 and arg_425_1.time_ < var_428_0 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003a",
		"TextureConfig/Background/ST2003"
	},
	voices = {}
}
