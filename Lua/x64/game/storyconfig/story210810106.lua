return {
	Play1108106001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108106001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108106002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0402a"

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
				local var_4_5 = arg_1_1.bgs_.ST0402a

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
					if iter_4_0 ~= "ST0402a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0
			local var_4_17 = 0.166666666666667

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_18 = "play"
				local var_4_19 = "music"

				arg_1_1:AudioAction(var_4_18, var_4_19, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = ""
				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_21 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 0.3
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_side_1070", "se_story_1070_wind02", "")
			end

			local var_4_32 = 0

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_33 = 2

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33
				local var_4_35 = Color.New(0, 0, 0)

				var_4_35.a = Mathf.Lerp(1, 0, var_4_34)
				arg_1_1.mask_.color = var_4_35
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				local var_4_36 = Color.New(0, 0, 0)
				local var_4_37 = 0

				arg_1_1.mask_.enabled = false
				var_4_36.a = var_4_37
				arg_1_1.mask_.color = var_4_36
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.999999999999
			local var_4_39 = 0.775

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(1108106001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 31
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108106002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108106002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108106003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.975

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

				local var_12_2 = arg_9_1:GetWordFromCfg(1108106002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39
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
	Play1108106003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108106003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1108106004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.025

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(1108106003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 41
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1108106004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108106004
		arg_17_1.duration_ = 4.73

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108106005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1081ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_20_7 = arg_17_1.actors_["1081ui_story"].transform
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.var_.moveOldPos1081ui_story = var_20_7.localPosition

				local var_20_9 = "1081ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_9 .. "Animator"].transform, false)
			end

			local var_20_10 = 0.001

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_10 then
				local var_20_11 = (arg_17_1.time_ - var_20_8) / var_20_10
				local var_20_12 = Vector3.New(0, -0.92, -5.8)

				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1081ui_story, var_20_12, var_20_11)

				local var_20_13 = manager.ui.mainCamera.transform.position - var_20_7.position

				var_20_7.forward = Vector3.New(var_20_13.x, var_20_13.y, var_20_13.z)

				local var_20_14 = var_20_7.localEulerAngles

				var_20_14.z = 0
				var_20_14.x = 0
				var_20_7.localEulerAngles = var_20_14
			end

			if arg_17_1.time_ >= var_20_8 + var_20_10 and arg_17_1.time_ < var_20_8 + var_20_10 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_20_15 = manager.ui.mainCamera.transform.position - var_20_7.position

				var_20_7.forward = Vector3.New(var_20_15.x, var_20_15.y, var_20_15.z)

				local var_20_16 = var_20_7.localEulerAngles

				var_20_16.z = 0
				var_20_16.x = 0
				var_20_7.localEulerAngles = var_20_16
			end

			local var_20_17 = arg_17_1.actors_["1081ui_story"]
			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.characterEffect1081ui_story == nil then
				arg_17_1.var_.characterEffect1081ui_story = var_20_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_19 = 0.2

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 and not isNil(var_20_17) then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19

				if arg_17_1.var_.characterEffect1081ui_story and not isNil(var_20_17) then
					arg_17_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.characterEffect1081ui_story then
				arg_17_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_20_21 = 0
			local var_20_22 = 0.075

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_23 = arg_17_1:FormatText(StoryNameCfg[202].name)

				arg_17_1.leftNameTxt_.text = var_20_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(1108106004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 3
				local var_20_27 = utf8.len(var_20_25)
				local var_20_28 = var_20_26 <= 0 and var_20_22 or var_20_22 * (var_20_27 / var_20_26)

				if var_20_28 > 0 and var_20_22 < var_20_28 then
					arg_17_1.talkMaxDuration = var_20_28

					if var_20_28 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_21
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb") ~= 0 then
					local var_20_29 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb") / 1000

					if var_20_29 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_29 + var_20_21
					end

					if var_20_24.prefab_name ~= "" and arg_17_1.actors_[var_20_24.prefab_name] ~= nil then
						local var_20_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_24.prefab_name].transform, "story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")

						arg_17_1:RecordAudio("1108106004", var_20_30)
						arg_17_1:RecordAudio("1108106004", var_20_30)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106004", "story_v_side_new_1108106.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_31 = math.max(var_20_22, arg_17_1.talkMaxDuration)

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_31 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_21) / var_20_31

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_21 + var_20_31 and arg_17_1.time_ < var_20_21 + var_20_31 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1108106005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108106005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1108106006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1081ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1081ui_story == nil then
				arg_21_1.var_.characterEffect1081ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1081ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1081ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1081ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1081ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 1.325

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(1108106005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 53
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_7 or var_24_7 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_7 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_13 and arg_21_1.time_ < var_24_6 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1108106006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108106006
		arg_25_1.duration_ = 3.83

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1108106007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1081ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1081ui_story == nil then
				arg_25_1.var_.characterEffect1081ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1081ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1081ui_story then
				arg_25_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_6 = 0
			local var_28_7 = 0.35

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[202].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(1108106006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")

						arg_25_1:RecordAudio("1108106006", var_28_15)
						arg_25_1:RecordAudio("1108106006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106006", "story_v_side_new_1108106.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1108106007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108106007
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"

			SetActive(arg_29_1.choicesGo_, true)

			for iter_30_0, iter_30_1 in ipairs(arg_29_1.choices_) do
				local var_30_0 = iter_30_0 <= 2

				SetActive(iter_30_1.go, var_30_0)
			end

			arg_29_1.choices_[1].txt.text = arg_29_1:FormatText(StoryChoiceCfg[979].name)
			arg_29_1.choices_[2].txt.text = arg_29_1:FormatText(StoryChoiceCfg[980].name)
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1108106008(arg_29_1)
			end

			if arg_31_0 == 2 then
				arg_29_0:Play1108106009(arg_29_1)
			end

			arg_29_1:RecordChoiceLog(1108106007, 979, 980)
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1081ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1081ui_story == nil then
				arg_29_1.var_.characterEffect1081ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1081ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1081ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1081ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1081ui_story.fillRatio = var_32_5
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1108106008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108106008
		arg_33_1.duration_ = 10.3

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1108106010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_36_1 = arg_33_1.actors_["1081ui_story"]
			local var_36_2 = 0

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1081ui_story == nil then
				arg_33_1.var_.characterEffect1081ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.2

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 and not isNil(var_36_1) then
				local var_36_4 = (arg_33_1.time_ - var_36_2) / var_36_3

				if arg_33_1.var_.characterEffect1081ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1081ui_story then
				arg_33_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_36_5 = 0
			local var_36_6 = 0.775

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[202].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(1108106008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 31
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")

						arg_33_1:RecordAudio("1108106008", var_36_14)
						arg_33_1:RecordAudio("1108106008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106008", "story_v_side_new_1108106.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1108106010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108106010
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108106011(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1081ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1081ui_story == nil then
				arg_37_1.var_.characterEffect1081ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1081ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1081ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1081ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1081ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_40_7 = 0
			local var_40_8 = 1.175

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(1108106010)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 47
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_8 or var_40_8 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_8 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_14 and arg_37_1.time_ < var_40_7 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1108106011 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108106011
		arg_41_1.duration_ = 2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1108106012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1081ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1081ui_story == nil then
				arg_41_1.var_.characterEffect1081ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1081ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1081ui_story then
				arg_41_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.2

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_6 = arg_41_1:FormatText(StoryNameCfg[202].name)

				arg_41_1.leftNameTxt_.text = var_44_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(1108106011)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 8
				local var_44_10 = utf8.len(var_44_8)
				local var_44_11 = var_44_9 <= 0 and var_44_5 or var_44_5 * (var_44_10 / var_44_9)

				if var_44_11 > 0 and var_44_5 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb") / 1000

					if var_44_12 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_4
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")

						arg_41_1:RecordAudio("1108106011", var_44_13)
						arg_41_1:RecordAudio("1108106011", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106011", "story_v_side_new_1108106.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_14 and arg_41_1.time_ < var_44_4 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1108106012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108106012
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108106013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1081ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1081ui_story == nil then
				arg_45_1.var_.characterEffect1081ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.0666666666666667

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1081ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1081ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1081ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1081ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.875

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(1108106012)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 35
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_7 or var_48_7 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_7 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_13 and arg_45_1.time_ < var_48_6 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1108106013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108106013
		arg_49_1.duration_ = 4.53

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108106014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_1 = arg_49_1.actors_["1081ui_story"]
			local var_52_2 = 0

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1081ui_story == nil then
				arg_49_1.var_.characterEffect1081ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_3 and not isNil(var_52_1) then
				local var_52_4 = (arg_49_1.time_ - var_52_2) / var_52_3

				if arg_49_1.var_.characterEffect1081ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_2 + var_52_3 and arg_49_1.time_ < var_52_2 + var_52_3 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1081ui_story then
				arg_49_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_52_5 = 0
			local var_52_6 = 0.45

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_7 = arg_49_1:FormatText(StoryNameCfg[202].name)

				arg_49_1.leftNameTxt_.text = var_52_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(1108106013)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 18
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_6 or var_52_6 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_6 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb") / 1000

					if var_52_13 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_5
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")

						arg_49_1:RecordAudio("1108106013", var_52_14)
						arg_49_1:RecordAudio("1108106013", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106013", "story_v_side_new_1108106.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_15 and arg_49_1.time_ < var_52_5 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1108106014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108106014
		arg_53_1.duration_ = 5.57

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1108106015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.625

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[202].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(1108106014)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 25
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")

						arg_53_1:RecordAudio("1108106014", var_56_9)
						arg_53_1:RecordAudio("1108106014", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106014", "story_v_side_new_1108106.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1108106015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108106015
		arg_57_1.duration_ = 6.5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1108106016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.575

			if var_60_2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_4 = arg_57_1:FormatText(StoryNameCfg[202].name)

				arg_57_1.leftNameTxt_.text = var_60_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(1108106015)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 23
				local var_60_8 = utf8.len(var_60_6)
				local var_60_9 = var_60_7 <= 0 and var_60_3 or var_60_3 * (var_60_8 / var_60_7)

				if var_60_9 > 0 and var_60_3 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb") / 1000

					if var_60_10 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_2
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")

						arg_57_1:RecordAudio("1108106015", var_60_11)
						arg_57_1:RecordAudio("1108106015", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106015", "story_v_side_new_1108106.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_12 and arg_57_1.time_ < var_60_2 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1108106016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108106016
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"

			SetActive(arg_61_1.choicesGo_, true)

			for iter_62_0, iter_62_1 in ipairs(arg_61_1.choices_) do
				local var_62_0 = iter_62_0 <= 1

				SetActive(iter_62_1.go, var_62_0)
			end

			arg_61_1.choices_[1].txt.text = arg_61_1:FormatText(StoryChoiceCfg[981].name)
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108106017(arg_61_1)
			end

			arg_61_1:RecordChoiceLog(1108106016, 981)
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1081ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1081ui_story == nil then
				arg_61_1.var_.characterEffect1081ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1081ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1081ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1081ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1081ui_story.fillRatio = var_64_5
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1108106017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108106017
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1108106018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.325

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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(1108106017)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 13
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
	Play1108106018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108106018
		arg_69_1.duration_ = 4.8

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1108106019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_72_2 = arg_69_1.actors_["1081ui_story"]
			local var_72_3 = 0

			if var_72_3 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1081ui_story == nil then
				arg_69_1.var_.characterEffect1081ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_4 and not isNil(var_72_2) then
				local var_72_5 = (arg_69_1.time_ - var_72_3) / var_72_4

				if arg_69_1.var_.characterEffect1081ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_3 + var_72_4 and arg_69_1.time_ < var_72_3 + var_72_4 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1081ui_story then
				arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_6 = 1
			local var_72_7 = 0.525

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_8 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_8:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_9 = arg_69_1:FormatText(StoryNameCfg[202].name)

				arg_69_1.leftNameTxt_.text = var_72_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(1108106018)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 21
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_7 or var_72_7 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_7 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14
					var_72_6 = var_72_6 + 0.3

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb") ~= 0 then
					local var_72_15 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb") / 1000

					if var_72_15 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_6
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")

						arg_69_1:RecordAudio("1108106018", var_72_16)
						arg_69_1:RecordAudio("1108106018", var_72_16)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106018", "story_v_side_new_1108106.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_17 = var_72_6 + 0.3
			local var_72_18 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_17) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_17 + var_72_18 and arg_69_1.time_ < var_72_17 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1108106019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1108106019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1108106020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1081ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1081ui_story == nil then
				arg_75_1.var_.characterEffect1081ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.0166666666666667

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1081ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1081ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1081ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1081ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 1.35

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(1108106019)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 54
				local var_78_11 = utf8.len(var_78_9)
				local var_78_12 = var_78_10 <= 0 and var_78_7 or var_78_7 * (var_78_11 / var_78_10)

				if var_78_12 > 0 and var_78_7 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_13 and arg_75_1.time_ < var_78_6 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1108106020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1108106020
		arg_79_1.duration_ = 10.8

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1108106021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_1 = arg_79_1.actors_["1081ui_story"]
			local var_82_2 = 0

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1081ui_story == nil then
				arg_79_1.var_.characterEffect1081ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_3 and not isNil(var_82_1) then
				local var_82_4 = (arg_79_1.time_ - var_82_2) / var_82_3

				if arg_79_1.var_.characterEffect1081ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_2 + var_82_3 and arg_79_1.time_ < var_82_2 + var_82_3 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1081ui_story then
				arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_82_5 = 0
			local var_82_6 = 0.9

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_7 = arg_79_1:FormatText(StoryNameCfg[202].name)

				arg_79_1.leftNameTxt_.text = var_82_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(1108106020)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 36
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_6 or var_82_6 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_6 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb") / 1000

					if var_82_13 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_5
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")

						arg_79_1:RecordAudio("1108106020", var_82_14)
						arg_79_1:RecordAudio("1108106020", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106020", "story_v_side_new_1108106.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_15 and arg_79_1.time_ < var_82_5 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1108106021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1108106021
		arg_83_1.duration_ = 5.13

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1108106022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_86_2 = 0
			local var_86_3 = 0.425

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_4 = arg_83_1:FormatText(StoryNameCfg[202].name)

				arg_83_1.leftNameTxt_.text = var_86_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:GetWordFromCfg(1108106021)
				local var_86_6 = arg_83_1:FormatText(var_86_5.content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 17
				local var_86_8 = utf8.len(var_86_6)
				local var_86_9 = var_86_7 <= 0 and var_86_3 or var_86_3 * (var_86_8 / var_86_7)

				if var_86_9 > 0 and var_86_3 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb") / 1000

					if var_86_10 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_2
					end

					if var_86_5.prefab_name ~= "" and arg_83_1.actors_[var_86_5.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_5.prefab_name].transform, "story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")

						arg_83_1:RecordAudio("1108106021", var_86_11)
						arg_83_1:RecordAudio("1108106021", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106021", "story_v_side_new_1108106.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_12 and arg_83_1.time_ < var_86_2 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1108106022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1108106022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1108106023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1081ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1081ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1081ui_story, var_90_4, var_90_3)

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

			local var_90_9 = 0
			local var_90_10 = 1.075

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:GetWordFromCfg(1108106022)
				local var_90_12 = arg_87_1:FormatText(var_90_11.content)

				arg_87_1.text_.text = var_90_12

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 43
				local var_90_14 = utf8.len(var_90_12)
				local var_90_15 = var_90_13 <= 0 and var_90_10 or var_90_10 * (var_90_14 / var_90_13)

				if var_90_15 > 0 and var_90_10 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_9 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_9
					end
				end

				arg_87_1.text_.text = var_90_12
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_10, arg_87_1.talkMaxDuration)

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_9) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_9 + var_90_16 and arg_87_1.time_ < var_90_9 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play1108106023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1108106023
		arg_91_1.duration_ = 5.23

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1108106024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.075

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[202].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(1108106023)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 13
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")

						arg_91_1:RecordAudio("1108106023", var_94_9)
						arg_91_1:RecordAudio("1108106023", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106023", "story_v_side_new_1108106.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1108106024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1108106024
		arg_95_1.duration_ = 1

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"

			SetActive(arg_95_1.choicesGo_, true)

			for iter_96_0, iter_96_1 in ipairs(arg_95_1.choices_) do
				local var_96_0 = iter_96_0 <= 1

				SetActive(iter_96_1.go, var_96_0)
			end

			arg_95_1.choices_[1].txt.text = arg_95_1:FormatText(StoryChoiceCfg[982].name)
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1108106025(arg_95_1)
			end

			arg_95_1:RecordChoiceLog(1108106024, 982)
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			return
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1108106025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1108106025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1108106026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.6

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(1108106025)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 64
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1108106026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1108106026
		arg_103_1.duration_ = 9

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1108106027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 4

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			local var_106_1 = 0.5

			if arg_103_1.time_ >= var_106_0 + var_106_1 and arg_103_1.time_ < var_106_0 + var_106_1 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_2 = "ST0401"

			if arg_103_1.bgs_[var_106_2] == nil then
				local var_106_3 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_106_2)
				var_106_3.name = var_106_2
				var_106_3.transform.parent = arg_103_1.stage_.transform
				var_106_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_[var_106_2] = var_106_3
			end

			local var_106_4 = 2

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				local var_106_5 = manager.ui.mainCamera.transform.localPosition
				local var_106_6 = Vector3.New(0, 0, 10) + Vector3.New(var_106_5.x, var_106_5.y, 0)
				local var_106_7 = arg_103_1.bgs_.ST0401

				var_106_7.transform.localPosition = var_106_6
				var_106_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_8 = var_106_7:GetComponent("SpriteRenderer")

				if var_106_8 and var_106_8.sprite then
					local var_106_9 = (var_106_7.transform.localPosition - var_106_5).z
					local var_106_10 = manager.ui.mainCameraCom_
					local var_106_11 = 2 * var_106_9 * Mathf.Tan(var_106_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_12 = var_106_11 * var_106_10.aspect
					local var_106_13 = var_106_8.sprite.bounds.size.x
					local var_106_14 = var_106_8.sprite.bounds.size.y
					local var_106_15 = var_106_12 / var_106_13
					local var_106_16 = var_106_11 / var_106_14
					local var_106_17 = var_106_16 < var_106_15 and var_106_15 or var_106_16

					var_106_7.transform.localScale = Vector3.New(var_106_17, var_106_17, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "ST0401" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_18 = 0

			if var_106_18 < arg_103_1.time_ and arg_103_1.time_ <= var_106_18 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_19 = 2

			if var_106_18 <= arg_103_1.time_ and arg_103_1.time_ < var_106_18 + var_106_19 then
				local var_106_20 = (arg_103_1.time_ - var_106_18) / var_106_19
				local var_106_21 = Color.New(1, 1, 1)

				var_106_21.a = Mathf.Lerp(0, 1, var_106_20)
				arg_103_1.mask_.color = var_106_21
			end

			if arg_103_1.time_ >= var_106_18 + var_106_19 and arg_103_1.time_ < var_106_18 + var_106_19 + arg_106_0 then
				local var_106_22 = Color.New(1, 1, 1)

				var_106_22.a = 1
				arg_103_1.mask_.color = var_106_22
			end

			local var_106_23 = 2

			if var_106_23 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_24 = 2

			if var_106_23 <= arg_103_1.time_ and arg_103_1.time_ < var_106_23 + var_106_24 then
				local var_106_25 = (arg_103_1.time_ - var_106_23) / var_106_24
				local var_106_26 = Color.New(1, 1, 1)

				var_106_26.a = Mathf.Lerp(1, 0, var_106_25)
				arg_103_1.mask_.color = var_106_26
			end

			if arg_103_1.time_ >= var_106_23 + var_106_24 and arg_103_1.time_ < var_106_23 + var_106_24 + arg_106_0 then
				local var_106_27 = Color.New(1, 1, 1)
				local var_106_28 = 0

				arg_103_1.mask_.enabled = false
				var_106_27.a = var_106_28
				arg_103_1.mask_.color = var_106_27
			end

			local var_106_29 = 2
			local var_106_30 = 1.43333333333333

			if var_106_29 < arg_103_1.time_ and arg_103_1.time_ <= var_106_29 + arg_106_0 then
				local var_106_31 = "play"
				local var_106_32 = "effect"

				arg_103_1:AudioAction(var_106_31, var_106_32, "se_story_133", "se_story_133_sea", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_33 = 4
			local var_106_34 = 1.3

			if var_106_33 < arg_103_1.time_ and arg_103_1.time_ <= var_106_33 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_35 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_35:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_36 = arg_103_1:GetWordFromCfg(1108106026)
				local var_106_37 = arg_103_1:FormatText(var_106_36.content)

				arg_103_1.text_.text = var_106_37

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_38 = 52
				local var_106_39 = utf8.len(var_106_37)
				local var_106_40 = var_106_38 <= 0 and var_106_34 or var_106_34 * (var_106_39 / var_106_38)

				if var_106_40 > 0 and var_106_34 < var_106_40 then
					arg_103_1.talkMaxDuration = var_106_40
					var_106_33 = var_106_33 + 0.3

					if var_106_40 + var_106_33 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_40 + var_106_33
					end
				end

				arg_103_1.text_.text = var_106_37
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_41 = var_106_33 + 0.3
			local var_106_42 = math.max(var_106_34, arg_103_1.talkMaxDuration)

			if var_106_41 <= arg_103_1.time_ and arg_103_1.time_ < var_106_41 + var_106_42 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_41) / var_106_42

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_41 + var_106_42 and arg_103_1.time_ < var_106_41 + var_106_42 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1108106027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108106027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108106028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_1 = 0.5

			if arg_109_1.time_ >= var_112_0 + var_112_1 and arg_109_1.time_ < var_112_0 + var_112_1 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_2 = 0
			local var_112_3 = 1.425

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(1108106027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 57
				local var_112_7 = utf8.len(var_112_5)
				local var_112_8 = var_112_6 <= 0 and var_112_3 or var_112_3 * (var_112_7 / var_112_6)

				if var_112_8 > 0 and var_112_3 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_9 and arg_109_1.time_ < var_112_2 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1108106028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108106028
		arg_113_1.duration_ = 1

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"

			SetActive(arg_113_1.choicesGo_, true)

			for iter_114_0, iter_114_1 in ipairs(arg_113_1.choices_) do
				local var_114_0 = iter_114_0 <= 1

				SetActive(iter_114_1.go, var_114_0)
			end

			arg_113_1.choices_[1].txt.text = arg_113_1:FormatText(StoryChoiceCfg[983].name)
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1108106029(arg_113_1)
			end

			arg_113_1:RecordChoiceLog(1108106028, 983)
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_1 = 0.5

			if arg_113_1.time_ >= var_116_0 + var_116_1 and arg_113_1.time_ < var_116_0 + var_116_1 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1108106029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108106029
		arg_117_1.duration_ = 6.5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1108106030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_120_2 = arg_117_1.actors_["1081ui_story"]
			local var_120_3 = 0

			if var_120_3 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1081ui_story == nil then
				arg_117_1.var_.characterEffect1081ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.200000002980232

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_4 and not isNil(var_120_2) then
				local var_120_5 = (arg_117_1.time_ - var_120_3) / var_120_4

				if arg_117_1.var_.characterEffect1081ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_3 + var_120_4 and arg_117_1.time_ < var_120_3 + var_120_4 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1081ui_story then
				arg_117_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_120_6 = arg_117_1.actors_["1081ui_story"].transform
			local var_120_7 = 0

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.var_.moveOldPos1081ui_story = var_120_6.localPosition
			end

			local var_120_8 = 0.001

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = (arg_117_1.time_ - var_120_7) / var_120_8
				local var_120_10 = Vector3.New(0, -0.92, -5.8)

				var_120_6.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1081ui_story, var_120_10, var_120_9)

				local var_120_11 = manager.ui.mainCamera.transform.position - var_120_6.position

				var_120_6.forward = Vector3.New(var_120_11.x, var_120_11.y, var_120_11.z)

				local var_120_12 = var_120_6.localEulerAngles

				var_120_12.z = 0
				var_120_12.x = 0
				var_120_6.localEulerAngles = var_120_12
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				var_120_6.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_120_13 = manager.ui.mainCamera.transform.position - var_120_6.position

				var_120_6.forward = Vector3.New(var_120_13.x, var_120_13.y, var_120_13.z)

				local var_120_14 = var_120_6.localEulerAngles

				var_120_14.z = 0
				var_120_14.x = 0
				var_120_6.localEulerAngles = var_120_14
			end

			local var_120_15 = 0
			local var_120_16 = 0.575

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[202].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(1108106029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 23
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")

						arg_117_1:RecordAudio("1108106029", var_120_24)
						arg_117_1:RecordAudio("1108106029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106029", "story_v_side_new_1108106.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108106030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108106030
		arg_121_1.duration_ = 3.8

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108106031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_2 = 0.666666666666667
			local var_124_3 = 0.15

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_4 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_4:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_5 = arg_121_1:FormatText(StoryNameCfg[202].name)

				arg_121_1.leftNameTxt_.text = var_124_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(1108106030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 6
				local var_124_9 = utf8.len(var_124_7)
				local var_124_10 = var_124_8 <= 0 and var_124_3 or var_124_3 * (var_124_9 / var_124_8)

				if var_124_10 > 0 and var_124_3 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10
					var_124_2 = var_124_2 + 0.3

					if var_124_10 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb") / 1000

					if var_124_11 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_2
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")

						arg_121_1:RecordAudio("1108106030", var_124_12)
						arg_121_1:RecordAudio("1108106030", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106030", "story_v_side_new_1108106.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = var_124_2 + 0.3
			local var_124_14 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_13 <= arg_121_1.time_ and arg_121_1.time_ < var_124_13 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_13) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_13 + var_124_14 and arg_121_1.time_ < var_124_13 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1108106031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1108106031
		arg_127_1.duration_ = 4.2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1108106032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.475

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[202].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(1108106031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 19
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")

						arg_127_1:RecordAudio("1108106031", var_130_9)
						arg_127_1:RecordAudio("1108106031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106031", "story_v_side_new_1108106.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1108106032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1108106032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1108106033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1081ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1081ui_story = var_134_0.localPosition

				local var_134_2 = "1081ui_story"

				arg_131_1:ShowWeapon(arg_131_1.var_[var_134_2 .. "Animator"].transform, false)
			end

			local var_134_3 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_3 then
				local var_134_4 = (arg_131_1.time_ - var_134_1) / var_134_3
				local var_134_5 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1081ui_story, var_134_5, var_134_4)

				local var_134_6 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_6.x, var_134_6.y, var_134_6.z)

				local var_134_7 = var_134_0.localEulerAngles

				var_134_7.z = 0
				var_134_7.x = 0
				var_134_0.localEulerAngles = var_134_7
			end

			if arg_131_1.time_ >= var_134_1 + var_134_3 and arg_131_1.time_ < var_134_1 + var_134_3 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_8 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_8.x, var_134_8.y, var_134_8.z)

				local var_134_9 = var_134_0.localEulerAngles

				var_134_9.z = 0
				var_134_9.x = 0
				var_134_0.localEulerAngles = var_134_9
			end

			local var_134_10 = 0
			local var_134_11 = 1.125

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_12 = arg_131_1:GetWordFromCfg(1108106032)
				local var_134_13 = arg_131_1:FormatText(var_134_12.content)

				arg_131_1.text_.text = var_134_13

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_14 = 45
				local var_134_15 = utf8.len(var_134_13)
				local var_134_16 = var_134_14 <= 0 and var_134_11 or var_134_11 * (var_134_15 / var_134_14)

				if var_134_16 > 0 and var_134_11 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_10
					end
				end

				arg_131_1.text_.text = var_134_13
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_17 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_17 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_10) / var_134_17

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_10 + var_134_17 and arg_131_1.time_ < var_134_10 + var_134_17 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1108106033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1108106033
		arg_135_1.duration_ = 5.1

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1108106034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1081ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1081ui_story == nil then
				arg_135_1.var_.characterEffect1081ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1081ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1081ui_story then
				arg_135_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_138_6 = arg_135_1.actors_["1081ui_story"].transform
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 then
				arg_135_1.var_.moveOldPos1081ui_story = var_138_6.localPosition

				local var_138_8 = "1081ui_story"

				arg_135_1:ShowWeapon(arg_135_1.var_[var_138_8 .. "Animator"].transform, false)
			end

			local var_138_9 = 0.001

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_9 then
				local var_138_10 = (arg_135_1.time_ - var_138_7) / var_138_9
				local var_138_11 = Vector3.New(0, -0.92, -5.8)

				var_138_6.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1081ui_story, var_138_11, var_138_10)

				local var_138_12 = manager.ui.mainCamera.transform.position - var_138_6.position

				var_138_6.forward = Vector3.New(var_138_12.x, var_138_12.y, var_138_12.z)

				local var_138_13 = var_138_6.localEulerAngles

				var_138_13.z = 0
				var_138_13.x = 0
				var_138_6.localEulerAngles = var_138_13
			end

			if arg_135_1.time_ >= var_138_7 + var_138_9 and arg_135_1.time_ < var_138_7 + var_138_9 + arg_138_0 then
				var_138_6.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_6.position

				var_138_6.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_6.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_6.localEulerAngles = var_138_15
			end

			local var_138_16 = 0
			local var_138_17 = 0.5

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_18 = arg_135_1:FormatText(StoryNameCfg[202].name)

				arg_135_1.leftNameTxt_.text = var_138_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_19 = arg_135_1:GetWordFromCfg(1108106033)
				local var_138_20 = arg_135_1:FormatText(var_138_19.content)

				arg_135_1.text_.text = var_138_20

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_21 = 20
				local var_138_22 = utf8.len(var_138_20)
				local var_138_23 = var_138_21 <= 0 and var_138_17 or var_138_17 * (var_138_22 / var_138_21)

				if var_138_23 > 0 and var_138_17 < var_138_23 then
					arg_135_1.talkMaxDuration = var_138_23

					if var_138_23 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_16
					end
				end

				arg_135_1.text_.text = var_138_20
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb") ~= 0 then
					local var_138_24 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb") / 1000

					if var_138_24 + var_138_16 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_24 + var_138_16
					end

					if var_138_19.prefab_name ~= "" and arg_135_1.actors_[var_138_19.prefab_name] ~= nil then
						local var_138_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_19.prefab_name].transform, "story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")

						arg_135_1:RecordAudio("1108106033", var_138_25)
						arg_135_1:RecordAudio("1108106033", var_138_25)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106033", "story_v_side_new_1108106.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_26 = math.max(var_138_17, arg_135_1.talkMaxDuration)

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_26 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_16) / var_138_26

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_16 + var_138_26 and arg_135_1.time_ < var_138_16 + var_138_26 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play1108106034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1108106034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1108106035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1081ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1081ui_story == nil then
				arg_139_1.var_.characterEffect1081ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1081ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1081ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1081ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1081ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.55

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

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(1108106034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 22
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
	Play1108106035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108106035
		arg_143_1.duration_ = 3

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1108106036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1081ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1081ui_story == nil then
				arg_143_1.var_.characterEffect1081ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1081ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1081ui_story then
				arg_143_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_6 = 0
			local var_146_7 = 0.375

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[202].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(1108106035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 15
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")

						arg_143_1:RecordAudio("1108106035", var_146_15)
						arg_143_1:RecordAudio("1108106035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106035", "story_v_side_new_1108106.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1108106036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1108106036
		arg_147_1.duration_ = 6

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1108106037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.999999998152256

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_1 = 0.3

			if arg_147_1.time_ >= var_150_0 + var_150_1 and arg_147_1.time_ < var_150_0 + var_150_1 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_2 = 0.999999998152256

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				local var_150_3 = manager.ui.mainCamera.transform.localPosition
				local var_150_4 = Vector3.New(0, 0, 10) + Vector3.New(var_150_3.x, var_150_3.y, 0)
				local var_150_5 = arg_147_1.bgs_.ST0401

				var_150_5.transform.localPosition = var_150_4
				var_150_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_6 = var_150_5:GetComponent("SpriteRenderer")

				if var_150_6 and var_150_6.sprite then
					local var_150_7 = (var_150_5.transform.localPosition - var_150_3).z
					local var_150_8 = manager.ui.mainCameraCom_
					local var_150_9 = 2 * var_150_7 * Mathf.Tan(var_150_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_150_10 = var_150_9 * var_150_8.aspect
					local var_150_11 = var_150_6.sprite.bounds.size.x
					local var_150_12 = var_150_6.sprite.bounds.size.y
					local var_150_13 = var_150_10 / var_150_11
					local var_150_14 = var_150_9 / var_150_12
					local var_150_15 = var_150_14 < var_150_13 and var_150_13 or var_150_14

					var_150_5.transform.localScale = Vector3.New(var_150_15, var_150_15, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST0401" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_17 = 1

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Color.New(0, 0, 0)

				var_150_19.a = Mathf.Lerp(0, 1, var_150_18)
				arg_147_1.mask_.color = var_150_19
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				local var_150_20 = Color.New(0, 0, 0)

				var_150_20.a = 1
				arg_147_1.mask_.color = var_150_20
			end

			local var_150_21 = 1

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_22 = 1

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_22 then
				local var_150_23 = (arg_147_1.time_ - var_150_21) / var_150_22
				local var_150_24 = Color.New(0, 0, 0)

				var_150_24.a = Mathf.Lerp(1, 0, var_150_23)
				arg_147_1.mask_.color = var_150_24
			end

			if arg_147_1.time_ >= var_150_21 + var_150_22 and arg_147_1.time_ < var_150_21 + var_150_22 + arg_150_0 then
				local var_150_25 = Color.New(0, 0, 0)
				local var_150_26 = 0

				arg_147_1.mask_.enabled = false
				var_150_25.a = var_150_26
				arg_147_1.mask_.color = var_150_25
			end

			local var_150_27 = arg_147_1.actors_["1081ui_story"].transform
			local var_150_28 = 0.983333331485589

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.var_.moveOldPos1081ui_story = var_150_27.localPosition
			end

			local var_150_29 = 0.001

			if var_150_28 <= arg_147_1.time_ and arg_147_1.time_ < var_150_28 + var_150_29 then
				local var_150_30 = (arg_147_1.time_ - var_150_28) / var_150_29
				local var_150_31 = Vector3.New(0, 100, 0)

				var_150_27.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1081ui_story, var_150_31, var_150_30)

				local var_150_32 = manager.ui.mainCamera.transform.position - var_150_27.position

				var_150_27.forward = Vector3.New(var_150_32.x, var_150_32.y, var_150_32.z)

				local var_150_33 = var_150_27.localEulerAngles

				var_150_33.z = 0
				var_150_33.x = 0
				var_150_27.localEulerAngles = var_150_33
			end

			if arg_147_1.time_ >= var_150_28 + var_150_29 and arg_147_1.time_ < var_150_28 + var_150_29 + arg_150_0 then
				var_150_27.localPosition = Vector3.New(0, 100, 0)

				local var_150_34 = manager.ui.mainCamera.transform.position - var_150_27.position

				var_150_27.forward = Vector3.New(var_150_34.x, var_150_34.y, var_150_34.z)

				local var_150_35 = var_150_27.localEulerAngles

				var_150_35.z = 0
				var_150_35.x = 0
				var_150_27.localEulerAngles = var_150_35
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_36 = 0.999999998152256
			local var_150_37 = 1.425

			if var_150_36 < arg_147_1.time_ and arg_147_1.time_ <= var_150_36 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_38 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_38:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_39 = arg_147_1:GetWordFromCfg(1108106036)
				local var_150_40 = arg_147_1:FormatText(var_150_39.content)

				arg_147_1.text_.text = var_150_40

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_41 = 57
				local var_150_42 = utf8.len(var_150_40)
				local var_150_43 = var_150_41 <= 0 and var_150_37 or var_150_37 * (var_150_42 / var_150_41)

				if var_150_43 > 0 and var_150_37 < var_150_43 then
					arg_147_1.talkMaxDuration = var_150_43
					var_150_36 = var_150_36 + 0.3

					if var_150_43 + var_150_36 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_43 + var_150_36
					end
				end

				arg_147_1.text_.text = var_150_40
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_44 = var_150_36 + 0.3
			local var_150_45 = math.max(var_150_37, arg_147_1.talkMaxDuration)

			if var_150_44 <= arg_147_1.time_ and arg_147_1.time_ < var_150_44 + var_150_45 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_44) / var_150_45

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_44 + var_150_45 and arg_147_1.time_ < var_150_44 + var_150_45 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.983333331485589,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1108106037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1108106037
		arg_153_1.duration_ = 3.93

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1108106038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1081ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1081ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0, -0.92, -5.8)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1081ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1081ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1081ui_story == nil then
				arg_153_1.var_.characterEffect1081ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1081ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1081ui_story then
				arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_15 = 0
			local var_156_16 = 0.725

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[202].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(1108106037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 21
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")

						arg_153_1:RecordAudio("1108106037", var_156_24)
						arg_153_1:RecordAudio("1108106037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106037", "story_v_side_new_1108106.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1108106038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1108106038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1108106039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1081ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1081ui_story == nil then
				arg_157_1.var_.characterEffect1081ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1081ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1081ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1081ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1081ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.25

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_8 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_9 = arg_157_1:GetWordFromCfg(1108106038)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 10
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_7 or var_160_7 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_7 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1108106039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1108106039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1108106040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1081ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1081ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, 100, 0)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1081ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, 100, 0)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = 0
			local var_164_10 = 1.3

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_11 = arg_161_1:GetWordFromCfg(1108106039)
				local var_164_12 = arg_161_1:FormatText(var_164_11.content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 52
				local var_164_14 = utf8.len(var_164_12)
				local var_164_15 = var_164_13 <= 0 and var_164_10 or var_164_10 * (var_164_14 / var_164_13)

				if var_164_15 > 0 and var_164_10 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_9 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_9
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_10, arg_161_1.talkMaxDuration)

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_9) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_9 + var_164_16 and arg_161_1.time_ < var_164_9 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1108106040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1108106040
		arg_165_1.duration_ = 2.4

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1108106041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1081ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1081ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, 100, 0)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1081ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, 100, 0)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = 0
			local var_168_10 = 0.15

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_11 = arg_165_1:FormatText(StoryNameCfg[202].name)

				arg_165_1.leftNameTxt_.text = var_168_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_12 = arg_165_1:GetWordFromCfg(1108106040)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_14 = 6
				local var_168_15 = utf8.len(var_168_13)
				local var_168_16 = var_168_14 <= 0 and var_168_10 or var_168_10 * (var_168_15 / var_168_14)

				if var_168_16 > 0 and var_168_10 < var_168_16 then
					arg_165_1.talkMaxDuration = var_168_16

					if var_168_16 + var_168_9 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_9
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb") ~= 0 then
					local var_168_17 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb") / 1000

					if var_168_17 + var_168_9 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_9
					end

					if var_168_12.prefab_name ~= "" and arg_165_1.actors_[var_168_12.prefab_name] ~= nil then
						local var_168_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_12.prefab_name].transform, "story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")

						arg_165_1:RecordAudio("1108106040", var_168_18)
						arg_165_1:RecordAudio("1108106040", var_168_18)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106040", "story_v_side_new_1108106.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_19 = math.max(var_168_10, arg_165_1.talkMaxDuration)

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_19 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_9) / var_168_19

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_9 + var_168_19 and arg_165_1.time_ < var_168_9 + var_168_19 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1108106041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1108106041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1108106042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(1108106041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 40
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1108106042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108106042
		arg_173_1.duration_ = 1

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				local var_174_0 = iter_174_0 <= 1

				SetActive(iter_174_1.go, var_174_0)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[984].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108106043(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(1108106042, 984)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_1 = 0.5

			if arg_173_1.time_ >= var_176_0 + var_176_1 and arg_173_1.time_ < var_176_0 + var_176_1 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108106043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108106043
		arg_177_1.duration_ = 2.13

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1108106044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = manager.ui.mainCamera.transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = var_180_0.localPosition
			end

			local var_180_2 = 0.466666666666667

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / 0.066
				local var_180_4, var_180_5 = math.modf(var_180_3)

				var_180_0.localPosition = Vector3.New(var_180_5 * 0.13, var_180_5 * 0.13, var_180_5 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = arg_177_1.var_.shakeOldPos
			end

			local var_180_6 = 0
			local var_180_7 = 0.05

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[202].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_9 = arg_177_1:GetWordFromCfg(1108106043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 2
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb") / 1000

					if var_180_14 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_6
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")

						arg_177_1:RecordAudio("1108106043", var_180_15)
						arg_177_1:RecordAudio("1108106043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106043", "story_v_side_new_1108106.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_16 and arg_177_1.time_ < var_180_6 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1108106044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108106044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1108106045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.375

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(1108106044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 55
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108106045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108106045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1108106046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.225

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(1108106045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 49
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108106046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108106046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108106047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_1 = 0.5

			if arg_189_1.time_ >= var_192_0 + var_192_1 and arg_189_1.time_ < var_192_0 + var_192_1 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_2 = 0
			local var_192_3 = 0.75

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(1108106046)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 30
				local var_192_7 = utf8.len(var_192_5)
				local var_192_8 = var_192_6 <= 0 and var_192_3 or var_192_3 * (var_192_7 / var_192_6)

				if var_192_8 > 0 and var_192_3 < var_192_8 then
					arg_189_1.talkMaxDuration = var_192_8

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_9 and arg_189_1.time_ < var_192_2 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1108106047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108106047
		arg_193_1.duration_ = 7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1108106048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 2

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_1 = 0.3

			if arg_193_1.time_ >= var_196_0 + var_196_1 and arg_193_1.time_ < var_196_0 + var_196_1 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_2 = "ST10"

			if arg_193_1.bgs_[var_196_2] == nil then
				local var_196_3 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_2)
				var_196_3.name = var_196_2
				var_196_3.transform.parent = arg_193_1.stage_.transform
				var_196_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_2] = var_196_3
			end

			local var_196_4 = 1

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				local var_196_5 = manager.ui.mainCamera.transform.localPosition
				local var_196_6 = Vector3.New(0, 0, 10) + Vector3.New(var_196_5.x, var_196_5.y, 0)
				local var_196_7 = arg_193_1.bgs_.ST10

				var_196_7.transform.localPosition = var_196_6
				var_196_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_8 = var_196_7:GetComponent("SpriteRenderer")

				if var_196_8 and var_196_8.sprite then
					local var_196_9 = (var_196_7.transform.localPosition - var_196_5).z
					local var_196_10 = manager.ui.mainCameraCom_
					local var_196_11 = 2 * var_196_9 * Mathf.Tan(var_196_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_12 = var_196_11 * var_196_10.aspect
					local var_196_13 = var_196_8.sprite.bounds.size.x
					local var_196_14 = var_196_8.sprite.bounds.size.y
					local var_196_15 = var_196_12 / var_196_13
					local var_196_16 = var_196_11 / var_196_14
					local var_196_17 = var_196_16 < var_196_15 and var_196_15 or var_196_16

					var_196_7.transform.localScale = Vector3.New(var_196_17, var_196_17, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST10" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_18 = 0

			if var_196_18 < arg_193_1.time_ and arg_193_1.time_ <= var_196_18 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_19 = 1

			if var_196_18 <= arg_193_1.time_ and arg_193_1.time_ < var_196_18 + var_196_19 then
				local var_196_20 = (arg_193_1.time_ - var_196_18) / var_196_19
				local var_196_21 = Color.New(0, 0, 0)

				var_196_21.a = Mathf.Lerp(0, 1, var_196_20)
				arg_193_1.mask_.color = var_196_21
			end

			if arg_193_1.time_ >= var_196_18 + var_196_19 and arg_193_1.time_ < var_196_18 + var_196_19 + arg_196_0 then
				local var_196_22 = Color.New(0, 0, 0)

				var_196_22.a = 1
				arg_193_1.mask_.color = var_196_22
			end

			local var_196_23 = 1

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_24 = 1

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_24 then
				local var_196_25 = (arg_193_1.time_ - var_196_23) / var_196_24
				local var_196_26 = Color.New(0, 0, 0)

				var_196_26.a = Mathf.Lerp(1, 0, var_196_25)
				arg_193_1.mask_.color = var_196_26
			end

			if arg_193_1.time_ >= var_196_23 + var_196_24 and arg_193_1.time_ < var_196_23 + var_196_24 + arg_196_0 then
				local var_196_27 = Color.New(0, 0, 0)
				local var_196_28 = 0

				arg_193_1.mask_.enabled = false
				var_196_27.a = var_196_28
				arg_193_1.mask_.color = var_196_27
			end

			local var_196_29 = 1.01666666666667
			local var_196_30 = 1

			if var_196_29 < arg_193_1.time_ and arg_193_1.time_ <= var_196_29 + arg_196_0 then
				local var_196_31 = "stop"
				local var_196_32 = "music"

				arg_193_1:AudioAction(var_196_31, var_196_32, "se_story_133", "se_story_133_sea", "")

				local var_196_33 = ""
				local var_196_34 = manager.audio:GetAudioName("se_story_133", "se_story_133_sea")

				if var_196_34 ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_34 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_34

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_34
						arg_193_1.bgmTxt2_.text = var_196_34
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_35 = 1

			arg_193_1.isInRecall_ = false

			if var_196_35 < arg_193_1.time_ and arg_193_1.time_ <= var_196_35 + arg_196_0 then
				arg_193_1.screenFilterGo_:SetActive(true)

				arg_193_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_196_2, iter_196_3 in pairs(arg_193_1.actors_) do
					local var_196_36 = iter_196_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_196_4, iter_196_5 in ipairs(var_196_36) do
						if iter_196_5.color.r > 0.51 then
							iter_196_5.color = Color.New(1, 1, 1)
						else
							iter_196_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_196_37 = 0.0166666666666667

			if var_196_35 <= arg_193_1.time_ and arg_193_1.time_ < var_196_35 + var_196_37 then
				local var_196_38 = (arg_193_1.time_ - var_196_35) / var_196_37

				arg_193_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_196_38)
			end

			if arg_193_1.time_ >= var_196_35 + var_196_37 and arg_193_1.time_ < var_196_35 + var_196_37 + arg_196_0 then
				arg_193_1.screenFilterEffect_.weight = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_39 = 2
			local var_196_40 = 1.1

			if var_196_39 < arg_193_1.time_ and arg_193_1.time_ <= var_196_39 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_41 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_41:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_193_1.dialogCg_.alpha = arg_198_0
				end))
				var_196_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_42 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_43 = arg_193_1:GetWordFromCfg(1108106047)
				local var_196_44 = arg_193_1:FormatText(var_196_43.content)

				arg_193_1.text_.text = var_196_44

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_45 = 19
				local var_196_46 = utf8.len(var_196_44)
				local var_196_47 = var_196_45 <= 0 and var_196_40 or var_196_40 * (var_196_46 / var_196_45)

				if var_196_47 > 0 and var_196_40 < var_196_47 then
					arg_193_1.talkMaxDuration = var_196_47
					var_196_39 = var_196_39 + 0.3

					if var_196_47 + var_196_39 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_47 + var_196_39
					end
				end

				arg_193_1.text_.text = var_196_44
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_48 = var_196_39 + 0.3
			local var_196_49 = math.max(var_196_40, arg_193_1.talkMaxDuration)

			if var_196_48 <= arg_193_1.time_ and arg_193_1.time_ < var_196_48 + var_196_49 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_48) / var_196_49

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_48 + var_196_49 and arg_193_1.time_ < var_196_48 + var_196_49 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1108106048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108106048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108106049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.4

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(1108106048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 16
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_8 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_8 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_8

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_8 and arg_200_1.time_ < var_203_0 + var_203_8 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1108106049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108106049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108106050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.5

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

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(1108106049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 20
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
	Play1108106050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108106050
		arg_208_1.duration_ = 7

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108106051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 2

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_1 = 1

			if arg_208_1.time_ >= var_211_0 + var_211_1 and arg_208_1.time_ < var_211_0 + var_211_1 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_2 = 1

			if var_211_2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				local var_211_3 = manager.ui.mainCamera.transform.localPosition
				local var_211_4 = Vector3.New(0, 0, 10) + Vector3.New(var_211_3.x, var_211_3.y, 0)
				local var_211_5 = arg_208_1.bgs_.ST0401

				var_211_5.transform.localPosition = var_211_4
				var_211_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_6 = var_211_5:GetComponent("SpriteRenderer")

				if var_211_6 and var_211_6.sprite then
					local var_211_7 = (var_211_5.transform.localPosition - var_211_3).z
					local var_211_8 = manager.ui.mainCameraCom_
					local var_211_9 = 2 * var_211_7 * Mathf.Tan(var_211_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_211_10 = var_211_9 * var_211_8.aspect
					local var_211_11 = var_211_6.sprite.bounds.size.x
					local var_211_12 = var_211_6.sprite.bounds.size.y
					local var_211_13 = var_211_10 / var_211_11
					local var_211_14 = var_211_9 / var_211_12
					local var_211_15 = var_211_14 < var_211_13 and var_211_13 or var_211_14

					var_211_5.transform.localScale = Vector3.New(var_211_15, var_211_15, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST0401" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_16 = 1

			arg_208_1.isInRecall_ = false

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.screenFilterGo_:SetActive(false)

				for iter_211_2, iter_211_3 in pairs(arg_208_1.actors_) do
					local var_211_17 = iter_211_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_211_4, iter_211_5 in ipairs(var_211_17) do
						if iter_211_5.color.r > 0.51 then
							iter_211_5.color = Color.New(1, 1, 1)
						else
							iter_211_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_211_18 = 0.0166666666666667

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_18 then
				local var_211_19 = (arg_208_1.time_ - var_211_16) / var_211_18

				arg_208_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_211_19)
			end

			if arg_208_1.time_ >= var_211_16 + var_211_18 and arg_208_1.time_ < var_211_16 + var_211_18 + arg_211_0 then
				arg_208_1.screenFilterEffect_.weight = 0
			end

			local var_211_20 = 0

			if var_211_20 < arg_208_1.time_ and arg_208_1.time_ <= var_211_20 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_21 = 1

			if var_211_20 <= arg_208_1.time_ and arg_208_1.time_ < var_211_20 + var_211_21 then
				local var_211_22 = (arg_208_1.time_ - var_211_20) / var_211_21
				local var_211_23 = Color.New(0, 0, 0)

				var_211_23.a = Mathf.Lerp(0, 1, var_211_22)
				arg_208_1.mask_.color = var_211_23
			end

			if arg_208_1.time_ >= var_211_20 + var_211_21 and arg_208_1.time_ < var_211_20 + var_211_21 + arg_211_0 then
				local var_211_24 = Color.New(0, 0, 0)

				var_211_24.a = 1
				arg_208_1.mask_.color = var_211_24
			end

			local var_211_25 = 1

			if var_211_25 < arg_208_1.time_ and arg_208_1.time_ <= var_211_25 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_26 = 1

			if var_211_25 <= arg_208_1.time_ and arg_208_1.time_ < var_211_25 + var_211_26 then
				local var_211_27 = (arg_208_1.time_ - var_211_25) / var_211_26
				local var_211_28 = Color.New(0, 0, 0)

				var_211_28.a = Mathf.Lerp(1, 0, var_211_27)
				arg_208_1.mask_.color = var_211_28
			end

			if arg_208_1.time_ >= var_211_25 + var_211_26 and arg_208_1.time_ < var_211_25 + var_211_26 + arg_211_0 then
				local var_211_29 = Color.New(0, 0, 0)
				local var_211_30 = 0

				arg_208_1.mask_.enabled = false
				var_211_29.a = var_211_30
				arg_208_1.mask_.color = var_211_29
			end

			local var_211_31 = 0
			local var_211_32 = 1.43333333333333

			if var_211_31 < arg_208_1.time_ and arg_208_1.time_ <= var_211_31 + arg_211_0 then
				local var_211_33 = "play"
				local var_211_34 = "effect"

				arg_208_1:AudioAction(var_211_33, var_211_34, "se_story_133", "se_story_133_sea", "")
			end

			local var_211_35 = 0.983333333333333

			arg_208_1.isInRecall_ = false

			if var_211_35 < arg_208_1.time_ and arg_208_1.time_ <= var_211_35 + arg_211_0 then
				arg_208_1.screenFilterGo_:SetActive(false)

				for iter_211_6, iter_211_7 in pairs(arg_208_1.actors_) do
					local var_211_36 = iter_211_7:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_211_8, iter_211_9 in ipairs(var_211_36) do
						if iter_211_9.color.r > 0.51 then
							iter_211_9.color = Color.New(1, 1, 1)
						else
							iter_211_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_211_37 = 0.0166666666666667

			if var_211_35 <= arg_208_1.time_ and arg_208_1.time_ < var_211_35 + var_211_37 then
				local var_211_38 = (arg_208_1.time_ - var_211_35) / var_211_37

				arg_208_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_211_38)
			end

			if arg_208_1.time_ >= var_211_35 + var_211_37 and arg_208_1.time_ < var_211_35 + var_211_37 + arg_211_0 then
				arg_208_1.screenFilterEffect_.weight = 0
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_39 = 2
			local var_211_40 = 1.4

			if var_211_39 < arg_208_1.time_ and arg_208_1.time_ <= var_211_39 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_41 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_41:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_42 = arg_208_1:GetWordFromCfg(1108106050)
				local var_211_43 = arg_208_1:FormatText(var_211_42.content)

				arg_208_1.text_.text = var_211_43

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_44 = 56
				local var_211_45 = utf8.len(var_211_43)
				local var_211_46 = var_211_44 <= 0 and var_211_40 or var_211_40 * (var_211_45 / var_211_44)

				if var_211_46 > 0 and var_211_40 < var_211_46 then
					arg_208_1.talkMaxDuration = var_211_46
					var_211_39 = var_211_39 + 0.3

					if var_211_46 + var_211_39 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_46 + var_211_39
					end
				end

				arg_208_1.text_.text = var_211_43
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_47 = var_211_39 + 0.3
			local var_211_48 = math.max(var_211_40, arg_208_1.talkMaxDuration)

			if var_211_47 <= arg_208_1.time_ and arg_208_1.time_ < var_211_47 + var_211_48 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_47) / var_211_48

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_47 + var_211_48 and arg_208_1.time_ < var_211_47 + var_211_48 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108106051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1108106051
		arg_214_1.duration_ = 1.47

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1108106052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.166666666666667

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				local var_217_2 = "play"
				local var_217_3 = "effect"

				arg_214_1:AudioAction(var_217_2, var_217_3, "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_217_4 = 0
			local var_217_5 = 0.15

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_6 = arg_214_1:FormatText(StoryNameCfg[202].name)

				arg_214_1.leftNameTxt_.text = var_217_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_7 = arg_214_1:GetWordFromCfg(1108106051)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 6
				local var_217_10 = utf8.len(var_217_8)
				local var_217_11 = var_217_9 <= 0 and var_217_5 or var_217_5 * (var_217_10 / var_217_9)

				if var_217_11 > 0 and var_217_5 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb") / 1000

					if var_217_12 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_4
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")

						arg_214_1:RecordAudio("1108106051", var_217_13)
						arg_214_1:RecordAudio("1108106051", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106051", "story_v_side_new_1108106.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_14 and arg_214_1.time_ < var_217_4 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1108106052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1108106052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1108106053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.85

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_2 = arg_218_1:GetWordFromCfg(1108106052)
				local var_221_3 = arg_218_1:FormatText(var_221_2.content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 34
				local var_221_5 = utf8.len(var_221_3)
				local var_221_6 = var_221_4 <= 0 and var_221_1 or var_221_1 * (var_221_5 / var_221_4)

				if var_221_6 > 0 and var_221_1 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_7 and arg_218_1.time_ < var_221_0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1108106053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108106053
		arg_222_1.duration_ = 4.52

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108106054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.75

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			local var_225_1 = 0.0833333333333335

			if arg_222_1.time_ >= var_225_0 + var_225_1 and arg_222_1.time_ < var_225_0 + var_225_1 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_2 = "STblack"

			if arg_222_1.bgs_[var_225_2] == nil then
				local var_225_3 = Object.Instantiate(arg_222_1.paintGo_)

				var_225_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_225_2)
				var_225_3.name = var_225_2
				var_225_3.transform.parent = arg_222_1.stage_.transform
				var_225_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_222_1.bgs_[var_225_2] = var_225_3
			end

			local var_225_4 = 1

			if var_225_4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				local var_225_5 = manager.ui.mainCamera.transform.localPosition
				local var_225_6 = Vector3.New(0, 0, 10) + Vector3.New(var_225_5.x, var_225_5.y, 0)
				local var_225_7 = arg_222_1.bgs_.STblack

				var_225_7.transform.localPosition = var_225_6
				var_225_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_8 = var_225_7:GetComponent("SpriteRenderer")

				if var_225_8 and var_225_8.sprite then
					local var_225_9 = (var_225_7.transform.localPosition - var_225_5).z
					local var_225_10 = manager.ui.mainCameraCom_
					local var_225_11 = 2 * var_225_9 * Mathf.Tan(var_225_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_225_12 = var_225_11 * var_225_10.aspect
					local var_225_13 = var_225_8.sprite.bounds.size.x
					local var_225_14 = var_225_8.sprite.bounds.size.y
					local var_225_15 = var_225_12 / var_225_13
					local var_225_16 = var_225_11 / var_225_14
					local var_225_17 = var_225_16 < var_225_15 and var_225_15 or var_225_16

					var_225_7.transform.localScale = Vector3.New(var_225_17, var_225_17, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "STblack" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_18 = 0

			if var_225_18 < arg_222_1.time_ and arg_222_1.time_ <= var_225_18 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_19 = 1

			if var_225_18 <= arg_222_1.time_ and arg_222_1.time_ < var_225_18 + var_225_19 then
				local var_225_20 = (arg_222_1.time_ - var_225_18) / var_225_19
				local var_225_21 = Color.New(0, 0, 0)

				var_225_21.a = Mathf.Lerp(0, 1, var_225_20)
				arg_222_1.mask_.color = var_225_21
			end

			if arg_222_1.time_ >= var_225_18 + var_225_19 and arg_222_1.time_ < var_225_18 + var_225_19 + arg_225_0 then
				local var_225_22 = Color.New(0, 0, 0)

				var_225_22.a = 1
				arg_222_1.mask_.color = var_225_22
			end

			local var_225_23 = 1

			if var_225_23 < arg_222_1.time_ and arg_222_1.time_ <= var_225_23 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_24 = 1

			if var_225_23 <= arg_222_1.time_ and arg_222_1.time_ < var_225_23 + var_225_24 then
				local var_225_25 = (arg_222_1.time_ - var_225_23) / var_225_24
				local var_225_26 = Color.New(0, 0, 0)

				var_225_26.a = Mathf.Lerp(1, 0, var_225_25)
				arg_222_1.mask_.color = var_225_26
			end

			if arg_222_1.time_ >= var_225_23 + var_225_24 and arg_222_1.time_ < var_225_23 + var_225_24 + arg_225_0 then
				local var_225_27 = Color.New(0, 0, 0)
				local var_225_28 = 0

				arg_222_1.mask_.enabled = false
				var_225_27.a = var_225_28
				arg_222_1.mask_.color = var_225_27
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_29 = 1.75
			local var_225_30 = 0.25

			if var_225_29 < arg_222_1.time_ and arg_222_1.time_ <= var_225_29 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_31 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_31:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_32 = arg_222_1:FormatText(StoryNameCfg[202].name)

				arg_222_1.leftNameTxt_.text = var_225_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_33 = arg_222_1:GetWordFromCfg(1108106053)
				local var_225_34 = arg_222_1:FormatText(var_225_33.content)

				arg_222_1.text_.text = var_225_34

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_35 = 10
				local var_225_36 = utf8.len(var_225_34)
				local var_225_37 = var_225_35 <= 0 and var_225_30 or var_225_30 * (var_225_36 / var_225_35)

				if var_225_37 > 0 and var_225_30 < var_225_37 then
					arg_222_1.talkMaxDuration = var_225_37
					var_225_29 = var_225_29 + 0.3

					if var_225_37 + var_225_29 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_37 + var_225_29
					end
				end

				arg_222_1.text_.text = var_225_34
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb") ~= 0 then
					local var_225_38 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb") / 1000

					if var_225_38 + var_225_29 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_38 + var_225_29
					end

					if var_225_33.prefab_name ~= "" and arg_222_1.actors_[var_225_33.prefab_name] ~= nil then
						local var_225_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_33.prefab_name].transform, "story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")

						arg_222_1:RecordAudio("1108106053", var_225_39)
						arg_222_1:RecordAudio("1108106053", var_225_39)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106053", "story_v_side_new_1108106.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_40 = var_225_29 + 0.3
			local var_225_41 = math.max(var_225_30, arg_222_1.talkMaxDuration)

			if var_225_40 <= arg_222_1.time_ and arg_222_1.time_ < var_225_40 + var_225_41 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_40) / var_225_41

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_40 + var_225_41 and arg_222_1.time_ < var_225_40 + var_225_41 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108106054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1108106054
		arg_228_1.duration_ = 4.97

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1108106055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 0.45

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[202].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(1108106054)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 18
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb") / 1000

					if var_231_8 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_0
					end

					if var_231_3.prefab_name ~= "" and arg_228_1.actors_[var_231_3.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_3.prefab_name].transform, "story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")

						arg_228_1:RecordAudio("1108106054", var_231_9)
						arg_228_1:RecordAudio("1108106054", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106054", "story_v_side_new_1108106.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_10 and arg_228_1.time_ < var_231_0 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1108106055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1108106055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1108106056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.166666666666667

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				local var_235_2 = "play"
				local var_235_3 = "music"

				arg_232_1:AudioAction(var_235_2, var_235_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_235_4 = ""
				local var_235_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_235_5 ~= "" then
					if arg_232_1.bgmTxt_.text ~= var_235_5 and arg_232_1.bgmTxt_.text ~= "" then
						if arg_232_1.bgmTxt2_.text ~= "" then
							arg_232_1.bgmTxt_.text = arg_232_1.bgmTxt2_.text
						end

						arg_232_1.bgmTxt2_.text = var_235_5

						arg_232_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_232_1.bgmTxt_.text = var_235_5
						arg_232_1.bgmTxt2_.text = var_235_5
					end

					if arg_232_1.bgmTimer then
						arg_232_1.bgmTimer:Stop()

						arg_232_1.bgmTimer = nil
					end

					if arg_232_1.settingData.show_music_name == 1 then
						arg_232_1.musicController:SetSelectedState("show")
						arg_232_1.musicAnimator_:Play("open", 0, 0)

						if arg_232_1.settingData.music_time ~= 0 then
							arg_232_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_232_1.settingData.music_time), function()
								if arg_232_1 == nil or isNil(arg_232_1.bgmTxt_) then
									return
								end

								arg_232_1.musicController:SetSelectedState("hide")
								arg_232_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_235_6 = 0
			local var_235_7 = 1

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				local var_235_8 = "play"
				local var_235_9 = "effect"

				arg_232_1:AudioAction(var_235_8, var_235_9, "se_story_side_1081", "se_story_side_1081_bubble", "")
			end

			local var_235_10 = 0.425
			local var_235_11 = 0.575

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				local var_235_12 = "stop"
				local var_235_13 = "effect"

				arg_232_1:AudioAction(var_235_12, var_235_13, "se_story_133", "se_story_133_sea", "")
			end

			local var_235_14 = 0
			local var_235_15 = 0.575

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_16 = arg_232_1:GetWordFromCfg(1108106055)
				local var_235_17 = arg_232_1:FormatText(var_235_16.content)

				arg_232_1.text_.text = var_235_17

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_18 = 23
				local var_235_19 = utf8.len(var_235_17)
				local var_235_20 = var_235_18 <= 0 and var_235_15 or var_235_15 * (var_235_19 / var_235_18)

				if var_235_20 > 0 and var_235_15 < var_235_20 then
					arg_232_1.talkMaxDuration = var_235_20

					if var_235_20 + var_235_14 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_20 + var_235_14
					end
				end

				arg_232_1.text_.text = var_235_17
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_21 = math.max(var_235_15, arg_232_1.talkMaxDuration)

			if var_235_14 <= arg_232_1.time_ and arg_232_1.time_ < var_235_14 + var_235_21 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_14) / var_235_21

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_14 + var_235_21 and arg_232_1.time_ < var_235_14 + var_235_21 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1108106056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108106056
		arg_237_1.duration_ = 1

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"

			SetActive(arg_237_1.choicesGo_, true)

			for iter_238_0, iter_238_1 in ipairs(arg_237_1.choices_) do
				local var_238_0 = iter_238_0 <= 1

				SetActive(iter_238_1.go, var_238_0)
			end

			arg_237_1.choices_[1].txt.text = arg_237_1:FormatText(StoryChoiceCfg[985].name)
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108106057(arg_237_1)
			end

			arg_237_1:RecordChoiceLog(1108106056, 985)
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			return
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108106057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108106057
		arg_241_1.duration_ = 7.33

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1108106058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.4

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[202].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(1108106057)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 16
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")

						arg_241_1:RecordAudio("1108106057", var_244_9)
						arg_241_1:RecordAudio("1108106057", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106057", "story_v_side_new_1108106.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1108106058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108106058
		arg_245_1.duration_ = 3.3

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108106059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.275

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[202].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(1108106058)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 11
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")

						arg_245_1:RecordAudio("1108106058", var_248_9)
						arg_245_1:RecordAudio("1108106058", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106058", "story_v_side_new_1108106.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1108106059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108106059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108106060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.125

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(1108106059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 5
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1108106060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108106060
		arg_253_1.duration_ = 6.67

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1108106061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.66666666666667

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			local var_256_1 = 0.3

			if arg_253_1.time_ >= var_256_0 + var_256_1 and arg_253_1.time_ < var_256_0 + var_256_1 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_2 = "H01b"

			if arg_253_1.bgs_[var_256_2] == nil then
				local var_256_3 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_256_2)
				var_256_3.name = var_256_2
				var_256_3.transform.parent = arg_253_1.stage_.transform
				var_256_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_[var_256_2] = var_256_3
			end

			local var_256_4 = 1

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				local var_256_5 = manager.ui.mainCamera.transform.localPosition
				local var_256_6 = Vector3.New(0, 0, 10) + Vector3.New(var_256_5.x, var_256_5.y, 0)
				local var_256_7 = arg_253_1.bgs_.H01b

				var_256_7.transform.localPosition = var_256_6
				var_256_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_8 = var_256_7:GetComponent("SpriteRenderer")

				if var_256_8 and var_256_8.sprite then
					local var_256_9 = (var_256_7.transform.localPosition - var_256_5).z
					local var_256_10 = manager.ui.mainCameraCom_
					local var_256_11 = 2 * var_256_9 * Mathf.Tan(var_256_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_256_12 = var_256_11 * var_256_10.aspect
					local var_256_13 = var_256_8.sprite.bounds.size.x
					local var_256_14 = var_256_8.sprite.bounds.size.y
					local var_256_15 = var_256_12 / var_256_13
					local var_256_16 = var_256_11 / var_256_14
					local var_256_17 = var_256_16 < var_256_15 and var_256_15 or var_256_16

					var_256_7.transform.localScale = Vector3.New(var_256_17, var_256_17, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "H01b" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_18 = 0

			if var_256_18 < arg_253_1.time_ and arg_253_1.time_ <= var_256_18 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_19 = 1

			if var_256_18 <= arg_253_1.time_ and arg_253_1.time_ < var_256_18 + var_256_19 then
				local var_256_20 = (arg_253_1.time_ - var_256_18) / var_256_19
				local var_256_21 = Color.New(0, 0, 0)

				var_256_21.a = Mathf.Lerp(0, 1, var_256_20)
				arg_253_1.mask_.color = var_256_21
			end

			if arg_253_1.time_ >= var_256_18 + var_256_19 and arg_253_1.time_ < var_256_18 + var_256_19 + arg_256_0 then
				local var_256_22 = Color.New(0, 0, 0)

				var_256_22.a = 1
				arg_253_1.mask_.color = var_256_22
			end

			local var_256_23 = 1

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_24 = 0.966666666666667

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_24 then
				local var_256_25 = (arg_253_1.time_ - var_256_23) / var_256_24
				local var_256_26 = Color.New(0, 0, 0)

				var_256_26.a = Mathf.Lerp(1, 0, var_256_25)
				arg_253_1.mask_.color = var_256_26
			end

			if arg_253_1.time_ >= var_256_23 + var_256_24 and arg_253_1.time_ < var_256_23 + var_256_24 + arg_256_0 then
				local var_256_27 = Color.New(0, 0, 0)
				local var_256_28 = 0

				arg_253_1.mask_.enabled = false
				var_256_27.a = var_256_28
				arg_253_1.mask_.color = var_256_27
			end

			local var_256_29 = arg_253_1.actors_["1081ui_story"].transform
			local var_256_30 = 0.983333333333333

			if var_256_30 < arg_253_1.time_ and arg_253_1.time_ <= var_256_30 + arg_256_0 then
				arg_253_1.var_.moveOldPos1081ui_story = var_256_29.localPosition
			end

			local var_256_31 = 0.001

			if var_256_30 <= arg_253_1.time_ and arg_253_1.time_ < var_256_30 + var_256_31 then
				local var_256_32 = (arg_253_1.time_ - var_256_30) / var_256_31
				local var_256_33 = Vector3.New(0, 100, 0)

				var_256_29.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1081ui_story, var_256_33, var_256_32)

				local var_256_34 = manager.ui.mainCamera.transform.position - var_256_29.position

				var_256_29.forward = Vector3.New(var_256_34.x, var_256_34.y, var_256_34.z)

				local var_256_35 = var_256_29.localEulerAngles

				var_256_35.z = 0
				var_256_35.x = 0
				var_256_29.localEulerAngles = var_256_35
			end

			if arg_253_1.time_ >= var_256_30 + var_256_31 and arg_253_1.time_ < var_256_30 + var_256_31 + arg_256_0 then
				var_256_29.localPosition = Vector3.New(0, 100, 0)

				local var_256_36 = manager.ui.mainCamera.transform.position - var_256_29.position

				var_256_29.forward = Vector3.New(var_256_36.x, var_256_36.y, var_256_36.z)

				local var_256_37 = var_256_29.localEulerAngles

				var_256_37.z = 0
				var_256_37.x = 0
				var_256_29.localEulerAngles = var_256_37
			end

			local var_256_38 = 0
			local var_256_39 = 0.166666666666667

			if var_256_38 < arg_253_1.time_ and arg_253_1.time_ <= var_256_38 + arg_256_0 then
				local var_256_40 = "play"
				local var_256_41 = "music"

				arg_253_1:AudioAction(var_256_40, var_256_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_256_42 = ""
				local var_256_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_256_43 ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_43 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_43

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_43
						arg_253_1.bgmTxt2_.text = var_256_43
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_256_44 = 0.3
			local var_256_45 = 1

			if var_256_44 < arg_253_1.time_ and arg_253_1.time_ <= var_256_44 + arg_256_0 then
				local var_256_46 = "play"
				local var_256_47 = "music"

				arg_253_1:AudioAction(var_256_46, var_256_47, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_256_48 = ""
				local var_256_49 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_256_49 ~= "" then
					if arg_253_1.bgmTxt_.text ~= var_256_49 and arg_253_1.bgmTxt_.text ~= "" then
						if arg_253_1.bgmTxt2_.text ~= "" then
							arg_253_1.bgmTxt_.text = arg_253_1.bgmTxt2_.text
						end

						arg_253_1.bgmTxt2_.text = var_256_49

						arg_253_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_253_1.bgmTxt_.text = var_256_49
						arg_253_1.bgmTxt2_.text = var_256_49
					end

					if arg_253_1.bgmTimer then
						arg_253_1.bgmTimer:Stop()

						arg_253_1.bgmTimer = nil
					end

					if arg_253_1.settingData.show_music_name == 1 then
						arg_253_1.musicController:SetSelectedState("show")
						arg_253_1.musicAnimator_:Play("open", 0, 0)

						if arg_253_1.settingData.music_time ~= 0 then
							arg_253_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_253_1.settingData.music_time), function()
								if arg_253_1 == nil or isNil(arg_253_1.bgmTxt_) then
									return
								end

								arg_253_1.musicController:SetSelectedState("hide")
								arg_253_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_256_50 = 0
			local var_256_51 = 0.166666666666667

			if var_256_50 < arg_253_1.time_ and arg_253_1.time_ <= var_256_50 + arg_256_0 then
				local var_256_52 = "play"
				local var_256_53 = "effect"

				arg_253_1:AudioAction(var_256_52, var_256_53, "se_story_123_01", "se_story_123_01_flame1", "")
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_54 = 1.66666666666667
			local var_256_55 = 1.65

			if var_256_54 < arg_253_1.time_ and arg_253_1.time_ <= var_256_54 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_56 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_56:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_253_1.dialogCg_.alpha = arg_259_0
				end))
				var_256_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_57 = arg_253_1:GetWordFromCfg(1108106060)
				local var_256_58 = arg_253_1:FormatText(var_256_57.content)

				arg_253_1.text_.text = var_256_58

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_59 = 66
				local var_256_60 = utf8.len(var_256_58)
				local var_256_61 = var_256_59 <= 0 and var_256_55 or var_256_55 * (var_256_60 / var_256_59)

				if var_256_61 > 0 and var_256_55 < var_256_61 then
					arg_253_1.talkMaxDuration = var_256_61
					var_256_54 = var_256_54 + 0.3

					if var_256_61 + var_256_54 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_61 + var_256_54
					end
				end

				arg_253_1.text_.text = var_256_58
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_62 = var_256_54 + 0.3
			local var_256_63 = math.max(var_256_55, arg_253_1.talkMaxDuration)

			if var_256_62 <= arg_253_1.time_ and arg_253_1.time_ < var_256_62 + var_256_63 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_62) / var_256_63

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_62 + var_256_63 and arg_253_1.time_ < var_256_62 + var_256_63 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.983333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1108106061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108106061
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1108106062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 1.1

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_2 = arg_261_1:GetWordFromCfg(1108106061)
				local var_264_3 = arg_261_1:FormatText(var_264_2.content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 44
				local var_264_5 = utf8.len(var_264_3)
				local var_264_6 = var_264_4 <= 0 and var_264_1 or var_264_1 * (var_264_5 / var_264_4)

				if var_264_6 > 0 and var_264_1 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_7 and arg_261_1.time_ < var_264_0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1108106062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108106062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108106063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.275

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(1108106062)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 51
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_7 and arg_265_1.time_ < var_268_0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1108106063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108106063
		arg_269_1.duration_ = 5.57

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108106064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1081ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1081ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -0.92, -5.8)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1081ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1081ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1081ui_story == nil then
				arg_269_1.var_.characterEffect1081ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1081ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1081ui_story then
				arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_15 = 0
			local var_272_16 = 0.55

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[202].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(1108106063)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 22
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")

						arg_269_1:RecordAudio("1108106063", var_272_24)
						arg_269_1:RecordAudio("1108106063", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106063", "story_v_side_new_1108106.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1108106064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108106064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108106065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1081ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1081ui_story == nil then
				arg_273_1.var_.characterEffect1081ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.0333333333333333

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1081ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1081ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1081ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1081ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 1.2

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(1108106064)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 48
				local var_276_11 = utf8.len(var_276_9)
				local var_276_12 = var_276_10 <= 0 and var_276_7 or var_276_7 * (var_276_11 / var_276_10)

				if var_276_12 > 0 and var_276_7 < var_276_12 then
					arg_273_1.talkMaxDuration = var_276_12

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_13 and arg_273_1.time_ < var_276_6 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1108106065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108106065
		arg_277_1.duration_ = 4.8

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108106066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1081ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1081ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, -0.92, -5.8)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1081ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1081ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1081ui_story == nil then
				arg_277_1.var_.characterEffect1081ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1081ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1081ui_story then
				arg_277_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_280_15 = 0
			local var_280_16 = 0.55

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[202].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(1108106065)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 22
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")

						arg_277_1:RecordAudio("1108106065", var_280_24)
						arg_277_1:RecordAudio("1108106065", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106065", "story_v_side_new_1108106.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108106066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1108106066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1108106067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1081ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1081ui_story == nil then
				arg_281_1.var_.characterEffect1081ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.0333333333333333

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1081ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1081ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1081ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1081ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_284_7 = 0
			local var_284_8 = 0.1

			if var_284_7 < arg_281_1.time_ and arg_281_1.time_ <= var_284_7 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_9 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_10 = arg_281_1:GetWordFromCfg(1108106066)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_12 = 4
				local var_284_13 = utf8.len(var_284_11)
				local var_284_14 = var_284_12 <= 0 and var_284_8 or var_284_8 * (var_284_13 / var_284_12)

				if var_284_14 > 0 and var_284_8 < var_284_14 then
					arg_281_1.talkMaxDuration = var_284_14

					if var_284_14 + var_284_7 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_7
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_15 = math.max(var_284_8, arg_281_1.talkMaxDuration)

			if var_284_7 <= arg_281_1.time_ and arg_281_1.time_ < var_284_7 + var_284_15 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_7) / var_284_15

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_7 + var_284_15 and arg_281_1.time_ < var_284_7 + var_284_15 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1108106067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1108106067
		arg_285_1.duration_ = 4.83

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1108106068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_288_2 = arg_285_1.actors_["1081ui_story"]
			local var_288_3 = 0

			if var_288_3 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1081ui_story == nil then
				arg_285_1.var_.characterEffect1081ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_4 = 0.2

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_4 and not isNil(var_288_2) then
				local var_288_5 = (arg_285_1.time_ - var_288_3) / var_288_4

				if arg_285_1.var_.characterEffect1081ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_3 + var_288_4 and arg_285_1.time_ < var_288_3 + var_288_4 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1081ui_story then
				arg_285_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_288_6 = 0
			local var_288_7 = 0.55

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[202].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_9 = arg_285_1:GetWordFromCfg(1108106067)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 22
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb") / 1000

					if var_288_14 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_6
					end

					if var_288_9.prefab_name ~= "" and arg_285_1.actors_[var_288_9.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_9.prefab_name].transform, "story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")

						arg_285_1:RecordAudio("1108106067", var_288_15)
						arg_285_1:RecordAudio("1108106067", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106067", "story_v_side_new_1108106.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_16 and arg_285_1.time_ < var_288_6 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1108106068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1108106068
		arg_289_1.duration_ = 1

		SetActive(arg_289_1.tipsGo_, true)

		arg_289_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"

			SetActive(arg_289_1.choicesGo_, true)

			for iter_290_0, iter_290_1 in ipairs(arg_289_1.choices_) do
				local var_290_0 = iter_290_0 <= 2

				SetActive(iter_290_1.go, var_290_0)
			end

			arg_289_1.choices_[1].txt.text = arg_289_1:FormatText(StoryChoiceCfg[986].name)
			arg_289_1.choices_[2].txt.text = arg_289_1:FormatText(StoryChoiceCfg[987].name)
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1108106069(arg_289_1)
			end

			if arg_291_0 == 2 then
				PlayerAction.UseStoryTrigger(1081012, 210810106, 1108106068, 2)
				arg_289_0:Play1108106069(arg_289_1)
			end

			arg_289_1:RecordChoiceLog(1108106068, 986, 987)
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			return
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1108106069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108106069
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1108106070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1081ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1081ui_story == nil then
				arg_293_1.var_.characterEffect1081ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1081ui_story and not isNil(var_296_0) then
					local var_296_4 = Mathf.Lerp(0, 0.5, var_296_3)

					arg_293_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1081ui_story.fillRatio = var_296_4
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1081ui_story then
				local var_296_5 = 0.5

				arg_293_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1081ui_story.fillRatio = var_296_5
			end

			local var_296_6 = 0
			local var_296_7 = 0.625

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

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_9 = arg_293_1:GetWordFromCfg(1108106069)
				local var_296_10 = arg_293_1:FormatText(var_296_9.content)

				arg_293_1.text_.text = var_296_10

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 25
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
	Play1108106070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1108106070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1108106071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.475

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(1108106070)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 19
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1108106071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1108106071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1108106072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_304_1 = 0
			local var_304_2 = 0.525

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(1108106071)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 21
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_2 or var_304_2 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_2 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_8 and arg_301_1.time_ < var_304_1 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1108106072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1108106072
		arg_305_1.duration_ = 3.33

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1108106073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_308_1 = arg_305_1.actors_["1081ui_story"]
			local var_308_2 = 0

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1081ui_story == nil then
				arg_305_1.var_.characterEffect1081ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_3 = 0.2

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_3 and not isNil(var_308_1) then
				local var_308_4 = (arg_305_1.time_ - var_308_2) / var_308_3

				if arg_305_1.var_.characterEffect1081ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_2 + var_308_3 and arg_305_1.time_ < var_308_2 + var_308_3 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1081ui_story then
				arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_308_5 = 0
			local var_308_6 = 0.425

			if var_308_5 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_7 = arg_305_1:FormatText(StoryNameCfg[202].name)

				arg_305_1.leftNameTxt_.text = var_308_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_8 = arg_305_1:GetWordFromCfg(1108106072)
				local var_308_9 = arg_305_1:FormatText(var_308_8.content)

				arg_305_1.text_.text = var_308_9

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 17
				local var_308_11 = utf8.len(var_308_9)
				local var_308_12 = var_308_10 <= 0 and var_308_6 or var_308_6 * (var_308_11 / var_308_10)

				if var_308_12 > 0 and var_308_6 < var_308_12 then
					arg_305_1.talkMaxDuration = var_308_12

					if var_308_12 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_12 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_9
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb") ~= 0 then
					local var_308_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb") / 1000

					if var_308_13 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_5
					end

					if var_308_8.prefab_name ~= "" and arg_305_1.actors_[var_308_8.prefab_name] ~= nil then
						local var_308_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_8.prefab_name].transform, "story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")

						arg_305_1:RecordAudio("1108106072", var_308_14)
						arg_305_1:RecordAudio("1108106072", var_308_14)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106072", "story_v_side_new_1108106.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_15 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_15 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_15

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_15 and arg_305_1.time_ < var_308_5 + var_308_15 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1108106073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1108106073
		arg_309_1.duration_ = 2.83

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1108106074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_312_1 = 0
			local var_312_2 = 0.35

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_3 = arg_309_1:FormatText(StoryNameCfg[202].name)

				arg_309_1.leftNameTxt_.text = var_312_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(1108106073)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb") ~= 0 then
					local var_312_9 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb") / 1000

					if var_312_9 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_1
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")

						arg_309_1:RecordAudio("1108106073", var_312_10)
						arg_309_1:RecordAudio("1108106073", var_312_10)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106073", "story_v_side_new_1108106.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_11 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_11 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_11

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_11 and arg_309_1.time_ < var_312_1 + var_312_11 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1108106074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108106074
		arg_313_1.duration_ = 5.3

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1108106075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.525

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[202].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(1108106074)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 21
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")

						arg_313_1:RecordAudio("1108106074", var_316_9)
						arg_313_1:RecordAudio("1108106074", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106074", "story_v_side_new_1108106.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1108106075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108106075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108106076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1081ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1081ui_story == nil then
				arg_317_1.var_.characterEffect1081ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.0333333333333333

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1081ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1081ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1081ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1081ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 1.025

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_8 = arg_317_1:GetWordFromCfg(1108106075)
				local var_320_9 = arg_317_1:FormatText(var_320_8.content)

				arg_317_1.text_.text = var_320_9

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 41
				local var_320_11 = utf8.len(var_320_9)
				local var_320_12 = var_320_10 <= 0 and var_320_7 or var_320_7 * (var_320_11 / var_320_10)

				if var_320_12 > 0 and var_320_7 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_9
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_13 and arg_317_1.time_ < var_320_6 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1108106076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108106076
		arg_321_1.duration_ = 5.67

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108106077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1081ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1081ui_story == nil then
				arg_321_1.var_.characterEffect1081ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1081ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1081ui_story then
				arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_324_4 = 0

			if var_324_4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_324_5 = 0
			local var_324_6 = 0.675

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_7 = arg_321_1:FormatText(StoryNameCfg[202].name)

				arg_321_1.leftNameTxt_.text = var_324_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(1108106076)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 27
				local var_324_11 = utf8.len(var_324_9)
				local var_324_12 = var_324_10 <= 0 and var_324_6 or var_324_6 * (var_324_11 / var_324_10)

				if var_324_12 > 0 and var_324_6 < var_324_12 then
					arg_321_1.talkMaxDuration = var_324_12

					if var_324_12 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb") ~= 0 then
					local var_324_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb") / 1000

					if var_324_13 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_5
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")

						arg_321_1:RecordAudio("1108106076", var_324_14)
						arg_321_1:RecordAudio("1108106076", var_324_14)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106076", "story_v_side_new_1108106.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_15 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_15 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_15

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_15 and arg_321_1.time_ < var_324_5 + var_324_15 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1108106077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108106077
		arg_325_1.duration_ = 1

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"

			SetActive(arg_325_1.choicesGo_, true)

			for iter_326_0, iter_326_1 in ipairs(arg_325_1.choices_) do
				local var_326_0 = iter_326_0 <= 1

				SetActive(iter_326_1.go, var_326_0)
			end

			arg_325_1.choices_[1].txt.text = arg_325_1:FormatText(StoryChoiceCfg[988].name)
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108106078(arg_325_1)
			end

			arg_325_1:RecordChoiceLog(1108106077, 988)
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			return
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1108106078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108106078
		arg_329_1.duration_ = 6.97

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108106079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_332_2 = 0
			local var_332_3 = 0.95

			if var_332_2 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_4 = arg_329_1:FormatText(StoryNameCfg[202].name)

				arg_329_1.leftNameTxt_.text = var_332_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_5 = arg_329_1:GetWordFromCfg(1108106078)
				local var_332_6 = arg_329_1:FormatText(var_332_5.content)

				arg_329_1.text_.text = var_332_6

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 38
				local var_332_8 = utf8.len(var_332_6)
				local var_332_9 = var_332_7 <= 0 and var_332_3 or var_332_3 * (var_332_8 / var_332_7)

				if var_332_9 > 0 and var_332_3 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_6
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb") / 1000

					if var_332_10 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_2
					end

					if var_332_5.prefab_name ~= "" and arg_329_1.actors_[var_332_5.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_5.prefab_name].transform, "story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")

						arg_329_1:RecordAudio("1108106078", var_332_11)
						arg_329_1:RecordAudio("1108106078", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106078", "story_v_side_new_1108106.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_12 and arg_329_1.time_ < var_332_2 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108106079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108106079
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108106080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1081ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1081ui_story == nil then
				arg_333_1.var_.characterEffect1081ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.0333333333333333

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1081ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1081ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1081ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1081ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 0.875

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_9 = arg_333_1:GetWordFromCfg(1108106079)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 35
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1108106080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108106080
		arg_337_1.duration_ = 1.3

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108106081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1081ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1081ui_story == nil then
				arg_337_1.var_.characterEffect1081ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1081ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1081ui_story then
				arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_340_4 = 0
			local var_340_5 = 0.05

			if var_340_4 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_6 = arg_337_1:FormatText(StoryNameCfg[202].name)

				arg_337_1.leftNameTxt_.text = var_340_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:GetWordFromCfg(1108106080)
				local var_340_8 = arg_337_1:FormatText(var_340_7.content)

				arg_337_1.text_.text = var_340_8

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 2
				local var_340_10 = utf8.len(var_340_8)
				local var_340_11 = var_340_9 <= 0 and var_340_5 or var_340_5 * (var_340_10 / var_340_9)

				if var_340_11 > 0 and var_340_5 < var_340_11 then
					arg_337_1.talkMaxDuration = var_340_11

					if var_340_11 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_11 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_8
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb") ~= 0 then
					local var_340_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb") / 1000

					if var_340_12 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_4
					end

					if var_340_7.prefab_name ~= "" and arg_337_1.actors_[var_340_7.prefab_name] ~= nil then
						local var_340_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_7.prefab_name].transform, "story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")

						arg_337_1:RecordAudio("1108106080", var_340_13)
						arg_337_1:RecordAudio("1108106080", var_340_13)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106080", "story_v_side_new_1108106.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_14 and arg_337_1.time_ < var_340_4 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108106081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108106081
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108106082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1081ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1081ui_story == nil then
				arg_341_1.var_.characterEffect1081ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1081ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1081ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1081ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1081ui_story.fillRatio = var_344_5
			end

			local var_344_6 = 0
			local var_344_7 = 0.425

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_9 = arg_341_1:GetWordFromCfg(1108106081)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 17
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_14 and arg_341_1.time_ < var_344_6 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1108106082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108106082
		arg_345_1.duration_ = 2

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108106083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1081ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1081ui_story == nil then
				arg_345_1.var_.characterEffect1081ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1081ui_story and not isNil(var_348_0) then
					arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1081ui_story then
				arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_348_4 = 0

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_348_5 = 0
			local var_348_6 = 0.175

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_7 = arg_345_1:FormatText(StoryNameCfg[202].name)

				arg_345_1.leftNameTxt_.text = var_348_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(1108106082)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 7
				local var_348_11 = utf8.len(var_348_9)
				local var_348_12 = var_348_10 <= 0 and var_348_6 or var_348_6 * (var_348_11 / var_348_10)

				if var_348_12 > 0 and var_348_6 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb") ~= 0 then
					local var_348_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb") / 1000

					if var_348_13 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_5
					end

					if var_348_8.prefab_name ~= "" and arg_345_1.actors_[var_348_8.prefab_name] ~= nil then
						local var_348_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_8.prefab_name].transform, "story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")

						arg_345_1:RecordAudio("1108106082", var_348_14)
						arg_345_1:RecordAudio("1108106082", var_348_14)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106082", "story_v_side_new_1108106.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_15 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_15 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_15

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_15 and arg_345_1.time_ < var_348_5 + var_348_15 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108106083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108106083
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108106084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.allBtn_.enabled = false
			end

			local var_352_1 = 0.3

			if arg_349_1.time_ >= var_352_0 + var_352_1 and arg_349_1.time_ < var_352_0 + var_352_1 + arg_352_0 then
				arg_349_1.allBtn_.enabled = true
			end

			local var_352_2 = arg_349_1.actors_["1081ui_story"].transform
			local var_352_3 = 0

			if var_352_3 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.var_.moveOldPos1081ui_story = var_352_2.localPosition
			end

			local var_352_4 = 0.001

			if var_352_3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_3 + var_352_4 then
				local var_352_5 = (arg_349_1.time_ - var_352_3) / var_352_4
				local var_352_6 = Vector3.New(0, 100, 0)

				var_352_2.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1081ui_story, var_352_6, var_352_5)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_2.position

				var_352_2.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_2.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_2.localEulerAngles = var_352_8
			end

			if arg_349_1.time_ >= var_352_3 + var_352_4 and arg_349_1.time_ < var_352_3 + var_352_4 + arg_352_0 then
				var_352_2.localPosition = Vector3.New(0, 100, 0)

				local var_352_9 = manager.ui.mainCamera.transform.position - var_352_2.position

				var_352_2.forward = Vector3.New(var_352_9.x, var_352_9.y, var_352_9.z)

				local var_352_10 = var_352_2.localEulerAngles

				var_352_10.z = 0
				var_352_10.x = 0
				var_352_2.localEulerAngles = var_352_10
			end

			local var_352_11 = 0
			local var_352_12 = 0.725

			if var_352_11 < arg_349_1.time_ and arg_349_1.time_ <= var_352_11 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_13 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_13:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_14 = arg_349_1:GetWordFromCfg(1108106083)
				local var_352_15 = arg_349_1:FormatText(var_352_14.content)

				arg_349_1.text_.text = var_352_15

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_16 = 29
				local var_352_17 = utf8.len(var_352_15)
				local var_352_18 = var_352_16 <= 0 and var_352_12 or var_352_12 * (var_352_17 / var_352_16)

				if var_352_18 > 0 and var_352_12 < var_352_18 then
					arg_349_1.talkMaxDuration = var_352_18
					var_352_11 = var_352_11 + 0.3

					if var_352_18 + var_352_11 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_18 + var_352_11
					end
				end

				arg_349_1.text_.text = var_352_15
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_19 = var_352_11 + 0.3
			local var_352_20 = math.max(var_352_12, arg_349_1.talkMaxDuration)

			if var_352_19 <= arg_349_1.time_ and arg_349_1.time_ < var_352_19 + var_352_20 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_19) / var_352_20

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_19 + var_352_20 and arg_349_1.time_ < var_352_19 + var_352_20 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1108106084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1108106084
		arg_355_1.duration_ = 3.4

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1108106085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_1 = arg_355_1.actors_["1081ui_story"]
			local var_358_2 = 0

			if var_358_2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1081ui_story == nil then
				arg_355_1.var_.characterEffect1081ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_3 = 0.2

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_3 and not isNil(var_358_1) then
				local var_358_4 = (arg_355_1.time_ - var_358_2) / var_358_3

				if arg_355_1.var_.characterEffect1081ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_2 + var_358_3 and arg_355_1.time_ < var_358_2 + var_358_3 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1081ui_story then
				arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_358_5 = arg_355_1.actors_["1081ui_story"].transform
			local var_358_6 = 0

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.var_.moveOldPos1081ui_story = var_358_5.localPosition

				local var_358_7 = "1081ui_story"

				arg_355_1:ShowWeapon(arg_355_1.var_[var_358_7 .. "Animator"].transform, false)
			end

			local var_358_8 = 0.001

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_8 then
				local var_358_9 = (arg_355_1.time_ - var_358_6) / var_358_8
				local var_358_10 = Vector3.New(0, -0.92, -5.8)

				var_358_5.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1081ui_story, var_358_10, var_358_9)

				local var_358_11 = manager.ui.mainCamera.transform.position - var_358_5.position

				var_358_5.forward = Vector3.New(var_358_11.x, var_358_11.y, var_358_11.z)

				local var_358_12 = var_358_5.localEulerAngles

				var_358_12.z = 0
				var_358_12.x = 0
				var_358_5.localEulerAngles = var_358_12
			end

			if arg_355_1.time_ >= var_358_6 + var_358_8 and arg_355_1.time_ < var_358_6 + var_358_8 + arg_358_0 then
				var_358_5.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_358_13 = manager.ui.mainCamera.transform.position - var_358_5.position

				var_358_5.forward = Vector3.New(var_358_13.x, var_358_13.y, var_358_13.z)

				local var_358_14 = var_358_5.localEulerAngles

				var_358_14.z = 0
				var_358_14.x = 0
				var_358_5.localEulerAngles = var_358_14
			end

			local var_358_15 = 0

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_358_16 = 0
			local var_358_17 = 0.275

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_18 = arg_355_1:FormatText(StoryNameCfg[202].name)

				arg_355_1.leftNameTxt_.text = var_358_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_19 = arg_355_1:GetWordFromCfg(1108106084)
				local var_358_20 = arg_355_1:FormatText(var_358_19.content)

				arg_355_1.text_.text = var_358_20

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_21 = 11
				local var_358_22 = utf8.len(var_358_20)
				local var_358_23 = var_358_21 <= 0 and var_358_17 or var_358_17 * (var_358_22 / var_358_21)

				if var_358_23 > 0 and var_358_17 < var_358_23 then
					arg_355_1.talkMaxDuration = var_358_23

					if var_358_23 + var_358_16 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_16
					end
				end

				arg_355_1.text_.text = var_358_20
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb") ~= 0 then
					local var_358_24 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb") / 1000

					if var_358_24 + var_358_16 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_24 + var_358_16
					end

					if var_358_19.prefab_name ~= "" and arg_355_1.actors_[var_358_19.prefab_name] ~= nil then
						local var_358_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_19.prefab_name].transform, "story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")

						arg_355_1:RecordAudio("1108106084", var_358_25)
						arg_355_1:RecordAudio("1108106084", var_358_25)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106084", "story_v_side_new_1108106.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_26 = math.max(var_358_17, arg_355_1.talkMaxDuration)

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_26 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_16) / var_358_26

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_16 + var_358_26 and arg_355_1.time_ < var_358_16 + var_358_26 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play1108106085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1108106085
		arg_359_1.duration_ = 4.7

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1108106086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.75

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[202].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(1108106085)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 30
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")

						arg_359_1:RecordAudio("1108106085", var_362_9)
						arg_359_1:RecordAudio("1108106085", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106085", "story_v_side_new_1108106.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1108106086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1108106086
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1108106087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1081ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1081ui_story == nil then
				arg_363_1.var_.characterEffect1081ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1081ui_story and not isNil(var_366_0) then
					local var_366_4 = Mathf.Lerp(0, 0.5, var_366_3)

					arg_363_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1081ui_story.fillRatio = var_366_4
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1081ui_story then
				local var_366_5 = 0.5

				arg_363_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1081ui_story.fillRatio = var_366_5
			end

			local var_366_6 = 0
			local var_366_7 = 0.325

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_8 = arg_363_1:FormatText(StoryNameCfg[7].name)

				arg_363_1.leftNameTxt_.text = var_366_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_9 = arg_363_1:GetWordFromCfg(1108106086)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 13
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_7 or var_366_7 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_7 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_14 and arg_363_1.time_ < var_366_6 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1108106087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1108106087
		arg_367_1.duration_ = 2.97

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1108106088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1081ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1081ui_story == nil then
				arg_367_1.var_.characterEffect1081ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1081ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1081ui_story then
				arg_367_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_370_4 = 0

			if var_370_4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_5 = 0
			local var_370_6 = 0.35

			if var_370_5 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_7 = arg_367_1:FormatText(StoryNameCfg[202].name)

				arg_367_1.leftNameTxt_.text = var_370_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_8 = arg_367_1:GetWordFromCfg(1108106087)
				local var_370_9 = arg_367_1:FormatText(var_370_8.content)

				arg_367_1.text_.text = var_370_9

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 14
				local var_370_11 = utf8.len(var_370_9)
				local var_370_12 = var_370_10 <= 0 and var_370_6 or var_370_6 * (var_370_11 / var_370_10)

				if var_370_12 > 0 and var_370_6 < var_370_12 then
					arg_367_1.talkMaxDuration = var_370_12

					if var_370_12 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_9
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb") ~= 0 then
					local var_370_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb") / 1000

					if var_370_13 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_5
					end

					if var_370_8.prefab_name ~= "" and arg_367_1.actors_[var_370_8.prefab_name] ~= nil then
						local var_370_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_8.prefab_name].transform, "story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")

						arg_367_1:RecordAudio("1108106087", var_370_14)
						arg_367_1:RecordAudio("1108106087", var_370_14)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106087", "story_v_side_new_1108106.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_15 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_15 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_15

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_15 and arg_367_1.time_ < var_370_5 + var_370_15 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1108106088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1108106088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1108106089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1081ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1081ui_story == nil then
				arg_371_1.var_.characterEffect1081ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.075

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1081ui_story and not isNil(var_374_0) then
					local var_374_4 = Mathf.Lerp(0, 0.5, var_374_3)

					arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1081ui_story.fillRatio = var_374_4
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1081ui_story then
				local var_374_5 = 0.5

				arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1081ui_story.fillRatio = var_374_5
			end

			local var_374_6 = 0
			local var_374_7 = 0.075

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_9 = arg_371_1:GetWordFromCfg(1108106088)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 3
				local var_374_12 = utf8.len(var_374_10)
				local var_374_13 = var_374_11 <= 0 and var_374_7 or var_374_7 * (var_374_12 / var_374_11)

				if var_374_13 > 0 and var_374_7 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_14 and arg_371_1.time_ < var_374_6 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1108106089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1108106089
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1108106090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 0.825

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_2 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_3 = arg_375_1:GetWordFromCfg(1108106089)
				local var_378_4 = arg_375_1:FormatText(var_378_3.content)

				arg_375_1.text_.text = var_378_4

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 33
				local var_378_6 = utf8.len(var_378_4)
				local var_378_7 = var_378_5 <= 0 and var_378_1 or var_378_1 * (var_378_6 / var_378_5)

				if var_378_7 > 0 and var_378_1 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_0
					end
				end

				arg_375_1.text_.text = var_378_4
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_8 = math.max(var_378_1, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_8 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_0) / var_378_8

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_8 and arg_375_1.time_ < var_378_0 + var_378_8 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1108106090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1108106090
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1108106091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.825

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1108106090)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 33
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_8 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_8 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_8

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_8 and arg_379_1.time_ < var_382_0 + var_382_8 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1108106091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1108106091
		arg_383_1.duration_ = 2.43

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1108106092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1081ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1081ui_story == nil then
				arg_383_1.var_.characterEffect1081ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1081ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1081ui_story then
				arg_383_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_386_4 = 0
			local var_386_5 = 0.05

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_6 = arg_383_1:FormatText(StoryNameCfg[202].name)

				arg_383_1.leftNameTxt_.text = var_386_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_7 = arg_383_1:GetWordFromCfg(1108106091)
				local var_386_8 = arg_383_1:FormatText(var_386_7.content)

				arg_383_1.text_.text = var_386_8

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 2
				local var_386_10 = utf8.len(var_386_8)
				local var_386_11 = var_386_9 <= 0 and var_386_5 or var_386_5 * (var_386_10 / var_386_9)

				if var_386_11 > 0 and var_386_5 < var_386_11 then
					arg_383_1.talkMaxDuration = var_386_11

					if var_386_11 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_11 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_8
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb") ~= 0 then
					local var_386_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb") / 1000

					if var_386_12 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_12 + var_386_4
					end

					if var_386_7.prefab_name ~= "" and arg_383_1.actors_[var_386_7.prefab_name] ~= nil then
						local var_386_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_7.prefab_name].transform, "story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")

						arg_383_1:RecordAudio("1108106091", var_386_13)
						arg_383_1:RecordAudio("1108106091", var_386_13)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106091", "story_v_side_new_1108106.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_14 and arg_383_1.time_ < var_386_4 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1108106092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1108106092
		arg_387_1.duration_ = 2

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1108106093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_390_2 = 0
			local var_390_3 = 0.05

			if var_390_2 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_4 = arg_387_1:FormatText(StoryNameCfg[202].name)

				arg_387_1.leftNameTxt_.text = var_390_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_5 = arg_387_1:GetWordFromCfg(1108106092)
				local var_390_6 = arg_387_1:FormatText(var_390_5.content)

				arg_387_1.text_.text = var_390_6

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 2
				local var_390_8 = utf8.len(var_390_6)
				local var_390_9 = var_390_7 <= 0 and var_390_3 or var_390_3 * (var_390_8 / var_390_7)

				if var_390_9 > 0 and var_390_3 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_6
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb") / 1000

					if var_390_10 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_2
					end

					if var_390_5.prefab_name ~= "" and arg_387_1.actors_[var_390_5.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_5.prefab_name].transform, "story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")

						arg_387_1:RecordAudio("1108106092", var_390_11)
						arg_387_1:RecordAudio("1108106092", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106092", "story_v_side_new_1108106.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_12 and arg_387_1.time_ < var_390_2 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1108106093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1108106093
		arg_391_1.duration_ = 1.3

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"

			SetActive(arg_391_1.choicesGo_, true)

			for iter_392_0, iter_392_1 in ipairs(arg_391_1.choices_) do
				local var_392_0 = iter_392_0 <= 2

				SetActive(iter_392_1.go, var_392_0)
			end

			arg_391_1.choices_[1].txt.text = arg_391_1:FormatText(StoryChoiceCfg[989].name)
			arg_391_1.choices_[2].txt.text = arg_391_1:FormatText(StoryChoiceCfg[990].name)
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1108106094(arg_391_1)
			end

			if arg_393_0 == 2 then
				arg_391_0:Play1108106094(arg_391_1)
			end

			arg_391_1:RecordChoiceLog(1108106093, 989, 990)
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1081ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1081ui_story == nil then
				arg_391_1.var_.characterEffect1081ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1081ui_story and not isNil(var_394_0) then
					local var_394_4 = Mathf.Lerp(0, 0.5, var_394_3)

					arg_391_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1081ui_story.fillRatio = var_394_4
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1081ui_story then
				local var_394_5 = 0.5

				arg_391_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1081ui_story.fillRatio = var_394_5
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1108106094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1108106094
		arg_395_1.duration_ = 4.2

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1108106095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1081ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1081ui_story == nil then
				arg_395_1.var_.characterEffect1081ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1081ui_story and not isNil(var_398_0) then
					arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1081ui_story then
				arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_398_4 = "1081ui_story"

			if arg_395_1.actors_[var_398_4] == nil then
				local var_398_5 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_398_5) then
					local var_398_6 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_395_1.stage_.transform)

					var_398_6.name = var_398_4
					var_398_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_395_1.actors_[var_398_4] = var_398_6

					local var_398_7 = var_398_6:GetComponentInChildren(typeof(CharacterEffect))

					var_398_7.enabled = true

					local var_398_8 = GameObjectTools.GetOrAddComponent(var_398_6, typeof(DynamicBoneHelper))

					if var_398_8 then
						var_398_8:EnableDynamicBone(false)
					end

					arg_395_1:ShowWeapon(var_398_7.transform, false)

					arg_395_1.var_[var_398_4 .. "Animator"] = var_398_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_395_1.var_[var_398_4 .. "Animator"].applyRootMotion = true
					arg_395_1.var_[var_398_4 .. "LipSync"] = var_398_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_398_9 = 0

			if var_398_9 < arg_395_1.time_ and arg_395_1.time_ <= var_398_9 + arg_398_0 then
				arg_395_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_398_10 = 0
			local var_398_11 = 0.325

			if var_398_10 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_12 = arg_395_1:FormatText(StoryNameCfg[202].name)

				arg_395_1.leftNameTxt_.text = var_398_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_13 = arg_395_1:GetWordFromCfg(1108106094)
				local var_398_14 = arg_395_1:FormatText(var_398_13.content)

				arg_395_1.text_.text = var_398_14

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_15 = 13
				local var_398_16 = utf8.len(var_398_14)
				local var_398_17 = var_398_15 <= 0 and var_398_11 or var_398_11 * (var_398_16 / var_398_15)

				if var_398_17 > 0 and var_398_11 < var_398_17 then
					arg_395_1.talkMaxDuration = var_398_17

					if var_398_17 + var_398_10 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_17 + var_398_10
					end
				end

				arg_395_1.text_.text = var_398_14
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb") ~= 0 then
					local var_398_18 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb") / 1000

					if var_398_18 + var_398_10 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_18 + var_398_10
					end

					if var_398_13.prefab_name ~= "" and arg_395_1.actors_[var_398_13.prefab_name] ~= nil then
						local var_398_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_13.prefab_name].transform, "story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")

						arg_395_1:RecordAudio("1108106094", var_398_19)
						arg_395_1:RecordAudio("1108106094", var_398_19)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106094", "story_v_side_new_1108106.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_20 = math.max(var_398_11, arg_395_1.talkMaxDuration)

			if var_398_10 <= arg_395_1.time_ and arg_395_1.time_ < var_398_10 + var_398_20 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_10) / var_398_20

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_10 + var_398_20 and arg_395_1.time_ < var_398_10 + var_398_20 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1108106095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1108106095
		arg_399_1.duration_ = 6.5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1108106096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action463")
			end

			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_2 = 0
			local var_402_3 = 0.8

			if var_402_2 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_4 = arg_399_1:FormatText(StoryNameCfg[202].name)

				arg_399_1.leftNameTxt_.text = var_402_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_5 = arg_399_1:GetWordFromCfg(1108106095)
				local var_402_6 = arg_399_1:FormatText(var_402_5.content)

				arg_399_1.text_.text = var_402_6

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 32
				local var_402_8 = utf8.len(var_402_6)
				local var_402_9 = var_402_7 <= 0 and var_402_3 or var_402_3 * (var_402_8 / var_402_7)

				if var_402_9 > 0 and var_402_3 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_2
					end
				end

				arg_399_1.text_.text = var_402_6
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb") / 1000

					if var_402_10 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_2
					end

					if var_402_5.prefab_name ~= "" and arg_399_1.actors_[var_402_5.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_5.prefab_name].transform, "story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")

						arg_399_1:RecordAudio("1108106095", var_402_11)
						arg_399_1:RecordAudio("1108106095", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106095", "story_v_side_new_1108106.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_3, arg_399_1.talkMaxDuration)

			if var_402_2 <= arg_399_1.time_ and arg_399_1.time_ < var_402_2 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_2) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_2 + var_402_12 and arg_399_1.time_ < var_402_2 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1108106096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108106096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108106097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1081ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1081ui_story == nil then
				arg_403_1.var_.characterEffect1081ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1081ui_story and not isNil(var_406_0) then
					local var_406_4 = Mathf.Lerp(0, 0.5, var_406_3)

					arg_403_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1081ui_story.fillRatio = var_406_4
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1081ui_story then
				local var_406_5 = 0.5

				arg_403_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1081ui_story.fillRatio = var_406_5
			end

			local var_406_6 = 0
			local var_406_7 = 0.225

			if var_406_6 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_8 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_9 = arg_403_1:GetWordFromCfg(1108106096)
				local var_406_10 = arg_403_1:FormatText(var_406_9.content)

				arg_403_1.text_.text = var_406_10

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 9
				local var_406_12 = utf8.len(var_406_10)
				local var_406_13 = var_406_11 <= 0 and var_406_7 or var_406_7 * (var_406_12 / var_406_11)

				if var_406_13 > 0 and var_406_7 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_10
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_14 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_14 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_14

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_14 and arg_403_1.time_ < var_406_6 + var_406_14 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108106097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1108106097
		arg_407_1.duration_ = 5.33

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1108106098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1081ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1081ui_story == nil then
				arg_407_1.var_.characterEffect1081ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1081ui_story and not isNil(var_410_0) then
					arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1081ui_story then
				arg_407_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_410_4 = 0

			if var_410_4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_5 = 0
			local var_410_6 = 0.75

			if var_410_5 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_7 = arg_407_1:FormatText(StoryNameCfg[202].name)

				arg_407_1.leftNameTxt_.text = var_410_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:GetWordFromCfg(1108106097)
				local var_410_9 = arg_407_1:FormatText(var_410_8.content)

				arg_407_1.text_.text = var_410_9

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 30
				local var_410_11 = utf8.len(var_410_9)
				local var_410_12 = var_410_10 <= 0 and var_410_6 or var_410_6 * (var_410_11 / var_410_10)

				if var_410_12 > 0 and var_410_6 < var_410_12 then
					arg_407_1.talkMaxDuration = var_410_12

					if var_410_12 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_12 + var_410_5
					end
				end

				arg_407_1.text_.text = var_410_9
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb") ~= 0 then
					local var_410_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb") / 1000

					if var_410_13 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_5
					end

					if var_410_8.prefab_name ~= "" and arg_407_1.actors_[var_410_8.prefab_name] ~= nil then
						local var_410_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_8.prefab_name].transform, "story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")

						arg_407_1:RecordAudio("1108106097", var_410_14)
						arg_407_1:RecordAudio("1108106097", var_410_14)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106097", "story_v_side_new_1108106.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_15 = math.max(var_410_6, arg_407_1.talkMaxDuration)

			if var_410_5 <= arg_407_1.time_ and arg_407_1.time_ < var_410_5 + var_410_15 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_5) / var_410_15

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_5 + var_410_15 and arg_407_1.time_ < var_410_5 + var_410_15 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1108106098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1108106098
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1108106099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1081ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1081ui_story == nil then
				arg_411_1.var_.characterEffect1081ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.075

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1081ui_story and not isNil(var_414_0) then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1081ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1081ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1081ui_story.fillRatio = var_414_5
			end

			local var_414_6 = 0
			local var_414_7 = 0.075

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_9 = arg_411_1:GetWordFromCfg(1108106098)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 3
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_14 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_14 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_14

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_14 and arg_411_1.time_ < var_414_6 + var_414_14 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1108106099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1108106099
		arg_415_1.duration_ = 2.43

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1108106100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1081ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1081ui_story == nil then
				arg_415_1.var_.characterEffect1081ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1081ui_story and not isNil(var_418_0) then
					arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1081ui_story then
				arg_415_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_418_4 = 0

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action437")
			end

			local var_418_5 = 0
			local var_418_6 = 0.175

			if var_418_5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_7 = arg_415_1:FormatText(StoryNameCfg[202].name)

				arg_415_1.leftNameTxt_.text = var_418_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_8 = arg_415_1:GetWordFromCfg(1108106099)
				local var_418_9 = arg_415_1:FormatText(var_418_8.content)

				arg_415_1.text_.text = var_418_9

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_10 = 7
				local var_418_11 = utf8.len(var_418_9)
				local var_418_12 = var_418_10 <= 0 and var_418_6 or var_418_6 * (var_418_11 / var_418_10)

				if var_418_12 > 0 and var_418_6 < var_418_12 then
					arg_415_1.talkMaxDuration = var_418_12

					if var_418_12 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_12 + var_418_5
					end
				end

				arg_415_1.text_.text = var_418_9
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb") ~= 0 then
					local var_418_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb") / 1000

					if var_418_13 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_5
					end

					if var_418_8.prefab_name ~= "" and arg_415_1.actors_[var_418_8.prefab_name] ~= nil then
						local var_418_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_8.prefab_name].transform, "story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")

						arg_415_1:RecordAudio("1108106099", var_418_14)
						arg_415_1:RecordAudio("1108106099", var_418_14)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106099", "story_v_side_new_1108106.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_15 = math.max(var_418_6, arg_415_1.talkMaxDuration)

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_15 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_5) / var_418_15

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_5 + var_418_15 and arg_415_1.time_ < var_418_5 + var_418_15 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1108106100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1108106100
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1108106101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1081ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1081ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, 100, 0)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1081ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, 100, 0)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = 0
			local var_422_10 = 0.9

			if var_422_9 < arg_419_1.time_ and arg_419_1.time_ <= var_422_9 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_11 = arg_419_1:GetWordFromCfg(1108106100)
				local var_422_12 = arg_419_1:FormatText(var_422_11.content)

				arg_419_1.text_.text = var_422_12

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_13 = 36
				local var_422_14 = utf8.len(var_422_12)
				local var_422_15 = var_422_13 <= 0 and var_422_10 or var_422_10 * (var_422_14 / var_422_13)

				if var_422_15 > 0 and var_422_10 < var_422_15 then
					arg_419_1.talkMaxDuration = var_422_15

					if var_422_15 + var_422_9 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_15 + var_422_9
					end
				end

				arg_419_1.text_.text = var_422_12
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_16 = math.max(var_422_10, arg_419_1.talkMaxDuration)

			if var_422_9 <= arg_419_1.time_ and arg_419_1.time_ < var_422_9 + var_422_16 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_9) / var_422_16

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_9 + var_422_16 and arg_419_1.time_ < var_422_9 + var_422_16 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1108106101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1108106101
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1108106102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 0.225

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_2 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:GetWordFromCfg(1108106101)
				local var_426_4 = arg_423_1:FormatText(var_426_3.content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 9
				local var_426_6 = utf8.len(var_426_4)
				local var_426_7 = var_426_5 <= 0 and var_426_1 or var_426_1 * (var_426_6 / var_426_5)

				if var_426_7 > 0 and var_426_1 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_8 and arg_423_1.time_ < var_426_0 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1108106102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1108106102
		arg_427_1.duration_ = 5.23

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1108106103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1081ui_story"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos1081ui_story = var_430_0.localPosition
			end

			local var_430_2 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2
				local var_430_4 = Vector3.New(0, -0.92, -5.8)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1081ui_story, var_430_4, var_430_3)

				local var_430_5 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_5.x, var_430_5.y, var_430_5.z)

				local var_430_6 = var_430_0.localEulerAngles

				var_430_6.z = 0
				var_430_6.x = 0
				var_430_0.localEulerAngles = var_430_6
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_430_7 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_7.x, var_430_7.y, var_430_7.z)

				local var_430_8 = var_430_0.localEulerAngles

				var_430_8.z = 0
				var_430_8.x = 0
				var_430_0.localEulerAngles = var_430_8
			end

			local var_430_9 = arg_427_1.actors_["1081ui_story"]
			local var_430_10 = 0

			if var_430_10 < arg_427_1.time_ and arg_427_1.time_ <= var_430_10 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1081ui_story == nil then
				arg_427_1.var_.characterEffect1081ui_story = var_430_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.200000002980232

			if var_430_10 <= arg_427_1.time_ and arg_427_1.time_ < var_430_10 + var_430_11 and not isNil(var_430_9) then
				local var_430_12 = (arg_427_1.time_ - var_430_10) / var_430_11

				if arg_427_1.var_.characterEffect1081ui_story and not isNil(var_430_9) then
					arg_427_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_10 + var_430_11 and arg_427_1.time_ < var_430_10 + var_430_11 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1081ui_story then
				arg_427_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_430_13 = 0

			if var_430_13 < arg_427_1.time_ and arg_427_1.time_ <= var_430_13 + arg_430_0 then
				arg_427_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_14 = 0
			local var_430_15 = 0.475

			if var_430_14 < arg_427_1.time_ and arg_427_1.time_ <= var_430_14 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_16 = arg_427_1:FormatText(StoryNameCfg[202].name)

				arg_427_1.leftNameTxt_.text = var_430_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_17 = arg_427_1:GetWordFromCfg(1108106102)
				local var_430_18 = arg_427_1:FormatText(var_430_17.content)

				arg_427_1.text_.text = var_430_18

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_19 = 19
				local var_430_20 = utf8.len(var_430_18)
				local var_430_21 = var_430_19 <= 0 and var_430_15 or var_430_15 * (var_430_20 / var_430_19)

				if var_430_21 > 0 and var_430_15 < var_430_21 then
					arg_427_1.talkMaxDuration = var_430_21

					if var_430_21 + var_430_14 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_21 + var_430_14
					end
				end

				arg_427_1.text_.text = var_430_18
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb") ~= 0 then
					local var_430_22 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb") / 1000

					if var_430_22 + var_430_14 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_22 + var_430_14
					end

					if var_430_17.prefab_name ~= "" and arg_427_1.actors_[var_430_17.prefab_name] ~= nil then
						local var_430_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_17.prefab_name].transform, "story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")

						arg_427_1:RecordAudio("1108106102", var_430_23)
						arg_427_1:RecordAudio("1108106102", var_430_23)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106102", "story_v_side_new_1108106.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_24 = math.max(var_430_15, arg_427_1.talkMaxDuration)

			if var_430_14 <= arg_427_1.time_ and arg_427_1.time_ < var_430_14 + var_430_24 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_14) / var_430_24

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_14 + var_430_24 and arg_427_1.time_ < var_430_14 + var_430_24 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play1108106103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108106103
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108106104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1081ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1081ui_story == nil then
				arg_431_1.var_.characterEffect1081ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1081ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1081ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect1081ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1081ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.525

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_9 = arg_431_1:GetWordFromCfg(1108106103)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 21
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108106104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108106104
		arg_435_1.duration_ = 4.6

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108106105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1081ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1081ui_story == nil then
				arg_435_1.var_.characterEffect1081ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.034000001847744

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1081ui_story and not isNil(var_438_0) then
					arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1081ui_story then
				arg_435_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_438_4 = 0

			if var_438_4 < arg_435_1.time_ and arg_435_1.time_ <= var_438_4 + arg_438_0 then
				arg_435_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_5 = 0
			local var_438_6 = 0.525

			if var_438_5 < arg_435_1.time_ and arg_435_1.time_ <= var_438_5 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_7 = arg_435_1:FormatText(StoryNameCfg[202].name)

				arg_435_1.leftNameTxt_.text = var_438_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_8 = arg_435_1:GetWordFromCfg(1108106104)
				local var_438_9 = arg_435_1:FormatText(var_438_8.content)

				arg_435_1.text_.text = var_438_9

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_10 = 21
				local var_438_11 = utf8.len(var_438_9)
				local var_438_12 = var_438_10 <= 0 and var_438_6 or var_438_6 * (var_438_11 / var_438_10)

				if var_438_12 > 0 and var_438_6 < var_438_12 then
					arg_435_1.talkMaxDuration = var_438_12

					if var_438_12 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_12 + var_438_5
					end
				end

				arg_435_1.text_.text = var_438_9
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb") ~= 0 then
					local var_438_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb") / 1000

					if var_438_13 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_5
					end

					if var_438_8.prefab_name ~= "" and arg_435_1.actors_[var_438_8.prefab_name] ~= nil then
						local var_438_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_8.prefab_name].transform, "story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")

						arg_435_1:RecordAudio("1108106104", var_438_14)
						arg_435_1:RecordAudio("1108106104", var_438_14)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106104", "story_v_side_new_1108106.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_15 = math.max(var_438_6, arg_435_1.talkMaxDuration)

			if var_438_5 <= arg_435_1.time_ and arg_435_1.time_ < var_438_5 + var_438_15 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_5) / var_438_15

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_5 + var_438_15 and arg_435_1.time_ < var_438_5 + var_438_15 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108106105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108106105
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108106106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1081ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1081ui_story == nil then
				arg_439_1.var_.characterEffect1081ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1081ui_story and not isNil(var_442_0) then
					local var_442_4 = Mathf.Lerp(0, 0.5, var_442_3)

					arg_439_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1081ui_story.fillRatio = var_442_4
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1081ui_story then
				local var_442_5 = 0.5

				arg_439_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1081ui_story.fillRatio = var_442_5
			end

			local var_442_6 = 0
			local var_442_7 = 0.75

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[7].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_9 = arg_439_1:GetWordFromCfg(1108106105)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 30
				local var_442_12 = utf8.len(var_442_10)
				local var_442_13 = var_442_11 <= 0 and var_442_7 or var_442_7 * (var_442_12 / var_442_11)

				if var_442_13 > 0 and var_442_7 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108106106 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108106106
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108106107(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.65

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(1108106106)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 26
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1108106107 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108106107
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108106108(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.325

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_3 = arg_447_1:GetWordFromCfg(1108106107)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 13
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_8 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_8 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_8

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_8 and arg_447_1.time_ < var_450_0 + var_450_8 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108106108 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1108106108
		arg_451_1.duration_ = 2

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1108106109(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1081ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1081ui_story == nil then
				arg_451_1.var_.characterEffect1081ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1081ui_story and not isNil(var_454_0) then
					arg_451_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.characterEffect1081ui_story then
				arg_451_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_454_4 = 0

			if var_454_4 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_454_5 = 0

			if var_454_5 < arg_451_1.time_ and arg_451_1.time_ <= var_454_5 + arg_454_0 then
				arg_451_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_454_6 = 0
			local var_454_7 = 0.075

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[202].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_9 = arg_451_1:GetWordFromCfg(1108106108)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 3
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb") ~= 0 then
					local var_454_14 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb") / 1000

					if var_454_14 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_14 + var_454_6
					end

					if var_454_9.prefab_name ~= "" and arg_451_1.actors_[var_454_9.prefab_name] ~= nil then
						local var_454_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_9.prefab_name].transform, "story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")

						arg_451_1:RecordAudio("1108106108", var_454_15)
						arg_451_1:RecordAudio("1108106108", var_454_15)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106108", "story_v_side_new_1108106.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_16 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_16 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_16

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_16 and arg_451_1.time_ < var_454_6 + var_454_16 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1108106109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1108106109
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1108106110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1081ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1081ui_story == nil then
				arg_455_1.var_.characterEffect1081ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1081ui_story and not isNil(var_458_0) then
					local var_458_4 = Mathf.Lerp(0, 0.5, var_458_3)

					arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1081ui_story.fillRatio = var_458_4
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.characterEffect1081ui_story then
				local var_458_5 = 0.5

				arg_455_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1081ui_story.fillRatio = var_458_5
			end

			local var_458_6 = 0
			local var_458_7 = 1.15

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[7].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_9 = arg_455_1:GetWordFromCfg(1108106109)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 46
				local var_458_12 = utf8.len(var_458_10)
				local var_458_13 = var_458_11 <= 0 and var_458_7 or var_458_7 * (var_458_12 / var_458_11)

				if var_458_13 > 0 and var_458_7 < var_458_13 then
					arg_455_1.talkMaxDuration = var_458_13

					if var_458_13 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_6
					end
				end

				arg_455_1.text_.text = var_458_10
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_14 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_14 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_14

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_14 and arg_455_1.time_ < var_458_6 + var_458_14 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1108106110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1108106110
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1108106111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.65

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[7].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_3 = arg_459_1:GetWordFromCfg(1108106110)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 26
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_8 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_8 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_8

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_8 and arg_459_1.time_ < var_462_0 + var_462_8 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play1108106111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1108106111
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1108106112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.825

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[7].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(1108106111)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 33
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_8 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_8 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_8

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_8 and arg_463_1.time_ < var_466_0 + var_466_8 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1108106112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108106112
		arg_467_1.duration_ = 1

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"

			SetActive(arg_467_1.choicesGo_, true)

			for iter_468_0, iter_468_1 in ipairs(arg_467_1.choices_) do
				local var_468_0 = iter_468_0 <= 1

				SetActive(iter_468_1.go, var_468_0)
			end

			arg_467_1.choices_[1].txt.text = arg_467_1:FormatText(StoryChoiceCfg[991].name)
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108106113(arg_467_1)
			end

			arg_467_1:RecordChoiceLog(1108106112, 991)
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			return
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108106113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108106113
		arg_471_1.duration_ = 9

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108106114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 4

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			local var_474_1 = 0.3

			if arg_471_1.time_ >= var_474_0 + var_474_1 and arg_471_1.time_ < var_474_0 + var_474_1 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_2 = "R8102a"

			if arg_471_1.bgs_[var_474_2] == nil then
				local var_474_3 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_474_2)
				var_474_3.name = var_474_2
				var_474_3.transform.parent = arg_471_1.stage_.transform
				var_474_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_[var_474_2] = var_474_3
			end

			local var_474_4 = 2

			if var_474_4 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				local var_474_5 = manager.ui.mainCamera.transform.localPosition
				local var_474_6 = Vector3.New(0, 0, 10) + Vector3.New(var_474_5.x, var_474_5.y, 0)
				local var_474_7 = arg_471_1.bgs_.R8102a

				var_474_7.transform.localPosition = var_474_6
				var_474_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_8 = var_474_7:GetComponent("SpriteRenderer")

				if var_474_8 and var_474_8.sprite then
					local var_474_9 = (var_474_7.transform.localPosition - var_474_5).z
					local var_474_10 = manager.ui.mainCameraCom_
					local var_474_11 = 2 * var_474_9 * Mathf.Tan(var_474_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_474_12 = var_474_11 * var_474_10.aspect
					local var_474_13 = var_474_8.sprite.bounds.size.x
					local var_474_14 = var_474_8.sprite.bounds.size.y
					local var_474_15 = var_474_12 / var_474_13
					local var_474_16 = var_474_11 / var_474_14
					local var_474_17 = var_474_16 < var_474_15 and var_474_15 or var_474_16

					var_474_7.transform.localScale = Vector3.New(var_474_17, var_474_17, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "R8102a" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_18 = 0

			if var_474_18 < arg_471_1.time_ and arg_471_1.time_ <= var_474_18 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_19 = 2

			if var_474_18 <= arg_471_1.time_ and arg_471_1.time_ < var_474_18 + var_474_19 then
				local var_474_20 = (arg_471_1.time_ - var_474_18) / var_474_19
				local var_474_21 = Color.New(0, 0, 0)

				var_474_21.a = Mathf.Lerp(0, 1, var_474_20)
				arg_471_1.mask_.color = var_474_21
			end

			if arg_471_1.time_ >= var_474_18 + var_474_19 and arg_471_1.time_ < var_474_18 + var_474_19 + arg_474_0 then
				local var_474_22 = Color.New(0, 0, 0)

				var_474_22.a = 1
				arg_471_1.mask_.color = var_474_22
			end

			local var_474_23 = 2

			if var_474_23 < arg_471_1.time_ and arg_471_1.time_ <= var_474_23 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_24 = 2

			if var_474_23 <= arg_471_1.time_ and arg_471_1.time_ < var_474_23 + var_474_24 then
				local var_474_25 = (arg_471_1.time_ - var_474_23) / var_474_24
				local var_474_26 = Color.New(0, 0, 0)

				var_474_26.a = Mathf.Lerp(1, 0, var_474_25)
				arg_471_1.mask_.color = var_474_26
			end

			if arg_471_1.time_ >= var_474_23 + var_474_24 and arg_471_1.time_ < var_474_23 + var_474_24 + arg_474_0 then
				local var_474_27 = Color.New(0, 0, 0)
				local var_474_28 = 0

				arg_471_1.mask_.enabled = false
				var_474_27.a = var_474_28
				arg_471_1.mask_.color = var_474_27
			end

			local var_474_29 = arg_471_1.actors_["1081ui_story"].transform
			local var_474_30 = 1.966

			if var_474_30 < arg_471_1.time_ and arg_471_1.time_ <= var_474_30 + arg_474_0 then
				arg_471_1.var_.moveOldPos1081ui_story = var_474_29.localPosition

				local var_474_31 = "1081ui_story"

				arg_471_1:ShowWeapon(arg_471_1.var_[var_474_31 .. "Animator"].transform, false)
			end

			local var_474_32 = 0.001

			if var_474_30 <= arg_471_1.time_ and arg_471_1.time_ < var_474_30 + var_474_32 then
				local var_474_33 = (arg_471_1.time_ - var_474_30) / var_474_32
				local var_474_34 = Vector3.New(0, 100, 0)

				var_474_29.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1081ui_story, var_474_34, var_474_33)

				local var_474_35 = manager.ui.mainCamera.transform.position - var_474_29.position

				var_474_29.forward = Vector3.New(var_474_35.x, var_474_35.y, var_474_35.z)

				local var_474_36 = var_474_29.localEulerAngles

				var_474_36.z = 0
				var_474_36.x = 0
				var_474_29.localEulerAngles = var_474_36
			end

			if arg_471_1.time_ >= var_474_30 + var_474_32 and arg_471_1.time_ < var_474_30 + var_474_32 + arg_474_0 then
				var_474_29.localPosition = Vector3.New(0, 100, 0)

				local var_474_37 = manager.ui.mainCamera.transform.position - var_474_29.position

				var_474_29.forward = Vector3.New(var_474_37.x, var_474_37.y, var_474_37.z)

				local var_474_38 = var_474_29.localEulerAngles

				var_474_38.z = 0
				var_474_38.x = 0
				var_474_29.localEulerAngles = var_474_38
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_39 = 4
			local var_474_40 = 0.925

			if var_474_39 < arg_471_1.time_ and arg_471_1.time_ <= var_474_39 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_41 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_41:setOnUpdate(LuaHelper.FloatAction(function(arg_475_0)
					arg_471_1.dialogCg_.alpha = arg_475_0
				end))
				var_474_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_42 = arg_471_1:GetWordFromCfg(1108106113)
				local var_474_43 = arg_471_1:FormatText(var_474_42.content)

				arg_471_1.text_.text = var_474_43

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_44 = 37
				local var_474_45 = utf8.len(var_474_43)
				local var_474_46 = var_474_44 <= 0 and var_474_40 or var_474_40 * (var_474_45 / var_474_44)

				if var_474_46 > 0 and var_474_40 < var_474_46 then
					arg_471_1.talkMaxDuration = var_474_46
					var_474_39 = var_474_39 + 0.3

					if var_474_46 + var_474_39 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_46 + var_474_39
					end
				end

				arg_471_1.text_.text = var_474_43
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_47 = var_474_39 + 0.3
			local var_474_48 = math.max(var_474_40, arg_471_1.talkMaxDuration)

			if var_474_47 <= arg_471_1.time_ and arg_471_1.time_ < var_474_47 + var_474_48 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_47) / var_474_48

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_47 + var_474_48 and arg_471_1.time_ < var_474_47 + var_474_48 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play1108106114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1108106114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1108106115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.6

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(1108106114)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 24
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1108106115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108106115
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108106116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.475

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(1108106115)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 19
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1108106116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108106116
		arg_485_1.duration_ = 1

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"

			SetActive(arg_485_1.choicesGo_, true)

			for iter_486_0, iter_486_1 in ipairs(arg_485_1.choices_) do
				local var_486_0 = iter_486_0 <= 1

				SetActive(iter_486_1.go, var_486_0)
			end

			arg_485_1.choices_[1].txt.text = arg_485_1:FormatText(StoryChoiceCfg[992].name)
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108106117(arg_485_1)
			end

			arg_485_1:RecordChoiceLog(1108106116, 992)
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			return
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1108106117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108106117
		arg_489_1.duration_ = 2.9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108106118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.45

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[202].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:GetWordFromCfg(1108106117)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 18
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")

						arg_489_1:RecordAudio("1108106117", var_492_9)
						arg_489_1:RecordAudio("1108106117", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106117", "story_v_side_new_1108106.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_10 and arg_489_1.time_ < var_492_0 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108106118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1108106118
		arg_493_1.duration_ = 4.57

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1108106119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.425

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[202].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_3 = arg_493_1:GetWordFromCfg(1108106118)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 17
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb") / 1000

					if var_496_8 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_0
					end

					if var_496_3.prefab_name ~= "" and arg_493_1.actors_[var_496_3.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_3.prefab_name].transform, "story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")

						arg_493_1:RecordAudio("1108106118", var_496_9)
						arg_493_1:RecordAudio("1108106118", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106118", "story_v_side_new_1108106.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_10 and arg_493_1.time_ < var_496_0 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1108106119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1108106119
		arg_497_1.duration_ = 1.93

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1108106120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.25

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_2 = arg_497_1:FormatText(StoryNameCfg[202].name)

				arg_497_1.leftNameTxt_.text = var_500_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(1108106119)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 10
				local var_500_6 = utf8.len(var_500_4)
				local var_500_7 = var_500_5 <= 0 and var_500_1 or var_500_1 * (var_500_6 / var_500_5)

				if var_500_7 > 0 and var_500_1 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb") / 1000

					if var_500_8 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_0
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")

						arg_497_1:RecordAudio("1108106119", var_500_9)
						arg_497_1:RecordAudio("1108106119", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106119", "story_v_side_new_1108106.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_10 and arg_497_1.time_ < var_500_0 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1108106120 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1108106120
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1108106121(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 1.525

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_2 = arg_501_1:GetWordFromCfg(1108106120)
				local var_504_3 = arg_501_1:FormatText(var_504_2.content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_4 = 61
				local var_504_5 = utf8.len(var_504_3)
				local var_504_6 = var_504_4 <= 0 and var_504_1 or var_504_1 * (var_504_5 / var_504_4)

				if var_504_6 > 0 and var_504_1 < var_504_6 then
					arg_501_1.talkMaxDuration = var_504_6

					if var_504_6 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_6 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_7 and arg_501_1.time_ < var_504_0 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1108106121 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1108106121
		arg_505_1.duration_ = 1.37

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1108106122(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.075

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_2 = arg_505_1:FormatText(StoryNameCfg[202].name)

				arg_505_1.leftNameTxt_.text = var_508_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_3 = arg_505_1:GetWordFromCfg(1108106121)
				local var_508_4 = arg_505_1:FormatText(var_508_3.content)

				arg_505_1.text_.text = var_508_4

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 3
				local var_508_6 = utf8.len(var_508_4)
				local var_508_7 = var_508_5 <= 0 and var_508_1 or var_508_1 * (var_508_6 / var_508_5)

				if var_508_7 > 0 and var_508_1 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_4
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb") ~= 0 then
					local var_508_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb") / 1000

					if var_508_8 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_8 + var_508_0
					end

					if var_508_3.prefab_name ~= "" and arg_505_1.actors_[var_508_3.prefab_name] ~= nil then
						local var_508_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_3.prefab_name].transform, "story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")

						arg_505_1:RecordAudio("1108106121", var_508_9)
						arg_505_1:RecordAudio("1108106121", var_508_9)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106121", "story_v_side_new_1108106.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_10 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_10 and arg_505_1.time_ < var_508_0 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1108106122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1108106122
		arg_509_1.duration_ = 2.43

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1108106123(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 0.275

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[202].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:GetWordFromCfg(1108106122)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 11
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")

						arg_509_1:RecordAudio("1108106122", var_512_9)
						arg_509_1:RecordAudio("1108106122", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106122", "story_v_side_new_1108106.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1108106123 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1108106123
		arg_513_1.duration_ = 6.03

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1108106124(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.625

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[202].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:GetWordFromCfg(1108106123)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 25
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb") / 1000

					if var_516_8 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_0
					end

					if var_516_3.prefab_name ~= "" and arg_513_1.actors_[var_516_3.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_3.prefab_name].transform, "story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")

						arg_513_1:RecordAudio("1108106123", var_516_9)
						arg_513_1:RecordAudio("1108106123", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106123", "story_v_side_new_1108106.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_10 and arg_513_1.time_ < var_516_0 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1108106124 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1108106124
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1108106125(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.775

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_2 = arg_517_1:FormatText(StoryNameCfg[7].name)

				arg_517_1.leftNameTxt_.text = var_520_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_3 = arg_517_1:GetWordFromCfg(1108106124)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 31
				local var_520_6 = utf8.len(var_520_4)
				local var_520_7 = var_520_5 <= 0 and var_520_1 or var_520_1 * (var_520_6 / var_520_5)

				if var_520_7 > 0 and var_520_1 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_8 and arg_517_1.time_ < var_520_0 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1108106125 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1108106125
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1108106126(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.525

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:GetWordFromCfg(1108106125)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 21
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_8 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_8 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_8

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_8 and arg_521_1.time_ < var_524_0 + var_524_8 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1108106126 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1108106126
		arg_525_1.duration_ = 7.03

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1108106127(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = "R8102"

			if arg_525_1.bgs_[var_528_0] == nil then
				local var_528_1 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_528_0)
				var_528_1.name = var_528_0
				var_528_1.transform.parent = arg_525_1.stage_.transform
				var_528_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_[var_528_0] = var_528_1
			end

			local var_528_2 = 2.03333333333333

			if var_528_2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				local var_528_3 = manager.ui.mainCamera.transform.localPosition
				local var_528_4 = Vector3.New(0, 0, 10) + Vector3.New(var_528_3.x, var_528_3.y, 0)
				local var_528_5 = arg_525_1.bgs_.R8102

				var_528_5.transform.localPosition = var_528_4
				var_528_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_6 = var_528_5:GetComponent("SpriteRenderer")

				if var_528_6 and var_528_6.sprite then
					local var_528_7 = (var_528_5.transform.localPosition - var_528_3).z
					local var_528_8 = manager.ui.mainCameraCom_
					local var_528_9 = 2 * var_528_7 * Mathf.Tan(var_528_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_528_10 = var_528_9 * var_528_8.aspect
					local var_528_11 = var_528_6.sprite.bounds.size.x
					local var_528_12 = var_528_6.sprite.bounds.size.y
					local var_528_13 = var_528_10 / var_528_11
					local var_528_14 = var_528_9 / var_528_12
					local var_528_15 = var_528_14 < var_528_13 and var_528_13 or var_528_14

					var_528_5.transform.localScale = Vector3.New(var_528_15, var_528_15, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "R8102" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_16 = 0

			if var_528_16 < arg_525_1.time_ and arg_525_1.time_ <= var_528_16 + arg_528_0 then
				arg_525_1.allBtn_.enabled = false
			end

			local var_528_17 = 0.3

			if arg_525_1.time_ >= var_528_16 + var_528_17 and arg_525_1.time_ < var_528_16 + var_528_17 + arg_528_0 then
				arg_525_1.allBtn_.enabled = true
			end

			local var_528_18 = 0

			if var_528_18 < arg_525_1.time_ and arg_525_1.time_ <= var_528_18 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_19 = 2.03333333333333

			if var_528_18 <= arg_525_1.time_ and arg_525_1.time_ < var_528_18 + var_528_19 then
				local var_528_20 = (arg_525_1.time_ - var_528_18) / var_528_19
				local var_528_21 = Color.New(0, 0, 0)

				var_528_21.a = Mathf.Lerp(0, 1, var_528_20)
				arg_525_1.mask_.color = var_528_21
			end

			if arg_525_1.time_ >= var_528_18 + var_528_19 and arg_525_1.time_ < var_528_18 + var_528_19 + arg_528_0 then
				local var_528_22 = Color.New(0, 0, 0)

				var_528_22.a = 1
				arg_525_1.mask_.color = var_528_22
			end

			local var_528_23 = 2.03333333333333

			if var_528_23 < arg_525_1.time_ and arg_525_1.time_ <= var_528_23 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_24 = 2

			if var_528_23 <= arg_525_1.time_ and arg_525_1.time_ < var_528_23 + var_528_24 then
				local var_528_25 = (arg_525_1.time_ - var_528_23) / var_528_24
				local var_528_26 = Color.New(0, 0, 0)

				var_528_26.a = Mathf.Lerp(1, 0, var_528_25)
				arg_525_1.mask_.color = var_528_26
			end

			if arg_525_1.time_ >= var_528_23 + var_528_24 and arg_525_1.time_ < var_528_23 + var_528_24 + arg_528_0 then
				local var_528_27 = Color.New(0, 0, 0)
				local var_528_28 = 0

				arg_525_1.mask_.enabled = false
				var_528_27.a = var_528_28
				arg_525_1.mask_.color = var_528_27
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_29 = 2.03333333333333
			local var_528_30 = 0.725

			if var_528_29 < arg_525_1.time_ and arg_525_1.time_ <= var_528_29 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_31 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_31:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_32 = arg_525_1:GetWordFromCfg(1108106126)
				local var_528_33 = arg_525_1:FormatText(var_528_32.content)

				arg_525_1.text_.text = var_528_33

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_34 = 29
				local var_528_35 = utf8.len(var_528_33)
				local var_528_36 = var_528_34 <= 0 and var_528_30 or var_528_30 * (var_528_35 / var_528_34)

				if var_528_36 > 0 and var_528_30 < var_528_36 then
					arg_525_1.talkMaxDuration = var_528_36
					var_528_29 = var_528_29 + 0.3

					if var_528_36 + var_528_29 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_36 + var_528_29
					end
				end

				arg_525_1.text_.text = var_528_33
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_37 = var_528_29 + 0.3
			local var_528_38 = math.max(var_528_30, arg_525_1.talkMaxDuration)

			if var_528_37 <= arg_525_1.time_ and arg_525_1.time_ < var_528_37 + var_528_38 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_37) / var_528_38

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_37 + var_528_38 and arg_525_1.time_ < var_528_37 + var_528_38 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1108106127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108106127
		arg_531_1.duration_ = 3.2

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108106128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.325

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[202].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_3 = arg_531_1:GetWordFromCfg(1108106127)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 13
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb") / 1000

					if var_534_8 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_0
					end

					if var_534_3.prefab_name ~= "" and arg_531_1.actors_[var_534_3.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_3.prefab_name].transform, "story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")

						arg_531_1:RecordAudio("1108106127", var_534_9)
						arg_531_1:RecordAudio("1108106127", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106127", "story_v_side_new_1108106.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_10 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_10 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_10

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_10 and arg_531_1.time_ < var_534_0 + var_534_10 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108106128 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1108106128
		arg_535_1.duration_ = 5.53

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1108106129(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.725

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_2 = arg_535_1:FormatText(StoryNameCfg[202].name)

				arg_535_1.leftNameTxt_.text = var_538_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:GetWordFromCfg(1108106128)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 29
				local var_538_6 = utf8.len(var_538_4)
				local var_538_7 = var_538_5 <= 0 and var_538_1 or var_538_1 * (var_538_6 / var_538_5)

				if var_538_7 > 0 and var_538_1 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb") / 1000

					if var_538_8 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_0
					end

					if var_538_3.prefab_name ~= "" and arg_535_1.actors_[var_538_3.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_3.prefab_name].transform, "story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")

						arg_535_1:RecordAudio("1108106128", var_538_9)
						arg_535_1:RecordAudio("1108106128", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106128", "story_v_side_new_1108106.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_10 and arg_535_1.time_ < var_538_0 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1108106129 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1108106129
		arg_539_1.duration_ = 4.53

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1108106130(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.625

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[202].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_3 = arg_539_1:GetWordFromCfg(1108106129)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 25
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb") ~= 0 then
					local var_542_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb") / 1000

					if var_542_8 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_0
					end

					if var_542_3.prefab_name ~= "" and arg_539_1.actors_[var_542_3.prefab_name] ~= nil then
						local var_542_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_3.prefab_name].transform, "story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")

						arg_539_1:RecordAudio("1108106129", var_542_9)
						arg_539_1:RecordAudio("1108106129", var_542_9)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106129", "story_v_side_new_1108106.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_10 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_10 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_10

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_10 and arg_539_1.time_ < var_542_0 + var_542_10 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1108106130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108106130
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108106131(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 0.325

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_2 = arg_543_1:FormatText(StoryNameCfg[7].name)

				arg_543_1.leftNameTxt_.text = var_546_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_3 = arg_543_1:GetWordFromCfg(1108106130)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 13
				local var_546_6 = utf8.len(var_546_4)
				local var_546_7 = var_546_5 <= 0 and var_546_1 or var_546_1 * (var_546_6 / var_546_5)

				if var_546_7 > 0 and var_546_1 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_8 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_8 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_8

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_8 and arg_543_1.time_ < var_546_0 + var_546_8 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1108106131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108106131
		arg_547_1.duration_ = 1

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"

			SetActive(arg_547_1.choicesGo_, true)

			for iter_548_0, iter_548_1 in ipairs(arg_547_1.choices_) do
				local var_548_0 = iter_548_0 <= 1

				SetActive(iter_548_1.go, var_548_0)
			end

			arg_547_1.choices_[1].txt.text = arg_547_1:FormatText(StoryChoiceCfg[993].name)
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108106132(arg_547_1)
			end

			arg_547_1:RecordChoiceLog(1108106131, 993)
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			return
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108106132 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108106132
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108106133(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 0.85

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_2 = arg_551_1:GetWordFromCfg(1108106132)
				local var_554_3 = arg_551_1:FormatText(var_554_2.content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 34
				local var_554_5 = utf8.len(var_554_3)
				local var_554_6 = var_554_4 <= 0 and var_554_1 or var_554_1 * (var_554_5 / var_554_4)

				if var_554_6 > 0 and var_554_1 < var_554_6 then
					arg_551_1.talkMaxDuration = var_554_6

					if var_554_6 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_6 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_7 and arg_551_1.time_ < var_554_0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108106133 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108106133
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1108106134(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 0.775

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_2 = arg_555_1:FormatText(StoryNameCfg[7].name)

				arg_555_1.leftNameTxt_.text = var_558_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:GetWordFromCfg(1108106133)
				local var_558_4 = arg_555_1:FormatText(var_558_3.content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 31
				local var_558_6 = utf8.len(var_558_4)
				local var_558_7 = var_558_5 <= 0 and var_558_1 or var_558_1 * (var_558_6 / var_558_5)

				if var_558_7 > 0 and var_558_1 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_8 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_8 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_8

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_8 and arg_555_1.time_ < var_558_0 + var_558_8 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1108106134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1108106134
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1108106135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.65

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[7].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:GetWordFromCfg(1108106134)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 26
				local var_562_6 = utf8.len(var_562_4)
				local var_562_7 = var_562_5 <= 0 and var_562_1 or var_562_1 * (var_562_6 / var_562_5)

				if var_562_7 > 0 and var_562_1 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_8 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_8 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_8

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_8 and arg_559_1.time_ < var_562_0 + var_562_8 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1108106135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1108106135
		arg_563_1.duration_ = 1

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"

			SetActive(arg_563_1.choicesGo_, true)

			for iter_564_0, iter_564_1 in ipairs(arg_563_1.choices_) do
				local var_564_0 = iter_564_0 <= 1

				SetActive(iter_564_1.go, var_564_0)
			end

			arg_563_1.choices_[1].txt.text = arg_563_1:FormatText(StoryChoiceCfg[994].name)
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1108106136(arg_563_1)
			end

			arg_563_1:RecordChoiceLog(1108106135, 994)
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			return
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1108106136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1108106136
		arg_567_1.duration_ = 4.33

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1108106137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.725

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[202].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_3 = arg_567_1:GetWordFromCfg(1108106136)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 29
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb") / 1000

					if var_570_8 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_0
					end

					if var_570_3.prefab_name ~= "" and arg_567_1.actors_[var_570_3.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_3.prefab_name].transform, "story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")

						arg_567_1:RecordAudio("1108106136", var_570_9)
						arg_567_1:RecordAudio("1108106136", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106136", "story_v_side_new_1108106.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_10 and arg_567_1.time_ < var_570_0 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1108106137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1108106137
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1108106138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.85

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_2 = arg_571_1:GetWordFromCfg(1108106137)
				local var_574_3 = arg_571_1:FormatText(var_574_2.content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 34
				local var_574_5 = utf8.len(var_574_3)
				local var_574_6 = var_574_4 <= 0 and var_574_1 or var_574_1 * (var_574_5 / var_574_4)

				if var_574_6 > 0 and var_574_1 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_7 and arg_571_1.time_ < var_574_0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1108106138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1108106138
		arg_575_1.duration_ = 4.67

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1108106139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.625

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[202].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_3 = arg_575_1:GetWordFromCfg(1108106138)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 25
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb") / 1000

					if var_578_8 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_0
					end

					if var_578_3.prefab_name ~= "" and arg_575_1.actors_[var_578_3.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_3.prefab_name].transform, "story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")

						arg_575_1:RecordAudio("1108106138", var_578_9)
						arg_575_1:RecordAudio("1108106138", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106138", "story_v_side_new_1108106.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_10 and arg_575_1.time_ < var_578_0 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1108106139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1108106139
		arg_579_1.duration_ = 2.47

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1108106140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.3

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_2 = arg_579_1:FormatText(StoryNameCfg[202].name)

				arg_579_1.leftNameTxt_.text = var_582_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_3 = arg_579_1:GetWordFromCfg(1108106139)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 12
				local var_582_6 = utf8.len(var_582_4)
				local var_582_7 = var_582_5 <= 0 and var_582_1 or var_582_1 * (var_582_6 / var_582_5)

				if var_582_7 > 0 and var_582_1 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb") ~= 0 then
					local var_582_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb") / 1000

					if var_582_8 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_8 + var_582_0
					end

					if var_582_3.prefab_name ~= "" and arg_579_1.actors_[var_582_3.prefab_name] ~= nil then
						local var_582_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_3.prefab_name].transform, "story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")

						arg_579_1:RecordAudio("1108106139", var_582_9)
						arg_579_1:RecordAudio("1108106139", var_582_9)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106139", "story_v_side_new_1108106.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_10 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_10 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_10

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_10 and arg_579_1.time_ < var_582_0 + var_582_10 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1108106140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1108106140
		arg_583_1.duration_ = 2.47

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1108106141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.3

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[202].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_3 = arg_583_1:GetWordFromCfg(1108106140)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 12
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb") / 1000

					if var_586_8 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_0
					end

					if var_586_3.prefab_name ~= "" and arg_583_1.actors_[var_586_3.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_3.prefab_name].transform, "story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")

						arg_583_1:RecordAudio("1108106140", var_586_9)
						arg_583_1:RecordAudio("1108106140", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106140", "story_v_side_new_1108106.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_10 and arg_583_1.time_ < var_586_0 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1108106141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1108106141
		arg_587_1.duration_ = 4

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1108106142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0
			local var_590_1 = 0.725

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_2 = arg_587_1:FormatText(StoryNameCfg[202].name)

				arg_587_1.leftNameTxt_.text = var_590_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_3 = arg_587_1:GetWordFromCfg(1108106141)
				local var_590_4 = arg_587_1:FormatText(var_590_3.content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 29
				local var_590_6 = utf8.len(var_590_4)
				local var_590_7 = var_590_5 <= 0 and var_590_1 or var_590_1 * (var_590_6 / var_590_5)

				if var_590_7 > 0 and var_590_1 < var_590_7 then
					arg_587_1.talkMaxDuration = var_590_7

					if var_590_7 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb") ~= 0 then
					local var_590_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb") / 1000

					if var_590_8 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_8 + var_590_0
					end

					if var_590_3.prefab_name ~= "" and arg_587_1.actors_[var_590_3.prefab_name] ~= nil then
						local var_590_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_3.prefab_name].transform, "story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")

						arg_587_1:RecordAudio("1108106141", var_590_9)
						arg_587_1:RecordAudio("1108106141", var_590_9)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106141", "story_v_side_new_1108106.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_10 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_10 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_10

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_10 and arg_587_1.time_ < var_590_0 + var_590_10 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1108106142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1108106142
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1108106143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.75

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, false)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_2 = arg_591_1:GetWordFromCfg(1108106142)
				local var_594_3 = arg_591_1:FormatText(var_594_2.content)

				arg_591_1.text_.text = var_594_3

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_4 = 30
				local var_594_5 = utf8.len(var_594_3)
				local var_594_6 = var_594_4 <= 0 and var_594_1 or var_594_1 * (var_594_5 / var_594_4)

				if var_594_6 > 0 and var_594_1 < var_594_6 then
					arg_591_1.talkMaxDuration = var_594_6

					if var_594_6 + var_594_0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_6 + var_594_0
					end
				end

				arg_591_1.text_.text = var_594_3
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_7 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_7 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_7

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_7 and arg_591_1.time_ < var_594_0 + var_594_7 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1108106143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1108106143
		arg_595_1.duration_ = 3.73

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1108106144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.425

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[202].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_3 = arg_595_1:GetWordFromCfg(1108106143)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 17
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb") / 1000

					if var_598_8 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_0
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")

						arg_595_1:RecordAudio("1108106143", var_598_9)
						arg_595_1:RecordAudio("1108106143", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106143", "story_v_side_new_1108106.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_10 and arg_595_1.time_ < var_598_0 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1108106144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1108106144
		arg_599_1.duration_ = 8.37

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1108106145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.525

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[202].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_3 = arg_599_1:GetWordFromCfg(1108106144)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 21
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")

						arg_599_1:RecordAudio("1108106144", var_602_9)
						arg_599_1:RecordAudio("1108106144", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106144", "story_v_side_new_1108106.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1108106145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108106145
		arg_603_1.duration_ = 5.1

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108106146(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 1.96666666666667

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				local var_606_1 = manager.ui.mainCamera.transform.localPosition
				local var_606_2 = Vector3.New(0, 0, 10) + Vector3.New(var_606_1.x, var_606_1.y, 0)
				local var_606_3 = arg_603_1.bgs_.R8102a

				var_606_3.transform.localPosition = var_606_2
				var_606_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_606_4 = var_606_3:GetComponent("SpriteRenderer")

				if var_606_4 and var_606_4.sprite then
					local var_606_5 = (var_606_3.transform.localPosition - var_606_1).z
					local var_606_6 = manager.ui.mainCameraCom_
					local var_606_7 = 2 * var_606_5 * Mathf.Tan(var_606_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_606_8 = var_606_7 * var_606_6.aspect
					local var_606_9 = var_606_4.sprite.bounds.size.x
					local var_606_10 = var_606_4.sprite.bounds.size.y
					local var_606_11 = var_606_8 / var_606_9
					local var_606_12 = var_606_7 / var_606_10
					local var_606_13 = var_606_12 < var_606_11 and var_606_11 or var_606_12

					var_606_3.transform.localScale = Vector3.New(var_606_13, var_606_13, 0)
				end

				for iter_606_0, iter_606_1 in pairs(arg_603_1.bgs_) do
					if iter_606_0 ~= "R8102a" then
						iter_606_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_606_14 = 1.96666666666667

			if var_606_14 < arg_603_1.time_ and arg_603_1.time_ <= var_606_14 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			local var_606_15 = 0.3

			if arg_603_1.time_ >= var_606_14 + var_606_15 and arg_603_1.time_ < var_606_14 + var_606_15 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end

			local var_606_16 = 0

			if var_606_16 < arg_603_1.time_ and arg_603_1.time_ <= var_606_16 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_17 = 1.96666666666667

			if var_606_16 <= arg_603_1.time_ and arg_603_1.time_ < var_606_16 + var_606_17 then
				local var_606_18 = (arg_603_1.time_ - var_606_16) / var_606_17
				local var_606_19 = Color.New(0, 0, 0)

				var_606_19.a = Mathf.Lerp(0, 1, var_606_18)
				arg_603_1.mask_.color = var_606_19
			end

			if arg_603_1.time_ >= var_606_16 + var_606_17 and arg_603_1.time_ < var_606_16 + var_606_17 + arg_606_0 then
				local var_606_20 = Color.New(0, 0, 0)

				var_606_20.a = 1
				arg_603_1.mask_.color = var_606_20
			end

			local var_606_21 = 1.96666666666667

			if var_606_21 < arg_603_1.time_ and arg_603_1.time_ <= var_606_21 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_22 = 2

			if var_606_21 <= arg_603_1.time_ and arg_603_1.time_ < var_606_21 + var_606_22 then
				local var_606_23 = (arg_603_1.time_ - var_606_21) / var_606_22
				local var_606_24 = Color.New(0, 0, 0)

				var_606_24.a = Mathf.Lerp(1, 0, var_606_23)
				arg_603_1.mask_.color = var_606_24
			end

			if arg_603_1.time_ >= var_606_21 + var_606_22 and arg_603_1.time_ < var_606_21 + var_606_22 + arg_606_0 then
				local var_606_25 = Color.New(0, 0, 0)
				local var_606_26 = 0

				arg_603_1.mask_.enabled = false
				var_606_25.a = var_606_26
				arg_603_1.mask_.color = var_606_25
			end

			if arg_603_1.frameCnt_ <= 1 then
				arg_603_1.dialog_:SetActive(false)
			end

			local var_606_27 = 3.03333333333333
			local var_606_28 = 0.15

			if var_606_27 < arg_603_1.time_ and arg_603_1.time_ <= var_606_27 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0

				arg_603_1.dialog_:SetActive(true)

				arg_603_1.dialogCg_.alpha = 0

				local var_606_29 = LeanTween.value(arg_603_1.dialog_, 0, 1, 0.3)

				var_606_29:setOnUpdate(LuaHelper.FloatAction(function(arg_607_0)
					arg_603_1.dialogCg_.alpha = arg_607_0
				end))
				var_606_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_603_1.dialog_)
					var_606_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_603_1.duration_ = arg_603_1.duration_ + 0.3

				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_30 = arg_603_1:FormatText(StoryNameCfg[202].name)

				arg_603_1.leftNameTxt_.text = var_606_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_31 = arg_603_1:GetWordFromCfg(1108106145)
				local var_606_32 = arg_603_1:FormatText(var_606_31.content)

				arg_603_1.text_.text = var_606_32

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_33 = 6
				local var_606_34 = utf8.len(var_606_32)
				local var_606_35 = var_606_33 <= 0 and var_606_28 or var_606_28 * (var_606_34 / var_606_33)

				if var_606_35 > 0 and var_606_28 < var_606_35 then
					arg_603_1.talkMaxDuration = var_606_35
					var_606_27 = var_606_27 + 0.3

					if var_606_35 + var_606_27 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_35 + var_606_27
					end
				end

				arg_603_1.text_.text = var_606_32
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb") ~= 0 then
					local var_606_36 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb") / 1000

					if var_606_36 + var_606_27 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_36 + var_606_27
					end

					if var_606_31.prefab_name ~= "" and arg_603_1.actors_[var_606_31.prefab_name] ~= nil then
						local var_606_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_31.prefab_name].transform, "story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")

						arg_603_1:RecordAudio("1108106145", var_606_37)
						arg_603_1:RecordAudio("1108106145", var_606_37)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106145", "story_v_side_new_1108106.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_38 = var_606_27 + 0.3
			local var_606_39 = math.max(var_606_28, arg_603_1.talkMaxDuration)

			if var_606_38 <= arg_603_1.time_ and arg_603_1.time_ < var_606_38 + var_606_39 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_38) / var_606_39

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_38 + var_606_39 and arg_603_1.time_ < var_606_38 + var_606_39 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108106146 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1108106146
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1108106147(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 1.15

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_2 = arg_609_1:GetWordFromCfg(1108106146)
				local var_612_3 = arg_609_1:FormatText(var_612_2.content)

				arg_609_1.text_.text = var_612_3

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_4 = 46
				local var_612_5 = utf8.len(var_612_3)
				local var_612_6 = var_612_4 <= 0 and var_612_1 or var_612_1 * (var_612_5 / var_612_4)

				if var_612_6 > 0 and var_612_1 < var_612_6 then
					arg_609_1.talkMaxDuration = var_612_6

					if var_612_6 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_6 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_3
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_7 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_7 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_7

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_7 and arg_609_1.time_ < var_612_0 + var_612_7 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1108106147 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1108106147
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1108106148(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.175

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[7].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:GetWordFromCfg(1108106147)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 7
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_8 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_8 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_8

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_8 and arg_613_1.time_ < var_616_0 + var_616_8 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1108106148 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1108106148
		arg_617_1.duration_ = 4.73

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1108106149(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 0.6

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[202].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:GetWordFromCfg(1108106148)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 24
				local var_620_6 = utf8.len(var_620_4)
				local var_620_7 = var_620_5 <= 0 and var_620_1 or var_620_1 * (var_620_6 / var_620_5)

				if var_620_7 > 0 and var_620_1 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_4
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb") / 1000

					if var_620_8 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_0
					end

					if var_620_3.prefab_name ~= "" and arg_617_1.actors_[var_620_3.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_3.prefab_name].transform, "story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")

						arg_617_1:RecordAudio("1108106148", var_620_9)
						arg_617_1:RecordAudio("1108106148", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106148", "story_v_side_new_1108106.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_10 and arg_617_1.time_ < var_620_0 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1108106149 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1108106149
		arg_621_1.duration_ = 1

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"

			SetActive(arg_621_1.choicesGo_, true)

			for iter_622_0, iter_622_1 in ipairs(arg_621_1.choices_) do
				local var_622_0 = iter_622_0 <= 2

				SetActive(iter_622_1.go, var_622_0)
			end

			arg_621_1.choices_[1].txt.text = arg_621_1:FormatText(StoryChoiceCfg[995].name)
			arg_621_1.choices_[2].txt.text = arg_621_1:FormatText(StoryChoiceCfg[996].name)
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1108106150(arg_621_1)
			end

			if arg_623_0 == 2 then
				arg_621_0:Play1108106150(arg_621_1)
			end

			arg_621_1:RecordChoiceLog(1108106149, 995, 996)
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			return
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1108106150 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1108106150
		arg_625_1.duration_ = 2.27

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1108106151(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.275

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_2 = arg_625_1:FormatText(StoryNameCfg[202].name)

				arg_625_1.leftNameTxt_.text = var_628_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_3 = arg_625_1:GetWordFromCfg(1108106150)
				local var_628_4 = arg_625_1:FormatText(var_628_3.content)

				arg_625_1.text_.text = var_628_4

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 11
				local var_628_6 = utf8.len(var_628_4)
				local var_628_7 = var_628_5 <= 0 and var_628_1 or var_628_1 * (var_628_6 / var_628_5)

				if var_628_7 > 0 and var_628_1 < var_628_7 then
					arg_625_1.talkMaxDuration = var_628_7

					if var_628_7 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_7 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_4
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb") ~= 0 then
					local var_628_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb") / 1000

					if var_628_8 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_8 + var_628_0
					end

					if var_628_3.prefab_name ~= "" and arg_625_1.actors_[var_628_3.prefab_name] ~= nil then
						local var_628_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_3.prefab_name].transform, "story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")

						arg_625_1:RecordAudio("1108106150", var_628_9)
						arg_625_1:RecordAudio("1108106150", var_628_9)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106150", "story_v_side_new_1108106.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_10 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_10 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_10

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_10 and arg_625_1.time_ < var_628_0 + var_628_10 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1108106151 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1108106151
		arg_629_1.duration_ = 3.7

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1108106152(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0
			local var_632_1 = 0.45

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_2 = arg_629_1:FormatText(StoryNameCfg[202].name)

				arg_629_1.leftNameTxt_.text = var_632_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_3 = arg_629_1:GetWordFromCfg(1108106151)
				local var_632_4 = arg_629_1:FormatText(var_632_3.content)

				arg_629_1.text_.text = var_632_4

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_5 = 18
				local var_632_6 = utf8.len(var_632_4)
				local var_632_7 = var_632_5 <= 0 and var_632_1 or var_632_1 * (var_632_6 / var_632_5)

				if var_632_7 > 0 and var_632_1 < var_632_7 then
					arg_629_1.talkMaxDuration = var_632_7

					if var_632_7 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_7 + var_632_0
					end
				end

				arg_629_1.text_.text = var_632_4
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb") ~= 0 then
					local var_632_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb") / 1000

					if var_632_8 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_8 + var_632_0
					end

					if var_632_3.prefab_name ~= "" and arg_629_1.actors_[var_632_3.prefab_name] ~= nil then
						local var_632_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_3.prefab_name].transform, "story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")

						arg_629_1:RecordAudio("1108106151", var_632_9)
						arg_629_1:RecordAudio("1108106151", var_632_9)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106151", "story_v_side_new_1108106.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_10 = math.max(var_632_1, arg_629_1.talkMaxDuration)

			if var_632_0 <= arg_629_1.time_ and arg_629_1.time_ < var_632_0 + var_632_10 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_0) / var_632_10

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_0 + var_632_10 and arg_629_1.time_ < var_632_0 + var_632_10 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1108106152 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1108106152
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1108106153(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 0
			local var_636_1 = 0.15

			if var_636_0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_2 = arg_633_1:FormatText(StoryNameCfg[7].name)

				arg_633_1.leftNameTxt_.text = var_636_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_3 = arg_633_1:GetWordFromCfg(1108106152)
				local var_636_4 = arg_633_1:FormatText(var_636_3.content)

				arg_633_1.text_.text = var_636_4

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_5 = 6
				local var_636_6 = utf8.len(var_636_4)
				local var_636_7 = var_636_5 <= 0 and var_636_1 or var_636_1 * (var_636_6 / var_636_5)

				if var_636_7 > 0 and var_636_1 < var_636_7 then
					arg_633_1.talkMaxDuration = var_636_7

					if var_636_7 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_7 + var_636_0
					end
				end

				arg_633_1.text_.text = var_636_4
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_8 = math.max(var_636_1, arg_633_1.talkMaxDuration)

			if var_636_0 <= arg_633_1.time_ and arg_633_1.time_ < var_636_0 + var_636_8 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_0) / var_636_8

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_0 + var_636_8 and arg_633_1.time_ < var_636_0 + var_636_8 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1108106153 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1108106153
		arg_637_1.duration_ = 5.57

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1108106154(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 0.6

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_2 = arg_637_1:FormatText(StoryNameCfg[202].name)

				arg_637_1.leftNameTxt_.text = var_640_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_3 = arg_637_1:GetWordFromCfg(1108106153)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 24
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb") ~= 0 then
					local var_640_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb") / 1000

					if var_640_8 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_8 + var_640_0
					end

					if var_640_3.prefab_name ~= "" and arg_637_1.actors_[var_640_3.prefab_name] ~= nil then
						local var_640_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_3.prefab_name].transform, "story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")

						arg_637_1:RecordAudio("1108106153", var_640_9)
						arg_637_1:RecordAudio("1108106153", var_640_9)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106153", "story_v_side_new_1108106.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_10 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_0 <= arg_637_1.time_ and arg_637_1.time_ < var_640_0 + var_640_10 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_0) / var_640_10

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_0 + var_640_10 and arg_637_1.time_ < var_640_0 + var_640_10 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1108106154 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1108106154
		arg_641_1.duration_ = 2.9

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1108106155(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.35

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_2 = arg_641_1:FormatText(StoryNameCfg[202].name)

				arg_641_1.leftNameTxt_.text = var_644_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_3 = arg_641_1:GetWordFromCfg(1108106154)
				local var_644_4 = arg_641_1:FormatText(var_644_3.content)

				arg_641_1.text_.text = var_644_4

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 14
				local var_644_6 = utf8.len(var_644_4)
				local var_644_7 = var_644_5 <= 0 and var_644_1 or var_644_1 * (var_644_6 / var_644_5)

				if var_644_7 > 0 and var_644_1 < var_644_7 then
					arg_641_1.talkMaxDuration = var_644_7

					if var_644_7 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_7 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_4
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb") ~= 0 then
					local var_644_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb") / 1000

					if var_644_8 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_8 + var_644_0
					end

					if var_644_3.prefab_name ~= "" and arg_641_1.actors_[var_644_3.prefab_name] ~= nil then
						local var_644_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_3.prefab_name].transform, "story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")

						arg_641_1:RecordAudio("1108106154", var_644_9)
						arg_641_1:RecordAudio("1108106154", var_644_9)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106154", "story_v_side_new_1108106.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_10 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_10 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_10

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_10 and arg_641_1.time_ < var_644_0 + var_644_10 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1108106155 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1108106155
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1108106156(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.125

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:GetWordFromCfg(1108106155)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 5
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1108106156 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1108106156
		arg_649_1.duration_ = 6.3

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1108106157(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.8

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_2 = arg_649_1:FormatText(StoryNameCfg[202].name)

				arg_649_1.leftNameTxt_.text = var_652_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_3 = arg_649_1:GetWordFromCfg(1108106156)
				local var_652_4 = arg_649_1:FormatText(var_652_3.content)

				arg_649_1.text_.text = var_652_4

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 32
				local var_652_6 = utf8.len(var_652_4)
				local var_652_7 = var_652_5 <= 0 and var_652_1 or var_652_1 * (var_652_6 / var_652_5)

				if var_652_7 > 0 and var_652_1 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_4
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb") ~= 0 then
					local var_652_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb") / 1000

					if var_652_8 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_8 + var_652_0
					end

					if var_652_3.prefab_name ~= "" and arg_649_1.actors_[var_652_3.prefab_name] ~= nil then
						local var_652_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_3.prefab_name].transform, "story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")

						arg_649_1:RecordAudio("1108106156", var_652_9)
						arg_649_1:RecordAudio("1108106156", var_652_9)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106156", "story_v_side_new_1108106.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_10 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_10 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_10

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_10 and arg_649_1.time_ < var_652_0 + var_652_10 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1108106157 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1108106157
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1108106158(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0
			local var_656_1 = 0.925

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_2 = arg_653_1:FormatText(StoryNameCfg[7].name)

				arg_653_1.leftNameTxt_.text = var_656_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_3 = arg_653_1:GetWordFromCfg(1108106157)
				local var_656_4 = arg_653_1:FormatText(var_656_3.content)

				arg_653_1.text_.text = var_656_4

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_5 = 37
				local var_656_6 = utf8.len(var_656_4)
				local var_656_7 = var_656_5 <= 0 and var_656_1 or var_656_1 * (var_656_6 / var_656_5)

				if var_656_7 > 0 and var_656_1 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_0
					end
				end

				arg_653_1.text_.text = var_656_4
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_8 = math.max(var_656_1, arg_653_1.talkMaxDuration)

			if var_656_0 <= arg_653_1.time_ and arg_653_1.time_ < var_656_0 + var_656_8 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_0) / var_656_8

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_0 + var_656_8 and arg_653_1.time_ < var_656_0 + var_656_8 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1108106158 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1108106158
		arg_657_1.duration_ = 2.3

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1108106159(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0
			local var_660_1 = 0.325

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_2 = arg_657_1:FormatText(StoryNameCfg[202].name)

				arg_657_1.leftNameTxt_.text = var_660_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_3 = arg_657_1:GetWordFromCfg(1108106158)
				local var_660_4 = arg_657_1:FormatText(var_660_3.content)

				arg_657_1.text_.text = var_660_4

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 13
				local var_660_6 = utf8.len(var_660_4)
				local var_660_7 = var_660_5 <= 0 and var_660_1 or var_660_1 * (var_660_6 / var_660_5)

				if var_660_7 > 0 and var_660_1 < var_660_7 then
					arg_657_1.talkMaxDuration = var_660_7

					if var_660_7 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_7 + var_660_0
					end
				end

				arg_657_1.text_.text = var_660_4
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb") ~= 0 then
					local var_660_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb") / 1000

					if var_660_8 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_8 + var_660_0
					end

					if var_660_3.prefab_name ~= "" and arg_657_1.actors_[var_660_3.prefab_name] ~= nil then
						local var_660_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_3.prefab_name].transform, "story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")

						arg_657_1:RecordAudio("1108106158", var_660_9)
						arg_657_1:RecordAudio("1108106158", var_660_9)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106158", "story_v_side_new_1108106.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_10 = math.max(var_660_1, arg_657_1.talkMaxDuration)

			if var_660_0 <= arg_657_1.time_ and arg_657_1.time_ < var_660_0 + var_660_10 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_0) / var_660_10

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_0 + var_660_10 and arg_657_1.time_ < var_660_0 + var_660_10 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1108106159 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1108106159
		arg_661_1.duration_ = 3.5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1108106160(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0
			local var_664_1 = 0.375

			if var_664_0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_2 = arg_661_1:FormatText(StoryNameCfg[202].name)

				arg_661_1.leftNameTxt_.text = var_664_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_3 = arg_661_1:GetWordFromCfg(1108106159)
				local var_664_4 = arg_661_1:FormatText(var_664_3.content)

				arg_661_1.text_.text = var_664_4

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 15
				local var_664_6 = utf8.len(var_664_4)
				local var_664_7 = var_664_5 <= 0 and var_664_1 or var_664_1 * (var_664_6 / var_664_5)

				if var_664_7 > 0 and var_664_1 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_0
					end
				end

				arg_661_1.text_.text = var_664_4
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb") ~= 0 then
					local var_664_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb") / 1000

					if var_664_8 + var_664_0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_8 + var_664_0
					end

					if var_664_3.prefab_name ~= "" and arg_661_1.actors_[var_664_3.prefab_name] ~= nil then
						local var_664_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_3.prefab_name].transform, "story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")

						arg_661_1:RecordAudio("1108106159", var_664_9)
						arg_661_1:RecordAudio("1108106159", var_664_9)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106159", "story_v_side_new_1108106.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_10 = math.max(var_664_1, arg_661_1.talkMaxDuration)

			if var_664_0 <= arg_661_1.time_ and arg_661_1.time_ < var_664_0 + var_664_10 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_0) / var_664_10

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_0 + var_664_10 and arg_661_1.time_ < var_664_0 + var_664_10 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1108106160 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1108106160
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1108106161(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0
			local var_668_1 = 0.7

			if var_668_0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_2 = arg_665_1:FormatText(StoryNameCfg[7].name)

				arg_665_1.leftNameTxt_.text = var_668_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_3 = arg_665_1:GetWordFromCfg(1108106160)
				local var_668_4 = arg_665_1:FormatText(var_668_3.content)

				arg_665_1.text_.text = var_668_4

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_5 = 28
				local var_668_6 = utf8.len(var_668_4)
				local var_668_7 = var_668_5 <= 0 and var_668_1 or var_668_1 * (var_668_6 / var_668_5)

				if var_668_7 > 0 and var_668_1 < var_668_7 then
					arg_665_1.talkMaxDuration = var_668_7

					if var_668_7 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_7 + var_668_0
					end
				end

				arg_665_1.text_.text = var_668_4
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_8 = math.max(var_668_1, arg_665_1.talkMaxDuration)

			if var_668_0 <= arg_665_1.time_ and arg_665_1.time_ < var_668_0 + var_668_8 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_0) / var_668_8

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_0 + var_668_8 and arg_665_1.time_ < var_668_0 + var_668_8 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1108106161 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1108106161
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1108106162(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 0.725

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_2 = arg_669_1:FormatText(StoryNameCfg[7].name)

				arg_669_1.leftNameTxt_.text = var_672_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:GetWordFromCfg(1108106161)
				local var_672_4 = arg_669_1:FormatText(var_672_3.content)

				arg_669_1.text_.text = var_672_4

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 29
				local var_672_6 = utf8.len(var_672_4)
				local var_672_7 = var_672_5 <= 0 and var_672_1 or var_672_1 * (var_672_6 / var_672_5)

				if var_672_7 > 0 and var_672_1 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_4
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_8 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_8 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_8

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_8 and arg_669_1.time_ < var_672_0 + var_672_8 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1108106162 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1108106162
		arg_673_1.duration_ = 7.93

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1108106163(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 2

			if var_676_0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_0 + arg_676_0 then
				local var_676_1 = manager.ui.mainCamera.transform.localPosition
				local var_676_2 = Vector3.New(0, 0, 10) + Vector3.New(var_676_1.x, var_676_1.y, 0)
				local var_676_3 = arg_673_1.bgs_.R8102

				var_676_3.transform.localPosition = var_676_2
				var_676_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_676_4 = var_676_3:GetComponent("SpriteRenderer")

				if var_676_4 and var_676_4.sprite then
					local var_676_5 = (var_676_3.transform.localPosition - var_676_1).z
					local var_676_6 = manager.ui.mainCameraCom_
					local var_676_7 = 2 * var_676_5 * Mathf.Tan(var_676_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_676_8 = var_676_7 * var_676_6.aspect
					local var_676_9 = var_676_4.sprite.bounds.size.x
					local var_676_10 = var_676_4.sprite.bounds.size.y
					local var_676_11 = var_676_8 / var_676_9
					local var_676_12 = var_676_7 / var_676_10
					local var_676_13 = var_676_12 < var_676_11 and var_676_11 or var_676_12

					var_676_3.transform.localScale = Vector3.New(var_676_13, var_676_13, 0)
				end

				for iter_676_0, iter_676_1 in pairs(arg_673_1.bgs_) do
					if iter_676_0 ~= "R8102" then
						iter_676_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_676_14 = 2

			if var_676_14 < arg_673_1.time_ and arg_673_1.time_ <= var_676_14 + arg_676_0 then
				arg_673_1.allBtn_.enabled = false
			end

			local var_676_15 = 0.3

			if arg_673_1.time_ >= var_676_14 + var_676_15 and arg_673_1.time_ < var_676_14 + var_676_15 + arg_676_0 then
				arg_673_1.allBtn_.enabled = true
			end

			local var_676_16 = 0

			if var_676_16 < arg_673_1.time_ and arg_673_1.time_ <= var_676_16 + arg_676_0 then
				arg_673_1.mask_.enabled = true
				arg_673_1.mask_.raycastTarget = true

				arg_673_1:SetGaussion(false)
			end

			local var_676_17 = 2

			if var_676_16 <= arg_673_1.time_ and arg_673_1.time_ < var_676_16 + var_676_17 then
				local var_676_18 = (arg_673_1.time_ - var_676_16) / var_676_17
				local var_676_19 = Color.New(0, 0, 0)

				var_676_19.a = Mathf.Lerp(0, 1, var_676_18)
				arg_673_1.mask_.color = var_676_19
			end

			if arg_673_1.time_ >= var_676_16 + var_676_17 and arg_673_1.time_ < var_676_16 + var_676_17 + arg_676_0 then
				local var_676_20 = Color.New(0, 0, 0)

				var_676_20.a = 1
				arg_673_1.mask_.color = var_676_20
			end

			local var_676_21 = 2

			if var_676_21 < arg_673_1.time_ and arg_673_1.time_ <= var_676_21 + arg_676_0 then
				arg_673_1.mask_.enabled = true
				arg_673_1.mask_.raycastTarget = true

				arg_673_1:SetGaussion(false)
			end

			local var_676_22 = 2

			if var_676_21 <= arg_673_1.time_ and arg_673_1.time_ < var_676_21 + var_676_22 then
				local var_676_23 = (arg_673_1.time_ - var_676_21) / var_676_22
				local var_676_24 = Color.New(0, 0, 0)

				var_676_24.a = Mathf.Lerp(1, 0, var_676_23)
				arg_673_1.mask_.color = var_676_24
			end

			if arg_673_1.time_ >= var_676_21 + var_676_22 and arg_673_1.time_ < var_676_21 + var_676_22 + arg_676_0 then
				local var_676_25 = Color.New(0, 0, 0)
				local var_676_26 = 0

				arg_673_1.mask_.enabled = false
				var_676_25.a = var_676_26
				arg_673_1.mask_.color = var_676_25
			end

			if arg_673_1.frameCnt_ <= 1 then
				arg_673_1.dialog_:SetActive(false)
			end

			local var_676_27 = 2.93333333333333
			local var_676_28 = 0.875

			if var_676_27 < arg_673_1.time_ and arg_673_1.time_ <= var_676_27 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0

				arg_673_1.dialog_:SetActive(true)

				arg_673_1.dialogCg_.alpha = 0

				local var_676_29 = LeanTween.value(arg_673_1.dialog_, 0, 1, 0.3)

				var_676_29:setOnUpdate(LuaHelper.FloatAction(function(arg_677_0)
					arg_673_1.dialogCg_.alpha = arg_677_0
				end))
				var_676_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_673_1.dialog_)
					var_676_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_673_1.duration_ = arg_673_1.duration_ + 0.3

				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_30 = arg_673_1:GetWordFromCfg(1108106162)
				local var_676_31 = arg_673_1:FormatText(var_676_30.content)

				arg_673_1.text_.text = var_676_31

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_32 = 35
				local var_676_33 = utf8.len(var_676_31)
				local var_676_34 = var_676_32 <= 0 and var_676_28 or var_676_28 * (var_676_33 / var_676_32)

				if var_676_34 > 0 and var_676_28 < var_676_34 then
					arg_673_1.talkMaxDuration = var_676_34
					var_676_27 = var_676_27 + 0.3

					if var_676_34 + var_676_27 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_34 + var_676_27
					end
				end

				arg_673_1.text_.text = var_676_31
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_35 = var_676_27 + 0.3
			local var_676_36 = math.max(var_676_28, arg_673_1.talkMaxDuration)

			if var_676_35 <= arg_673_1.time_ and arg_673_1.time_ < var_676_35 + var_676_36 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_35) / var_676_36

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_35 + var_676_36 and arg_673_1.time_ < var_676_35 + var_676_36 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1108106163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1108106163
		arg_679_1.duration_ = 7.33

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1108106164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0
			local var_682_1 = 0.825

			if var_682_0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_2 = arg_679_1:FormatText(StoryNameCfg[202].name)

				arg_679_1.leftNameTxt_.text = var_682_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_3 = arg_679_1:GetWordFromCfg(1108106163)
				local var_682_4 = arg_679_1:FormatText(var_682_3.content)

				arg_679_1.text_.text = var_682_4

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_5 = 33
				local var_682_6 = utf8.len(var_682_4)
				local var_682_7 = var_682_5 <= 0 and var_682_1 or var_682_1 * (var_682_6 / var_682_5)

				if var_682_7 > 0 and var_682_1 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_0
					end
				end

				arg_679_1.text_.text = var_682_4
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb") ~= 0 then
					local var_682_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb") / 1000

					if var_682_8 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_8 + var_682_0
					end

					if var_682_3.prefab_name ~= "" and arg_679_1.actors_[var_682_3.prefab_name] ~= nil then
						local var_682_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_3.prefab_name].transform, "story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")

						arg_679_1:RecordAudio("1108106163", var_682_9)
						arg_679_1:RecordAudio("1108106163", var_682_9)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106163", "story_v_side_new_1108106.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_10 = math.max(var_682_1, arg_679_1.talkMaxDuration)

			if var_682_0 <= arg_679_1.time_ and arg_679_1.time_ < var_682_0 + var_682_10 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_0) / var_682_10

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_0 + var_682_10 and arg_679_1.time_ < var_682_0 + var_682_10 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1108106164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1108106164
		arg_683_1.duration_ = 6.1

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1108106165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 0.4

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_2 = arg_683_1:FormatText(StoryNameCfg[202].name)

				arg_683_1.leftNameTxt_.text = var_686_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_3 = arg_683_1:GetWordFromCfg(1108106164)
				local var_686_4 = arg_683_1:FormatText(var_686_3.content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 16
				local var_686_6 = utf8.len(var_686_4)
				local var_686_7 = var_686_5 <= 0 and var_686_1 or var_686_1 * (var_686_6 / var_686_5)

				if var_686_7 > 0 and var_686_1 < var_686_7 then
					arg_683_1.talkMaxDuration = var_686_7

					if var_686_7 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_7 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb") ~= 0 then
					local var_686_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb") / 1000

					if var_686_8 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_8 + var_686_0
					end

					if var_686_3.prefab_name ~= "" and arg_683_1.actors_[var_686_3.prefab_name] ~= nil then
						local var_686_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_3.prefab_name].transform, "story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")

						arg_683_1:RecordAudio("1108106164", var_686_9)
						arg_683_1:RecordAudio("1108106164", var_686_9)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106164", "story_v_side_new_1108106.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_10 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_10 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_10

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_10 and arg_683_1.time_ < var_686_0 + var_686_10 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1108106165 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1108106165
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1108106166(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 0.225

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_2 = arg_687_1:FormatText(StoryNameCfg[7].name)

				arg_687_1.leftNameTxt_.text = var_690_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_3 = arg_687_1:GetWordFromCfg(1108106165)
				local var_690_4 = arg_687_1:FormatText(var_690_3.content)

				arg_687_1.text_.text = var_690_4

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 9
				local var_690_6 = utf8.len(var_690_4)
				local var_690_7 = var_690_5 <= 0 and var_690_1 or var_690_1 * (var_690_6 / var_690_5)

				if var_690_7 > 0 and var_690_1 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_0
					end
				end

				arg_687_1.text_.text = var_690_4
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_8 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_8 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_8

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_8 and arg_687_1.time_ < var_690_0 + var_690_8 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1108106166 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1108106166
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1108106167(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0
			local var_694_1 = 0.35

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_2 = arg_691_1:FormatText(StoryNameCfg[7].name)

				arg_691_1.leftNameTxt_.text = var_694_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, true)
				arg_691_1.iconController_:SetSelectedState("hero")

				arg_691_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_691_1.callingController_:SetSelectedState("normal")

				arg_691_1.keyicon_.color = Color.New(1, 1, 1)
				arg_691_1.icon_.color = Color.New(1, 1, 1)

				local var_694_3 = arg_691_1:GetWordFromCfg(1108106166)
				local var_694_4 = arg_691_1:FormatText(var_694_3.content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 14
				local var_694_6 = utf8.len(var_694_4)
				local var_694_7 = var_694_5 <= 0 and var_694_1 or var_694_1 * (var_694_6 / var_694_5)

				if var_694_7 > 0 and var_694_1 < var_694_7 then
					arg_691_1.talkMaxDuration = var_694_7

					if var_694_7 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_7 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_8 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_8 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_8

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_8 and arg_691_1.time_ < var_694_0 + var_694_8 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1108106167 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1108106167
		arg_695_1.duration_ = 3.93

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1108106168(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 0.525

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_2 = arg_695_1:FormatText(StoryNameCfg[202].name)

				arg_695_1.leftNameTxt_.text = var_698_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_3 = arg_695_1:GetWordFromCfg(1108106167)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 21
				local var_698_6 = utf8.len(var_698_4)
				local var_698_7 = var_698_5 <= 0 and var_698_1 or var_698_1 * (var_698_6 / var_698_5)

				if var_698_7 > 0 and var_698_1 < var_698_7 then
					arg_695_1.talkMaxDuration = var_698_7

					if var_698_7 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb") ~= 0 then
					local var_698_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb") / 1000

					if var_698_8 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_8 + var_698_0
					end

					if var_698_3.prefab_name ~= "" and arg_695_1.actors_[var_698_3.prefab_name] ~= nil then
						local var_698_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_3.prefab_name].transform, "story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")

						arg_695_1:RecordAudio("1108106167", var_698_9)
						arg_695_1:RecordAudio("1108106167", var_698_9)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106167", "story_v_side_new_1108106.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_10 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_10 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_10

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_10 and arg_695_1.time_ < var_698_0 + var_698_10 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1108106168 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1108106168
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1108106169(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0
			local var_702_1 = 0.275

			if var_702_0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_2 = arg_699_1:FormatText(StoryNameCfg[7].name)

				arg_699_1.leftNameTxt_.text = var_702_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, true)
				arg_699_1.iconController_:SetSelectedState("hero")

				arg_699_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_699_1.callingController_:SetSelectedState("normal")

				arg_699_1.keyicon_.color = Color.New(1, 1, 1)
				arg_699_1.icon_.color = Color.New(1, 1, 1)

				local var_702_3 = arg_699_1:GetWordFromCfg(1108106168)
				local var_702_4 = arg_699_1:FormatText(var_702_3.content)

				arg_699_1.text_.text = var_702_4

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 11
				local var_702_6 = utf8.len(var_702_4)
				local var_702_7 = var_702_5 <= 0 and var_702_1 or var_702_1 * (var_702_6 / var_702_5)

				if var_702_7 > 0 and var_702_1 < var_702_7 then
					arg_699_1.talkMaxDuration = var_702_7

					if var_702_7 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_7 + var_702_0
					end
				end

				arg_699_1.text_.text = var_702_4
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_8 = math.max(var_702_1, arg_699_1.talkMaxDuration)

			if var_702_0 <= arg_699_1.time_ and arg_699_1.time_ < var_702_0 + var_702_8 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_0) / var_702_8

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_0 + var_702_8 and arg_699_1.time_ < var_702_0 + var_702_8 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1108106169 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1108106169
		arg_703_1.duration_ = 8.03

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1108106170(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = "R8102b"

			if arg_703_1.bgs_[var_706_0] == nil then
				local var_706_1 = Object.Instantiate(arg_703_1.paintGo_)

				var_706_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_706_0)
				var_706_1.name = var_706_0
				var_706_1.transform.parent = arg_703_1.stage_.transform
				var_706_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_703_1.bgs_[var_706_0] = var_706_1
			end

			local var_706_2 = 1.96666666666667

			if var_706_2 < arg_703_1.time_ and arg_703_1.time_ <= var_706_2 + arg_706_0 then
				local var_706_3 = manager.ui.mainCamera.transform.localPosition
				local var_706_4 = Vector3.New(0, 0, 10) + Vector3.New(var_706_3.x, var_706_3.y, 0)
				local var_706_5 = arg_703_1.bgs_.R8102b

				var_706_5.transform.localPosition = var_706_4
				var_706_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_706_6 = var_706_5:GetComponent("SpriteRenderer")

				if var_706_6 and var_706_6.sprite then
					local var_706_7 = (var_706_5.transform.localPosition - var_706_3).z
					local var_706_8 = manager.ui.mainCameraCom_
					local var_706_9 = 2 * var_706_7 * Mathf.Tan(var_706_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_706_10 = var_706_9 * var_706_8.aspect
					local var_706_11 = var_706_6.sprite.bounds.size.x
					local var_706_12 = var_706_6.sprite.bounds.size.y
					local var_706_13 = var_706_10 / var_706_11
					local var_706_14 = var_706_9 / var_706_12
					local var_706_15 = var_706_14 < var_706_13 and var_706_13 or var_706_14

					var_706_5.transform.localScale = Vector3.New(var_706_15, var_706_15, 0)
				end

				for iter_706_0, iter_706_1 in pairs(arg_703_1.bgs_) do
					if iter_706_0 ~= "R8102b" then
						iter_706_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_706_16 = 1.96666666666667

			if var_706_16 < arg_703_1.time_ and arg_703_1.time_ <= var_706_16 + arg_706_0 then
				arg_703_1.allBtn_.enabled = false
			end

			local var_706_17 = 0.3

			if arg_703_1.time_ >= var_706_16 + var_706_17 and arg_703_1.time_ < var_706_16 + var_706_17 + arg_706_0 then
				arg_703_1.allBtn_.enabled = true
			end

			local var_706_18 = 0

			if var_706_18 < arg_703_1.time_ and arg_703_1.time_ <= var_706_18 + arg_706_0 then
				arg_703_1.mask_.enabled = true
				arg_703_1.mask_.raycastTarget = true

				arg_703_1:SetGaussion(false)
			end

			local var_706_19 = 1.96666666666667

			if var_706_18 <= arg_703_1.time_ and arg_703_1.time_ < var_706_18 + var_706_19 then
				local var_706_20 = (arg_703_1.time_ - var_706_18) / var_706_19
				local var_706_21 = Color.New(0, 0, 0)

				var_706_21.a = Mathf.Lerp(0, 1, var_706_20)
				arg_703_1.mask_.color = var_706_21
			end

			if arg_703_1.time_ >= var_706_18 + var_706_19 and arg_703_1.time_ < var_706_18 + var_706_19 + arg_706_0 then
				local var_706_22 = Color.New(0, 0, 0)

				var_706_22.a = 1
				arg_703_1.mask_.color = var_706_22
			end

			local var_706_23 = 1.96666666666667

			if var_706_23 < arg_703_1.time_ and arg_703_1.time_ <= var_706_23 + arg_706_0 then
				arg_703_1.mask_.enabled = true
				arg_703_1.mask_.raycastTarget = true

				arg_703_1:SetGaussion(false)
			end

			local var_706_24 = 2

			if var_706_23 <= arg_703_1.time_ and arg_703_1.time_ < var_706_23 + var_706_24 then
				local var_706_25 = (arg_703_1.time_ - var_706_23) / var_706_24
				local var_706_26 = Color.New(0, 0, 0)

				var_706_26.a = Mathf.Lerp(1, 0, var_706_25)
				arg_703_1.mask_.color = var_706_26
			end

			if arg_703_1.time_ >= var_706_23 + var_706_24 and arg_703_1.time_ < var_706_23 + var_706_24 + arg_706_0 then
				local var_706_27 = Color.New(0, 0, 0)
				local var_706_28 = 0

				arg_703_1.mask_.enabled = false
				var_706_27.a = var_706_28
				arg_703_1.mask_.color = var_706_27
			end

			if arg_703_1.frameCnt_ <= 1 then
				arg_703_1.dialog_:SetActive(false)
			end

			local var_706_29 = 3.03333333333333
			local var_706_30 = 0.775

			if var_706_29 < arg_703_1.time_ and arg_703_1.time_ <= var_706_29 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0

				arg_703_1.dialog_:SetActive(true)

				arg_703_1.dialogCg_.alpha = 0

				local var_706_31 = LeanTween.value(arg_703_1.dialog_, 0, 1, 0.3)

				var_706_31:setOnUpdate(LuaHelper.FloatAction(function(arg_707_0)
					arg_703_1.dialogCg_.alpha = arg_707_0
				end))
				var_706_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_703_1.dialog_)
					var_706_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_703_1.duration_ = arg_703_1.duration_ + 0.3

				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_32 = arg_703_1:GetWordFromCfg(1108106169)
				local var_706_33 = arg_703_1:FormatText(var_706_32.content)

				arg_703_1.text_.text = var_706_33

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_34 = 31
				local var_706_35 = utf8.len(var_706_33)
				local var_706_36 = var_706_34 <= 0 and var_706_30 or var_706_30 * (var_706_35 / var_706_34)

				if var_706_36 > 0 and var_706_30 < var_706_36 then
					arg_703_1.talkMaxDuration = var_706_36
					var_706_29 = var_706_29 + 0.3

					if var_706_36 + var_706_29 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_36 + var_706_29
					end
				end

				arg_703_1.text_.text = var_706_33
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_37 = var_706_29 + 0.3
			local var_706_38 = math.max(var_706_30, arg_703_1.talkMaxDuration)

			if var_706_37 <= arg_703_1.time_ and arg_703_1.time_ < var_706_37 + var_706_38 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_37) / var_706_38

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_37 + var_706_38 and arg_703_1.time_ < var_706_37 + var_706_38 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1108106170 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1108106170
		arg_709_1.duration_ = 5.6

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1108106171(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = 0
			local var_712_1 = 0.825

			if var_712_0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_0 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				local var_712_2 = arg_709_1:FormatText(StoryNameCfg[202].name)

				arg_709_1.leftNameTxt_.text = var_712_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_3 = arg_709_1:GetWordFromCfg(1108106170)
				local var_712_4 = arg_709_1:FormatText(var_712_3.content)

				arg_709_1.text_.text = var_712_4

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_5 = 33
				local var_712_6 = utf8.len(var_712_4)
				local var_712_7 = var_712_5 <= 0 and var_712_1 or var_712_1 * (var_712_6 / var_712_5)

				if var_712_7 > 0 and var_712_1 < var_712_7 then
					arg_709_1.talkMaxDuration = var_712_7

					if var_712_7 + var_712_0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_7 + var_712_0
					end
				end

				arg_709_1.text_.text = var_712_4
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb") ~= 0 then
					local var_712_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb") / 1000

					if var_712_8 + var_712_0 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_8 + var_712_0
					end

					if var_712_3.prefab_name ~= "" and arg_709_1.actors_[var_712_3.prefab_name] ~= nil then
						local var_712_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_3.prefab_name].transform, "story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")

						arg_709_1:RecordAudio("1108106170", var_712_9)
						arg_709_1:RecordAudio("1108106170", var_712_9)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106170", "story_v_side_new_1108106.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_10 = math.max(var_712_1, arg_709_1.talkMaxDuration)

			if var_712_0 <= arg_709_1.time_ and arg_709_1.time_ < var_712_0 + var_712_10 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_0) / var_712_10

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_0 + var_712_10 and arg_709_1.time_ < var_712_0 + var_712_10 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1108106171 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1108106171
		arg_713_1.duration_ = 5.9

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1108106172(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0
			local var_716_1 = 0.725

			if var_716_0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_2 = arg_713_1:FormatText(StoryNameCfg[202].name)

				arg_713_1.leftNameTxt_.text = var_716_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_3 = arg_713_1:GetWordFromCfg(1108106171)
				local var_716_4 = arg_713_1:FormatText(var_716_3.content)

				arg_713_1.text_.text = var_716_4

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_5 = 29
				local var_716_6 = utf8.len(var_716_4)
				local var_716_7 = var_716_5 <= 0 and var_716_1 or var_716_1 * (var_716_6 / var_716_5)

				if var_716_7 > 0 and var_716_1 < var_716_7 then
					arg_713_1.talkMaxDuration = var_716_7

					if var_716_7 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_7 + var_716_0
					end
				end

				arg_713_1.text_.text = var_716_4
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb") ~= 0 then
					local var_716_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb") / 1000

					if var_716_8 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_8 + var_716_0
					end

					if var_716_3.prefab_name ~= "" and arg_713_1.actors_[var_716_3.prefab_name] ~= nil then
						local var_716_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_3.prefab_name].transform, "story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")

						arg_713_1:RecordAudio("1108106171", var_716_9)
						arg_713_1:RecordAudio("1108106171", var_716_9)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106171", "story_v_side_new_1108106.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_10 = math.max(var_716_1, arg_713_1.talkMaxDuration)

			if var_716_0 <= arg_713_1.time_ and arg_713_1.time_ < var_716_0 + var_716_10 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_0) / var_716_10

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_0 + var_716_10 and arg_713_1.time_ < var_716_0 + var_716_10 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play1108106172 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1108106172
		arg_717_1.duration_ = 3.07

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1108106173(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0
			local var_720_1 = 0.3

			if var_720_0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_2 = arg_717_1:FormatText(StoryNameCfg[202].name)

				arg_717_1.leftNameTxt_.text = var_720_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_3 = arg_717_1:GetWordFromCfg(1108106172)
				local var_720_4 = arg_717_1:FormatText(var_720_3.content)

				arg_717_1.text_.text = var_720_4

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_5 = 12
				local var_720_6 = utf8.len(var_720_4)
				local var_720_7 = var_720_5 <= 0 and var_720_1 or var_720_1 * (var_720_6 / var_720_5)

				if var_720_7 > 0 and var_720_1 < var_720_7 then
					arg_717_1.talkMaxDuration = var_720_7

					if var_720_7 + var_720_0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_7 + var_720_0
					end
				end

				arg_717_1.text_.text = var_720_4
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb") ~= 0 then
					local var_720_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb") / 1000

					if var_720_8 + var_720_0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_8 + var_720_0
					end

					if var_720_3.prefab_name ~= "" and arg_717_1.actors_[var_720_3.prefab_name] ~= nil then
						local var_720_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_3.prefab_name].transform, "story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")

						arg_717_1:RecordAudio("1108106172", var_720_9)
						arg_717_1:RecordAudio("1108106172", var_720_9)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106172", "story_v_side_new_1108106.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_10 = math.max(var_720_1, arg_717_1.talkMaxDuration)

			if var_720_0 <= arg_717_1.time_ and arg_717_1.time_ < var_720_0 + var_720_10 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_0) / var_720_10

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_0 + var_720_10 and arg_717_1.time_ < var_720_0 + var_720_10 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1108106173 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1108106173
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1108106174(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 0
			local var_724_1 = 1.2

			if var_724_0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_2 = arg_721_1:GetWordFromCfg(1108106173)
				local var_724_3 = arg_721_1:FormatText(var_724_2.content)

				arg_721_1.text_.text = var_724_3

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_4 = 48
				local var_724_5 = utf8.len(var_724_3)
				local var_724_6 = var_724_4 <= 0 and var_724_1 or var_724_1 * (var_724_5 / var_724_4)

				if var_724_6 > 0 and var_724_1 < var_724_6 then
					arg_721_1.talkMaxDuration = var_724_6

					if var_724_6 + var_724_0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_6 + var_724_0
					end
				end

				arg_721_1.text_.text = var_724_3
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_7 = math.max(var_724_1, arg_721_1.talkMaxDuration)

			if var_724_0 <= arg_721_1.time_ and arg_721_1.time_ < var_724_0 + var_724_7 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_0) / var_724_7

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_0 + var_724_7 and arg_721_1.time_ < var_724_0 + var_724_7 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1108106174 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1108106174
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1108106175(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = 0
			local var_728_1 = 0.05

			if var_728_0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_0 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				local var_728_2 = arg_725_1:FormatText(StoryNameCfg[7].name)

				arg_725_1.leftNameTxt_.text = var_728_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, true)
				arg_725_1.iconController_:SetSelectedState("hero")

				arg_725_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_725_1.callingController_:SetSelectedState("normal")

				arg_725_1.keyicon_.color = Color.New(1, 1, 1)
				arg_725_1.icon_.color = Color.New(1, 1, 1)

				local var_728_3 = arg_725_1:GetWordFromCfg(1108106174)
				local var_728_4 = arg_725_1:FormatText(var_728_3.content)

				arg_725_1.text_.text = var_728_4

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_5 = 2
				local var_728_6 = utf8.len(var_728_4)
				local var_728_7 = var_728_5 <= 0 and var_728_1 or var_728_1 * (var_728_6 / var_728_5)

				if var_728_7 > 0 and var_728_1 < var_728_7 then
					arg_725_1.talkMaxDuration = var_728_7

					if var_728_7 + var_728_0 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_7 + var_728_0
					end
				end

				arg_725_1.text_.text = var_728_4
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_8 = math.max(var_728_1, arg_725_1.talkMaxDuration)

			if var_728_0 <= arg_725_1.time_ and arg_725_1.time_ < var_728_0 + var_728_8 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_0) / var_728_8

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_0 + var_728_8 and arg_725_1.time_ < var_728_0 + var_728_8 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play1108106175 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1108106175
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1108106176(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0
			local var_732_1 = 0.425

			if var_732_0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_2 = arg_729_1:FormatText(StoryNameCfg[7].name)

				arg_729_1.leftNameTxt_.text = var_732_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_3 = arg_729_1:GetWordFromCfg(1108106175)
				local var_732_4 = arg_729_1:FormatText(var_732_3.content)

				arg_729_1.text_.text = var_732_4

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 17
				local var_732_6 = utf8.len(var_732_4)
				local var_732_7 = var_732_5 <= 0 and var_732_1 or var_732_1 * (var_732_6 / var_732_5)

				if var_732_7 > 0 and var_732_1 < var_732_7 then
					arg_729_1.talkMaxDuration = var_732_7

					if var_732_7 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_7 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_4
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1108106176 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1108106176
		arg_733_1.duration_ = 5.13

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1108106177(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 0
			local var_736_1 = 0.55

			if var_736_0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				local var_736_2 = arg_733_1:FormatText(StoryNameCfg[202].name)

				arg_733_1.leftNameTxt_.text = var_736_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_3 = arg_733_1:GetWordFromCfg(1108106176)
				local var_736_4 = arg_733_1:FormatText(var_736_3.content)

				arg_733_1.text_.text = var_736_4

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 22
				local var_736_6 = utf8.len(var_736_4)
				local var_736_7 = var_736_5 <= 0 and var_736_1 or var_736_1 * (var_736_6 / var_736_5)

				if var_736_7 > 0 and var_736_1 < var_736_7 then
					arg_733_1.talkMaxDuration = var_736_7

					if var_736_7 + var_736_0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_7 + var_736_0
					end
				end

				arg_733_1.text_.text = var_736_4
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb") ~= 0 then
					local var_736_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb") / 1000

					if var_736_8 + var_736_0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_8 + var_736_0
					end

					if var_736_3.prefab_name ~= "" and arg_733_1.actors_[var_736_3.prefab_name] ~= nil then
						local var_736_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_733_1.actors_[var_736_3.prefab_name].transform, "story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")

						arg_733_1:RecordAudio("1108106176", var_736_9)
						arg_733_1:RecordAudio("1108106176", var_736_9)
					else
						arg_733_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")
					end

					arg_733_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106176", "story_v_side_new_1108106.awb")
				end

				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_10 = math.max(var_736_1, arg_733_1.talkMaxDuration)

			if var_736_0 <= arg_733_1.time_ and arg_733_1.time_ < var_736_0 + var_736_10 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_0) / var_736_10

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_0 + var_736_10 and arg_733_1.time_ < var_736_0 + var_736_10 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play1108106177 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1108106177
		arg_737_1.duration_ = 3.5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1108106178(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0
			local var_740_1 = 0.3

			if var_740_0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_2 = arg_737_1:FormatText(StoryNameCfg[202].name)

				arg_737_1.leftNameTxt_.text = var_740_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_3 = arg_737_1:GetWordFromCfg(1108106177)
				local var_740_4 = arg_737_1:FormatText(var_740_3.content)

				arg_737_1.text_.text = var_740_4

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_5 = 12
				local var_740_6 = utf8.len(var_740_4)
				local var_740_7 = var_740_5 <= 0 and var_740_1 or var_740_1 * (var_740_6 / var_740_5)

				if var_740_7 > 0 and var_740_1 < var_740_7 then
					arg_737_1.talkMaxDuration = var_740_7

					if var_740_7 + var_740_0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_7 + var_740_0
					end
				end

				arg_737_1.text_.text = var_740_4
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb") ~= 0 then
					local var_740_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb") / 1000

					if var_740_8 + var_740_0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_8 + var_740_0
					end

					if var_740_3.prefab_name ~= "" and arg_737_1.actors_[var_740_3.prefab_name] ~= nil then
						local var_740_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_3.prefab_name].transform, "story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")

						arg_737_1:RecordAudio("1108106177", var_740_9)
						arg_737_1:RecordAudio("1108106177", var_740_9)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106177", "story_v_side_new_1108106.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_10 = math.max(var_740_1, arg_737_1.talkMaxDuration)

			if var_740_0 <= arg_737_1.time_ and arg_737_1.time_ < var_740_0 + var_740_10 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_0) / var_740_10

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_0 + var_740_10 and arg_737_1.time_ < var_740_0 + var_740_10 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1108106178 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1108106178
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1108106179(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0
			local var_744_1 = 0.275

			if var_744_0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_2 = arg_741_1:FormatText(StoryNameCfg[7].name)

				arg_741_1.leftNameTxt_.text = var_744_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, true)
				arg_741_1.iconController_:SetSelectedState("hero")

				arg_741_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_741_1.callingController_:SetSelectedState("normal")

				arg_741_1.keyicon_.color = Color.New(1, 1, 1)
				arg_741_1.icon_.color = Color.New(1, 1, 1)

				local var_744_3 = arg_741_1:GetWordFromCfg(1108106178)
				local var_744_4 = arg_741_1:FormatText(var_744_3.content)

				arg_741_1.text_.text = var_744_4

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_5 = 11
				local var_744_6 = utf8.len(var_744_4)
				local var_744_7 = var_744_5 <= 0 and var_744_1 or var_744_1 * (var_744_6 / var_744_5)

				if var_744_7 > 0 and var_744_1 < var_744_7 then
					arg_741_1.talkMaxDuration = var_744_7

					if var_744_7 + var_744_0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_7 + var_744_0
					end
				end

				arg_741_1.text_.text = var_744_4
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_8 = math.max(var_744_1, arg_741_1.talkMaxDuration)

			if var_744_0 <= arg_741_1.time_ and arg_741_1.time_ < var_744_0 + var_744_8 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_0) / var_744_8

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_0 + var_744_8 and arg_741_1.time_ < var_744_0 + var_744_8 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1108106179 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1108106179
		arg_745_1.duration_ = 4

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1108106180(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0
			local var_748_1 = 0.45

			if var_748_0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				local var_748_2 = arg_745_1:FormatText(StoryNameCfg[202].name)

				arg_745_1.leftNameTxt_.text = var_748_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_3 = arg_745_1:GetWordFromCfg(1108106179)
				local var_748_4 = arg_745_1:FormatText(var_748_3.content)

				arg_745_1.text_.text = var_748_4

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_5 = 18
				local var_748_6 = utf8.len(var_748_4)
				local var_748_7 = var_748_5 <= 0 and var_748_1 or var_748_1 * (var_748_6 / var_748_5)

				if var_748_7 > 0 and var_748_1 < var_748_7 then
					arg_745_1.talkMaxDuration = var_748_7

					if var_748_7 + var_748_0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_7 + var_748_0
					end
				end

				arg_745_1.text_.text = var_748_4
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb") ~= 0 then
					local var_748_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb") / 1000

					if var_748_8 + var_748_0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_8 + var_748_0
					end

					if var_748_3.prefab_name ~= "" and arg_745_1.actors_[var_748_3.prefab_name] ~= nil then
						local var_748_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_745_1.actors_[var_748_3.prefab_name].transform, "story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")

						arg_745_1:RecordAudio("1108106179", var_748_9)
						arg_745_1:RecordAudio("1108106179", var_748_9)
					else
						arg_745_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")
					end

					arg_745_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106179", "story_v_side_new_1108106.awb")
				end

				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_10 = math.max(var_748_1, arg_745_1.talkMaxDuration)

			if var_748_0 <= arg_745_1.time_ and arg_745_1.time_ < var_748_0 + var_748_10 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_0) / var_748_10

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_0 + var_748_10 and arg_745_1.time_ < var_748_0 + var_748_10 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1108106180 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1108106180
		arg_749_1.duration_ = 6.2

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1108106181(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 1

			if var_752_0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				local var_752_1 = manager.ui.mainCamera.transform.localPosition
				local var_752_2 = Vector3.New(0, 0, 10) + Vector3.New(var_752_1.x, var_752_1.y, 0)
				local var_752_3 = arg_749_1.bgs_.H01b

				var_752_3.transform.localPosition = var_752_2
				var_752_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_752_4 = var_752_3:GetComponent("SpriteRenderer")

				if var_752_4 and var_752_4.sprite then
					local var_752_5 = (var_752_3.transform.localPosition - var_752_1).z
					local var_752_6 = manager.ui.mainCameraCom_
					local var_752_7 = 2 * var_752_5 * Mathf.Tan(var_752_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_752_8 = var_752_7 * var_752_6.aspect
					local var_752_9 = var_752_4.sprite.bounds.size.x
					local var_752_10 = var_752_4.sprite.bounds.size.y
					local var_752_11 = var_752_8 / var_752_9
					local var_752_12 = var_752_7 / var_752_10
					local var_752_13 = var_752_12 < var_752_11 and var_752_11 or var_752_12

					var_752_3.transform.localScale = Vector3.New(var_752_13, var_752_13, 0)
				end

				for iter_752_0, iter_752_1 in pairs(arg_749_1.bgs_) do
					if iter_752_0 ~= "H01b" then
						iter_752_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_752_14 = 1

			if var_752_14 < arg_749_1.time_ and arg_749_1.time_ <= var_752_14 + arg_752_0 then
				arg_749_1.allBtn_.enabled = false
			end

			local var_752_15 = 0.3

			if arg_749_1.time_ >= var_752_14 + var_752_15 and arg_749_1.time_ < var_752_14 + var_752_15 + arg_752_0 then
				arg_749_1.allBtn_.enabled = true
			end

			local var_752_16 = 0

			if var_752_16 < arg_749_1.time_ and arg_749_1.time_ <= var_752_16 + arg_752_0 then
				arg_749_1.mask_.enabled = true
				arg_749_1.mask_.raycastTarget = true

				arg_749_1:SetGaussion(false)
			end

			local var_752_17 = 1

			if var_752_16 <= arg_749_1.time_ and arg_749_1.time_ < var_752_16 + var_752_17 then
				local var_752_18 = (arg_749_1.time_ - var_752_16) / var_752_17
				local var_752_19 = Color.New(0, 0, 0)

				var_752_19.a = Mathf.Lerp(0, 1, var_752_18)
				arg_749_1.mask_.color = var_752_19
			end

			if arg_749_1.time_ >= var_752_16 + var_752_17 and arg_749_1.time_ < var_752_16 + var_752_17 + arg_752_0 then
				local var_752_20 = Color.New(0, 0, 0)

				var_752_20.a = 1
				arg_749_1.mask_.color = var_752_20
			end

			local var_752_21 = 1

			if var_752_21 < arg_749_1.time_ and arg_749_1.time_ <= var_752_21 + arg_752_0 then
				arg_749_1.mask_.enabled = true
				arg_749_1.mask_.raycastTarget = true

				arg_749_1:SetGaussion(false)
			end

			local var_752_22 = 1.93333333333333

			if var_752_21 <= arg_749_1.time_ and arg_749_1.time_ < var_752_21 + var_752_22 then
				local var_752_23 = (arg_749_1.time_ - var_752_21) / var_752_22
				local var_752_24 = Color.New(0, 0, 0)

				var_752_24.a = Mathf.Lerp(1, 0, var_752_23)
				arg_749_1.mask_.color = var_752_24
			end

			if arg_749_1.time_ >= var_752_21 + var_752_22 and arg_749_1.time_ < var_752_21 + var_752_22 + arg_752_0 then
				local var_752_25 = Color.New(0, 0, 0)
				local var_752_26 = 0

				arg_749_1.mask_.enabled = false
				var_752_25.a = var_752_26
				arg_749_1.mask_.color = var_752_25
			end

			local var_752_27 = arg_749_1.actors_["1081ui_story"].transform
			local var_752_28 = 1

			if var_752_28 < arg_749_1.time_ and arg_749_1.time_ <= var_752_28 + arg_752_0 then
				arg_749_1.var_.moveOldPos1081ui_story = var_752_27.localPosition
			end

			local var_752_29 = 0.001

			if var_752_28 <= arg_749_1.time_ and arg_749_1.time_ < var_752_28 + var_752_29 then
				local var_752_30 = (arg_749_1.time_ - var_752_28) / var_752_29
				local var_752_31 = Vector3.New(0, -0.92, -5.8)

				var_752_27.localPosition = Vector3.Lerp(arg_749_1.var_.moveOldPos1081ui_story, var_752_31, var_752_30)

				local var_752_32 = manager.ui.mainCamera.transform.position - var_752_27.position

				var_752_27.forward = Vector3.New(var_752_32.x, var_752_32.y, var_752_32.z)

				local var_752_33 = var_752_27.localEulerAngles

				var_752_33.z = 0
				var_752_33.x = 0
				var_752_27.localEulerAngles = var_752_33
			end

			if arg_749_1.time_ >= var_752_28 + var_752_29 and arg_749_1.time_ < var_752_28 + var_752_29 + arg_752_0 then
				var_752_27.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_752_34 = manager.ui.mainCamera.transform.position - var_752_27.position

				var_752_27.forward = Vector3.New(var_752_34.x, var_752_34.y, var_752_34.z)

				local var_752_35 = var_752_27.localEulerAngles

				var_752_35.z = 0
				var_752_35.x = 0
				var_752_27.localEulerAngles = var_752_35
			end

			local var_752_36 = arg_749_1.actors_["1081ui_story"]
			local var_752_37 = 1

			if var_752_37 < arg_749_1.time_ and arg_749_1.time_ <= var_752_37 + arg_752_0 and not isNil(var_752_36) and arg_749_1.var_.characterEffect1081ui_story == nil then
				arg_749_1.var_.characterEffect1081ui_story = var_752_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_38 = 0.2

			if var_752_37 <= arg_749_1.time_ and arg_749_1.time_ < var_752_37 + var_752_38 and not isNil(var_752_36) then
				local var_752_39 = (arg_749_1.time_ - var_752_37) / var_752_38

				if arg_749_1.var_.characterEffect1081ui_story and not isNil(var_752_36) then
					arg_749_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_749_1.time_ >= var_752_37 + var_752_38 and arg_749_1.time_ < var_752_37 + var_752_38 + arg_752_0 and not isNil(var_752_36) and arg_749_1.var_.characterEffect1081ui_story then
				arg_749_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_752_40 = 1

			if var_752_40 < arg_749_1.time_ and arg_749_1.time_ <= var_752_40 + arg_752_0 then
				arg_749_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_1")
			end

			local var_752_41 = 1

			if var_752_41 < arg_749_1.time_ and arg_749_1.time_ <= var_752_41 + arg_752_0 then
				arg_749_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_752_42 = 1
			local var_752_43 = 1

			if var_752_42 < arg_749_1.time_ and arg_749_1.time_ <= var_752_42 + arg_752_0 then
				local var_752_44 = "stop"
				local var_752_45 = "effect"

				arg_749_1:AudioAction(var_752_44, var_752_45, "se_story_123_01", "se_story_123_01_flame1", "")
			end

			if arg_749_1.frameCnt_ <= 1 then
				arg_749_1.dialog_:SetActive(false)
			end

			local var_752_46 = 1.2
			local var_752_47 = 0.55

			if var_752_46 < arg_749_1.time_ and arg_749_1.time_ <= var_752_46 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0

				arg_749_1.dialog_:SetActive(true)

				arg_749_1.dialogCg_.alpha = 0

				local var_752_48 = LeanTween.value(arg_749_1.dialog_, 0, 1, 0.3)

				var_752_48:setOnUpdate(LuaHelper.FloatAction(function(arg_753_0)
					arg_749_1.dialogCg_.alpha = arg_753_0
				end))
				var_752_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_749_1.dialog_)
					var_752_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_749_1.duration_ = arg_749_1.duration_ + 0.3

				SetActive(arg_749_1.leftNameGo_, true)

				local var_752_49 = arg_749_1:FormatText(StoryNameCfg[202].name)

				arg_749_1.leftNameTxt_.text = var_752_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_50 = arg_749_1:GetWordFromCfg(1108106180)
				local var_752_51 = arg_749_1:FormatText(var_752_50.content)

				arg_749_1.text_.text = var_752_51

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_52 = 22
				local var_752_53 = utf8.len(var_752_51)
				local var_752_54 = var_752_52 <= 0 and var_752_47 or var_752_47 * (var_752_53 / var_752_52)

				if var_752_54 > 0 and var_752_47 < var_752_54 then
					arg_749_1.talkMaxDuration = var_752_54
					var_752_46 = var_752_46 + 0.3

					if var_752_54 + var_752_46 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_54 + var_752_46
					end
				end

				arg_749_1.text_.text = var_752_51
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb") ~= 0 then
					local var_752_55 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb") / 1000

					if var_752_55 + var_752_46 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_55 + var_752_46
					end

					if var_752_50.prefab_name ~= "" and arg_749_1.actors_[var_752_50.prefab_name] ~= nil then
						local var_752_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_749_1.actors_[var_752_50.prefab_name].transform, "story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")

						arg_749_1:RecordAudio("1108106180", var_752_56)
						arg_749_1:RecordAudio("1108106180", var_752_56)
					else
						arg_749_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")
					end

					arg_749_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106180", "story_v_side_new_1108106.awb")
				end

				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_57 = var_752_46 + 0.3
			local var_752_58 = math.max(var_752_47, arg_749_1.talkMaxDuration)

			if var_752_57 <= arg_749_1.time_ and arg_749_1.time_ < var_752_57 + var_752_58 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_57) / var_752_58

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_57 + var_752_58 and arg_749_1.time_ < var_752_57 + var_752_58 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_749_1:InitPlayNodeList()
	end,
	Play1108106181 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 1108106181
		arg_755_1.duration_ = 2.93

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play1108106182(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = 0

			if var_758_0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_0 + arg_758_0 then
				arg_755_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action9_2")
			end

			local var_758_1 = 0

			if var_758_1 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_758_2 = 0
			local var_758_3 = 0.225

			if var_758_2 < arg_755_1.time_ and arg_755_1.time_ <= var_758_2 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				local var_758_4 = arg_755_1:FormatText(StoryNameCfg[202].name)

				arg_755_1.leftNameTxt_.text = var_758_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_5 = arg_755_1:GetWordFromCfg(1108106181)
				local var_758_6 = arg_755_1:FormatText(var_758_5.content)

				arg_755_1.text_.text = var_758_6

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_7 = 9
				local var_758_8 = utf8.len(var_758_6)
				local var_758_9 = var_758_7 <= 0 and var_758_3 or var_758_3 * (var_758_8 / var_758_7)

				if var_758_9 > 0 and var_758_3 < var_758_9 then
					arg_755_1.talkMaxDuration = var_758_9

					if var_758_9 + var_758_2 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_9 + var_758_2
					end
				end

				arg_755_1.text_.text = var_758_6
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb") ~= 0 then
					local var_758_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb") / 1000

					if var_758_10 + var_758_2 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_10 + var_758_2
					end

					if var_758_5.prefab_name ~= "" and arg_755_1.actors_[var_758_5.prefab_name] ~= nil then
						local var_758_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_755_1.actors_[var_758_5.prefab_name].transform, "story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")

						arg_755_1:RecordAudio("1108106181", var_758_11)
						arg_755_1:RecordAudio("1108106181", var_758_11)
					else
						arg_755_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")
					end

					arg_755_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106181", "story_v_side_new_1108106.awb")
				end

				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_12 = math.max(var_758_3, arg_755_1.talkMaxDuration)

			if var_758_2 <= arg_755_1.time_ and arg_755_1.time_ < var_758_2 + var_758_12 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_2) / var_758_12

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_2 + var_758_12 and arg_755_1.time_ < var_758_2 + var_758_12 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play1108106182 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 1108106182
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play1108106183(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = arg_759_1.actors_["1081ui_story"].transform
			local var_762_1 = 0

			if var_762_1 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				arg_759_1.var_.moveOldPos1081ui_story = var_762_0.localPosition
			end

			local var_762_2 = 0.001

			if var_762_1 <= arg_759_1.time_ and arg_759_1.time_ < var_762_1 + var_762_2 then
				local var_762_3 = (arg_759_1.time_ - var_762_1) / var_762_2
				local var_762_4 = Vector3.New(0, 100, 0)

				var_762_0.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1081ui_story, var_762_4, var_762_3)

				local var_762_5 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_5.x, var_762_5.y, var_762_5.z)

				local var_762_6 = var_762_0.localEulerAngles

				var_762_6.z = 0
				var_762_6.x = 0
				var_762_0.localEulerAngles = var_762_6
			end

			if arg_759_1.time_ >= var_762_1 + var_762_2 and arg_759_1.time_ < var_762_1 + var_762_2 + arg_762_0 then
				var_762_0.localPosition = Vector3.New(0, 100, 0)

				local var_762_7 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_7.x, var_762_7.y, var_762_7.z)

				local var_762_8 = var_762_0.localEulerAngles

				var_762_8.z = 0
				var_762_8.x = 0
				var_762_0.localEulerAngles = var_762_8
			end

			local var_762_9 = 0
			local var_762_10 = 0.7

			if var_762_9 < arg_759_1.time_ and arg_759_1.time_ <= var_762_9 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, false)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_11 = arg_759_1:GetWordFromCfg(1108106182)
				local var_762_12 = arg_759_1:FormatText(var_762_11.content)

				arg_759_1.text_.text = var_762_12

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_13 = 28
				local var_762_14 = utf8.len(var_762_12)
				local var_762_15 = var_762_13 <= 0 and var_762_10 or var_762_10 * (var_762_14 / var_762_13)

				if var_762_15 > 0 and var_762_10 < var_762_15 then
					arg_759_1.talkMaxDuration = var_762_15

					if var_762_15 + var_762_9 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_15 + var_762_9
					end
				end

				arg_759_1.text_.text = var_762_12
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_16 = math.max(var_762_10, arg_759_1.talkMaxDuration)

			if var_762_9 <= arg_759_1.time_ and arg_759_1.time_ < var_762_9 + var_762_16 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_9) / var_762_16

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_9 + var_762_16 and arg_759_1.time_ < var_762_9 + var_762_16 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_759_1:InitPlayNodeList()
	end,
	Play1108106183 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 1108106183
		arg_763_1.duration_ = 1.63

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play1108106184(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0
			local var_766_1 = 0.075

			if var_766_0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				local var_766_2 = arg_763_1:FormatText(StoryNameCfg[202].name)

				arg_763_1.leftNameTxt_.text = var_766_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, true)
				arg_763_1.iconController_:SetSelectedState("hero")

				arg_763_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_763_1.callingController_:SetSelectedState("normal")

				arg_763_1.keyicon_.color = Color.New(1, 1, 1)
				arg_763_1.icon_.color = Color.New(1, 1, 1)

				local var_766_3 = arg_763_1:GetWordFromCfg(1108106183)
				local var_766_4 = arg_763_1:FormatText(var_766_3.content)

				arg_763_1.text_.text = var_766_4

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_5 = 3
				local var_766_6 = utf8.len(var_766_4)
				local var_766_7 = var_766_5 <= 0 and var_766_1 or var_766_1 * (var_766_6 / var_766_5)

				if var_766_7 > 0 and var_766_1 < var_766_7 then
					arg_763_1.talkMaxDuration = var_766_7

					if var_766_7 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_7 + var_766_0
					end
				end

				arg_763_1.text_.text = var_766_4
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb") ~= 0 then
					local var_766_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb") / 1000

					if var_766_8 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_8 + var_766_0
					end

					if var_766_3.prefab_name ~= "" and arg_763_1.actors_[var_766_3.prefab_name] ~= nil then
						local var_766_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_3.prefab_name].transform, "story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")

						arg_763_1:RecordAudio("1108106183", var_766_9)
						arg_763_1:RecordAudio("1108106183", var_766_9)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106183", "story_v_side_new_1108106.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_10 = math.max(var_766_1, arg_763_1.talkMaxDuration)

			if var_766_0 <= arg_763_1.time_ and arg_763_1.time_ < var_766_0 + var_766_10 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_0) / var_766_10

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_0 + var_766_10 and arg_763_1.time_ < var_766_0 + var_766_10 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play1108106184 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 1108106184
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play1108106185(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = 0
			local var_770_1 = 0.425

			if var_770_0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_0 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				local var_770_2 = arg_767_1:FormatText(StoryNameCfg[7].name)

				arg_767_1.leftNameTxt_.text = var_770_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, true)
				arg_767_1.iconController_:SetSelectedState("hero")

				arg_767_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_767_1.callingController_:SetSelectedState("normal")

				arg_767_1.keyicon_.color = Color.New(1, 1, 1)
				arg_767_1.icon_.color = Color.New(1, 1, 1)

				local var_770_3 = arg_767_1:GetWordFromCfg(1108106184)
				local var_770_4 = arg_767_1:FormatText(var_770_3.content)

				arg_767_1.text_.text = var_770_4

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_5 = 17
				local var_770_6 = utf8.len(var_770_4)
				local var_770_7 = var_770_5 <= 0 and var_770_1 or var_770_1 * (var_770_6 / var_770_5)

				if var_770_7 > 0 and var_770_1 < var_770_7 then
					arg_767_1.talkMaxDuration = var_770_7

					if var_770_7 + var_770_0 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_7 + var_770_0
					end
				end

				arg_767_1.text_.text = var_770_4
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_8 = math.max(var_770_1, arg_767_1.talkMaxDuration)

			if var_770_0 <= arg_767_1.time_ and arg_767_1.time_ < var_770_0 + var_770_8 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_0) / var_770_8

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_0 + var_770_8 and arg_767_1.time_ < var_770_0 + var_770_8 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play1108106185 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 1108106185
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play1108106186(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0
			local var_774_1 = 0.45

			if var_774_0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, true)

				local var_774_2 = arg_771_1:FormatText(StoryNameCfg[7].name)

				arg_771_1.leftNameTxt_.text = var_774_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_771_1.leftNameTxt_.transform)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1.leftNameTxt_.text)
				SetActive(arg_771_1.iconTrs_.gameObject, true)
				arg_771_1.iconController_:SetSelectedState("hero")

				arg_771_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_771_1.callingController_:SetSelectedState("normal")

				arg_771_1.keyicon_.color = Color.New(1, 1, 1)
				arg_771_1.icon_.color = Color.New(1, 1, 1)

				local var_774_3 = arg_771_1:GetWordFromCfg(1108106185)
				local var_774_4 = arg_771_1:FormatText(var_774_3.content)

				arg_771_1.text_.text = var_774_4

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_5 = 18
				local var_774_6 = utf8.len(var_774_4)
				local var_774_7 = var_774_5 <= 0 and var_774_1 or var_774_1 * (var_774_6 / var_774_5)

				if var_774_7 > 0 and var_774_1 < var_774_7 then
					arg_771_1.talkMaxDuration = var_774_7

					if var_774_7 + var_774_0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_7 + var_774_0
					end
				end

				arg_771_1.text_.text = var_774_4
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_8 = math.max(var_774_1, arg_771_1.talkMaxDuration)

			if var_774_0 <= arg_771_1.time_ and arg_771_1.time_ < var_774_0 + var_774_8 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_0) / var_774_8

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_0 + var_774_8 and arg_771_1.time_ < var_774_0 + var_774_8 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play1108106186 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 1108106186
		arg_775_1.duration_ = 5

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play1108106187(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			local var_778_0 = 0
			local var_778_1 = 1

			if var_778_0 < arg_775_1.time_ and arg_775_1.time_ <= var_778_0 + arg_778_0 then
				local var_778_2 = "stop"
				local var_778_3 = "music"

				arg_775_1:AudioAction(var_778_2, var_778_3, "se_story_123_01", "se_story_123_flame1", "")

				local var_778_4 = ""
				local var_778_5 = manager.audio:GetAudioName("se_story_123_01", "se_story_123_flame1")

				if var_778_5 ~= "" then
					if arg_775_1.bgmTxt_.text ~= var_778_5 and arg_775_1.bgmTxt_.text ~= "" then
						if arg_775_1.bgmTxt2_.text ~= "" then
							arg_775_1.bgmTxt_.text = arg_775_1.bgmTxt2_.text
						end

						arg_775_1.bgmTxt2_.text = var_778_5

						arg_775_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_775_1.bgmTxt_.text = var_778_5
						arg_775_1.bgmTxt2_.text = var_778_5
					end

					if arg_775_1.bgmTimer then
						arg_775_1.bgmTimer:Stop()

						arg_775_1.bgmTimer = nil
					end

					if arg_775_1.settingData.show_music_name == 1 then
						arg_775_1.musicController:SetSelectedState("show")
						arg_775_1.musicAnimator_:Play("open", 0, 0)

						if arg_775_1.settingData.music_time ~= 0 then
							arg_775_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_775_1.settingData.music_time), function()
								if arg_775_1 == nil or isNil(arg_775_1.bgmTxt_) then
									return
								end

								arg_775_1.musicController:SetSelectedState("hide")
								arg_775_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_778_6 = 0
			local var_778_7 = 0.85

			if var_778_6 < arg_775_1.time_ and arg_775_1.time_ <= var_778_6 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, false)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_8 = arg_775_1:GetWordFromCfg(1108106186)
				local var_778_9 = arg_775_1:FormatText(var_778_8.content)

				arg_775_1.text_.text = var_778_9

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_10 = 34
				local var_778_11 = utf8.len(var_778_9)
				local var_778_12 = var_778_10 <= 0 and var_778_7 or var_778_7 * (var_778_11 / var_778_10)

				if var_778_12 > 0 and var_778_7 < var_778_12 then
					arg_775_1.talkMaxDuration = var_778_12

					if var_778_12 + var_778_6 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_12 + var_778_6
					end
				end

				arg_775_1.text_.text = var_778_9
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)
				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_13 = math.max(var_778_7, arg_775_1.talkMaxDuration)

			if var_778_6 <= arg_775_1.time_ and arg_775_1.time_ < var_778_6 + var_778_13 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_6) / var_778_13

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_6 + var_778_13 and arg_775_1.time_ < var_778_6 + var_778_13 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {}

		arg_775_1:InitPlayNodeList()
	end,
	Play1108106187 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1108106187
		arg_780_1.duration_ = 8.57

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1108106188(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			local var_783_0 = 3.56666666666667

			if var_783_0 < arg_780_1.time_ and arg_780_1.time_ <= var_783_0 + arg_783_0 then
				arg_780_1.allBtn_.enabled = false
			end

			local var_783_1 = 0.3

			if arg_780_1.time_ >= var_783_0 + var_783_1 and arg_780_1.time_ < var_783_0 + var_783_1 + arg_783_0 then
				arg_780_1.allBtn_.enabled = true
			end

			local var_783_2 = "ST12"

			if arg_780_1.bgs_[var_783_2] == nil then
				local var_783_3 = Object.Instantiate(arg_780_1.paintGo_)

				var_783_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_783_2)
				var_783_3.name = var_783_2
				var_783_3.transform.parent = arg_780_1.stage_.transform
				var_783_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_780_1.bgs_[var_783_2] = var_783_3
			end

			local var_783_4 = 2

			if var_783_4 < arg_780_1.time_ and arg_780_1.time_ <= var_783_4 + arg_783_0 then
				local var_783_5 = manager.ui.mainCamera.transform.localPosition
				local var_783_6 = Vector3.New(0, 0, 10) + Vector3.New(var_783_5.x, var_783_5.y, 0)
				local var_783_7 = arg_780_1.bgs_.ST12

				var_783_7.transform.localPosition = var_783_6
				var_783_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_783_8 = var_783_7:GetComponent("SpriteRenderer")

				if var_783_8 and var_783_8.sprite then
					local var_783_9 = (var_783_7.transform.localPosition - var_783_5).z
					local var_783_10 = manager.ui.mainCameraCom_
					local var_783_11 = 2 * var_783_9 * Mathf.Tan(var_783_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_783_12 = var_783_11 * var_783_10.aspect
					local var_783_13 = var_783_8.sprite.bounds.size.x
					local var_783_14 = var_783_8.sprite.bounds.size.y
					local var_783_15 = var_783_12 / var_783_13
					local var_783_16 = var_783_11 / var_783_14
					local var_783_17 = var_783_16 < var_783_15 and var_783_15 or var_783_16

					var_783_7.transform.localScale = Vector3.New(var_783_17, var_783_17, 0)
				end

				for iter_783_0, iter_783_1 in pairs(arg_780_1.bgs_) do
					if iter_783_0 ~= "ST12" then
						iter_783_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_783_18 = 0

			if var_783_18 < arg_780_1.time_ and arg_780_1.time_ <= var_783_18 + arg_783_0 then
				arg_780_1.mask_.enabled = true
				arg_780_1.mask_.raycastTarget = true

				arg_780_1:SetGaussion(false)
			end

			local var_783_19 = 2

			if var_783_18 <= arg_780_1.time_ and arg_780_1.time_ < var_783_18 + var_783_19 then
				local var_783_20 = (arg_780_1.time_ - var_783_18) / var_783_19
				local var_783_21 = Color.New(0, 0, 0)

				var_783_21.a = Mathf.Lerp(0, 1, var_783_20)
				arg_780_1.mask_.color = var_783_21
			end

			if arg_780_1.time_ >= var_783_18 + var_783_19 and arg_780_1.time_ < var_783_18 + var_783_19 + arg_783_0 then
				local var_783_22 = Color.New(0, 0, 0)

				var_783_22.a = 1
				arg_780_1.mask_.color = var_783_22
			end

			local var_783_23 = 2

			if var_783_23 < arg_780_1.time_ and arg_780_1.time_ <= var_783_23 + arg_783_0 then
				arg_780_1.mask_.enabled = true
				arg_780_1.mask_.raycastTarget = true

				arg_780_1:SetGaussion(false)
			end

			local var_783_24 = 2

			if var_783_23 <= arg_780_1.time_ and arg_780_1.time_ < var_783_23 + var_783_24 then
				local var_783_25 = (arg_780_1.time_ - var_783_23) / var_783_24
				local var_783_26 = Color.New(0, 0, 0)

				var_783_26.a = Mathf.Lerp(1, 0, var_783_25)
				arg_780_1.mask_.color = var_783_26
			end

			if arg_780_1.time_ >= var_783_23 + var_783_24 and arg_780_1.time_ < var_783_23 + var_783_24 + arg_783_0 then
				local var_783_27 = Color.New(0, 0, 0)
				local var_783_28 = 0

				arg_780_1.mask_.enabled = false
				var_783_27.a = var_783_28
				arg_780_1.mask_.color = var_783_27
			end

			local var_783_29 = 2
			local var_783_30 = 0.166666666666667

			if var_783_29 < arg_780_1.time_ and arg_780_1.time_ <= var_783_29 + arg_783_0 then
				local var_783_31 = "play"
				local var_783_32 = "music"

				arg_780_1:AudioAction(var_783_31, var_783_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_783_33 = ""
				local var_783_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_783_34 ~= "" then
					if arg_780_1.bgmTxt_.text ~= var_783_34 and arg_780_1.bgmTxt_.text ~= "" then
						if arg_780_1.bgmTxt2_.text ~= "" then
							arg_780_1.bgmTxt_.text = arg_780_1.bgmTxt2_.text
						end

						arg_780_1.bgmTxt2_.text = var_783_34

						arg_780_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_780_1.bgmTxt_.text = var_783_34
						arg_780_1.bgmTxt2_.text = var_783_34
					end

					if arg_780_1.bgmTimer then
						arg_780_1.bgmTimer:Stop()

						arg_780_1.bgmTimer = nil
					end

					if arg_780_1.settingData.show_music_name == 1 then
						arg_780_1.musicController:SetSelectedState("show")
						arg_780_1.musicAnimator_:Play("open", 0, 0)

						if arg_780_1.settingData.music_time ~= 0 then
							arg_780_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_780_1.settingData.music_time), function()
								if arg_780_1 == nil or isNil(arg_780_1.bgmTxt_) then
									return
								end

								arg_780_1.musicController:SetSelectedState("hide")
								arg_780_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_780_1.frameCnt_ <= 1 then
				arg_780_1.dialog_:SetActive(false)
			end

			local var_783_35 = 3.56666666666667
			local var_783_36 = 0.9

			if var_783_35 < arg_780_1.time_ and arg_780_1.time_ <= var_783_35 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0

				arg_780_1.dialog_:SetActive(true)

				arg_780_1.dialogCg_.alpha = 0

				local var_783_37 = LeanTween.value(arg_780_1.dialog_, 0, 1, 0.3)

				var_783_37:setOnUpdate(LuaHelper.FloatAction(function(arg_785_0)
					arg_780_1.dialogCg_.alpha = arg_785_0
				end))
				var_783_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_780_1.dialog_)
					var_783_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_780_1.duration_ = arg_780_1.duration_ + 0.3

				SetActive(arg_780_1.leftNameGo_, false)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_38 = arg_780_1:GetWordFromCfg(1108106187)
				local var_783_39 = arg_780_1:FormatText(var_783_38.content)

				arg_780_1.text_.text = var_783_39

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_40 = 36
				local var_783_41 = utf8.len(var_783_39)
				local var_783_42 = var_783_40 <= 0 and var_783_36 or var_783_36 * (var_783_41 / var_783_40)

				if var_783_42 > 0 and var_783_36 < var_783_42 then
					arg_780_1.talkMaxDuration = var_783_42
					var_783_35 = var_783_35 + 0.3

					if var_783_42 + var_783_35 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_42 + var_783_35
					end
				end

				arg_780_1.text_.text = var_783_39
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)
				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_43 = var_783_35 + 0.3
			local var_783_44 = math.max(var_783_36, arg_780_1.talkMaxDuration)

			if var_783_43 <= arg_780_1.time_ and arg_780_1.time_ < var_783_43 + var_783_44 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_43) / var_783_44

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_43 + var_783_44 and arg_780_1.time_ < var_783_43 + var_783_44 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1108106188 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 1108106188
		arg_787_1.duration_ = 5

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play1108106189(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			local var_790_0 = 0
			local var_790_1 = 0.75

			if var_790_0 < arg_787_1.time_ and arg_787_1.time_ <= var_790_0 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, false)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_2 = arg_787_1:GetWordFromCfg(1108106188)
				local var_790_3 = arg_787_1:FormatText(var_790_2.content)

				arg_787_1.text_.text = var_790_3

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_4 = 30
				local var_790_5 = utf8.len(var_790_3)
				local var_790_6 = var_790_4 <= 0 and var_790_1 or var_790_1 * (var_790_5 / var_790_4)

				if var_790_6 > 0 and var_790_1 < var_790_6 then
					arg_787_1.talkMaxDuration = var_790_6

					if var_790_6 + var_790_0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_6 + var_790_0
					end
				end

				arg_787_1.text_.text = var_790_3
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)
				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_7 = math.max(var_790_1, arg_787_1.talkMaxDuration)

			if var_790_0 <= arg_787_1.time_ and arg_787_1.time_ < var_790_0 + var_790_7 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - var_790_0) / var_790_7

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= var_790_0 + var_790_7 and arg_787_1.time_ < var_790_0 + var_790_7 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {}

		arg_787_1:InitPlayNodeList()
	end,
	Play1108106189 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 1108106189
		arg_791_1.duration_ = 1

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"

			SetActive(arg_791_1.choicesGo_, true)

			for iter_792_0, iter_792_1 in ipairs(arg_791_1.choices_) do
				local var_792_0 = iter_792_0 <= 1

				SetActive(iter_792_1.go, var_792_0)
			end

			arg_791_1.choices_[1].txt.text = arg_791_1:FormatText(StoryChoiceCfg[997].name)
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play1108106190(arg_791_1)
			end

			arg_791_1:RecordChoiceLog(1108106189, 997)
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			return
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play1108106190 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 1108106190
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play1108106191(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0
			local var_798_1 = 0.15

			if var_798_0 < arg_795_1.time_ and arg_795_1.time_ <= var_798_0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				local var_798_2 = arg_795_1:FormatText(StoryNameCfg[7].name)

				arg_795_1.leftNameTxt_.text = var_798_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, true)
				arg_795_1.iconController_:SetSelectedState("hero")

				arg_795_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_795_1.callingController_:SetSelectedState("normal")

				arg_795_1.keyicon_.color = Color.New(1, 1, 1)
				arg_795_1.icon_.color = Color.New(1, 1, 1)

				local var_798_3 = arg_795_1:GetWordFromCfg(1108106190)
				local var_798_4 = arg_795_1:FormatText(var_798_3.content)

				arg_795_1.text_.text = var_798_4

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_5 = 6
				local var_798_6 = utf8.len(var_798_4)
				local var_798_7 = var_798_5 <= 0 and var_798_1 or var_798_1 * (var_798_6 / var_798_5)

				if var_798_7 > 0 and var_798_1 < var_798_7 then
					arg_795_1.talkMaxDuration = var_798_7

					if var_798_7 + var_798_0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_7 + var_798_0
					end
				end

				arg_795_1.text_.text = var_798_4
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_8 = math.max(var_798_1, arg_795_1.talkMaxDuration)

			if var_798_0 <= arg_795_1.time_ and arg_795_1.time_ < var_798_0 + var_798_8 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_0) / var_798_8

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_0 + var_798_8 and arg_795_1.time_ < var_798_0 + var_798_8 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play1108106191 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 1108106191
		arg_799_1.duration_ = 5

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play1108106192(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = 0
			local var_802_1 = 0.25

			if var_802_0 < arg_799_1.time_ and arg_799_1.time_ <= var_802_0 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				local var_802_2 = arg_799_1:FormatText(StoryNameCfg[7].name)

				arg_799_1.leftNameTxt_.text = var_802_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, true)
				arg_799_1.iconController_:SetSelectedState("hero")

				arg_799_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_799_1.callingController_:SetSelectedState("normal")

				arg_799_1.keyicon_.color = Color.New(1, 1, 1)
				arg_799_1.icon_.color = Color.New(1, 1, 1)

				local var_802_3 = arg_799_1:GetWordFromCfg(1108106191)
				local var_802_4 = arg_799_1:FormatText(var_802_3.content)

				arg_799_1.text_.text = var_802_4

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_5 = 10
				local var_802_6 = utf8.len(var_802_4)
				local var_802_7 = var_802_5 <= 0 and var_802_1 or var_802_1 * (var_802_6 / var_802_5)

				if var_802_7 > 0 and var_802_1 < var_802_7 then
					arg_799_1.talkMaxDuration = var_802_7

					if var_802_7 + var_802_0 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_7 + var_802_0
					end
				end

				arg_799_1.text_.text = var_802_4
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)
				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_8 = math.max(var_802_1, arg_799_1.talkMaxDuration)

			if var_802_0 <= arg_799_1.time_ and arg_799_1.time_ < var_802_0 + var_802_8 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_0) / var_802_8

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_0 + var_802_8 and arg_799_1.time_ < var_802_0 + var_802_8 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {}

		arg_799_1:InitPlayNodeList()
	end,
	Play1108106192 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 1108106192
		arg_803_1.duration_ = 7.87

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play1108106193(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = "ST07b"

			if arg_803_1.bgs_[var_806_0] == nil then
				local var_806_1 = Object.Instantiate(arg_803_1.paintGo_)

				var_806_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_806_0)
				var_806_1.name = var_806_0
				var_806_1.transform.parent = arg_803_1.stage_.transform
				var_806_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_803_1.bgs_[var_806_0] = var_806_1
			end

			local var_806_2 = 1.999999999999

			if var_806_2 < arg_803_1.time_ and arg_803_1.time_ <= var_806_2 + arg_806_0 then
				local var_806_3 = manager.ui.mainCamera.transform.localPosition
				local var_806_4 = Vector3.New(0, 0, 10) + Vector3.New(var_806_3.x, var_806_3.y, 0)
				local var_806_5 = arg_803_1.bgs_.ST07b

				var_806_5.transform.localPosition = var_806_4
				var_806_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_806_6 = var_806_5:GetComponent("SpriteRenderer")

				if var_806_6 and var_806_6.sprite then
					local var_806_7 = (var_806_5.transform.localPosition - var_806_3).z
					local var_806_8 = manager.ui.mainCameraCom_
					local var_806_9 = 2 * var_806_7 * Mathf.Tan(var_806_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_806_10 = var_806_9 * var_806_8.aspect
					local var_806_11 = var_806_6.sprite.bounds.size.x
					local var_806_12 = var_806_6.sprite.bounds.size.y
					local var_806_13 = var_806_10 / var_806_11
					local var_806_14 = var_806_9 / var_806_12
					local var_806_15 = var_806_14 < var_806_13 and var_806_13 or var_806_14

					var_806_5.transform.localScale = Vector3.New(var_806_15, var_806_15, 0)
				end

				for iter_806_0, iter_806_1 in pairs(arg_803_1.bgs_) do
					if iter_806_0 ~= "ST07b" then
						iter_806_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_806_16 = 0

			if var_806_16 < arg_803_1.time_ and arg_803_1.time_ <= var_806_16 + arg_806_0 then
				arg_803_1.mask_.enabled = true
				arg_803_1.mask_.raycastTarget = true

				arg_803_1:SetGaussion(false)
			end

			local var_806_17 = 2

			if var_806_16 <= arg_803_1.time_ and arg_803_1.time_ < var_806_16 + var_806_17 then
				local var_806_18 = (arg_803_1.time_ - var_806_16) / var_806_17
				local var_806_19 = Color.New(0, 0, 0)

				var_806_19.a = Mathf.Lerp(0, 1, var_806_18)
				arg_803_1.mask_.color = var_806_19
			end

			if arg_803_1.time_ >= var_806_16 + var_806_17 and arg_803_1.time_ < var_806_16 + var_806_17 + arg_806_0 then
				local var_806_20 = Color.New(0, 0, 0)

				var_806_20.a = 1
				arg_803_1.mask_.color = var_806_20
			end

			local var_806_21 = 1.999999999999

			if var_806_21 < arg_803_1.time_ and arg_803_1.time_ <= var_806_21 + arg_806_0 then
				arg_803_1.mask_.enabled = true
				arg_803_1.mask_.raycastTarget = true

				arg_803_1:SetGaussion(false)
			end

			local var_806_22 = 2

			if var_806_21 <= arg_803_1.time_ and arg_803_1.time_ < var_806_21 + var_806_22 then
				local var_806_23 = (arg_803_1.time_ - var_806_21) / var_806_22
				local var_806_24 = Color.New(0, 0, 0)

				var_806_24.a = Mathf.Lerp(1, 0, var_806_23)
				arg_803_1.mask_.color = var_806_24
			end

			if arg_803_1.time_ >= var_806_21 + var_806_22 and arg_803_1.time_ < var_806_21 + var_806_22 + arg_806_0 then
				local var_806_25 = Color.New(0, 0, 0)
				local var_806_26 = 0

				arg_803_1.mask_.enabled = false
				var_806_25.a = var_806_26
				arg_803_1.mask_.color = var_806_25
			end

			local var_806_27 = "10066ui_story"

			if arg_803_1.actors_[var_806_27] == nil then
				local var_806_28 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_806_28) then
					local var_806_29 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_803_1.stage_.transform)

					var_806_29.name = var_806_27
					var_806_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_803_1.actors_[var_806_27] = var_806_29

					local var_806_30 = var_806_29:GetComponentInChildren(typeof(CharacterEffect))

					var_806_30.enabled = true

					local var_806_31 = GameObjectTools.GetOrAddComponent(var_806_29, typeof(DynamicBoneHelper))

					if var_806_31 then
						var_806_31:EnableDynamicBone(false)
					end

					arg_803_1:ShowWeapon(var_806_30.transform, false)

					arg_803_1.var_[var_806_27 .. "Animator"] = var_806_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_803_1.var_[var_806_27 .. "Animator"].applyRootMotion = true
					arg_803_1.var_[var_806_27 .. "LipSync"] = var_806_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_806_32 = 1.999999999999

			if var_806_32 < arg_803_1.time_ and arg_803_1.time_ <= var_806_32 + arg_806_0 then
				arg_803_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_806_33 = 1.999999999999

			if var_806_33 < arg_803_1.time_ and arg_803_1.time_ <= var_806_33 + arg_806_0 then
				arg_803_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_806_34 = arg_803_1.actors_["10066ui_story"]
			local var_806_35 = 1.999999999999

			if var_806_35 < arg_803_1.time_ and arg_803_1.time_ <= var_806_35 + arg_806_0 and not isNil(var_806_34) and arg_803_1.var_.characterEffect10066ui_story == nil then
				arg_803_1.var_.characterEffect10066ui_story = var_806_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_36 = 0.0833333333333335

			if var_806_35 <= arg_803_1.time_ and arg_803_1.time_ < var_806_35 + var_806_36 and not isNil(var_806_34) then
				local var_806_37 = (arg_803_1.time_ - var_806_35) / var_806_36

				if arg_803_1.var_.characterEffect10066ui_story and not isNil(var_806_34) then
					arg_803_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_803_1.time_ >= var_806_35 + var_806_36 and arg_803_1.time_ < var_806_35 + var_806_36 + arg_806_0 and not isNil(var_806_34) and arg_803_1.var_.characterEffect10066ui_story then
				arg_803_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_806_38 = arg_803_1.actors_["10066ui_story"].transform
			local var_806_39 = 1.999999999999

			if var_806_39 < arg_803_1.time_ and arg_803_1.time_ <= var_806_39 + arg_806_0 then
				arg_803_1.var_.moveOldPos10066ui_story = var_806_38.localPosition
			end

			local var_806_40 = 0.001

			if var_806_39 <= arg_803_1.time_ and arg_803_1.time_ < var_806_39 + var_806_40 then
				local var_806_41 = (arg_803_1.time_ - var_806_39) / var_806_40
				local var_806_42 = Vector3.New(0, -0.99, -5.83)

				var_806_38.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos10066ui_story, var_806_42, var_806_41)

				local var_806_43 = manager.ui.mainCamera.transform.position - var_806_38.position

				var_806_38.forward = Vector3.New(var_806_43.x, var_806_43.y, var_806_43.z)

				local var_806_44 = var_806_38.localEulerAngles

				var_806_44.z = 0
				var_806_44.x = 0
				var_806_38.localEulerAngles = var_806_44
			end

			if arg_803_1.time_ >= var_806_39 + var_806_40 and arg_803_1.time_ < var_806_39 + var_806_40 + arg_806_0 then
				var_806_38.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_806_45 = manager.ui.mainCamera.transform.position - var_806_38.position

				var_806_38.forward = Vector3.New(var_806_45.x, var_806_45.y, var_806_45.z)

				local var_806_46 = var_806_38.localEulerAngles

				var_806_46.z = 0
				var_806_46.x = 0
				var_806_38.localEulerAngles = var_806_46
			end

			local var_806_47 = 2
			local var_806_48 = 0.85

			if var_806_47 < arg_803_1.time_ and arg_803_1.time_ <= var_806_47 + arg_806_0 then
				local var_806_49 = "play"
				local var_806_50 = "music"

				arg_803_1:AudioAction(var_806_49, var_806_50, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_806_51 = ""
				local var_806_52 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_806_52 ~= "" then
					if arg_803_1.bgmTxt_.text ~= var_806_52 and arg_803_1.bgmTxt_.text ~= "" then
						if arg_803_1.bgmTxt2_.text ~= "" then
							arg_803_1.bgmTxt_.text = arg_803_1.bgmTxt2_.text
						end

						arg_803_1.bgmTxt2_.text = var_806_52

						arg_803_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_803_1.bgmTxt_.text = var_806_52
						arg_803_1.bgmTxt2_.text = var_806_52
					end

					if arg_803_1.bgmTimer then
						arg_803_1.bgmTimer:Stop()

						arg_803_1.bgmTimer = nil
					end

					if arg_803_1.settingData.show_music_name == 1 then
						arg_803_1.musicController:SetSelectedState("show")
						arg_803_1.musicAnimator_:Play("open", 0, 0)

						if arg_803_1.settingData.music_time ~= 0 then
							arg_803_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_803_1.settingData.music_time), function()
								if arg_803_1 == nil or isNil(arg_803_1.bgmTxt_) then
									return
								end

								arg_803_1.musicController:SetSelectedState("hide")
								arg_803_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_803_1.frameCnt_ <= 1 then
				arg_803_1.dialog_:SetActive(false)
			end

			local var_806_53 = 2.66666666666667
			local var_806_54 = 0.45

			if var_806_53 < arg_803_1.time_ and arg_803_1.time_ <= var_806_53 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0

				arg_803_1.dialog_:SetActive(true)

				arg_803_1.dialogCg_.alpha = 0

				local var_806_55 = LeanTween.value(arg_803_1.dialog_, 0, 1, 0.3)

				var_806_55:setOnUpdate(LuaHelper.FloatAction(function(arg_808_0)
					arg_803_1.dialogCg_.alpha = arg_808_0
				end))
				var_806_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_803_1.dialog_)
					var_806_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_803_1.duration_ = arg_803_1.duration_ + 0.3

				SetActive(arg_803_1.leftNameGo_, true)

				local var_806_56 = arg_803_1:FormatText(StoryNameCfg[640].name)

				arg_803_1.leftNameTxt_.text = var_806_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_57 = arg_803_1:GetWordFromCfg(1108106192)
				local var_806_58 = arg_803_1:FormatText(var_806_57.content)

				arg_803_1.text_.text = var_806_58

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_59 = 18
				local var_806_60 = utf8.len(var_806_58)
				local var_806_61 = var_806_59 <= 0 and var_806_54 or var_806_54 * (var_806_60 / var_806_59)

				if var_806_61 > 0 and var_806_54 < var_806_61 then
					arg_803_1.talkMaxDuration = var_806_61
					var_806_53 = var_806_53 + 0.3

					if var_806_61 + var_806_53 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_61 + var_806_53
					end
				end

				arg_803_1.text_.text = var_806_58
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb") ~= 0 then
					local var_806_62 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb") / 1000

					if var_806_62 + var_806_53 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_62 + var_806_53
					end

					if var_806_57.prefab_name ~= "" and arg_803_1.actors_[var_806_57.prefab_name] ~= nil then
						local var_806_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_803_1.actors_[var_806_57.prefab_name].transform, "story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")

						arg_803_1:RecordAudio("1108106192", var_806_63)
						arg_803_1:RecordAudio("1108106192", var_806_63)
					else
						arg_803_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")
					end

					arg_803_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106192", "story_v_side_new_1108106.awb")
				end

				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_64 = var_806_53 + 0.3
			local var_806_65 = math.max(var_806_54, arg_803_1.talkMaxDuration)

			if var_806_64 <= arg_803_1.time_ and arg_803_1.time_ < var_806_64 + var_806_65 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_64) / var_806_65

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_64 + var_806_65 and arg_803_1.time_ < var_806_64 + var_806_65 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play1108106193 = function(arg_810_0, arg_810_1)
		arg_810_1.time_ = 0
		arg_810_1.frameCnt_ = 0
		arg_810_1.state_ = "playing"
		arg_810_1.curTalkId_ = 1108106193
		arg_810_1.duration_ = 5

		SetActive(arg_810_1.tipsGo_, false)

		function arg_810_1.onSingleLineFinish_()
			arg_810_1.onSingleLineUpdate_ = nil
			arg_810_1.onSingleLineFinish_ = nil
			arg_810_1.state_ = "waiting"
		end

		function arg_810_1.playNext_(arg_812_0)
			if arg_812_0 == 1 then
				arg_810_0:Play1108106194(arg_810_1)
			end
		end

		function arg_810_1.onSingleLineUpdate_(arg_813_0)
			local var_813_0 = arg_810_1.actors_["10066ui_story"].transform
			local var_813_1 = 0

			if var_813_1 < arg_810_1.time_ and arg_810_1.time_ <= var_813_1 + arg_813_0 then
				arg_810_1.var_.moveOldPos10066ui_story = var_813_0.localPosition
			end

			local var_813_2 = 0.001

			if var_813_1 <= arg_810_1.time_ and arg_810_1.time_ < var_813_1 + var_813_2 then
				local var_813_3 = (arg_810_1.time_ - var_813_1) / var_813_2
				local var_813_4 = Vector3.New(0, 100, 0)

				var_813_0.localPosition = Vector3.Lerp(arg_810_1.var_.moveOldPos10066ui_story, var_813_4, var_813_3)

				local var_813_5 = manager.ui.mainCamera.transform.position - var_813_0.position

				var_813_0.forward = Vector3.New(var_813_5.x, var_813_5.y, var_813_5.z)

				local var_813_6 = var_813_0.localEulerAngles

				var_813_6.z = 0
				var_813_6.x = 0
				var_813_0.localEulerAngles = var_813_6
			end

			if arg_810_1.time_ >= var_813_1 + var_813_2 and arg_810_1.time_ < var_813_1 + var_813_2 + arg_813_0 then
				var_813_0.localPosition = Vector3.New(0, 100, 0)

				local var_813_7 = manager.ui.mainCamera.transform.position - var_813_0.position

				var_813_0.forward = Vector3.New(var_813_7.x, var_813_7.y, var_813_7.z)

				local var_813_8 = var_813_0.localEulerAngles

				var_813_8.z = 0
				var_813_8.x = 0
				var_813_0.localEulerAngles = var_813_8
			end

			local var_813_9 = 0
			local var_813_10 = 1.15

			if var_813_9 < arg_810_1.time_ and arg_810_1.time_ <= var_813_9 + arg_813_0 then
				arg_810_1.talkMaxDuration = 0
				arg_810_1.dialogCg_.alpha = 1

				arg_810_1.dialog_:SetActive(true)
				SetActive(arg_810_1.leftNameGo_, false)

				arg_810_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_810_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_810_1:RecordName(arg_810_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_810_1.iconTrs_.gameObject, false)
				arg_810_1.callingController_:SetSelectedState("normal")

				local var_813_11 = arg_810_1:GetWordFromCfg(1108106193)
				local var_813_12 = arg_810_1:FormatText(var_813_11.content)

				arg_810_1.text_.text = var_813_12

				LuaForUtil.ClearLinePrefixSymbol(arg_810_1.text_)

				local var_813_13 = 46
				local var_813_14 = utf8.len(var_813_12)
				local var_813_15 = var_813_13 <= 0 and var_813_10 or var_813_10 * (var_813_14 / var_813_13)

				if var_813_15 > 0 and var_813_10 < var_813_15 then
					arg_810_1.talkMaxDuration = var_813_15

					if var_813_15 + var_813_9 > arg_810_1.duration_ then
						arg_810_1.duration_ = var_813_15 + var_813_9
					end
				end

				arg_810_1.text_.text = var_813_12
				arg_810_1.typewritter.percent = 0

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(false)
				arg_810_1:RecordContent(arg_810_1.text_.text)
			end

			local var_813_16 = math.max(var_813_10, arg_810_1.talkMaxDuration)

			if var_813_9 <= arg_810_1.time_ and arg_810_1.time_ < var_813_9 + var_813_16 then
				arg_810_1.typewritter.percent = (arg_810_1.time_ - var_813_9) / var_813_16

				arg_810_1.typewritter:SetDirty()
			end

			if arg_810_1.time_ >= var_813_9 + var_813_16 and arg_810_1.time_ < var_813_9 + var_813_16 + arg_813_0 then
				arg_810_1.typewritter.percent = 1

				arg_810_1.typewritter:SetDirty()
				arg_810_1:ShowNextGo(true)
			end
		end

		arg_810_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_810_1:InitPlayNodeList()
	end,
	Play1108106194 = function(arg_814_0, arg_814_1)
		arg_814_1.time_ = 0
		arg_814_1.frameCnt_ = 0
		arg_814_1.state_ = "playing"
		arg_814_1.curTalkId_ = 1108106194
		arg_814_1.duration_ = 6.93

		SetActive(arg_814_1.tipsGo_, false)

		function arg_814_1.onSingleLineFinish_()
			arg_814_1.onSingleLineUpdate_ = nil
			arg_814_1.onSingleLineFinish_ = nil
			arg_814_1.state_ = "waiting"
		end

		function arg_814_1.playNext_(arg_816_0)
			if arg_816_0 == 1 then
				arg_814_0:Play1108106195(arg_814_1)
			end
		end

		function arg_814_1.onSingleLineUpdate_(arg_817_0)
			local var_817_0 = arg_814_1.actors_["10066ui_story"].transform
			local var_817_1 = 0

			if var_817_1 < arg_814_1.time_ and arg_814_1.time_ <= var_817_1 + arg_817_0 then
				arg_814_1.var_.moveOldPos10066ui_story = var_817_0.localPosition
			end

			local var_817_2 = 0.001

			if var_817_1 <= arg_814_1.time_ and arg_814_1.time_ < var_817_1 + var_817_2 then
				local var_817_3 = (arg_814_1.time_ - var_817_1) / var_817_2
				local var_817_4 = Vector3.New(0, -0.99, -5.83)

				var_817_0.localPosition = Vector3.Lerp(arg_814_1.var_.moveOldPos10066ui_story, var_817_4, var_817_3)

				local var_817_5 = manager.ui.mainCamera.transform.position - var_817_0.position

				var_817_0.forward = Vector3.New(var_817_5.x, var_817_5.y, var_817_5.z)

				local var_817_6 = var_817_0.localEulerAngles

				var_817_6.z = 0
				var_817_6.x = 0
				var_817_0.localEulerAngles = var_817_6
			end

			if arg_814_1.time_ >= var_817_1 + var_817_2 and arg_814_1.time_ < var_817_1 + var_817_2 + arg_817_0 then
				var_817_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_817_7 = manager.ui.mainCamera.transform.position - var_817_0.position

				var_817_0.forward = Vector3.New(var_817_7.x, var_817_7.y, var_817_7.z)

				local var_817_8 = var_817_0.localEulerAngles

				var_817_8.z = 0
				var_817_8.x = 0
				var_817_0.localEulerAngles = var_817_8
			end

			local var_817_9 = arg_814_1.actors_["10066ui_story"]
			local var_817_10 = 0

			if var_817_10 < arg_814_1.time_ and arg_814_1.time_ <= var_817_10 + arg_817_0 and not isNil(var_817_9) and arg_814_1.var_.characterEffect10066ui_story == nil then
				arg_814_1.var_.characterEffect10066ui_story = var_817_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_817_11 = 0.034000001847744

			if var_817_10 <= arg_814_1.time_ and arg_814_1.time_ < var_817_10 + var_817_11 and not isNil(var_817_9) then
				local var_817_12 = (arg_814_1.time_ - var_817_10) / var_817_11

				if arg_814_1.var_.characterEffect10066ui_story and not isNil(var_817_9) then
					arg_814_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_814_1.time_ >= var_817_10 + var_817_11 and arg_814_1.time_ < var_817_10 + var_817_11 + arg_817_0 and not isNil(var_817_9) and arg_814_1.var_.characterEffect10066ui_story then
				arg_814_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_817_13 = 0

			if var_817_13 < arg_814_1.time_ and arg_814_1.time_ <= var_817_13 + arg_817_0 then
				arg_814_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_817_14 = 0

			if var_817_14 < arg_814_1.time_ and arg_814_1.time_ <= var_817_14 + arg_817_0 then
				arg_814_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_817_15 = 0
			local var_817_16 = 0.725

			if var_817_15 < arg_814_1.time_ and arg_814_1.time_ <= var_817_15 + arg_817_0 then
				arg_814_1.talkMaxDuration = 0
				arg_814_1.dialogCg_.alpha = 1

				arg_814_1.dialog_:SetActive(true)
				SetActive(arg_814_1.leftNameGo_, true)

				local var_817_17 = arg_814_1:FormatText(StoryNameCfg[640].name)

				arg_814_1.leftNameTxt_.text = var_817_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_814_1.leftNameTxt_.transform)

				arg_814_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_814_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_814_1:RecordName(arg_814_1.leftNameTxt_.text)
				SetActive(arg_814_1.iconTrs_.gameObject, false)
				arg_814_1.callingController_:SetSelectedState("normal")

				local var_817_18 = arg_814_1:GetWordFromCfg(1108106194)
				local var_817_19 = arg_814_1:FormatText(var_817_18.content)

				arg_814_1.text_.text = var_817_19

				LuaForUtil.ClearLinePrefixSymbol(arg_814_1.text_)

				local var_817_20 = 29
				local var_817_21 = utf8.len(var_817_19)
				local var_817_22 = var_817_20 <= 0 and var_817_16 or var_817_16 * (var_817_21 / var_817_20)

				if var_817_22 > 0 and var_817_16 < var_817_22 then
					arg_814_1.talkMaxDuration = var_817_22

					if var_817_22 + var_817_15 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_22 + var_817_15
					end
				end

				arg_814_1.text_.text = var_817_19
				arg_814_1.typewritter.percent = 0

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb") ~= 0 then
					local var_817_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb") / 1000

					if var_817_23 + var_817_15 > arg_814_1.duration_ then
						arg_814_1.duration_ = var_817_23 + var_817_15
					end

					if var_817_18.prefab_name ~= "" and arg_814_1.actors_[var_817_18.prefab_name] ~= nil then
						local var_817_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_814_1.actors_[var_817_18.prefab_name].transform, "story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")

						arg_814_1:RecordAudio("1108106194", var_817_24)
						arg_814_1:RecordAudio("1108106194", var_817_24)
					else
						arg_814_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")
					end

					arg_814_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106194", "story_v_side_new_1108106.awb")
				end

				arg_814_1:RecordContent(arg_814_1.text_.text)
			end

			local var_817_25 = math.max(var_817_16, arg_814_1.talkMaxDuration)

			if var_817_15 <= arg_814_1.time_ and arg_814_1.time_ < var_817_15 + var_817_25 then
				arg_814_1.typewritter.percent = (arg_814_1.time_ - var_817_15) / var_817_25

				arg_814_1.typewritter:SetDirty()
			end

			if arg_814_1.time_ >= var_817_15 + var_817_25 and arg_814_1.time_ < var_817_15 + var_817_25 + arg_817_0 then
				arg_814_1.typewritter.percent = 1

				arg_814_1.typewritter:SetDirty()
				arg_814_1:ShowNextGo(true)
			end
		end

		arg_814_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_814_1:InitPlayNodeList()
	end,
	Play1108106195 = function(arg_818_0, arg_818_1)
		arg_818_1.time_ = 0
		arg_818_1.frameCnt_ = 0
		arg_818_1.state_ = "playing"
		arg_818_1.curTalkId_ = 1108106195
		arg_818_1.duration_ = 7.8

		SetActive(arg_818_1.tipsGo_, false)

		function arg_818_1.onSingleLineFinish_()
			arg_818_1.onSingleLineUpdate_ = nil
			arg_818_1.onSingleLineFinish_ = nil
			arg_818_1.state_ = "waiting"
		end

		function arg_818_1.playNext_(arg_820_0)
			if arg_820_0 == 1 then
				arg_818_0:Play1108106196(arg_818_1)
			end
		end

		function arg_818_1.onSingleLineUpdate_(arg_821_0)
			local var_821_0 = arg_818_1.actors_["10066ui_story"].transform
			local var_821_1 = 0

			if var_821_1 < arg_818_1.time_ and arg_818_1.time_ <= var_821_1 + arg_821_0 then
				arg_818_1.var_.moveOldPos10066ui_story = var_821_0.localPosition
			end

			local var_821_2 = 0.001

			if var_821_1 <= arg_818_1.time_ and arg_818_1.time_ < var_821_1 + var_821_2 then
				local var_821_3 = (arg_818_1.time_ - var_821_1) / var_821_2
				local var_821_4 = Vector3.New(0, -0.99, -5.83)

				var_821_0.localPosition = Vector3.Lerp(arg_818_1.var_.moveOldPos10066ui_story, var_821_4, var_821_3)

				local var_821_5 = manager.ui.mainCamera.transform.position - var_821_0.position

				var_821_0.forward = Vector3.New(var_821_5.x, var_821_5.y, var_821_5.z)

				local var_821_6 = var_821_0.localEulerAngles

				var_821_6.z = 0
				var_821_6.x = 0
				var_821_0.localEulerAngles = var_821_6
			end

			if arg_818_1.time_ >= var_821_1 + var_821_2 and arg_818_1.time_ < var_821_1 + var_821_2 + arg_821_0 then
				var_821_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_821_7 = manager.ui.mainCamera.transform.position - var_821_0.position

				var_821_0.forward = Vector3.New(var_821_7.x, var_821_7.y, var_821_7.z)

				local var_821_8 = var_821_0.localEulerAngles

				var_821_8.z = 0
				var_821_8.x = 0
				var_821_0.localEulerAngles = var_821_8
			end

			local var_821_9 = arg_818_1.actors_["10066ui_story"]
			local var_821_10 = 0

			if var_821_10 < arg_818_1.time_ and arg_818_1.time_ <= var_821_10 + arg_821_0 and not isNil(var_821_9) and arg_818_1.var_.characterEffect10066ui_story == nil then
				arg_818_1.var_.characterEffect10066ui_story = var_821_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_821_11 = 0.200000002980232

			if var_821_10 <= arg_818_1.time_ and arg_818_1.time_ < var_821_10 + var_821_11 and not isNil(var_821_9) then
				local var_821_12 = (arg_818_1.time_ - var_821_10) / var_821_11

				if arg_818_1.var_.characterEffect10066ui_story and not isNil(var_821_9) then
					arg_818_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_818_1.time_ >= var_821_10 + var_821_11 and arg_818_1.time_ < var_821_10 + var_821_11 + arg_821_0 and not isNil(var_821_9) and arg_818_1.var_.characterEffect10066ui_story then
				arg_818_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_821_13 = 0

			if var_821_13 < arg_818_1.time_ and arg_818_1.time_ <= var_821_13 + arg_821_0 then
				arg_818_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_821_14 = 0

			if var_821_14 < arg_818_1.time_ and arg_818_1.time_ <= var_821_14 + arg_821_0 then
				arg_818_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_821_15 = 0
			local var_821_16 = 0.775

			if var_821_15 < arg_818_1.time_ and arg_818_1.time_ <= var_821_15 + arg_821_0 then
				arg_818_1.talkMaxDuration = 0
				arg_818_1.dialogCg_.alpha = 1

				arg_818_1.dialog_:SetActive(true)
				SetActive(arg_818_1.leftNameGo_, true)

				local var_821_17 = arg_818_1:FormatText(StoryNameCfg[640].name)

				arg_818_1.leftNameTxt_.text = var_821_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_818_1.leftNameTxt_.transform)

				arg_818_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_818_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_818_1:RecordName(arg_818_1.leftNameTxt_.text)
				SetActive(arg_818_1.iconTrs_.gameObject, false)
				arg_818_1.callingController_:SetSelectedState("normal")

				local var_821_18 = arg_818_1:GetWordFromCfg(1108106195)
				local var_821_19 = arg_818_1:FormatText(var_821_18.content)

				arg_818_1.text_.text = var_821_19

				LuaForUtil.ClearLinePrefixSymbol(arg_818_1.text_)

				local var_821_20 = 31
				local var_821_21 = utf8.len(var_821_19)
				local var_821_22 = var_821_20 <= 0 and var_821_16 or var_821_16 * (var_821_21 / var_821_20)

				if var_821_22 > 0 and var_821_16 < var_821_22 then
					arg_818_1.talkMaxDuration = var_821_22

					if var_821_22 + var_821_15 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_22 + var_821_15
					end
				end

				arg_818_1.text_.text = var_821_19
				arg_818_1.typewritter.percent = 0

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb") ~= 0 then
					local var_821_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb") / 1000

					if var_821_23 + var_821_15 > arg_818_1.duration_ then
						arg_818_1.duration_ = var_821_23 + var_821_15
					end

					if var_821_18.prefab_name ~= "" and arg_818_1.actors_[var_821_18.prefab_name] ~= nil then
						local var_821_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_818_1.actors_[var_821_18.prefab_name].transform, "story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")

						arg_818_1:RecordAudio("1108106195", var_821_24)
						arg_818_1:RecordAudio("1108106195", var_821_24)
					else
						arg_818_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")
					end

					arg_818_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106195", "story_v_side_new_1108106.awb")
				end

				arg_818_1:RecordContent(arg_818_1.text_.text)
			end

			local var_821_25 = math.max(var_821_16, arg_818_1.talkMaxDuration)

			if var_821_15 <= arg_818_1.time_ and arg_818_1.time_ < var_821_15 + var_821_25 then
				arg_818_1.typewritter.percent = (arg_818_1.time_ - var_821_15) / var_821_25

				arg_818_1.typewritter:SetDirty()
			end

			if arg_818_1.time_ >= var_821_15 + var_821_25 and arg_818_1.time_ < var_821_15 + var_821_25 + arg_821_0 then
				arg_818_1.typewritter.percent = 1

				arg_818_1.typewritter:SetDirty()
				arg_818_1:ShowNextGo(true)
			end
		end

		arg_818_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_818_1:InitPlayNodeList()
	end,
	Play1108106196 = function(arg_822_0, arg_822_1)
		arg_822_1.time_ = 0
		arg_822_1.frameCnt_ = 0
		arg_822_1.state_ = "playing"
		arg_822_1.curTalkId_ = 1108106196
		arg_822_1.duration_ = 1

		SetActive(arg_822_1.tipsGo_, false)

		function arg_822_1.onSingleLineFinish_()
			arg_822_1.onSingleLineUpdate_ = nil
			arg_822_1.onSingleLineFinish_ = nil
			arg_822_1.state_ = "waiting"

			SetActive(arg_822_1.choicesGo_, true)

			for iter_823_0, iter_823_1 in ipairs(arg_822_1.choices_) do
				local var_823_0 = iter_823_0 <= 2

				SetActive(iter_823_1.go, var_823_0)
			end

			arg_822_1.choices_[1].txt.text = arg_822_1:FormatText(StoryChoiceCfg[998].name)
			arg_822_1.choices_[2].txt.text = arg_822_1:FormatText(StoryChoiceCfg[999].name)
		end

		function arg_822_1.playNext_(arg_824_0)
			if arg_824_0 == 1 then
				arg_822_0:Play1108106197(arg_822_1)
			end

			if arg_824_0 == 2 then
				arg_822_0:Play1108106197(arg_822_1)
			end

			arg_822_1:RecordChoiceLog(1108106196, 998, 999)
		end

		function arg_822_1.onSingleLineUpdate_(arg_825_0)
			return
		end

		arg_822_1.nodeConfigList_ = {}

		arg_822_1:InitPlayNodeList()
	end,
	Play1108106197 = function(arg_826_0, arg_826_1)
		arg_826_1.time_ = 0
		arg_826_1.frameCnt_ = 0
		arg_826_1.state_ = "playing"
		arg_826_1.curTalkId_ = 1108106197
		arg_826_1.duration_ = 5

		SetActive(arg_826_1.tipsGo_, false)

		function arg_826_1.onSingleLineFinish_()
			arg_826_1.onSingleLineUpdate_ = nil
			arg_826_1.onSingleLineFinish_ = nil
			arg_826_1.state_ = "waiting"
		end

		function arg_826_1.playNext_(arg_828_0)
			if arg_828_0 == 1 then
				arg_826_0:Play1108106198(arg_826_1)
			end
		end

		function arg_826_1.onSingleLineUpdate_(arg_829_0)
			local var_829_0 = arg_826_1.actors_["10066ui_story"]
			local var_829_1 = 0

			if var_829_1 < arg_826_1.time_ and arg_826_1.time_ <= var_829_1 + arg_829_0 and not isNil(var_829_0) and arg_826_1.var_.characterEffect10066ui_story == nil then
				arg_826_1.var_.characterEffect10066ui_story = var_829_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_829_2 = 0.05

			if var_829_1 <= arg_826_1.time_ and arg_826_1.time_ < var_829_1 + var_829_2 and not isNil(var_829_0) then
				local var_829_3 = (arg_826_1.time_ - var_829_1) / var_829_2

				if arg_826_1.var_.characterEffect10066ui_story and not isNil(var_829_0) then
					local var_829_4 = Mathf.Lerp(0, 0.5, var_829_3)

					arg_826_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_826_1.var_.characterEffect10066ui_story.fillRatio = var_829_4
				end
			end

			if arg_826_1.time_ >= var_829_1 + var_829_2 and arg_826_1.time_ < var_829_1 + var_829_2 + arg_829_0 and not isNil(var_829_0) and arg_826_1.var_.characterEffect10066ui_story then
				local var_829_5 = 0.5

				arg_826_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_826_1.var_.characterEffect10066ui_story.fillRatio = var_829_5
			end

			local var_829_6 = 0
			local var_829_7 = 0.05

			if var_829_6 < arg_826_1.time_ and arg_826_1.time_ <= var_829_6 + arg_829_0 then
				arg_826_1.talkMaxDuration = 0
				arg_826_1.dialogCg_.alpha = 1

				arg_826_1.dialog_:SetActive(true)
				SetActive(arg_826_1.leftNameGo_, true)

				local var_829_8 = arg_826_1:FormatText(StoryNameCfg[7].name)

				arg_826_1.leftNameTxt_.text = var_829_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_826_1.leftNameTxt_.transform)

				arg_826_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_826_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_826_1:RecordName(arg_826_1.leftNameTxt_.text)
				SetActive(arg_826_1.iconTrs_.gameObject, true)
				arg_826_1.iconController_:SetSelectedState("hero")

				arg_826_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_826_1.callingController_:SetSelectedState("normal")

				arg_826_1.keyicon_.color = Color.New(1, 1, 1)
				arg_826_1.icon_.color = Color.New(1, 1, 1)

				local var_829_9 = arg_826_1:GetWordFromCfg(1108106197)
				local var_829_10 = arg_826_1:FormatText(var_829_9.content)

				arg_826_1.text_.text = var_829_10

				LuaForUtil.ClearLinePrefixSymbol(arg_826_1.text_)

				local var_829_11 = 2
				local var_829_12 = utf8.len(var_829_10)
				local var_829_13 = var_829_11 <= 0 and var_829_7 or var_829_7 * (var_829_12 / var_829_11)

				if var_829_13 > 0 and var_829_7 < var_829_13 then
					arg_826_1.talkMaxDuration = var_829_13

					if var_829_13 + var_829_6 > arg_826_1.duration_ then
						arg_826_1.duration_ = var_829_13 + var_829_6
					end
				end

				arg_826_1.text_.text = var_829_10
				arg_826_1.typewritter.percent = 0

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(false)
				arg_826_1:RecordContent(arg_826_1.text_.text)
			end

			local var_829_14 = math.max(var_829_7, arg_826_1.talkMaxDuration)

			if var_829_6 <= arg_826_1.time_ and arg_826_1.time_ < var_829_6 + var_829_14 then
				arg_826_1.typewritter.percent = (arg_826_1.time_ - var_829_6) / var_829_14

				arg_826_1.typewritter:SetDirty()
			end

			if arg_826_1.time_ >= var_829_6 + var_829_14 and arg_826_1.time_ < var_829_6 + var_829_14 + arg_829_0 then
				arg_826_1.typewritter.percent = 1

				arg_826_1.typewritter:SetDirty()
				arg_826_1:ShowNextGo(true)
			end
		end

		arg_826_1.nodeConfigList_ = {}

		arg_826_1:InitPlayNodeList()
	end,
	Play1108106198 = function(arg_830_0, arg_830_1)
		arg_830_1.time_ = 0
		arg_830_1.frameCnt_ = 0
		arg_830_1.state_ = "playing"
		arg_830_1.curTalkId_ = 1108106198
		arg_830_1.duration_ = 5

		SetActive(arg_830_1.tipsGo_, false)

		function arg_830_1.onSingleLineFinish_()
			arg_830_1.onSingleLineUpdate_ = nil
			arg_830_1.onSingleLineFinish_ = nil
			arg_830_1.state_ = "waiting"
		end

		function arg_830_1.playNext_(arg_832_0)
			if arg_832_0 == 1 then
				arg_830_0:Play1108106199(arg_830_1)
			end
		end

		function arg_830_1.onSingleLineUpdate_(arg_833_0)
			local var_833_0 = 0
			local var_833_1 = 0.7

			if var_833_0 < arg_830_1.time_ and arg_830_1.time_ <= var_833_0 + arg_833_0 then
				arg_830_1.talkMaxDuration = 0
				arg_830_1.dialogCg_.alpha = 1

				arg_830_1.dialog_:SetActive(true)
				SetActive(arg_830_1.leftNameGo_, true)

				local var_833_2 = arg_830_1:FormatText(StoryNameCfg[7].name)

				arg_830_1.leftNameTxt_.text = var_833_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_830_1.leftNameTxt_.transform)

				arg_830_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_830_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_830_1:RecordName(arg_830_1.leftNameTxt_.text)
				SetActive(arg_830_1.iconTrs_.gameObject, true)
				arg_830_1.iconController_:SetSelectedState("hero")

				arg_830_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_830_1.callingController_:SetSelectedState("normal")

				arg_830_1.keyicon_.color = Color.New(1, 1, 1)
				arg_830_1.icon_.color = Color.New(1, 1, 1)

				local var_833_3 = arg_830_1:GetWordFromCfg(1108106198)
				local var_833_4 = arg_830_1:FormatText(var_833_3.content)

				arg_830_1.text_.text = var_833_4

				LuaForUtil.ClearLinePrefixSymbol(arg_830_1.text_)

				local var_833_5 = 28
				local var_833_6 = utf8.len(var_833_4)
				local var_833_7 = var_833_5 <= 0 and var_833_1 or var_833_1 * (var_833_6 / var_833_5)

				if var_833_7 > 0 and var_833_1 < var_833_7 then
					arg_830_1.talkMaxDuration = var_833_7

					if var_833_7 + var_833_0 > arg_830_1.duration_ then
						arg_830_1.duration_ = var_833_7 + var_833_0
					end
				end

				arg_830_1.text_.text = var_833_4
				arg_830_1.typewritter.percent = 0

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(false)
				arg_830_1:RecordContent(arg_830_1.text_.text)
			end

			local var_833_8 = math.max(var_833_1, arg_830_1.talkMaxDuration)

			if var_833_0 <= arg_830_1.time_ and arg_830_1.time_ < var_833_0 + var_833_8 then
				arg_830_1.typewritter.percent = (arg_830_1.time_ - var_833_0) / var_833_8

				arg_830_1.typewritter:SetDirty()
			end

			if arg_830_1.time_ >= var_833_0 + var_833_8 and arg_830_1.time_ < var_833_0 + var_833_8 + arg_833_0 then
				arg_830_1.typewritter.percent = 1

				arg_830_1.typewritter:SetDirty()
				arg_830_1:ShowNextGo(true)
			end
		end

		arg_830_1.nodeConfigList_ = {}

		arg_830_1:InitPlayNodeList()
	end,
	Play1108106199 = function(arg_834_0, arg_834_1)
		arg_834_1.time_ = 0
		arg_834_1.frameCnt_ = 0
		arg_834_1.state_ = "playing"
		arg_834_1.curTalkId_ = 1108106199
		arg_834_1.duration_ = 8.5

		SetActive(arg_834_1.tipsGo_, false)

		function arg_834_1.onSingleLineFinish_()
			arg_834_1.onSingleLineUpdate_ = nil
			arg_834_1.onSingleLineFinish_ = nil
			arg_834_1.state_ = "waiting"
		end

		function arg_834_1.playNext_(arg_836_0)
			if arg_836_0 == 1 then
				arg_834_0:Play1108106200(arg_834_1)
			end
		end

		function arg_834_1.onSingleLineUpdate_(arg_837_0)
			local var_837_0 = arg_834_1.actors_["10066ui_story"].transform
			local var_837_1 = 0

			if var_837_1 < arg_834_1.time_ and arg_834_1.time_ <= var_837_1 + arg_837_0 then
				arg_834_1.var_.moveOldPos10066ui_story = var_837_0.localPosition
			end

			local var_837_2 = 0.001

			if var_837_1 <= arg_834_1.time_ and arg_834_1.time_ < var_837_1 + var_837_2 then
				local var_837_3 = (arg_834_1.time_ - var_837_1) / var_837_2
				local var_837_4 = Vector3.New(0, -0.99, -5.83)

				var_837_0.localPosition = Vector3.Lerp(arg_834_1.var_.moveOldPos10066ui_story, var_837_4, var_837_3)

				local var_837_5 = manager.ui.mainCamera.transform.position - var_837_0.position

				var_837_0.forward = Vector3.New(var_837_5.x, var_837_5.y, var_837_5.z)

				local var_837_6 = var_837_0.localEulerAngles

				var_837_6.z = 0
				var_837_6.x = 0
				var_837_0.localEulerAngles = var_837_6
			end

			if arg_834_1.time_ >= var_837_1 + var_837_2 and arg_834_1.time_ < var_837_1 + var_837_2 + arg_837_0 then
				var_837_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_837_7 = manager.ui.mainCamera.transform.position - var_837_0.position

				var_837_0.forward = Vector3.New(var_837_7.x, var_837_7.y, var_837_7.z)

				local var_837_8 = var_837_0.localEulerAngles

				var_837_8.z = 0
				var_837_8.x = 0
				var_837_0.localEulerAngles = var_837_8
			end

			local var_837_9 = arg_834_1.actors_["10066ui_story"]
			local var_837_10 = 0

			if var_837_10 < arg_834_1.time_ and arg_834_1.time_ <= var_837_10 + arg_837_0 and not isNil(var_837_9) and arg_834_1.var_.characterEffect10066ui_story == nil then
				arg_834_1.var_.characterEffect10066ui_story = var_837_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_837_11 = 0.200000002980232

			if var_837_10 <= arg_834_1.time_ and arg_834_1.time_ < var_837_10 + var_837_11 and not isNil(var_837_9) then
				local var_837_12 = (arg_834_1.time_ - var_837_10) / var_837_11

				if arg_834_1.var_.characterEffect10066ui_story and not isNil(var_837_9) then
					arg_834_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_834_1.time_ >= var_837_10 + var_837_11 and arg_834_1.time_ < var_837_10 + var_837_11 + arg_837_0 and not isNil(var_837_9) and arg_834_1.var_.characterEffect10066ui_story then
				arg_834_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_837_13 = 0

			if var_837_13 < arg_834_1.time_ and arg_834_1.time_ <= var_837_13 + arg_837_0 then
				arg_834_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_837_14 = 0

			if var_837_14 < arg_834_1.time_ and arg_834_1.time_ <= var_837_14 + arg_837_0 then
				arg_834_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_837_15 = 0
			local var_837_16 = 0.725

			if var_837_15 < arg_834_1.time_ and arg_834_1.time_ <= var_837_15 + arg_837_0 then
				arg_834_1.talkMaxDuration = 0
				arg_834_1.dialogCg_.alpha = 1

				arg_834_1.dialog_:SetActive(true)
				SetActive(arg_834_1.leftNameGo_, true)

				local var_837_17 = arg_834_1:FormatText(StoryNameCfg[640].name)

				arg_834_1.leftNameTxt_.text = var_837_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_834_1.leftNameTxt_.transform)

				arg_834_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_834_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_834_1:RecordName(arg_834_1.leftNameTxt_.text)
				SetActive(arg_834_1.iconTrs_.gameObject, false)
				arg_834_1.callingController_:SetSelectedState("normal")

				local var_837_18 = arg_834_1:GetWordFromCfg(1108106199)
				local var_837_19 = arg_834_1:FormatText(var_837_18.content)

				arg_834_1.text_.text = var_837_19

				LuaForUtil.ClearLinePrefixSymbol(arg_834_1.text_)

				local var_837_20 = 29
				local var_837_21 = utf8.len(var_837_19)
				local var_837_22 = var_837_20 <= 0 and var_837_16 or var_837_16 * (var_837_21 / var_837_20)

				if var_837_22 > 0 and var_837_16 < var_837_22 then
					arg_834_1.talkMaxDuration = var_837_22

					if var_837_22 + var_837_15 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_22 + var_837_15
					end
				end

				arg_834_1.text_.text = var_837_19
				arg_834_1.typewritter.percent = 0

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb") ~= 0 then
					local var_837_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb") / 1000

					if var_837_23 + var_837_15 > arg_834_1.duration_ then
						arg_834_1.duration_ = var_837_23 + var_837_15
					end

					if var_837_18.prefab_name ~= "" and arg_834_1.actors_[var_837_18.prefab_name] ~= nil then
						local var_837_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_834_1.actors_[var_837_18.prefab_name].transform, "story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")

						arg_834_1:RecordAudio("1108106199", var_837_24)
						arg_834_1:RecordAudio("1108106199", var_837_24)
					else
						arg_834_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")
					end

					arg_834_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106199", "story_v_side_new_1108106.awb")
				end

				arg_834_1:RecordContent(arg_834_1.text_.text)
			end

			local var_837_25 = math.max(var_837_16, arg_834_1.talkMaxDuration)

			if var_837_15 <= arg_834_1.time_ and arg_834_1.time_ < var_837_15 + var_837_25 then
				arg_834_1.typewritter.percent = (arg_834_1.time_ - var_837_15) / var_837_25

				arg_834_1.typewritter:SetDirty()
			end

			if arg_834_1.time_ >= var_837_15 + var_837_25 and arg_834_1.time_ < var_837_15 + var_837_25 + arg_837_0 then
				arg_834_1.typewritter.percent = 1

				arg_834_1.typewritter:SetDirty()
				arg_834_1:ShowNextGo(true)
			end
		end

		arg_834_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_834_1:InitPlayNodeList()
	end,
	Play1108106200 = function(arg_838_0, arg_838_1)
		arg_838_1.time_ = 0
		arg_838_1.frameCnt_ = 0
		arg_838_1.state_ = "playing"
		arg_838_1.curTalkId_ = 1108106200
		arg_838_1.duration_ = 7

		SetActive(arg_838_1.tipsGo_, false)

		function arg_838_1.onSingleLineFinish_()
			arg_838_1.onSingleLineUpdate_ = nil
			arg_838_1.onSingleLineFinish_ = nil
			arg_838_1.state_ = "waiting"
		end

		function arg_838_1.playNext_(arg_840_0)
			if arg_840_0 == 1 then
				arg_838_0:Play1108106201(arg_838_1)
			end
		end

		function arg_838_1.onSingleLineUpdate_(arg_841_0)
			local var_841_0 = 2

			if var_841_0 < arg_838_1.time_ and arg_838_1.time_ <= var_841_0 + arg_841_0 then
				arg_838_1.allBtn_.enabled = false
			end

			local var_841_1 = 0.3

			if arg_838_1.time_ >= var_841_0 + var_841_1 and arg_838_1.time_ < var_841_0 + var_841_1 + arg_841_0 then
				arg_838_1.allBtn_.enabled = true
			end

			local var_841_2 = 1

			if var_841_2 < arg_838_1.time_ and arg_838_1.time_ <= var_841_2 + arg_841_0 then
				local var_841_3 = manager.ui.mainCamera.transform.localPosition
				local var_841_4 = Vector3.New(0, 0, 10) + Vector3.New(var_841_3.x, var_841_3.y, 0)
				local var_841_5 = arg_838_1.bgs_.ST07b

				var_841_5.transform.localPosition = var_841_4
				var_841_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_841_6 = var_841_5:GetComponent("SpriteRenderer")

				if var_841_6 and var_841_6.sprite then
					local var_841_7 = (var_841_5.transform.localPosition - var_841_3).z
					local var_841_8 = manager.ui.mainCameraCom_
					local var_841_9 = 2 * var_841_7 * Mathf.Tan(var_841_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_841_10 = var_841_9 * var_841_8.aspect
					local var_841_11 = var_841_6.sprite.bounds.size.x
					local var_841_12 = var_841_6.sprite.bounds.size.y
					local var_841_13 = var_841_10 / var_841_11
					local var_841_14 = var_841_9 / var_841_12
					local var_841_15 = var_841_14 < var_841_13 and var_841_13 or var_841_14

					var_841_5.transform.localScale = Vector3.New(var_841_15, var_841_15, 0)
				end

				for iter_841_0, iter_841_1 in pairs(arg_838_1.bgs_) do
					if iter_841_0 ~= "ST07b" then
						iter_841_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_841_16 = 0

			if var_841_16 < arg_838_1.time_ and arg_838_1.time_ <= var_841_16 + arg_841_0 then
				arg_838_1.mask_.enabled = true
				arg_838_1.mask_.raycastTarget = true

				arg_838_1:SetGaussion(false)
			end

			local var_841_17 = 1

			if var_841_16 <= arg_838_1.time_ and arg_838_1.time_ < var_841_16 + var_841_17 then
				local var_841_18 = (arg_838_1.time_ - var_841_16) / var_841_17
				local var_841_19 = Color.New(0, 0, 0)

				var_841_19.a = Mathf.Lerp(0, 1, var_841_18)
				arg_838_1.mask_.color = var_841_19
			end

			if arg_838_1.time_ >= var_841_16 + var_841_17 and arg_838_1.time_ < var_841_16 + var_841_17 + arg_841_0 then
				local var_841_20 = Color.New(0, 0, 0)

				var_841_20.a = 1
				arg_838_1.mask_.color = var_841_20
			end

			local var_841_21 = 1

			if var_841_21 < arg_838_1.time_ and arg_838_1.time_ <= var_841_21 + arg_841_0 then
				arg_838_1.mask_.enabled = true
				arg_838_1.mask_.raycastTarget = true

				arg_838_1:SetGaussion(false)
			end

			local var_841_22 = 2

			if var_841_21 <= arg_838_1.time_ and arg_838_1.time_ < var_841_21 + var_841_22 then
				local var_841_23 = (arg_838_1.time_ - var_841_21) / var_841_22
				local var_841_24 = Color.New(0, 0, 0)

				var_841_24.a = Mathf.Lerp(1, 0, var_841_23)
				arg_838_1.mask_.color = var_841_24
			end

			if arg_838_1.time_ >= var_841_21 + var_841_22 and arg_838_1.time_ < var_841_21 + var_841_22 + arg_841_0 then
				local var_841_25 = Color.New(0, 0, 0)
				local var_841_26 = 0

				arg_838_1.mask_.enabled = false
				var_841_25.a = var_841_26
				arg_838_1.mask_.color = var_841_25
			end

			local var_841_27 = arg_838_1.actors_["10066ui_story"].transform
			local var_841_28 = 0.965999998152257

			if var_841_28 < arg_838_1.time_ and arg_838_1.time_ <= var_841_28 + arg_841_0 then
				arg_838_1.var_.moveOldPos10066ui_story = var_841_27.localPosition
			end

			local var_841_29 = 0.001

			if var_841_28 <= arg_838_1.time_ and arg_838_1.time_ < var_841_28 + var_841_29 then
				local var_841_30 = (arg_838_1.time_ - var_841_28) / var_841_29
				local var_841_31 = Vector3.New(0, 100, 0)

				var_841_27.localPosition = Vector3.Lerp(arg_838_1.var_.moveOldPos10066ui_story, var_841_31, var_841_30)

				local var_841_32 = manager.ui.mainCamera.transform.position - var_841_27.position

				var_841_27.forward = Vector3.New(var_841_32.x, var_841_32.y, var_841_32.z)

				local var_841_33 = var_841_27.localEulerAngles

				var_841_33.z = 0
				var_841_33.x = 0
				var_841_27.localEulerAngles = var_841_33
			end

			if arg_838_1.time_ >= var_841_28 + var_841_29 and arg_838_1.time_ < var_841_28 + var_841_29 + arg_841_0 then
				var_841_27.localPosition = Vector3.New(0, 100, 0)

				local var_841_34 = manager.ui.mainCamera.transform.position - var_841_27.position

				var_841_27.forward = Vector3.New(var_841_34.x, var_841_34.y, var_841_34.z)

				local var_841_35 = var_841_27.localEulerAngles

				var_841_35.z = 0
				var_841_35.x = 0
				var_841_27.localEulerAngles = var_841_35
			end

			if arg_838_1.frameCnt_ <= 1 then
				arg_838_1.dialog_:SetActive(false)
			end

			local var_841_36 = 2
			local var_841_37 = 0.675

			if var_841_36 < arg_838_1.time_ and arg_838_1.time_ <= var_841_36 + arg_841_0 then
				arg_838_1.talkMaxDuration = 0

				arg_838_1.dialog_:SetActive(true)

				arg_838_1.dialogCg_.alpha = 0

				local var_841_38 = LeanTween.value(arg_838_1.dialog_, 0, 1, 0.3)

				var_841_38:setOnUpdate(LuaHelper.FloatAction(function(arg_842_0)
					arg_838_1.dialogCg_.alpha = arg_842_0
				end))
				var_841_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_838_1.dialog_)
					var_841_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_838_1.duration_ = arg_838_1.duration_ + 0.3

				SetActive(arg_838_1.leftNameGo_, false)

				arg_838_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_838_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_838_1:RecordName(arg_838_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_838_1.iconTrs_.gameObject, false)
				arg_838_1.callingController_:SetSelectedState("normal")

				local var_841_39 = arg_838_1:GetWordFromCfg(1108106200)
				local var_841_40 = arg_838_1:FormatText(var_841_39.content)

				arg_838_1.text_.text = var_841_40

				LuaForUtil.ClearLinePrefixSymbol(arg_838_1.text_)

				local var_841_41 = 27
				local var_841_42 = utf8.len(var_841_40)
				local var_841_43 = var_841_41 <= 0 and var_841_37 or var_841_37 * (var_841_42 / var_841_41)

				if var_841_43 > 0 and var_841_37 < var_841_43 then
					arg_838_1.talkMaxDuration = var_841_43
					var_841_36 = var_841_36 + 0.3

					if var_841_43 + var_841_36 > arg_838_1.duration_ then
						arg_838_1.duration_ = var_841_43 + var_841_36
					end
				end

				arg_838_1.text_.text = var_841_40
				arg_838_1.typewritter.percent = 0

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(false)
				arg_838_1:RecordContent(arg_838_1.text_.text)
			end

			local var_841_44 = var_841_36 + 0.3
			local var_841_45 = math.max(var_841_37, arg_838_1.talkMaxDuration)

			if var_841_44 <= arg_838_1.time_ and arg_838_1.time_ < var_841_44 + var_841_45 then
				arg_838_1.typewritter.percent = (arg_838_1.time_ - var_841_44) / var_841_45

				arg_838_1.typewritter:SetDirty()
			end

			if arg_838_1.time_ >= var_841_44 + var_841_45 and arg_838_1.time_ < var_841_44 + var_841_45 + arg_841_0 then
				arg_838_1.typewritter.percent = 1

				arg_838_1.typewritter:SetDirty()
				arg_838_1:ShowNextGo(true)
			end
		end

		arg_838_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152257,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_838_1:InitPlayNodeList()
	end,
	Play1108106201 = function(arg_844_0, arg_844_1)
		arg_844_1.time_ = 0
		arg_844_1.frameCnt_ = 0
		arg_844_1.state_ = "playing"
		arg_844_1.curTalkId_ = 1108106201
		arg_844_1.duration_ = 5

		SetActive(arg_844_1.tipsGo_, false)

		function arg_844_1.onSingleLineFinish_()
			arg_844_1.onSingleLineUpdate_ = nil
			arg_844_1.onSingleLineFinish_ = nil
			arg_844_1.state_ = "waiting"
		end

		function arg_844_1.playNext_(arg_846_0)
			if arg_846_0 == 1 then
				arg_844_0:Play1108106202(arg_844_1)
			end
		end

		function arg_844_1.onSingleLineUpdate_(arg_847_0)
			local var_847_0 = 0
			local var_847_1 = 1.35

			if var_847_0 < arg_844_1.time_ and arg_844_1.time_ <= var_847_0 + arg_847_0 then
				arg_844_1.talkMaxDuration = 0
				arg_844_1.dialogCg_.alpha = 1

				arg_844_1.dialog_:SetActive(true)
				SetActive(arg_844_1.leftNameGo_, false)

				arg_844_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_844_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_844_1:RecordName(arg_844_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_844_1.iconTrs_.gameObject, false)
				arg_844_1.callingController_:SetSelectedState("normal")

				local var_847_2 = arg_844_1:GetWordFromCfg(1108106201)
				local var_847_3 = arg_844_1:FormatText(var_847_2.content)

				arg_844_1.text_.text = var_847_3

				LuaForUtil.ClearLinePrefixSymbol(arg_844_1.text_)

				local var_847_4 = 54
				local var_847_5 = utf8.len(var_847_3)
				local var_847_6 = var_847_4 <= 0 and var_847_1 or var_847_1 * (var_847_5 / var_847_4)

				if var_847_6 > 0 and var_847_1 < var_847_6 then
					arg_844_1.talkMaxDuration = var_847_6

					if var_847_6 + var_847_0 > arg_844_1.duration_ then
						arg_844_1.duration_ = var_847_6 + var_847_0
					end
				end

				arg_844_1.text_.text = var_847_3
				arg_844_1.typewritter.percent = 0

				arg_844_1.typewritter:SetDirty()
				arg_844_1:ShowNextGo(false)
				arg_844_1:RecordContent(arg_844_1.text_.text)
			end

			local var_847_7 = math.max(var_847_1, arg_844_1.talkMaxDuration)

			if var_847_0 <= arg_844_1.time_ and arg_844_1.time_ < var_847_0 + var_847_7 then
				arg_844_1.typewritter.percent = (arg_844_1.time_ - var_847_0) / var_847_7

				arg_844_1.typewritter:SetDirty()
			end

			if arg_844_1.time_ >= var_847_0 + var_847_7 and arg_844_1.time_ < var_847_0 + var_847_7 + arg_847_0 then
				arg_844_1.typewritter.percent = 1

				arg_844_1.typewritter:SetDirty()
				arg_844_1:ShowNextGo(true)
			end
		end

		arg_844_1.nodeConfigList_ = {}

		arg_844_1:InitPlayNodeList()
	end,
	Play1108106202 = function(arg_848_0, arg_848_1)
		arg_848_1.time_ = 0
		arg_848_1.frameCnt_ = 0
		arg_848_1.state_ = "playing"
		arg_848_1.curTalkId_ = 1108106202
		arg_848_1.duration_ = 5

		SetActive(arg_848_1.tipsGo_, false)

		function arg_848_1.onSingleLineFinish_()
			arg_848_1.onSingleLineUpdate_ = nil
			arg_848_1.onSingleLineFinish_ = nil
			arg_848_1.state_ = "waiting"
		end

		function arg_848_1.playNext_(arg_850_0)
			if arg_850_0 == 1 then
				arg_848_0:Play1108106203(arg_848_1)
			end
		end

		function arg_848_1.onSingleLineUpdate_(arg_851_0)
			local var_851_0 = 0
			local var_851_1 = 0.125

			if var_851_0 < arg_848_1.time_ and arg_848_1.time_ <= var_851_0 + arg_851_0 then
				arg_848_1.talkMaxDuration = 0
				arg_848_1.dialogCg_.alpha = 1

				arg_848_1.dialog_:SetActive(true)
				SetActive(arg_848_1.leftNameGo_, true)

				local var_851_2 = arg_848_1:FormatText(StoryNameCfg[7].name)

				arg_848_1.leftNameTxt_.text = var_851_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_848_1.leftNameTxt_.transform)

				arg_848_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_848_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_848_1:RecordName(arg_848_1.leftNameTxt_.text)
				SetActive(arg_848_1.iconTrs_.gameObject, true)
				arg_848_1.iconController_:SetSelectedState("hero")

				arg_848_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_848_1.callingController_:SetSelectedState("normal")

				arg_848_1.keyicon_.color = Color.New(1, 1, 1)
				arg_848_1.icon_.color = Color.New(1, 1, 1)

				local var_851_3 = arg_848_1:GetWordFromCfg(1108106202)
				local var_851_4 = arg_848_1:FormatText(var_851_3.content)

				arg_848_1.text_.text = var_851_4

				LuaForUtil.ClearLinePrefixSymbol(arg_848_1.text_)

				local var_851_5 = 5
				local var_851_6 = utf8.len(var_851_4)
				local var_851_7 = var_851_5 <= 0 and var_851_1 or var_851_1 * (var_851_6 / var_851_5)

				if var_851_7 > 0 and var_851_1 < var_851_7 then
					arg_848_1.talkMaxDuration = var_851_7

					if var_851_7 + var_851_0 > arg_848_1.duration_ then
						arg_848_1.duration_ = var_851_7 + var_851_0
					end
				end

				arg_848_1.text_.text = var_851_4
				arg_848_1.typewritter.percent = 0

				arg_848_1.typewritter:SetDirty()
				arg_848_1:ShowNextGo(false)
				arg_848_1:RecordContent(arg_848_1.text_.text)
			end

			local var_851_8 = math.max(var_851_1, arg_848_1.talkMaxDuration)

			if var_851_0 <= arg_848_1.time_ and arg_848_1.time_ < var_851_0 + var_851_8 then
				arg_848_1.typewritter.percent = (arg_848_1.time_ - var_851_0) / var_851_8

				arg_848_1.typewritter:SetDirty()
			end

			if arg_848_1.time_ >= var_851_0 + var_851_8 and arg_848_1.time_ < var_851_0 + var_851_8 + arg_851_0 then
				arg_848_1.typewritter.percent = 1

				arg_848_1.typewritter:SetDirty()
				arg_848_1:ShowNextGo(true)
			end
		end

		arg_848_1.nodeConfigList_ = {}

		arg_848_1:InitPlayNodeList()
	end,
	Play1108106203 = function(arg_852_0, arg_852_1)
		arg_852_1.time_ = 0
		arg_852_1.frameCnt_ = 0
		arg_852_1.state_ = "playing"
		arg_852_1.curTalkId_ = 1108106203
		arg_852_1.duration_ = 5

		SetActive(arg_852_1.tipsGo_, false)

		function arg_852_1.onSingleLineFinish_()
			arg_852_1.onSingleLineUpdate_ = nil
			arg_852_1.onSingleLineFinish_ = nil
			arg_852_1.state_ = "waiting"
		end

		function arg_852_1.playNext_(arg_854_0)
			if arg_854_0 == 1 then
				arg_852_0:Play1108106204(arg_852_1)
			end
		end

		function arg_852_1.onSingleLineUpdate_(arg_855_0)
			local var_855_0 = 0
			local var_855_1 = 0.85

			if var_855_0 < arg_852_1.time_ and arg_852_1.time_ <= var_855_0 + arg_855_0 then
				arg_852_1.talkMaxDuration = 0
				arg_852_1.dialogCg_.alpha = 1

				arg_852_1.dialog_:SetActive(true)
				SetActive(arg_852_1.leftNameGo_, false)

				arg_852_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_852_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_852_1:RecordName(arg_852_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_852_1.iconTrs_.gameObject, false)
				arg_852_1.callingController_:SetSelectedState("normal")

				local var_855_2 = arg_852_1:GetWordFromCfg(1108106203)
				local var_855_3 = arg_852_1:FormatText(var_855_2.content)

				arg_852_1.text_.text = var_855_3

				LuaForUtil.ClearLinePrefixSymbol(arg_852_1.text_)

				local var_855_4 = 34
				local var_855_5 = utf8.len(var_855_3)
				local var_855_6 = var_855_4 <= 0 and var_855_1 or var_855_1 * (var_855_5 / var_855_4)

				if var_855_6 > 0 and var_855_1 < var_855_6 then
					arg_852_1.talkMaxDuration = var_855_6

					if var_855_6 + var_855_0 > arg_852_1.duration_ then
						arg_852_1.duration_ = var_855_6 + var_855_0
					end
				end

				arg_852_1.text_.text = var_855_3
				arg_852_1.typewritter.percent = 0

				arg_852_1.typewritter:SetDirty()
				arg_852_1:ShowNextGo(false)
				arg_852_1:RecordContent(arg_852_1.text_.text)
			end

			local var_855_7 = math.max(var_855_1, arg_852_1.talkMaxDuration)

			if var_855_0 <= arg_852_1.time_ and arg_852_1.time_ < var_855_0 + var_855_7 then
				arg_852_1.typewritter.percent = (arg_852_1.time_ - var_855_0) / var_855_7

				arg_852_1.typewritter:SetDirty()
			end

			if arg_852_1.time_ >= var_855_0 + var_855_7 and arg_852_1.time_ < var_855_0 + var_855_7 + arg_855_0 then
				arg_852_1.typewritter.percent = 1

				arg_852_1.typewritter:SetDirty()
				arg_852_1:ShowNextGo(true)
			end
		end

		arg_852_1.nodeConfigList_ = {}

		arg_852_1:InitPlayNodeList()
	end,
	Play1108106204 = function(arg_856_0, arg_856_1)
		arg_856_1.time_ = 0
		arg_856_1.frameCnt_ = 0
		arg_856_1.state_ = "playing"
		arg_856_1.curTalkId_ = 1108106204
		arg_856_1.duration_ = 1

		SetActive(arg_856_1.tipsGo_, false)

		function arg_856_1.onSingleLineFinish_()
			arg_856_1.onSingleLineUpdate_ = nil
			arg_856_1.onSingleLineFinish_ = nil
			arg_856_1.state_ = "waiting"

			SetActive(arg_856_1.choicesGo_, true)

			for iter_857_0, iter_857_1 in ipairs(arg_856_1.choices_) do
				local var_857_0 = iter_857_0 <= 1

				SetActive(iter_857_1.go, var_857_0)
			end

			arg_856_1.choices_[1].txt.text = arg_856_1:FormatText(StoryChoiceCfg[1000].name)
		end

		function arg_856_1.playNext_(arg_858_0)
			if arg_858_0 == 1 then
				arg_856_0:Play1108106205(arg_856_1)
			end

			arg_856_1:RecordChoiceLog(1108106204, 1000)
		end

		function arg_856_1.onSingleLineUpdate_(arg_859_0)
			return
		end

		arg_856_1.nodeConfigList_ = {}

		arg_856_1:InitPlayNodeList()
	end,
	Play1108106205 = function(arg_860_0, arg_860_1)
		arg_860_1.time_ = 0
		arg_860_1.frameCnt_ = 0
		arg_860_1.state_ = "playing"
		arg_860_1.curTalkId_ = 1108106205
		arg_860_1.duration_ = 5

		SetActive(arg_860_1.tipsGo_, false)

		function arg_860_1.onSingleLineFinish_()
			arg_860_1.onSingleLineUpdate_ = nil
			arg_860_1.onSingleLineFinish_ = nil
			arg_860_1.state_ = "waiting"
		end

		function arg_860_1.playNext_(arg_862_0)
			if arg_862_0 == 1 then
				arg_860_0:Play1108106206(arg_860_1)
			end
		end

		function arg_860_1.onSingleLineUpdate_(arg_863_0)
			local var_863_0 = 0
			local var_863_1 = 1.075

			if var_863_0 < arg_860_1.time_ and arg_860_1.time_ <= var_863_0 + arg_863_0 then
				arg_860_1.talkMaxDuration = 0
				arg_860_1.dialogCg_.alpha = 1

				arg_860_1.dialog_:SetActive(true)
				SetActive(arg_860_1.leftNameGo_, false)

				arg_860_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_860_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_860_1:RecordName(arg_860_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_860_1.iconTrs_.gameObject, false)
				arg_860_1.callingController_:SetSelectedState("normal")

				local var_863_2 = arg_860_1:GetWordFromCfg(1108106205)
				local var_863_3 = arg_860_1:FormatText(var_863_2.content)

				arg_860_1.text_.text = var_863_3

				LuaForUtil.ClearLinePrefixSymbol(arg_860_1.text_)

				local var_863_4 = 43
				local var_863_5 = utf8.len(var_863_3)
				local var_863_6 = var_863_4 <= 0 and var_863_1 or var_863_1 * (var_863_5 / var_863_4)

				if var_863_6 > 0 and var_863_1 < var_863_6 then
					arg_860_1.talkMaxDuration = var_863_6

					if var_863_6 + var_863_0 > arg_860_1.duration_ then
						arg_860_1.duration_ = var_863_6 + var_863_0
					end
				end

				arg_860_1.text_.text = var_863_3
				arg_860_1.typewritter.percent = 0

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(false)
				arg_860_1:RecordContent(arg_860_1.text_.text)
			end

			local var_863_7 = math.max(var_863_1, arg_860_1.talkMaxDuration)

			if var_863_0 <= arg_860_1.time_ and arg_860_1.time_ < var_863_0 + var_863_7 then
				arg_860_1.typewritter.percent = (arg_860_1.time_ - var_863_0) / var_863_7

				arg_860_1.typewritter:SetDirty()
			end

			if arg_860_1.time_ >= var_863_0 + var_863_7 and arg_860_1.time_ < var_863_0 + var_863_7 + arg_863_0 then
				arg_860_1.typewritter.percent = 1

				arg_860_1.typewritter:SetDirty()
				arg_860_1:ShowNextGo(true)
			end
		end

		arg_860_1.nodeConfigList_ = {}

		arg_860_1:InitPlayNodeList()
	end,
	Play1108106206 = function(arg_864_0, arg_864_1)
		arg_864_1.time_ = 0
		arg_864_1.frameCnt_ = 0
		arg_864_1.state_ = "playing"
		arg_864_1.curTalkId_ = 1108106206
		arg_864_1.duration_ = 5

		SetActive(arg_864_1.tipsGo_, false)

		function arg_864_1.onSingleLineFinish_()
			arg_864_1.onSingleLineUpdate_ = nil
			arg_864_1.onSingleLineFinish_ = nil
			arg_864_1.state_ = "waiting"
		end

		function arg_864_1.playNext_(arg_866_0)
			if arg_866_0 == 1 then
				arg_864_0:Play1108106207(arg_864_1)
			end
		end

		function arg_864_1.onSingleLineUpdate_(arg_867_0)
			local var_867_0 = 0
			local var_867_1 = 0.5

			if var_867_0 < arg_864_1.time_ and arg_864_1.time_ <= var_867_0 + arg_867_0 then
				arg_864_1.talkMaxDuration = 0
				arg_864_1.dialogCg_.alpha = 1

				arg_864_1.dialog_:SetActive(true)
				SetActive(arg_864_1.leftNameGo_, true)

				local var_867_2 = arg_864_1:FormatText(StoryNameCfg[7].name)

				arg_864_1.leftNameTxt_.text = var_867_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_864_1.leftNameTxt_.transform)

				arg_864_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_864_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_864_1:RecordName(arg_864_1.leftNameTxt_.text)
				SetActive(arg_864_1.iconTrs_.gameObject, true)
				arg_864_1.iconController_:SetSelectedState("hero")

				arg_864_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_864_1.callingController_:SetSelectedState("normal")

				arg_864_1.keyicon_.color = Color.New(1, 1, 1)
				arg_864_1.icon_.color = Color.New(1, 1, 1)

				local var_867_3 = arg_864_1:GetWordFromCfg(1108106206)
				local var_867_4 = arg_864_1:FormatText(var_867_3.content)

				arg_864_1.text_.text = var_867_4

				LuaForUtil.ClearLinePrefixSymbol(arg_864_1.text_)

				local var_867_5 = 20
				local var_867_6 = utf8.len(var_867_4)
				local var_867_7 = var_867_5 <= 0 and var_867_1 or var_867_1 * (var_867_6 / var_867_5)

				if var_867_7 > 0 and var_867_1 < var_867_7 then
					arg_864_1.talkMaxDuration = var_867_7

					if var_867_7 + var_867_0 > arg_864_1.duration_ then
						arg_864_1.duration_ = var_867_7 + var_867_0
					end
				end

				arg_864_1.text_.text = var_867_4
				arg_864_1.typewritter.percent = 0

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(false)
				arg_864_1:RecordContent(arg_864_1.text_.text)
			end

			local var_867_8 = math.max(var_867_1, arg_864_1.talkMaxDuration)

			if var_867_0 <= arg_864_1.time_ and arg_864_1.time_ < var_867_0 + var_867_8 then
				arg_864_1.typewritter.percent = (arg_864_1.time_ - var_867_0) / var_867_8

				arg_864_1.typewritter:SetDirty()
			end

			if arg_864_1.time_ >= var_867_0 + var_867_8 and arg_864_1.time_ < var_867_0 + var_867_8 + arg_867_0 then
				arg_864_1.typewritter.percent = 1

				arg_864_1.typewritter:SetDirty()
				arg_864_1:ShowNextGo(true)
			end
		end

		arg_864_1.nodeConfigList_ = {}

		arg_864_1:InitPlayNodeList()
	end,
	Play1108106207 = function(arg_868_0, arg_868_1)
		arg_868_1.time_ = 0
		arg_868_1.frameCnt_ = 0
		arg_868_1.state_ = "playing"
		arg_868_1.curTalkId_ = 1108106207
		arg_868_1.duration_ = 5

		SetActive(arg_868_1.tipsGo_, false)

		function arg_868_1.onSingleLineFinish_()
			arg_868_1.onSingleLineUpdate_ = nil
			arg_868_1.onSingleLineFinish_ = nil
			arg_868_1.state_ = "waiting"
		end

		function arg_868_1.playNext_(arg_870_0)
			if arg_870_0 == 1 then
				arg_868_0:Play1108106208(arg_868_1)
			end
		end

		function arg_868_1.onSingleLineUpdate_(arg_871_0)
			local var_871_0 = 0
			local var_871_1 = 0.3

			if var_871_0 < arg_868_1.time_ and arg_868_1.time_ <= var_871_0 + arg_871_0 then
				arg_868_1.talkMaxDuration = 0
				arg_868_1.dialogCg_.alpha = 1

				arg_868_1.dialog_:SetActive(true)
				SetActive(arg_868_1.leftNameGo_, true)

				local var_871_2 = arg_868_1:FormatText(StoryNameCfg[7].name)

				arg_868_1.leftNameTxt_.text = var_871_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_868_1.leftNameTxt_.transform)

				arg_868_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_868_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_868_1:RecordName(arg_868_1.leftNameTxt_.text)
				SetActive(arg_868_1.iconTrs_.gameObject, true)
				arg_868_1.iconController_:SetSelectedState("hero")

				arg_868_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_868_1.callingController_:SetSelectedState("normal")

				arg_868_1.keyicon_.color = Color.New(1, 1, 1)
				arg_868_1.icon_.color = Color.New(1, 1, 1)

				local var_871_3 = arg_868_1:GetWordFromCfg(1108106207)
				local var_871_4 = arg_868_1:FormatText(var_871_3.content)

				arg_868_1.text_.text = var_871_4

				LuaForUtil.ClearLinePrefixSymbol(arg_868_1.text_)

				local var_871_5 = 12
				local var_871_6 = utf8.len(var_871_4)
				local var_871_7 = var_871_5 <= 0 and var_871_1 or var_871_1 * (var_871_6 / var_871_5)

				if var_871_7 > 0 and var_871_1 < var_871_7 then
					arg_868_1.talkMaxDuration = var_871_7

					if var_871_7 + var_871_0 > arg_868_1.duration_ then
						arg_868_1.duration_ = var_871_7 + var_871_0
					end
				end

				arg_868_1.text_.text = var_871_4
				arg_868_1.typewritter.percent = 0

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(false)
				arg_868_1:RecordContent(arg_868_1.text_.text)
			end

			local var_871_8 = math.max(var_871_1, arg_868_1.talkMaxDuration)

			if var_871_0 <= arg_868_1.time_ and arg_868_1.time_ < var_871_0 + var_871_8 then
				arg_868_1.typewritter.percent = (arg_868_1.time_ - var_871_0) / var_871_8

				arg_868_1.typewritter:SetDirty()
			end

			if arg_868_1.time_ >= var_871_0 + var_871_8 and arg_868_1.time_ < var_871_0 + var_871_8 + arg_871_0 then
				arg_868_1.typewritter.percent = 1

				arg_868_1.typewritter:SetDirty()
				arg_868_1:ShowNextGo(true)
			end
		end

		arg_868_1.nodeConfigList_ = {}

		arg_868_1:InitPlayNodeList()
	end,
	Play1108106208 = function(arg_872_0, arg_872_1)
		arg_872_1.time_ = 0
		arg_872_1.frameCnt_ = 0
		arg_872_1.state_ = "playing"
		arg_872_1.curTalkId_ = 1108106208
		arg_872_1.duration_ = 5

		SetActive(arg_872_1.tipsGo_, false)

		function arg_872_1.onSingleLineFinish_()
			arg_872_1.onSingleLineUpdate_ = nil
			arg_872_1.onSingleLineFinish_ = nil
			arg_872_1.state_ = "waiting"
		end

		function arg_872_1.playNext_(arg_874_0)
			if arg_874_0 == 1 then
				arg_872_0:Play1108106209(arg_872_1)
			end
		end

		function arg_872_1.onSingleLineUpdate_(arg_875_0)
			local var_875_0 = 0
			local var_875_1 = 1.025

			if var_875_0 < arg_872_1.time_ and arg_872_1.time_ <= var_875_0 + arg_875_0 then
				arg_872_1.talkMaxDuration = 0
				arg_872_1.dialogCg_.alpha = 1

				arg_872_1.dialog_:SetActive(true)
				SetActive(arg_872_1.leftNameGo_, false)

				arg_872_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_872_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_872_1:RecordName(arg_872_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_872_1.iconTrs_.gameObject, false)
				arg_872_1.callingController_:SetSelectedState("normal")

				local var_875_2 = arg_872_1:GetWordFromCfg(1108106208)
				local var_875_3 = arg_872_1:FormatText(var_875_2.content)

				arg_872_1.text_.text = var_875_3

				LuaForUtil.ClearLinePrefixSymbol(arg_872_1.text_)

				local var_875_4 = 41
				local var_875_5 = utf8.len(var_875_3)
				local var_875_6 = var_875_4 <= 0 and var_875_1 or var_875_1 * (var_875_5 / var_875_4)

				if var_875_6 > 0 and var_875_1 < var_875_6 then
					arg_872_1.talkMaxDuration = var_875_6

					if var_875_6 + var_875_0 > arg_872_1.duration_ then
						arg_872_1.duration_ = var_875_6 + var_875_0
					end
				end

				arg_872_1.text_.text = var_875_3
				arg_872_1.typewritter.percent = 0

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(false)
				arg_872_1:RecordContent(arg_872_1.text_.text)
			end

			local var_875_7 = math.max(var_875_1, arg_872_1.talkMaxDuration)

			if var_875_0 <= arg_872_1.time_ and arg_872_1.time_ < var_875_0 + var_875_7 then
				arg_872_1.typewritter.percent = (arg_872_1.time_ - var_875_0) / var_875_7

				arg_872_1.typewritter:SetDirty()
			end

			if arg_872_1.time_ >= var_875_0 + var_875_7 and arg_872_1.time_ < var_875_0 + var_875_7 + arg_875_0 then
				arg_872_1.typewritter.percent = 1

				arg_872_1.typewritter:SetDirty()
				arg_872_1:ShowNextGo(true)
			end
		end

		arg_872_1.nodeConfigList_ = {}

		arg_872_1:InitPlayNodeList()
	end,
	Play1108106209 = function(arg_876_0, arg_876_1)
		arg_876_1.time_ = 0
		arg_876_1.frameCnt_ = 0
		arg_876_1.state_ = "playing"
		arg_876_1.curTalkId_ = 1108106209
		arg_876_1.duration_ = 5.3

		SetActive(arg_876_1.tipsGo_, false)

		function arg_876_1.onSingleLineFinish_()
			arg_876_1.onSingleLineUpdate_ = nil
			arg_876_1.onSingleLineFinish_ = nil
			arg_876_1.state_ = "waiting"
		end

		function arg_876_1.playNext_(arg_878_0)
			if arg_878_0 == 1 then
				arg_876_0:Play1108106210(arg_876_1)
			end
		end

		function arg_876_1.onSingleLineUpdate_(arg_879_0)
			local var_879_0 = arg_876_1.actors_["1081ui_story"].transform
			local var_879_1 = 0

			if var_879_1 < arg_876_1.time_ and arg_876_1.time_ <= var_879_1 + arg_879_0 then
				arg_876_1.var_.moveOldPos1081ui_story = var_879_0.localPosition
			end

			local var_879_2 = 0.001

			if var_879_1 <= arg_876_1.time_ and arg_876_1.time_ < var_879_1 + var_879_2 then
				local var_879_3 = (arg_876_1.time_ - var_879_1) / var_879_2
				local var_879_4 = Vector3.New(0, -0.92, -5.8)

				var_879_0.localPosition = Vector3.Lerp(arg_876_1.var_.moveOldPos1081ui_story, var_879_4, var_879_3)

				local var_879_5 = manager.ui.mainCamera.transform.position - var_879_0.position

				var_879_0.forward = Vector3.New(var_879_5.x, var_879_5.y, var_879_5.z)

				local var_879_6 = var_879_0.localEulerAngles

				var_879_6.z = 0
				var_879_6.x = 0
				var_879_0.localEulerAngles = var_879_6
			end

			if arg_876_1.time_ >= var_879_1 + var_879_2 and arg_876_1.time_ < var_879_1 + var_879_2 + arg_879_0 then
				var_879_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_879_7 = manager.ui.mainCamera.transform.position - var_879_0.position

				var_879_0.forward = Vector3.New(var_879_7.x, var_879_7.y, var_879_7.z)

				local var_879_8 = var_879_0.localEulerAngles

				var_879_8.z = 0
				var_879_8.x = 0
				var_879_0.localEulerAngles = var_879_8
			end

			local var_879_9 = arg_876_1.actors_["1081ui_story"]
			local var_879_10 = 0

			if var_879_10 < arg_876_1.time_ and arg_876_1.time_ <= var_879_10 + arg_879_0 and not isNil(var_879_9) and arg_876_1.var_.characterEffect1081ui_story == nil then
				arg_876_1.var_.characterEffect1081ui_story = var_879_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_879_11 = 0.200000002980232

			if var_879_10 <= arg_876_1.time_ and arg_876_1.time_ < var_879_10 + var_879_11 and not isNil(var_879_9) then
				local var_879_12 = (arg_876_1.time_ - var_879_10) / var_879_11

				if arg_876_1.var_.characterEffect1081ui_story and not isNil(var_879_9) then
					arg_876_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_876_1.time_ >= var_879_10 + var_879_11 and arg_876_1.time_ < var_879_10 + var_879_11 + arg_879_0 and not isNil(var_879_9) and arg_876_1.var_.characterEffect1081ui_story then
				arg_876_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_879_13 = 0

			if var_879_13 < arg_876_1.time_ and arg_876_1.time_ <= var_879_13 + arg_879_0 then
				arg_876_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			local var_879_14 = 0

			if var_879_14 < arg_876_1.time_ and arg_876_1.time_ <= var_879_14 + arg_879_0 then
				arg_876_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_879_15 = 0
			local var_879_16 = 0.65

			if var_879_15 < arg_876_1.time_ and arg_876_1.time_ <= var_879_15 + arg_879_0 then
				arg_876_1.talkMaxDuration = 0
				arg_876_1.dialogCg_.alpha = 1

				arg_876_1.dialog_:SetActive(true)
				SetActive(arg_876_1.leftNameGo_, true)

				local var_879_17 = arg_876_1:FormatText(StoryNameCfg[202].name)

				arg_876_1.leftNameTxt_.text = var_879_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_876_1.leftNameTxt_.transform)

				arg_876_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_876_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_876_1:RecordName(arg_876_1.leftNameTxt_.text)
				SetActive(arg_876_1.iconTrs_.gameObject, false)
				arg_876_1.callingController_:SetSelectedState("normal")

				local var_879_18 = arg_876_1:GetWordFromCfg(1108106209)
				local var_879_19 = arg_876_1:FormatText(var_879_18.content)

				arg_876_1.text_.text = var_879_19

				LuaForUtil.ClearLinePrefixSymbol(arg_876_1.text_)

				local var_879_20 = 26
				local var_879_21 = utf8.len(var_879_19)
				local var_879_22 = var_879_20 <= 0 and var_879_16 or var_879_16 * (var_879_21 / var_879_20)

				if var_879_22 > 0 and var_879_16 < var_879_22 then
					arg_876_1.talkMaxDuration = var_879_22

					if var_879_22 + var_879_15 > arg_876_1.duration_ then
						arg_876_1.duration_ = var_879_22 + var_879_15
					end
				end

				arg_876_1.text_.text = var_879_19
				arg_876_1.typewritter.percent = 0

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb") ~= 0 then
					local var_879_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb") / 1000

					if var_879_23 + var_879_15 > arg_876_1.duration_ then
						arg_876_1.duration_ = var_879_23 + var_879_15
					end

					if var_879_18.prefab_name ~= "" and arg_876_1.actors_[var_879_18.prefab_name] ~= nil then
						local var_879_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_876_1.actors_[var_879_18.prefab_name].transform, "story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")

						arg_876_1:RecordAudio("1108106209", var_879_24)
						arg_876_1:RecordAudio("1108106209", var_879_24)
					else
						arg_876_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")
					end

					arg_876_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106209", "story_v_side_new_1108106.awb")
				end

				arg_876_1:RecordContent(arg_876_1.text_.text)
			end

			local var_879_25 = math.max(var_879_16, arg_876_1.talkMaxDuration)

			if var_879_15 <= arg_876_1.time_ and arg_876_1.time_ < var_879_15 + var_879_25 then
				arg_876_1.typewritter.percent = (arg_876_1.time_ - var_879_15) / var_879_25

				arg_876_1.typewritter:SetDirty()
			end

			if arg_876_1.time_ >= var_879_15 + var_879_25 and arg_876_1.time_ < var_879_15 + var_879_25 + arg_879_0 then
				arg_876_1.typewritter.percent = 1

				arg_876_1.typewritter:SetDirty()
				arg_876_1:ShowNextGo(true)
			end
		end

		arg_876_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_876_1:InitPlayNodeList()
	end,
	Play1108106210 = function(arg_880_0, arg_880_1)
		arg_880_1.time_ = 0
		arg_880_1.frameCnt_ = 0
		arg_880_1.state_ = "playing"
		arg_880_1.curTalkId_ = 1108106210
		arg_880_1.duration_ = 5

		SetActive(arg_880_1.tipsGo_, false)

		function arg_880_1.onSingleLineFinish_()
			arg_880_1.onSingleLineUpdate_ = nil
			arg_880_1.onSingleLineFinish_ = nil
			arg_880_1.state_ = "waiting"
		end

		function arg_880_1.playNext_(arg_882_0)
			if arg_882_0 == 1 then
				arg_880_0:Play1108106211(arg_880_1)
			end
		end

		function arg_880_1.onSingleLineUpdate_(arg_883_0)
			local var_883_0 = 0

			if var_883_0 < arg_880_1.time_ and arg_880_1.time_ <= var_883_0 + arg_883_0 then
				arg_880_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_2")
			end

			local var_883_1 = 0

			if var_883_1 < arg_880_1.time_ and arg_880_1.time_ <= var_883_1 + arg_883_0 then
				arg_880_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_883_2 = arg_880_1.actors_["1081ui_story"]
			local var_883_3 = 0

			if var_883_3 < arg_880_1.time_ and arg_880_1.time_ <= var_883_3 + arg_883_0 and not isNil(var_883_2) and arg_880_1.var_.characterEffect1081ui_story == nil then
				arg_880_1.var_.characterEffect1081ui_story = var_883_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_883_4 = 0.2

			if var_883_3 <= arg_880_1.time_ and arg_880_1.time_ < var_883_3 + var_883_4 and not isNil(var_883_2) then
				local var_883_5 = (arg_880_1.time_ - var_883_3) / var_883_4

				if arg_880_1.var_.characterEffect1081ui_story and not isNil(var_883_2) then
					local var_883_6 = Mathf.Lerp(0, 0.5, var_883_5)

					arg_880_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_880_1.var_.characterEffect1081ui_story.fillRatio = var_883_6
				end
			end

			if arg_880_1.time_ >= var_883_3 + var_883_4 and arg_880_1.time_ < var_883_3 + var_883_4 + arg_883_0 and not isNil(var_883_2) and arg_880_1.var_.characterEffect1081ui_story then
				local var_883_7 = 0.5

				arg_880_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_880_1.var_.characterEffect1081ui_story.fillRatio = var_883_7
			end

			local var_883_8 = 0
			local var_883_9 = 0.825

			if var_883_8 < arg_880_1.time_ and arg_880_1.time_ <= var_883_8 + arg_883_0 then
				arg_880_1.talkMaxDuration = 0
				arg_880_1.dialogCg_.alpha = 1

				arg_880_1.dialog_:SetActive(true)
				SetActive(arg_880_1.leftNameGo_, false)

				arg_880_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_880_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_880_1:RecordName(arg_880_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_880_1.iconTrs_.gameObject, false)
				arg_880_1.callingController_:SetSelectedState("normal")

				local var_883_10 = arg_880_1:GetWordFromCfg(1108106210)
				local var_883_11 = arg_880_1:FormatText(var_883_10.content)

				arg_880_1.text_.text = var_883_11

				LuaForUtil.ClearLinePrefixSymbol(arg_880_1.text_)

				local var_883_12 = 33
				local var_883_13 = utf8.len(var_883_11)
				local var_883_14 = var_883_12 <= 0 and var_883_9 or var_883_9 * (var_883_13 / var_883_12)

				if var_883_14 > 0 and var_883_9 < var_883_14 then
					arg_880_1.talkMaxDuration = var_883_14

					if var_883_14 + var_883_8 > arg_880_1.duration_ then
						arg_880_1.duration_ = var_883_14 + var_883_8
					end
				end

				arg_880_1.text_.text = var_883_11
				arg_880_1.typewritter.percent = 0

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(false)
				arg_880_1:RecordContent(arg_880_1.text_.text)
			end

			local var_883_15 = math.max(var_883_9, arg_880_1.talkMaxDuration)

			if var_883_8 <= arg_880_1.time_ and arg_880_1.time_ < var_883_8 + var_883_15 then
				arg_880_1.typewritter.percent = (arg_880_1.time_ - var_883_8) / var_883_15

				arg_880_1.typewritter:SetDirty()
			end

			if arg_880_1.time_ >= var_883_8 + var_883_15 and arg_880_1.time_ < var_883_8 + var_883_15 + arg_883_0 then
				arg_880_1.typewritter.percent = 1

				arg_880_1.typewritter:SetDirty()
				arg_880_1:ShowNextGo(true)
			end
		end

		arg_880_1.nodeConfigList_ = {}

		arg_880_1:InitPlayNodeList()
	end,
	Play1108106211 = function(arg_884_0, arg_884_1)
		arg_884_1.time_ = 0
		arg_884_1.frameCnt_ = 0
		arg_884_1.state_ = "playing"
		arg_884_1.curTalkId_ = 1108106211
		arg_884_1.duration_ = 7.3

		SetActive(arg_884_1.tipsGo_, false)

		function arg_884_1.onSingleLineFinish_()
			arg_884_1.onSingleLineUpdate_ = nil
			arg_884_1.onSingleLineFinish_ = nil
			arg_884_1.state_ = "waiting"
		end

		function arg_884_1.playNext_(arg_886_0)
			if arg_886_0 == 1 then
				arg_884_0:Play1108106212(arg_884_1)
			end
		end

		function arg_884_1.onSingleLineUpdate_(arg_887_0)
			local var_887_0 = arg_884_1.actors_["1081ui_story"]
			local var_887_1 = 0

			if var_887_1 < arg_884_1.time_ and arg_884_1.time_ <= var_887_1 + arg_887_0 and not isNil(var_887_0) and arg_884_1.var_.characterEffect1081ui_story == nil then
				arg_884_1.var_.characterEffect1081ui_story = var_887_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_887_2 = 0.200000002980232

			if var_887_1 <= arg_884_1.time_ and arg_884_1.time_ < var_887_1 + var_887_2 and not isNil(var_887_0) then
				local var_887_3 = (arg_884_1.time_ - var_887_1) / var_887_2

				if arg_884_1.var_.characterEffect1081ui_story and not isNil(var_887_0) then
					arg_884_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_884_1.time_ >= var_887_1 + var_887_2 and arg_884_1.time_ < var_887_1 + var_887_2 + arg_887_0 and not isNil(var_887_0) and arg_884_1.var_.characterEffect1081ui_story then
				arg_884_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_887_4 = 0
			local var_887_5 = 0.95

			if var_887_4 < arg_884_1.time_ and arg_884_1.time_ <= var_887_4 + arg_887_0 then
				arg_884_1.talkMaxDuration = 0
				arg_884_1.dialogCg_.alpha = 1

				arg_884_1.dialog_:SetActive(true)
				SetActive(arg_884_1.leftNameGo_, true)

				local var_887_6 = arg_884_1:FormatText(StoryNameCfg[202].name)

				arg_884_1.leftNameTxt_.text = var_887_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_884_1.leftNameTxt_.transform)

				arg_884_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_884_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_884_1:RecordName(arg_884_1.leftNameTxt_.text)
				SetActive(arg_884_1.iconTrs_.gameObject, false)
				arg_884_1.callingController_:SetSelectedState("normal")

				local var_887_7 = arg_884_1:GetWordFromCfg(1108106211)
				local var_887_8 = arg_884_1:FormatText(var_887_7.content)

				arg_884_1.text_.text = var_887_8

				LuaForUtil.ClearLinePrefixSymbol(arg_884_1.text_)

				local var_887_9 = 38
				local var_887_10 = utf8.len(var_887_8)
				local var_887_11 = var_887_9 <= 0 and var_887_5 or var_887_5 * (var_887_10 / var_887_9)

				if var_887_11 > 0 and var_887_5 < var_887_11 then
					arg_884_1.talkMaxDuration = var_887_11

					if var_887_11 + var_887_4 > arg_884_1.duration_ then
						arg_884_1.duration_ = var_887_11 + var_887_4
					end
				end

				arg_884_1.text_.text = var_887_8
				arg_884_1.typewritter.percent = 0

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb") ~= 0 then
					local var_887_12 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb") / 1000

					if var_887_12 + var_887_4 > arg_884_1.duration_ then
						arg_884_1.duration_ = var_887_12 + var_887_4
					end

					if var_887_7.prefab_name ~= "" and arg_884_1.actors_[var_887_7.prefab_name] ~= nil then
						local var_887_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_884_1.actors_[var_887_7.prefab_name].transform, "story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")

						arg_884_1:RecordAudio("1108106211", var_887_13)
						arg_884_1:RecordAudio("1108106211", var_887_13)
					else
						arg_884_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")
					end

					arg_884_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106211", "story_v_side_new_1108106.awb")
				end

				arg_884_1:RecordContent(arg_884_1.text_.text)
			end

			local var_887_14 = math.max(var_887_5, arg_884_1.talkMaxDuration)

			if var_887_4 <= arg_884_1.time_ and arg_884_1.time_ < var_887_4 + var_887_14 then
				arg_884_1.typewritter.percent = (arg_884_1.time_ - var_887_4) / var_887_14

				arg_884_1.typewritter:SetDirty()
			end

			if arg_884_1.time_ >= var_887_4 + var_887_14 and arg_884_1.time_ < var_887_4 + var_887_14 + arg_887_0 then
				arg_884_1.typewritter.percent = 1

				arg_884_1.typewritter:SetDirty()
				arg_884_1:ShowNextGo(true)
			end
		end

		arg_884_1.nodeConfigList_ = {}

		arg_884_1:InitPlayNodeList()
	end,
	Play1108106212 = function(arg_888_0, arg_888_1)
		arg_888_1.time_ = 0
		arg_888_1.frameCnt_ = 0
		arg_888_1.state_ = "playing"
		arg_888_1.curTalkId_ = 1108106212
		arg_888_1.duration_ = 5

		SetActive(arg_888_1.tipsGo_, false)

		function arg_888_1.onSingleLineFinish_()
			arg_888_1.onSingleLineUpdate_ = nil
			arg_888_1.onSingleLineFinish_ = nil
			arg_888_1.state_ = "waiting"
		end

		function arg_888_1.playNext_(arg_890_0)
			if arg_890_0 == 1 then
				arg_888_0:Play1108106213(arg_888_1)
			end
		end

		function arg_888_1.onSingleLineUpdate_(arg_891_0)
			local var_891_0 = arg_888_1.actors_["1081ui_story"].transform
			local var_891_1 = 0

			if var_891_1 < arg_888_1.time_ and arg_888_1.time_ <= var_891_1 + arg_891_0 then
				arg_888_1.var_.moveOldPos1081ui_story = var_891_0.localPosition
			end

			local var_891_2 = 0.001

			if var_891_1 <= arg_888_1.time_ and arg_888_1.time_ < var_891_1 + var_891_2 then
				local var_891_3 = (arg_888_1.time_ - var_891_1) / var_891_2
				local var_891_4 = Vector3.New(0, 100, 0)

				var_891_0.localPosition = Vector3.Lerp(arg_888_1.var_.moveOldPos1081ui_story, var_891_4, var_891_3)

				local var_891_5 = manager.ui.mainCamera.transform.position - var_891_0.position

				var_891_0.forward = Vector3.New(var_891_5.x, var_891_5.y, var_891_5.z)

				local var_891_6 = var_891_0.localEulerAngles

				var_891_6.z = 0
				var_891_6.x = 0
				var_891_0.localEulerAngles = var_891_6
			end

			if arg_888_1.time_ >= var_891_1 + var_891_2 and arg_888_1.time_ < var_891_1 + var_891_2 + arg_891_0 then
				var_891_0.localPosition = Vector3.New(0, 100, 0)

				local var_891_7 = manager.ui.mainCamera.transform.position - var_891_0.position

				var_891_0.forward = Vector3.New(var_891_7.x, var_891_7.y, var_891_7.z)

				local var_891_8 = var_891_0.localEulerAngles

				var_891_8.z = 0
				var_891_8.x = 0
				var_891_0.localEulerAngles = var_891_8
			end

			local var_891_9 = 0
			local var_891_10 = 0.05

			if var_891_9 < arg_888_1.time_ and arg_888_1.time_ <= var_891_9 + arg_891_0 then
				arg_888_1.talkMaxDuration = 0
				arg_888_1.dialogCg_.alpha = 1

				arg_888_1.dialog_:SetActive(true)
				SetActive(arg_888_1.leftNameGo_, true)

				local var_891_11 = arg_888_1:FormatText(StoryNameCfg[7].name)

				arg_888_1.leftNameTxt_.text = var_891_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_888_1.leftNameTxt_.transform)

				arg_888_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_888_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_888_1:RecordName(arg_888_1.leftNameTxt_.text)
				SetActive(arg_888_1.iconTrs_.gameObject, true)
				arg_888_1.iconController_:SetSelectedState("hero")

				arg_888_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_888_1.callingController_:SetSelectedState("normal")

				arg_888_1.keyicon_.color = Color.New(1, 1, 1)
				arg_888_1.icon_.color = Color.New(1, 1, 1)

				local var_891_12 = arg_888_1:GetWordFromCfg(1108106212)
				local var_891_13 = arg_888_1:FormatText(var_891_12.content)

				arg_888_1.text_.text = var_891_13

				LuaForUtil.ClearLinePrefixSymbol(arg_888_1.text_)

				local var_891_14 = 2
				local var_891_15 = utf8.len(var_891_13)
				local var_891_16 = var_891_14 <= 0 and var_891_10 or var_891_10 * (var_891_15 / var_891_14)

				if var_891_16 > 0 and var_891_10 < var_891_16 then
					arg_888_1.talkMaxDuration = var_891_16

					if var_891_16 + var_891_9 > arg_888_1.duration_ then
						arg_888_1.duration_ = var_891_16 + var_891_9
					end
				end

				arg_888_1.text_.text = var_891_13
				arg_888_1.typewritter.percent = 0

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(false)
				arg_888_1:RecordContent(arg_888_1.text_.text)
			end

			local var_891_17 = math.max(var_891_10, arg_888_1.talkMaxDuration)

			if var_891_9 <= arg_888_1.time_ and arg_888_1.time_ < var_891_9 + var_891_17 then
				arg_888_1.typewritter.percent = (arg_888_1.time_ - var_891_9) / var_891_17

				arg_888_1.typewritter:SetDirty()
			end

			if arg_888_1.time_ >= var_891_9 + var_891_17 and arg_888_1.time_ < var_891_9 + var_891_17 + arg_891_0 then
				arg_888_1.typewritter.percent = 1

				arg_888_1.typewritter:SetDirty()
				arg_888_1:ShowNextGo(true)
			end
		end

		arg_888_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_888_1:InitPlayNodeList()
	end,
	Play1108106213 = function(arg_892_0, arg_892_1)
		arg_892_1.time_ = 0
		arg_892_1.frameCnt_ = 0
		arg_892_1.state_ = "playing"
		arg_892_1.curTalkId_ = 1108106213
		arg_892_1.duration_ = 1

		SetActive(arg_892_1.tipsGo_, false)

		function arg_892_1.onSingleLineFinish_()
			arg_892_1.onSingleLineUpdate_ = nil
			arg_892_1.onSingleLineFinish_ = nil
			arg_892_1.state_ = "waiting"

			SetActive(arg_892_1.choicesGo_, true)

			for iter_893_0, iter_893_1 in ipairs(arg_892_1.choices_) do
				local var_893_0 = iter_893_0 <= 1

				SetActive(iter_893_1.go, var_893_0)
			end

			arg_892_1.choices_[1].txt.text = arg_892_1:FormatText(StoryChoiceCfg[1001].name)
		end

		function arg_892_1.playNext_(arg_894_0)
			if arg_894_0 == 1 then
				arg_892_0:Play1108106214(arg_892_1)
			end

			arg_892_1:RecordChoiceLog(1108106213, 1001)
		end

		function arg_892_1.onSingleLineUpdate_(arg_895_0)
			return
		end

		arg_892_1.nodeConfigList_ = {}

		arg_892_1:InitPlayNodeList()
	end,
	Play1108106214 = function(arg_896_0, arg_896_1)
		arg_896_1.time_ = 0
		arg_896_1.frameCnt_ = 0
		arg_896_1.state_ = "playing"
		arg_896_1.curTalkId_ = 1108106214
		arg_896_1.duration_ = 8.12

		SetActive(arg_896_1.tipsGo_, false)

		function arg_896_1.onSingleLineFinish_()
			arg_896_1.onSingleLineUpdate_ = nil
			arg_896_1.onSingleLineFinish_ = nil
			arg_896_1.state_ = "waiting"
		end

		function arg_896_1.playNext_(arg_898_0)
			if arg_898_0 == 1 then
				arg_896_0:Play1108106215(arg_896_1)
			end
		end

		function arg_896_1.onSingleLineUpdate_(arg_899_0)
			local var_899_0 = 2

			if var_899_0 < arg_896_1.time_ and arg_896_1.time_ <= var_899_0 + arg_899_0 then
				local var_899_1 = manager.ui.mainCamera.transform.localPosition
				local var_899_2 = Vector3.New(0, 0, 10) + Vector3.New(var_899_1.x, var_899_1.y, 0)
				local var_899_3 = arg_896_1.bgs_.ST07b

				var_899_3.transform.localPosition = var_899_2
				var_899_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_899_4 = var_899_3:GetComponent("SpriteRenderer")

				if var_899_4 and var_899_4.sprite then
					local var_899_5 = (var_899_3.transform.localPosition - var_899_1).z
					local var_899_6 = manager.ui.mainCameraCom_
					local var_899_7 = 2 * var_899_5 * Mathf.Tan(var_899_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_899_8 = var_899_7 * var_899_6.aspect
					local var_899_9 = var_899_4.sprite.bounds.size.x
					local var_899_10 = var_899_4.sprite.bounds.size.y
					local var_899_11 = var_899_8 / var_899_9
					local var_899_12 = var_899_7 / var_899_10
					local var_899_13 = var_899_12 < var_899_11 and var_899_11 or var_899_12

					var_899_3.transform.localScale = Vector3.New(var_899_13, var_899_13, 0)
				end

				for iter_899_0, iter_899_1 in pairs(arg_896_1.bgs_) do
					if iter_899_0 ~= "ST07b" then
						iter_899_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_899_14 = 0

			if var_899_14 < arg_896_1.time_ and arg_896_1.time_ <= var_899_14 + arg_899_0 then
				arg_896_1.mask_.enabled = true
				arg_896_1.mask_.raycastTarget = true

				arg_896_1:SetGaussion(false)
			end

			local var_899_15 = 2

			if var_899_14 <= arg_896_1.time_ and arg_896_1.time_ < var_899_14 + var_899_15 then
				local var_899_16 = (arg_896_1.time_ - var_899_14) / var_899_15
				local var_899_17 = Color.New(0, 0, 0)

				var_899_17.a = Mathf.Lerp(0, 1, var_899_16)
				arg_896_1.mask_.color = var_899_17
			end

			if arg_896_1.time_ >= var_899_14 + var_899_15 and arg_896_1.time_ < var_899_14 + var_899_15 + arg_899_0 then
				local var_899_18 = Color.New(0, 0, 0)

				var_899_18.a = 1
				arg_896_1.mask_.color = var_899_18
			end

			local var_899_19 = 2

			if var_899_19 < arg_896_1.time_ and arg_896_1.time_ <= var_899_19 + arg_899_0 then
				arg_896_1.mask_.enabled = true
				arg_896_1.mask_.raycastTarget = true

				arg_896_1:SetGaussion(false)
			end

			local var_899_20 = 2

			if var_899_19 <= arg_896_1.time_ and arg_896_1.time_ < var_899_19 + var_899_20 then
				local var_899_21 = (arg_896_1.time_ - var_899_19) / var_899_20
				local var_899_22 = Color.New(0, 0, 0)

				var_899_22.a = Mathf.Lerp(1, 0, var_899_21)
				arg_896_1.mask_.color = var_899_22
			end

			if arg_896_1.time_ >= var_899_19 + var_899_20 and arg_896_1.time_ < var_899_19 + var_899_20 + arg_899_0 then
				local var_899_23 = Color.New(0, 0, 0)
				local var_899_24 = 0

				arg_896_1.mask_.enabled = false
				var_899_23.a = var_899_24
				arg_896_1.mask_.color = var_899_23
			end

			if arg_896_1.frameCnt_ <= 1 then
				arg_896_1.dialog_:SetActive(false)
			end

			local var_899_25 = 3.125
			local var_899_26 = 0.875

			if var_899_25 < arg_896_1.time_ and arg_896_1.time_ <= var_899_25 + arg_899_0 then
				arg_896_1.talkMaxDuration = 0

				arg_896_1.dialog_:SetActive(true)

				arg_896_1.dialogCg_.alpha = 0

				local var_899_27 = LeanTween.value(arg_896_1.dialog_, 0, 1, 0.3)

				var_899_27:setOnUpdate(LuaHelper.FloatAction(function(arg_900_0)
					arg_896_1.dialogCg_.alpha = arg_900_0
				end))
				var_899_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_896_1.dialog_)
					var_899_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_896_1.duration_ = arg_896_1.duration_ + 0.3

				SetActive(arg_896_1.leftNameGo_, true)

				local var_899_28 = arg_896_1:FormatText(StoryNameCfg[7].name)

				arg_896_1.leftNameTxt_.text = var_899_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_896_1.leftNameTxt_.transform)

				arg_896_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_896_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_896_1:RecordName(arg_896_1.leftNameTxt_.text)
				SetActive(arg_896_1.iconTrs_.gameObject, true)
				arg_896_1.iconController_:SetSelectedState("hero")

				arg_896_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_896_1.callingController_:SetSelectedState("normal")

				arg_896_1.keyicon_.color = Color.New(1, 1, 1)
				arg_896_1.icon_.color = Color.New(1, 1, 1)

				local var_899_29 = arg_896_1:GetWordFromCfg(1108106214)
				local var_899_30 = arg_896_1:FormatText(var_899_29.content)

				arg_896_1.text_.text = var_899_30

				LuaForUtil.ClearLinePrefixSymbol(arg_896_1.text_)

				local var_899_31 = 35
				local var_899_32 = utf8.len(var_899_30)
				local var_899_33 = var_899_31 <= 0 and var_899_26 or var_899_26 * (var_899_32 / var_899_31)

				if var_899_33 > 0 and var_899_26 < var_899_33 then
					arg_896_1.talkMaxDuration = var_899_33
					var_899_25 = var_899_25 + 0.3

					if var_899_33 + var_899_25 > arg_896_1.duration_ then
						arg_896_1.duration_ = var_899_33 + var_899_25
					end
				end

				arg_896_1.text_.text = var_899_30
				arg_896_1.typewritter.percent = 0

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(false)
				arg_896_1:RecordContent(arg_896_1.text_.text)
			end

			local var_899_34 = var_899_25 + 0.3
			local var_899_35 = math.max(var_899_26, arg_896_1.talkMaxDuration)

			if var_899_34 <= arg_896_1.time_ and arg_896_1.time_ < var_899_34 + var_899_35 then
				arg_896_1.typewritter.percent = (arg_896_1.time_ - var_899_34) / var_899_35

				arg_896_1.typewritter:SetDirty()
			end

			if arg_896_1.time_ >= var_899_34 + var_899_35 and arg_896_1.time_ < var_899_34 + var_899_35 + arg_899_0 then
				arg_896_1.typewritter.percent = 1

				arg_896_1.typewritter:SetDirty()
				arg_896_1:ShowNextGo(true)
			end
		end

		arg_896_1.nodeConfigList_ = {}

		arg_896_1:InitPlayNodeList()
	end,
	Play1108106215 = function(arg_902_0, arg_902_1)
		arg_902_1.time_ = 0
		arg_902_1.frameCnt_ = 0
		arg_902_1.state_ = "playing"
		arg_902_1.curTalkId_ = 1108106215
		arg_902_1.duration_ = 5.27

		SetActive(arg_902_1.tipsGo_, false)

		function arg_902_1.onSingleLineFinish_()
			arg_902_1.onSingleLineUpdate_ = nil
			arg_902_1.onSingleLineFinish_ = nil
			arg_902_1.state_ = "waiting"
		end

		function arg_902_1.playNext_(arg_904_0)
			if arg_904_0 == 1 then
				arg_902_0:Play1108106216(arg_902_1)
			end
		end

		function arg_902_1.onSingleLineUpdate_(arg_905_0)
			local var_905_0 = arg_902_1.actors_["1081ui_story"].transform
			local var_905_1 = 0

			if var_905_1 < arg_902_1.time_ and arg_902_1.time_ <= var_905_1 + arg_905_0 then
				arg_902_1.var_.moveOldPos1081ui_story = var_905_0.localPosition
			end

			local var_905_2 = 0.001

			if var_905_1 <= arg_902_1.time_ and arg_902_1.time_ < var_905_1 + var_905_2 then
				local var_905_3 = (arg_902_1.time_ - var_905_1) / var_905_2
				local var_905_4 = Vector3.New(0, -0.92, -5.8)

				var_905_0.localPosition = Vector3.Lerp(arg_902_1.var_.moveOldPos1081ui_story, var_905_4, var_905_3)

				local var_905_5 = manager.ui.mainCamera.transform.position - var_905_0.position

				var_905_0.forward = Vector3.New(var_905_5.x, var_905_5.y, var_905_5.z)

				local var_905_6 = var_905_0.localEulerAngles

				var_905_6.z = 0
				var_905_6.x = 0
				var_905_0.localEulerAngles = var_905_6
			end

			if arg_902_1.time_ >= var_905_1 + var_905_2 and arg_902_1.time_ < var_905_1 + var_905_2 + arg_905_0 then
				var_905_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_905_7 = manager.ui.mainCamera.transform.position - var_905_0.position

				var_905_0.forward = Vector3.New(var_905_7.x, var_905_7.y, var_905_7.z)

				local var_905_8 = var_905_0.localEulerAngles

				var_905_8.z = 0
				var_905_8.x = 0
				var_905_0.localEulerAngles = var_905_8
			end

			local var_905_9 = arg_902_1.actors_["1081ui_story"]
			local var_905_10 = 0

			if var_905_10 < arg_902_1.time_ and arg_902_1.time_ <= var_905_10 + arg_905_0 and not isNil(var_905_9) and arg_902_1.var_.characterEffect1081ui_story == nil then
				arg_902_1.var_.characterEffect1081ui_story = var_905_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_905_11 = 0.200000002980232

			if var_905_10 <= arg_902_1.time_ and arg_902_1.time_ < var_905_10 + var_905_11 and not isNil(var_905_9) then
				local var_905_12 = (arg_902_1.time_ - var_905_10) / var_905_11

				if arg_902_1.var_.characterEffect1081ui_story and not isNil(var_905_9) then
					arg_902_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_902_1.time_ >= var_905_10 + var_905_11 and arg_902_1.time_ < var_905_10 + var_905_11 + arg_905_0 and not isNil(var_905_9) and arg_902_1.var_.characterEffect1081ui_story then
				arg_902_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_905_13 = 0

			if var_905_13 < arg_902_1.time_ and arg_902_1.time_ <= var_905_13 + arg_905_0 then
				arg_902_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_1")
			end

			local var_905_14 = 0

			if var_905_14 < arg_902_1.time_ and arg_902_1.time_ <= var_905_14 + arg_905_0 then
				arg_902_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_905_15 = 0
			local var_905_16 = 0.9

			if var_905_15 < arg_902_1.time_ and arg_902_1.time_ <= var_905_15 + arg_905_0 then
				arg_902_1.talkMaxDuration = 0
				arg_902_1.dialogCg_.alpha = 1

				arg_902_1.dialog_:SetActive(true)
				SetActive(arg_902_1.leftNameGo_, true)

				local var_905_17 = arg_902_1:FormatText(StoryNameCfg[202].name)

				arg_902_1.leftNameTxt_.text = var_905_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_902_1.leftNameTxt_.transform)

				arg_902_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_902_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_902_1:RecordName(arg_902_1.leftNameTxt_.text)
				SetActive(arg_902_1.iconTrs_.gameObject, false)
				arg_902_1.callingController_:SetSelectedState("normal")

				local var_905_18 = arg_902_1:GetWordFromCfg(1108106215)
				local var_905_19 = arg_902_1:FormatText(var_905_18.content)

				arg_902_1.text_.text = var_905_19

				LuaForUtil.ClearLinePrefixSymbol(arg_902_1.text_)

				local var_905_20 = 36
				local var_905_21 = utf8.len(var_905_19)
				local var_905_22 = var_905_20 <= 0 and var_905_16 or var_905_16 * (var_905_21 / var_905_20)

				if var_905_22 > 0 and var_905_16 < var_905_22 then
					arg_902_1.talkMaxDuration = var_905_22

					if var_905_22 + var_905_15 > arg_902_1.duration_ then
						arg_902_1.duration_ = var_905_22 + var_905_15
					end
				end

				arg_902_1.text_.text = var_905_19
				arg_902_1.typewritter.percent = 0

				arg_902_1.typewritter:SetDirty()
				arg_902_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb") ~= 0 then
					local var_905_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb") / 1000

					if var_905_23 + var_905_15 > arg_902_1.duration_ then
						arg_902_1.duration_ = var_905_23 + var_905_15
					end

					if var_905_18.prefab_name ~= "" and arg_902_1.actors_[var_905_18.prefab_name] ~= nil then
						local var_905_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_902_1.actors_[var_905_18.prefab_name].transform, "story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")

						arg_902_1:RecordAudio("1108106215", var_905_24)
						arg_902_1:RecordAudio("1108106215", var_905_24)
					else
						arg_902_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")
					end

					arg_902_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106215", "story_v_side_new_1108106.awb")
				end

				arg_902_1:RecordContent(arg_902_1.text_.text)
			end

			local var_905_25 = math.max(var_905_16, arg_902_1.talkMaxDuration)

			if var_905_15 <= arg_902_1.time_ and arg_902_1.time_ < var_905_15 + var_905_25 then
				arg_902_1.typewritter.percent = (arg_902_1.time_ - var_905_15) / var_905_25

				arg_902_1.typewritter:SetDirty()
			end

			if arg_902_1.time_ >= var_905_15 + var_905_25 and arg_902_1.time_ < var_905_15 + var_905_25 + arg_905_0 then
				arg_902_1.typewritter.percent = 1

				arg_902_1.typewritter:SetDirty()
				arg_902_1:ShowNextGo(true)
			end
		end

		arg_902_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_902_1:InitPlayNodeList()
	end,
	Play1108106216 = function(arg_906_0, arg_906_1)
		arg_906_1.time_ = 0
		arg_906_1.frameCnt_ = 0
		arg_906_1.state_ = "playing"
		arg_906_1.curTalkId_ = 1108106216
		arg_906_1.duration_ = 1

		SetActive(arg_906_1.tipsGo_, true)

		arg_906_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_906_1.onSingleLineFinish_()
			arg_906_1.onSingleLineUpdate_ = nil
			arg_906_1.onSingleLineFinish_ = nil
			arg_906_1.state_ = "waiting"

			SetActive(arg_906_1.choicesGo_, true)

			for iter_907_0, iter_907_1 in ipairs(arg_906_1.choices_) do
				local var_907_0 = iter_907_0 <= 2

				SetActive(iter_907_1.go, var_907_0)
			end

			arg_906_1.choices_[1].txt.text = arg_906_1:FormatText(StoryChoiceCfg[1002].name)
			arg_906_1.choices_[2].txt.text = arg_906_1:FormatText(StoryChoiceCfg[1003].name)
		end

		function arg_906_1.playNext_(arg_908_0)
			if arg_908_0 == 1 then
				PlayerAction.UseStoryTrigger(1081013, 210810106, 1108106216, 1)
				arg_906_0:Play1108106217(arg_906_1)
			end

			if arg_908_0 == 2 then
				PlayerAction.UseStoryTrigger(1081013, 210810106, 1108106216, 2)
				arg_906_0:Play1108106218(arg_906_1)
			end

			arg_906_1:RecordChoiceLog(1108106216, 1002, 1003)
		end

		function arg_906_1.onSingleLineUpdate_(arg_909_0)
			local var_909_0 = arg_906_1.actors_["1081ui_story"]
			local var_909_1 = 0

			if var_909_1 < arg_906_1.time_ and arg_906_1.time_ <= var_909_1 + arg_909_0 and not isNil(var_909_0) and arg_906_1.var_.characterEffect1081ui_story == nil then
				arg_906_1.var_.characterEffect1081ui_story = var_909_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_909_2 = 0.200000002980232

			if var_909_1 <= arg_906_1.time_ and arg_906_1.time_ < var_909_1 + var_909_2 and not isNil(var_909_0) then
				local var_909_3 = (arg_906_1.time_ - var_909_1) / var_909_2

				if arg_906_1.var_.characterEffect1081ui_story and not isNil(var_909_0) then
					local var_909_4 = Mathf.Lerp(0, 0.5, var_909_3)

					arg_906_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_906_1.var_.characterEffect1081ui_story.fillRatio = var_909_4
				end
			end

			if arg_906_1.time_ >= var_909_1 + var_909_2 and arg_906_1.time_ < var_909_1 + var_909_2 + arg_909_0 and not isNil(var_909_0) and arg_906_1.var_.characterEffect1081ui_story then
				local var_909_5 = 0.5

				arg_906_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_906_1.var_.characterEffect1081ui_story.fillRatio = var_909_5
			end
		end

		arg_906_1.nodeConfigList_ = {}

		arg_906_1:InitPlayNodeList()
	end,
	Play1108106217 = function(arg_910_0, arg_910_1)
		arg_910_1.time_ = 0
		arg_910_1.frameCnt_ = 0
		arg_910_1.state_ = "playing"
		arg_910_1.curTalkId_ = 1108106217
		arg_910_1.duration_ = 5.5

		SetActive(arg_910_1.tipsGo_, false)

		function arg_910_1.onSingleLineFinish_()
			arg_910_1.onSingleLineUpdate_ = nil
			arg_910_1.onSingleLineFinish_ = nil
			arg_910_1.state_ = "waiting"
		end

		function arg_910_1.playNext_(arg_912_0)
			if arg_912_0 == 1 then
				arg_910_0:Play1108106219(arg_910_1)
			end
		end

		function arg_910_1.onSingleLineUpdate_(arg_913_0)
			local var_913_0 = arg_910_1.actors_["1081ui_story"].transform
			local var_913_1 = 0

			if var_913_1 < arg_910_1.time_ and arg_910_1.time_ <= var_913_1 + arg_913_0 then
				arg_910_1.var_.moveOldPos1081ui_story = var_913_0.localPosition
			end

			local var_913_2 = 0.001

			if var_913_1 <= arg_910_1.time_ and arg_910_1.time_ < var_913_1 + var_913_2 then
				local var_913_3 = (arg_910_1.time_ - var_913_1) / var_913_2
				local var_913_4 = Vector3.New(0, -0.92, -5.8)

				var_913_0.localPosition = Vector3.Lerp(arg_910_1.var_.moveOldPos1081ui_story, var_913_4, var_913_3)

				local var_913_5 = manager.ui.mainCamera.transform.position - var_913_0.position

				var_913_0.forward = Vector3.New(var_913_5.x, var_913_5.y, var_913_5.z)

				local var_913_6 = var_913_0.localEulerAngles

				var_913_6.z = 0
				var_913_6.x = 0
				var_913_0.localEulerAngles = var_913_6
			end

			if arg_910_1.time_ >= var_913_1 + var_913_2 and arg_910_1.time_ < var_913_1 + var_913_2 + arg_913_0 then
				var_913_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_913_7 = manager.ui.mainCamera.transform.position - var_913_0.position

				var_913_0.forward = Vector3.New(var_913_7.x, var_913_7.y, var_913_7.z)

				local var_913_8 = var_913_0.localEulerAngles

				var_913_8.z = 0
				var_913_8.x = 0
				var_913_0.localEulerAngles = var_913_8
			end

			local var_913_9 = arg_910_1.actors_["1081ui_story"]
			local var_913_10 = 0

			if var_913_10 < arg_910_1.time_ and arg_910_1.time_ <= var_913_10 + arg_913_0 and not isNil(var_913_9) and arg_910_1.var_.characterEffect1081ui_story == nil then
				arg_910_1.var_.characterEffect1081ui_story = var_913_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_913_11 = 0.200000002980232

			if var_913_10 <= arg_910_1.time_ and arg_910_1.time_ < var_913_10 + var_913_11 and not isNil(var_913_9) then
				local var_913_12 = (arg_910_1.time_ - var_913_10) / var_913_11

				if arg_910_1.var_.characterEffect1081ui_story and not isNil(var_913_9) then
					arg_910_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_910_1.time_ >= var_913_10 + var_913_11 and arg_910_1.time_ < var_913_10 + var_913_11 + arg_913_0 and not isNil(var_913_9) and arg_910_1.var_.characterEffect1081ui_story then
				arg_910_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_913_13 = 0

			if var_913_13 < arg_910_1.time_ and arg_910_1.time_ <= var_913_13 + arg_913_0 then
				arg_910_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			local var_913_14 = 0

			if var_913_14 < arg_910_1.time_ and arg_910_1.time_ <= var_913_14 + arg_913_0 then
				arg_910_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_913_15 = 0
			local var_913_16 = 0.5

			if var_913_15 < arg_910_1.time_ and arg_910_1.time_ <= var_913_15 + arg_913_0 then
				arg_910_1.talkMaxDuration = 0
				arg_910_1.dialogCg_.alpha = 1

				arg_910_1.dialog_:SetActive(true)
				SetActive(arg_910_1.leftNameGo_, true)

				local var_913_17 = arg_910_1:FormatText(StoryNameCfg[202].name)

				arg_910_1.leftNameTxt_.text = var_913_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_910_1.leftNameTxt_.transform)

				arg_910_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_910_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_910_1:RecordName(arg_910_1.leftNameTxt_.text)
				SetActive(arg_910_1.iconTrs_.gameObject, false)
				arg_910_1.callingController_:SetSelectedState("normal")

				local var_913_18 = arg_910_1:GetWordFromCfg(1108106217)
				local var_913_19 = arg_910_1:FormatText(var_913_18.content)

				arg_910_1.text_.text = var_913_19

				LuaForUtil.ClearLinePrefixSymbol(arg_910_1.text_)

				local var_913_20 = 19
				local var_913_21 = utf8.len(var_913_19)
				local var_913_22 = var_913_20 <= 0 and var_913_16 or var_913_16 * (var_913_21 / var_913_20)

				if var_913_22 > 0 and var_913_16 < var_913_22 then
					arg_910_1.talkMaxDuration = var_913_22

					if var_913_22 + var_913_15 > arg_910_1.duration_ then
						arg_910_1.duration_ = var_913_22 + var_913_15
					end
				end

				arg_910_1.text_.text = var_913_19
				arg_910_1.typewritter.percent = 0

				arg_910_1.typewritter:SetDirty()
				arg_910_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb") ~= 0 then
					local var_913_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb") / 1000

					if var_913_23 + var_913_15 > arg_910_1.duration_ then
						arg_910_1.duration_ = var_913_23 + var_913_15
					end

					if var_913_18.prefab_name ~= "" and arg_910_1.actors_[var_913_18.prefab_name] ~= nil then
						local var_913_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_910_1.actors_[var_913_18.prefab_name].transform, "story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")

						arg_910_1:RecordAudio("1108106217", var_913_24)
						arg_910_1:RecordAudio("1108106217", var_913_24)
					else
						arg_910_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")
					end

					arg_910_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106217", "story_v_side_new_1108106.awb")
				end

				arg_910_1:RecordContent(arg_910_1.text_.text)
			end

			local var_913_25 = math.max(var_913_16, arg_910_1.talkMaxDuration)

			if var_913_15 <= arg_910_1.time_ and arg_910_1.time_ < var_913_15 + var_913_25 then
				arg_910_1.typewritter.percent = (arg_910_1.time_ - var_913_15) / var_913_25

				arg_910_1.typewritter:SetDirty()
			end

			if arg_910_1.time_ >= var_913_15 + var_913_25 and arg_910_1.time_ < var_913_15 + var_913_25 + arg_913_0 then
				arg_910_1.typewritter.percent = 1

				arg_910_1.typewritter:SetDirty()
				arg_910_1:ShowNextGo(true)
			end
		end

		arg_910_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_910_1:InitPlayNodeList()
	end,
	Play1108106219 = function(arg_914_0, arg_914_1)
		arg_914_1.time_ = 0
		arg_914_1.frameCnt_ = 0
		arg_914_1.state_ = "playing"
		arg_914_1.curTalkId_ = 1108106219
		arg_914_1.duration_ = 2

		SetActive(arg_914_1.tipsGo_, false)

		function arg_914_1.onSingleLineFinish_()
			arg_914_1.onSingleLineUpdate_ = nil
			arg_914_1.onSingleLineFinish_ = nil
			arg_914_1.state_ = "waiting"
		end

		function arg_914_1.playNext_(arg_916_0)
			if arg_916_0 == 1 then
				arg_914_0:Play1108106220(arg_914_1)
			end
		end

		function arg_914_1.onSingleLineUpdate_(arg_917_0)
			local var_917_0 = arg_914_1.actors_["1081ui_story"].transform
			local var_917_1 = 0

			if var_917_1 < arg_914_1.time_ and arg_914_1.time_ <= var_917_1 + arg_917_0 then
				arg_914_1.var_.moveOldPos1081ui_story = var_917_0.localPosition
			end

			local var_917_2 = 0.001

			if var_917_1 <= arg_914_1.time_ and arg_914_1.time_ < var_917_1 + var_917_2 then
				local var_917_3 = (arg_914_1.time_ - var_917_1) / var_917_2
				local var_917_4 = Vector3.New(0, -0.92, -5.8)

				var_917_0.localPosition = Vector3.Lerp(arg_914_1.var_.moveOldPos1081ui_story, var_917_4, var_917_3)

				local var_917_5 = manager.ui.mainCamera.transform.position - var_917_0.position

				var_917_0.forward = Vector3.New(var_917_5.x, var_917_5.y, var_917_5.z)

				local var_917_6 = var_917_0.localEulerAngles

				var_917_6.z = 0
				var_917_6.x = 0
				var_917_0.localEulerAngles = var_917_6
			end

			if arg_914_1.time_ >= var_917_1 + var_917_2 and arg_914_1.time_ < var_917_1 + var_917_2 + arg_917_0 then
				var_917_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_917_7 = manager.ui.mainCamera.transform.position - var_917_0.position

				var_917_0.forward = Vector3.New(var_917_7.x, var_917_7.y, var_917_7.z)

				local var_917_8 = var_917_0.localEulerAngles

				var_917_8.z = 0
				var_917_8.x = 0
				var_917_0.localEulerAngles = var_917_8
			end

			local var_917_9 = arg_914_1.actors_["1081ui_story"]
			local var_917_10 = 0

			if var_917_10 < arg_914_1.time_ and arg_914_1.time_ <= var_917_10 + arg_917_0 and not isNil(var_917_9) and arg_914_1.var_.characterEffect1081ui_story == nil then
				arg_914_1.var_.characterEffect1081ui_story = var_917_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_917_11 = 0.200000002980232

			if var_917_10 <= arg_914_1.time_ and arg_914_1.time_ < var_917_10 + var_917_11 and not isNil(var_917_9) then
				local var_917_12 = (arg_914_1.time_ - var_917_10) / var_917_11

				if arg_914_1.var_.characterEffect1081ui_story and not isNil(var_917_9) then
					arg_914_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_914_1.time_ >= var_917_10 + var_917_11 and arg_914_1.time_ < var_917_10 + var_917_11 + arg_917_0 and not isNil(var_917_9) and arg_914_1.var_.characterEffect1081ui_story then
				arg_914_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_917_13 = 0

			if var_917_13 < arg_914_1.time_ and arg_914_1.time_ <= var_917_13 + arg_917_0 then
				arg_914_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_917_14 = 0
			local var_917_15 = 0.125

			if var_917_14 < arg_914_1.time_ and arg_914_1.time_ <= var_917_14 + arg_917_0 then
				arg_914_1.talkMaxDuration = 0
				arg_914_1.dialogCg_.alpha = 1

				arg_914_1.dialog_:SetActive(true)
				SetActive(arg_914_1.leftNameGo_, true)

				local var_917_16 = arg_914_1:FormatText(StoryNameCfg[202].name)

				arg_914_1.leftNameTxt_.text = var_917_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_914_1.leftNameTxt_.transform)

				arg_914_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_914_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_914_1:RecordName(arg_914_1.leftNameTxt_.text)
				SetActive(arg_914_1.iconTrs_.gameObject, false)
				arg_914_1.callingController_:SetSelectedState("normal")

				local var_917_17 = arg_914_1:GetWordFromCfg(1108106219)
				local var_917_18 = arg_914_1:FormatText(var_917_17.content)

				arg_914_1.text_.text = var_917_18

				LuaForUtil.ClearLinePrefixSymbol(arg_914_1.text_)

				local var_917_19 = 5
				local var_917_20 = utf8.len(var_917_18)
				local var_917_21 = var_917_19 <= 0 and var_917_15 or var_917_15 * (var_917_20 / var_917_19)

				if var_917_21 > 0 and var_917_15 < var_917_21 then
					arg_914_1.talkMaxDuration = var_917_21

					if var_917_21 + var_917_14 > arg_914_1.duration_ then
						arg_914_1.duration_ = var_917_21 + var_917_14
					end
				end

				arg_914_1.text_.text = var_917_18
				arg_914_1.typewritter.percent = 0

				arg_914_1.typewritter:SetDirty()
				arg_914_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb") ~= 0 then
					local var_917_22 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb") / 1000

					if var_917_22 + var_917_14 > arg_914_1.duration_ then
						arg_914_1.duration_ = var_917_22 + var_917_14
					end

					if var_917_17.prefab_name ~= "" and arg_914_1.actors_[var_917_17.prefab_name] ~= nil then
						local var_917_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_914_1.actors_[var_917_17.prefab_name].transform, "story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")

						arg_914_1:RecordAudio("1108106219", var_917_23)
						arg_914_1:RecordAudio("1108106219", var_917_23)
					else
						arg_914_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")
					end

					arg_914_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106219", "story_v_side_new_1108106.awb")
				end

				arg_914_1:RecordContent(arg_914_1.text_.text)
			end

			local var_917_24 = math.max(var_917_15, arg_914_1.talkMaxDuration)

			if var_917_14 <= arg_914_1.time_ and arg_914_1.time_ < var_917_14 + var_917_24 then
				arg_914_1.typewritter.percent = (arg_914_1.time_ - var_917_14) / var_917_24

				arg_914_1.typewritter:SetDirty()
			end

			if arg_914_1.time_ >= var_917_14 + var_917_24 and arg_914_1.time_ < var_917_14 + var_917_24 + arg_917_0 then
				arg_914_1.typewritter.percent = 1

				arg_914_1.typewritter:SetDirty()
				arg_914_1:ShowNextGo(true)
			end
		end

		arg_914_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_914_1:InitPlayNodeList()
	end,
	Play1108106220 = function(arg_918_0, arg_918_1)
		arg_918_1.time_ = 0
		arg_918_1.frameCnt_ = 0
		arg_918_1.state_ = "playing"
		arg_918_1.curTalkId_ = 1108106220
		arg_918_1.duration_ = 5

		SetActive(arg_918_1.tipsGo_, false)

		function arg_918_1.onSingleLineFinish_()
			arg_918_1.onSingleLineUpdate_ = nil
			arg_918_1.onSingleLineFinish_ = nil
			arg_918_1.state_ = "waiting"
		end

		function arg_918_1.playNext_(arg_920_0)
			if arg_920_0 == 1 then
				arg_918_0:Play1108106221(arg_918_1)
			end
		end

		function arg_918_1.onSingleLineUpdate_(arg_921_0)
			local var_921_0 = arg_918_1.actors_["1081ui_story"]
			local var_921_1 = 0

			if var_921_1 < arg_918_1.time_ and arg_918_1.time_ <= var_921_1 + arg_921_0 and not isNil(var_921_0) and arg_918_1.var_.characterEffect1081ui_story == nil then
				arg_918_1.var_.characterEffect1081ui_story = var_921_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_921_2 = 0.200000002980232

			if var_921_1 <= arg_918_1.time_ and arg_918_1.time_ < var_921_1 + var_921_2 and not isNil(var_921_0) then
				local var_921_3 = (arg_918_1.time_ - var_921_1) / var_921_2

				if arg_918_1.var_.characterEffect1081ui_story and not isNil(var_921_0) then
					local var_921_4 = Mathf.Lerp(0, 0.5, var_921_3)

					arg_918_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_918_1.var_.characterEffect1081ui_story.fillRatio = var_921_4
				end
			end

			if arg_918_1.time_ >= var_921_1 + var_921_2 and arg_918_1.time_ < var_921_1 + var_921_2 + arg_921_0 and not isNil(var_921_0) and arg_918_1.var_.characterEffect1081ui_story then
				local var_921_5 = 0.5

				arg_918_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_918_1.var_.characterEffect1081ui_story.fillRatio = var_921_5
			end

			local var_921_6 = 0
			local var_921_7 = 0.7

			if var_921_6 < arg_918_1.time_ and arg_918_1.time_ <= var_921_6 + arg_921_0 then
				arg_918_1.talkMaxDuration = 0
				arg_918_1.dialogCg_.alpha = 1

				arg_918_1.dialog_:SetActive(true)
				SetActive(arg_918_1.leftNameGo_, false)

				arg_918_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_918_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_918_1:RecordName(arg_918_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_918_1.iconTrs_.gameObject, false)
				arg_918_1.callingController_:SetSelectedState("normal")

				local var_921_8 = arg_918_1:GetWordFromCfg(1108106220)
				local var_921_9 = arg_918_1:FormatText(var_921_8.content)

				arg_918_1.text_.text = var_921_9

				LuaForUtil.ClearLinePrefixSymbol(arg_918_1.text_)

				local var_921_10 = 28
				local var_921_11 = utf8.len(var_921_9)
				local var_921_12 = var_921_10 <= 0 and var_921_7 or var_921_7 * (var_921_11 / var_921_10)

				if var_921_12 > 0 and var_921_7 < var_921_12 then
					arg_918_1.talkMaxDuration = var_921_12

					if var_921_12 + var_921_6 > arg_918_1.duration_ then
						arg_918_1.duration_ = var_921_12 + var_921_6
					end
				end

				arg_918_1.text_.text = var_921_9
				arg_918_1.typewritter.percent = 0

				arg_918_1.typewritter:SetDirty()
				arg_918_1:ShowNextGo(false)
				arg_918_1:RecordContent(arg_918_1.text_.text)
			end

			local var_921_13 = math.max(var_921_7, arg_918_1.talkMaxDuration)

			if var_921_6 <= arg_918_1.time_ and arg_918_1.time_ < var_921_6 + var_921_13 then
				arg_918_1.typewritter.percent = (arg_918_1.time_ - var_921_6) / var_921_13

				arg_918_1.typewritter:SetDirty()
			end

			if arg_918_1.time_ >= var_921_6 + var_921_13 and arg_918_1.time_ < var_921_6 + var_921_13 + arg_921_0 then
				arg_918_1.typewritter.percent = 1

				arg_918_1.typewritter:SetDirty()
				arg_918_1:ShowNextGo(true)
			end
		end

		arg_918_1.nodeConfigList_ = {}

		arg_918_1:InitPlayNodeList()
	end,
	Play1108106221 = function(arg_922_0, arg_922_1)
		arg_922_1.time_ = 0
		arg_922_1.frameCnt_ = 0
		arg_922_1.state_ = "playing"
		arg_922_1.curTalkId_ = 1108106221
		arg_922_1.duration_ = 4.93

		SetActive(arg_922_1.tipsGo_, false)

		function arg_922_1.onSingleLineFinish_()
			arg_922_1.onSingleLineUpdate_ = nil
			arg_922_1.onSingleLineFinish_ = nil
			arg_922_1.state_ = "waiting"
		end

		function arg_922_1.playNext_(arg_924_0)
			if arg_924_0 == 1 then
				arg_922_0:Play1108106222(arg_922_1)
			end
		end

		function arg_922_1.onSingleLineUpdate_(arg_925_0)
			local var_925_0 = 0

			if var_925_0 < arg_922_1.time_ and arg_922_1.time_ <= var_925_0 + arg_925_0 then
				arg_922_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_925_1 = arg_922_1.actors_["1081ui_story"]
			local var_925_2 = 0

			if var_925_2 < arg_922_1.time_ and arg_922_1.time_ <= var_925_2 + arg_925_0 and not isNil(var_925_1) and arg_922_1.var_.characterEffect1081ui_story == nil then
				arg_922_1.var_.characterEffect1081ui_story = var_925_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_925_3 = 0.200000002980232

			if var_925_2 <= arg_922_1.time_ and arg_922_1.time_ < var_925_2 + var_925_3 and not isNil(var_925_1) then
				local var_925_4 = (arg_922_1.time_ - var_925_2) / var_925_3

				if arg_922_1.var_.characterEffect1081ui_story and not isNil(var_925_1) then
					arg_922_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_922_1.time_ >= var_925_2 + var_925_3 and arg_922_1.time_ < var_925_2 + var_925_3 + arg_925_0 and not isNil(var_925_1) and arg_922_1.var_.characterEffect1081ui_story then
				arg_922_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_925_5 = 0
			local var_925_6 = 0.675

			if var_925_5 < arg_922_1.time_ and arg_922_1.time_ <= var_925_5 + arg_925_0 then
				arg_922_1.talkMaxDuration = 0
				arg_922_1.dialogCg_.alpha = 1

				arg_922_1.dialog_:SetActive(true)
				SetActive(arg_922_1.leftNameGo_, true)

				local var_925_7 = arg_922_1:FormatText(StoryNameCfg[202].name)

				arg_922_1.leftNameTxt_.text = var_925_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_922_1.leftNameTxt_.transform)

				arg_922_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_922_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_922_1:RecordName(arg_922_1.leftNameTxt_.text)
				SetActive(arg_922_1.iconTrs_.gameObject, false)
				arg_922_1.callingController_:SetSelectedState("normal")

				local var_925_8 = arg_922_1:GetWordFromCfg(1108106221)
				local var_925_9 = arg_922_1:FormatText(var_925_8.content)

				arg_922_1.text_.text = var_925_9

				LuaForUtil.ClearLinePrefixSymbol(arg_922_1.text_)

				local var_925_10 = 27
				local var_925_11 = utf8.len(var_925_9)
				local var_925_12 = var_925_10 <= 0 and var_925_6 or var_925_6 * (var_925_11 / var_925_10)

				if var_925_12 > 0 and var_925_6 < var_925_12 then
					arg_922_1.talkMaxDuration = var_925_12

					if var_925_12 + var_925_5 > arg_922_1.duration_ then
						arg_922_1.duration_ = var_925_12 + var_925_5
					end
				end

				arg_922_1.text_.text = var_925_9
				arg_922_1.typewritter.percent = 0

				arg_922_1.typewritter:SetDirty()
				arg_922_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb") ~= 0 then
					local var_925_13 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb") / 1000

					if var_925_13 + var_925_5 > arg_922_1.duration_ then
						arg_922_1.duration_ = var_925_13 + var_925_5
					end

					if var_925_8.prefab_name ~= "" and arg_922_1.actors_[var_925_8.prefab_name] ~= nil then
						local var_925_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_922_1.actors_[var_925_8.prefab_name].transform, "story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")

						arg_922_1:RecordAudio("1108106221", var_925_14)
						arg_922_1:RecordAudio("1108106221", var_925_14)
					else
						arg_922_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")
					end

					arg_922_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106221", "story_v_side_new_1108106.awb")
				end

				arg_922_1:RecordContent(arg_922_1.text_.text)
			end

			local var_925_15 = math.max(var_925_6, arg_922_1.talkMaxDuration)

			if var_925_5 <= arg_922_1.time_ and arg_922_1.time_ < var_925_5 + var_925_15 then
				arg_922_1.typewritter.percent = (arg_922_1.time_ - var_925_5) / var_925_15

				arg_922_1.typewritter:SetDirty()
			end

			if arg_922_1.time_ >= var_925_5 + var_925_15 and arg_922_1.time_ < var_925_5 + var_925_15 + arg_925_0 then
				arg_922_1.typewritter.percent = 1

				arg_922_1.typewritter:SetDirty()
				arg_922_1:ShowNextGo(true)
			end
		end

		arg_922_1.nodeConfigList_ = {}

		arg_922_1:InitPlayNodeList()
	end,
	Play1108106222 = function(arg_926_0, arg_926_1)
		arg_926_1.time_ = 0
		arg_926_1.frameCnt_ = 0
		arg_926_1.state_ = "playing"
		arg_926_1.curTalkId_ = 1108106222
		arg_926_1.duration_ = 6.37

		SetActive(arg_926_1.tipsGo_, false)

		function arg_926_1.onSingleLineFinish_()
			arg_926_1.onSingleLineUpdate_ = nil
			arg_926_1.onSingleLineFinish_ = nil
			arg_926_1.state_ = "waiting"
		end

		function arg_926_1.playNext_(arg_928_0)
			if arg_928_0 == 1 then
				arg_926_0:Play1108106223(arg_926_1)
			end
		end

		function arg_926_1.onSingleLineUpdate_(arg_929_0)
			local var_929_0 = 0

			if var_929_0 < arg_926_1.time_ and arg_926_1.time_ <= var_929_0 + arg_929_0 then
				arg_926_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_929_1 = 0

			if var_929_1 < arg_926_1.time_ and arg_926_1.time_ <= var_929_1 + arg_929_0 then
				arg_926_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_929_2 = 0
			local var_929_3 = 1.05

			if var_929_2 < arg_926_1.time_ and arg_926_1.time_ <= var_929_2 + arg_929_0 then
				arg_926_1.talkMaxDuration = 0
				arg_926_1.dialogCg_.alpha = 1

				arg_926_1.dialog_:SetActive(true)
				SetActive(arg_926_1.leftNameGo_, true)

				local var_929_4 = arg_926_1:FormatText(StoryNameCfg[202].name)

				arg_926_1.leftNameTxt_.text = var_929_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_926_1.leftNameTxt_.transform)

				arg_926_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_926_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_926_1:RecordName(arg_926_1.leftNameTxt_.text)
				SetActive(arg_926_1.iconTrs_.gameObject, false)
				arg_926_1.callingController_:SetSelectedState("normal")

				local var_929_5 = arg_926_1:GetWordFromCfg(1108106222)
				local var_929_6 = arg_926_1:FormatText(var_929_5.content)

				arg_926_1.text_.text = var_929_6

				LuaForUtil.ClearLinePrefixSymbol(arg_926_1.text_)

				local var_929_7 = 42
				local var_929_8 = utf8.len(var_929_6)
				local var_929_9 = var_929_7 <= 0 and var_929_3 or var_929_3 * (var_929_8 / var_929_7)

				if var_929_9 > 0 and var_929_3 < var_929_9 then
					arg_926_1.talkMaxDuration = var_929_9

					if var_929_9 + var_929_2 > arg_926_1.duration_ then
						arg_926_1.duration_ = var_929_9 + var_929_2
					end
				end

				arg_926_1.text_.text = var_929_6
				arg_926_1.typewritter.percent = 0

				arg_926_1.typewritter:SetDirty()
				arg_926_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb") ~= 0 then
					local var_929_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb") / 1000

					if var_929_10 + var_929_2 > arg_926_1.duration_ then
						arg_926_1.duration_ = var_929_10 + var_929_2
					end

					if var_929_5.prefab_name ~= "" and arg_926_1.actors_[var_929_5.prefab_name] ~= nil then
						local var_929_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_926_1.actors_[var_929_5.prefab_name].transform, "story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")

						arg_926_1:RecordAudio("1108106222", var_929_11)
						arg_926_1:RecordAudio("1108106222", var_929_11)
					else
						arg_926_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")
					end

					arg_926_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106222", "story_v_side_new_1108106.awb")
				end

				arg_926_1:RecordContent(arg_926_1.text_.text)
			end

			local var_929_12 = math.max(var_929_3, arg_926_1.talkMaxDuration)

			if var_929_2 <= arg_926_1.time_ and arg_926_1.time_ < var_929_2 + var_929_12 then
				arg_926_1.typewritter.percent = (arg_926_1.time_ - var_929_2) / var_929_12

				arg_926_1.typewritter:SetDirty()
			end

			if arg_926_1.time_ >= var_929_2 + var_929_12 and arg_926_1.time_ < var_929_2 + var_929_12 + arg_929_0 then
				arg_926_1.typewritter.percent = 1

				arg_926_1.typewritter:SetDirty()
				arg_926_1:ShowNextGo(true)
			end
		end

		arg_926_1.nodeConfigList_ = {}

		arg_926_1:InitPlayNodeList()
	end,
	Play1108106223 = function(arg_930_0, arg_930_1)
		arg_930_1.time_ = 0
		arg_930_1.frameCnt_ = 0
		arg_930_1.state_ = "playing"
		arg_930_1.curTalkId_ = 1108106223
		arg_930_1.duration_ = 2

		SetActive(arg_930_1.tipsGo_, true)

		arg_930_1.tipsText_.text = StoryTipsCfg[108101].name

		function arg_930_1.onSingleLineFinish_()
			arg_930_1.onSingleLineUpdate_ = nil
			arg_930_1.onSingleLineFinish_ = nil
			arg_930_1.state_ = "waiting"

			SetActive(arg_930_1.choicesGo_, true)

			for iter_931_0, iter_931_1 in ipairs(arg_930_1.choices_) do
				local var_931_0 = iter_931_0 <= 2

				SetActive(iter_931_1.go, var_931_0)
			end

			arg_930_1.choices_[1].txt.text = arg_930_1:FormatText(StoryChoiceCfg[1004].name)
			arg_930_1.choices_[2].txt.text = arg_930_1:FormatText(StoryChoiceCfg[1005].name)
		end

		function arg_930_1.playNext_(arg_932_0)
			if arg_932_0 == 1 then
				arg_930_0:Play1108106224(arg_930_1)
			end

			if arg_932_0 == 2 then
				PlayerAction.UseStoryTrigger(1081014, 210810106, 1108106223, 2)
				arg_930_0:Play1108106224(arg_930_1)
			end

			arg_930_1:RecordChoiceLog(1108106223, 1004, 1005)
		end

		function arg_930_1.onSingleLineUpdate_(arg_933_0)
			local var_933_0 = 0

			if var_933_0 < arg_930_1.time_ and arg_930_1.time_ <= var_933_0 + arg_933_0 then
				arg_930_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_933_1 = 0

			if var_933_1 < arg_930_1.time_ and arg_930_1.time_ <= var_933_1 + arg_933_0 then
				arg_930_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_933_2 = arg_930_1.actors_["1081ui_story"]
			local var_933_3 = 0

			if var_933_3 < arg_930_1.time_ and arg_930_1.time_ <= var_933_3 + arg_933_0 and not isNil(var_933_2) and arg_930_1.var_.characterEffect1081ui_story == nil then
				arg_930_1.var_.characterEffect1081ui_story = var_933_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_933_4 = 0.200000002980232

			if var_933_3 <= arg_930_1.time_ and arg_930_1.time_ < var_933_3 + var_933_4 and not isNil(var_933_2) then
				local var_933_5 = (arg_930_1.time_ - var_933_3) / var_933_4

				if arg_930_1.var_.characterEffect1081ui_story and not isNil(var_933_2) then
					local var_933_6 = Mathf.Lerp(0, 0.5, var_933_5)

					arg_930_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_930_1.var_.characterEffect1081ui_story.fillRatio = var_933_6
				end
			end

			if arg_930_1.time_ >= var_933_3 + var_933_4 and arg_930_1.time_ < var_933_3 + var_933_4 + arg_933_0 and not isNil(var_933_2) and arg_930_1.var_.characterEffect1081ui_story then
				local var_933_7 = 0.5

				arg_930_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_930_1.var_.characterEffect1081ui_story.fillRatio = var_933_7
			end
		end

		arg_930_1.nodeConfigList_ = {}

		arg_930_1:InitPlayNodeList()
	end,
	Play1108106224 = function(arg_934_0, arg_934_1)
		arg_934_1.time_ = 0
		arg_934_1.frameCnt_ = 0
		arg_934_1.state_ = "playing"
		arg_934_1.curTalkId_ = 1108106224
		arg_934_1.duration_ = 2

		SetActive(arg_934_1.tipsGo_, false)

		function arg_934_1.onSingleLineFinish_()
			arg_934_1.onSingleLineUpdate_ = nil
			arg_934_1.onSingleLineFinish_ = nil
			arg_934_1.state_ = "waiting"
		end

		function arg_934_1.playNext_(arg_936_0)
			if arg_936_0 == 1 then
				arg_934_0:Play1108106225(arg_934_1)
			end
		end

		function arg_934_1.onSingleLineUpdate_(arg_937_0)
			local var_937_0 = "1081ui_story"

			if arg_934_1.actors_[var_937_0] == nil then
				local var_937_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_937_1) then
					local var_937_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_934_1.stage_.transform)

					var_937_2.name = var_937_0
					var_937_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_934_1.actors_[var_937_0] = var_937_2

					local var_937_3 = var_937_2:GetComponentInChildren(typeof(CharacterEffect))

					var_937_3.enabled = true

					local var_937_4 = GameObjectTools.GetOrAddComponent(var_937_2, typeof(DynamicBoneHelper))

					if var_937_4 then
						var_937_4:EnableDynamicBone(false)
					end

					arg_934_1:ShowWeapon(var_937_3.transform, false)

					arg_934_1.var_[var_937_0 .. "Animator"] = var_937_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_934_1.var_[var_937_0 .. "Animator"].applyRootMotion = true
					arg_934_1.var_[var_937_0 .. "LipSync"] = var_937_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_937_5 = 0

			if var_937_5 < arg_934_1.time_ and arg_934_1.time_ <= var_937_5 + arg_937_0 then
				arg_934_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_937_6 = arg_934_1.actors_["1081ui_story"]
			local var_937_7 = 0

			if var_937_7 < arg_934_1.time_ and arg_934_1.time_ <= var_937_7 + arg_937_0 and not isNil(var_937_6) and arg_934_1.var_.characterEffect1081ui_story == nil then
				arg_934_1.var_.characterEffect1081ui_story = var_937_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_937_8 = 0.200000002980232

			if var_937_7 <= arg_934_1.time_ and arg_934_1.time_ < var_937_7 + var_937_8 and not isNil(var_937_6) then
				local var_937_9 = (arg_934_1.time_ - var_937_7) / var_937_8

				if arg_934_1.var_.characterEffect1081ui_story and not isNil(var_937_6) then
					arg_934_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_934_1.time_ >= var_937_7 + var_937_8 and arg_934_1.time_ < var_937_7 + var_937_8 + arg_937_0 and not isNil(var_937_6) and arg_934_1.var_.characterEffect1081ui_story then
				arg_934_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_937_10 = 0
			local var_937_11 = 0.075

			if var_937_10 < arg_934_1.time_ and arg_934_1.time_ <= var_937_10 + arg_937_0 then
				arg_934_1.talkMaxDuration = 0
				arg_934_1.dialogCg_.alpha = 1

				arg_934_1.dialog_:SetActive(true)
				SetActive(arg_934_1.leftNameGo_, true)

				local var_937_12 = arg_934_1:FormatText(StoryNameCfg[202].name)

				arg_934_1.leftNameTxt_.text = var_937_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_934_1.leftNameTxt_.transform)

				arg_934_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_934_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_934_1:RecordName(arg_934_1.leftNameTxt_.text)
				SetActive(arg_934_1.iconTrs_.gameObject, false)
				arg_934_1.callingController_:SetSelectedState("normal")

				local var_937_13 = arg_934_1:GetWordFromCfg(1108106224)
				local var_937_14 = arg_934_1:FormatText(var_937_13.content)

				arg_934_1.text_.text = var_937_14

				LuaForUtil.ClearLinePrefixSymbol(arg_934_1.text_)

				local var_937_15 = 3
				local var_937_16 = utf8.len(var_937_14)
				local var_937_17 = var_937_15 <= 0 and var_937_11 or var_937_11 * (var_937_16 / var_937_15)

				if var_937_17 > 0 and var_937_11 < var_937_17 then
					arg_934_1.talkMaxDuration = var_937_17

					if var_937_17 + var_937_10 > arg_934_1.duration_ then
						arg_934_1.duration_ = var_937_17 + var_937_10
					end
				end

				arg_934_1.text_.text = var_937_14
				arg_934_1.typewritter.percent = 0

				arg_934_1.typewritter:SetDirty()
				arg_934_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb") ~= 0 then
					local var_937_18 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb") / 1000

					if var_937_18 + var_937_10 > arg_934_1.duration_ then
						arg_934_1.duration_ = var_937_18 + var_937_10
					end

					if var_937_13.prefab_name ~= "" and arg_934_1.actors_[var_937_13.prefab_name] ~= nil then
						local var_937_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_934_1.actors_[var_937_13.prefab_name].transform, "story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")

						arg_934_1:RecordAudio("1108106224", var_937_19)
						arg_934_1:RecordAudio("1108106224", var_937_19)
					else
						arg_934_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")
					end

					arg_934_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106224", "story_v_side_new_1108106.awb")
				end

				arg_934_1:RecordContent(arg_934_1.text_.text)
			end

			local var_937_20 = math.max(var_937_11, arg_934_1.talkMaxDuration)

			if var_937_10 <= arg_934_1.time_ and arg_934_1.time_ < var_937_10 + var_937_20 then
				arg_934_1.typewritter.percent = (arg_934_1.time_ - var_937_10) / var_937_20

				arg_934_1.typewritter:SetDirty()
			end

			if arg_934_1.time_ >= var_937_10 + var_937_20 and arg_934_1.time_ < var_937_10 + var_937_20 + arg_937_0 then
				arg_934_1.typewritter.percent = 1

				arg_934_1.typewritter:SetDirty()
				arg_934_1:ShowNextGo(true)
			end
		end

		arg_934_1.nodeConfigList_ = {}

		arg_934_1:InitPlayNodeList()
	end,
	Play1108106225 = function(arg_938_0, arg_938_1)
		arg_938_1.time_ = 0
		arg_938_1.frameCnt_ = 0
		arg_938_1.state_ = "playing"
		arg_938_1.curTalkId_ = 1108106225
		arg_938_1.duration_ = 5

		SetActive(arg_938_1.tipsGo_, false)

		function arg_938_1.onSingleLineFinish_()
			arg_938_1.onSingleLineUpdate_ = nil
			arg_938_1.onSingleLineFinish_ = nil
			arg_938_1.state_ = "waiting"
		end

		function arg_938_1.playNext_(arg_940_0)
			if arg_940_0 == 1 then
				arg_938_0:Play1108106226(arg_938_1)
			end
		end

		function arg_938_1.onSingleLineUpdate_(arg_941_0)
			local var_941_0 = arg_938_1.actors_["1081ui_story"].transform
			local var_941_1 = 0

			if var_941_1 < arg_938_1.time_ and arg_938_1.time_ <= var_941_1 + arg_941_0 then
				arg_938_1.var_.moveOldPos1081ui_story = var_941_0.localPosition
			end

			local var_941_2 = 0.001

			if var_941_1 <= arg_938_1.time_ and arg_938_1.time_ < var_941_1 + var_941_2 then
				local var_941_3 = (arg_938_1.time_ - var_941_1) / var_941_2
				local var_941_4 = Vector3.New(0, 100, 0)

				var_941_0.localPosition = Vector3.Lerp(arg_938_1.var_.moveOldPos1081ui_story, var_941_4, var_941_3)

				local var_941_5 = manager.ui.mainCamera.transform.position - var_941_0.position

				var_941_0.forward = Vector3.New(var_941_5.x, var_941_5.y, var_941_5.z)

				local var_941_6 = var_941_0.localEulerAngles

				var_941_6.z = 0
				var_941_6.x = 0
				var_941_0.localEulerAngles = var_941_6
			end

			if arg_938_1.time_ >= var_941_1 + var_941_2 and arg_938_1.time_ < var_941_1 + var_941_2 + arg_941_0 then
				var_941_0.localPosition = Vector3.New(0, 100, 0)

				local var_941_7 = manager.ui.mainCamera.transform.position - var_941_0.position

				var_941_0.forward = Vector3.New(var_941_7.x, var_941_7.y, var_941_7.z)

				local var_941_8 = var_941_0.localEulerAngles

				var_941_8.z = 0
				var_941_8.x = 0
				var_941_0.localEulerAngles = var_941_8
			end

			local var_941_9 = 0
			local var_941_10 = 0.825

			if var_941_9 < arg_938_1.time_ and arg_938_1.time_ <= var_941_9 + arg_941_0 then
				arg_938_1.talkMaxDuration = 0
				arg_938_1.dialogCg_.alpha = 1

				arg_938_1.dialog_:SetActive(true)
				SetActive(arg_938_1.leftNameGo_, false)

				arg_938_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_938_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_938_1:RecordName(arg_938_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_938_1.iconTrs_.gameObject, false)
				arg_938_1.callingController_:SetSelectedState("normal")

				local var_941_11 = arg_938_1:GetWordFromCfg(1108106225)
				local var_941_12 = arg_938_1:FormatText(var_941_11.content)

				arg_938_1.text_.text = var_941_12

				LuaForUtil.ClearLinePrefixSymbol(arg_938_1.text_)

				local var_941_13 = 33
				local var_941_14 = utf8.len(var_941_12)
				local var_941_15 = var_941_13 <= 0 and var_941_10 or var_941_10 * (var_941_14 / var_941_13)

				if var_941_15 > 0 and var_941_10 < var_941_15 then
					arg_938_1.talkMaxDuration = var_941_15

					if var_941_15 + var_941_9 > arg_938_1.duration_ then
						arg_938_1.duration_ = var_941_15 + var_941_9
					end
				end

				arg_938_1.text_.text = var_941_12
				arg_938_1.typewritter.percent = 0

				arg_938_1.typewritter:SetDirty()
				arg_938_1:ShowNextGo(false)
				arg_938_1:RecordContent(arg_938_1.text_.text)
			end

			local var_941_16 = math.max(var_941_10, arg_938_1.talkMaxDuration)

			if var_941_9 <= arg_938_1.time_ and arg_938_1.time_ < var_941_9 + var_941_16 then
				arg_938_1.typewritter.percent = (arg_938_1.time_ - var_941_9) / var_941_16

				arg_938_1.typewritter:SetDirty()
			end

			if arg_938_1.time_ >= var_941_9 + var_941_16 and arg_938_1.time_ < var_941_9 + var_941_16 + arg_941_0 then
				arg_938_1.typewritter.percent = 1

				arg_938_1.typewritter:SetDirty()
				arg_938_1:ShowNextGo(true)
			end
		end

		arg_938_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_938_1:InitPlayNodeList()
	end,
	Play1108106226 = function(arg_942_0, arg_942_1)
		arg_942_1.time_ = 0
		arg_942_1.frameCnt_ = 0
		arg_942_1.state_ = "playing"
		arg_942_1.curTalkId_ = 1108106226
		arg_942_1.duration_ = 5

		SetActive(arg_942_1.tipsGo_, false)

		function arg_942_1.onSingleLineFinish_()
			arg_942_1.onSingleLineUpdate_ = nil
			arg_942_1.onSingleLineFinish_ = nil
			arg_942_1.state_ = "waiting"
		end

		function arg_942_1.playNext_(arg_944_0)
			if arg_944_0 == 1 then
				arg_942_0:Play1108106227(arg_942_1)
			end
		end

		function arg_942_1.onSingleLineUpdate_(arg_945_0)
			local var_945_0 = 0
			local var_945_1 = 0.8

			if var_945_0 < arg_942_1.time_ and arg_942_1.time_ <= var_945_0 + arg_945_0 then
				arg_942_1.talkMaxDuration = 0
				arg_942_1.dialogCg_.alpha = 1

				arg_942_1.dialog_:SetActive(true)
				SetActive(arg_942_1.leftNameGo_, false)

				arg_942_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_942_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_942_1:RecordName(arg_942_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_942_1.iconTrs_.gameObject, false)
				arg_942_1.callingController_:SetSelectedState("normal")

				local var_945_2 = arg_942_1:GetWordFromCfg(1108106226)
				local var_945_3 = arg_942_1:FormatText(var_945_2.content)

				arg_942_1.text_.text = var_945_3

				LuaForUtil.ClearLinePrefixSymbol(arg_942_1.text_)

				local var_945_4 = 32
				local var_945_5 = utf8.len(var_945_3)
				local var_945_6 = var_945_4 <= 0 and var_945_1 or var_945_1 * (var_945_5 / var_945_4)

				if var_945_6 > 0 and var_945_1 < var_945_6 then
					arg_942_1.talkMaxDuration = var_945_6

					if var_945_6 + var_945_0 > arg_942_1.duration_ then
						arg_942_1.duration_ = var_945_6 + var_945_0
					end
				end

				arg_942_1.text_.text = var_945_3
				arg_942_1.typewritter.percent = 0

				arg_942_1.typewritter:SetDirty()
				arg_942_1:ShowNextGo(false)
				arg_942_1:RecordContent(arg_942_1.text_.text)
			end

			local var_945_7 = math.max(var_945_1, arg_942_1.talkMaxDuration)

			if var_945_0 <= arg_942_1.time_ and arg_942_1.time_ < var_945_0 + var_945_7 then
				arg_942_1.typewritter.percent = (arg_942_1.time_ - var_945_0) / var_945_7

				arg_942_1.typewritter:SetDirty()
			end

			if arg_942_1.time_ >= var_945_0 + var_945_7 and arg_942_1.time_ < var_945_0 + var_945_7 + arg_945_0 then
				arg_942_1.typewritter.percent = 1

				arg_942_1.typewritter:SetDirty()
				arg_942_1:ShowNextGo(true)
			end
		end

		arg_942_1.nodeConfigList_ = {}

		arg_942_1:InitPlayNodeList()
	end,
	Play1108106227 = function(arg_946_0, arg_946_1)
		arg_946_1.time_ = 0
		arg_946_1.frameCnt_ = 0
		arg_946_1.state_ = "playing"
		arg_946_1.curTalkId_ = 1108106227
		arg_946_1.duration_ = 5

		SetActive(arg_946_1.tipsGo_, false)

		function arg_946_1.onSingleLineFinish_()
			arg_946_1.onSingleLineUpdate_ = nil
			arg_946_1.onSingleLineFinish_ = nil
			arg_946_1.state_ = "waiting"
		end

		function arg_946_1.playNext_(arg_948_0)
			if arg_948_0 == 1 then
				arg_946_0:Play1108106228(arg_946_1)
			end
		end

		function arg_946_1.onSingleLineUpdate_(arg_949_0)
			local var_949_0 = 0
			local var_949_1 = 1.35

			if var_949_0 < arg_946_1.time_ and arg_946_1.time_ <= var_949_0 + arg_949_0 then
				arg_946_1.talkMaxDuration = 0
				arg_946_1.dialogCg_.alpha = 1

				arg_946_1.dialog_:SetActive(true)
				SetActive(arg_946_1.leftNameGo_, false)

				arg_946_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_946_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_946_1:RecordName(arg_946_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_946_1.iconTrs_.gameObject, false)
				arg_946_1.callingController_:SetSelectedState("normal")

				local var_949_2 = arg_946_1:GetWordFromCfg(1108106227)
				local var_949_3 = arg_946_1:FormatText(var_949_2.content)

				arg_946_1.text_.text = var_949_3

				LuaForUtil.ClearLinePrefixSymbol(arg_946_1.text_)

				local var_949_4 = 54
				local var_949_5 = utf8.len(var_949_3)
				local var_949_6 = var_949_4 <= 0 and var_949_1 or var_949_1 * (var_949_5 / var_949_4)

				if var_949_6 > 0 and var_949_1 < var_949_6 then
					arg_946_1.talkMaxDuration = var_949_6

					if var_949_6 + var_949_0 > arg_946_1.duration_ then
						arg_946_1.duration_ = var_949_6 + var_949_0
					end
				end

				arg_946_1.text_.text = var_949_3
				arg_946_1.typewritter.percent = 0

				arg_946_1.typewritter:SetDirty()
				arg_946_1:ShowNextGo(false)
				arg_946_1:RecordContent(arg_946_1.text_.text)
			end

			local var_949_7 = math.max(var_949_1, arg_946_1.talkMaxDuration)

			if var_949_0 <= arg_946_1.time_ and arg_946_1.time_ < var_949_0 + var_949_7 then
				arg_946_1.typewritter.percent = (arg_946_1.time_ - var_949_0) / var_949_7

				arg_946_1.typewritter:SetDirty()
			end

			if arg_946_1.time_ >= var_949_0 + var_949_7 and arg_946_1.time_ < var_949_0 + var_949_7 + arg_949_0 then
				arg_946_1.typewritter.percent = 1

				arg_946_1.typewritter:SetDirty()
				arg_946_1:ShowNextGo(true)
			end
		end

		arg_946_1.nodeConfigList_ = {}

		arg_946_1:InitPlayNodeList()
	end,
	Play1108106228 = function(arg_950_0, arg_950_1)
		arg_950_1.time_ = 0
		arg_950_1.frameCnt_ = 0
		arg_950_1.state_ = "playing"
		arg_950_1.curTalkId_ = 1108106228
		arg_950_1.duration_ = 4.27

		SetActive(arg_950_1.tipsGo_, false)

		function arg_950_1.onSingleLineFinish_()
			arg_950_1.onSingleLineUpdate_ = nil
			arg_950_1.onSingleLineFinish_ = nil
			arg_950_1.state_ = "waiting"
		end

		function arg_950_1.playNext_(arg_952_0)
			if arg_952_0 == 1 then
				arg_950_0:Play1108106229(arg_950_1)
			end
		end

		function arg_950_1.onSingleLineUpdate_(arg_953_0)
			local var_953_0 = arg_950_1.actors_["1081ui_story"].transform
			local var_953_1 = 0

			if var_953_1 < arg_950_1.time_ and arg_950_1.time_ <= var_953_1 + arg_953_0 then
				arg_950_1.var_.moveOldPos1081ui_story = var_953_0.localPosition
			end

			local var_953_2 = 0.001

			if var_953_1 <= arg_950_1.time_ and arg_950_1.time_ < var_953_1 + var_953_2 then
				local var_953_3 = (arg_950_1.time_ - var_953_1) / var_953_2
				local var_953_4 = Vector3.New(0, -0.92, -5.8)

				var_953_0.localPosition = Vector3.Lerp(arg_950_1.var_.moveOldPos1081ui_story, var_953_4, var_953_3)

				local var_953_5 = manager.ui.mainCamera.transform.position - var_953_0.position

				var_953_0.forward = Vector3.New(var_953_5.x, var_953_5.y, var_953_5.z)

				local var_953_6 = var_953_0.localEulerAngles

				var_953_6.z = 0
				var_953_6.x = 0
				var_953_0.localEulerAngles = var_953_6
			end

			if arg_950_1.time_ >= var_953_1 + var_953_2 and arg_950_1.time_ < var_953_1 + var_953_2 + arg_953_0 then
				var_953_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_953_7 = manager.ui.mainCamera.transform.position - var_953_0.position

				var_953_0.forward = Vector3.New(var_953_7.x, var_953_7.y, var_953_7.z)

				local var_953_8 = var_953_0.localEulerAngles

				var_953_8.z = 0
				var_953_8.x = 0
				var_953_0.localEulerAngles = var_953_8
			end

			local var_953_9 = arg_950_1.actors_["1081ui_story"]
			local var_953_10 = 0

			if var_953_10 < arg_950_1.time_ and arg_950_1.time_ <= var_953_10 + arg_953_0 and not isNil(var_953_9) and arg_950_1.var_.characterEffect1081ui_story == nil then
				arg_950_1.var_.characterEffect1081ui_story = var_953_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_953_11 = 0.200000002980232

			if var_953_10 <= arg_950_1.time_ and arg_950_1.time_ < var_953_10 + var_953_11 and not isNil(var_953_9) then
				local var_953_12 = (arg_950_1.time_ - var_953_10) / var_953_11

				if arg_950_1.var_.characterEffect1081ui_story and not isNil(var_953_9) then
					arg_950_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_950_1.time_ >= var_953_10 + var_953_11 and arg_950_1.time_ < var_953_10 + var_953_11 + arg_953_0 and not isNil(var_953_9) and arg_950_1.var_.characterEffect1081ui_story then
				arg_950_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_953_13 = 0

			if var_953_13 < arg_950_1.time_ and arg_950_1.time_ <= var_953_13 + arg_953_0 then
				arg_950_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_953_14 = 0

			if var_953_14 < arg_950_1.time_ and arg_950_1.time_ <= var_953_14 + arg_953_0 then
				arg_950_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_953_15 = 0
			local var_953_16 = 0.7

			if var_953_15 < arg_950_1.time_ and arg_950_1.time_ <= var_953_15 + arg_953_0 then
				arg_950_1.talkMaxDuration = 0
				arg_950_1.dialogCg_.alpha = 1

				arg_950_1.dialog_:SetActive(true)
				SetActive(arg_950_1.leftNameGo_, true)

				local var_953_17 = arg_950_1:FormatText(StoryNameCfg[202].name)

				arg_950_1.leftNameTxt_.text = var_953_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_950_1.leftNameTxt_.transform)

				arg_950_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_950_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_950_1:RecordName(arg_950_1.leftNameTxt_.text)
				SetActive(arg_950_1.iconTrs_.gameObject, false)
				arg_950_1.callingController_:SetSelectedState("normal")

				local var_953_18 = arg_950_1:GetWordFromCfg(1108106228)
				local var_953_19 = arg_950_1:FormatText(var_953_18.content)

				arg_950_1.text_.text = var_953_19

				LuaForUtil.ClearLinePrefixSymbol(arg_950_1.text_)

				local var_953_20 = 28
				local var_953_21 = utf8.len(var_953_19)
				local var_953_22 = var_953_20 <= 0 and var_953_16 or var_953_16 * (var_953_21 / var_953_20)

				if var_953_22 > 0 and var_953_16 < var_953_22 then
					arg_950_1.talkMaxDuration = var_953_22

					if var_953_22 + var_953_15 > arg_950_1.duration_ then
						arg_950_1.duration_ = var_953_22 + var_953_15
					end
				end

				arg_950_1.text_.text = var_953_19
				arg_950_1.typewritter.percent = 0

				arg_950_1.typewritter:SetDirty()
				arg_950_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb") ~= 0 then
					local var_953_23 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb") / 1000

					if var_953_23 + var_953_15 > arg_950_1.duration_ then
						arg_950_1.duration_ = var_953_23 + var_953_15
					end

					if var_953_18.prefab_name ~= "" and arg_950_1.actors_[var_953_18.prefab_name] ~= nil then
						local var_953_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_950_1.actors_[var_953_18.prefab_name].transform, "story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")

						arg_950_1:RecordAudio("1108106228", var_953_24)
						arg_950_1:RecordAudio("1108106228", var_953_24)
					else
						arg_950_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")
					end

					arg_950_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106228", "story_v_side_new_1108106.awb")
				end

				arg_950_1:RecordContent(arg_950_1.text_.text)
			end

			local var_953_25 = math.max(var_953_16, arg_950_1.talkMaxDuration)

			if var_953_15 <= arg_950_1.time_ and arg_950_1.time_ < var_953_15 + var_953_25 then
				arg_950_1.typewritter.percent = (arg_950_1.time_ - var_953_15) / var_953_25

				arg_950_1.typewritter:SetDirty()
			end

			if arg_950_1.time_ >= var_953_15 + var_953_25 and arg_950_1.time_ < var_953_15 + var_953_25 + arg_953_0 then
				arg_950_1.typewritter.percent = 1

				arg_950_1.typewritter:SetDirty()
				arg_950_1:ShowNextGo(true)
			end
		end

		arg_950_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_950_1:InitPlayNodeList()
	end,
	Play1108106229 = function(arg_954_0, arg_954_1)
		arg_954_1.time_ = 0
		arg_954_1.frameCnt_ = 0
		arg_954_1.state_ = "playing"
		arg_954_1.curTalkId_ = 1108106229
		arg_954_1.duration_ = 4.03

		SetActive(arg_954_1.tipsGo_, false)

		function arg_954_1.onSingleLineFinish_()
			arg_954_1.onSingleLineUpdate_ = nil
			arg_954_1.onSingleLineFinish_ = nil
			arg_954_1.state_ = "waiting"
		end

		function arg_954_1.playNext_(arg_956_0)
			if arg_956_0 == 1 then
				arg_954_0:Play1108106230(arg_954_1)
			end
		end

		function arg_954_1.onSingleLineUpdate_(arg_957_0)
			local var_957_0 = 0

			if var_957_0 < arg_954_1.time_ and arg_954_1.time_ <= var_957_0 + arg_957_0 then
				arg_954_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_957_1 = 0

			if var_957_1 < arg_954_1.time_ and arg_954_1.time_ <= var_957_1 + arg_957_0 then
				arg_954_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_957_2 = 0
			local var_957_3 = 0.525

			if var_957_2 < arg_954_1.time_ and arg_954_1.time_ <= var_957_2 + arg_957_0 then
				arg_954_1.talkMaxDuration = 0
				arg_954_1.dialogCg_.alpha = 1

				arg_954_1.dialog_:SetActive(true)
				SetActive(arg_954_1.leftNameGo_, true)

				local var_957_4 = arg_954_1:FormatText(StoryNameCfg[202].name)

				arg_954_1.leftNameTxt_.text = var_957_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_954_1.leftNameTxt_.transform)

				arg_954_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_954_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_954_1:RecordName(arg_954_1.leftNameTxt_.text)
				SetActive(arg_954_1.iconTrs_.gameObject, false)
				arg_954_1.callingController_:SetSelectedState("normal")

				local var_957_5 = arg_954_1:GetWordFromCfg(1108106229)
				local var_957_6 = arg_954_1:FormatText(var_957_5.content)

				arg_954_1.text_.text = var_957_6

				LuaForUtil.ClearLinePrefixSymbol(arg_954_1.text_)

				local var_957_7 = 21
				local var_957_8 = utf8.len(var_957_6)
				local var_957_9 = var_957_7 <= 0 and var_957_3 or var_957_3 * (var_957_8 / var_957_7)

				if var_957_9 > 0 and var_957_3 < var_957_9 then
					arg_954_1.talkMaxDuration = var_957_9

					if var_957_9 + var_957_2 > arg_954_1.duration_ then
						arg_954_1.duration_ = var_957_9 + var_957_2
					end
				end

				arg_954_1.text_.text = var_957_6
				arg_954_1.typewritter.percent = 0

				arg_954_1.typewritter:SetDirty()
				arg_954_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb") ~= 0 then
					local var_957_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb") / 1000

					if var_957_10 + var_957_2 > arg_954_1.duration_ then
						arg_954_1.duration_ = var_957_10 + var_957_2
					end

					if var_957_5.prefab_name ~= "" and arg_954_1.actors_[var_957_5.prefab_name] ~= nil then
						local var_957_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_954_1.actors_[var_957_5.prefab_name].transform, "story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")

						arg_954_1:RecordAudio("1108106229", var_957_11)
						arg_954_1:RecordAudio("1108106229", var_957_11)
					else
						arg_954_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")
					end

					arg_954_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106229", "story_v_side_new_1108106.awb")
				end

				arg_954_1:RecordContent(arg_954_1.text_.text)
			end

			local var_957_12 = math.max(var_957_3, arg_954_1.talkMaxDuration)

			if var_957_2 <= arg_954_1.time_ and arg_954_1.time_ < var_957_2 + var_957_12 then
				arg_954_1.typewritter.percent = (arg_954_1.time_ - var_957_2) / var_957_12

				arg_954_1.typewritter:SetDirty()
			end

			if arg_954_1.time_ >= var_957_2 + var_957_12 and arg_954_1.time_ < var_957_2 + var_957_12 + arg_957_0 then
				arg_954_1.typewritter.percent = 1

				arg_954_1.typewritter:SetDirty()
				arg_954_1:ShowNextGo(true)
			end
		end

		arg_954_1.nodeConfigList_ = {}

		arg_954_1:InitPlayNodeList()
	end,
	Play1108106230 = function(arg_958_0, arg_958_1)
		arg_958_1.time_ = 0
		arg_958_1.frameCnt_ = 0
		arg_958_1.state_ = "playing"
		arg_958_1.curTalkId_ = 1108106230
		arg_958_1.duration_ = 4.03

		SetActive(arg_958_1.tipsGo_, false)

		function arg_958_1.onSingleLineFinish_()
			arg_958_1.onSingleLineUpdate_ = nil
			arg_958_1.onSingleLineFinish_ = nil
			arg_958_1.state_ = "waiting"
		end

		function arg_958_1.playNext_(arg_960_0)
			if arg_960_0 == 1 then
				arg_958_0:Play1108106231(arg_958_1)
			end
		end

		function arg_958_1.onSingleLineUpdate_(arg_961_0)
			local var_961_0 = 0
			local var_961_1 = 0.475

			if var_961_0 < arg_958_1.time_ and arg_958_1.time_ <= var_961_0 + arg_961_0 then
				arg_958_1.talkMaxDuration = 0
				arg_958_1.dialogCg_.alpha = 1

				arg_958_1.dialog_:SetActive(true)
				SetActive(arg_958_1.leftNameGo_, true)

				local var_961_2 = arg_958_1:FormatText(StoryNameCfg[202].name)

				arg_958_1.leftNameTxt_.text = var_961_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_958_1.leftNameTxt_.transform)

				arg_958_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_958_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_958_1:RecordName(arg_958_1.leftNameTxt_.text)
				SetActive(arg_958_1.iconTrs_.gameObject, false)
				arg_958_1.callingController_:SetSelectedState("normal")

				local var_961_3 = arg_958_1:GetWordFromCfg(1108106230)
				local var_961_4 = arg_958_1:FormatText(var_961_3.content)

				arg_958_1.text_.text = var_961_4

				LuaForUtil.ClearLinePrefixSymbol(arg_958_1.text_)

				local var_961_5 = 19
				local var_961_6 = utf8.len(var_961_4)
				local var_961_7 = var_961_5 <= 0 and var_961_1 or var_961_1 * (var_961_6 / var_961_5)

				if var_961_7 > 0 and var_961_1 < var_961_7 then
					arg_958_1.talkMaxDuration = var_961_7

					if var_961_7 + var_961_0 > arg_958_1.duration_ then
						arg_958_1.duration_ = var_961_7 + var_961_0
					end
				end

				arg_958_1.text_.text = var_961_4
				arg_958_1.typewritter.percent = 0

				arg_958_1.typewritter:SetDirty()
				arg_958_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb") ~= 0 then
					local var_961_8 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb") / 1000

					if var_961_8 + var_961_0 > arg_958_1.duration_ then
						arg_958_1.duration_ = var_961_8 + var_961_0
					end

					if var_961_3.prefab_name ~= "" and arg_958_1.actors_[var_961_3.prefab_name] ~= nil then
						local var_961_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_958_1.actors_[var_961_3.prefab_name].transform, "story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")

						arg_958_1:RecordAudio("1108106230", var_961_9)
						arg_958_1:RecordAudio("1108106230", var_961_9)
					else
						arg_958_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")
					end

					arg_958_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106230", "story_v_side_new_1108106.awb")
				end

				arg_958_1:RecordContent(arg_958_1.text_.text)
			end

			local var_961_10 = math.max(var_961_1, arg_958_1.talkMaxDuration)

			if var_961_0 <= arg_958_1.time_ and arg_958_1.time_ < var_961_0 + var_961_10 then
				arg_958_1.typewritter.percent = (arg_958_1.time_ - var_961_0) / var_961_10

				arg_958_1.typewritter:SetDirty()
			end

			if arg_958_1.time_ >= var_961_0 + var_961_10 and arg_958_1.time_ < var_961_0 + var_961_10 + arg_961_0 then
				arg_958_1.typewritter.percent = 1

				arg_958_1.typewritter:SetDirty()
				arg_958_1:ShowNextGo(true)
			end
		end

		arg_958_1.nodeConfigList_ = {}

		arg_958_1:InitPlayNodeList()
	end,
	Play1108106231 = function(arg_962_0, arg_962_1)
		arg_962_1.time_ = 0
		arg_962_1.frameCnt_ = 0
		arg_962_1.state_ = "playing"
		arg_962_1.curTalkId_ = 1108106231
		arg_962_1.duration_ = 3.6

		SetActive(arg_962_1.tipsGo_, false)

		function arg_962_1.onSingleLineFinish_()
			arg_962_1.onSingleLineUpdate_ = nil
			arg_962_1.onSingleLineFinish_ = nil
			arg_962_1.state_ = "waiting"
			arg_962_1.auto_ = false
		end

		function arg_962_1.playNext_(arg_964_0)
			arg_962_1.onStoryFinished_()
		end

		function arg_962_1.onSingleLineUpdate_(arg_965_0)
			local var_965_0 = 0

			if var_965_0 < arg_962_1.time_ and arg_962_1.time_ <= var_965_0 + arg_965_0 then
				arg_962_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			local var_965_1 = 0

			if var_965_1 < arg_962_1.time_ and arg_962_1.time_ <= var_965_1 + arg_965_0 then
				arg_962_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_965_2 = 0
			local var_965_3 = 0.275

			if var_965_2 < arg_962_1.time_ and arg_962_1.time_ <= var_965_2 + arg_965_0 then
				arg_962_1.talkMaxDuration = 0
				arg_962_1.dialogCg_.alpha = 1

				arg_962_1.dialog_:SetActive(true)
				SetActive(arg_962_1.leftNameGo_, true)

				local var_965_4 = arg_962_1:FormatText(StoryNameCfg[202].name)

				arg_962_1.leftNameTxt_.text = var_965_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_962_1.leftNameTxt_.transform)

				arg_962_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_962_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_962_1:RecordName(arg_962_1.leftNameTxt_.text)
				SetActive(arg_962_1.iconTrs_.gameObject, false)
				arg_962_1.callingController_:SetSelectedState("normal")

				local var_965_5 = arg_962_1:GetWordFromCfg(1108106231)
				local var_965_6 = arg_962_1:FormatText(var_965_5.content)

				arg_962_1.text_.text = var_965_6

				LuaForUtil.ClearLinePrefixSymbol(arg_962_1.text_)

				local var_965_7 = 11
				local var_965_8 = utf8.len(var_965_6)
				local var_965_9 = var_965_7 <= 0 and var_965_3 or var_965_3 * (var_965_8 / var_965_7)

				if var_965_9 > 0 and var_965_3 < var_965_9 then
					arg_962_1.talkMaxDuration = var_965_9

					if var_965_9 + var_965_2 > arg_962_1.duration_ then
						arg_962_1.duration_ = var_965_9 + var_965_2
					end
				end

				arg_962_1.text_.text = var_965_6
				arg_962_1.typewritter.percent = 0

				arg_962_1.typewritter:SetDirty()
				arg_962_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb") ~= 0 then
					local var_965_10 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb") / 1000

					if var_965_10 + var_965_2 > arg_962_1.duration_ then
						arg_962_1.duration_ = var_965_10 + var_965_2
					end

					if var_965_5.prefab_name ~= "" and arg_962_1.actors_[var_965_5.prefab_name] ~= nil then
						local var_965_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_962_1.actors_[var_965_5.prefab_name].transform, "story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")

						arg_962_1:RecordAudio("1108106231", var_965_11)
						arg_962_1:RecordAudio("1108106231", var_965_11)
					else
						arg_962_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")
					end

					arg_962_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106231", "story_v_side_new_1108106.awb")
				end

				arg_962_1:RecordContent(arg_962_1.text_.text)
			end

			local var_965_12 = math.max(var_965_3, arg_962_1.talkMaxDuration)

			if var_965_2 <= arg_962_1.time_ and arg_962_1.time_ < var_965_2 + var_965_12 then
				arg_962_1.typewritter.percent = (arg_962_1.time_ - var_965_2) / var_965_12

				arg_962_1.typewritter:SetDirty()
			end

			if arg_962_1.time_ >= var_965_2 + var_965_12 and arg_962_1.time_ < var_965_2 + var_965_12 + arg_965_0 then
				arg_962_1.typewritter.percent = 1

				arg_962_1.typewritter:SetDirty()
				arg_962_1:ShowNextGo(true)
			end
		end

		arg_962_1.nodeConfigList_ = {}

		arg_962_1:InitPlayNodeList()
	end,
	Play1108106218 = function(arg_966_0, arg_966_1)
		arg_966_1.time_ = 0
		arg_966_1.frameCnt_ = 0
		arg_966_1.state_ = "playing"
		arg_966_1.curTalkId_ = 1108106218
		arg_966_1.duration_ = 2.67

		SetActive(arg_966_1.tipsGo_, false)

		function arg_966_1.onSingleLineFinish_()
			arg_966_1.onSingleLineUpdate_ = nil
			arg_966_1.onSingleLineFinish_ = nil
			arg_966_1.state_ = "waiting"
		end

		function arg_966_1.playNext_(arg_968_0)
			if arg_968_0 == 1 then
				arg_966_0:Play1108106219(arg_966_1)
			end
		end

		function arg_966_1.onSingleLineUpdate_(arg_969_0)
			local var_969_0 = "1081ui_story"

			if arg_966_1.actors_[var_969_0] == nil then
				local var_969_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_969_1) then
					local var_969_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_966_1.stage_.transform)

					var_969_2.name = var_969_0
					var_969_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_966_1.actors_[var_969_0] = var_969_2

					local var_969_3 = var_969_2:GetComponentInChildren(typeof(CharacterEffect))

					var_969_3.enabled = true

					local var_969_4 = GameObjectTools.GetOrAddComponent(var_969_2, typeof(DynamicBoneHelper))

					if var_969_4 then
						var_969_4:EnableDynamicBone(false)
					end

					arg_966_1:ShowWeapon(var_969_3.transform, false)

					arg_966_1.var_[var_969_0 .. "Animator"] = var_969_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_966_1.var_[var_969_0 .. "Animator"].applyRootMotion = true
					arg_966_1.var_[var_969_0 .. "LipSync"] = var_969_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_969_5 = 0

			if var_969_5 < arg_966_1.time_ and arg_966_1.time_ <= var_969_5 + arg_969_0 then
				arg_966_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action6_2")
			end

			local var_969_6 = "1081ui_story"

			if arg_966_1.actors_[var_969_6] == nil then
				local var_969_7 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_969_7) then
					local var_969_8 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_966_1.stage_.transform)

					var_969_8.name = var_969_6
					var_969_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_966_1.actors_[var_969_6] = var_969_8

					local var_969_9 = var_969_8:GetComponentInChildren(typeof(CharacterEffect))

					var_969_9.enabled = true

					local var_969_10 = GameObjectTools.GetOrAddComponent(var_969_8, typeof(DynamicBoneHelper))

					if var_969_10 then
						var_969_10:EnableDynamicBone(false)
					end

					arg_966_1:ShowWeapon(var_969_9.transform, false)

					arg_966_1.var_[var_969_6 .. "Animator"] = var_969_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_966_1.var_[var_969_6 .. "Animator"].applyRootMotion = true
					arg_966_1.var_[var_969_6 .. "LipSync"] = var_969_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_969_11 = 0

			if var_969_11 < arg_966_1.time_ and arg_966_1.time_ <= var_969_11 + arg_969_0 then
				arg_966_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_969_12 = arg_966_1.actors_["1081ui_story"]
			local var_969_13 = 0

			if var_969_13 < arg_966_1.time_ and arg_966_1.time_ <= var_969_13 + arg_969_0 and not isNil(var_969_12) and arg_966_1.var_.characterEffect1081ui_story == nil then
				arg_966_1.var_.characterEffect1081ui_story = var_969_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_969_14 = 0.200000002980232

			if var_969_13 <= arg_966_1.time_ and arg_966_1.time_ < var_969_13 + var_969_14 and not isNil(var_969_12) then
				local var_969_15 = (arg_966_1.time_ - var_969_13) / var_969_14

				if arg_966_1.var_.characterEffect1081ui_story and not isNil(var_969_12) then
					arg_966_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_966_1.time_ >= var_969_13 + var_969_14 and arg_966_1.time_ < var_969_13 + var_969_14 + arg_969_0 and not isNil(var_969_12) and arg_966_1.var_.characterEffect1081ui_story then
				arg_966_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_969_16 = 0
			local var_969_17 = 0.225

			if var_969_16 < arg_966_1.time_ and arg_966_1.time_ <= var_969_16 + arg_969_0 then
				arg_966_1.talkMaxDuration = 0
				arg_966_1.dialogCg_.alpha = 1

				arg_966_1.dialog_:SetActive(true)
				SetActive(arg_966_1.leftNameGo_, true)

				local var_969_18 = arg_966_1:FormatText(StoryNameCfg[202].name)

				arg_966_1.leftNameTxt_.text = var_969_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_966_1.leftNameTxt_.transform)

				arg_966_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_966_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_966_1:RecordName(arg_966_1.leftNameTxt_.text)
				SetActive(arg_966_1.iconTrs_.gameObject, false)
				arg_966_1.callingController_:SetSelectedState("normal")

				local var_969_19 = arg_966_1:GetWordFromCfg(1108106218)
				local var_969_20 = arg_966_1:FormatText(var_969_19.content)

				arg_966_1.text_.text = var_969_20

				LuaForUtil.ClearLinePrefixSymbol(arg_966_1.text_)

				local var_969_21 = 9
				local var_969_22 = utf8.len(var_969_20)
				local var_969_23 = var_969_21 <= 0 and var_969_17 or var_969_17 * (var_969_22 / var_969_21)

				if var_969_23 > 0 and var_969_17 < var_969_23 then
					arg_966_1.talkMaxDuration = var_969_23

					if var_969_23 + var_969_16 > arg_966_1.duration_ then
						arg_966_1.duration_ = var_969_23 + var_969_16
					end
				end

				arg_966_1.text_.text = var_969_20
				arg_966_1.typewritter.percent = 0

				arg_966_1.typewritter:SetDirty()
				arg_966_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb") ~= 0 then
					local var_969_24 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb") / 1000

					if var_969_24 + var_969_16 > arg_966_1.duration_ then
						arg_966_1.duration_ = var_969_24 + var_969_16
					end

					if var_969_19.prefab_name ~= "" and arg_966_1.actors_[var_969_19.prefab_name] ~= nil then
						local var_969_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_966_1.actors_[var_969_19.prefab_name].transform, "story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")

						arg_966_1:RecordAudio("1108106218", var_969_25)
						arg_966_1:RecordAudio("1108106218", var_969_25)
					else
						arg_966_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")
					end

					arg_966_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106218", "story_v_side_new_1108106.awb")
				end

				arg_966_1:RecordContent(arg_966_1.text_.text)
			end

			local var_969_26 = math.max(var_969_17, arg_966_1.talkMaxDuration)

			if var_969_16 <= arg_966_1.time_ and arg_966_1.time_ < var_969_16 + var_969_26 then
				arg_966_1.typewritter.percent = (arg_966_1.time_ - var_969_16) / var_969_26

				arg_966_1.typewritter:SetDirty()
			end

			if arg_966_1.time_ >= var_969_16 + var_969_26 and arg_966_1.time_ < var_969_16 + var_969_26 + arg_969_0 then
				arg_966_1.typewritter.percent = 1

				arg_966_1.typewritter:SetDirty()
				arg_966_1:ShowNextGo(true)
			end
		end

		arg_966_1.nodeConfigList_ = {}

		arg_966_1:InitPlayNodeList()
	end,
	Play1108106009 = function(arg_970_0, arg_970_1)
		arg_970_1.time_ = 0
		arg_970_1.frameCnt_ = 0
		arg_970_1.state_ = "playing"
		arg_970_1.curTalkId_ = 1108106009
		arg_970_1.duration_ = 6.93

		SetActive(arg_970_1.tipsGo_, false)

		function arg_970_1.onSingleLineFinish_()
			arg_970_1.onSingleLineUpdate_ = nil
			arg_970_1.onSingleLineFinish_ = nil
			arg_970_1.state_ = "waiting"
		end

		function arg_970_1.playNext_(arg_972_0)
			if arg_972_0 == 1 then
				arg_970_0:Play1108106010(arg_970_1)
			end
		end

		function arg_970_1.onSingleLineUpdate_(arg_973_0)
			local var_973_0 = "1081ui_story"

			if arg_970_1.actors_[var_973_0] == nil then
				local var_973_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_973_1) then
					local var_973_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_970_1.stage_.transform)

					var_973_2.name = var_973_0
					var_973_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_970_1.actors_[var_973_0] = var_973_2

					local var_973_3 = var_973_2:GetComponentInChildren(typeof(CharacterEffect))

					var_973_3.enabled = true

					local var_973_4 = GameObjectTools.GetOrAddComponent(var_973_2, typeof(DynamicBoneHelper))

					if var_973_4 then
						var_973_4:EnableDynamicBone(false)
					end

					arg_970_1:ShowWeapon(var_973_3.transform, false)

					arg_970_1.var_[var_973_0 .. "Animator"] = var_973_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_970_1.var_[var_973_0 .. "Animator"].applyRootMotion = true
					arg_970_1.var_[var_973_0 .. "LipSync"] = var_973_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_973_5 = 0

			if var_973_5 < arg_970_1.time_ and arg_970_1.time_ <= var_973_5 + arg_973_0 then
				arg_970_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_973_6 = arg_970_1.actors_["1081ui_story"]
			local var_973_7 = 0

			if var_973_7 < arg_970_1.time_ and arg_970_1.time_ <= var_973_7 + arg_973_0 and not isNil(var_973_6) and arg_970_1.var_.characterEffect1081ui_story == nil then
				arg_970_1.var_.characterEffect1081ui_story = var_973_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_973_8 = 0.2

			if var_973_7 <= arg_970_1.time_ and arg_970_1.time_ < var_973_7 + var_973_8 and not isNil(var_973_6) then
				local var_973_9 = (arg_970_1.time_ - var_973_7) / var_973_8

				if arg_970_1.var_.characterEffect1081ui_story and not isNil(var_973_6) then
					arg_970_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_970_1.time_ >= var_973_7 + var_973_8 and arg_970_1.time_ < var_973_7 + var_973_8 + arg_973_0 and not isNil(var_973_6) and arg_970_1.var_.characterEffect1081ui_story then
				arg_970_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_973_10 = 0
			local var_973_11 = 0.625

			if var_973_10 < arg_970_1.time_ and arg_970_1.time_ <= var_973_10 + arg_973_0 then
				arg_970_1.talkMaxDuration = 0
				arg_970_1.dialogCg_.alpha = 1

				arg_970_1.dialog_:SetActive(true)
				SetActive(arg_970_1.leftNameGo_, true)

				local var_973_12 = arg_970_1:FormatText(StoryNameCfg[202].name)

				arg_970_1.leftNameTxt_.text = var_973_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_970_1.leftNameTxt_.transform)

				arg_970_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_970_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_970_1:RecordName(arg_970_1.leftNameTxt_.text)
				SetActive(arg_970_1.iconTrs_.gameObject, false)
				arg_970_1.callingController_:SetSelectedState("normal")

				local var_973_13 = arg_970_1:GetWordFromCfg(1108106009)
				local var_973_14 = arg_970_1:FormatText(var_973_13.content)

				arg_970_1.text_.text = var_973_14

				LuaForUtil.ClearLinePrefixSymbol(arg_970_1.text_)

				local var_973_15 = 25
				local var_973_16 = utf8.len(var_973_14)
				local var_973_17 = var_973_15 <= 0 and var_973_11 or var_973_11 * (var_973_16 / var_973_15)

				if var_973_17 > 0 and var_973_11 < var_973_17 then
					arg_970_1.talkMaxDuration = var_973_17

					if var_973_17 + var_973_10 > arg_970_1.duration_ then
						arg_970_1.duration_ = var_973_17 + var_973_10
					end
				end

				arg_970_1.text_.text = var_973_14
				arg_970_1.typewritter.percent = 0

				arg_970_1.typewritter:SetDirty()
				arg_970_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb") ~= 0 then
					local var_973_18 = manager.audio:GetVoiceLength("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb") / 1000

					if var_973_18 + var_973_10 > arg_970_1.duration_ then
						arg_970_1.duration_ = var_973_18 + var_973_10
					end

					if var_973_13.prefab_name ~= "" and arg_970_1.actors_[var_973_13.prefab_name] ~= nil then
						local var_973_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_970_1.actors_[var_973_13.prefab_name].transform, "story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")

						arg_970_1:RecordAudio("1108106009", var_973_19)
						arg_970_1:RecordAudio("1108106009", var_973_19)
					else
						arg_970_1:AudioAction("play", "voice", "story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")
					end

					arg_970_1:RecordHistoryTalkVoice("story_v_side_new_1108106", "1108106009", "story_v_side_new_1108106.awb")
				end

				arg_970_1:RecordContent(arg_970_1.text_.text)
			end

			local var_973_20 = math.max(var_973_11, arg_970_1.talkMaxDuration)

			if var_973_10 <= arg_970_1.time_ and arg_970_1.time_ < var_973_10 + var_973_20 then
				arg_970_1.typewritter.percent = (arg_970_1.time_ - var_973_10) / var_973_20

				arg_970_1.typewritter:SetDirty()
			end

			if arg_970_1.time_ >= var_973_10 + var_973_20 and arg_970_1.time_ < var_973_10 + var_973_20 + arg_973_0 then
				arg_970_1.typewritter.percent = 1

				arg_970_1.typewritter:SetDirty()
				arg_970_1:ShowNextGo(true)
			end
		end

		arg_970_1.nodeConfigList_ = {}

		arg_970_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0402a",
		"TextureConfig/Background/ST0401",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/H01b",
		"TextureConfig/Background/R8102a",
		"TextureConfig/Background/R8102",
		"TextureConfig/Background/R8102b",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST07b"
	},
	voices = {
		"story_v_side_new_1108106.awb"
	}
}
